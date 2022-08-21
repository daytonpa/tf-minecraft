locals {
  os_name = var.os_name
  os_version = var.os_version
  snapshot_search_string = var.minecraft_server_search_string

  timestamp = formatdate("YYYY-MM-DD-hh-mm-ss")
}