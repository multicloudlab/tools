# Copyright 2019 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# GKE variables.
PROJECT ?= oceanic-guard-191815
ZONE    ?= us-west1-a
CLUSTER ?= prow

.PHONY: activate-serviceaccount
activate-serviceaccount:
ifdef GOOGLE_APPLICATION_CREDENTIALS
	gcloud auth activate-service-account --key-file="$(GOOGLE_APPLICATION_CREDENTIALS)"
endif

.PHONY: get-cluster-credentials
get-cluster-credentials: activate-serviceaccount
	gcloud container clusters get-credentials "$(CLUSTER)" --project="$(PROJECT)" --zone="$(ZONE)"

#build:
#	@go build ./...

#test:
#	@go test -race ./...

#check-stability:
#	./metrics/check_metrics.py

lint: lint-all

fmt: format-go format-python

images: get-cluster-credentials
	@cd docker/build-tools && ./build-and-push.sh

include common/Makefile.common.mk
