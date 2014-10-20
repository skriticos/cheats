/*
<svg width="500" height="500" id="svg">
    <line x1="0" y1="100" x2="500" y2="100" stroke="black" stroke-width="1" />
</svg>

http://jsfiddle.net/2wokzk3a/
*/

var svg = document.getElementById("svg");

// text width through bounding box
function getTextWidth(elm) {
    var bbox = elm.getBBox();
    return bbox.width;
}

// create text from top-left position
function createTextTop(text, x, y) {
    var newElement = document.createElementNS("http://www.w3.org/2000/svg", 'text');
    
    var textNode = document.createTextNode("Hello there!");
    newElement.appendChild(textNode);
    
    newElement.setAttribute("x", x);
    newElement.setAttribute("y", y);

    svg.appendChild(newElement);

    var fontSize = parseInt(window.getComputedStyle(newElement, null).getPropertyValue("font-size"), 10);
    newElement.setAttribute("y", y + fontSize);
    
    console.log(getTextWidth(newElement)); // 85 (at 16px)
}

// same as above, but with font size specified
function createTextTopSize(text, x, y, size) {
    var newElement = document.createElementNS("http://www.w3.org/2000/svg", 'text');
    
    var textNode = document.createTextNode("Hello there!");
    newElement.appendChild(textNode);
    
    newElement.setAttribute("font-size", size);
    newElement.setAttribute("x", x);
    newElement.setAttribute("y", y + size);

    svg.appendChild(newElement);

    console.log(getTextWidth(newElement)); // 66 (at 12px)
}

// test
createTextTop("Hello there!", 100, 100);
createTextTopSize("Hello There 2!", 300, 100, 12);
