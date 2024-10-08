// GObject libraries
const { Gtk, GLib } = imports.gi;

// Widgets
const Grid = Widget.subclass(Gtk.Grid);

const date = Variable(GLib.DateTime.new_now_local());

export const calendar = Widget.Box({
  className: "calendar",
  vexpand: false,
  vpack: "end",
  vertical: true,
  children: [
    Widget.Box({
      hexpand: true,
      children: [
        Widget.Label({
          className: "month",
          label: date.bind().as((d) => `${d.format("%B")}`),
        }),
        Widget.Label({
          className: "year",
          label: date.bind().as((d) => `${d.format("%Y")}`),
        }),
        Widget.Box({
          hpack: "end",
          hexpand: true,
          children: [
            Widget.Button({
              onPrimaryClick: () => (date.value = date.value.add_months(1)),
              child: Widget.Icon({
                icon: "pan-up-symbolic",
              }),
            }),
            Widget.Button({
              onPrimaryClick: () => (date.value = date.value.add_months(-1)),
              child: Widget.Icon({
                icon: "pan-down-symbolic",
              }),
            }),
          ],
        }),
      ],
    }),
    Widget.Box({
      className: "calendar",
      child: date.bind().as((date) =>
        Grid({
          hexpand: true,
          row_homogeneous: true,
          column_homogeneous: true,
          setup: (self) => {
            function isToday(y, m, d) {
              const today = GLib.DateTime.new_now_local();

              if (
                y === today.get_year() &&
                m === today.get_month() &&
                d === today.get_day_of_month()
              ) {
                return true;
              } else {
                return false;
              }
            }

            const year = date.get_year();
            const month = date.get_month();

            const firstDayOfMonth = GLib.DateTime.new_local(
              year,
              month,
              1,
              0,
              0,
              0,
            ).get_day_of_week();
            const daysInMonth = GLib.Date.get_days_in_month(month, year);
            const daysInLastMonth = GLib.Date.get_days_in_month(
              month - 1,
              year,
            );

            for (let row = 0; row < 7; row++) {
              for (let col = 0; col < 7; col++) {
                let label;

                if (row === 0) {
                  label = Widget.Label(
                    ["S", "M", "T", "W", "T", "F", "S"][col],
                  );
                } else {
                  let day = (row - 1) * 7 + col - firstDayOfMonth + 1;

                  if (day > 0 && day <= daysInMonth) {
                    label = Widget.Label({
                      className: `${isToday(date.get_year(), date.get_month(), day) ? "today" : ""}`,
                      label: `${day}`,
                    });
                  } else if (day < 1) {
                    label = Widget.Label({
                      className: "off",
                      label: `${daysInLastMonth + day}`,
                    });
                  } else if (day > daysInMonth) {
                    label = Widget.Label({
                      className: "off",
                      label: `${day - daysInMonth}`,
                    });
                  }
                }

                self.attach(label, col, row, 1, 1);
              }
            }
          },
        }),
      ),
    }),
  ],
});
