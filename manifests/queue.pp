# rt::queue defined type.
# Stolen from https://github.com/deadpoint/puppet-rt/blob/master/manifests/queue.pp
define rt::queue (
    $ensure             = present,
    $description        = "${name} queue",
    $reply_email        = "${name}@${rt::email_domain}",
    $comment_email      = "${name}-comment@${rt::email_domain}",
    $url                = $rt::rt_server
    ) {

    validate_re($ensure, '^present$',
        "${ensure} is not valid. Allowed values are 'present' only.")

    exec { "rt_queue_add_${name}":
        command => "/usr/bin/rt create -t queue set name=\"${name}\" description=\"${description}\" CorrespondAddress=\"${reply_email}\" CommentAddress=\"${comment_email}\"",
        unless  => "/usr/bin/rt show -t queue \"${name}\" | grep ^Name: > /dev/null"
    }

    mailalias {
      $name:
        ensure    => $ensure,
        recipient => "|/usr/bin/rt-mailgate --queue ${name} --action correspond --url $url";
      "${name}-comment":
        ensure    => $ensure,
        recipient => "|/usr/bin/rt-mailgate --queue ${name} --action comment --url $url";
    }
}
