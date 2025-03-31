output "alb_id" {
  value = module.my_alb.id
}

output "alb_listeners" {
  value = module.my_alb.listeners
}

output "alb_target_groups" {
  value = module.my_alb.target_groups
}

