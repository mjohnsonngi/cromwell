#!/bin/bash
export LSF_DOCKER_VOLUMES="/storage1/fs1/cruchagac/Active:/storage1/fs1/cruchagac/Active \
/scratch1/fs1/cruchagac:/scratch1/fs1/cruchagac"
JOB_GROUP="/${USER}/compute-cruchagac"
bgadd -L 10 ${JOB_GROUP}
#LSF_DOCKER_ENV_FILE="/scratch1/fs1/cruchagac/${USER}/c1in/envs/${FULLSMID}.env" \
LSF_DOCKER_PORTS='8644:8644' \
bsub -g ${JOB_GROUP} \
-J ${USER}/cromwell \
-n 1 \
-R 'select[port8644=1]' \
-G compute-cruchagac \
-q general-interactive \
-a 'docker(mjohnsonngi/cromwell:latest)' java -Dconfig.file=/confs/testMJ.conf -jar cromwell-[VERSION].jar server
