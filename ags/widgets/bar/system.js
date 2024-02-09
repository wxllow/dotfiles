// This is for the right pill of the bar.
// For the cool memory indicator on the sidebar, see sysinfo.js
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import * as Utils from "resource:///com/github/Aylur/ags/utils.js";
const { Box, Label, Button, Overlay, Revealer, Scrollable, Stack, EventBox } =
  Widget;
const { exec, execAsync } = Utils;
const { GLib } = imports.gi;
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import { MaterialIcon } from "../../lib/materialicon.js";
import { AnimatedCircProg } from "../../lib/animatedcircularprogress.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";

const BATTERY_LOW = 20;

const BatBatteryProgress = () => {
  const _updateProgress = (circprog) => {
    // Set circular progress value
    circprog.css = `font-size: ${Math.abs(Battery.percent)}px;`;

    circprog.toggleClassName(
      "bar-batt-circprog-low",
      Battery.percent <= BATTERY_LOW
    );
    circprog.toggleClassName("bar-batt-circprog-full", Battery.charged);
  };
  return AnimatedCircProg({
    className: "bar-batt-circprog",
    vpack: "center",
    hpack: "center",
    extraSetup: (self) => self.hook(Battery, _updateProgress),
  });
};

const BarClock = () =>
  Widget.Box({
    vpack: "center",
    className: "spacing-h-5 txt-onSurfaceVariant bar-clock-box",
    children: [
      Widget.Label({
        className: "bar-clock",
        label: GLib.DateTime.new_now_local().format("%I:%M:%S"),
        setup: (self) =>
          self.poll(15, (label) => {
            label.label = GLib.DateTime.new_now_local().format("%I:%M:%S");
          }),
      }),
      Widget.Label({
        className: "txt-norm",
        label: "•",
      }),
      Widget.Label({
        className: "txt-smallie",
        label: GLib.DateTime.new_now_local().format("%A, %m/%d"),
        setup: (self) =>
          self.poll(5000, (label) => {
            label.label = GLib.DateTime.new_now_local().format("%A, %m/%d");
          }),
      }),
    ],
  });

const UtilButton = ({ name, icon, onClicked }) =>
  Button({
    vpack: "center",
    tooltipText: name,
    onClicked: onClicked,
    className: "bar-util-btn icon-material txt-norm",
    label: `${icon}`,
  });

const Utilities = () =>
  Box({
    hpack: "center",
    className: "spacing-h-5 txt-onSurfaceVariant",
    children: [
      UtilButton({
        name: "Screen snip",
        icon: "screenshot_region",
        onClicked: () => {
          Utils.execAsync([
            "bash",
            "-c",
            `grimblast --notify --cursor copysave area`,
          ]).catch(print);
        },
      }),
      UtilButton({
        name: "Color picker",
        icon: "colorize",
        onClicked: () => {
          Utils.execAsync(["hyprpicker", "-a"]).catch(print);
        },
      }),
      UtilButton({
        name: "Toggle on-screen keyboard",
        icon: "keyboard",
        onClicked: () => {
          App.toggleWindow("osk");
        },
      }),
    ],
  });

const indics = [
  [0, "battery_0_bar", "battery_charging_20"],
  [10, "battery_1_bar", "battery_charging_20"],
  [20, "battery_2_bar", "battery_charging_30"],
  [40, "battery_3_bar", "battery_charging_50"],
  [60, "battery_4_bar", "battery_charging_60"],
  [80, "battery_5_bar", "battery_charging_80"],
  [90, "battery_6_bar", "battery_charging_90"],
  [96, "battery_full", "battery_charging_full"],
];

const BarBattery = () =>
  Box({
    className: "spacing-h-4 txt-onSurfaceVariant",
    children: [
      Label({
        className: "txt-smallie txt-onSurfaceVariant",
        setup: (self) =>
          self.hook(Battery, (label) => {
            label.label = `${Battery.percent}%`;
          }),
      }),
      Overlay({
        child: Widget.Box({
          vpack: "center",
          className: "bar-batt",
          homogeneous: true,
          children: [
            MaterialIcon(
              indics.find(([threshold]) => threshold <= Battery.percent)[
                Battery.charging ? 2 : 1
              ],
              "small"
            ),
          ],
          setup: (self) =>
            self.hook(Battery, (box) => {
              box.children[0].label = indics.find(
                ([threshold]) => threshold <= Battery.percent
              )[Battery.charging ? 2 : 1];
            }),
        }),
        overlays: [BatBatteryProgress()],
      }),
    ],
  });

const BarResourceValue = (name, icon, command) =>
  Widget.Box({
    vpack: "center",
    className: "bar-batt spacing-h-5",
    children: [
      MaterialIcon(icon, "small"),
      Widget.ProgressBar({
        // Progress
        vpack: "center",
        hexpand: true,
        className: "bar-prog-batt",
        setup: (self) =>
          self.poll(5000, (progress) =>
            execAsync(["bash", "-c", command])
              .then((output) => {
                progress.value = Number(output) / 100;
                progress.tooltipText = `${name}: ${Number(output)}%`;
              })
              .catch(print)
          ),
      }),
    ],
  });

const BarResource = (name, icon, command, details_name, details_command) => {
  const resourceLabel = Label({
    className: "txt-smallie txt-onSurfaceVariant",
  });
  const resourceCircProg = AnimatedCircProg({
    className: "bar-batt-circprog",
    vpack: "center",
    hpack: "center",
  });
  const widget = Box({
    className: "spacing-h-4 txt-onSurfaceVariant",
    children: [
      resourceLabel,
      Overlay({
        child: Widget.Box({
          vpack: "center",
          className: "bar-batt",
          homogeneous: true,
          children: [MaterialIcon(icon, "small")],
        }),
        overlays: [resourceCircProg],
      }),
    ],
    setup: (self) =>
      self.poll(5000, () =>
        execAsync(["bash", "-c", command])
          .then((output) => {
            resourceCircProg.css = `font-size: ${Number(output)}px;`;
            resourceLabel.label = `${Math.round(Number(output))}%`;

            if (details_name) {
              execAsync(["bash", "-c", details_command])
                .then((details_output) => {
                  widget.tooltipText = `${name}: ${Math.round(
                    Number(output)
                  )}%\n\n${details_name}: ${Math.round(
                    Number(details_output)
                  )}%`;
                })
                .catch(print);
            } else {
              widget.tooltipText = `${name}: ${Math.round(Number(output))}%`;
            }
          })
          .catch(print)
      ),
  });
  return widget;
};

/*
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';

const volumeIndicator = Widget.Button({
    onClicked: () => Audio.speaker.isMuted = !Audio.speaker.isMuted,
    child: Widget.Icon().hook(Audio, self => {
        if (!Audio.speaker)
            return;

        const vol = Audio.speaker.volume * 100;
        const icon = [
            [101, 'overamplified'],
            [67,  'high'],
            [34,  'medium'],
            [1,   'low'],
            [0,   'muted'],
        ].find(([threshold]) => threshold <= vol)[1];

        self.icon = `audio-volume-${icon}-symbolic`;
        self.tooltipText = `Volume ${Math.floor(vol)}%`;
    }, 'speaker-changed'),
});
 */
const Volume = () => {
  const resourceLabel = Label({
    className: "txt-smallie txt-onSurfaceVariant",
  });
  const resourceCircProg = AnimatedCircProg({
    className: "bar-batt-circprog",
    vpack: "center",
    hpack: "center",
  });
  const iconBox = MaterialIcon("no_sound", "small");

  const widget = Widget.EventBox({
    onPrimaryClickRelease: () =>
      execAsync(["bash", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"]),
    onSecondaryClickRelease: () => execAsync(["bash", "-c", "pavucontrol &"]),
    child: Box({
      className: "spacing-h-4 txt-onSurfaceVariant",
      children: [
        resourceLabel,
        Overlay({
          child: Widget.Box({
            vpack: "center",
            className: "bar-batt",
            homogeneous: true,
            children: [iconBox],
          }),
          overlays: [resourceCircProg],
        }),
      ],
      setup: (self) =>
        self.hook(Audio, (self) => {
          if (!Audio.speaker) return;

          const vol = Audio.speaker.volume * 100;
          const icon = [
            [32, "volume_up"],
            [1, "volume_down"],
            [0, "volume_mute"],
          ].find(([threshold]) => threshold <= vol)[1];

          resourceCircProg.css = `font-size: ${vol}px;`;
          resourceLabel.label = Audio.speaker.stream.isMuted
            ? ""
            : `${Math.round(vol)}%`;
          widget.tooltipText = `${Audio.speaker.description} - ${Math.round(
            vol
          )}%`;
          iconBox.label = Audio.speaker.stream.isMuted ? "no_sound" : icon;
        }),
    }),
  });
  return widget;
};

const BarGroup = ({ child }) =>
  Widget.Box({
    className: "bar-group-margin bar-sides",
    children: [
      Widget.Box({
        className: "bar-group bar-group-standalone bar-group-pad-system",
        children: [child],
      }),
    ],
  });

const moveToRelativeWorkspace = async (self, num) => {
  try {
    const Hyprland = (
      await import("resource:///com/github/Aylur/ags/service/hyprland.js")
    ).default;
    Hyprland.sendMessage(`dispatch workspace ${num > 0 ? "+" : ""}${num}`);
  } catch {
    console.log(`TODO: Sway workspace ${num > 0 ? "+" : ""}${num}`);
  }
};

export const ModuleSystem = () =>
  Widget.EventBox({
    // onScrollUp: (self) => moveToRelativeWorkspace(self, -1),
    // onScrollDown: (self) => moveToRelativeWorkspace(self, +1),
    // onPrimaryClick: () => App.toggleWindow('sideright'),
    child: Widget.Box({
      className: "spacing-h-5",
      children: [
        BarGroup({ child: BarClock() }),
        Stack({
          transition: "slide_up_down",
          transitionDuration: 150,
          items: [
            [
              "laptop",
              Box({
                className: "spacing-h-5",
                children: [
                  BarGroup({ child: Utilities() }),
                  BarGroup({ child: BarBattery() }),
                  BarGroup({ child: Volume() }),
                  BarGroup({
                    child: BarResource(
                      "CPU usage",
                      "memory",
                      `awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1); }' \
                            <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)`
                    ),
                  }),
                  BarGroup({
                    child: BarResource(
                      "RAM usage",
                      "memory_alt",
                      `free | awk '/^Mem/ {printf("%.2f\\n", ($3/$2) * 100)}'`,
                      "Swap usage",
                      `free | awk '/^Swap/ {printf("%.2f\\n", ($3/$2) * 100)}'`
                    ),
                  }),
                  // BarGroup({
                  //   child: BarResource(
                  //     "Swap usage",
                  //     "swap_horiz",
                  //     `free | awk '/^Swap/ {printf("%.2f\\n", ($3/$2) * 100)}'`
                  //   ),
                  // }),
                ],
              }),
            ],
            [
              "desktop",
              Box({
                className: "spacing-h-5",
                children: [
                  BarGroup({ child: Utilities() }),
                  BarGroup({ child: Volume() }),
                  BarGroup({
                    child: BarResource(
                      "CPU usage",
                      "memory",
                      `awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1); }' \
                            <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)`
                    ),
                  }),
                  BarGroup({
                    child: BarResource(
                      "RAM usage",
                      "memory_alt",
                      `free | awk '/^Mem/ {printf("%.2f\\n", ($3/$2) * 100)}'`
                    ),
                  }),
                  BarGroup({
                    child: BarResource(
                      "Swap usage",
                      "swap_horiz",
                      `free | awk '/^Swap/ {printf("%.2f\\n", ($3/$2) * 100)}'`
                    ),
                  }),
                ],
              }),
            ],
          ],
          setup: (stack) =>
            Utils.timeout(10, () => {
              if (!Battery.available) stack.shown = "desktop";
              else stack.shown = "laptop";
            }),
        }),
      ],
    }),
  });
