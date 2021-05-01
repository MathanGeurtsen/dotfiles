function ssh-setup {
  eval $(ssh-agent)
  ssh-add ~/.ssh/github
}
