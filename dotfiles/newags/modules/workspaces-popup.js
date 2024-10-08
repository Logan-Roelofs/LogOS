// GObject libraries
const { GLib } = imports.gi;

// Widgets
import PopupWindow from "../custom/widgets/popupWindow.js";

// Services (sort alphabetically)
let Hyprland;
if (GLib.getenv("XDG_CURRENT_DESKTOP") === "Hyprland") {
  Hyprland = await Service.import("hyprland");
}

export const workspacePopup = PopupWindow({
  name: "workspace-popup",
  anchor: [],
  exclusivity: "ignore",
  layer: "overlay",
  transition: "crossfade",
  transitionDuration: 250,
  child: Widget.Box({
    className: "workspace-popup",
    children: [],
    setup: (self) => {
      if (Hyprland) {
        for (let i = 1; i <= 10; i++) {
          const workspace = Widget.Box({
            className: Hyprland.active
              .bind("workspace")
              .as((active) => `${active.id === i ? "active" : ""}`),
            visible: Hyprland.bind("workspaces").as((workspaces) =>
              workspaces.some((ws) => ws.id === i),
            ),
          });

          self.children = [...self.children, workspace];
        }
      }
    },
  }),
  setup: (self) => {
    if (Hyprland) {
      let i = 0;

      self.hook(
        Hyprland.active,
        () => {
          App.openWindow("workspace-popup");
          i++;
          Utils.timeout(1000, () => {
            i--;

            if (i === 0) App.closeWindow("workspace-popup");
          });
        },
        "notify::workspace",
      );
    }
  },
});
