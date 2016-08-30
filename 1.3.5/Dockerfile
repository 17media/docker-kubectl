FROM        alpine:3.4

ENV         VERSION 1.3.5
ENV         KUBE_CONTEXT default

COPY        entrypoint.sh /
RUN         apk --no-cache add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
                kubernetes=$VERSION-r0 \
                nano && \
            (\
                cd /usr/bin && \
                rm \
                    kube-apiserver \
                    kube-controller-manager \
                    kube-proxy \
                    kube-scheduler \
                    kubelet \
                    kubemark \
            ) && \
            chmod +x /entrypoint.sh

ENTRYPOINT  ["/entrypoint.sh", "kubectl"]
