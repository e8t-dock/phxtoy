// require alpinejs
// import "alpinejs";

import Alpine from "alpinejs";
if (!window.Alpine) {
  window.Alpine = Alpine;
}

Alpine.store("tabs", {
  current: "London",
  setTab(value) {
    this.current = value;
  },
});

Alpine.start();
