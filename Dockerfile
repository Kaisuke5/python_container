FROM frolvlad/alpine-python2


RUN apk add --no-cache --virtual=build_dependencies musl-dev gcc python-dev make cmake g++ gfortran && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && mkdir -p /tmp/build \
	&& cd /tmp/build/ \
	&& wget http://www.netlib.org/blas/blas-3.6.0.tgz \
	&& wget http://www.netlib.org/lapack/lapack-3.6.1.tgz \
	&& tar xzf blas-3.6.0.tgz \
	&& tar xzf lapack-3.6.1.tgz \
	&& cd /tmp/build/BLAS-3.6.0/ \
	&& export BLAS=/tmp/build/libfblas.a \
	&& export LAPACK=/tmp/build/liblapack.a


RUN mkdir python_dev

COPY requirement.txt python_dev
RUN pip install -r python_dev/requirement.txt

CMD ["pip list"]
