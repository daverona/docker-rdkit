# daverona/rdkit


```bash
docker image build . --tag daverona/rdkit:2019.03.4-ubuntu18.04
```

```bash
docker container run --rm \
  --volume $PWD:/data \
  daverona/rdkit:2019.03.4-ubuntu:18.04 \
  cp -R /usr/local/rdkit/Release_2019_03_4 /data/rdkit 

export RDBASE=/path/to/your/rdkit
  
cp -R rdkit ${RDBASE}  

sudo apt-get install --yes --quiet --no-install-recommends \
  libboost-iostreams1.65.1 \
  libboost-python1.65.1 \
  libboost-regex1.65.1 \
  libboost-serialization1.65.1 \
  libboost-system1.65.1 \
  python3-cairo=1.16.2-1 \
  python3-pandas=0.22.0-4 \
  python3-pil=5.1.0-1 \
  python3.6 \
  python3.6-dev

sudo ln -s ${RDBASE}/lib/python3.6/site-packages/rdkit \
  /usr/local/lib/python3.6/dist-packages/rdkit

echo 'export LD_LIBRARY_PATH="'${RDBASE}'/lib:${LD_LIBRARY_PATH}"' \
  > /etc/profile.d/rdkit.sh
```
