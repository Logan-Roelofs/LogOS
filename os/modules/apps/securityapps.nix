{ config, pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    # Security Tools
    rustscan # Fast port scanner
    nmap # Network scanner
    john # Password cracker
    hashcat # Password cracker
    hash-identifier # Hash identifier
    burpsuite # Web application security testing
    samba # Smb client
    inetutils # telnet, ftp, rsh, rlogin, rcp, and rwho
    redis # Redis-cli
    gobuster # Directory brute-forcer
    enum4linux # Enumerate information from Windows and Samba systems
    thc-hydra # Password cracker
    whatweb # Web scanner
    exploitdb # Exploit database
    ffuf # Fast web fuzzer
    nfs-utils # NFS client
    dig # DNS lookup
    # THIS IS CAUSING BUILD TO FAIL... PYTHON SLOWAPI IS BROKEN  theharvester # Email, subdomain, and people search
  ];
}
