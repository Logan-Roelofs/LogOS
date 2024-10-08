// Services (sort alphabetically)
import Brightness from "../../custom/services/brightness.js";

export const brightnessOsd = Widget.Revealer({
  transition: "slide_up",
  transitionDuration: 125,
  child: Widget.Box({
    className: "brightness-osd",
    children: [
      Widget.Icon({
        icon: "display-brightness-symbolic",
      }),
      Widget.Slider({
        value: Brightness.bind("screen"),
        drawValue: false,
        hexpand: true,
        onChange: ({ value }) => (Brightness.screen = value),
      }),
    ],
  }),
  setup: (self) => {
    let i = 0;

    self.hook(
      Brightness,
      () => {
        self.set_reveal_child(true);
        i++;
        Utils.timeout(2500, () => {
          i--;

          if (i === 0) self.set_reveal_child(false);
        });
      },
      "notify::screen",
    );
  },
});
