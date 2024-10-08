// GObject libraries
const { Pango } = imports.gi;

// Widgets
import PopupWindow from "../custom/widgets/popupWindow.js";

// Services (sort alphabetically)
const Applications = await Service.import("applications");

const application = (app) =>
  Widget.Revealer({
    attribute: { app },
    transition: "slide_down",
    transitionDuration: 125,
    setup: (self) => Utils.timeout(1, () => self.set_reveal_child(true)),
    child: Widget.Button({
      className: "application",
      onClicked: (self) => {
        App.toggleWindow("launcher");
        self.parent.attribute.app.launch();
      },
      child: Widget.Box({
        children: [
          Widget.Icon({
            //vpack: "start",
            icon: app.iconName,
          }),
          Widget.Box({
            vpack: "center",
            vertical: true,
            children: [
              Widget.Label({
                label: app.name,
                xalign: 0,
                justification: "left",
              }),
              (() => {
                if (app.description) {
                  return Widget.Label({
                    label: app.description,
                    xalign: 0,
                    justification: "left",
                    maxWidthChars: 36,
                    wrap: true,
                    wrapMode: Pango.WrapMode.WORD_CHAR,
                  });
                }
              })(),
            ],
          }),
        ],
      }),
    }),
  });

const entry = Widget.Entry({
  placeholderText: "Search...",
  primaryIconName: "system-search-symbolic",
  onAccept: () => {
    const filteredChildren = list.children.filter((app) => app.reveal_child);
    if (filteredChildren[0]) filteredChildren[0].child.clicked();
  },
  onChange: ({ text }) =>
    list.children.forEach((app) =>
      app.set_reveal_child(app.attribute.app.match(text ?? "")),
    ),
  setup: (self) =>
    self.on("button-press-event", (_, event) => event.get_button()[1] !== 1),
});

const list = Widget.Box({
  vertical: true,
  children: Applications.list.map(application),
});

export const launcher = PopupWindow({
  name: "launcher",
  anchor: ["bottom", "left"],
  keymode: "exclusive",
  transition: "slide_right",
  transitionDuration: 125,
  child: Widget.Box({
    className: "launcher",
    vertical: true,
    children: [
      entry,
      Widget.Scrollable({
        hscroll: "never",
        vexpand: true,
        child: list,
      }),
    ],
    setup: (self) =>
      self.hook(App, (self, windowName, visible) => {
        if (windowName === "launcher") {
          entry.text = "";
          entry.grab_focus();
        }
      }),
  }),
});
