#!/bin/bash
BASE_PATH=$(dirname "${BASH_SOURCE}")
BASE_PATH=$(cd "${BASE_PATH}"; pwd)

# source ISCE env
export GMT_HOME=/usr/local/gmt
export ARIAMH_HOME=$HOME/ariamh
source $ARIAMH_HOME/isce.sh
source $ARIAMH_HOME/giant.sh
export TROPMAP_HOME=$HOME/tropmap
export UTILS_HOME=$ARIAMH_HOME/utils
export GIANT_HOME=/usr/local/giant/GIAnT
export PYTHONPATH=$ISCE_HOME/applications:$ISCE_HOME/components:$BASE_PATH:$ARIAMH_HOME:$TROPMAP_HOME:$GIANT_HOME:$PYTHONPATH
export PATH=$BASE_PATH:$TROPMAP_HOME:$GMT_HOME/bin:$PATH


SLCP_PROD=$1
SWATH=$2


echo "##########################################" 1>&2
echo -n "Running S1 coherence and amplitude generation: " 1>&2
date 1>&2
python3 $BASE_PATH/create_cor.py $SLCP_PROD > create_cor.log 2>&1
STATUS=$?
echo -n "Finished running S1 coherence and amplitude generation: " 1>&2
date 1>&2
if [ $STATUS -ne 0 ]; then
  echo "Failed to run S1 coherence and amplitude generation." 1>&2
  cat create_cor.log 1>&2
  echo "{}"
  exit $STATUS
fi
