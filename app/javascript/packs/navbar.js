document.addEventListener("DOMContentLoaded", function(){
  mdc = window.mdc
  const drawer = mdc.drawer.MDCDrawer.attachTo(document.querySelector('.mdc-drawer'));
  const menuButton = mdc.ripple.MDCRipple.attachTo(document.getElementById('menu'))
  menuButton.listen('click', () => {
      drawer.open = !drawer.open;
  });
});
