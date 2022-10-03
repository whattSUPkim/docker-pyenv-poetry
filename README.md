# GPU 개발환경을 위한 Docker Image
Ubuntu + Pyenv + Poetry

## 요구 사항
- 이미지를 빌드하기 위한 도커 엔진이 필요합니다. 
  - [Docker docs](https://docs.docker.com/engine/install/ubuntu/)를 참고하여 설치해주세요.
- CUDA 사용 환경을 위해 NVIDIA 그래픽 카드와 드라이버, 그리고 Nvidia-docker가 필요합니다.
  - [NVIDIA install-guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)를 참고하여 설치해주세요.

## 사용법
### 빌드된 이미지 사용
- [Docker Hub]((https://hub.docker.com/r/fkaus5555/dl-world))에서 이미 빌드된 이미지를 사용하실 수 있습니다.
- 다음 명령어로 docker 이미지를 pull할 수 있습니다.
```bash
# Tag: Ubuntu 22.04 + cuda 11.7.1 + cudnn8 + Pyenv + Poetry
docker pull fkaus5555/dl-world:base-cuda11.7.1-cudnn8-ubuntu22.04
```

### base 버전 빌드
base 버전은 단순히 Ubuntu, CUDA, cudnn, Pyenv, Poetry로만 이루어져 있습니다. 
직접 원하는 파이썬 환경을 구성하고, 사용해보세요.
```bash
# dockerfile이 있는 위치에서 다음 명령어 실행
docker build -t dl-world:base-cuda11.7.1-cudnn8-ubuntu22.04 \
--build-arg USER_NAME=user \
--build-arg USER_PASSWORD=0000 \
--build-arg PYTHON_VERSION=3.10.6 .
```

### dldev 버전 빌드
dldev 버전은 base 버전 이미지와 pyproject.toml 파일을 기반으로 원하는(재현가능한) 패키지를 설치합니다.   
본 소스에는 torch(cu116), torchvision(cu116), pandas, numpy, scipy, sklearn, matplotlib, seaborn, ipykernel, tqdm이 포함되어 있습니다.
```bash
# dockerfile이 있는 위치에서 다음 명령어 실행
docker build -t dl-world:dldev-cuda11.7.1-cudnn8-ubuntu22.04 \
--build-arg USER_NAME=user \
--build-arg USER_PASSWORD=0000 \
--build-arg PYTHON_VERSION=3.10.6 .
```

### docker run 예시
❗️ GPU 사용 시 `--gpus` 설정을 꼭 해주세요.
```bash
docker run -itd --name test-container \
--gpus all -p 2222:22 \
--restart always \
-v dl-world:/home/user/workspace:z \
-w /home/user/workspace \
dl-world:cuda11.7.1-cudnn8-ubuntu22.04
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
     ![image](https://user-images.githubusercontent.com/83912849/193665663-3bd29d21-3707-482d-bf57-4e846feaf0ed.png)


  
  

#### 개발 과정: [블로그](https://velog.io/@whattsup_kim/GPU-%EA%B0%9C%EB%B0%9C%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-docker%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%98%EC%97%AC-%EA%B0%9C%EB%B0%9C%ED%99%98%EA%B2%BD-%ED%95%9C-%EB%B2%88%EC%97%90-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0)
