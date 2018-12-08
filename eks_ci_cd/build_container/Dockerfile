FROM docker:latest

RUN apk add --no-cache bash python3 curl openssl git iptables
RUN pip3 install --upgrade pip
RUN pip3 install awscli
RUN curl -o /usr/local/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl
RUN curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x /usr/local/bin/aws-iam-authenticator
RUN curl -o /usr/local/bin/get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get \
    && chmod +x /usr/local/bin/get_helm.sh \
    && /usr/local/bin/get_helm.sh \
    && helm init --client-only
RUN helm plugin install https://github.com/hypnoglow/helm-s3.git
COPY build_scripts /usr/local/bin