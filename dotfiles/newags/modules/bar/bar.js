// Services (sort alphabetically);
const Battery = await Service.import("battery");
const Bluetooth = await Service.import("bluetooth");
const Network = await Service.import("network");

// Modules
import { clock } from "./clock.js";
import { tray } from "./tray.js";

const left = Widget.Box({
  className: "left",
  hpack: "start",
});

const center = Widget.Box();

const right = Widget.Box({
  className: "right",
  hpack: "end",
  children: [
    //tray,
    (() => {
      const connected = Network.wifi.bind("internet");
      return Widget.Icon({
        className: connected.as(
          (connected) => `wifi ${connected === "connected" ? "" : "off"}`,
        ),
        tooltipText: Network.wifi.bind("ssid"),
        icon: Network.wifi.bind("icon_name"),
      });
    })(),
    (() => {
      const enabled = Bluetooth.bind("enabled");
      return Widget.Icon({
        className: enabled.as((enabled) => `bluetooth ${enabled ? "" : "off"}`),
        icon: enabled.as(
          (enabled) => `bluetooth-${enabled ? "active" : "disabled"}-symbolic`,
        ),
      });
    })(),
    Widget.Icon({
      className: "battery",
      icon: Battery.bind("icon_name"),
      setup: (self) => {
        self.hook(Battery, () => {
          const hoursRemaining = Math.floor(Battery.time_remaining / 3600)
            .toString()
            .padStart(2, "0");

          const minutesRemaining = Math.floor(
            (Battery.time_remaining % 3600) / 60,
          )
            .toString()
            .padStart(2, "0");

          const secondsRemaining = Math.floor(Battery.time_remaining % 60);

          self.tooltip_text = `${hoursRemaining}:${minutesRemaining} ${Battery.charging ? "until full" : "remaining"
            }`;
        });
      },
    }),
    Widget.Separator({
      vertical: true,
    }),
    clock,
    Widget.Button({
      onClicked: () => App.toggleWindow("panel-1"),
      child: Widget.Icon({
        icon: "controls-symbolic",
      }),
    }),
  ],
});

export const bar = () =>
  Widget.Window({
    name: "bar",
    monitor: 1,
    anchor: ["bottom", "right", "left"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      className: "bar",
      startWidget: left,
      centerWidget: center,
      endWidget: right,
    }),
  });
