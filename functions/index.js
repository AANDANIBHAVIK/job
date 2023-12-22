/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");

const admin = require("firebase-admin");
const {
  parse,
  isBefore,
  isAfter,
  isEqual,
  startOfDay,
  addDays,
  format,
} = require("date-fns");

admin.initializeApp();
var msgData;

exports.notifyEveryDay = functions.pubsub
  .schedule("0 8 * * *")
  .onRun((context) => {
    admin
      .firestore()
      .collection("Order")
      .where("paymentStatus", "==", "Pending")
      .get()
      .then((snapshots) => {
        console.log("---------------------->> : Hello");

        if (snapshots.empty) {
          console.log("-------No Devices Found");
        } else {
          for (var orderData of snapshots.docs) {
            const deliveryDate = orderData.data().deliveryDate;

            console.log(`---- delhivery ${deliveryDate} `);

            const targetDateStr = deliveryDate;
            const targetDate = parse(targetDateStr, "dd-MM-yyyy", new Date());

            console.log(`---- target date : ${targetDate} `);

            const futureDate = addDays(targetDate, 15);
            console.log(`---- future ${futureDate} `);

            const currentDate = new Date();

            const startOfCurrentDate = startOfDay(currentDate);

            if (isAfter(futureDate, startOfCurrentDate)) {
              admin
                .firestore()
                .collection("tokens")
                .get()
                .then((snapshots) => {
                  var tokens = [];
                  if (snapshots.empty) {
                    console.log("-------No Devices Found");
                  } else {
                    for (var pushTokens of snapshots.docs) {
                      tokens.push(pushTokens.data().token);
                    }
                    console.log(tokens);

                    var payload = {
                      notification: {
                        title: "Payment Is Pending",
                        body:
                          "No : " +
                          orderData.data().jobNo +
                          ",  Name : " +
                          orderData.data().partyName,
                        sound: "default",
                      },
                    };

                    return admin
                      .messaging()
                      .sendToDevice(tokens, payload)
                      .then((response) => {
                        console.log(
                          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   pushed them all"
                        );
                      })
                      .catch((err) => {
                        console.log(
                          "---------------------------------------------------Fail pushed them all"
                        );

                        console.log(err);
                      });
                  }
                });
            }

            tokens.push(orderData.data().paymentStatus);
          }
          console.log("-------Tokend  Found : ${tokens}");
          console.log(tokens);
        }
        console.log("---------------------->> : Hello");
      });
  });

exports.orderMsg = functions.firestore
  .document("Order/{OrderID}")
  .onCreate((snapshot, context) => {
    msgData = snapshot.data();

    admin
      .firestore()
      .collection("tokens")
      .get()
      .then((snapshots) => {
        var tokens = [];
        if (snapshots.empty) {
          console.log("-------No Devices Found");
        } else {
          for (var pushTokens of snapshots.docs) {
            tokens.push(pushTokens.data().token);
          }
          console.log("-------Tokend  Found : ${tokens}");
          console.log(tokens);

          var payload = {
            notification: {
              title: "New Order Added!✔",
              body: "No : " + msgData.jobNo + ",  Name : " + msgData.partyName,
              sound: "default",
            },
          };

          return admin
            .messaging()
            .sendToDevice(tokens, payload)
            .then((response) => {
              console.log("pushed them all");
            })
            .catch((err) => {
              console.log(
                "---------------------------------------------------pushed them all"
              );

              console.log(err);
            });
        }
      });
  });