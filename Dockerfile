FROM ruby:alpine as Jekyll
WORKDIR /app

# Install dependencies
RUN apk upgrade --no-cache --update && apk add --no-cache --update make build-base git

# Instal Gems (bundler and jekyll)
RUN gem install bundler jekyll

FROM Jekyll 
# Copy Theme files to Workdir
COPY . /app

#Install Minimal Mistakes
RUN bundle install --jobs 4 --retry 3 --quiet

# Start local server
CMD ["bundle", "exec", "jekyll", "serve", "--watch" ,"--host=0.0.0.0"]

EXPOSE 4000