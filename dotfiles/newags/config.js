#!/usr/bin/env -S ags -c

// GObject libraries
const { Gtk, Gdk, Gio } = imports.gi;

// Services
const Applications = await Service.import("applications");
const Battery = await Service.import("battery");
//const Hyprland = await Service.import("hyprland");

// Modules
import { bar } from "./modules/bar/bar.js";
import { panel1 } from "./modules/panels/panel-1/panel.js";
import { panel2 } from "./modules/panels/panel-2/panel.js";
import { launcher } from "./modules/launcher.js";
import { notificationPopups } from "./modules/notification-popups.js";
import { screenshotPopup } from "./modules/screenshot-popup.js";
import { workspacePopup } from "./modules/workspaces-popup.js";
import { osdPopups } from "./modules/osd/osd-popups.js";

Battery.connect("notify::percent", () => {
  if (Battery.charged === true) {
    Utils.notify("Battery full", "You can unplug the cable");
  } else if (Battery.percent === 15 && Battery.charging === false) {
    Utils.notify("Battery low", "Plug the cable!");
  } else if (Battery.percent === 5 && Battery.charging === false) {
    Utils.notify("Battery exhausted", "Shutdown imminent");
  }
});

function sass(input, output) {
  if (!output) return Utils.exec(`sass -q ${input}`);

  Utils.exec(`sass -q --no-source-map ${input} ${output}`);
}

Utils.monitorFile(`${App.configDir}/scss`, () => {
  App.resetCss();
  App.applyCss(sass(`${App.configDir}/scss/main.scss`));
});

Utils.monitorFile("/usr/share/applications", () => Applications.reload());

Utils.monitorFile("/home/bunbun/.config/background", (file, event) => {
  if (event === Gio.FileMonitorEvent.CHANGES_DONE_HINT) {
    Utils.exec(`swww img ${file.get_path()}`);
  }
});

App.addIcons(`${App.configDir}/assets/icons`);
App.addIcons(`${App.configDir}/assets/icons/icon-dev-kit`);

App.config({
  style: sass(`${App.configDir}/scss/main.scss`),
  iconTheme: "MoreWaita",
  closeWindowDelay: {
    "panel-1": 125,
    "panel-2": 125,
    launcher: 125,
    "screenshot-popup": 125,
    "workspace-popup": 250,
  },
  windows: [
    bar(),
    panel1,
    panel2,
    launcher,
    notificationPopups,
    screenshotPopup,
    workspacePopup,
    (() => {
      return Widget.Window({
        name: "background",
        anchor: ["top", "right", "bottom", "left"],
        exclusivity: "ignore",
        layer: "background",
        setup: (self) => {
          self.drag_dest_set(Gtk.DestDefaults.ALL, [], Gdk.DragAction.COPY);
          self.drag_dest_add_uri_targets();

          self.on(
            "drag-data-received",
            (self, context, x, y, data, info, time) =>
              Utils.exec(
                `swww img --transition-type grow --transition-pos ${x},${y} ${data
                  .get_uris()[0]
                  .replace("file://", "")}`,
              ),
          );
        },
      });
    })(),
    /*
    (() => {
      const desktopMenu = Widget.Menu({
        className: "desktop-menu",
        children: [
          Widget.MenuItem({
            label: "New",
            onActivate: () =>
              Utils.exec(
                `${GLib.get_home_dir()}/.config/hypr/scripts/open_window ${Utils.exec(
                  "slurp -b '#00000000' -c '#454545' -w 2",
                )} alacritty`,
              ),
          }),
          Widget.MenuItem({
            label: "Resize",
            onActivate: () =>
              Utils.exec(
                `${GLib.get_home_dir()}/.config/hypr/scripts/move_window ${Utils.exec(
                  "slurp -b '#00000000' -c '#454545' -w 2",
                )}`,
              ),
          }),
          Widget.MenuItem({
            label: "Move",
            onActivate: () => Hyprland.message("dispatch submap move"),
          }),
          Widget.MenuItem({
            label: "Delete",
            onActivate: () => Utils.exec("hyprctl kill"),
          }),
        ],
      });
      return Widget.Window({
        name: "desktop",
        anchor: ["top", "right", "bottom", "left"],
        layer: "bottom",
        child: Widget.EventBox({
          onSecondaryClick: (_, event) => desktopMenu.popup_at_pointer(event),
        }),
      });
    })(),
    */
  ],
});
