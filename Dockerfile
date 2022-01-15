FROM ruby:3.0-alpine
RUN apk add --no-cache --update build-base linux-headers git postgresql-dev nodejs tzdata npm
RUN npm install -g yarn
WORKDIR /projects
COPY Gemfile* /projects
RUN bundle install
COPY . /projects
CMD rails db:create && rails db:migrate && rails assets:precompile && puma -C config/puma.rb
