source $ZSH/oh-my-zsh.sh

alias espacio='du -ksh *'
alias refreshalias='source ~/.bash_profile'
alias httpserver='python -m SimpleHTTPServer 8000'
alias wgettest='wget http://sftp.fibertel.com.ar/services/file-1GB.img'
alias decir='say -v juan'
alias servir='php -S 127.0.0.1:8000'
alias workon='brew services start mysql@5.7 && brew services start httpd && brew services start redis'
alias workoff='brew services stop mysql@5.7 && brew services stop httpd && brew services stop redis'
alias sqlstart='brew services start mysql@5.7'
alias sqlstop='brew services stop mysql@5.7'
alias zshreload="source ~/.zshrc"
#alias tailMongoLog="tail -f /usr/local/var/log/mongodb/mongo.log"
alias cuantoocupa="du -shc *"
ZSH_THEME="agnoster"

POWERLEVEL9K_MODE="awesome-patched"
#ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  bundler
  dotenv
  osx
  rake
  rbenv
  ruby
)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


cchmod(){

echo "+1 if the class can execute the file."
echo "+2 if the class can write to the file."
echo "+4 if the class can read the file."
echo ""
echo "In other words, the meaning of each digit value ends up being:"
echo "0: No permission"
echo "1: Execute"
echo "2: Write"
echo "3: Write and execute"
echo "4: Read"
echo "5: Read and execute"
echo "6: Read and write"
echo "7: Read, write, and execute"
}
export PATH="/usr/local/opt/php@7.3/bin:$PATH"
export PATH="/usr/local/opt/php@7.3/sbin:$PATH"
alias python=/usr/local/bin/python3.7
