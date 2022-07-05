(() => {
  // js/live_chat/load-sw.js
  var registerServiceWorker = async () => {
    if (false) {
      try {
        const registration = await navigator.serviceWorker.register("/sw.js", {});
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
})();
//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAic291cmNlcyI6IFsiLi4vLi4vYXNzZXRzL2pzL2xpdmVfY2hhdC9sb2FkLXN3LmpzIl0sCiAgInNvdXJjZXNDb250ZW50IjogWyIvLyBDaGVjayBTZXJ2aWNlIHdvcmtlcnNcbmNvbnN0IHJlZ2lzdGVyU2VydmljZVdvcmtlciA9IGFzeW5jICgpID0+IHtcbiAgLy8gaWYgKFwic2VydmljZVdvcmtlclwiIGluIG5hdmlnYXRvcikge1xuICBpZiAoZmFsc2UpIHtcbiAgICB0cnkge1xuICAgICAgY29uc3QgcmVnaXN0cmF0aW9uID0gYXdhaXQgbmF2aWdhdG9yLnNlcnZpY2VXb3JrZXIucmVnaXN0ZXIoXG4gICAgICAgIC8vIFwiL2Fzc2V0cy9saXZlX2NoYXRfc3cuanNcIixcbiAgICAgICAgXCIvc3cuanNcIixcbiAgICAgICAge1xuICAgICAgICAgIC8vIHNjb3BlOiBcIi9saXZlL2NoYXRcIixcbiAgICAgICAgfVxuICAgICAgKTtcbiAgICAgIGlmIChyZWdpc3RyYXRpb24uaW5zdGFsbGluZykge1xuICAgICAgICBjb25zb2xlLmxvZyhcIlNlcnZpY2Ugd29ya2VyIGluc3RhbGxpbmdcIik7XG4gICAgICB9IGVsc2UgaWYgKHJlZ2lzdHJhdGlvbi53YWl0aW5nKSB7XG4gICAgICAgIGNvbnNvbGUubG9nKFwiU2VydmljZSB3b3JrZXIgd2FpdGluZ1wiKTtcbiAgICAgIH0gZWxzZSBpZiAocmVnaXN0cmF0aW9uLmFjdGl2ZSkge1xuICAgICAgICBjb25zb2xlLmxvZyhcIlNlcnZpY2Ugd29ya2VyIGFjdGl2ZVwiKTtcbiAgICAgIH1cbiAgICB9IGNhdGNoIChlKSB7XG4gICAgICBjb25zb2xlLmVycm9yKGUpO1xuICAgIH1cbiAgfVxufTtcblxud2luZG93LmFkZEV2ZW50TGlzdGVuZXIoXCJsb2FkXCIsIGFzeW5jICgpID0+IHtcbiAgYXdhaXQgcmVnaXN0ZXJTZXJ2aWNlV29ya2VyKCk7XG59KTtcbiJdLAogICJtYXBwaW5ncyI6ICI7O0FBQ0EsTUFBTSx3QkFBd0IsWUFBWTtBQUV4QyxRQUFJLE9BQU87QUFDVCxVQUFJO0FBQ0YsY0FBTSxlQUFlLE1BQU0sVUFBVSxjQUFjLFNBRWpELFVBQ0E7QUFJRixZQUFJLGFBQWEsWUFBWTtBQUMzQixrQkFBUSxJQUFJO0FBQUEsbUJBQ0gsYUFBYSxTQUFTO0FBQy9CLGtCQUFRLElBQUk7QUFBQSxtQkFDSCxhQUFhLFFBQVE7QUFDOUIsa0JBQVEsSUFBSTtBQUFBO0FBQUEsZUFFUCxHQUFQO0FBQ0EsZ0JBQVEsTUFBTTtBQUFBO0FBQUE7QUFBQTtBQUtwQixTQUFPLGlCQUFpQixRQUFRLFlBQVk7QUFDMUMsVUFBTTtBQUFBOyIsCiAgIm5hbWVzIjogW10KfQo=
