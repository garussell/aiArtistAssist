document.getElementById('toggle-password').addEventListener('change', function() {
  var passwordFields = document.getElementById('password-fields');
  passwordFields.classList.toggle('hide', !this.checked);
  passwordFields.classList.toggle('show', this.checked);
});