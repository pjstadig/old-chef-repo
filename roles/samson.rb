name "samson"
description "Recipies and attributes specific to samson"
run_list("role[basic]",
         "role[sonian]",
         "java_dev",
         "ruby_dev",
         "gobi_2000")
