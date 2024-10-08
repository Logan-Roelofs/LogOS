// Widgets
import PopupWindow from "../../custom/widgets/popupWindow.js";

// Services (sort alphabetically)
const Audio = await Service.import("audio");

export const volumeOsd = Widget.Revealer({
  transition: "slide_up",
  transitionDuration: 125,
  child: Widget.Box({
    className: "volume-osd",
    children: [
      Widget.Icon({
        setup: (self) =>
          self.hook(Audio, () => {
            const volume = Audio.speaker.volume * 100;
            const thresholds = [101, 67, 34, 1, 0];
            self.icon = `audio-volume-${["overamplified", "high", "medium", "low", "muted"][
              Math.max(
                0,
                thresholds.findIndex((threshold) => volume >= threshold),
              )
              ]
              }-symbolic`;
          }),
      }),
      Widget.Slider({
        value: Audio.speaker.bind("volume"),
        drawValue: false,
        onChange: ({ value }) => (Audio.speaker.volume = value),
      }),
    ],
  }),
  setup: (self) => {
    let i = 0;

    self.hook(
      Audio,
      () => {
        self.set_reveal_child(true);
        i++;
        Utils.timeout(2500, () => {
          i--;

          if (i === 0) self.set_reveal_child(false);
        });
      },
      "speaker-changed",
    );
  },
});
