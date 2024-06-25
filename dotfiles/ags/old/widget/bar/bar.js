import * as barLib from "./barlib.js";

function left() {
  return Widget.Box({
    children: [barLib.Clock()],
    spacing: 8,
  });
}

function center() {
  return Widget.Box({
    children: [barLib.Workspaces()],
    spacing: 8,
  });
}

function right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [
      barLib.Volume(),
      barLib.BatteryLabel(),
      barLib.bright(),
      barLib.menuinit(),
    ],
  });
}

export function bar(monitor) {
  return Widget.Window({
    monitor,
    exclusivity: "exclusive",
    class_name: "bar",
    name: `bar-${monitor}`, // this name has to be unique
    anchor: ["top", "left", "right"],
    child: Widget.CenterBox({
      start_widget: left(),
      center_widget: center(),
      end_widget: right(),
    }),
  });
}
