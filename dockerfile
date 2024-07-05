# Gunakan image dasar Ubuntu 22.04
FROM ubuntu:22.04

# Setel variabel lingkungan yang diperlukan
ENV DEBIAN_FRONTEND=noninteractive

# Perbarui paket dan instal beberapa paket dasar serta SSH dan FTP
RUN apt-get update && apt-get install -y \
    ssh \
    ftp \
    && rm -rf /var/lib/apt/lists/*

# Instal nano untuk editor teks
RUN apt-get update && apt-get install -y \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Tambahkan pengguna baru dengan nama 'user' dan sandi 'user'
RUN useradd -m -s /bin/bash user \
    && echo "user:user" | chpasswd

# Instal FreeRADIUS dengan dukungan MySQL
RUN apt-get update && apt-get install -y \
    freeradius \
    freeradius-mysql \
    && rm -rf /var/lib/apt/lists/*

# Konfigurasi FreeRADIUS (opsional, sesuaikan dengan kebutuhan)

# Buat symlink untuk modul SQL
RUN ln -s /etc/freeradius/3.0/mods-available/sql /etc/freeradius/3.0/mods-enabled/

# Misalnya, tambahkan file konfigurasi, konfigurasi database MySQL, dll.

# Instal PHP 7.4 dan ekstensi yang diperlukan
RUN apt-get update && apt-get install -y \
    php \
    php-mysql \
    php-cli \
    php-curl \
    php-gd \
    php-intl \
    php-mbstring \
    php-xml \
    php-zip \
    && rm -rf /var/lib/apt/lists/*

# Konfigurasi tambahan PHP (opsional, sesuaikan dengan kebutuhan)
# Misalnya, atur konfigurasi php.ini, tambahkan ekstensi tambahan, dll.

# Ekspos port yang diperlukan untuk SSH, FTP, dan FreeRADIUS
EXPOSE 22 21 1812 1813

# Tentukan perintah default saat container berjalan
CMD ["bash"]
