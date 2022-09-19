import * as functions from "firebase-functions";
// import * as nodemailer from "nodemailer";
import * as admin from "firebase-admin";
import * as sgMail from "@sendgrid/mail";

// set up sendgrid mail keys and template
const SENDGRID_API_KEY = functions.config().sendgrid.key;
const SENDGRID_SUCCESS_TEMPLATE = functions.config().sendgrid.successtemplate;
// eslint-disable-next-line max-len
const SENDGRID_NEW_BOOKING_TEMPLATE = functions.config().sendgrid.newbookingtemplate;

sgMail.setApiKey(SENDGRID_API_KEY);

// initialize firebase admin
admin.initializeApp();


// const mailTransport = nodemailer.createTransport({

//   service: "gmail",
//   auth: {
//     user: functions.config().gmail.email,
//     pass: functions.config().gmail.password,
//   },

// });

// const COMPANY_NAME = "Waterburg Safaris";

export const sendBookingMail = functions.firestore
    .document("/bookings/{docID}").onCreate(async (booking, context)=>{
      const mailOptions = (
          email:string,
          templateID:string,
          emailData:Record<string, unknown>) => ({

        from: "btexblacky@gmail.com",
        to: email,
        templateId: templateID,
        dynamic_template_data: emailData,
      });

      // const sendToAdmin = mailOptions("boitumelotubabwene@gmail.com",
      //     `New booking made by ${booking.data().customerDetails.fullNames}`,
      //     `New booking made\n
      //     ${booking.data().customerDetails.fullNames}
      //      has made a booking for
      //      ${booking.data().activityDetails.activityName}
      //      activity of package {{ packageName }}.\n
      //     Below is ${booking.data().customerDetails.fullNames}
      //      booking code and email
      //     ${booking.data().bookingCode}\n
      //     ${booking.data().customerDetails.email}`);

      // const sendToCustomer = mailOptions(
      //     `${booking.data().customerDetails.email}`,
      //     "Your booking was successful",
      //     `Hello ${booking.data().customerDetails.fullNames}\n
      //     You have successfully booked a
      //     ${booking.data().activityDetails.activityName}
      //      activity of package
      //      ${booking.data().activityDetails.bookedPackage.packageName} .\n

      //     Below is your booking code
      //      booking code and email
      //     ${booking.data().bookingCode}\n
      //     You can use the code if you have
      //      an inquiry or want to cancel your booking.`);

      const sendToCustomer = mailOptions(
          `${booking.data().customerDetails.email}`,
          SENDGRID_SUCCESS_TEMPLATE,
          {
            subject: "Your booking was successful",
            name: `${booking.data().customerDetails.fullNames}`,
            activity: `${booking.data().activityDetails.activityName}`,
            // eslint-disable-next-line max-len
            packageName: `${booking.data().activityDetails.bookedPackage.packageName}`,
            bookingCode: `${booking.data().bookingCode}`,
          });

      const sendToAdmin = mailOptions(
          "boitumelotubabwene@gmail.com",
          SENDGRID_NEW_BOOKING_TEMPLATE,
          {
            subject: "A new booking was made",
            customerName: `${booking.data().customerDetails.fullNames}`,
            activity: `${booking.data().activityDetails.activityName}`,
            // eslint-disable-next-line max-len
            packageName: `${booking.data().activityDetails.bookedPackage.packageName}`,
            bookingCode: `${booking.data().bookingCode}`,
            customerEmail: `${booking.data().customerDetails.email}`,
          });

      // await mailTransport.sendMail(sendToCustomer);
      // await mailTransport.sendMail(sendToAdmin);

      await sgMail.send(sendToCustomer);
      await sgMail.send(sendToAdmin);

      functions.logger.log("Mail sent to", "boitumelotubabwene@gmail.com",
          `${booking.data().customerDetails.email}`);
    });


