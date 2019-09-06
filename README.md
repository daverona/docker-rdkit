# daverona/rdkit


```bash
docker image build . --tag daverona/rdkit:2019.03.4-ubuntu18.04
```

```bash
docker container run --rm \
  --volume $PWD:/data \
  daverona/rdkit:2019.03.4-ubuntu:18.04 \
  cp -R /usr/local/rdkit/Release_2019_03_4 /data/rdkit 
```

```bash
ln -s ${RDBASE}/lib/python3.6/site-packages/rdkit \
  /usr/local/lib/python3.6/dist-packages/rdkit
echo 'export LD_LIBRARY_PATH="'${RDBASE}'/lib:${LD_LIBRARY_PATH}"' \
  > /etc/profile.d/rdkit.sh
```
