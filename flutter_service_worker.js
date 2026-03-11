'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "cf1765659774005b33a0157099f29cd3",
"assets/AssetManifest.bin.json": "dd964a601d098b30a387b37371e2a838",
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
"assets/assets/svg/academico/academic-cap-outline.svg": "a8ddfd5572789efe4d835d90eec6a0f7",
"assets/assets/svg/academico/academic-cap.svg": "ca9a5973205f2e37dffda6561efef9b6",
"assets/assets/svg/bell-alert.svg": "0ab42b36ee35b13a38eb0520c946280b",
"assets/assets/svg/bell.svg": "7850b113ce8a179a194b2a8913bd3b5e",
"assets/assets/svg/calendar-fill.svg": "2cf11581e0b178d9a768bad997daa018",
"assets/assets/svg/calendar.svg": "a88734f9c5ccdff7acf1ef5e55fb5430",
"assets/assets/svg/camera.svg": "53846baffaab0572e828608af6a96726",
"assets/assets/svg/clock.svg": "1ead9c269249e6ed15b66aa8453421a3",
"assets/assets/svg/clock_outline.svg": "f19c3bf895da72ba37226e6318cd0006",
"assets/assets/svg/codigo_verificacao.svg": "6f6a570e154090156ab604cfe84ac851",
"assets/assets/svg/compartilhar.svg": "3c2ab045c20d58eb1e601a2832de2168",
"assets/assets/svg/compartilhar_fill.svg": "1ff4ad5e9838072d560bb446e5e5bb08",
"assets/assets/svg/empty_state.svg": "0c02c2260403eff4c1c416a31c6137ca",
"assets/assets/svg/endereco.svg": "a5363412e34a41af4d092bb175b72ca8",
"assets/assets/svg/esqueceu_senha.svg": "c1b7d890c42cf8c03fee2181d718105e",
"assets/assets/svg/exclaimation-circle.svg": "da6a44d73f11f1df35e19a6edd0e57d3",
"assets/assets/svg/excluir_conta.svg": "281c0fa21a64fcf1ea63f288c7e03f78",
"assets/assets/svg/exclusao/trash.svg": "c7961d531427e7ba51847aacbcb52e69",
"assets/assets/svg/face-frown.svg": "3d3ac26ea4d112d7be65991f1cefab88",
"assets/assets/svg/face-smile.svg": "2def32a4ecb9f72743a6b52f583bc648",
"assets/assets/svg/filtro.svg": "72f7844bd322b8fd3c669ad2404f1577",
"assets/assets/svg/garota_comentando.svg": "39e2400199892ac26c824bda51335d2b",
"assets/assets/svg/garota_lendo.svg": "bda10f1e0266c5300b65910fafaee94b",
"assets/assets/svg/garota_lendo_com_oculos.svg": "1b6da8c3658e6823470afe87ad976e07",
"assets/assets/svg/garota_login.svg": "a5bdf074a4c0615dc6ec48c4937dc5b5",
"assets/assets/svg/lamp.svg": "90b5962c3f6a63c416b687dbb80057cb",
"assets/assets/svg/limpar_icon.svg": "0ecbf7b595b6d53b50f15e88fc3e60be",
"assets/assets/svg/login.svg": "a367342cde99cecc379e35b22d70c61f",
"assets/assets/svg/logout.svg": "a98e0875c6f01a35ea4afb399be5e630",
"assets/assets/svg/magnifying-glass.svg": "2ba0826c89eacfb998fb753661945abb",
"assets/assets/svg/menu/book-open.svg": "5a5268c2667a3961e8604abc3fd86e86",
"assets/assets/svg/menu/home-fill.svg": "2679c66cc8220a3f3810b72523e0fff6",
"assets/assets/svg/menu/home.svg": "623067df05cac5e57234dd9c0ed324a1",
"assets/assets/svg/menu/map-pin-fill.svg": "273b5a6db49f4ac2f5400ba87ab2127a",
"assets/assets/svg/menu/map-pin.svg": "f254fd34f1d04c0a8e55423a7fb5ba23",
"assets/assets/svg/menu/plus-circle-fill.svg": "319dfb7967261cdc165621448a5f3d90",
"assets/assets/svg/menu/plus-circle.svg": "895ecd87ffa828d629b9df2e21292a27",
"assets/assets/svg/moca_esqueceu_senha.svg": "71d3e4132c72ae656a182e61e606c2aa",
"assets/assets/svg/pessoas_com_livro.svg": "00b8006b8acd37385132fe520e64de09",
"assets/assets/svg/security.svg": "d6ab9ac815c9ba54824aab102b220d80",
"assets/assets/svg/seta/arrow-long-left.svg": "f71f4f56e4739f7dda34b1fa7ccdd218",
"assets/assets/svg/seta/arrow-long-right.svg": "7766725f193fc78f1b2177284eea4855",
"assets/assets/svg/seta/arrow-right-on-rectangle.svg": "e5e39bdfcecd2cd5802984b98ad03743",
"assets/assets/svg/seta/arrow-small-left.svg": "e79afbebecd68445235381bd358119ba",
"assets/assets/svg/seta/arrow-small-right.svg": "efa1106308f1b3b7788d4a3f4ad6f400",
"assets/assets/svg/seta/chevron-down.svg": "c80143c3d6d67d5f0dc3d2eb2aaa7783",
"assets/assets/svg/seta/chevron-left.svg": "fafa82f95d9ec5bfc4e781f54f8ecc2f",
"assets/assets/svg/seta/chevron-right.svg": "79ec13c592ff684de56f6c255a706679",
"assets/assets/svg/seta/chevron-up.svg": "7117bd89cf2f8ff073ab743d107219bb",
"assets/assets/svg/solicitacao_fim.svg": "aacb8be6a84707e564fe920fbd55555e",
"assets/assets/svg/tema/moon-outline.svg": "2c9d897042b9a6001fb1c4f1e18a0235",
"assets/assets/svg/tema/moon.svg": "86bf7fd1e58a69a391ea7f585be1cfe7",
"assets/assets/svg/tema/sun-outline.svg": "15ec8f34d2fef562383601135b637caa",
"assets/assets/svg/tema/sun.svg": "0720bf4e90be1c7cbb9aa3e34747e4ce",
"assets/assets/svg/usuario/user-circle.svg": "08722112de635cce6136c0481daf74d8",
"assets/assets/svg/usuario/user-outline.svg": "37ab4e5786e1cd70bb50b1671e7be8bf",
"assets/assets/svg/usuario/user.svg": "0ac09c8d4324715bee4c35ea5069d7fe",
"assets/FontManifest.json": "f1967de9980eb8c6da9365129247a065",
"assets/fonts/MaterialIcons-Regular.otf": "135c07ac11666f3d49c5df4997f58eae",
"assets/NOTICES": "a110ca14d665ea86497efa289fb802c0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "35edd7ae91c9e1e76d40ea3ba5ae66b4",
"assets/packages/flutter_image_compress_web/assets/pica.min.js": "6208ed6419908c4b04382adc8a3053a2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "38d7241238fe934111e7d98465291085",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "8c6cd0644b65ca0443b6d02b5aa2120e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "0d9609899c1d7ef6c1df4fcd3b8889ae",
"/": "0d9609899c1d7ef6c1df4fcd3b8889ae",
"main.dart.js": "edeb9a70e3dc72bcad64e97c50372afc",
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
