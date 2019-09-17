Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53C2B4DCF
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 14:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfIQMa0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 08:30:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40357 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIQMa0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 08:30:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so2942658wmj.5;
        Tue, 17 Sep 2019 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YBp2v8vFDNAxFhqQgdr+u9iIeUOhuwZckRnxJj0Jxrs=;
        b=E25WSBhPPxHHjzHODS1R3+6Ld++kisQJorRGGHXnMT9BXrzL3H+rV3QSGF8eH79WBk
         nWS3FlJdQoElriRYPYYSi5aWgF/HkTrB7v6/j/YPmt1CpyIDkJi9HRBlYga+LbDq1Q4i
         TsPRxAwdZg7Z6qiNohxiEkWvE6HPgbn+FYMEVVb2UWtCjBTDF+Ka/++DIaBRAY+oqS6E
         CTCmpVLFcDSCqgq7saquKkyzNN9BxipHvKzIC/nXF6GNsbcqHkGK+Z2E+yTrHGl3s3IN
         ftaNjO9xGypzoLxTJznF7K1l55m19XXTz8N7MzV1lm5t04GerAJ4cTghglLxG6jE6WsT
         1piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YBp2v8vFDNAxFhqQgdr+u9iIeUOhuwZckRnxJj0Jxrs=;
        b=C0m/u0HKcBDW0nxfJ5LXct5JGDF9g2xPvvznIRHaOH40D/OTdayUfCJSdNadYId0Vi
         swaOyeIbxuyHdkdsBdz0H8U6SI+SNe+cr5Yt4ixEqH8JbpGzwD2yHhLDJtZ6YmvIHuAt
         AkzhuiIGVLhmWyuXMp9Dga9L418KBHATJU12ISopE+JoU8l7giUntzMJAePeNsUiQNV2
         rkGNW4STPFggWQlRqRGJfrhFXwIVEwM7OUye9KlCU2vFC9jFZvgnuZ5KudPCsPXJ2O1b
         Bch7db/06eCFLwATLM2ZppJltOmMS1oK4pLrzd/UoqttxvoNkOLFnmINPvXulxE9G3rP
         wW7g==
X-Gm-Message-State: APjAAAWxzKogTai9eH/Bl0kmBGY4xeaIv/7fiVMP5CiroHxNZa0Kj/cn
        pP5EpiikabkT9E9MllnHUpdqzPnLP/k=
X-Google-Smtp-Source: APXvYqzQ3PVSAhsuMvzKRoZPeZQdZ/5cLfN+W6bP1BTcEBhiwq5pK91AO7KyXf4CO+VydsZPPZI9jg==
X-Received: by 2002:a1c:1f47:: with SMTP id f68mr3646457wmf.78.1568723423295;
        Tue, 17 Sep 2019 05:30:23 -0700 (PDT)
Received: from debian-stretch-darwi.lab.linutronix.de ([5.158.153.53])
        by smtp.gmail.com with ESMTPSA id a10sm3160082wrv.64.2019.09.17.05.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 05:30:22 -0700 (PDT)
Date:   Tue, 17 Sep 2019 12:30:15 +0000
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Martin Steigerwald <martin@lichtvoll.de>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917121156.GC6762@mit.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 08:11:56AM -0400, Theodore Y. Ts'o wrote:
> On Tue, Sep 17, 2019 at 09:33:40AM +0200, Martin Steigerwald wrote:
> > Willy Tarreau - 17.09.19, 07:24:38 CEST:
> > > On Mon, Sep 16, 2019 at 06:46:07PM -0700, Matthew Garrett wrote:
> > > > >Well, the patch actually made getrandom() return en error too, but
> > > > >you seem more interested in the hypotheticals than in arguing
> > > > >actualities.>
> > > > If you want to be safe, terminate the process.
> > >
> > > This is an interesting approach. At least it will cause bug reports in
> > > application using getrandom() in an unreliable way and they will
> > > check for other options. Because one of the issues with systems that
> > > do not finish to boot is that usually the user doesn't know what
> > > process is hanging.
> >
>
> I would be happy with a change which changes getrandom(0) to send a
> kill -9 to the process if it is called too early, with a new flag,
> getrandom(GRND_BLOCK) which blocks until entropy is available.  That
> leaves it up to the application developer to decide what behavior they
> want.
>

Yup, I'm convinced that's the sanest option too. I'll send a final RFC
patch tonight implementing the following:

config GETRANDOM_CRNG_ENTROPY_MAX_WAIT_MS
	int
	default 3000
	help
	  Default max wait in milliseconds, for the getrandom(2) system
	  call when asking for entropy from the urandom source, until
	  the Cryptographic Random Number Generator (CRNG) gets
	  initialized.  Any process exceeding this duration for entropy
	  wait will get killed by kernel. The maximum wait can be
	  overriden through the "random.getrandom_max_wait_ms" kernel
	  boot parameter. Rationale follows.

	  When the getrandom(2) system call was created, it came with
	  the clear warning: "Any userspace program which uses this new
	  functionality must take care to assure that if it is used
	  during the boot process, that it will not cause the init
	  scripts or other portions of the system startup to hang
	  indefinitely.

	  Unfortunately, due to multiple factors, including not having
	  this warning written in a scary enough language in the
	  manpages, and due to glibc since v2.25 implementing a BSD-like
	  getentropy(3) in terms of getrandom(2), modern user-space is
	  calling getrandom(2) in the boot path everywhere.

	  Embedded Linux systems were first hit by this, and reports of
	  embedded system "getting stuck at boot" began to be
	  common. Over time, the issue began to even creep into consumer
	  level x86 laptops: mainstream distributions, like Debian
	  Buster, began to recommend installing haveged as a workaround,
	  just to let the system boot.

	  Filesystem optimizations in EXT4 and XFS exagerated the
	  problem, due to aggressive batching of IO requests, and thus
	  minimizing sources of entropy at boot. This led to large
	  delays until the kernel's Cryptographic Random Number
	  Generator (CRNG) got initialized, and thus having reports of
	  getrandom(2) inidifinitely stuck at boot.

	  Solve this problem by setting a conservative upper bound for
	  getrandom(2) wait. Kill the process, instead of returning an
	  error code, because otherwise crypto-sensitive applications
	  may revert to less secure mechanisms (e.g. /dev/urandom). We
	  __deeply encourage__ system integrators and distribution
	  builders not to considerably increase this value: during
	  system boot, you either have entropy, or you don't. And if you
	  didn't have entropy, it will stay like this forever, because
	  if you had, you wouldn't have blocked in the first place. It's
	  an atomic "either/or" situation, with no middle ground. Please
	  think twice.

	  Ideally, systems would be configured with hardware random
	  number generators, and/or configured to trust the CPU-provided
	  RNG's (CONFIG_RANDOM_TRUST_CPU) or boot-loader provided ones
	  (CONFIG_RANDOM_TRUST_BOOTLOADER).  In addition, userspace
	  should generate cryptographic keys only as late as possible,
	  when they are needed, instead of during early boot.  (For
	  non-cryptographic use cases, such as dictionary seeds or MIT
	  Magic Cookies, other mechanisms such as /dev/urandom or
	  random(3) may be more appropropriate.)

Sounds good?

thanks,

--
Ahmed Darwish
http://darwish.chasingpointers.com
