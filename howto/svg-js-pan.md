Add panning to HTML embedded SVGs with JavaScript
=================================================

The HTML file is set to hide the rulers and contains an SVG element with
a single group. This group is used to make the panning work, and all
other SVG elements need to be part of it. The HTML calls the init()
function on page load, which adjusts the SVG view port to the inner
dimensions of the browser window. The program logic uses the d3 library
for selecting and setting attributes/events, etc.

    <!DOCTYPE HTML>
    <meta charset="utf-8">
    <script src="d3.min.js"></script>
    <script src="engine.js"></script>
    <style>
        body{margin:0px;padding:0px;overflow:hidden;}
    </style>

    <svg id="mainSvg">
        <g id="mainGroup">
            <polygon points="100,10 40,198 190,78 10,78 160,198"
                style="fill:lime;stroke:purple;stroke-width:5;fill-rule:nonzero;" />
        </g
    </svg>

    <script>
        window.onload=init;
    </script>

Panning is initiated with a mouse down on the SVG area, but not on
objects that are on it (which would be dragging, or selection, or
something.). For this, there is a `transformState` variable that is set
to 'pan' when panning is active.

    var transformState = '';

The `panTranslateVal` variable stores the absolute translation vector
for the panning and is incrementally adjusted when panning around. It
starts with zero.

    var panTranslateVal = { x: 0, y: 0 };

The `panPrevCoords` stores the previous mouse position on the client
window. When moving the mouse while pressing the left mouse button, the
event has the new coordinates where the mouse moved to. Substracting the
previous coordinates will yield the delta that needs to be added to the
transformation.

    var panPrevCoords = { x: 0, y: 0 };

The `init` function re-sizes the SVG to the browser size and registers
the mouse events.

    function init() {

        var mainSvg = d3.select("#mainSvg");

        mainSvg
            // set initial window size
            .attr('width', window.innerWidth)
            .attr('height', window.innerHeight)

            // if the drag is initated on the background, start panning
            // otherwise drag-n-drop, select, etc..
            .on('mousedown', function() {
                if (d3.event.target.id == 'mainSvg' || d3.event.target.id == 'mainGroup') {
                    transformState = 'pan';
                }
            })

            // re-set pan state when mouse button is released
            .on('mouseup', function() {
                transformState = '';
                panPrevCoords = {x: 0, y: 0}
            })

            // the actual panning is done while the mouse is moved.
            .on('mousemove', function() {
                if (transformState == 'pan') {

                    // get mouse pointer coordinates
                    var clientX = d3.event.clientX;
                    var clientY = d3.event.clientY;

                    // if this is the first move after pan started, store coordinates
                    if (panPrevCoords.x == 0 && panPrevCoords.y == 0) {
                        panPrevCoords = { x: clientX, y: clientY };
                        return;
                    }

                    // otherwise calculate difference to previous transformation
                    var deltaX = clientX - panPrevCoords.x;
                    var deltaY = clientY - panPrevCoords.y;

                    // apply it to the transform vector
                    panTranslateVal.x += deltaX;
                    panTranslateVal.y += deltaY;

                    // and set the new vector for transformation
                    d3.select('#mainGroup')
                        .attr('transform', 'translate('+panTranslateVal.x+','+panTranslateVal.y+')');

                    // finally, store the new coordinates, that are used for the delta calculations of the next mouse move event
                    panPrevCoords = { x: clientX, y: clientY };
                }
            });
    }

// vim: set tw=72 sw=4 ts=4 spell:
