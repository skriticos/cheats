Create nested elements with attributes using JQuery

```
  $('<div>', {'id': 'test', 'class': 'foobar', text: 'x'})
    .append($('<p>', {id:'subtest', 'class': 'myp', text: 'some text'})
      .append($('<pre>'))
    )
    .append($('<p>'))
  
  results in =>
  
  [ <div id="test" class="foobar">
      "x"
      <p id="subtest" class="myp">
          "some text"
          <pre></pre>
      </p>
      <p></p>
  </div> ]
```
