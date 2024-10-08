import { brightnessOsd } from "./brightness-osd.js";
import { volumeOsd } from "./volume-osd.js";

export const osdPopups = Widget.Window({
  name: "osd-popups",
  anchor: ["bottom"],
  exclusivity: "ignore",
  layer: "overlay",
  child: Widget.Box({
    vertical: true,
    widthRequest: 2,
    heightRequest: 2,
    children: [brightnessOsd, volumeOsd],
  }),
});
