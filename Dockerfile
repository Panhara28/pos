FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# # Set an environment variable where the Rails app is installed to inside of Docker image
# ENV RAILS_ROOT /var/www/app_name
# RUN mkdir -p $RAILS_ROOT
# # Set working directory
# WORKDIR $RAILS_ROOT
# RUN touch .env /var/www/app_name
# RUN echo "URL=mysql2://panhra:panhara28@157.230.254.45/point_of_sale_production" >> /var/www/app_name/.env

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler -v 1.17.2
RUN gem install nokogiri -v 1.10.5
RUN bundle install --deployment --without development test
# Adding project files
COPY . .
RUN bundle exec rake db:create
RUN bundle exec rake db:migrate
# RUN bundle exec rake db:seed
EXPOSE 80
CMD ["rackup","config.ru", "--host", "0.0.0.0", "--port", "80"]
