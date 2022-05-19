####################################################################################################
# Step 1: Build the app
####################################################################################################

FROM rwynn/monstache-builder-cache-rel6:1.0.7 AS build-app

RUN mkdir /app

WORKDIR /app

COPY . .

RUN go mod download

RUN make release

####################################################################################################
# Step 2: Copy output build file to an alpine image
####################################################################################################

FROM rwynn/monstache-alpine:3.15.0

COPY --from=build-app /app/build/linux-amd64/monstache /bin/monstache

COPY ./start_monstache.sh /usr/local/bin/start_monstache.sh
RUN chmod +x /usr/local/bin/start_monstache.sh

ENTRYPOINT ["/bin/sh", "-c", "start_monstache.sh"]
