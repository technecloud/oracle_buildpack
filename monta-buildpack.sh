#if [ "$#" -lt 2 ]; then
#    echo "Usage: $(basename $0) usuario_cf senha_cf"
#    exit 1
#fi

#clonar repositorio do java-buildpack
git clone https://github.com/cloudfoundry/java-buildpack.git
echo ">>>>>>>>>Java"
cd java-buildpack
echo ">>>>>>>>>Checkout"
git checkout 8821e85d3

#substituir os arquivos personalizados
cp ../config/*.* config

#instalar o bundler
if ! gem spec bundler > /dev/null 2>&1; then
  echo "Gem <name> não está instalada."
  read -p "Proceder com a instalacao?[y/N] " -n 1 -r
  echo    # (optional) move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
        gem install bundler --no-ri --no-rdoc
        bundle install
        bundle exec rake package OFFLINE=true PINNED=true
  then
      exit 1
  fi
fi

#empacotar o buildpack


#logar no cf
#cf api
#subir buildpack
