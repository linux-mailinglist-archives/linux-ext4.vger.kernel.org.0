Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C37B33E3
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 06:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfIPEV3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 00:21:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40169 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfIPEV2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 00:21:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id d17so8429851lfa.7
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 21:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rq2sexGvXyylQNcdJFz5T59iDA//hf3VzmIhHtRsXOM=;
        b=TS2dDRbURQUMp4r1Uisuw67wWuJoMZhNT5OPAXaweTtn6/78ZH4Rpp+VPWpR7o2NR1
         CboY8r7rDnKIGZ7IabPeLJ0qQ0BIXf2FzGUQw3ZtQS+i8c5fRMmwkQjWvgDauyGBly1Z
         erb+PTSfVUna3DOAM0EpjpQnfViDxx/7mZRjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rq2sexGvXyylQNcdJFz5T59iDA//hf3VzmIhHtRsXOM=;
        b=lod4cQnYClW+3IkBb4MW5hrJv1AkQJBxbP0p/yVVUdnAUmBO3yH87H4zXk34PDGssD
         xHqCjuMuo7W1vrhY3LIeiyxiYw5qVrEiqT5XusfBSA5XHph4bfSqbNyi/rJwHxHaNuKh
         jionb1YCCeS5rroI1PUeV1fiTs1sILixgjoQPec44rjE6/qU12z51X1t5OB6cc3AS1zN
         ST36Z2XPkPSF6erBvFSeNMq/57DlX21szHJyH4k1UYlNbzzuL+073XcPnzfIbAySbgVv
         q6TZK/0eWStX5wn9lqbRQSyv/w6Z5YY8FnmYpllzVEwLnKSpdutbeTRoM+pTvrV1rhbF
         sCdA==
X-Gm-Message-State: APjAAAVppecB4/f09eQst4IC8QwrYyk7fQkGPR3GF/oAmbcMLrVykKTA
        g/iEnGYPKZ7S/vnVjzjBsZaM8ka9VTs=
X-Google-Smtp-Source: APXvYqxHsx9q6Hfxj0wbQ3Y7/uf6fki5UzeW6/IIYLY+3ywOyovFbtPmAnMJqZqYVEWAgAilHvhFDg==
X-Received: by 2002:a19:f512:: with SMTP id j18mr19064502lfb.169.1568607684751;
        Sun, 15 Sep 2019 21:21:24 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w16sm1588621lji.42.2019.09.15.21.21.22
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 21:21:23 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id s19so1690727lji.6
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 21:21:22 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr28431238ljo.180.1568607682512;
 Sun, 15 Sep 2019 21:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190911160729.GF2740@mit.edu> <20190916035228.GA1767@gondor.apana.org.au>
In-Reply-To: <20190916035228.GA1767@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 21:21:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQeiYu8Q_wcMgM-nAcW7KsBfG1+90DaTD5WF2cCeGCgA@mail.gmail.com>
Message-ID: <CAHk-=wjQeiYu8Q_wcMgM-nAcW7KsBfG1+90DaTD5WF2cCeGCgA@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 8:52 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Can we perhaps artifically increase the interrupt rate while the
> CRNG is not initialised?

Long term (or even medium term in some areas), the problem really is
that device interrupts during boot really are going away, rather than
becoming more common.

That just happened to be the case now because of improved plugging,
but it's fundamentally the direction any storage is moving with faster
flash interfaces.

The only interrupt we could easily increase the rate of in the kernel
is the timer interrupt, but that's also the interrupt that is the
least useful for randomness.

The timer interrupt could be somewhat interesting if you are also
CPU-bound on a non-trivial load, because then "what program counter
got interrupted" ends up being possibly unpredictable - even with a
very stable timer interrupt source - and effectively stand in for a
cycle counter even on hardware that doesn't have a native TSC. Lots of
possible low-level jitter there to use for entropy. But especially if
you're just idly _waiting_ for entropy, you won't be "CPU-bound on an
interesting load" - you'll just hit the CPU idle loop all the time so
even that wouldn't work.

But practically speaking timers really are not really much of an
option. And if we are idle, even having a high-frequency TSC isn't all
that useful with the timer interrupt, because the two tend to be very
intimately related.

Of course, if you're generating a host key for SSH or something like
that, you could try to at least cause some network traffic while
generating the key. That's not much of an option for the _kernel_, but
for a program like ssh-keygen it certainly could be.

Blocking is fine if you simply don't care about time at all (the "five
hours later is fine" situation), or if you have some a-priori
knowledge that the machine is doing real interesting work that will
generate entropy. But I don't see how the kernel can generate entropy
on its own, particularly during boot (which is when the problem
happens), when most devices aren't even necessarily meaningfully set
up yet.

Hopefully hw random number generators will make this issue effectively
moot before we really end up having the "nvdimms and their ilk are
common enough that you really have no early boot irq-driven disk IO at
all".

           Linus
