import { registerRoute } from "workbox-routing";
import {
  CacheFirst,
  NetworkFirst,
  StaleWhileRevalidate,
} from "workbox-strategies";
import { CacheableResponsePlugin } from "workbox-cacheable-response";
import { ExpirationPlugin } from "workbox-expiration";

// console.log("service worker");
const workboxUrl =
  "https://cdn.bootcdn.net/ajax/libs/workbox-sw/6.5.3/workbox-sw.min.js";
console.log(workboxUrl);

// importScripts(workboxUrl);

registerRoute(
  ({ request }) => request.mode == "navigate",
  new NetworkFirst({
    // put all cached files iin a cache name 'pages'
    cacheName: "pages",
    plugins: [
      new CacheableResponsePlugin({
        statuses: [200],
      }),
    ],
  })
);

registerRoute(
  ({ request }) => {
    console.log(request.destination);
    request.destination === "style" ||
      request.destination === "script" ||
      request.destination === "worker";
  },
  new StaleWhileRevalidate({
    cacheName: "assets",
    plugins: [
      new CacheableResponsePlugin({
        statuses: [200],
      }),
    ],
  })
);

registerRoute(
  ({ request }) => {
    request.destination === "image";
  },
  new CacheFirst({
    cacheName: "images",
    plugins: [
      new CacheableResponsePlugin({
        statuses: [200],
      }),
      new ExpirationPlugin({
        maxEntries: 50,
        maxAgeSeconds: 60 * 60 * 24 * 30,
      }),
    ],
  })
);

/*
workbox.routing.registerRoute(
  ({ request }) => request.mode == "navigate",
  new workbox.strategies.NetworkFirst({
    // put all cached files iin a cache name 'pages'
    cacheName: "pages",
    plugins: [
      new workbox.cacheableResponse.CacheableResponsePlugin({
        statuses: [200],
      }),
    ],
  })
);

// cache CSS JS and Web Worker requests with a Stale While Revalidate strategy

workbox.routing.registerRoute(
  ({ request }) => {
    console.log(request.destination);
    request.destination === "style" ||
      request.destination === "script" ||
      request.destination === "worker";
  },
  new workbox.strategies.StaleWhileRevalidate({
    cacheName: "assets",
    plugins: [
      new workbox.cacheableResponse.CacheableResponsePlugin({
        statuses: [200],
      }),
    ],
  })
);

// cache images

workbox.routing.registerRoute(
  ({ request }) => {
    request.destination === "image";
  },
  new workbox.strategies.CacheFirst({
    cacheName: "images",
    plugins: [
      new workbox.cacheableResponse.CacheableResponsePlugin({
        statuses: [200],
      }),
      new workbox.expiration.ExpirationPlugin({
        maxEntries: 50,
        maxAgeSeconds: 60 * 60 * 24 * 30,
      }),
    ],
  })
);
*/
