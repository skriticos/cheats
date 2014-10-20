CANVAS CONTEXT

--- ctx.scale(x, y);

Scales/streches the canvas content by x, y, interpreted as factor. E.g. 1.1 =
110%.

Example:

	var scaleFactor = 1.1;
	var multiplier = 1;
	var factor = math.pow(scaleFactor, multiplier);
	ctx.scale(factor, factor);


--- ctx.translate(x, y);

Pans the viewport by x and y pixels. Transformation values can be negative. Only
effects things drawn after called.

Example:

	// move viewport px to the right
	ctx.translate(50, 0);


--- ctx.strokeStyle = x; ctx.fillStyle = x;

Stroke and fill style attribute.


--- ctx.clearRect(); ctx.fillRect(); ctx.strokeRect();

--- ctx.beginPath(); ctx.closePath();
    ctx.fill(); ctx.stroke();
	ctx.moveTo(x, y);
	ctx.lineTo(x, y); ctx.rect(x, y, w, h); ctx.arc(...); arcTo(...);


--- ctx.lineWidth = x;
    ctx.lineCap = [butt|round|square];
	ctx.lineJoin = [bevel|round|miter];
	ctx.setLineDash(...);


--- ctx.font = "bold 12px sans-serif";
    ctx.textAlign = [start|end|left|right|center];
	ctx.textBaseline = [top|middle|bottom|...];
    ctx.fillText(text, x, y);

--- ctx.drawImage([img|canvas|video], x, y)

--- ctx.save(); ctx.restore();

Save and load drawing state. E.g. the stroke and transformations.
