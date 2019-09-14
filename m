Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC00CB2BBC
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfINPCQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 11:02:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38888 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfINPCP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 11:02:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so5642303wme.3;
        Sat, 14 Sep 2019 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mMOMMNUQ7rvMvo5/g+Bua3yjd+yLYQVgTyXgh4mnFag=;
        b=NSqVRzEPdBFSL55/YmV+cg/jx7/aM55zhs0fNUsElm0Yh/yXmWtY2MKuiGx4ecspbr
         9Cyek6GFoDpYdTi7+ROGCjFCwhQ/d9BqpqoNY1zbK0b3of853GCi1aXNM+902IfWUTby
         TR9kwpVZHKUr/IcE6L8KZMjcyBvcDplet3YO3vaURYY2vBD51FCihNMakd6JQrZTB5b3
         lcqH4eueux7ptiNGYdxDp/XZXQVrDrD1mFEw7/iu5E+VKwjqNxLbRpyJO7Ot+57Q7rAc
         igWVmPEVZwF3y5sDWOiMFgTPEyapf6vJhv2oRkaI4OvwVY2UFZ9U1YlX2y6k7yf1dCzt
         Tv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mMOMMNUQ7rvMvo5/g+Bua3yjd+yLYQVgTyXgh4mnFag=;
        b=gpJoqblENAIsiyqMz3l7btGvt/i612wIPQgsJ8nhPpKqu5XXXiToWpxp2EgsacQpjs
         dAyT4ywk1mgd7QhFw2InLXgefILbEQruwzCOlwe9uQUrNMhmXcG8KdieUFI5mZjEkHF/
         DYa9MN2toIhlKREa8ZJJA7UtkBfKW4uHhQECveTx5Z5pbA6bGSyyJ52+IVm+FcvQWgUx
         aqyq2coBnHTpvttpm1LHo7gMM+GbBxd1sNKJKxHpd6nAc5fallL7FVC7DBgJcF+OZ0T6
         JCPJxGL05h9uOksBhRAwc32xva6MpDjSFa58lRWJZ88invsjzBudqYuqHNStBKE3Nn4k
         FQhQ==
X-Gm-Message-State: APjAAAVmRYWI6rCUd1ePiBsrfQPy7e0/THOHioNJ/adjA2FiTkESM+9E
        96eis8pgA8d8ZEJbcOfujO8=
X-Google-Smtp-Source: APXvYqyd07s0MMmHJ9O5HTsIyshLJSqP0TwdoonPy5ZWKxr9qEsgi32Hw8iN8Usrw3MQEwDug0FYRg==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr7439138wmb.151.1568473332696;
        Sat, 14 Sep 2019 08:02:12 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D1401AF0812D8DEE03BEC.dip0.t-ipconnect.de. [2003:d0:6f2d:1401:af08:12d8:dee0:3bec])
        by smtp.gmail.com with ESMTPSA id m62sm7833183wmm.35.2019.09.14.08.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 08:02:11 -0700 (PDT)
Date:   Sat, 14 Sep 2019 17:02:06 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190914150206.GA2270@darwi-home-pc>
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 12, 2019 at 12:34:45PM +0100, Linus Torvalds wrote:
> On Thu, Sep 12, 2019 at 9:25 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > Hmm, one thought might be GRND_FAILSAFE, which will wait up to two
> > minutes before returning "best efforts" randomness and issuing a huge
> > massive warning if it is triggered?
> 
> Yeah, based on (by now) _years_ of experience with people mis-using
> "get me random numbers", I think the sense of a new flag needs to be
> "yeah, I'm willing to wait for it".
>
> Because most people just don't want to wait for it, and most people
> don't think about it, and we need to make the default be for that
> "don't think about it" crowd, with the people who ask for randomness
> sources for a secure key having to very clearly and very explicitly
> say "Yes, I understand that this can take minutes and can only be done
> long after boot".
> 
> Even then people will screw that up because they copy code, or some
> less than gifted rodent writes a library and decides "my library is so
> important that I need that waiting sooper-sekrit-secure random
> number", and then people use that broken library by mistake without
> realizing that it's not going to be reliable at boot time.
> 
> An alternative might be to make getrandom() just return an error
> instead of waiting. Sure, fill the buffer with "as random as we can"
> stuff, but then return -EINVAL because you called us too early.
>

ACK, that's probably _the_ most sensible approach. Only caveat is
the slight change in user-space API semantics though...

For example, this breaks the just released systemd-random-seed(8)
as it _explicitly_ requests blocking behvior from getrandom() here:

    => src/random-seed/random-seed.c:
    /*
     * Let's make this whole job asynchronous, i.e. let's make
     * ourselves a barrier for proper initialization of the
     * random pool.
     */
     k = getrandom(buf, buf_size, GRND_NONBLOCK);
     if (k < 0 && errno == EAGAIN && synchronous) {
         log_notice("Kernel entropy pool is not initialized yet, "
                    "waiting until it is.");
                    
         k = getrandom(buf, buf_size, 0); /* retry synchronously */
     }
     if (k < 0) {
         log_debug_errno(errno, "Failed to read random data with "
                         "getrandom(), falling back to "
                         "/dev/urandom: %m");
     } else if ((size_t) k < buf_size) {
         log_debug("Short read from getrandom(), falling back to "
	           "/dev/urandom: %m");
     } else {
         getrandom_worked = true;
     }

Nonetheless, a slightly broken systemd-random-seed, that was just
released only 11 days ago (v243), is honestly much better than a
*non-booting system*...

I've sent an RFC patch at [1].

To handle the systemd case, I'll add the discussed "yeah, I'm
willing to wait for it" flag (GRND_BLOCK) in v2.

If this whole approach is going to be merged, and the slight ABI
breakage is to be tolerated (hmmmmm?), I wonder how will systemd
random-seed handle the semantics change though without doing
ugly kernel version checks..

thanks,

[1] https://lkml.kernel.org/r/20190914122500.GA1425@darwi-home-pc

--
darwi
http://darwish.chasingpointers.com
