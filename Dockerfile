FROM ruby:2.6.2-stretch

# Copy application code
COPY . /application
# Change to the application's directory
WORKDIR /application

# Install gems, nodejs and precompile the assets
RUN bundle install --deployment --without development test \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs

RUN gem install bundler:2.0.2
# Adding project files
COPY . .
RUN bundle exec rake db:create
RUN bundle exec rake db:migrate
# RUN bundle exec rake db:seed
EXPOSE 80
CMD ["rackup","config.ru", "--host", "0.0.0.0", "--port", "80"]
