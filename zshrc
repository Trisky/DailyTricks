#MacOS .zshrc
#free space
alias espacio='du -ksh *'
alias refreshalias='source ~/.bash_profile'
alias httpserver='python -m SimpleHTTPServer 8000'
alias wgettest='wget http://sftp.fibertel.com.ar/services/file-1GB.img'
alias decir='say -v juan'
alias servir='php -S 127.0.0.1:8000'
alias sqlstart='brew services start mysql'
alias sqlstop='brew services stop mysql'
alias zshreload="source ~/.zshrc"
alias nis="npm install --save"
alias tailMongoLog="tail -f /usr/local/var/log/mongodb/mongo.log"
#directory size
alias cuantoocupa="du -shc *"


#set lat and long to all jpg files in the current folder.
#Requires exiftool
setexifgeo() {

    if [ -z "$1" || -z "$2" ]
	then
	      echo latitude or longitude are empty
	      return
	fi
    exiftool -GPSLatitude=$1 -GPSLongitude=$2 *.JPG
}