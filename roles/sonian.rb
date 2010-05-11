name "sonian_development"
description "Recipes and attributes for sonian development"
run_list("role[basic]",
         "clojure_dev")

# build-essential
# skype
# jce export
# rabbitmq
# safe setup

# Attributes applied if the node doesn't have it set already.
#default_attributes()

# Attributes applied no matter what the node has set already.
#override_attributes()
