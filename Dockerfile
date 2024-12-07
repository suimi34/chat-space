FROM ruby:2.3.8

ENV ROOT="/chat-space"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo
ENV RAILS_ENV=development

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN echo "deb http://archive.debian.org/debian/ stretch main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list

RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN set -x && apt-get update -y -qq && apt-get install -yq yarn default-mysql-client

WORKDIR ${ROOT}

COPY Gemfile Gemfile.lock ${ROOT}
RUN gem install bundler -v 2.3.27 && bundle install
COPY . ${ROOT}

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
