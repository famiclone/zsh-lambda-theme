#!/bin/zsh

autoload -U colors && colors

function git_branch {
  branch=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ $? -eq 0 ]; then
    echo "%{$fg[green]%}$branch"
  fi
}

function git_status {
  st=$(git status --porcelain 2> /dev/null)
  if [ -n "$st" ]; then
    echo "*"
  fi
}

function venv_status {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv_name=$(basename "$VIRTUAL_ENV")
    echo "%{$fg[red]%}($venv_name) "
  fi
}

function set_prompt {
  PROMPT="%{$fg[bold]%}%{$bg[yellow]%}%{$fg[black]%}(λ)%{$reset_color%} %~/ $(venv_status)$(git_branch)$(git_status)%{$reset_color%} "
}

precmd_functions+=( set_prompt )
