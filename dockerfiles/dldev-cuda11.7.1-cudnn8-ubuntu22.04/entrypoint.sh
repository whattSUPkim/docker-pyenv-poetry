#! /bin/bash

# restart ssh service
/bin/bash -c "sudo service ssh start > /dev/null"

# execute jupyter lab server
/bin/bash -c "cd ./machine-learning && \
    poetry run jupyter lab --ip 0.0.0.0 --allow-root \
    --NotebookApp.token= --no-browser --notebook-dir=$HOME"