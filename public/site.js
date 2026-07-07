window.onkeydown = function(e) {
  if (e.ctrlKey || e.altKey || e.shiftKey || e.metaKey) {
    return;
  }
  if (e.key === "ArrowLeft") {
    var prev = document.querySelector('p.next a:first-child');
    if (prev) {
      window.location.href = prev.getAttribute('href');
    }
  }
  if (e.key === "ArrowRight") {
    var links = document.querySelectorAll('p.next a');
    var next = links[links.length - 1];
    if (next && next.textContent.indexOf('\u2192') !== -1) {
      window.location.href = next.getAttribute('href');
    }
  }
};

document.addEventListener('DOMContentLoaded', function() {
  var blocks = document.querySelectorAll('td.code pre');
  blocks.forEach(function(pre) {
    var btn = document.createElement('img');
    btn.src = '/clipboard.svg';
    btn.className = 'copy';
    btn.title = 'Copy code';
    btn.addEventListener('click', function() {
      var text = pre.textContent;
      navigator.clipboard.writeText(text).then(function() {
        btn.title = 'Copied!';
        setTimeout(function() {
          btn.title = 'Copy code';
        }, 2000);
      });
    });
    var td = pre.parentNode;
    if (td) td.insertBefore(btn, td.firstChild);
  });
});
