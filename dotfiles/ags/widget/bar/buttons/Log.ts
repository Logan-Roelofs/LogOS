import PanelButton from "../PanelButton"
import logs from "service/logs"
import Gdk from "gi://Gdk"

const css = (color: string) => `
* {
    background-color: ${color};
    color: transparent;
}
*:hover {
    color: white;
    text-shadow: 2px 2px 3px rgba(0,0,0,.8);
}`

export default () => {
    const menu = Widget.Menu({
        class_name: "logs",
        children: logs.bind("colors").as(c => c.map(color => Widget.MenuItem({
            child: Widget.Label(color),
            css: css(color),
            on_activate: () => logs.wlCopy(color),
        }))),
    })

    return PanelButton({
        class_name: "color-picker",
        child: Widget.Icon("logs-logo-symbolic"),
        tooltip_text: logs.bind("colors").as(v => `${v.length} colors`),
        on_clicked: logs.pick,
        on_secondary_click: self => {
            if (logs.colors.length === 0)
                return

            menu.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null)
        },
    })
}
