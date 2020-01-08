FROM ruby:2.3

RUN mkdir -p /usr/src/app
RUN git clone https://github.com/mrbirds/cryptoexchange-api.git /usr/src/app
WORKDIR /usr/src/app
EXPOSE 4567
RUN bundle install
CMD ["./api.rb"]
