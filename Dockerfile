FROM ruby:3.0.0-alpine

ENV RAILS_APP_PATH /project
ENV PATH "${PATH}:${RAILS_APP_PATH}/bin"

ENV PORT 3000

RUN mkdir $RAILS_APP_PATH
WORKDIR $RAILS_APP_PATH

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories \
  && apk --update --no-cache add make g++ postgresql-dev imagemagick=6.9.6.8-r1 imagemagick-dev=6.9.6.8-r1 nodejs npm yarn bash libgcc libstdc++ libx11 glib libxrender libxext libintl ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family \
  && gem install bundler

COPY Gemfile $RAILS_APP_PATH
COPY Gemfile.lock $RAILS_APP_PATH
RUN gem install bundler --update
RUN bundle install

COPY package.json $RAILS_APP_PATH
COPY yarn.lock $RAILS_APP_PATH
RUN yarn install --check-files && cp yarn.lock /tmp

RUN rails webpacker:install

RUN bundle config --delete bin
RUN rails app:update:bin

RUN rails assets:precompile

COPY . $RAILS_APP_PATH

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE $PORT