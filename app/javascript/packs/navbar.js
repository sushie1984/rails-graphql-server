document.addEventListener("DOMContentLoaded", function(){
  mdc = window.mdc
  const drawer = mdc.drawer.MDCDrawer.attachTo(document.querySelector('.mdc-drawer'));
  const menuButton = mdc.ripple.MDCRipple.attachTo(document.getElementById('menu'));
  menuButton.listen('click', () => {
      drawer.open = !drawer.open;
  });

  mdc_list_item_name = document.getElementById('mdc-drawer-navlist').value;
  const nav_list = drawer.list;
  item = nav_list.listElements.find(item => item.name == mdc_list_item_name);
  item.classList.add('mdc-list-item--activated');
});
