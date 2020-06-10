## Some examples of how to secure communications with the sodium and gpg packages.
install.packages("sodium")
library("sodium")
passphrase <- "you can grow ideas in the garden of your mind"
key <- hash(charToRaw(passphrase))
secret_message <- serialize(ChickWeight, NULL)
noise <- random(24)
encrypted_text <- data_encrypt(secret_message, key, noise)

## Send to friend
saveRDS(noise, file="noise.rds");
saveRDS(encrypted_text, file="text.rds");
library("gmailr");
gm_auth_configure(path="client_secret.json");
msg_subject <- "Encrypted Data";
msg_from <- "Jon Westfall <doctorwestfall@gmail.com>";
msg_to <- "Another Jon Westfall <jon@jonwestfall.com>";
msg_body <- "See the data attached";
email_msg <- gm_mime() %>%
  gm_to(msg_to) %>%
  gm_from(msg_from) %>%
  gm_subject(msg_subject) %>%
  gm_html_body(msg_body) %>%
  gm_attach_file("noise.rds") %>%
  gm_attach_file("text.rds")

gm_send_message(email_msg)


## Friend Receives and runs
library("sodium")
noise <- readRDS(file="noise.rds")
encrypted_text <- readRDS(file="text.rds")
passphrase <- "you can grow ideas in the garden of your mind"
key <- hash(charToRaw(passphrase))
data <- unserialize(data_decrypt(encrypted_text,key,noise))


# How to encrypt/decrypt using GPG

install.packages("gpg")
library("gpg")
my_key <- gpg_keygen(name = "Testy McTestperson", email="doctorwestfall@gmail.com")
public_key <- gpg_export(id = my_key)
library("gmailr");
gm_auth_configure(path="client_secret.json");
msg_subject <- "My Public Key";
msg_from <- "Jon Westfall <doctorwestfall@gmail.com>";
msg_to <- "Another Jon Westfall <jon@jonwestfall.com>";
msg_body <- paste("You can use the public key below to communicate with me: ", public_key);

email_msg <- gm_mime() %>%
  gm_to(msg_to) %>%
  gm_from(msg_from) %>%
  gm_subject(msg_subject) %>%
  gm_html_body(msg_body)

gm_send_message(email_msg)

## Encrypting this R file and sending it to Jon.
library("gpg")
jon <- "F97D7D4A348AE209B0FE5B201396233294A0EFA4"
gpg_recv(jon)
library("gmailr");
gm_auth_configure(path="client_secret.json");
msg_subject <- "Encrypted Message";
msg_from <- "Jon Westfall <doctorwestfall@gmail.com>";
msg_to <- "Another Jon Westfall <jon@jonwestfall.com>";
msg_body <- gpg_encrypt("secure-communications.R",receiver=jon)
email_msg <- gm_mime() %>%
  gm_to(msg_to) %>%
  gm_from(msg_from) %>%
  gm_subject(msg_subject) %>%
  gm_html_body(msg_body)
gm_send_message(email_msg)
