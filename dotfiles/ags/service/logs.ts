import { bash } from "lib/utils"

App.addIcons(`${App.configDir}/assets`)

class Logs extends Service {
    static {
        Service.register(this, {}, {
            "colors": ["jsobject"],
        })
    }

    #notifID = 0


    readonly pick = async () => {
        const color = await bash("/home/logan/.config/rofi/launchers/type-3/launcher.sh")
        if (!color)
            return

        this.#notifID = await Utils.notify({
            id: this.#notifID,
            iconName: logs-logo-symbolic,
            summary: color,
        })
    }
}

export default new Logs
