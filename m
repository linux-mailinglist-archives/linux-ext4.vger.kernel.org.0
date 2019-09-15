Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B23B30E0
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbfIOQaT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 12:30:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38353 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388100AbfIOQaR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 12:30:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so4795419lfc.5
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eXQR5cNa/rEvZ1aNPUIkNm/QbpDwPCy01MJ9nMVGXA=;
        b=X93ojoRt0fwRn6t2yZfaMbViKKNJwHwvJGGsbpHUO+NgdcUiIJ/BjYUURdYoYJHliC
         Ea5JW2CXXXcZaG4w3q6JGmNcVoRVTe4q5vshFp31k1mqZi2rff9M4H1EHgQGiLBz2Wrn
         g31xHYn3n5K+fcb4Uzc1ryw8ed/gXBjoQetbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eXQR5cNa/rEvZ1aNPUIkNm/QbpDwPCy01MJ9nMVGXA=;
        b=V/SVQgj31YPnRQtQVyxUGXI68IIF9GMXyVoLSpjSiQ1iCglo2af5/zOHfNulEeAz65
         zqqzY+dj0gwQCE2jxIu7PYk1AEwW3kN3Deb+0RxGV8qmYgk3pR3/imICWxROuHcHDUnI
         diYG7Onk1ukyFbaqOGerZieRvLSI8d2RsQkVCGFfyhhNbjDF6H5LHHfYI42WM5epLFSS
         5uz8yO1giUJ2U3vrZMO3SnzVvN4h0beb4Jhjra0KXRMP2ZW35w6NB78n6Vu9UXGRju6r
         pvHMqMxTp755RDbg/ezEwl2PIESPRkGmJqG5yeSp8JEuVa5ypaTMeCevYE4Gkk0yFvBB
         qTNg==
X-Gm-Message-State: APjAAAW8dUOjfKFdLYw6+r0lqFOaE0DC6cUhLj45bXSfgXWLrvbBM0TD
        PmH7qxTfu8DQ7aubnxfsVoft/3Q6y8Q=
X-Google-Smtp-Source: APXvYqw+bryOo8a+gf7y5lbIWci+v+g/f5hu7//hazhFr3Ljk0knMvnmCX95/fFWYxAHWYL5Tynhvw==
X-Received: by 2002:ac2:562c:: with SMTP id b12mr36944898lff.156.1568565015056;
        Sun, 15 Sep 2019 09:30:15 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id s21sm7723142ljj.22.2019.09.15.09.30.11
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 09:30:12 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id t8so25518921lfc.13
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 09:30:11 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr36503149lfp.134.1568565011303;
 Sun, 15 Sep 2019 09:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
In-Reply-To: <20190915065142.GA29681@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 09:29:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
Message-ID: <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
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

On Sat, Sep 14, 2019 at 11:51 PM Lennart Poettering
<mzxreary@0pointer.de> wrote:
>
> Oh man. Just spend 5min to understand the situation, before claiming
> this was garbage or that was garbage. The code above does not block
> boot.

Yes it does. You clearly didn't read the thread.

> It blocks startup of services that explicit order themselves
> after the code above. There's only a few services that should do that,
> and the main system boots up just fine without waiting for this.

That's a nice theory, but it doesn't actually match reality.

There are clearly broken setups that use this for things that it
really shouldn't be used for. Asking for true randomness at boot
before there is any indication that randomness exists, and then just
blocking with no further action that could actually _generate_ said
randomness.

If your description was true that the system would come up and be
usable while the blocked thread is waiting for that to happen, things
would be fine.

But that simply isn't the case.

                  Linus
