#!/bin/bash
set -e

logger <<< "Spam filter piping to SpamAssassin, then to: /usr/sbin/sendmail $@"
/usr/bin/spamc -s 1048576 -d spamassassin | /usr/sbin/sendmail "$@"

exit $?