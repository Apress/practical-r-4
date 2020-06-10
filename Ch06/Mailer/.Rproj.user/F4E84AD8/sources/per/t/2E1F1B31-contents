### Let's send our first message with Gmail
# Install Packages (If you have not already)
install.packages("gmailr");

# Load Packages
library("gmailr");

# Specify Gmail Credentials.
gm_auth_configure(path="client_secret.json");

# Set up email

msg_subject <- "This is the second email I've sent.";
msg_from <- "Jon Westfall <doctorwestfall@gmail.com>";
msg_to <- "Another Jon Westfall <jon@jonwestfall.com>";
msg_body <- "<html>There is no attachment in this email. You already got the file in the last one!</html>";

# Form it into a Gmail Mime Object
# We're going to attach this R file as well, to show you how to attach files.

email_msg <- gm_mime() %>%
  gm_to(msg_to) %>%
  gm_from(msg_from) %>%
  gm_subject(msg_subject) %>%
  gm_html_body(msg_body)

gm_send_message(email_msg)
