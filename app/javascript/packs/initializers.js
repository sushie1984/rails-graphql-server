document.addEventListener("DOMContentLoaded", function(){
  mdc = window.mdc
  const textFields = [].map.call(document.querySelectorAll('.mdc-text-field'), function(el) {
    return new mdc.textField.MDCTextField(el);
  });

  const selectFields = [].map.call(document.querySelectorAll('.mdc-select'), function(el) {
    return new mdc.select.MDCSelect(el);
  });
});
