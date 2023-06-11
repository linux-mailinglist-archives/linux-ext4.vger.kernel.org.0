Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9416072B209
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Jun 2023 15:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjFKNSj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFKNSj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 09:18:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C66122
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 06:18:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35BDIT6u008970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jun 2023 09:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686489511; bh=+xkUtGh9u39S9wn8koi6UmpOU+diO+cuw1QFieGVGxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To;
        b=ZoTTDcxOTQlRb9cVWi+59RAJMegl3NDjaDk4isvHA1YNDS0YUYliI8QEhnB5EVBCW
         vnlQ4so57LW+eokf8rysFQ01wuB4PV0sRjXxLBtXIeqH/RonYVeQ4a94u23wpz/Zs0
         bsT0f1c1Psg2UNIiznud34y4IgKug8fFJ9lCbT5uIWUEy4t4Mo8Kuci6SADcALB7Xd
         rfE675TwNk/VLhgVdjfBukQoRnVS3kM/4ZSaI6b3+UWSHcbsbkfVwwq71TgIQyqbt1
         NlQrKfL/Cftaj+d+6X2GrO37jUuZ0Lue6IAmCEzpdTvyTp1Eha5NSHL/n3SHpxeZGS
         Ekzux4LeSpXpw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4985A15C00B0; Sun, 11 Jun 2023 09:18:29 -0400 (EDT)
Date:   Sun, 11 Jun 2023 09:18:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid
 context in ext4_update_super
Message-ID: <20230611131829.GA1584772@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2511036.4XsnlVU6TS@suse>
 <2113211.OBFZWjSADL@suse>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 11, 2023 at 09:05:31AM +0200, Fabio M. De Francesco wrote:
> 
> Are you okay with me submitting a patch with your "Suggested by:" tag? Or 
> maybe you prefer to take care of it yourself? For now I await your kind reply.

Sure, feel free to create such a patch.

I would strongly recommend that you use gce-xfstests or kvm-xfstests
before submitting ext4 patches.  In this particular case, it's a
relatively simple patch, but it's a good habit to get into.  See [1]
for more details.

[1] https://thunk.org/gce-xfstests

At the bare minimum, it would be useful for you to run
"{kvm,gce}-xfstests smoke" or more preferably, "{kvm,gce}-xfstests -c
ext4/4k -g auto".  If it's a particular complex patch series, running
"gce-xfstests -c ext4/all -g auto" is nice, since it can save me a lot
of time when y ou've introduced a subtle corner case bug that doesn't
show up with lighter testing, and I have to track it down myself.  The
latter only costs about $2 --- you could do "kvm-xfstests -c ext4/all
-g auto", but it will take a day or so, and it's not much fun unless
you have dedicated test hardware.  So if you can afford the $2, I
strongly recommend using gce-xfstests for the full set of tests.  (The
smoke test using gce-xfstests costs a penny or two, last time I priced
it out.  But it's not too bad to run it using kvm-xfstests.)


> Can we "reliably" test !in_atomic() and act accordingly? I remember that the 
> in_atomic() helper cannot always detect atomic contexts.

No; we can do something like BUG_ON(in_atomic(), but it will only work
if LOCKDEP is enabled, and that's generally is not enabled on
production systems.


On Sun, Jun 11, 2023 at 11:38:07AM +0200, Fabio M. De Francesco wrote:
> In the meantime, I have had time to think of a different solution that allows 
> the workqueue the chance to run even if the file system is configured to 
> immediately panic on error (sorry, no code - I'm in a hurry)...
> 
> This can let you leave that call to ext4_error() that commit 5354b2af3406 
> ("ext4: allow ext4_get_group_info()") had introduced (if it works - please 
> keep on reading).
> 
> 1) Init a global variable ("glob") and set it to 0.
> 2) Modify the code of the error handling workqueue to set "glob" to 1, soon 
> before the task is done.
> 3) Change the fragment that panics the system to call mdelay() in a loop  (it 
> doesn't sleep - correct?) for an adequate amount of time and periodically 
> check READ_ONCE(global) == 1. If true, break and then panic, otherwise 
> reiterate the loop.

Well, it's more than a bit ugly, and it's not necessasrily guaranteed
to work.  After all we're doing this to allow ext4_error() to be
called in critical sections.  But that means that while we're doing
this mdelay loop, we're holding on to a spinlock.  While lockdep isn't
smart enough to catch this particular deadlock, it's still a real
potential problem, which means such a solution is also fragile.

It's better off simply prohibiting ext4_error() to be called while
holding a lock, and in most places this isn't all that hard.  Most of
the time, you don't want to hold spinlocks across a long period of
time, because this can become a scalability bottleneck.  This means
very often the pattern is something like this:

      spin_lock(..);
         ...
      ret = do_stuff();
      spin_unlock(..);

So it's enough to check the error return after you've unlocked the
spinlock.  And you can also just _not_ call ext4_error() inside
do_stuff(), but have do_stuff return an error code, possibly with a
call to ext4_warning() if you want to get some context for the problem
into the kernel log, and then have the top-level function call
ext4_error().

Cheers,

						- Ted
