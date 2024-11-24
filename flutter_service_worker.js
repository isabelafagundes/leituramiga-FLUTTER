'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "71e196dd0b080fa3b92260633bd5fa10",
"assets/AssetManifest.bin.json": "5ab71ec327be9c78dd3b6c0f2aa60298",
"assets/AssetManifest.json": "797293b5ead492eddb857b9a3bef7e30",
"assets/assets/fonte/Montserrat/Montserrat-Bold.ttf": "ed86af2ed5bbaf879e9f2ec2e2eac929",
"assets/assets/fonte/Montserrat/Montserrat-ExtraBold.ttf": "9e07cac927a9b4d955e2138bf6136d6a",
"assets/assets/fonte/Montserrat/Montserrat-Light.ttf": "94fbe93542f684134cad1d775947ca92",
"assets/assets/fonte/Montserrat/Montserrat-Medium.ttf": "bdb7ba651b7bdcda6ce527b3b6705334",
"assets/assets/fonte/Montserrat/Montserrat-Regular.ttf": "5e077c15f6e1d334dd4e9be62b28ac75",
"assets/assets/fonte/Montserrat/Montserrat-SemiBold.ttf": "cc10461cb5e0a6f2621c7179f4d6de17",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-Black.ttf": "4ee31e1bdfd4b73e58b03be7235c6b13",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-BlackItalic.ttf": "7d584718a04661e4be40ae120301e87e",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-Bold.ttf": "dec15f4454da4c3dcdba85a36c9f9a37",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-BoldItalic.ttf": "b5efe009d5a7716bda810edee7b635be",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-ExtraBold.ttf": "bb1218e7fc385a9bff7b79b2b096ab09",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-ExtraBoldItalic.ttf": "4e5e038f59eb6d02e97f2302fd7ab6f4",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-ExtraLight.ttf": "e67eb5869de7de7d0daecb535dcfcda5",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-ExtraLightItalic.ttf": "bd7f18b4ce68cb013779ef54b4feb03e",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-Italic.ttf": "433b5c0bbcdc5383624d124a3030e565",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-Light.ttf": "36bcc537dc03505d47b5c6ada975cb9a",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-LightItalic.ttf": "c599ecc210027f491004096a3919f619",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-Medium.ttf": "4c61e408402414f36f5c3a06ecc5915b",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-MediumItalic.ttf": "e45349294bfd8445f86a75d6084b2126",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-Regular.ttf": "aed416691ba9afb1590d9ddf220f5996",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-SemiBold.ttf": "049fdc5014564a1f21293fe11e108bcc",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-SemiBoldItalic.ttf": "a6ee45b8654b1b1b0b5d5d46de410747",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-Thin.ttf": "851b328f969eeba7e58ae81ddc7275ad",
"assets/assets/fonte/Montserrat_Alternates/MontserratAlternates-ThinItalic.ttf": "21fc5ad34e9f724ab5bfdaf50afe55b1",
"assets/assets/png/login.png": "00310f1b316ea77fed863315aa371b61",
"assets/assets/png/pointing-right.png": "eb41ba12276aaf49205396cae4c19674",
"assets/assets/png/recuperacao_senha.png": "97c5240454c9209d0f4f4127125f121a",
"assets/assets/png/senha_recuperada.png": "09085a58790f56769079156bde4259ea",
"assets/assets/png/solicitacao.png": "d0db19c3b41d0de3668e882d630fb264",
"assets/assets/svg/academico/academic-cap-outline.svg": "776c11b0733d4231725aa4a6a76c2558",
"assets/assets/svg/academico/academic-cap.svg": "c8d433775baf56afc389149d20dd15ef",
"assets/assets/svg/bell-alert.svg": "0ab42b36ee35b13a38eb0520c946280b",
"assets/assets/svg/bell.svg": "7850b113ce8a179a194b2a8913bd3b5e",
"assets/assets/svg/calendar-fill.svg": "fb8f8f24efafe974f0c6b0e56bb2c0db",
"assets/assets/svg/calendar.svg": "54960a121798f2d13c73e2f0a7b0aae9",
"assets/assets/svg/camera.svg": "c1a33080c9f9c746a1bd76975fe15035",
"assets/assets/svg/clock.svg": "1ead9c269249e6ed15b66aa8453421a3",
"assets/assets/svg/clock_outline.svg": "f19c3bf895da72ba37226e6318cd0006",
"assets/assets/svg/codigo_verificacao.svg": "6f6a570e154090156ab604cfe84ac851",
"assets/assets/svg/compartilhar.svg": "3c2ab045c20d58eb1e601a2832de2168",
"assets/assets/svg/compartilhar_fill.svg": "1ff4ad5e9838072d560bb446e5e5bb08",
"assets/assets/svg/empty_state.svg": "b4a2c269e2e7de493db59218961bd992",
"assets/assets/svg/endereco.svg": "a5363412e34a41af4d092bb175b72ca8",
"assets/assets/svg/esqueceu_senha.svg": "b83d334012406f3eb15a3105120e4f9f",
"assets/assets/svg/exclaimation-circle.svg": "bbf6e53499b6c98473ee4dd2cd22af31",
"assets/assets/svg/exclusao/trash.svg": "2a864e9ba06f3b91f457308dfc826297",
"assets/assets/svg/face-frown.svg": "bb1ced7dfcae524d7ca28a142b1b1d05",
"assets/assets/svg/face-smile.svg": "7a517c7785d365f36e70fcd005972572",
"assets/assets/svg/filtro.svg": "50938b65e8ceface61877321b204daf2",
"assets/assets/svg/garota_comentando.svg": "39e2400199892ac26c824bda51335d2b",
"assets/assets/svg/garota_lendo.svg": "bda10f1e0266c5300b65910fafaee94b",
"assets/assets/svg/garota_lendo_com_oculos.svg": "1b6da8c3658e6823470afe87ad976e07",
"assets/assets/svg/garota_login.svg": "a5bdf074a4c0615dc6ec48c4937dc5b5",
"assets/assets/svg/lamp.svg": "9332aa287fda5fd65c4aae39387e6ab0",
"assets/assets/svg/limpar_icon.svg": "0ecbf7b595b6d53b50f15e88fc3e60be",
"assets/assets/svg/login.svg": "a367342cde99cecc379e35b22d70c61f",
"assets/assets/svg/logout.svg": "d245c79985a4116a722d2f08855210a7",
"assets/assets/svg/magnifying-glass.svg": "321ffc7d056515fac39de6b095af220d",
"assets/assets/svg/menu/book-open.svg": "331eda115b094a4344adc3764fbcd093",
"assets/assets/svg/menu/home-fill.svg": "df3901aa281085b966f719224c91e105",
"assets/assets/svg/menu/home.svg": "c20f210ab61dfd3987f4037c2635b308",
"assets/assets/svg/menu/map-pin-fill.svg": "76e66be75054f029728c28c737f8f97f",
"assets/assets/svg/menu/map-pin.svg": "52d025ff9c97283a1e87bb5a8d35d390",
"assets/assets/svg/menu/plus-circle-fill.svg": "f35a64b7b999e2f774497e1ca2c52670",
"assets/assets/svg/menu/plus-circle.svg": "f13ae465c57258650105a8b0262bf63d",
"assets/assets/svg/moca_esqueceu_senha.svg": "71d3e4132c72ae656a182e61e606c2aa",
"assets/assets/svg/pessoas_com_livro.svg": "11e192722c2bddac4b0fa4e0615d8196",
"assets/assets/svg/security.svg": "d6ab9ac815c9ba54824aab102b220d80",
"assets/assets/svg/seta/arrow-long-left.svg": "d28ea9a0490550ad105f5d0f3cb5d45f",
"assets/assets/svg/seta/arrow-long-right.svg": "b6bb7e69b4ed58c0b516f518a7e0e51d",
"assets/assets/svg/seta/arrow-right-on-rectangle.svg": "b75e0a3dfad442ff3543db6e6d19d28b",
"assets/assets/svg/seta/arrow-small-left.svg": "a7ee3bb2386f91fff336ebb087322df3",
"assets/assets/svg/seta/arrow-small-right.svg": "f4a89fc25d9bb09e53bbc7e7903bc243",
"assets/assets/svg/seta/chevron-down.svg": "744b3d74ccc8890383f0244cfecb7f2f",
"assets/assets/svg/seta/chevron-left.svg": "0b3d45c6b17303b3fe3437df0ad6e4dc",
"assets/assets/svg/seta/chevron-right.svg": "080eeded7a5050d2f6df3eb8fcf93452",
"assets/assets/svg/seta/chevron-up.svg": "eba7bf6e5429015b927c13d06c41e1b3",
"assets/assets/svg/solicitacao_fim.svg": "aacb8be6a84707e564fe920fbd55555e",
"assets/assets/svg/tema/moon-outline.svg": "73c31c57284ff6c1d49cbfa6ad6456dd",
"assets/assets/svg/tema/moon.svg": "36206c141726814899f01918b2b0d7ee",
"assets/assets/svg/tema/sun-outline.svg": "5db27e006f8d235c76d5b2522dabbdb4",
"assets/assets/svg/tema/sun.svg": "b91e7e48c5311b7b38f926e5cf015dca",
"assets/assets/svg/usuario/user-circle.svg": "f71c4089915a7be51816caea446e1dd8",
"assets/assets/svg/usuario/user-outline.svg": "c0aff51107c3bf55f64b95673775e5a3",
"assets/assets/svg/usuario/user.svg": "d2065379f44360971bcdf4612c01cc07",
"assets/FontManifest.json": "f1967de9980eb8c6da9365129247a065",
"assets/fonts/MaterialIcons-Regular.otf": "40fcf76e5aa5f2ae175d1e876df6e837",
"assets/NOTICES": "bdfc4cdff372ed40298b538bf07268ac",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "229d36864e2e7d6f615ff9fba4228cd0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "38d7241238fe934111e7d98465291085",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "6a843fa35cea2960009d5960ea191963",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "d45ff32ccebf1e66301410672f2d198e",
"/": "d45ff32ccebf1e66301410672f2d198e",
"main.dart.js": "e146229a349eb244ce89ed266f3611c9",
"manifest.json": "495bd5aa7862d4639394b0939fe8781b",
"version.json": "8d355c6876d4d5e6d5a74c5907a2f583"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}