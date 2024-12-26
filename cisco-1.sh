#!/usr/bin/expect

CISCO_IP="192.168.228.128"
CISCO_PORT="30002"

# Mulai telnet
spawn telnet spawn telnet $CISCO_IP $CISCO_PORT
set timeout 20


# Tunggu koneksi berhasil
expect {
    "Connected to" { 
        send "enable\r"
    }
    timeout {
        puts "Gagal terhubung ke telnet."
        exit 1
    }
}

# Kirim perintah ke perangkat Cisco
expect ">"
send "enable\r"
expect "#"
send "configure terminal\r"
expect "(config)#"
send "int e0/1\r"
expect "(config-if)#"
send "sw mo acc\r"
expect "(config-if)#"
send "sw acc vl 10\r"
expect "(config-if)#"
send "no sh\r"
expect "(config-if)#"
send "exit\r"
expect "(config)#"
send "interface e0/0\r"
expect "(config-if)#"
send "sw tr encap do\r"
expect "(config-if)#"
send "sw mo tr\r"
expect "(config-if)#"
send "no sh\r"
expect "(config-if)#"
send "exit\r"

# Selesai konfigurasi
send "exit\r"
expect eof

# Konfirmasi eksekusi
puts "Konfigurasi CISCO berhasil diterapkan."
