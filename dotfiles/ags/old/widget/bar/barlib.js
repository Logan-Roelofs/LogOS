import * as menu from "../menu/menu.js";
const hyprland = await Service.import("hyprland");
const audio = await Service.import("audio");
const battery = await Service.import("battery");
import brightness from "./service/brightness.js";

export function bright() {
  return Widget.Slider({
    on_change: (self) => (brightness.screen_value = self.value),
    value: brightness.bind("screen-value"),
  });

  const label = Label({
    label: brightness.bind("screen-value").as((v) => `${v}`),
    setup: (self) =>
      self.hook(
        brightness,
        (self, screenValue) => {
          // screenValue is the passed parameter from the 'screen-changed' signal
          self.label = screenValue ?? 0;

          // NOTE:
          // since hooks are run upon construction
          // the passed screenValue will be undefined the first time

          // all three are valid
          self.label = `${brightness.screenValue}`;
          self.label = `${brightness.screen_value}`;
          self.label = `${brightness["screen-value"]}`;
        },
        "screen-changed",
      ),
  });
}

export function Clock() {
  const date = Variable("", {
    poll: [1000, 'date "+%H:%M:%S %b %e."'],
  });
  return Widget.Label({
    class_name: "clock",
    label: date.bind(),
  });
}

export function calendar() {
  return Widget.Calendar({
    class_name: "calendar",
    showDayNames: true,
    showDetails: true,
    showHeading: true,
    showWeekNumbers: true,
    detail: (self, y, m, d) => {
      return `<span color="white">${y}. ${m}. ${d}.</span>`;
    },
    onDaySelected: ({ date: [y, m, d] }) => {
      print(`${y}. ${m}. ${d}.`);
    },
  });
}

export function revealer() {
  return Widget.Revealer({
    revealChild: false,
    transitionDuration: 1000,
    transition: "slide_right",
    child: Widget.Label("revealer!"),
    setup: (self) =>
      self.poll(2000, () => {
        self.reveal_child = !self.reveal_child;
      }),
  });
}

export function menuinit() {
  return Widget.Button({
    on_primary_click: (_, event) => App.addWindow(menu.menu(1)),
    //child: App.addWindow(menu.menu(1)),
    //on_secondary_click: (_, event) => App.toggleWindow("menu"),
    //onClicked: () => App.toggleWindow("menu"),
  });
}

export function RightClickMenu() {
  const menu = Widget.Menu({
    children: [
      Widget.MenuItem({
        child: Widget.Label("MenuItem"),
      }),
      Widget.MenuItem({
        child: Widget.Label("MenuItem"),
      }),
    ],
  });

  return Widget.Button({
    on_primary_click: (_, event) => {
      menu.popup_at_pointer(event);
    },
  });
}

export function BatteryLabel() {
  const value = battery.bind("percent").as((p) => (p > 0 ? p / 100 : 0));
  const icon = battery
    .bind("percent")
    .as((p) => `battery-level-${Math.floor(p / 10) * 10}-symbolic`);

  return Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    children: [
      Widget.Icon({ icon }),
      Widget.LevelBar({
        widthRequest: 140,
        vpack: "center",
        value,
      }),
    ],
  });
}

export function Workspaces() {
  const activeId = hyprland.active.workspace.bind("id");
  const workspaces = hyprland.bind("workspaces").as((ws) =>
    ws.map(({ id }) =>
      Widget.Button({
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        child: Widget.Label(`${id}`),
        class_name: activeId.as((i) => `${i === id ? "focused" : ""}`),
      }),
    ),
  );

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
}

export function Volume() {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  };

  function getIcon() {
    const icon = audio.speaker.is_muted
      ? 0
      : [101, 67, 34, 1, 0].find(
          (threshold) => threshold <= audio.speaker.volume * 100,
        );

    return `audio-volume-${icons[icon]}-symbolic`;
  }

  const icon = Widget.Icon({
    icon: Utils.watch(getIcon(), audio.speaker, getIcon),
  });

  const slider = Widget.Slider({
    hexpand: true,
    draw_value: false,
    on_change: ({ value }) => (audio.speaker.volume = value),
    setup: (self) =>
      self.hook(audio.speaker, () => {
        self.value = audio.speaker.volume || 0;
      }),
  });

  return Widget.Box({
    class_name: "volume",
    css: "min-width: 180px",
    children: [icon, slider],
  });
}
