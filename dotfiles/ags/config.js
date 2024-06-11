const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S %b %e."'],
})

function myLabel() {
  return Widget.Label({
    label: "Hello World",
  })
}

function Left() {
    return Widget.Box({
        spacing: 8,
        children: [
          myLabel() 
        ],
    })
}

function Center() {
    return Widget.Box({
        spacing: 8,
        children: [
          myLabel(),
        ],
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [
          myLabel(),
        ],
    })
}
const Bar = (monitor) => Widget.Window({
  name: `bar-${monitor}`, // name has to be unique
  class_name: "bar",
  monitor,
  anchor: ["top", "left", "right"], // Sets widget to the top of the screen
  exclusivity: "exclusive", // Makes room for the bar AKA no overlapping with other windows
  child: Widget.CenterBox({
    start_widget: Left(),
    center_widget: Center(),
    end_widget: Right(),
  }),
})

App.config({
  windows: [Bar(0),Bar(1)],
})

