FROM ruby:2.6.2-stretch
RUN apt-get update 
RUN apt-get install git
# Copy application code
RUN  git clone https://github.com/CORE-UPM/myjson
# Change to the application's directory
WORKDIR /myjson

# Set Rails environment to production
ENV RAILS_ENV production

# Install gems, nodejs and precompile the assets
RUN bundle install --deployment --without development test \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs

EXPOSE 80
# Start the application server
ENTRYPOINT [cap production deploy]