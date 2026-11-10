ARG BUILD_FROM
FROM $BUILD_FROM

# 1. Instalar dependencias del sistema y herramientas de compilación necesarias
RUN apk add --no-cache \
    python3 \
    py3-pip \
    openjpeg \
    tiff \
    openblas-dev \
    build-base \
    python3-dev \
    linux-headers

# 2. Establecer el directorio de trabajo obligatorio para evitar fallos de copia
WORKDIR /usr/src/app

# 3. Instalar librerías de Python
# Nota: RPi.GPIO y smbus necesitan compilar en Alpine, por lo que requerían build-base arriba
RUN pip3 install --no-cache-dir --break-system-packages \
    pillow \
    numpy \
    RPi.GPIO \
    smbus

# 4. Copiar los archivos del proyecto al directorio de trabajo
COPY . .

# 5. Ejecutar con el formato JSON recomendado para que Home Assistant controle el ciclo de vida
CMD [ "python3", "bin/main.py" ]


