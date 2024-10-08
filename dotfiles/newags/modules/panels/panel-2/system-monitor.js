// GObject libraries
const { cairo, GLib, GTop } = imports.gi;

let cpu = new GTop.glibtop_cpu();
const getCpuUsage = () => {
  const newCpu = new GTop.glibtop_cpu();
  GTop.glibtop_get_cpu(newCpu);

  const total = newCpu.total - cpu.total;
  const user = newCpu.user - cpu.user;
  const nice = newCpu.nice - cpu.nice;
  const sys = newCpu.sys - cpu.sys;

  cpu = newCpu;

  return (user + nice + sys) / Math.max(total, 1.0);
};

const cpuUsage = Variable(0, {
  poll: [1000, getCpuUsage],
});

const mem = new GTop.glibtop_mem();
const getMemUsage = () => {
  GTop.glibtop_get_mem(mem);

  return { user: mem.user, total: mem.total };
};

const memUsage = Variable(
  { user: 0, total: 0 },
  {
    poll: [1000, getMemUsage],
  },
);

const getTemp = () => parseFloat(Utils.exec("acpi -t").match(/\d+\.\d+/)[0]);

const temp = Variable(0, {
  poll: [1000, getTemp],
});

const cpuMonitor = Widget.Box({
  className: "cpu",
  vexpand: false,
  child: Widget.Box({
    vertical: true,
    children: [
      Widget.Box({
        children: [
          Widget.Label({
            hpack: "start",
            label: "Cpu",
          }),
          Widget.Label({
            hpack: "end",
            hexpand: true,
            label: cpuUsage.bind().as((usage) => `${Math.floor(usage * 100)}%`),
          }),
        ],
      }),
      Widget.ProgressBar({
        hexpand: true,
        value: cpuUsage.bind(),
      }),
    ],
  }),
});

const formatBytes = (bytes) => {
  bytes /= 1048576;

  const n = parseInt(bytes, 10) || 0;

  if (n > 1048576) {
    return `${(n / 1048576).toFixed(1)} MiB`;
  } else {
    return `${(n / 1024).toFixed(1)} GiB`;
  }
};

const memoryMonitor = Widget.Box({
  className: "memory",
  vexpand: false,
  child: Widget.Box({
    vertical: true,
    children: [
      Widget.Box({
        children: [
          Widget.Label({
            hpack: "start",
            label: "Memory",
          }),
          Widget.Label({
            hpack: "end",
            hexpand: true,
            label: memUsage
              .bind()
              .as(
                (usage) =>
                  `${formatBytes(usage.user)} / ${formatBytes(usage.total)}`,
              ),
          }),
        ],
      }),
      Widget.ProgressBar({
        hexpand: true,
        value: memUsage
          .bind()
          .as((usage) => usage.user / Math.max(usage.total, 1.0)),
      }),
    ],
  }),
});

const temperatureMonitor = Widget.Box({
  className: "temperature",
  child: Widget.Box({
    vertical: true,
    children: [
      Widget.ProgressBar({
        hpack: "center",
        vexpand: true,
        vertical: true,
        inverted: true,
        value: temp.bind().as((temp) => temp / 100),
      }),
      Widget.Label({
        label: temp.bind().as((temp) => `${temp}°C`),
      }),
    ],
  }),
});

const randomValue = Variable(0, {
  poll: [1000, () => Math.random()],
});

const randomMonitor = () => {
  const graphHistory = [];
  const updateGraphHistory = (value, time) => graphHistory.push([value, time]);

  return Widget.Box({
    className: "random",
    vertical: true,
    children: [
      Widget.Box({
        vpack: "start",
        children: [
          Widget.Label("/dev/random"),
          Widget.Label({
            hpack: "end",
            hexpand: true,
            label: randomValue.bind().as((value) => `${value.toFixed(1)}`),
          }),
        ],
      }),
      Widget.DrawingArea({
        hexpand: true,
        vexpand: true,
        drawFn: (self, cr, w, h) => {
          const max = 5;
          const min = 0;

          const now = GLib.get_monotonic_time();

          const valueRange = max - min;
          const timeRange = 10 * 1_000_000;

          cr.setSourceRGBA(1, 1, 1, 0.35);
          cr.setLineWidth(2);

          const graphPoints = graphHistory
            .map(([value, time]) => [
              w * ((now - time) / timeRange),
              h * (1 - value / valueRange),
            ])
            .filter(([x, y], i) => {
              if (i === 0) {
                return true;
              }

              return x >= 0 && x <= w;
            });

          if (graphPoints.length > 0) {
            cr.moveTo(graphPoints[0][0], graphPoints[0][1]);
            for (let i = 1; i < graphPoints.length; i++) {
              cr.lineTo(graphPoints[i][0], graphPoints[i][1]);
            }
            cr.stroke();
          }
        },
        setup: (self) =>
          self.hook(randomValue, () => {
            updateGraphHistory(randomValue.value, GLib.get_monotonic_time());
            self.queue_draw();
          }),
      }),
    ],
  });
};

export const systemMonitor = Widget.Box({
  className: "system-monitor",
  child: Widget.Box({
    children: [
      Widget.Box({
        vertical: true,
        children: [cpuMonitor, memoryMonitor, randomMonitor()],
      }),
      temperatureMonitor,
    ],
  }),
});
