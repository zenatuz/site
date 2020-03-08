FROM ruby:alpine
WORKDIR /app

# Install dependencies
RUN apk upgrade --no-cache --update && apk add --no-cache --update make build-base git

# Copy Theme files to Workdir
COPY . /app

# Instal Gems (bundler and jekyll) and Minimal Mistakes
RUN gem install bundler jekyll && bundle install --jobs 4 --retry 3 --quiet

CMD ["bundle", "exec", "jekyll", "serve", "--watch" ,"--host=0.0.0.0"]

EXPOSE 4000