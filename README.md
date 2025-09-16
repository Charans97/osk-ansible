OSK-Ansible - Air-gapped Apache Kafka (KRaft) deployment skeleton

Usage:
1. Extract tarball
2. Put your tarballs and certs into roles/prereqs/files/:
   - kafka.tgz
   - jdk-17_linux-x64_bin.tar.gz
   - ca.crt
   - ca.key
3. Edit inventory/hosts.yml (only file you need to change)
4. Run:
   ansible-playbook -i inventory/hosts.yml playbooks/site.yml

Notes:
- Designed for air-gapped installs. No external package downloads.
- Ansible will generate keystores and truststores if ca.key/ca.crt are present in roles/prereqs/files/
- Adjust JVM heap and other production tuning in templates or group_vars/all.yml
