# rt::queue defined type.
# Stolen from https://github.com/deadpoint/puppet-rt/blob/master/manifests/queue.pp
define rt::queue (
    $ensure         = present,
    $description    = "",
    $reply_email    = "",
    $comment_email  = ""
    ) {

    validate_re($ensure, '^present$',
        "${ensure} is not valid. Allowed values are 'present' only.")

    exec { "rt_queue_add_${name}":
        command => "rt create -t queue set name=\"${name}\" description=\"${description}\" CorrespondAddress=\"${reply_email}\" CommentAddress=\"${comment_email}\"",
        unless  => "rt show -t queue \"${name}\" | grep ^Name: > /dev/null"
    }
    
    
}
