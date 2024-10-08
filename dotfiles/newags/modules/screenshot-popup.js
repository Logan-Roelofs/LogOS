// Widgets
import PopupWindow from "../custom/widgets/popupWindow.js";

export const screenshotPopup = PopupWindow({
  name: "screenshot-popup",
  anchor: ["top"],
  transition: "slide_down",
  transitionDuration: 125,
  child: Widget.Box({
    className: "screenshot-popup",
    vertical: true,
    children: [
      Widget.Label({
        hpack: "start",
        label: "Screenshot",
      }),
      Widget.Box({
        children: [
          Widget.Button({
            onClicked: () => {
              App.toggleWindow("screenshot-popup");
              Utils.timeout(125, () =>
                Utils.execAsync(`${App.configDir}/scripts/ss`),
              );
            },
            child: Widget.Icon({
              icon: "video-display-symbolic", // display-symbolic is not symbolic for some reason
            }),
          }),
          Widget.Button({
            onClicked: () => {
              App.toggleWindow("screenshot-popup");
              Utils.timeout(125, () =>
                Utils.execAsync(`${App.configDir}/scripts/ss_active`),
              );
            },
            child: Widget.Icon({
              icon: "window-symbolic",
            }),
          }),
          Widget.Button({
            onClicked: () => {
              App.toggleWindow("screenshot-popup");
              Utils.timeout(125, () =>
                Utils.execAsync(
                  `${App.configDir}/scripts/ss_area ${Utils.exec("slurp")}`,
                ),
              );
            },
            child: Widget.Icon({
              icon: "selection-symbolic",
            }),
          }),
        ],
      }),
    ],
  }),
});
