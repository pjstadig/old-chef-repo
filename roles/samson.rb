name "samson"
description "Recipies and attributes specific to samson"
run_list("role[basic]",
         "role[sonian]",
         "java_dev",
         "ruby_dev",
         "gobi_2000")

# Attributes applied if the node doesn't have it set already.
#default_attributes()

# Attributes applied no matter what the node has set already.
#override_attributes()
