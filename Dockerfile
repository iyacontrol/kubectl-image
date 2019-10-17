FROM alpine:3.10

ENV KUBE_LATEST_VERSION="v1.13.10"
ENV KUBECONFIG="/kubeconfig"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

ADD run.sh /usr/bin
RUN chmod +x /usr/bin/run.sh

CMD ["/usr/bin/run.sh"]