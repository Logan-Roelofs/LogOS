// GObject libraries
const { Pango } = imports.gi;

// Services (sort alphabetically)
const Notifications = await Service.import("notifications");

const notification = (n) =>
  Widget.Revealer({
    attribute: { id: n.id },
    vpack: "end",
    transition: "slide_down",
    transitionDuration: 250,
    setup: (self) => {
      Utils.timeout(1, () => self.set_reveal_child(true));
      self.on("notify::reveal-child", () => {
        if (self.reveal_child)
          Utils.timeout(125, () => self.child.set_reveal_child(true));
      });
    },
    child: Widget.Revealer({
      hpack: "start",
      transition: "slide_right",
      transitionDuration: 250,
      setup: (self) =>
        self.on("notify::reveal-child", () => {
          if (!self.reveal_child)
            Utils.timeout(125, () => self.parent.set_reveal_child(false));
        }),
      child: Widget.EventBox({
        onPrimaryClick: () => n.dismiss(),
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
    }),
  });

export const notificationPopups = Widget.Window({
  name: "notification-popups",
  anchor: ["top", "left"],
  layer: "overlay",
  child: Widget.Box({
    className: "notification-popups",
    vertical: true,
    widthRequest: 2,
    heightRequest: 2,
    children: Notifications.popups.map(notification),
    setup: (self) =>
      self
        .hook(
          Notifications,
          (_, id) => {
            if (Notifications.dnd) return;

            const n = Notifications.getNotification(id);

            if (!n) return;

            self.children = [...self.children, notification(n)];
          },
          "notified",
        )
        .hook(
          Notifications,
          (_, id) => {
            const n = self.children.find((child) => child.attribute.id === id);

            if (!n) return;

            n.child.set_reveal_child(false);

            Utils.timeout(n.transition_duration, () => n.destroy());
          },
          "dismissed",
        ),
  }),
});
