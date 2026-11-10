# Se define una imagen base por defecto para aarch64 si la variable llega vacía
ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base-python:3.12
FROM $BUILD_FROM

# 1. Instalar dependencias del sistema y herramientas de compilación necesarias
RUN apk add --no-cache \
    openjpeg \
    tiff \
    openblas-dev \
    build-base \
    python3-dev \
    linux-headers

# 2. Establecer el directorio de trabajo obligatorio
WORKDIR /usr/src/app

# 3. Instalar librerías de Python
RUN pip3 install --no-cache-dir --break-system-packages \
    pillow \
    numpy \
    RPi.GPIO \
    smbus

# 4. Copiar los archivos del proyecto al directorio de trabajo
COPY . .

# 5. Ejecutar script principal
CMD [ "python3", "bin/main.py" ]

