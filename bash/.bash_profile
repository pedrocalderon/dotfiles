#source ~/.bash_aliases
#source ~/bashConfig


#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
stty erase '^?'

alias ssh-tunnel='ssh -fN -i ~/.ssh/pedro_calderon.pem -L 9999:ds159579-a0.pfz30.fleet.mlab.com:59579 ec2-user@ec2-35-162-245-190.us-west-2.compute.amazonaws.com'
alias ssh-api-stag='ssh  -i ~/.ssh/pedro_calderon.pem ec2-user@ec2-52-41-211-14.us-west-2.compute.amazonaws.com'
alias ssh-api-prod='ssh -i ~/.ssh/pedro_calderon.pem ec2-user@ec2-35-162-245-190.us-west-2.compute.amazonaws.com'

alias edoc="cd ~/edoc/development"
