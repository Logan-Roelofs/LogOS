const screen = "intel_backlight";
const screenPath = `/sys/class/backlight/${screen}`;

const getBrightness = () => Utils.readFile(`${screenPath}/brightness`);
const getMaxBrightness = () => Utils.readFile(`${screenPath}/max_brightness`);

class Brightness extends Service {
  static {
    Service.register(
      this,
      {},
      {
        screen: ["float", "rw"],
      },
    );
  }

  _screenMax = getMaxBrightness();
  _screen = getBrightness() / getMaxBrightness();

  get screen() {
    return this._screen;
  }

  set screen(percent) {
    if (percent < 0) {
      percent = 0;
    }

    if (percent > 1) {
      percent = 1;
    }

    Utils.execAsync(`brightnessctl s ${Math.floor(percent * 100)}% -q`).then(
      () => {
        this._screen = percent;
        this.changed("screen");
      },
    );
  }

  constructor() {
    super();

    Utils.monitorFile(`${screenPath}/brightness`, async (f) => {
      const v = await Utils.readFileAsync(f);
      this._screen = Number(v) / this._screenMax;
      this.changed("screen");
    });
  }
}

export default new Brightness();
