import { clock } from "lib/variables";
import PanelButton from "../PanelButton";
import options from "options";
import GLib from "gi://GLib?version=2.0"

const dateTime = Variable(GLib.DateTime.new_now_local(), {
  poll: [1000, () => GLib.DateTime.new_now_local()],
});

const { format, action } = options.bar.date;
const time = Utils.derive([clock, format], (c, f) => c.format(f) || "");

export default () =>
  PanelButton({
    window: "datemenu",
    on_clicked: action.bind(),
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
  });
