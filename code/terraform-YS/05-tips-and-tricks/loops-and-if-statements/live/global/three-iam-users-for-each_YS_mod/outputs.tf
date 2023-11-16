#values Function values takes a map and returns a list containing the values of the elements in that map. The values are returned in lexicographical order by their corresponding keys, so the values will be returned in the same order as their keys would be returned from keys .

output "user_arns" {
  value       = values(module.users)[*].user_arn
  description = "The ARNs of the created IAM users"
}

output "user_Upper_NAMES" {
  value       = [for name in values(module.users)[*].user_name : upper(name) if length(name) < 5]
  description = "The names of the created IAM users converted to upper case"
}


output "map_output_as_list" {
  value       = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
  description = "Unwrapping the map variable"
}

#### Loop over a list and output a map
###{for <ITEM> in <LIST> : <OUTPUT_KEY> => <OUTPUT_VALUE>}
###
#### Loop over a map and output a map
###{for <KEY>, <VALUE> in <MAP> : <OUTPUT_KEY> => <OUTPUT_VALUE>}

output "map_output_as_map" {
  value       = {for name, role in var.hero_thousand_faces : "${name} is the" => "${role}"}
  description = "Unwrapping the map variable"
}

#Loops with the for String Directive

output "for_string_directive_list" {
  value = "%{ for name in var.user_names }${name}, %{ endfor }"
}

##Here the names are ordered alphabetically
output "for_string_directive_set" {
  value = "%{ for name in values(module.users)[*].user_name }${name}, %{ endfor }"
}

output "for_string_directive_index" {
  value = "%{ for i, name in var.user_names }(${i}) ${name}, %{ endfor }"
}


output "for_string_directive_index_set_if" {
  value = <<EOF
%{ for i, name in values(module.users)[*].user_name }
  ${name}%{ if i < length(values(module.users)[i].user_name) +1}, %{ endif } 
%{ endfor}
  EOF
}

output "for_string_directive_index_list_if" {
  value = <<EOF
%{ for i, name in var.user_names }
  ${name}%{ if i < length(var.user_names) +1}, %{ endif } 
%{ endfor}
  EOF
}

##Adding strip markers
output "for_string_directive_index_set_if_strip" {
  value = <<EOF
%{ for i, name in values(module.users)[*].user_name }
  ${name}%{ if i < length(values(module.users)[i].user_name) +1}, %{ endif } 
%{~ endfor ~}
  EOF
}

output "for_string_directive_index_list_if_strip" {
  value = <<EOF
%{ for i, name in var.user_names }
  ${name}%{ if i < length(var.user_names) +1}, %{ endif } 
%{~ endfor ~}
  EOF
}

##Adding strip markers and "else" statement
output "for_string_directive_index_set_if_strip_else" {
  value = <<EOF
%{ for i, name in values(module.users)[*].user_name }
  ${name}%{ if i < length(values(module.users)[i].user_name) +1}, %{ else }.%{ endif } 
%{~ endfor ~}
  EOF
}

output "for_string_directive_index_list_if_strip_else" {
  value = <<EOF
%{ for i, name in var.user_names }
  ${name}%{ if i < length(var.user_names) +1}, %{ else }.%{ endif }
%{~ endfor ~}
  EOF
}
