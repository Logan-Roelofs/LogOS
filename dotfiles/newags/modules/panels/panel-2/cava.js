const cavaValues = Variable([], {
  listen: [
    [`${App.configDir}/modules/panels/panel-2/cava`],
    (out) => out.split(";").slice(0, -1),
  ],
});

const cavaBars = Array.from({ length: 12 }, (_, index) =>
  Widget.ProgressBar({
    inverted: true,
    vertical: true,
    value: cavaValues.bind().as((value) => parseInt(value[index]) / 100 || 0),
  }),
);

export const cava = Widget.Box({
  className: "cava",
  homogeneous: true,
  children: [...cavaBars],
});
