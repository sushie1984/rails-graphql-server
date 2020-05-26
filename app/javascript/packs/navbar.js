document.addEventListener("DOMContentLoaded", function(){
  mdc = window.mdc
  const drawer = mdc.drawer.MDCDrawer.attachTo(document.querySelector('.mdc-drawer'));
  const menuButton = mdc.ripple.MDCRipple.attachTo(document.getElementById('menu'));
  drawer.open = true;
  menuButton.listen('click', () => {
      drawer.open = !drawer.open;
  });

  drawer.listen('MDCDrawer:closed', () => {
    menu = document.getElementById('menu')
    menu.getElementsByTagName('i')[0].innerText = 'chevron_right'
  });

  drawer.listen('MDCDrawer:opened', () => {
    menu = document.getElementById('menu')
    menu.getElementsByTagName('i')[0].innerText = 'chevron_left'
  });

  hightlightNavMenuEntryOf(drawer.list);
});

function hightlightNavMenuEntryOf(list) {
  mdc_list_item_name = document.getElementById('mdc-drawer-navlist').value;
  item = list.listElements.find(item => item.name == mdc_list_item_name);
  item.classList.add('mdc-list-item--activated');
}
