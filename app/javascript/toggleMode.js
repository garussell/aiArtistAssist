document.addEventListener("turbo:load", function() {
  var darkSwitch = document.getElementById("darkSwitch");
  var body = document.body;

  // Check if dark mode is stored as a cookie
  var isDarkMode = document.cookie.indexOf("darkMode=true") !== -1;

  // Set the theme to dark if dark mode is stored as a cookie
  body.classList.toggle("dark-mode", isDarkMode);
  darkSwitch.checked = isDarkMode;

  darkSwitch.addEventListener("change", function() {
    // Toggle between dark and regular mode
    body.classList.toggle("dark-mode", darkSwitch.checked);

    // Store the dark mode preference as a cookie
    document.cookie = "darkMode=" + darkSwitch.checked + ";path=/";
  });
});
