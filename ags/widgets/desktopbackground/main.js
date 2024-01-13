const { Gdk, Gtk } = imports.gi;
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
const { execAsync, exec } = Utils;

import TimeAndLaunchesWidget from './timeandlaunches.js'
import SystemWidget from './system.js'
import GraphWidget from './graph.js'

export default () => Widget.Window({
    name: 'desktopbackground',
    anchor: ['top', 'bottom', 'left', 'right'],
    layer: 'bottom',
    exclusivity: 'normal',
    visible: true,
    child: Widget.Overlay({
        child: Widget.Box({
            hexpand: true,
            vexpand: true,
        }),
        overlays: [
            // GraphWidget(),
            TimeAndLaunchesWidget(),
            SystemWidget(),
        ],
        setup: (self) => self.set_overlay_pass_through(self.get_children()[1], true),
    }),
});