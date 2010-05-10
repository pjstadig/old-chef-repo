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

# brackup
# video/audio codecs
# pidgin?
# vlc
# sun virtual box
# adobe reader?
# dropbox

# Attributes applied if the node doesn't have it set already.
#default_attributes()

# Attributes applied no matter what the node has set already.
#override_attributes()
