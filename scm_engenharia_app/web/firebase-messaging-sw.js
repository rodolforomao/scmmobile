importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
   apiKey: "AIzaSyB2lk4kC3U_jU2ocs3HKDFQOrVAHOCfEEA",
   authDomain: "app-scm.firebaseapp.com",
   projectId: "app-scm",
   storageBucket: "app-scm.appspot.com",
   messagingSenderId: "903936319018",
   appId: "1:903936319018:web:f596a0554cced492186d53",
   measurementId: "G-HJEEHSGB56"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});