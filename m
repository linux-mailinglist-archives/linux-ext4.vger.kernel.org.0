Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02560B2DBF
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 04:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfIOCFz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 22:05:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57778 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727262AbfIOCFz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 22:05:55 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8F25Mrh018387
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Sep 2019 22:05:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DADD4420811; Sat, 14 Sep 2019 22:05:21 -0400 (EDT)
Date:   Sat, 14 Sep 2019 22:05:21 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190915020521.GF19710@mit.edu>
References: <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190914211126.GA4355@darwi-home-pc>
 <20190914222432.GC19710@mit.edu>
 <CAHk-=wi-y26j4yX5JtwqwXc7zKX1K8FLQGVcx49aSYuW8JwM+w@mail.gmail.com>
 <20190915010037.GE19710@mit.edu>
 <CAHk-=wjGTV0e_P73V0B3cPVrfeoSZcV6CjQMgj-+yL-s38DKaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjGTV0e_P73V0B3cPVrfeoSZcV6CjQMgj-+yL-s38DKaw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 06:10:47PM -0700, Linus Torvalds wrote:
> > We could return 0 for success, and yet "the best we
> > can do" could be really terrible.
> 
> Yes. Which is why we should warn.

I'm all in favor of warning.  But people might just ignore the
warning.  We warn today about systemd trying to read from /dev/urandom
too early, and that just gets ignored.

> But we can't *block*. Because that just breaks people. Like shown in
> this whole discussion.

I'd be willing to let it take at least 2 minutes, since that's slow
enough to be annoying.  I'd be willing to to kill the process which
tried to call getrandom too early.  But I believe blocking is better
than returning something potentially not random at all.  I think
failing "safe" is extremely important.  And returning something not
random which then gets used for a long-term private key is a disaster.

You basically want to turn getrandom into /dev/urandom.  And that's
how we got into the mess where 10% of the publically accessible ssh
keys could be guessed.  I've tried that already, and we saw how that
ended.

> Why is warning different? Because hopefully it tells the only person
> who can *do* something about it - the original maintainer or developer
> of the user space tools - that they are doing something wrong and need
> to fix their broken model.

Except the developer could (and *has) just ignored the warning, which
is what happened with /dev/urandom when it was accessed too early.
Even when I drew some developers attention to the warning, at least
one just said, "meh", and blew me off.  Would a making it be noiser
(e.g., a WARN_ON) make enough of a difference?  I guess I'm just not
convinced.

> Blocking doesn't do that. Blocking only makes the system unusable. And
> yes, some security people think "unusable == secure", but honestly,
> those security people shouldn't do system design. They are the worst
> kind of "technically correct" incompetent.

Which is worse really depends on your point of view, and what the
system might be controlling.  If access to the system could cause a
malicious attacker to trigger a nuclear bomb, failing safe is always
going to be better.  In other cases, maybe failing open is certainly
more convenient.  It certainly leaves the system more "usable".  But
how do we trade off "usable" with "insecure"?  There are times when
"unusable" is WAY better than "could risk life or human safety".

Would you be willing to settle for a CONFIG option or a boot-command
line option which controls whether we fail "safe" or fail "open" if
someone calls getrandom(2) and there isn't enough entropy?  Then each
distribution and/or system integrator can decide whether "proper
systems design" considers "usability" versus "must not fail
insecurely" to be more important.   

	       	      	   	       	    - Ted
