Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37FB2F7A
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfIOKCL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 06:02:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41575 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfIOKCL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 06:02:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so34941678wrw.8;
        Sun, 15 Sep 2019 03:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lq/56+aWk8HZUKxvrJKXQrsRwTL+BrL6ITyZ6xEfBMU=;
        b=eTMplotUWxXR9+xdOydd7k/YYG1wMf4xowk3fBBO8Ad14YiO1v+93eKKoF753Adt2z
         FEXDYuULX2VBu7So2FATETLh9YyXhoysnWaLTOdrXiUHmjTCSiGJxT4YOc7aRQtk+0x1
         pJqpeu5taDtt43YRbUYe+knsiMEknUQf48uMoek0wCmXOA1ke29GscFEhpssj293Qil8
         naBMZvXETS7av/1ZR05puMfen/j4Mhyk7NQ1NlqyJOO0TIL/RNGDWTpF203vp9VV52N1
         HcC5ntSeXkuce2nEkiJarPdv4sCuB/bL9vaDKAFr3TYaXqDu9bsQ8rtYRl8cjF+c+5AC
         GXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lq/56+aWk8HZUKxvrJKXQrsRwTL+BrL6ITyZ6xEfBMU=;
        b=d7pPg68yOLbZwgGj23isnWUzr9lo6qcDwiXylaPbrbePm757h2RqyXpBaO0iu/vNmZ
         E/v2KG0kNeHglvpuaS9LtuVJNWNUlvvFN8gyBbclT0XL/MnBE9zMV8yqOeovB33xwAY1
         hHzKjG0ancW+NDV80mO3NUylfR3MhV0xtS75QHJSi/ougbaiCQUHPAkOg4MRJINqHx2Z
         iS2i+EwRnr86S6Oye2KPCB0HWo2ZGwex2vlMtArz2kaE0AlnAPvdy4Cxlr8SuqMUwveo
         cOS//3dVg7j2QlycIUR0wksVdaTzwTy5okp8HxnEgSGwvdMHZHeWQgBWSDXMLKL9rkdQ
         ujgQ==
X-Gm-Message-State: APjAAAVNIyzXqU8dSHU0y7aOsGCO4aPjLpss7tQAJ8HK7wjrQxdejdxx
        wPBHGA8C2S6dkhHdfRDOISE=
X-Google-Smtp-Source: APXvYqynHTtiZ3cK3pMtYZwbX+tQDkEKg9AwL+TUwPjd8uxv3yN6mmY/kcFY7S9AfxU+OFHtQ/1Kqw==
X-Received: by 2002:a05:6000:10c2:: with SMTP id b2mr27798625wrx.45.1568541727973;
        Sun, 15 Sep 2019 03:02:07 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D1401AF0812D8DEE03BEC.dip0.t-ipconnect.de. [2003:d0:6f2d:1401:af08:12d8:dee0:3bec])
        by smtp.gmail.com with ESMTPSA id w4sm5668769wrv.66.2019.09.15.03.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 03:02:07 -0700 (PDT)
Date:   Sun, 15 Sep 2019 12:02:01 +0200
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
Message-ID: <20190915100201.GA2663@darwi-home-pc>
References: <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <20190915081747.GA1058@darwi-home-pc>
 <20190915085907.GC29771@gardel-login>
 <20190915093057.GF20811@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915093057.GF20811@1wt.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 11:30:57AM +0200, Willy Tarreau wrote:
> On Sun, Sep 15, 2019 at 10:59:07AM +0200, Lennart Poettering wrote:
> > We live in a world where people run HTTPS, SSH, and all that stuff in
> > the initrd already. It's where SSH host keys are generated, and plenty
> > session keys.
> 
> It is exactly the type of crap that create this situation : making
> people developing such scripts believe that any random source was OK
> to generate these, and as such forcing urandom to produce crypto-solid
> randoms!

Willy, let's tone it down please... the thread is already getting a
bit toxic.

> No, distro developers must know that it's not acceptable to
> generate lifetime crypto keys from the early boot when no entropy is
> available. At least with this change they will get an error returned
> from getrandom() and will be able to ask the user to feed entropy, or
> be able to say "it was impossible to generate the SSH key right now,
> the daemon will only be started once it's possible", or "the SSH key
> we produced will not be saved because it's not safe and is only usable
> for this recovery session".
> 
> > If Linux lets all that stuff run with awful entropy then
> > you pretend things where secure while they actually aren't. It's much
> > better to fail loudly in that case, I am sure.
> 
> This is precisely what this change permits : fail instead of block
> by default, and let applications decide based on the use case.
>

Unfortunately, not exactly.

Linus didn't want getrandom to return an error code / "to fail" in
that case, but to silently return CRNG-uninitialized /dev/urandom
data, to avoid user-space even working around the error code through
busy-loops.

I understand the rationale behind that, of course, and this is what
I've done so far in the V3 RFC.

Nonetheless, this _will_, for example, make systemd-random-seed(8)
save week seeds under /var/lib/systemd/random-seed, since the kernel
didn't inform it about such weakness at all..

The situation is so bad now, that it's more of "some user-space are
more equal than others".. Let's just at least admit this while
discussing the RFC patch in question.

thanks,

> > Quite frankly, I don't think this is something to fix in the
> > kernel.
> 
> As long as it offers a single API to return randoms, and that it is
> not possible not to block for low-quality randoms, it needs to be
> at least addressed there. Then userspace can adapt. For now userspace
> does not have this option just due to the kernel's way of exposing
> randoms.
> 
> Willy
