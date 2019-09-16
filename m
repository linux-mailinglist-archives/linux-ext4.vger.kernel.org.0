Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A912B3EB4
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfIPQRa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 12:17:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46083 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIPQRa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 12:17:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so379706lfc.13
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qm5nFp4L20gwZCk9xWhvdF6dE9PnPMuHjDPFlxhyVHw=;
        b=MwiU5mWXMBSXfDgbMXxLnobo8HMGeJQR80lomHYctbelSfvBbvltS81l9dAKTU1gLz
         dsS8BFsV+weSgE45H3VfjD88vhb4mAU1RPEwWm+45it3Ah1tAVI/MAkb/nAk+iJU0WeD
         g8hBBvmDRQhs1SLCmtlw/SSvnhl9EIlxC1+wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qm5nFp4L20gwZCk9xWhvdF6dE9PnPMuHjDPFlxhyVHw=;
        b=TyoHNvnYxb5H40rmaCrfJFP0MEE1ibl4jQXlD0JBX3bCBqaJ7qZH7pJ4ORU/xcQ3kw
         fuNneWH2ny0aduDmrzroS7fJtR1WaJXzOZTLzvQfExp4YuV/lGYvaHYk5EuXv4OUwUK1
         2EiXHmuy/RWuBodKDC/K6vuD+AvVemIz/vJkoofpgkI5w0h5oMtgZiIx7S0y0ybT9K6S
         iuUmCxb/aAYU3PwikWuZZXKe6XjC7F2J84q4a+HJ7//uPFiuWnc7CkbWpJ8MOBQdhRiw
         S0cC/uNGPJHDBQuogbFEfPSwGYWX9gR5y/6H5hQcWJYxJab86Uo6Ojq94woPL1VWSOIM
         NQqw==
X-Gm-Message-State: APjAAAVeAj53DK1SZZHonC/g1iBTGW1AzTD9gwYpQht+ZJUaI7y2TxfH
        MBTLOnwcaATJ9/aRIXF+b1aBo6sXq3k=
X-Google-Smtp-Source: APXvYqxM30qcmRg/4vIvQXU1r6odnnHIPrtWLhBP+p4nOFa9aW7y8VjU/ptLmXkVT+lsEWhqIKD6ow==
X-Received: by 2002:ac2:5181:: with SMTP id u1mr141947lfi.114.1568650647850;
        Mon, 16 Sep 2019 09:17:27 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w13sm4370153ljh.104.2019.09.16.09.17.27
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 09:17:27 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id q11so390026lfc.11
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 09:17:27 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr116710lfh.29.1568650646859;
 Mon, 16 Sep 2019 09:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login> <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc> <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu> <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com> <20190916061252.GA24002@1wt.eu>
In-Reply-To: <20190916061252.GA24002@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 09:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
Message-ID: <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 11:13 PM Willy Tarreau <w@1wt.eu> wrote:
>
> >
> > So three out of four flag combinations end up being mostly "don't
> > use", and the fourth one isn't what you'd normally want (which is just
> > plain /dev/urandom semantics).
>
> I'm seeing it from a different angle. I now understand better why
> getrandom() absolutely wants to have an initialized pool, it's to
> encourage private key producers to use a secure, infinite source of
> randomness.

Right. There is absolutely no question that that is a useful thing to have.

And that's what GRND_RANDOM _should_ have meant. But didn't.

So the semantics that getrandom() should have had are:

 getrandom(0) - just give me reasonable random numbers for any of a
million non-strict-long-term-security use (ie the old urandom)

    - the nonblocking flag makes no sense here and would be a no-op

 getrandom(GRND_RANDOM) - get me actual _secure_ random numbers with
blocking until entropy pool fills (but not the completely invalid
entropy decrease accounting)

    - the nonblocking flag is useful for bootup and for "I will
actually try to generate entropy".

and both of those are very very sensible actions. That would actually
have _fixed_ the problems we had with /dev/[u]random, both from a
performance standpoint and for a filesystem access standpoint.

But that is sadly not what we have right now.

And I suspect we can't fix it, since people have grown to depend on
the old behavior, and already know to avoid GRND_RANDOM because it's
useless with old kernels even if we fixed it with new ones.

Does anybody really seriously debate the above? Ted? Are you seriously
trying to claim that the existing GRND_RANDOM has any sensible use?
Are you seriously trying to claim that the fact that we don't have a
sane urandom source is a "feature"?

                   Linus
