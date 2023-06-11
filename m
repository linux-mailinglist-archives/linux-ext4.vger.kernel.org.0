Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDBC72B38D
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Jun 2023 21:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjFKTQF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 15:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjFKTQE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 15:16:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF536E42
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 12:15:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30fa23e106bso1369063f8f.3
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686510958; x=1689102958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHWKitVSNUTXHYt2b56fiVAJSf54M0aboHdzY/wLjqg=;
        b=DZ2BDxOpfpt+df3o+UzH8/lrfrU0DH8A6Vik5h6ZgBL+WMhCt5zVr15OBv2h9/atat
         GJzebf6xfgDB140t17XU42V6eDURbu5dSGb1c42nGq1PKvSWuc1Mjd2m/TuJQKPRbCX5
         jyrmaW23BiJZXTGA5AFRA7zaOWXbp+byUXht2Bk08NcVa1ke28Ct06wxMNiVZL3rq1nT
         YfMaR01DF2tWKzMputiaaj61ROpLh5bn8geN+oab6zpB1s8Z1ulL1vauzWjtAexwSECW
         xjJwWfmJHuuJnmW4nn00oOdyJvu5WpRhRkxx1CkMwp//cV8fcx3SYqGgBGvQ3Ubqwnd2
         8yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686510958; x=1689102958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHWKitVSNUTXHYt2b56fiVAJSf54M0aboHdzY/wLjqg=;
        b=WKaForiqj4n39ckjb/Zx41Q8rUTxkLPCRnWavx9U9khNdnzfRx6Gq1DAbNzY/+R0Hz
         qA7Us9KBFKJru6/wQqsJ2hRx6uKMJxqifhbHZ341mQS7FwGVzOF4So5Pnb7Y5m4JYiP1
         Ht+77Y12UBLE1YwlRZ8dcmC76aeOywEh3GWFrBVke9ZNHwvCroCXaxvrcizOPabgMtKK
         Pe3eHCQTkTY3TzADv4jaeq9usD5VOtKX9u5ZFYWzoPzudWnMPo7FKtTjso0YzJmG6FTP
         rGifcqBIS6/6l2L4iHfWPBz3L2KdPuYQ/d9XECtLw8pSBvTJYecc8y6OWESTr0oI4eqP
         FbvA==
X-Gm-Message-State: AC+VfDxwtUzfiIBTczEMPMFdZQlxoPCCBxN4v/EhZE9nWw2uPAZU98Tc
        4089FDbSSVfZVe5cGgh2Ls94KHuhlk4=
X-Google-Smtp-Source: ACHHUZ6xgAYxDdmO0xHFRtBBGFMvG7XGX2Ah9AsdxgVQFi6gZaHmvWqC0EiKXm4vxepdFkr8o+J2JA==
X-Received: by 2002:a5d:6412:0:b0:30f:bafb:247a with SMTP id z18-20020a5d6412000000b0030fbafb247amr2146292wru.55.1686510958006;
        Sun, 11 Jun 2023 12:15:58 -0700 (PDT)
Received: from suse.localnet (host-95-252-166-216.retail.telecomitalia.it. [95.252.166.216])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c224b00b003f8126bcf34sm4799285wmm.48.2023.06.11.12.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:15:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid context in
 ext4_update_super
Date:   Sun, 11 Jun 2023 21:15:56 +0200
Message-ID: <7741416.gsGJI6kyIV@suse>
In-Reply-To: <20230611131829.GA1584772@mit.edu>
References: <20230611131829.GA1584772@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On domenica 11 giugno 2023 15:18:29 CEST Theodore Ts'o wrote:
> On Sun, Jun 11, 2023 at 09:05:31AM +0200, Fabio M. De Francesco wrote:
> > Are you okay with me submitting a patch with your "Suggested by:" tag? Or
> > maybe you prefer to take care of it yourself? For now I await your kind
> > reply.
> Sure, feel free to create such a patch.

Thanks!

Let me summarize, just to be sure we don't misunderstand each other... 

To start off, I'll send out _only_ the patch for the bug reported by Syzbot, 
the one about dropping the call to ext_error() in ext4_get_group_info(). 

I'll do this by Tuesday. (Sorry, I cannot do it by Monday because I must pass 
an exam and an interview for a job).

However, on the other problems with ext4_grp_locked_error() that you noticed 
in the final part of your first message in this thread I'll need some days 
more to better understand the context I'm working in.

> I would strongly recommend that you use gce-xfstests or kvm-xfstests
> before submitting ext4 patches.  In this particular case, it's a
> relatively simple patch, but it's a good habit to get into.  See [1]
> for more details.
> 
> [1] https://thunk.org/gce-xfstests

Thanks also for these information. 

In the last year I have been sending several patches patches for filesystems, 
several little things that comprise conversions (sometimes with additional 
related work, like a series of 5 patches to fs/sysv). 

The only tools I've ever needed were running (x)fstests on a QEMU/KVM x86_32 
VM, 6GB RAM, booting a Kernel with HIGHMEM64G enabled (for PAE).

Never heard about {kvm,gce}-xfstests. I'll have a look at the link and try 
these tests. I can afford $2, but at the moment I don't want to assemble a 
dedicated hardware for tests. 

What's the problem with running those tests in QEMU/KVM VMs??? 

Ah, I just recalled that in December 2022 I sent you three conversion from the 
old kmap{,_atomic} that went reviewed by Jan K. and Ira W.. It was tested with 
fstests as I explained above. That patch got lost, in fact I still see at 
least a kmap_atomic() call site in ext4. One call site is no more in ext4. The 
third today uses kmap_local_folio(). 

Well, everybody dislike to see their patches completely ignored (https://
lore.kernel.org/lkml/20221231174439.8557-1-fmdefrancesco@gmail.com/). If you 
wanted you could at least apply the part regarding the kmap_atomic() 
conversion in ext4_journalled_write_inline_data(). 

Or I can convert the call to kmap_atomic() to kmap_local_folio(), if you 
wanted. It's up to you, please let me know.

> At the bare minimum, it would be useful for you to run
> "{kvm,gce}-xfstests smoke" or more preferably, "{kvm,gce}-xfstests -c
> ext4/4k -g auto".  If it's a particular complex patch series, running
> "gce-xfstests -c ext4/all -g auto" is nice, since it can save me a lot
> of time when y ou've introduced a subtle corner case bug that doesn't
> show up with lighter testing, and I have to track it down myself.  The
> latter only costs about $2 --- you could do "kvm-xfstests -c ext4/all
> -g auto", but it will take a day or so, and it's not much fun unless
> you have dedicated test hardware.  So if you can afford the $2, I
> strongly recommend using gce-xfstests for the full set of tests.  (The
> smoke test using gce-xfstests costs a penny or two, last time I priced
> it out.  But it's not too bad to run it using kvm-xfstests.)

OK, again thanks for these additional information. I'll surely use all this.

> 
> > Can we "reliably" test !in_atomic() and act accordingly? I remember that 
the
> > in_atomic() helper cannot always detect atomic contexts.
> 
> No; we can do something like BUG_ON(in_atomic(), 

OK, it's the same from the other side of the ways to look at it.

> but it will only work
> if LOCKDEP is enabled, 

I don't know what others do. I always enable LOCKDEP, also in production 
systems.

> and that's generally is not enabled on
> production systems.

Ah, OK.

> On Sun, Jun 11, 2023 at 11:38:07AM +0200, Fabio M. De Francesco wrote:
> > In the meantime, I have had time to think of a different solution that
> > allows
> > the workqueue the chance to run even if the file system is configured to
> > immediately panic on error (sorry, no code - I'm in a hurry)...
> > 
> > This can let you leave that call to ext4_error() that commit 5354b2af3406
> > ("ext4: allow ext4_get_group_info()") had introduced (if it works - please
> > keep on reading).
> > 
> > 1) Init a global variable ("glob") and set it to 0.
> > 2) Modify the code of the error handling workqueue to set "glob" to 1, 
soon
> > before the task is done.
> > 3) Change the fragment that panics the system to call mdelay() in a loop 
> > (it
> > doesn't sleep - correct?) for an adequate amount of time and periodically
> > check READ_ONCE(global) == 1. If true, break and then panic, otherwise
> > reiterate the loop.
> 
> Well, it's more than a bit ugly,

I fully agree. I'm still in search of a reliable way to let atomic context run 
idle waiting for a status change. I am talking about atomic code in paths that 
we don't mind if they loop for few seconds (like the case at hand - we don't 
care to panic immediately or within a sec or two. Do we care???

> and it's not necessarily guaranteed
> to work.

Why not? AFAIK, mdelay() doesn't trigger SAC bugs because it doesn't sleep, 
very differently than msleep(). What's the problem to wait for panicking a 
little later without causing bugs? Any other means to signal in atomic context 
from a workqueue that is done with the assigned work?

> After all we're doing this to allow ext4_error() to be
> called in critical sections.  But that means that while we're doing
> this mdelay loop, we're holding on to a spinlock.  While lockdep isn't
> smart enough to catch this particular deadlock, it's still a real
> potential problem, which means such a solution is also fragile.
> 
> It's better off simply prohibiting ext4_error() to be called while
> holding a lock, and in most places this isn't all that hard. 

I'll do as you asked, but (out of curiosity and especially for the purpose of 
stealing knowledge from very experienced Kernel hackers like you, can you 
please set aside some more minutes to answer all my questions above?

Thanks in advance,

Fabio

> Most of
> the time, you don't want to hold spinlocks across a long period of
> time, because this can become a scalability bottleneck.  This means
> very often the pattern is something like this:
> 
>       spin_lock(..);
>          ...
>       ret = do_stuff();
>       spin_unlock(..);
> 
> So it's enough to check the error return after you've unlocked the
> spinlock.  And you can also just _not_ call ext4_error() inside
> do_stuff(), but have do_stuff return an error code, possibly with a
> call to ext4_warning() if you want to get some context for the problem
> into the kernel log, and then have the top-level function call
> ext4_error().

OK, yours is the right solution. Furthermore I didn't know about the 
importance to show the errors exactly where they currently are. As said, I'll 
follow your suggestion, but I'd like to know the answers at my questions, 
please :-)

> 
> Cheers,
> 
> 						- Ted

Again, thanks for all the time you are devoting to a newcomer like I am.

Fabio


