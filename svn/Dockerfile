FROM alpine:3.8
RUN apk add --no-cache subversion
VOLUME /svn
WORKDIR /svn
EXPOSE 3690
CMD [ "/usr/bin/svnserve", "--daemon", "--foreground", "--root", "/svn" ]
