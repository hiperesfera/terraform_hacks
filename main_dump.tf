

resource "null_resource" "running-local-commands" {

  triggers = {
  always_run = "${timestamp()}"
  }


  provisioner "local-exec" {
    command = <<_EOF
          hostname
          uname -ra
          whoami
          echo $$
          echo $0
          ps -o pid -u $(whoami)
          env
          [ -f /sys/hypervisor/uuid ] && [ `head -c 3 /sys/hypervisor/uuid` == e ] &&  echo 'This is a EC2'
          [ -f /.dockerenv ] && echo 'This is Docker'
          ip addr show
          #curl 'http://myip.dnsomatic.com'
          ls -ali / | sed '2!d'
          sleep 60
     _EOF
  }

/*
  provisioner "local-exec" {
    command = <<_EOF

    echo "This is id: $$ name: $0 running as $(whoami))"
    echo "and I am dumping the memory from all the processes running under my name"

    pids_list=$(ps -o pid -u $(whoami))

    for pid in $pids_list; do
        echo "Dumping $pid ..."
        cat /proc/$pid/maps | grep "rw-p" | awk '{print $1}' | awk -F - '{print $1,$2}' | while read a b; do dd if=/proc/$pid/mem bs=$( getconf PAGESIZE ) iflag=skip_bytes,count_bytes skip=$(( 0x$a )) count=$(( 0x$b - 0x$a )) of="/tmp/$1_mem_$a.bin"; done
        echo "Cleaning dump for pid:$pid"
        cat *_mem_*\.bin | strings >> dump.text
        rm *_mem_*\.bin
        cat dump.text
        rm dump.text
    done

     _EOF
  }
*/

}


output "hello_world" {
  value = "Hello TFE!"
}
