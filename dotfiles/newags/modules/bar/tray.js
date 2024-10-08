// Utils
import toSymbolic from "../../custom/utils/toSymbolic.js";

// Services (sort alphabetically)
const SystemTray = await Service.import("systemtray");

const systemTrayToggle = Variable(false);

const trayItem = (item, busName) =>
  Widget.Revealer({
    attribute: { busName: busName },
    transition: "slide_left",
    transitionDuration: 125,
    setup: (self) => Utils.timeout(1, () => self.set_reveal_child(true)),
    child: Widget.Button({
      onPrimaryClick: (_, event) => item.activate(event),
      tooltipMarkup: item.tooltipMarkup,
      child: Widget.Icon({
        icon: toSymbolic(item.icon),
      }),
    }),
  });

export const tray = Widget.Box({
  className: systemTrayToggle
    .bind()
    .as((toggled) => `tray ${toggled ? "toggled" : ""}`),
  children: [
    Widget.Button({
      onClicked: () => (systemTrayToggle.value = !systemTrayToggle.value),
      child: Widget.Icon({
        css: systemTrayToggle
          .bind()
          .as(
            (toggled) =>
              `-gtk-icon-transform: ${toggled ? "rotate(-0.5turn)" : "none"};`,
          ),
        icon: "left-symbolic",
      }),
    }),
    Widget.Revealer({
      revealChild: systemTrayToggle.bind(),
      transition: "slide_left",
      transitionDuration: 125,
      child: Widget.Box({
        children: SystemTray.items.map(trayItem),
        setup: (self) =>
          self
            .hook(
              SystemTray,
              (_, busName) => {
                const item = SystemTray.getItem(busName);

                if (!item) return;

                self.children = [...self.children, trayItem(item, busName)];
              },
              "added",
            )
            .hook(
              SystemTray,
              (_, busName) => {
                const item = self.children.find(
                  (child) => child.attribute.busName === busName,
                );

                if (!item) return;

                item.set_reveal_child(false);

                Utils.timeout(item.transition_duration, () => item.destroy());
              },
              "removed",
            ),
      }),
    }),
  ],
});
