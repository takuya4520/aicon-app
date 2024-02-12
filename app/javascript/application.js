// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("turbo:load", function () { // Turbolinks 5以前では 'turbolinks:load'
  document.getElementById("menuButton").addEventListener("click", function () {
    var menu = document.getElementById("menu");
    if (menu.classList.contains("hidden")) {
      menu.classList.remove("hidden");
      menu.classList.add("block");
    } else {
      menu.classList.add("hidden");
      menu.classList.remove("block");
    }
  });
});
