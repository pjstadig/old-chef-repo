name "basic"
description "Basic recipes and attributes"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list("ubuntu",
         "google_chrome",
         "cups_pdf",
         "flash",
         "keybox",
         "java_plugin",
         "codecs")

# gpg-agent
# brother printer drivers
# brother scanner drivers
# dropbox
# sun virtual box
# brackup
# vlc
# pidgin?
# adobe reader?

# Attributes applied if the node doesn't have it set already.
#default_attributes()

# Attributes applied no matter what the node has set already.
#override_attributes()
