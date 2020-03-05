FROM alpine:3.11

ENV KUBE_LATEST_VERSION="v1.13.10"
ENV KUBECONFIG="/etc/k8s/kubeconfig"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl bash zsh \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
#  && apk del --purge deps \
 && rm /var/cache/apk/*

ADD run.sh /usr/bin
ADD init-session.sh /usr/bin

WORKDIR /root

CMD ["/usr/bin/run.sh"]