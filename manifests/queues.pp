# rt::queues class 
class rt::queues (
  $queues = {},
){

  include ::rt

  create_resource('rt:queue', $queues)

}
