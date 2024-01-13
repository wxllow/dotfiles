import Cairo from 'gi://cairo?version=1.0';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { RoundedCorner } from "../../lib/roundedcorner.js";

const dummyRegion = new Cairo.Region();
const enableClickthrough = (self) => self.input_shape_combine_region(dummyRegion);

export const CornerTopleft = () => Widget.Window({
    name: 'cornertl',
    layer: 'top',
    anchor: ['top', 'left'],
    exclusivity: 'normal',
    visible: true,
    child: RoundedCorner('topleft', { className: 'corner', }),
    setup: enableClickthrough,
});
export const CornerTopright = () => Widget.Window({
    name: 'cornertr',
    layer: 'top',
    anchor: ['top', 'right'],
    exclusivity: 'normal',
    visible: true,
    child: RoundedCorner('topright', { className: 'corner', }),
    setup: enableClickthrough,
});
export const CornerBottomleft = () => Widget.Window({
    name: 'cornerbl',
    layer: 'top',
    anchor: ['bottom', 'left'],
    exclusivity: 'ignore',
    visible: true,
    child: RoundedCorner('bottomleft', { className: 'corner-black', }),
    setup: enableClickthrough,
});
export const CornerBottomright = () => Widget.Window({
    name: 'cornerbr',
    layer: 'top',
    anchor: ['bottom', 'right'],
    exclusivity: 'ignore',
    visible: true,
    child: RoundedCorner('bottomright', { className: 'corner-black', }),
    setup: enableClickthrough,
});
