// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
  const rows = document.querySelectorAll("tr[data-link]");

  rows.forEach(row => {
    row.addEventListener("click", function(event) {
      // 行内のリンクがクリックされた場合は何もしない
      if (!event.target.closest("a")) {
        window.location.href = row.dataset.link;
      }
    });
  });
});
