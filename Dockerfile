FROM ruby:3.1.2-alpine

ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

RUN mkdir /myapp
WORKDIR /myapp

RUN apk add --no-cache alpine-sdk \
    mysql-client \
    mysql-dev \
    build-base \
    bash \
    tzdata

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN gem install bundler
RUN bundle install --jobs 4

COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
