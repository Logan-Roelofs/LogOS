export default ({
  name,
  child,
  transition = "slide_up",
  transitionDuration = 250,
  ...params
}) => {
  const window = Widget.Window({
    name,
    visible: false,
    widthRequest: 2,
    heightRequest: 2,
    ...params,

    child: Widget.Revealer({
      transition,
      transitionDuration,
      hexpand: true,
      vexpand: true,
      child: child,
      setup: (self) => {
        self.hook(App, (self, windowName, visible) => {
          if (windowName === name) {
            self.revealChild = visible;
          }
        });
      },
    }),
  });

  return window;
};
