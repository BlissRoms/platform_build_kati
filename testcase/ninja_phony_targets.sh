#!/bin/bash
#
# Copyright 2015 Google Inc. All rights reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

mk="$@"
function build() {
  # Remove once regen works with different args
  rm -f build.ninja .kati_stamp ninja.sh
  ${mk} $@
  if [ -e ninja.sh ]; then ./ninja.sh -j1 $@; fi
}

cat <<EOF > Makefile
.PHONY: a b
b:
	echo \$@
a:
	echo \$@
EOF

echo "==="
build
echo "---"
build a
echo "---"
build b
echo "==="
