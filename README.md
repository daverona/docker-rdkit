# daverona/rdkit


```bash
docker image build . --tag arontier/rdkit:2019.03.2-ubuntu18.04
```

```bash
docker container run --rm -it --name rdkit arontier/rdkit:2019_03_2-ubuntu:18.04
```

```bash
docker cp rdkit:/usr/local/rdkit/Release_2019_03_2/ rdkit
```

```
&& ln -s ${RDBASE}/lib/python3.6/site-packages/rdkit \
  /usr/local/lib/python3.6/dist-packages/rdkit \
&& echo 'export LD_LIBRARY_PATH="'${RDBASE}'/lib:${LD_LIBRARY_PATH}"' \
  > /etc/profile.d/rdkit.sh \
```
