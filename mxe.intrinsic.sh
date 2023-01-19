#!/bin/bash

for MEMBER in $*
do
    OUTPUT="${MEMBER}.lo"
    cd "${BUILD_DIR}" && "${TARGET}-ar" x "${ARCHIVE}" "${MEMBER}" && \
        ( echo '# Generated by libtool (determined) imposter'; \
            echo "pic_object='${MEMBER}'"; echo 'non_pic_object=none'; \
        ) > "${OUTPUT}"

    echo "${BUILD_DIR}/${OUTPUT}"
done