FROM ruby:2.3.1

RUN apt-get update && apt-get install -y \
  build-essential man strace \
  nodejs npm \
  socat vim less && \
  apt-get clean autoremove

RUN mkdir -p /app
WORKDIR /app

ADD Gemfile /app
ADD Gemfile.lock /app
ADD patch/ /app/patch

RUN gem install bundler && bundle install -j8
ADD . /app

EXPOSE 3000
#CMD bundle exec rails s -b 0.0.0.0
#CMD /usr/local/bundle/bin/bundle exec zeus start
#CMD strace rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- /usr/local/bundle/bin/bundle exec zeus start
CMD rdebug-ide -d --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- /usr/local/bundle/bin/bundle exec zeus start
