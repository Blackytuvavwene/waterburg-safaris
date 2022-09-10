import * as functions from "firebase-functions";
import * as nodemailer from "nodemailer";
import * as admin from "firebase-admin";
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


// firestore database
// const db = admin.firestore();

// initialize firebase admin
admin.initializeApp();


const mailTransport = nodemailer.createTransport({

  service: "gmail",
  auth: {
    user: functions.config().gmail.email,
    pass: functions.config().gmail.password,
  },

});

const COMPANY_NAME = "Waterburg Safaris";

export const sendBookingMail = functions.firestore
    .document("/bookings/{docID}").onCreate(async (booking, context)=>{
      const mailOptions = (email:string, subject:string, text:string) => ({

        from: `${COMPANY_NAME} <noreply@firebase.com>`,
        to: email,
        subject: subject,
        text: text,

      });

      const sendToAdmin = mailOptions("boitumelotubabwene@gmail.com",
          `New booking made by ${booking.data().customerDetails.fullNames}`,
          `New booking made\n
          ${booking.data().customerDetails.fullNames}
           has made a booking for 
           ${booking.data().activityDetails.activityName} 
           activity of package {{ packageName }}.\n
          Below is ${booking.data().customerDetails.fullNames}
           booking code and email
          ${booking.data().bookingCode}\n
          ${booking.data().customerDetails.email}`);

      const sendToCustomer = mailOptions(
          `${booking.data().customerDetails.email}`,
          "Your booking was successful",
          `Hello ${booking.data().customerDetails.fullNames}\n
          You have successfully booked a
          ${booking.data().activityDetails.activityName} 
           activity of package 
           ${booking.data().activityDetails.bookedPackage.packageName} .\n
          
          Below is your booking code
           booking code and email
          ${booking.data().bookingCode}\n
          You can use the code if you have
           an inquiry or want to cancel your booking.`);

      await mailTransport.sendMail(sendToCustomer);
      await mailTransport.sendMail(sendToAdmin);

      functions.logger.log("Mail sent to", "boitumelotubabwene@gmail.com",
          `${booking.data().customerDetails.email}`);
    });


