import { bar } from "./widget/bar/bar.js";
import { menu } from "./widget/menu/menu.js";
import Gdk from "gi://Gdk";
//App.toggleWindow("menu-1");
// For each monitor, create a bar and a menu
function forMonitors() {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  const windowIds = Array.from({ length: n }, (_, i) => i + 0);
  windowIds.forEach((windowId) => {
    App.config({ window: bar(windowId) });
  });
}

forMonitors();
