export default function SendOtp(req, res) {
  var otpVal = Math.floor(100000 + Math.random() * 100000 + 1);
  var email = req.query.email;

  // Send Email
  var mailaddress = email;
  var subject =
    "Tech Adrishta 2.5 i-Voted Login Otp ( Mail id : $_" +
    (
      Date.now().toString(36) + Math.random().toString(36).substr(2, 5)
    ).toUpperCase() +
    " )";
  var message = "Your Otp for iVoted is : " + otpVal;
  var mailOptions = {
    from: "Tech Adrishta 2.5",
    to: mailaddress,
    subject: subject,
    text: message,
  };

  var theHtml = "<h1> Your Otp for I-Voted is : " + otpVal + "</h1>";
  const fetch = require("node-fetch");

  let url = "https://api.sendinblue.com/v3/smtp/email";

  let options = {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
      "api-key": process.env.SENDINBLUE_KEY,
    },
    body:
      '{"sender":{"name":"Tech Adrishta 2.5 (i-Voted)","email":"smit.yukti.official@gmail.com"},"to":[{"email":"' +
      mailaddress +
      '","name":"' +
      mailaddress +
      '"}],"replyTo":{"email":"smit.yukti.official@gmail.com","name":"Tech Adrishta 2.5"},"subject":"' +
      subject +
      '","htmlContent":"' +
      theHtml +
      '"}',
  };

  fetch(url, options)
    .then((res) => res.json())
    .then((json) =>
      res.json({
        query: json,
        otp: otpVal,
      })
    )
    .catch((err) =>
      res.json({
        query: err,
      })
    );
}
