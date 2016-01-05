# Web Search ZSH Plugin
# Inspired by oh-my-zsh

function web_search() {
    # define search engines
    typeset -A urls
    urls=(
        google      "https://www.google.com/search?q="
        duckduckgo  "https://www.duckduckgo.com/?q="
        github      "https://github.com/search?q="
        npm         "https://www.npmjs.com/search?q="
        mdnjs       "https://developer.mozilla.org/en-US/search?topic=js&q="
    )

    # check the search engine is supported
    if [[ -z "$urls[$1]" ]]; then
        echo "$1 not supported"
        return 1
    fi

    # search or go to main page depending on number of arguments passed
    if [[ $# -gt 1 ]]; then
      # build search url:
      # join arguments passed with '+', then append to search engine URL
      url="${urls[$1]}${(j:+:)@[2,-1]}"
    else
      # build main page url:
      # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
      url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
    fi

    # and run with it
    open "$url"
}

alias google="web_search google"
alias ddg="web_search duckduckgo"
alias github="web_search github"
alias npmjs="web_search npm"
alias mdnjs="web_search mdnjs"

alias images="web_search duckduckgo \!i"
alias wiki="web_search duckduckgo \!w"
alias map="web_search duckduckgo \!m"
