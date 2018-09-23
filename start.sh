docker run -d --rm --name=delve --privileged -p 8080:8080 -p 40000:40000 --security-opt="apparmor=unconfined" --cap-add=SYS_PTRACE delve
