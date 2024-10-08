// GObject libraries
imports.gi.versions.Granite = "1.0";
const { cairo, Gtk, Gdk, GdkPixbuf, Granite } = imports.gi;

// Services (sort alphabetically)
const Mpris = await Service.import("mpris");

const player = (p) => {
  const cover = Widget.Box({
    className: "cover",
    css: p
      .bind("cover_path")
      .as((cover) => `background-image: url("${cover}");`),
  });

  const title = Widget.Label({
    className: "title",
    label: p.bind("track_title") || "Unknown",
    xalign: 0,
    justification: "left",
    truncate: "end",
    maxWidthChars: 24,
  });

  const artists = Widget.Label({
    className: "artists",
    label: p
      .bind("track_artists")
      .as((artists) => artists.join(", ") || "Unknown"),
    xalign: 0,
    justification: "left",
    truncate: "end",
    maxWidthChars: 24,
  });

  const controls = Widget.Box({
    hpack: "end",
    vpack: "center",
    hexpand: true,
    vexpand: false,
    children: [
      Widget.Button({
        className: p.bind("can_go_prev").as((canGo) => `${canGo ? "" : "off"}`),
        onClicked: () => p.previous(),
        child: Widget.Icon({
          icon: "media-skip-backward-symbolic",
        }),
      }),
      Widget.Button({
        onClicked: () => p.playPause(),
        child: Widget.Icon({
          icon: p
            .bind("play_back_status")
            .as(
              (status) =>
                `media-playback-${status == "Playing" ? "pause" : "start"}-symbolic`,
            ),
        }),
      }),
      Widget.Button({
        className: p.bind("can_go_next").as((canGo) => `${canGo ? "" : "off"}`),
        onClicked: () => p.next(),
        child: Widget.Icon({
          icon: "media-skip-forward-symbolic",
        }),
      }),
    ],
  });

  return Widget.Box({
    className: "media",
    children: [
      cover,
      Widget.Box({
        children: [
          Widget.Box({
            vertical: true,
            hpack: "start",
            vpack: "center",
            children: [title, artists],
          }),
          controls,
        ],
      }),
    ],
    setup: (self) => {
      self.on("draw", (_, cr) => {
        if (p.cover_path) self.css = "background: none;";

        const styleContext = self.get_style_context();
        const margin = styleContext.get_margin(Gtk.StateFlags.NORMAL);
        const border = styleContext.get_border(Gtk.StateFlags.NORMAL);
        const borderRadius = styleContext.get_property(
          "border-radius",
          Gtk.StateFlags.NORMAL,
        );
        const width = self.get_allocated_width();
        const height =
          self.get_allocated_height() - (margin.bottom - border.bottom);

        Granite.DrawingUtilities.cairo_rounded_rectangle(
          cr,
          0,
          0,
          width,
          height,
          borderRadius,
        );
        cr.clip();

        cr.save();
        cr.setSourceRGB(0, 0, 0);
        cr.rectangle(0, 0, width, height);
        cr.fill();
        cr.restore();

        cr.save();
        const pixbuf = GdkPixbuf.Pixbuf.new_from_file(p.cover_path);
        const surface = Gdk.cairo_surface_create_from_pixbuf(pixbuf, 0, null);
        const buffer = Granite.DrawingBufferSurface.with_surface(
          width,
          height,
          surface,
        );

        buffer.context.setSourceSurface(surface, 0, -pixbuf.get_height() / 2);
        buffer.context.paintWithAlpha(0.5);
        buffer.fast_blur(12, 6);

        cr.setSourceSurface(buffer.surface, 0, 0);
        cr.paint();
        cr.restore();
      });

      self.hook(p, () => self.queue_draw(), "notify::cover-path");
    },
  });
};

const playersStack = Widget.Stack({
  transition: "slide_up_down",
  transitionDuration: 125,
  children: {},
  setup: (self) => {
    self.add_events(Gdk.EventMask.SCROLL_MASK);
    self.add_events(Gdk.EventMask.SMOOTH_SCROLL_MASK);

    let currentDeltaY = 0;

    self.on("scroll-event", (_, event) => {
      const childNames = Object.keys(self.children);

      const prevChild =
        childNames[childNames.indexOf(self.get_visible_child_name()) - 1];
      const nextChild =
        childNames[childNames.indexOf(self.get_visible_child_name()) + 1];

      const deltaY = event.get_scroll_deltas()[2];

      currentDeltaY += deltaY;

      if (currentDeltaY > 10 && prevChild) {
        self.set_visible_child_name(prevChild);
        currentDeltaY = 0;
      }
      if (currentDeltaY < -10 && nextChild) {
        self.set_visible_child_name(nextChild);
        currentDeltaY = 0;
      }
    });

    self.hook(
      Mpris,
      (_, name) => {
        if (!name) return;

        self.add_named(player(Mpris.getPlayer(name)), name);
      },
      "player-added",
    );
    self.hook(
      Mpris,
      (_, name) => {
        if (!name) return;

        self.get_child_by_name(name).destroy();
      },
      "player-closed",
    );
  },
});

export const media = Widget.Revealer({
  revealChild: Mpris.bind("players").as((players) => players.length > 0),
  transition: "slide_up",
  transitionDuration: 125,
  child: playersStack,
});
