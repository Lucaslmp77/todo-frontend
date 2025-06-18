# Estágio de Build
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

# Estágio de Produção
FROM nginx:stable-alpine
# Copia os arquivos estáticos gerados pelo build do React para a pasta do Nginx
COPY --from=build /app/build /usr/share/nginx/html
# Expõe a porta 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]