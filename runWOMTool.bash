#!/bin/bash
export VERSION=77
export LSF_DOCKER_VOLUMES="/storage1/fs1/cruchagac/Active:/storage1/fs1/cruchagac/Active \
/scratch1/fs1/cruchagac:/scratch1/fs1/cruchagac"
JOB_GROUP="/${USER}/compute-cruchagac"
bgadd -L 10 ${JOB_GROUP}
MODE="$1"
WDL="$2"
export JAVA_OPTS="-Dconfig.file=/scratch1/fs1/cruchagac/Workflows/testMJ.conf"
#LSF_DOCKER_ENV_FILE="/scratch1/fs1/cruchagac/${USER}/c1in/envs/${FULLSMID}.env" \
bsub -g ${JOB_GROUP} \
-J ${USER}/cromwell/${WDL} \
-n 1 \
-R 'rusage[mem=8000]' \
-M 8000
-G compute-cruchagac \
-q general-interactive \
-a 'docker(broadinstitute/womtool:77)' ${MODE} ${WDL}
