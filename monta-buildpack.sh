                                                  #!/bin/bash -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $(basename $0) usuario_cf senha_cf"
    exit 1
fi

#clonar repositorio do java-buildpack
git clone https://github.com/cloudfoundry/java-buildpack.git
git checkout 8821e85d3

#substituir os arquivos personalizados
cp config/*.* java-buildpack/config

#instalar o bundler
bundle install

#empacotar o buildpack
cd java-buildpack
bundle exec rake package OFFLINE=true PINNED=true

#logar no cf
cf api
#subir buildpack