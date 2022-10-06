# GPU 개발환경을 위한 Docker Image
Ubuntu + Pyenv + Poetry

## 요구 사항
- 이미지를 빌드하기 위한 도커 엔진이 필요합니다. 
  - [Docker docs](https://docs.docker.com/engine/install/ubuntu/)를 참고하여 설치해주세요.
- CUDA 사용 환경을 위해 NVIDIA 그래픽 카드와 드라이버, 그리고 Nvidia-docker가 필요합니다.
  - [NVIDIA install-guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)를 참고하여 설치해주세요.

## 사용법
### 빌드된 이미지 사용
- [Docker Hub](https://hub.docker.com/r/fkaus5555/dl-world)에서 이미 빌드된 이미지를 사용하실 수 있습니다.
- 다음 명령어로 docker 이미지를 pull할 수 있습니다.
```bash
# Tag(base): Ubuntu 22.04 + cuda 11.7.1 + cudnn8 + Pyenv + Poetry
docker pull fkaus5555/dl-world:base-cuda11.7.1-cudnn8-ubuntu22.04

# Tag(dldev): Ubuntu 22.04 + cuda 11.7.1 + cudnn8 + Pyenv + Poetry + jupyter lab + torch + numpy + ...
docker pull fkaus5555/dl-world:dldev-cuda11.7.1-cudnn8-ubuntu22.04
```

### base/dldev 버전 빌드
- base 버전은 단순히 Ubuntu, CUDA, cudnn, Pyenv, Poetry로만 이루어져 있습니다. 직접 원하는 파이썬 환경을 구성하고, 사용해보세요.
- dldev 버전은 base 버전 이미지와 pyproject.toml 파일을 기반으로 원하는(재현가능한) 패키지를 설치합니다.   
  - 본 소스에는 torch(cu116), torchvision(cu116), pandas, numpy, scipy, sklearn, matplotlib, seaborn, jupyter lab, tqdm이 포함되어 있습니다.
```bash
# dockerfile이 있는 위치에서 다음 명령어 실행
docker build -t <image-name>:<tag> \
--build-arg USER_NAME=<user-name> \
--build-arg USER_PASSWORD=<user-password> \
--build-arg PYTHON_VERSION=<python-version> .
```


### docker run 예시
- ❗️ GPU 사용 시 `--gpus` 설정을 꼭 해주세요.  
- ❗️ `dldev`의 기본 CMD는 jupyter lab 서버를 실행시킵니다(비밀번호 x). 
  - 보안을 위해 비밀번호를 설정하고 싶으시면 [여기](https://habitual-pint-c5d.notion.site/Jupyter-lab-35417e3b16894a4aaaa6cea7435c6d5c)를 참고해주세요.
```bash
docker run -itd --name dl-world \
--gpus all -p <server-port>:<container-jupyter-port> -p <server-port>:<container-ssh-port> \
--restart <always> \
-v <volume-name>:<workspace> \
-w <workspace> \
<image-name>:<tag>
```


## 버전 정보
#### LASTEST: CUDA 11.7 Update 1
- base
  - ubuntu 22.04
  - cuda 11.7.1
  - cudnn8
- dldev 
  - ubuntu 22.04
  - cuda 11.7.1
  - cudnn8
  - poetry.dependencies
     <img width="856" alt="image" src="https://user-images.githubusercontent.com/83912849/194380292-8193f289-27eb-4085-ae36-8953eb3ea26c.png">



#### 개발 과정: [블로그](https://velog.io/@whattsup_kim/GPU-%EA%B0%9C%EB%B0%9C%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-docker%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%98%EC%97%AC-%EA%B0%9C%EB%B0%9C%ED%99%98%EA%B2%BD-%ED%95%9C-%EB%B2%88%EC%97%90-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0)
