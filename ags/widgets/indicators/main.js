import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Indicator from "../../services/indicator.js";
import IndicatorValues from "./indicatorvalues.js";
// import MusicControls from "./musiccontrols.js";
import ColorScheme from "./colorscheme.js";
import NotificationPopups from "./notificationpopups.js";
import App from "resource:///com/github/Aylur/ags/app.js";

const box = Widget.Box({
  vertical: true,
  className: "osd-window",
  css: "min-height: 2px; padding: 1rem;",
  children: [
    IndicatorValues(),
    //   MusicControls(),
    NotificationPopups(),
    ColorScheme(),
  ],
});

export default () =>
  Widget.Window({
    name: `indicator`,
    className: "indicator",
    layer: "overlay",
    // exclusivity: 'ignore',
    visible: true,
    anchor: ["bottom", "right"],
    child: Widget.EventBox({
      onHover: () => {
        //make the widget hide when hovering
        Indicator.popup(-1);
      },
      child: box,
    }),
  });

App.connect("config-parsed", async () => {
  console.log("CPF2");
  try {
    const { default: MusicControls } = await import("./musiccontrols.js");

    box.children = [box.children[0], MusicControls, ...box.children.slice(1)];
  } catch (e) {
    console.log(e);
  }
});
