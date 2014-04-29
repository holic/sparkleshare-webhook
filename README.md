# SparkleShare - now with webhooks! :sparkle:

I found that while [SparkleShare](http://sparkleshare.org/) supports [notifications](https://github.com/hbons/SparkleShare/wiki/Notification-service), only a [git post-update hook](https://github.com/hbons/sparkleshare-git-hook/blob/master/post-update) is offered.

This project changes that!

Now you can automagically notify your SparkleShare project of new changes via GitHub webhook.

### Install

1. Navigate to your SparkleShare project's GitHub repo's settings.
2. Click "Webhooks & Services".
3. Click "Add webhook".
4. Fill in for the "Payload URL" the following:

   `https://sparkleshare-webhook.herokuapp.com/github/1e854c126a7c7d823c609928bf7384872db431bb`

   Replace the `1e854c126a7c7d823c609928bf7384872db431bb` with your project's hash located in the project root's `.sparkleshare` file.

   *Optionally* use your own notification server in the URL:

   `https://sparkleshare-webhook.herokuapp.com/github/example.com:443/1e854c126a7c7d823c609928bf7384872db431bb`

   **Note:** The hostname and port are required, otherwise they will default to SparkleShare's public notification server at `notifications.sparkleshare.org:443`.

5. Leave all other settings to their defaults.

   *Optionally* turn on JSON payloads.

6. Click "Add webhook" to test and add the webhook.
7. `git push` to your repo and watch SparkleShare update automagically! :sparkles:
