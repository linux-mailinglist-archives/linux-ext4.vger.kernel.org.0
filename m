Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D900AB3189
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 21:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfIOTFQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 15:05:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34849 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfIOTFP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 15:05:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1so207792ljc.2
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oP+K/Zty/5Eq3dLtmg1ohj585ZAG9DxfRL/uBO87TVA=;
        b=ZbdST7EmT75LmzbCteN6qEe5ZYtv+VqtbPOMfDEfSB2Sl+0Wja2v4xXoUQnh9HZZJE
         84kSoPHUTuc/TUM8RDZ6/cZRgEnsP0xfDBw0ai28cdu4bSFq45w/+JGJsbXvO54jsHCN
         f+JdY+GKJvAQvqPONNqYbX1ul8kh+5gunBRJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oP+K/Zty/5Eq3dLtmg1ohj585ZAG9DxfRL/uBO87TVA=;
        b=m/gOgMRjoTplk2yXL685lJJsk6b7AMZc3K3vr188A2oKM0e72dpUk/LXd/ULomMLJB
         PDTjsuTGXsZCIwv3yQsjuFWnDHjIRCJq/NJN3hU/yHUYmd/W/+zB5m/AonAZy3l9dxd1
         tCnxSEXOh/x9LUxZvqsxluHy29tZg1tGMRM2cisIFo2nKFYCZm2SiekE9wzcxbbOb0Si
         v8reR7GCpMHVefTlyHL0FoKj4wZcWUuJ5rLsxT7BnsvQRv59ICva1Xr0TLa0q5tn5yC8
         tPSDNEH0has7y5w4SUXvv6Pqa2g0B6ewdopnALB+SVXwnKFjk1vr6GWkhU88Y61eSgak
         6UXQ==
X-Gm-Message-State: APjAAAV3b7UFlHJJnUOCHbZJ8T8+m8DZ7s3p6r88DcLY2CYRl28mh4I5
        mQFC94t0WL++7QsYkJZi8MMg6UHi2Jo=
X-Google-Smtp-Source: APXvYqwf8Xd/gz1+1g2W5tZaZ0gqFxIFyWFD80XUZa3Fa0dllV2fmEwSh6nB6DtkrhDJV+5q6PLZkg==
X-Received: by 2002:a2e:8104:: with SMTP id d4mr32281729ljg.151.1568574311855;
        Sun, 15 Sep 2019 12:05:11 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 77sm7976748ljf.85.2019.09.15.12.05.11
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 12:05:11 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id e17so31665015ljf.13
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 12:05:11 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr27700804ljo.180.1568573997850;
 Sun, 15 Sep 2019 11:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190915183240.GA23155@1wt.eu>
In-Reply-To: <20190915183240.GA23155@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 11:59:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0tSUuxqaCDMtwqdVbwvTXw2ZH2k1URHz069RTznEfVw@mail.gmail.com>
Message-ID: <CAHk-=wi0tSUuxqaCDMtwqdVbwvTXw2ZH2k1URHz069RTznEfVw@mail.gmail.com>
Subject: Re: [PATCH RFC v2] random: optionally block in getrandom(2) when the
 CRNG is uninitialized
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <mzxreary@0pointer.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 11:32 AM Willy Tarreau <w@1wt.eu> wrote:
>
> I think that the exponential decay will either not be used or
> be totally used, so in practice you'll always end up with 0 or
> 30s depending on the entropy situation

According to the systemd random-seed source snippet that Ahmed posted,
it actually just tries once (well, first once non-blocking, then once
blocking) and then falls back to reading urandom if it fails.

So assuming there's just one of those "read much too early" cases, I
think it actually matters.

But while I tried to test this, on my F30 install, systemd seems to
always just use urandom().

I can trigger the urandom read warning easily enough (turn of CPU
rdrand trusting and increase the entropy requirement by a factor of
ten, and turn of the ioctl to add entropy from user space), just not
the getrandom() blocking case at all.

So presumably that's because I have a systemd that doesn't use
getrandom() at all, or perhaps uses the 'rdrand' instruction directly.
Or maybe because Arch has some other oddity that just triggers the
problem.

> In addition, since you're leaving the door open to bikeshed around
> the timeout valeue, I'd say that while 30s is usually not huge in a
> desktop system's life, it actually is a lot in network environments
> when it delays a switchover.

Oh, absolutely.

But in that situation you have a MIS person on call, and somebody who
can fix it.

It's not like switchovers happen in a vacuum. What we should care
about is that updating a kernel _works_. No regressions. But if you
have some five-nines setup with switchover, you'd better have some
competent MIS people there too. You don't just switch kernels without
testing ;)

                 Linus
