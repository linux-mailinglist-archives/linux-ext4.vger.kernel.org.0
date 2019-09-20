Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E98B9298
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391641AbfITOeE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 10:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391630AbfITOeB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 10:34:01 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81D1F21882
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 14:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568990040;
        bh=5T/4VfiO/HqhsBQATWPC19/qw+SPrKZRtyV53KT0GwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ERG/TepvuolOT6Mw8ez/j7trPLA7A2UHhgppUbM1UKt5I3anQ/LyiAyc1Gzj2TlKM
         sADxzjaDUCB5buPl3eS2UovJkkkCM5lajx430tmkdOhaMKDDGW+G/nttRZzcXhrsdr
         zAieZhwuQe6tN6TAp81EjJVKtEqxNKxDSB5o4mHU=
Received: by mail-wr1-f46.google.com with SMTP id v8so7033462wrt.2
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 07:34:00 -0700 (PDT)
X-Gm-Message-State: APjAAAVI1HdsDoQ1oMJ9Mc8szRBxdAjvKsrzYiyuBoXzwRNozlhWcf+Y
        QGBnP2Z8fK213RnagA5fhVD8zJVYTjfGk6wYBX4CDw==
X-Google-Smtp-Source: APXvYqw97uK1m0GzlqxXwrKua5Pdc2B9TF8UZRisIXGn8aSTnAlq1AfsIBHJ3uk1lXhVKnKKQuKNgHptfa8+mPFi7KY=
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr12713274wrr.343.1568990038968;
 Fri, 20 Sep 2019 07:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com> <20190920134609.GA2113@pc>
In-Reply-To: <20190920134609.GA2113@pc>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Sep 2019 07:33:47 -0700
X-Gmail-Original-Message-ID: <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
Message-ID: <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 6:46 AM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> Hi,
>
> On Wed, Sep 18, 2019 at 04:57:58PM -0700, Linus Torvalds wrote:
> > On Wed, Sep 18, 2019 at 2:17 PM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> > >
> > > Since Linux v3.17, getrandom(2) has been created as a new and more
> > > secure interface for pseudorandom data requests.  It attempted to
> > > solve three problems, as compared to /dev/urandom:
>   >
> > I don't think your patch is really _wrong_, but I think it's silly to
> > introduce a new system call, when we have 30 bits left in the flags of
> > the old one, and the old system call checked them.
> >
> > So it's much simpler and more straightforward to  just introduce a
> > single new bit #2 that says "I actually know what I'm doing, and I'm
> > explicitly asking for secure/insecure random data".
> >
> > And then say that the existing bit #1 just means "I want to wait for entropy".
> >
> > So then you end up with this:
> >
> >     /*
> >      * Flags for getrandom(2)
> >      *
> >      * GRND_NONBLOCK    Don't block and return EAGAIN instead
> >      * GRND_WAIT_ENTROPY        Explicitly wait for entropy
> >      * GRND_EXPLICIT    Make it clear you know what you are doing
> >      */
> >     #define GRND_NONBLOCK               0x0001
> >     #define GRND_WAIT_ENTROPY   0x0002
> >     #define GRND_EXPLICIT               0x0004

What is this GRND_EXPLICIT thing?

A few weeks ago, I sent a whole series to address this, and I
obviously didn't cc enough people.  I'll resend a rebased version
today.  Meanwhile, some comments on this whole mess:

As I think everyone mostly agrees in this whole thread, getrandom()
can't just magically start returning non-random results.  That would
be a big problem.

Linus, I disagree that blocking while waiting for randomness is an
error.  Sometimes you want to generate a key, you want to finish as
quickly as possible, and you don't want to be in the business of
fiddling with the setup of the kernel RNG.  I would argue that *most*
crypto applications are in this category.  I think that the kernel
should, instead, handle this mess itself.  As a first pass, it could
be as simple as noticing that someone is blocking on randomness and
kicking off a thread that does some randomish reads to the rootfs.
This would roughly simulate the old behavior in which an ext4 rootfs
did more IO than necessary.  A fancier version would, as discussed in
this thread, do more clever things.

(As an aside, I am not a fan of xoring or adding stuff to the CRNG
state.  We should just use an actual crypto primitive for this.
Accumulate the state in a buffer and SHA-512 it.  Or use something
like the Keccak duplex sponge.  But this is a discussion for another
day.)

So I'm going to resend my series.  You can all fight over whether the
patch that actually goes in should be based on my series or based on
this patch.

--Andy
