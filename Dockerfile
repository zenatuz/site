FROM ruby:alpine
WORKDIR /app
# Install dependencies
RUN apk upgrade --no-cache --update && apk add --no-cache --update make build-base git

# Copy Theme files to Workdir
COPY . /app

# Instal Gems (bundler and jekyll) and Minimal Mistakes
RUN gem install bundler && gem install jekyll && bundle install
# && export RUBYOPT='-W0'
RUN bundle exec jekyll build 

CMD ["bundle", "exec", "jekyll", "serve", "--host=0.0.0.0"]