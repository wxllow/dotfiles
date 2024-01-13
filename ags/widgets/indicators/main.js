import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Indicator from '../../services/indicator.js';
import IndicatorValues from './indicatorvalues.js';
import MusicControls from './musiccontrols.js';
import ColorScheme from './colorscheme.js';
import NotificationPopups from './notificationpopups.js';

export default (monitor) => Widget.Window({
    name: `indicator${monitor}`,
    monitor,
    className: 'indicator',
    layer: 'overlay',
    // exclusivity: 'ignore',
    visible: true,
    anchor: ['bottom', 'right'],
    child: Widget.EventBox({
        onHover: () => { //make the widget hide when hovering
            Indicator.popup(-1);
        },
        child: Widget.Box({
            vertical: true,
            className: 'osd-window',
            css: 'min-height: 2px; padding: 1rem;',
            children: [
                IndicatorValues(),
                MusicControls(),
                NotificationPopups(),
                ColorScheme(),
            ]
        })
    }),
});

