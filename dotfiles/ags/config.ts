const hyprland = await Service.import("hyprland");

const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S %b %e."'],
});

const dispatch = (ws) => hyprland.messageAsync(`dispatch workspace ${ws}`);
const Workspaces = () =>
  Widget.EventBox({
    onScrollUp: () => dispatch("+1"),
    onScrollDown: () => dispatch("-1"),
    child: Widget.Box({
      children: Array.from({ length: 10 }, (_, i) => i + 1).map((i) =>
        Widget.Button({
          attribute: i,
          label: `${i}`,
          onClicked: () => dispatch(i),
        }),
      ),

      // remove this setup hook if you want fixed number of buttons
      setup: (self) =>
        self.hook(hyprland, () =>
          self.children.forEach((btn) => {
            btn.visible = hyprland.workspaces.some(
              (ws) => ws.id === btn.attribute,
            );
          }),
        ),
    }),
  });

function myLabel() {
  return Widget.Label({
    class_name: "HelloWorld",
    label: "Hello World",
  });
}

// layout of the bar
function Left() {
  return Widget.Box({
    spacing: 8,
    children: [myLabel()],
  });
}

function Center() {
  return Widget.Box({
    spacing: 8,
    children: [Workspaces()],
  });
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [myLabel()],
  });
}

function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
}

App.config({
  style: "./style.css",
  windows: [
    Bar(),

    // you can call it, for each monitor
    // Bar(0),
    // Bar(1)
  ],
});
