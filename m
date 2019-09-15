Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBFEB2F9E
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 12:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfIOKzv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 06:55:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51913 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbfIOKzv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 06:55:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so6993907wme.1;
        Sun, 15 Sep 2019 03:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R3LqYYMBT+nWIT12Cdfqk6UPzHE/cc0WsDTckw4FJZs=;
        b=Brx6abDNQchwDnbthBGpqed/0B0BQnxO3vHj2PRO6R2BjfrK9epv0p1PWsmSZMgK98
         tGfPfMFR3PV0H1xO6x/5lWdzkgLfZl7deSOmxgC4JyNfs6P6+bx0705L54Yk9Rd10g7J
         c/ZvKQ/gx3sYV4RJ1Zsj5Hd3PE6DOdWg/RH94Pl5kyLQc90MB/fm4XlhzWSHtTNE6uRZ
         6zLWfKEcUAx69QT+NKcE4fEeUiaR42F5MgF/oaE13g7Uf04/lhIgcD615FwenAvYs9xb
         T2vPPGZ8Sv7WdLdpZVNVPChii+FAtH/uS4+CtBqTrKVwQtKQXvu2maXFaX8qFJy+RYe1
         irhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3LqYYMBT+nWIT12Cdfqk6UPzHE/cc0WsDTckw4FJZs=;
        b=Z9kRHl1pZ0ilEExzRg07HNsKCk3Q9xslWdPvbqChkK8wLMF6mGdEaqpXsQ9Hwf8Jeu
         V73CYajPk45c3X/xiXjacEDGVs+ZD7adGH2yzGH/vE6KMWA0FClWltkBZo+ZTYzkscF/
         GWwlXxIJ7dBJ8EH5AYdzRiki7IxBEEMN8FsvRamsSrtVpoqC3jNVgeKOwOcuvdcUtad8
         AkT1a/RNGfwPsCFwCt9E2P4cQMhpeScCCoNk3g89e6VXgnkOtiGSQSOnh6rVLu81+Vmm
         6sMzuqAWjvjm+590hfqdQUeKJe10gdH5fggN+mfRJp7bfQVQBCOiQoJolIcMUZrPyadi
         HeMQ==
X-Gm-Message-State: APjAAAVh/Dyfna224jnSoXBeYBSnHEshNdzXLWk2y6cvKDLGMQgy3s5n
        9sg+5PS27wh+UWmvtV/Yots=
X-Google-Smtp-Source: APXvYqysZZAEzcpTrLXqkqwFRZwSy3lD2aLI4EXUa68ZomYgeY2G7fIsR/kpfWFagdaMyU1g0aEUgg==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr10791113wmt.81.1568544947023;
        Sun, 15 Sep 2019 03:55:47 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D1401AF0812D8DEE03BEC.dip0.t-ipconnect.de. [2003:d0:6f2d:1401:af08:12d8:dee0:3bec])
        by smtp.gmail.com with ESMTPSA id 33sm42989155wra.41.2019.09.15.03.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 03:55:46 -0700 (PDT)
Date:   Sun, 15 Sep 2019 12:55:39 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v3] random: getrandom(2): optionally block when CRNG
 is uninitialized
Message-ID: <20190915105539.GA1082@darwi-home-pc>
References: <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <20190915081747.GA1058@darwi-home-pc>
 <20190915085907.GC29771@gardel-login>
 <20190915093057.GF20811@1wt.eu>
 <20190915100201.GA2663@darwi-home-pc>
 <20190915104027.GG20811@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915104027.GG20811@1wt.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 12:40:27PM +0200, Willy Tarreau wrote:
> On Sun, Sep 15, 2019 at 12:02:01PM +0200, Ahmed S. Darwish wrote:
> > On Sun, Sep 15, 2019 at 11:30:57AM +0200, Willy Tarreau wrote:
> > > On Sun, Sep 15, 2019 at 10:59:07AM +0200, Lennart Poettering wrote:
[...]
> > > > If Linux lets all that stuff run with awful entropy then
> > > > you pretend things where secure while they actually aren't. It's much
> > > > better to fail loudly in that case, I am sure.
> > > 
> > > This is precisely what this change permits : fail instead of block
> > > by default, and let applications decide based on the use case.
> > >
> > 
> > Unfortunately, not exactly.
> > 
> > Linus didn't want getrandom to return an error code / "to fail" in
> > that case, but to silently return CRNG-uninitialized /dev/urandom
> > data, to avoid user-space even working around the error code through
> > busy-loops.
> 
> But with this EINVAL you have the information that it only filled
> the buffer with whatever it could, right ? At least that was the
> last point I manage to catch in the discussion. Otherwise if it's
> totally silent, I fear that it will reintroduce the problem in a
> different form (i.e. libc will say "our randoms are not reliable
> anymore, let us work around this and produce blocking, solid randoms
> again to help all our users").
>

V1 of the patch I posted did indeed return -EINVAL. Linus then
suggested that this might make still some user-space act smart and
just busy-loop around that, basically blocking the boot again:

    https://lkml.kernel.org/r/CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com
    https://lkml.kernel.org/r/CAHk-=whSbo=dBiqozLoa6TFmMgbeB8d9krXXvXBKtpRWkG0rMQ@mail.gmail.com

So it was then requested to actually return what /dev/urandom would
return, so that user-space has no way whatsoever in knowing if
getrandom has failed. Then, it's the job of system integratos / BSP
builders to fix the inspect the big fat WARN on the kernel and fix
that.

This is the core of Lennart's critqueue of V3 above.

> > I understand the rationale behind that, of course, and this is what
> > I've done so far in the V3 RFC.
> > 
> > Nonetheless, this _will_, for example, make systemd-random-seed(8)
> > save week seeds under /var/lib/systemd/random-seed, since the kernel
> > didn't inform it about such weakness at all..
> 
> Then I am confused because I understood that the goal was to return
> EINVAL or anything equivalent in which case the userspace knows what
> it has to deal with :-/
>

Yeah, the discussion moved a bit beyond that.

thanks,
--darwi
