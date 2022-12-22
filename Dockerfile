FROM node:19-alpine as build

RUN apk update
RUN apk add bash

RUN npm i -g pnpm

ENV PATH /app/node_modules/.bin:$PATH

WORKDIR app

COPY .npmrc package.json pnpm-lock.yaml ./

RUN pnpm i -P --frozen-lockfile --ignore-scripts --reporter=silent
RUN pnpm i @craco/types @types/react @types/react-dom reflect-metadata tsconfig-paths tslib typescript

COPY .env package-scripts.yaml .barrelsby.json tsconfig.json tsconfig.compile.json ./
COPY .cracorc.prod.ts .cracorc.ts
COPY src src
COPY public public

COPY scripts/secrets-entrypoint.sh /usr/local/bin/secrets-entrypoint.sh
RUN chmod +x /usr/local/bin/secrets-entrypoint.sh
ENTRYPOINT ["secrets-entrypoint.sh"]

RUN nps build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
