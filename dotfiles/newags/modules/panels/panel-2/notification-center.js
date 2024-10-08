// GObject libraries
const { Pango } = imports.gi;

// Services (sort alphabetically)
const Notifications = await Service.import("notifications");

const notification = (n) =>
  Widget.Revealer({
    attribute: { id: n.id },
    transition: "slide_down",
    transitionDuration: 125,
    setup: (self) => Utils.timeout(1, () => self.set_reveal_child(true)),
    child: Widget.EventBox({
      onPrimaryClick: () => n.close(),
      child: Widget.Box({
        className: `notification ${n.urgency}`,
        vertical: true,
        children: [
          Widget.Label({
            className: "title",
            label: n.summary,
            xalign: 0,
            justification: "left",
            truncate: "end",
            maxWidthChars: 36,
          }),
          Widget.Separator(),
          Widget.Label({
            className: "body",
            label: n.body,
            xalign: 0,
            justification: "left",
            maxWidthChars: 36,
            wrap: true,
            wrapMode: Pango.WrapMode.WORD_CHAR,
            useMarkup: true,
          }),
        ],
      }),
    }),
  });

export const notificationCenter = Widget.Box({
  className: "notification-center",
  vertical: true,
  children: [
    Widget.Box({
      className: "header",
      children: [
        Widget.Label({
          hexpand: true,
          hpack: "start",
          label: "Notifications",
        }),
        Widget.Button({
          hpack: "end",
          onClicked: () => Notifications.clear(),
          onHover: (self) => self.child.children[0].set_reveal_child(true),
          onHoverLost: (self) => self.child.children[0].set_reveal_child(false),
          child: Widget.Label("Clear"),
          /*
          child: Widget.Box({
            children: [
              Widget.Revealer({
                transition: "slide_left",
                transitionDuration: 125,
                child: Widget.Label("Clear"),
              }),
              Widget.Icon({
                icon: "user-trash-symbolic",
              }),
            ],
          }),
          */
        }),
      ],
    }),
    Widget.Separator(),
    Widget.Scrollable({
      hscroll: "never",
      vexpand: true,
      child: Widget.Box({
        vertical: true,
        children: Notifications.notifications.map((n) => notification(n)),
        setup: (self) =>
          self
            .hook(
              Notifications,
              (_, id) => {
                const n = Notifications.getNotification(id);

                if (!n) return;

                self.children = [...self.children, notification(n)];
              },
              "notified",
            )
            .hook(
              Notifications,
              (_, id) => {
                const n = self.children.find(
                  (child) => child.attribute.id === id,
                );

                if (!n) return;

                n.set_reveal_child(false);

                Utils.timeout(n.transition_duration, () => n.destroy());
              },
              "closed",
            ),
      }),
    }),
  ],
});
