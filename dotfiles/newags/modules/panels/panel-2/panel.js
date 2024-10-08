/*
 * This is panel two, the secondary panel that has a notification center and calendar, and maybe more later
 */

// GObject libraries
const { Gtk, Gdk } = imports.gi;

// Widgets
import PopupWindow from "../../../custom/widgets/popupWindow.js";

// Modules
import { notificationCenter } from "./notification-center.js";
import { calendar } from "./calendar.js";
import { systemMonitor } from "./system-monitor.js";
import { cava } from "./cava.js";

const infoHeaderTitle = Variable("Calendar");
const infoToggle = Variable(true);

export const panel2 = PopupWindow({
  name: "panel-2",
  anchor: ["top", "bottom", "right"],
  transition: "slide_left",
  transitionDuration: 125,
  setup: (self) => self.on("show", () => App.closeWindow("panel-1")),
  child: Widget.Box({
    className: "panel-2",
    vertical: true,
    children: [
      notificationCenter,
      Widget.Box({
        className: "info", // Rename this (maybe)
        vexpand: false,
        vertical: true,
        children: [
          Widget.Box({
            children: [
              Widget.Label({
                className: "header",
                hpack: "start",
                label: infoHeaderTitle.bind(),
              }),
              Widget.Box({
                hpack: "end",
                hexpand: true,
                child: Widget.Button({
                  onClicked: () => (infoToggle.value = !infoToggle.value),
                  child: Widget.Icon({
                    css: infoToggle
                      .bind()
                      .as(
                        (toggled) =>
                          `-gtk-icon-transform: ${toggled ? "rotate(-0.5turn)" : "none"
                          };`,
                      ),
                    icon: "pan-down-symbolic",
                  }),
                }),
              }),
            ],
          }),
          Widget.Revealer({
            revealChild: infoToggle.bind(),
            transition: "slide_up",
            transitionDuration: 125,
            child: Widget.Box({
              vertical: true,
              children: [
                Widget.Separator(),
                Widget.Stack({
                  transition: "slide_left_right",
                  transitionDuration: 125,
                  children: {
                    Calendar: calendar,
                    "System Monitor": systemMonitor,
                    Cava: cava,
                  },
                  setup: (self) => {
                    self.add_events(Gdk.EventMask.SCROLL_MASK);
                    self.add_events(Gdk.EventMask.SMOOTH_SCROLL_MASK);

                    let currentDeltaX = 0;

                    self.on("scroll-event", (_, event) => {
                      const childNames = Object.keys(self.children);

                      const prevChild =
                        childNames[
                        childNames.indexOf(self.get_visible_child_name()) - 1
                        ];
                      const nextChild =
                        childNames[
                        childNames.indexOf(self.get_visible_child_name()) + 1
                        ];

                      const deltaX = event.get_scroll_deltas()[1];

                      currentDeltaX += deltaX;

                      if (currentDeltaX > 10 && prevChild) {
                        self.set_visible_child_name(prevChild);
                        currentDeltaX = 0;
                      }

                      if (currentDeltaX < -10 && nextChild) {
                        self.set_visible_child_name(nextChild);
                        currentDeltaX = 0;
                      }
                    });

                    self.on("notify::visible-child", () => {
                      infoHeaderTitle.value = self.get_visible_child_name();
                    });
                  },
                }),
              ],
            }),
          }),
        ],
      }),
    ],
  }),
});
