/*
 * This is panel one, the main panel that has the "control panel" and media player contorl
 */

// GObject libraries
const { GLib, Gio } = imports.gi;

// Widgets
import PopupWindow from "../../../custom/widgets/popupWindow.js";

// Services (sort alphabetically)
const Audio = await Service.import("audio");
const Bluetooth = await Service.import("bluetooth");
const Network = await Service.import("network");
const Notifications = await Service.import("notifications");
import Brightness from "../../../custom/services/brightness.js";

// Modules
import { media } from "./media.js";

const wifiControl = () => {
  const connected = Network.wifi
    .bind("internet")
    .as((internet) => internet === "connected");
  return Widget.Button({
    className: connected.as((connected) => `wifi ${connected ? "" : "off"}`),
    hexpand: true,
    onClicked: () => Network.toggleWifi(),
    child: Widget.Box({
      children: [
        Widget.Icon({
          icon: Network.wifi.bind("icon_name"),
        }),
        Widget.Label({
          label: "Wi-Fi",
        }),
      ],
    }),
  });
};

const bluetoothControl = () => {
  const enabled = Bluetooth.bind("enabled");
  return Widget.Button({
    className: enabled.as((enabled) => `bluetooth ${enabled ? "" : "off"}`),
    hexpand: true,
    onClicked: () => Bluetooth.toggle(),
    child: Widget.Box({
      children: [
        Widget.Icon({
          icon: enabled.as(
            (enabled) =>
              `bluetooth-${enabled ? "active" : "disabled"}-symbolic`,
          ),
        }),
        Widget.Label({
          label: "Bluetooth",
        }),
      ],
    }),
  });
};

const microphoneSliderToggle = Variable(false);

const microphoneControl = () => {
  const muted = Audio.microphone.bind("is_muted");
  return Widget.Box({
    children: [
      Widget.Button({
        className: muted.as((muted) => `microphone ${!muted ? "" : "off"}`),
        hexpand: true,
        onClicked: () => {
          Audio.microphone.is_muted = !Audio.microphone.is_muted;
        },
        child: Widget.Box({
          children: [
            Widget.Icon({
              icon: Audio.microphone
                .bind("is_muted")
                .as(
                  (muted) =>
                    `microphone${!muted ? "2-" : "-disabled-"}symbolic`,
                ),
            }),
            Widget.Label({
              label: "Microphone",
            }),
          ],
        }),
      }),
      Widget.Button({
        hpack: "end",
        onClicked: () => {
          microphoneSliderToggle.value = !microphoneSliderToggle.value;
        },
        child: Widget.Icon({
          hpack: "end",
          css: microphoneSliderToggle
            .bind()
            .as(
              (toggled) =>
                `-gtk-icon-transform: ${toggled ? "rotate(-0.5turn)" : "none"
                };`,
            ),
          icon: "pan-down-symbolic",
        }),
      }),
    ],
  });
};

const microphoneSlider = Widget.Box({
  className: "microphone-slider",
  children: [
    Widget.Icon({
      setup: (self) =>
        self.hook(Audio, () => {
          const volume = Audio.microphone.volume * 100;
          const thresholds = [67, 34, 1, 0];
          self.icon = `microphone-sensitivity-${["high", "medium", "low", "muted"][
            Math.max(
              0,
              thresholds.findIndex((threshold) => volume >= threshold),
            )
            ]
            }-symbolic`;
        }),
    }),
    Widget.Slider({
      value: Audio.microphone.bind("volume"),
      drawValue: false,
      hexpand: true,
      onChange: ({ value }) => (Audio.microphone.volume = value),
    }),
  ],
});

const controls = Widget.Box({
  className: "controls",
  vertical: true,
  children: [
    Widget.Box({
      homogeneous: true,
      children: [wifiControl(), bluetoothControl()],
    }),
    Widget.Box({
      homogeneous: true,
      children: [
        (() => {
          const dnd = Notifications.bind("dnd");
          return Widget.Button({
            className: dnd.as((dnd) => `dnd ${dnd ? "" : "off"}`),
            hexpand: true,
            onClicked: () => {
              Notifications.dnd = !Notifications.dnd;
            },
            child: Widget.Box({
              children: [
                Widget.Icon({
                  icon: Notifications.bind("dnd").as(
                    (dnd) => `bell-outline${!dnd ? "-" : "-none-"}symbolic`,
                  ),
                }),
                Widget.Label({
                  label: "Do Not Disturb",
                }),
              ],
            }),
          });
        })(),
        microphoneControl(),
      ],
    }),
    /*
    (() => {
      const settings = new Gio.Settings({
        schema: "org.gnome.desktop.interface",
      });

      const colorScheme = Variable(
        settings.get_string("color-scheme").replace("prefer-", ""),
      );
      settings.connect("changed::color-scheme", (_, key) => {
        colorScheme.value = settings.get_string(key).replace("prefer-", "");
      });

      settings.get_string("color-scheme");

      return Widget.Button({
        className: colorScheme.bind(),
        hexpand: true,
        onClicked: () =>
          settings.set_string(
            "color-scheme",
            `prefer-${colorScheme.value === "light" ? "dark" : "light"}`,
          ),
        child: Widget.Box({
          children: [
            Widget.Icon({
              icon: "dark-mode-symbolic",
            }),
            Widget.Label({
              label: colorScheme
                .bind()
                .as(
                  (mode) =>
                    `${mode.replace(mode[0], mode[0].toUpperCase())} Mode`,
                ),
            }),
          ],
        }),
      });
    })(),
    */
    Widget.Revealer({
      className: "Revealer",
      revealChild: microphoneSliderToggle.bind(),
      transition: "slide_down",
      transitionDuration: 125,
      child: microphoneSlider,
    }),
  ],
});

const brightnessSlider = Widget.Box({
  children: [
    Widget.Icon({
      icon: "display-brightness-symbolic",
    }),
    Widget.Slider({
      value: Brightness.bind("screen"),
      drawValue: false,
      hexpand: true,
      onChange: ({ value }) => (Brightness.screen = value),
    }),
  ],
});

const brightnessControl = Widget.Box({
  className: "brightness",
  vertical: true,
  children: [
    Widget.Label({
      label: "Brightness",
      hpack: "start",
    }),
    brightnessSlider,
  ],
});

const volumeSlider = Widget.Box({
  children: [
    Widget.Icon({
      setup: (self) =>
        self.hook(Audio, () => {
          const volume = Audio.speaker.volume * 100;
          const thresholds = [101, 67, 34, 1, 0];
          self.icon = `audio-volume-${["overamplified", "high", "medium", "low", "muted"][
            Math.max(
              0,
              thresholds.findIndex((threshold) => volume >= threshold),
            )
            ]
            }-symbolic`;
        }),
    }),
    Widget.Slider({
      value: Audio.speaker.bind("volume"),
      drawValue: false,
      hexpand: true,
      onChange: ({ value }) => (Audio.speaker.volume = value),
    }),
  ],
});

const volumeControl = Widget.Box({
  className: "volume",
  vertical: true,
  children: [
    Widget.Label({
      label: "Volume",
      hpack: "start",
    }),
    volumeSlider,
  ],
});

export const panel1 = PopupWindow({
  name: "panel-1",
  anchor: ["bottom", "right"],
  transition: "slide_left",
  transitionDuration: 125,
  setup: (self) => self.on("show", () => App.closeWindow("panel-2")),
  child: Widget.Box({
    className: "panel-1",
    vertical: true,
    children: [
      media,
      Widget.Box({
        className: "controls",
        vertical: true,
        children: [
          Widget.Box({
            children: [
              Widget.Box({
                className: "pfp",
                css: `background-image: url("${GLib.get_home_dir()}/pfp.png");`,
              }),
              Widget.Label(`${GLib.get_user_name()}@${GLib.get_host_name()}`),
            ],
          }),
          controls,
          Widget.Separator(),
          brightnessControl,
          volumeControl,
        ],
      }),
    ],
  }),
});
