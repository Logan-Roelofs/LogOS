import * as barLib from "./menulib.js";

function center() {
  return Widget.Box({
    children: [barLib.BatteryLabel(), barLib.Volume(), barLib.blutooth()],
    spacing: 10,
    vertical: true,
  });
}

export function menu(monitor) {
  return Widget.Window({
    monitor: 1,
    exclusivity: "exclusive",
    class_name: "menu",
    name: `menu`, // this name has to be unique
    anchor: ["top", "right"],
    child: Widget.CenterBox({
      center_widget: center(),
    }),
  });
}

export function menuinit() {
  App.addWindow(menu())
  
