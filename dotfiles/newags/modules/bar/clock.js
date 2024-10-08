const { GLib } = imports.gi;

const dateTime = Variable(GLib.DateTime.new_now_local(), {
  poll: [1000, () => GLib.DateTime.new_now_local()],
});

export const clock = Widget.Button({
  onClicked: () => App.toggleWindow("panel-2"),
  child: Widget.Box({
    className: "clock",
    vpack: "center",
    vertical: true,
    children: [
      Widget.Label({
        className: "date",
        justification: "center",
        label: dateTime.bind().as((date) => date.format("%a %d")),
      }),
      Widget.Label({
        className: "time",
        justification: "center",
        label: dateTime.bind().as((time) => time.format("%I:%M")),
      }),
    ],
  }),
});
