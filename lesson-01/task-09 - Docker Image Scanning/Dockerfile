FROM alpine:latest
LABEL authors="yidgar"

ENV TRIVY_VERSION=v0.45.1

# Install dependencies and download Trivy
# Install curl and any required dependencies
RUN apk add --no-cache curl bash \
    && curl -sfL https://github.com/aquasecurity/trivy/releases/download/${TRIVY_VERSION}/trivy_${TRIVY_VERSION#v}_Linux-64bit.tar.gz \
    | tar -xz -C /usr/local/bin trivy \
    && chmod +x /usr/local/bin/trivy

# Verify that curl and Trivy are installed
RUN curl --version && trivy --version

# Install Docker
RUN apk update
RUN apk add docker

ENTRYPOINT ["top"]
# Get nginx
# RUN trivy image nginx:alpine


