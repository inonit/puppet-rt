# rt::queues class 
class rt::queues (
  $queues = {},
){

  include ::rt

  create_resources('rt:queue', $queues)

}
