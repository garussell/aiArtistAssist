document.addEventListener("DOMContentLoaded", function() {
  var darkSwitch = document.getElementById("darkSwitch");
  var body = document.body;

  darkSwitch.addEventListener("change", function() {
    // Toggle between dark and regular mode
    body.classList.toggle("dark-mode", darkSwitch.checked);
  });
});
