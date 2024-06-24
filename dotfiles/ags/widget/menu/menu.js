import * as barLib from "./menulib.js";

function center() {
  return Widget.Box({
    children: [barLib.BatteryLabel(), barLib.Volume()],
    spacing: 8,
  });
}

export function menu(monitor) {
  return Widget.Window({
    monitor,
    exclusivity: "exclusive",
    class_name: "menu",
    name: `menu`, // this name has to be unique
    anchor: ["top", "right"],
    child: Widget.CenterBox({
      center_widget: center(),
    }),
  });
}
