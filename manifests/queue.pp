# rt::queue defined type.
# Stolen from https://github.com/deadpoint/puppet-rt/blob/master/manifests/queue.pp
define rt::queue (
    # Some data defined in rt/data
    $ensure             = present,
    $email_domain       = lookup('rt::email_domain'),
    $url                = lookup('rt::rt_server'),
    $alias              = "${name}",
    $description        = "${name} queue",
    $reply_email        = "${alias}@${email_domain}",
    $comment_email      = "${alias}-comment@${email_domain}",
    ) {

    # need for file requirements
    include ::rt

    validate_re($ensure, '^present$',
        "${ensure} is not valid. Allowed values are 'present' only.")

    exec { "rt_queue_add_${name}":
        command => "/usr/bin/rt create -t queue set name=\"${name}\" description=\"${description}\" CorrespondAddress=\"${reply_email}\" CommentAddress=\"${comment_email}\"",
        unless  => "/usr/bin/rt show -t queue \"${name}\" | grep ^Name: > /dev/null",
        require => File['/etc/request-tracker4/rt.conf']
    }

    mailalias {
      $alias:
        ensure    => $ensure,
        recipient => "|/usr/bin/rt-mailgate --queue ${name} --action correspond --url $url";
      "${alias}-comment":
        ensure    => $ensure,
        recipient => "|/usr/bin/rt-mailgate --queue ${name} --action comment --url $url";
    }
}
