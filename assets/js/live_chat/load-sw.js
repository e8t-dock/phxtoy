// Check Service workers
const registerServiceWorker = async () => {
  // if ("serviceWorker" in navigator) {
  if (false) {
    try {
      const registration = await navigator.serviceWorker.register(
        // "/assets/live_chat_sw.js",
        "/sw.js",
        {
          // scope: "/live/chat",
        }
      );
      if (registration.installing) {
        console.log("Service worker installing");
      } else if (registration.waiting) {
        console.log("Service worker waiting");
      } else if (registration.active) {
        console.log("Service worker active");
      }
    } catch (e) {
      console.error(e);
    }
  }
};

window.addEventListener("load", async () => {
  await registerServiceWorker();
});
