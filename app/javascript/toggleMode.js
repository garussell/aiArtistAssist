document.addEventListener("DOMContentLoaded", function() {
  var toggleModeButton = document.getElementById("toggleModeButton");
  var body = document.body;

  toggleModeButton.addEventListener("click", function() {
    // Toggle between dark and regular mode
    body.classList.toggle("dark-mode");
  });
});
