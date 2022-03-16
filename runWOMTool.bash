#!/bin/bash
export VERSION=77
JOB_GROUP="/${USER}/compute-cruchagac"
bgadd -L 10 ${JOB_GROUP}
MODE="$1"
WDL="$2"
#JAVA_OPTS="-Dconfig.file=/scratch1/fs1/cruchagac/Workflows/confs/testMJ.conf"
LSF_DOCKER_PRESERVE_ENVIRONMENT=false \
LSF_DOCKER_ENTRYPOINT=/bin/bash \
LSF_DOCKER_VOLUMES="/storage1/fs1/cruchagac/Active:/storage1/fs1/cruchagac/Active \
/scratch1/fs1/cruchagac:/scratch1/fs1/cruchagac" \
bsub -g ${JOB_GROUP} \
-J ${USER}/cromwell/wom \
-n 1 \
-R 'rusage[mem=8000]' \
-M 8000 \
-G compute-cruchagac \
-q general \
-a 'docker(broadinstitute/womtool:77)' java $JAVA_OPTS -jar /app/womtool.jar $MODE $WDL
