Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5AC1064
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Sep 2019 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfI1JbC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Sep 2019 05:31:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54027 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfI1JbB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Sep 2019 05:31:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so8294644wmd.3;
        Sat, 28 Sep 2019 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TCs/8nlpXbSdnRhoVRZAnKrxE2CTT3D9lBs8voTjYNs=;
        b=rVWQuWjy036UQ2W5RkKo4ubOfrcqumSywP0JeXL5bNOPIyACFAcFnAc4haFoj8WO/G
         eB4RdWcEIoCVjTEH93C3rJuuC+hAg1w8EPfKIsgU//w4E15Mj8AR6+RUhwSM62RtNUFD
         kmCsYOV6JVYv604pW1YcAyR9B69FEx1gj4KkZNL8u0HlOB4y7LZilUGxX39GLsX9oIPn
         pS4iDY3wZd0efd8sljR24a3/76TCunEa3UcLdZeYVdCjDAohOIVkFd3vlP8swFeR0Qf1
         Gc7iG4aFMn39NtYwmjlRPaM2x1XZo66KWvvjWO9FC6qm/d1Ayz0UClwdAIcd3+Q/EqLg
         29dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TCs/8nlpXbSdnRhoVRZAnKrxE2CTT3D9lBs8voTjYNs=;
        b=Ex8jtlbuLAQ9wc0JirI6bQm1e3hIzXFvn8NACQdXWDIaN2cKBqGmogRoDdLEkbaUvB
         jS40pC1NGzv32huknfJ6+tZfxFfs9mTaQ1MthK5fpVvxmRedRIz6DFssfZMUGcQMwvap
         BYMvjDmNZ/VXVOAAk0J9zdLHgyBCJTzwZuaEfxxnYutufJz6LKesgHmVt5yBAB8IDE+Q
         GuaSbs3McFdJCta+FrYQaJVHWi7Qc2YRtVrwA0OxM2Xj8hyoEvQUbZKGWbmpG5hRci8G
         MfC6633f7JX4d0rHjcEZJijpgjs16BCjfxDhZW9r/WFeU/dzmGZVPm7XUfJG0BqWM5yO
         k/ag==
X-Gm-Message-State: APjAAAV4PSVQjyyNWyw1RYUHAnDPFtJyoeNdkTXcsB0A6Pz95Eh52wA7
        dayjkLSTU3OlQYLESGIVZsAAw6anZWFyyw==
X-Google-Smtp-Source: APXvYqwPv49Z9qq8s4Li6UkyxiroJ52geU4gAaCCVqsL9cci41z6vRBV3TqjGf0oFg0mcukKWLpMng==
X-Received: by 2002:a05:600c:284:: with SMTP id 4mr9742207wmk.107.1569663058527;
        Sat, 28 Sep 2019 02:30:58 -0700 (PDT)
Received: from darwi-home-pc (ip-109-42-2-0.web.vodafone.de. [109.42.2.0])
        by smtp.gmail.com with ESMTPSA id f18sm6349267wmh.43.2019.09.28.02.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 02:30:57 -0700 (PDT)
Date:   Sat, 28 Sep 2019 11:30:46 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Florian Weimer <fweimer@redhat.com>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] random: getrandom(2): warn on large CRNG waits,
 introduce new flags
Message-ID: <20190928093046.GA1039@darwi-home-pc>
References: <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190926204217.GA1366@pc>
 <20190926204425.GA2198@pc>
 <9a9715dc-e30b-24fb-a754-464449cafb2f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9715dc-e30b-24fb-a754-464449cafb2f@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 26, 2019 at 02:39:44PM -0700, Andy Lutomirski wrote:
> On 9/26/19 1:44 PM, Ahmed S. Darwish wrote:
> > Since Linux v3.17, getrandom(2) has been created as a new and more
> > secure interface for pseudorandom data requests.  It attempted to
> > solve three problems, as compared to /dev/urandom:
> > 
> >    1. the need to access filesystem paths, which can fail, e.g. under a
> >       chroot
> > 
> >    2. the need to open a file descriptor, which can fail under file
> >       descriptor exhaustion attacks
> > 
> >    3. the possibility of getting not-so-random data from /dev/urandom,
> >       due to an incompletely initialized kernel entropy pool
> > 
> > To solve the third point, getrandom(2) was made to block until a
> > proper amount of entropy has been accumulated to initialize the CRNG
> > ChaCha20 cipher.  This made the system call have no guaranteed
> > upper-bound for its initial waiting time.
> > 
> > Thus when it was introduced at c6e9d6f38894 ("random: introduce
> > getrandom(2) system call"), it came with a clear warning: "Any
> > userspace program which uses this new functionality must take care to
> > assure that if it is used during the boot process, that it will not
> > cause the init scripts or other portions of the system startup to hang
> > indefinitely."
> > 
> > Unfortunately, due to multiple factors, including not having this
> > warning written in a scary-enough language in the manpages, and due to
> > glibc since v2.25 implementing a BSD-like getentropy(3) in terms of
> > getrandom(2), modern user-space is calling getrandom(2) in the boot
> > path everywhere (e.g. Qt, GDM, etc.)
> > 
> > Embedded Linux systems were first hit by this, and reports of embedded
> > systems "getting stuck at boot" began to be common.  Over time, the
> > issue began to even creep into consumer-level x86 laptops: mainstream
> > distributions, like Debian Buster, began to recommend installing
> > haveged as a duct-tape workaround... just to let the system boot.
> > 
> > Moreover, filesystem optimizations in EXT4 and XFS, e.g. b03755ad6f33
> > ("ext4: make __ext4_get_inode_loc plug"), which merged directory
> > lookup code inode table IO, and very fast systemd boots, further
> > exaggerated the problem by limiting interrupt-based entropy sources.
> > This led to large delays until the kernel's cryptographic random
> > number generator (CRNG) got initialized.
> > 
> > On a Thinkpad E480 x86 laptop and an ArchLinux user-space, the ext4
> > commit earlier mentioned reliably blocked the system on GDM boot.
> > Mitigate the problem, as a first step, in two ways:
> > 
> >    1. Issue a big WARN_ON when any process gets stuck on getrandom(2)
> >       for more than CONFIG_GETRANDOM_WAIT_THRESHOLD_SEC seconds.
> > 
> >    2. Introduce new getrandom(2) flags, with clear semantics that can
> >       hopefully guide user-space in doing the right thing.
> > 
> > Set CONFIG_GETRANDOM_WAIT_THRESHOLD_SEC to a heuristic 30-second
> > default value. System integrators and distribution builders are deeply
> > encouraged not to increase it much: during system boot, you either
> > have entropy, or you don't. And if you didn't have entropy, it will
> > stay like this forever, because if you had, you wouldn't have blocked
> > in the first place. It's an atomic "either/or" situation, with no
> > middle ground. Please think twice.
> 
> So what do we expect glibc's getentropy() to do?  If it just adds the new
> flag to shut up the warning, we haven't really accomplished much.

Yes, if glibc adds GRND_SECURE_UNBOUNDED_INITIAL_WAIT to gentropy(3),
then this exercise would indeed be invalidated. Hopefully,
coordination with glibc will be done so it won't happen... @Florian?

Afterwards, a sane approach would be for gentropy(3) to be deprecated,
and to add getentropy_secure_unbounded_initial_wait(3) and
getentropy_insecure(3).

Note that this V5 patch does not claim to fully solve the problem, but
it will:

  1. Pinpoint to the processes causing system boots to block
  
  2. Tell people what correct alternative to use when facing problem
     #1 above, through the proposed getrandom_wait(7) manpage. That
     manpage page will fully describe the problem, and advise
     user-space to either use the new getrandom flags, or the new
     glibc gentropy_*() variants.

thanks,

--
Ahmed Darwish
