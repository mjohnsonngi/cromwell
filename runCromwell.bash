#!/bin/bash
JOB_GROUP="/${USER}/compute-cruchagac"
bgadd -L 10 ${JOB_GROUP}
#JAVA_OPTS="-Dconfig.file=/scratch1/fs1/cruchagac/Workflows/testMJ.conf"
WDL="$1"
LSF_DOCKER_PRESERVE_ENVIRONMENT=false \
LSF_DOCKER_PORTS='8644:8000' \
LSF_DOCKER_ENTRYPOINT=/bin/bash \
LSF_DOCKER_VOLUMES="/storage1/fs1/cruchagac/Active:/storage1/fs1/cruchagac/Active \
/scratch1/fs1/cruchagac:/scratch1/fs1/cruchagac" \
bsub -g ${JOB_GROUP} \
-J ${USER}/cromwell/${WDL} \
-Is \
-n 1 \
-R 'select[port8644=1]' \
-G compute-cruchagac \
-q general-interactive \
-a 'docker(broadinstitute/cromwell:77)' java ${JAVA_OPTS} -jar /app/cromwell.jar server
