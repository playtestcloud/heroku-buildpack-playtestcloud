#!/usr/bin/env bash

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testCompile() {
  compile

  assertEquals 'compile did not return exit code 0' 0 "${RETURN}"
  assertTrue 'could not find wav2png binary' "[ -r ${BUILD_DIR}/wav2png/bin/Linux/wav2png ]"
  assertTrue 'could not find bundletool binary' "[ -r ${BUILD_DIR}/bundletool/bundletool ]"
}

testCompileFails() {
  # git does not clone into non-empty directories, so this should fail the compile script:
  mkdir ${BUILD_DIR}/wav2png
  touch ${BUILD_DIR}/wav2png/myfile.txt

  compile

  assertNotEquals 'compile should fail but returned exit code 0' 0 "${RETURN}"
}
