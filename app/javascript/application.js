// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function initializeRowClickEvents() {
  const rows = document.querySelectorAll("tr[data-link]");

  rows.forEach(row => {
    row.addEventListener("click", function(event) {
      // 行内のリンクがクリックされた場合は何もしない
      if (!event.target.closest("a")) {
        window.location.href = row.dataset.link;
      }
    });
  });
}

// 初回ロード時
document.addEventListener("DOMContentLoaded", function() {
  initializeRowClickEvents();
});

// Turbo Driveによるロード時
document.addEventListener("turbo:load", function() {
  initializeRowClickEvents();
});
