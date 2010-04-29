name "sonian_development"
description "Recipes and attributes for sonian development"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list("role[basic]",
         "java_dev",
         "ruby_dev",
         "clojure_dev")

# build-essential
# skype
# jce export

# Attributes applied if the node doesn't have it set already.
#default_attributes()

# Attributes applied no matter what the node has set already.
#override_attributes()
