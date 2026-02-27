'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "a3c5c9fd613aa3a989ba1848139363ac",
"version.json": "7dd8c5458979d17a79c9edbd865392b2",
"index.html": "5cfbe0644dfcffd762f09f00047bba79",
"/": "5cfbe0644dfcffd762f09f00047bba79",
"main.dart.js": "fab251dc49e7d4fe489caf6926651d13",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "9468677dc3e0aa638650158e583799d1",
"assets/AssetManifest.json": "0651c929681e6c1c885cce382d771aa9",
"assets/NOTICES": "a07b5d690fbfe6719a37a30ff5158bdb",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "91e004ca554afa2f7c2f893aed3fc97f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "ca914e2656646682667e9eb56527465a",
"assets/fonts/MaterialIcons-Regular.otf": "5628c2c08a85230f7bfa6937b0dce8e2",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-27%202.jpg": "fab6ab78c12087d60e157de06325f2fe",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-59%204.jpg": "d55339ea9db97014a8118d12f31527e1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-35.jpg": "b070a34c269dd17d8cea635a5ff63bd7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-21.jpg": "4a5ad0fe89b2efa1b6b1a2883b852a63",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-86%203.jpg": "4a80bee0077be62afa52e43bd41f2833",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-114%202.jpg": "fbb87df120d5d0e42e64ba0633b1a750",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-111.jpg": "755d3a987fc8e27579866e5dd53ac111",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-105.jpg": "c7931617c2cf33a7b9c5081f1c7a2b2b",
"assets/assets/Images/WhatsApp%2520Image%25202026-01-27%2520at%252021.47.49.jpeg": "17c0e577f208f6f7dc41369729f97eea",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-104.jpg": "67a6d35d5f350a857de711861f06684d",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-110.jpg": "23f5829700c634231a2445a6f64ab8a0",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-86%202.jpg": "4a80bee0077be62afa52e43bd41f2833",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-20.jpg": "b9a08e14864b7089f47ab6c0aec73a1a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-34.jpg": "e84777738a9c82476947fb71fb254189",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-46%202.jpg": "ad5ce23503590dafd1acfb0d0fedf547",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-44%202.jpg": "0ae7dc0f1b4009c4f28ea84275803ede",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-22.jpg": "4248c899b9a01b8742c69d0818fb6a28",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-36.jpg": "d3f7c873a66ef80109fce1007dc16acd",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-106.jpg": "ac8dbd26ac5c005bc64ebdbe181474c4",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-18%203.jpg": "dd1be3f23643c1ef78400be6fbfd018e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-112.jpg": "a5af9d2335e94dc55128c4374328da3c",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-84%202.jpg": "4f7934ee57d1376db73651f5b8d786bf",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-79%202.jpg": "a03b2718d19a64516c2377f9ec94c150",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-8%202.jpg": "2a1b02fb97a2f2a06fc82b92686e093c",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-79%203.jpg": "a03b2718d19a64516c2377f9ec94c150",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-84%203.jpg": "4f7934ee57d1376db73651f5b8d786bf",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-116%202.jpg": "3e8ac1dfdaf02f9aaa54056d00f89ad5",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-18%202.jpg": "dd1be3f23643c1ef78400be6fbfd018e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-113.jpg": "bd5b85d03a109dca1dd209db00e54c55",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-107.jpg": "83df500ffe097cb4e0efe89675672b5e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-37.jpg": "4397ada4614b75755a0a2017a5127f07",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-23.jpg": "84c39f31338f9b88fe49250f1c7ee1a7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-25%202.jpg": "34ca1627b11240ea6ddbb000428642df",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-44%203.jpg": "0ae7dc0f1b4009c4f28ea84275803ede",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-59%202.jpg": "d55339ea9db97014a8118d12f31527e1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-112%202.jpg": "a5af9d2335e94dc55128c4374328da3c",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-27.jpg": "fab6ab78c12087d60e157de06325f2fe",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-33.jpg": "3f74889268a61c6c3e1ca304e4f5f692",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-103.jpg": "dfee0fb67695b884362a9bbd94a2b2ab",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-117.jpg": "29c79db8151ff2222039684d55dedafa",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-64%202.jpg": "36a051b5a6a04b073f9e4224244393d4",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-116.jpg": "3e8ac1dfdaf02f9aaa54056d00f89ad5",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-102.jpg": "cf90d722d187fc4186cf3ea7572c83ff",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-40%202.jpg": "5b2c98c0307ceddc8a2f39f1c60504cd",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-32.jpg": "33a61eba9040359713118d7820fd2b40",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-26.jpg": "e62238641887eae8d3973ecbd1f8462b",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-86%204.jpg": "4a80bee0077be62afa52e43bd41f2833",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-59%203.jpg": "d55339ea9db97014a8118d12f31527e1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-82%202.jpg": "09a4b92ca1cbe11bad182e993523ab81",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-18.jpg": "dd1be3f23643c1ef78400be6fbfd018e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-30.jpg": "10290074b1b7bc89fe7dad83970f013e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-24.jpg": "d7e36ce768b87590098fe85375722c73",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-109%202.jpg": "67789bdcf37ad5e580b1f2a436c194c9",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-114.jpg": "fbb87df120d5d0e42e64ba0633b1a750",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-100.jpg": "1faeb04d93e53066914f831cafe5ff32",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-101.jpg": "c2139524e53ac8e050328495925e2fcc",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-115.jpg": "030106141c2f15a6a74eba165e1c67d7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-23%202.jpg": "84c39f31338f9b88fe49250f1c7ee1a7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-25.jpg": "34ca1627b11240ea6ddbb000428642df",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-31.jpg": "b10522ee5c0232bdba4571330a24344a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-19.jpg": "6da9cd2f30a04c66242cbc5acd9e1dff",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-82%203.jpg": "09a4b92ca1cbe11bad182e993523ab81",
"assets/assets/Images/WhatsApp%2520Image%25202026-01-27%2520at%252021.47.49%2520(2).jpeg": "4889c1b88905722d782b346a4c5f07f7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-85%202.jpg": "951e44fa817bf42672c065642ace5d58",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-78%202.jpg": "8d073e73809946a30c45944ff16b88bd",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-9%202.jpg": "c0a36d5ae5b1c052f773c8d13b352cc7",
"assets/assets/Images/WhatsApp%2520Image%25202026-01-27%2520at%252021.47.49%2520(3)%202.jpeg": "17c0e577f208f6f7dc41369729f97eea",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-56.jpg": "38cad4a8a20c0612596f20203e3d753a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-24%203.jpg": "d7e36ce768b87590098fe85375722c73",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-61%203.jpg": "e3974d77e28f3bbce7f4622ce34ffc48",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-42.jpg": "23480238005ba8960602dbb982a1dc3a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-95.jpg": "ee8597dbf663ec7c1f752fd95e285ff4",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-81.jpg": "ef5f43df0b0d5c2567cbf11bb9968a3e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-45%202.jpg": "f297585737002ef3901e5f99fd57109a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-45%203.jpg": "f297585737002ef3901e5f99fd57109a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-80.jpg": "8afccf51017de4a2489d79f58bef7a5d",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-94.jpg": "fa9bf241b147d958a387f27c956cab19",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-24%202.jpg": "d7e36ce768b87590098fe85375722c73",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-43.jpg": "06e0bcc0ad25a61664d337b56904624c",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-61%202.jpg": "e3974d77e28f3bbce7f4622ce34ffc48",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-57.jpg": "14e3fb7d2fdee55ab95e87936c826841",
"assets/assets/Images/WhatsApp%2520Image%25202026-01-27%2520at%252021.47.49%202.jpeg": "17c0e577f208f6f7dc41369729f97eea",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-19%202.jpg": "6da9cd2f30a04c66242cbc5acd9e1dff",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-78%203.jpg": "8d073e73809946a30c45944ff16b88bd",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-8.jpg": "2a1b02fb97a2f2a06fc82b92686e093c",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-115%202.jpg": "030106141c2f15a6a74eba165e1c67d7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-41.jpg": "421e0422ae1527847457708ef03093f1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-55.jpg": "07242c736e725be10b39f5fc5eab9bb7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-69.jpg": "88c0f2fd96bcd0b2d63d6de51d3ec0ae",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-82.jpg": "09a4b92ca1cbe11bad182e993523ab81",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-96.jpg": "693f3fbcf83a1a6b59fb6e04542ed167",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-63%202.jpg": "898ede0ec4b6d3a4f5efbfbdc862901a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-97.jpg": "3d95513959b6094d1e852184c880d965",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-83.jpg": "3da240e5075c29e6e6fc8b2aea941ceb",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-68.jpg": "e6c4b93e85e693b87f07f7ea154437ee",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-81%204.jpg": "ef5f43df0b0d5c2567cbf11bb9968a3e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-54.jpg": "b5aec2f7b72499033e142f46e7d1207c",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-47%202.jpg": "32df8d45705961ccef6b1b8468144b84",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-40.jpg": "5b2c98c0307ceddc8a2f39f1c60504cd",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-115%203.jpg": "030106141c2f15a6a74eba165e1c67d7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-9.jpg": "c0a36d5ae5b1c052f773c8d13b352cc7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-43%202.jpg": "06e0bcc0ad25a61664d337b56904624c",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-22%203.jpg": "4248c899b9a01b8742c69d0818fb6a28",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-108%202.jpg": "deec0d3f5f2490acd0e8cd980b13f446",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-78.jpg": "8d073e73809946a30c45944ff16b88bd",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-44.jpg": "0ae7dc0f1b4009c4f28ea84275803ede",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-50.jpg": "959267dbeda45193ab63d5008e00ee34",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-87.jpg": "7903a845c4c6303e3fc87ea0f37efa62",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-93.jpg": "bdb0f7eee585ead935ea452105c4901e",
"assets/assets/Images/WhatsApp%2520Image%25202026-01-27%2520at%252021.47.49%2520(3).jpeg": "17c0e577f208f6f7dc41369729f97eea",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-111%202.jpg": "755d3a987fc8e27579866e5dd53ac111",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-92.jpg": "7a6f5f83f70804a92ff3a998de69263d",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-86.jpg": "4a80bee0077be62afa52e43bd41f2833",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-51.jpg": "2c5db8ca9a8214f874f2321c4b6dd18a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-45.jpg": "f297585737002ef3901e5f99fd57109a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-79.jpg": "a03b2718d19a64516c2377f9ec94c150",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-22%202.jpg": "4248c899b9a01b8742c69d0818fb6a28",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-43%203.jpg": "06e0bcc0ad25a61664d337b56904624c",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-20%202.jpg": "b9a08e14864b7089f47ab6c0aec73a1a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-65%202.jpg": "62f1448448831b217ba98ef28da50588",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-98%202.jpg": "ec4e8c2d04289293d033f28a2d60887f",
"assets/assets/Images/WhatsApp%2520Image%25202026-01-27%2520at%252021.47.49%2520(2)%202.jpeg": "4889c1b88905722d782b346a4c5f07f7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-81%203.jpg": "ef5f43df0b0d5c2567cbf11bb9968a3e",
"assets/assets/Images/WhatsApp%2520Image%25202026-01-27%2520at%252021.47.49%2520(1).jpeg": "0d1808689d1633360de6104a317ab924",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-53.jpg": "345c21289fc38e8c53ed986690d821a9",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-47.jpg": "32df8d45705961ccef6b1b8468144b84",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-90.jpg": "0b20eabb498b9d4ec2234b1ad1ca4cfc",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-84.jpg": "4f7934ee57d1376db73651f5b8d786bf",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-85.jpg": "951e44fa817bf42672c065642ace5d58",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-39%202.jpg": "1fd96aa9c63fa69d0cb73014ecc4e4ad",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-91.jpg": "e94909114d4f83f1cd767a02d7bf54c5",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-46.jpg": "ad5ce23503590dafd1acfb0d0fedf547",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-52.jpg": "f2e0264e54e73c208610223c1e2d0ff8",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-81%202.jpg": "ef5f43df0b0d5c2567cbf11bb9968a3e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-2.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-69%203.jpg": "88c0f2fd96bcd0b2d63d6de51d3ec0ae",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-77.jpg": "9653d02b23371a7b3c820c2a45a807ff",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-63.jpg": "898ede0ec4b6d3a4f5efbfbdc862901a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-88.jpg": "abe1af6316b8d81cdf74f88912e3987e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-1%202.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-70%202.jpg": "2593084c20a1210288601b351bba6b38",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-35%202.jpg": "b070a34c269dd17d8cea635a5ff63bd7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-35%203.jpg": "b070a34c269dd17d8cea635a5ff63bd7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-89.jpg": "3c733085967589d96a7eadca4ae40855",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-62.jpg": "80b45ab6c94bbfb744c13d7dcc2f903a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-76.jpg": "35c244c57a905b4e98054ef4891959db",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-69%202.jpg": "88c0f2fd96bcd0b2d63d6de51d3ec0ae",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-94%202.jpg": "fa9bf241b147d958a387f27c956cab19",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-3.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-96%202.jpg": "693f3fbcf83a1a6b59fb6e04542ed167",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-1.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-120%202.jpg": "8d0d3ff038891ee4b29138afc5b5d39e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-60.jpg": "72bdaac4750b933bb23da7dcd28d0152",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-74.jpg": "552f8b1e9b62720c3f2fbb7e2af1504f",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-48.jpg": "caa5ace4a47da0f8d1f07652666113ff",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-49.jpg": "1db25b1176075c9af84b9be5b6fbb2c4",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-37%202.jpg": "4397ada4614b75755a0a2017a5127f07",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-75.jpg": "390102140672102fa3313b0b04c63e46",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-61.jpg": "e3974d77e28f3bbce7f4622ce34ffc48",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-3%202.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/logo.jpg": "b85daa725b41ffe5bb2a677411b7845d",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-120%203.jpg": "8d0d3ff038891ee4b29138afc5b5d39e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-96%203.jpg": "693f3fbcf83a1a6b59fb6e04542ed167",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-4.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-33%202.jpg": "3f74889268a61c6c3e1ca304e4f5f692",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-7%202.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-119%203.jpg": "4ad0b35a7d026fbd1c1e0fe39ef2e783",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-52%203.jpg": "f2e0264e54e73c208610223c1e2d0ff8",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-59.jpg": "d55339ea9db97014a8118d12f31527e1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-100%202.jpg": "1faeb04d93e53066914f831cafe5ff32",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-65.jpg": "62f1448448831b217ba98ef28da50588",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-71.jpg": "7f4e73a7d3ccb778f02cd861824b4173",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-70.jpg": "2593084c20a1210288601b351bba6b38",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-64.jpg": "36a051b5a6a04b073f9e4224244393d4",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-58.jpg": "5a8c920a3ea6c44f7cce1db7dd82ee4b",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-52%202.jpg": "f2e0264e54e73c208610223c1e2d0ff8",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-17%202.jpg": "71cd5d1725d46d669d9c99c38654705e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-119%202.jpg": "4ad0b35a7d026fbd1c1e0fe39ef2e783",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-5.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-33%203.jpg": "3f74889268a61c6c3e1ca304e4f5f692",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-7.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-50%202.jpg": "959267dbeda45193ab63d5008e00ee34",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-31%203.jpg": "b10522ee5c0232bdba4571330a24344a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-72.jpg": "e4850fd02215d613cb478939bb488018",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-66.jpg": "7cdf25f597fbb73ee8f1605862f6ff2e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-99.jpg": "37c816f818b92382c35e20afb9485e2f",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-90%202.jpg": "0b20eabb498b9d4ec2234b1ad1ca4cfc",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-102%203.jpg": "cf90d722d187fc4186cf3ea7572c83ff",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-102%202.jpg": "cf90d722d187fc4186cf3ea7572c83ff",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-98.jpg": "ec4e8c2d04289293d033f28a2d60887f",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-67.jpg": "f1fa52e37a66dc501662aafd0ecf5d27",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-73.jpg": "b78b5f772e5762b33b3673e2c75a2607",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-5%202.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-74%202.jpg": "552f8b1e9b62720c3f2fbb7e2af1504f",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-31%202.jpg": "b10522ee5c0232bdba4571330a24344a",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-50%203.jpg": "959267dbeda45193ab63d5008e00ee34",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-6.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-57%202.jpg": "14e3fb7d2fdee55ab95e87936c826841",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-36%203.jpg": "d3f7c873a66ef80109fce1007dc16acd",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-14.jpg": "23d998e49330cab29c51351e70a165b7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-28.jpg": "99afd9e834861333160bc7034615b269",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-118.jpg": "ad64af1045a502f4d13e0b4accbad438",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-97%202.jpg": "3d95513959b6094d1e852184c880d965",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-97%203.jpg": "3d95513959b6094d1e852184c880d965",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-119.jpg": "4ad0b35a7d026fbd1c1e0fe39ef2e783",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-29.jpg": "463c966733a7c15a7857862735979ef6",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-15.jpg": "eff16659101af99139ce9a1835ce9238",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-36%202.jpg": "d3f7c873a66ef80109fce1007dc16acd",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-2%202.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-34%202.jpg": "e84777738a9c82476947fb71fb254189",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-71%202.jpg": "7f4e73a7d3ccb778f02cd861824b4173",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-55%203.jpg": "07242c736e725be10b39f5fc5eab9bb7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-17.jpg": "71cd5d1725d46d669d9c99c38654705e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-16.jpg": "04bc54fe69768344ec005edc0facca63",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-95%202.jpg": "ee8597dbf663ec7c1f752fd95e285ff4",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-10%202.jpg": "cea3adab70e59b789207c15fe6b4b70e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-55%202.jpg": "07242c736e725be10b39f5fc5eab9bb7",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-34%203.jpg": "e84777738a9c82476947fb71fb254189",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-71%203.jpg": "7f4e73a7d3ccb778f02cd861824b4173",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-91%202.jpg": "e94909114d4f83f1cd767a02d7bf54c5",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-29%202.jpg": "463c966733a7c15a7857862735979ef6",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-30%203.jpg": "10290074b1b7bc89fe7dad83970f013e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-12.jpg": "52e672717d462d7a851f69ced79a918e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-88%202.jpg": "abe1af6316b8d81cdf74f88912e3987e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-13.jpg": "65d5cce6fb7c1346ece62e5ed6e694e8",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-4%202.jpg": "2252394433045e584530b1dd6665ffb1",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-30%202.jpg": "10290074b1b7bc89fe7dad83970f013e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-39.jpg": "1fd96aa9c63fa69d0cb73014ecc4e4ad",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-11.jpg": "a6d82d79ef12056c3a9cbb75aef356c0",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-109.jpg": "67789bdcf37ad5e580b1f2a436c194c9",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-32%202.jpg": "33a61eba9040359713118d7820fd2b40",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-77%202.jpg": "9653d02b23371a7b3c820c2a45a807ff",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-118%202.jpg": "ad64af1045a502f4d13e0b4accbad438",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-120.jpg": "8d0d3ff038891ee4b29138afc5b5d39e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-108.jpg": "deec0d3f5f2490acd0e8cd980b13f446",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-10.jpg": "cea3adab70e59b789207c15fe6b4b70e",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-38.jpg": "ff0162ca71bbce0ca315513b54113f4b",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-53%202.jpg": "345c21289fc38e8c53ed986690d821a9",
"assets/assets/Images/1%2520ENGLISH%2520CARD%2520VERSION-images-55%204.jpg": "07242c736e725be10b39f5fc5eab9bb7",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
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
