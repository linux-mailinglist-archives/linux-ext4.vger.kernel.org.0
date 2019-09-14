Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810FBB2C4A
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 18:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfINQxJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 12:53:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40938 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfINQxJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 12:53:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id d17so6491304lfa.7
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLIo6vFI0bpmCXFO87whfx1RKUoffbAynCeevQqzVaY=;
        b=ELbD4LRyFSnkAfSPCSVXoyh3un74MVZCrn++kf+mNF8nH8v/FPyJ3yuLu+pNYRJ9Jm
         zd5rpNwKA1AWkc4nMxoDraDB/EG2Z8O2lJDEPT2dz4ZuWB+7c9jdPlZGfkKpysD4rZN0
         mM0oEqg+F6vSDXePBv81AnnhmKfV64W/yfUZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLIo6vFI0bpmCXFO87whfx1RKUoffbAynCeevQqzVaY=;
        b=YkOJVBIxirXkKxK/OFj/RziBVVkAGwplADxhxdjjl7g+zp8OfFRRTz1NIk3jdTcukn
         jRGpqFBhVBI7flJZPAhi4JULQznGgzM74YcywpIei1hMn20V4OvoeK0MkG2qA0qDuFdP
         MLLkkxaACeziO+1M+23DgsQj+ABZUV19huD/XaMc8TPNWy0BpacLI+MdhQtgOXkV71r9
         mUAYnKrJJi27GbKlC/YDWwIZu5qv52s3h93lQcnAcOr6zOQSC9TgqvRV1/fBUlbzKFvD
         Uo/Ubz6VCcT62pYMS9w9+yOj/liYGyjXtdxCQUP0Bkg9FfjB0Du63iO+Sq5nZt0noC9g
         CQrw==
X-Gm-Message-State: APjAAAXyZwWyl5493LP1oPOcsJrvF07KQqTESbxRKRpPG8wu6bMRC8Cs
        j0owRL+SBRvlYA/dRiEDNm+/zsriIj8=
X-Google-Smtp-Source: APXvYqz8g8MAiGiMO0XIzjHANhbUZXNbt0PPviid4x1Fwn9DBXoh9c1xkXoBsY62IaRsHsIyPE5L5g==
X-Received: by 2002:a19:3fd1:: with SMTP id m200mr33944338lfa.18.1568479986231;
        Sat, 14 Sep 2019 09:53:06 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id g27sm6510647lja.33.2019.09.14.09.53.05
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 09:53:05 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id c22so2126190ljj.4
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 09:53:05 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr33898456ljg.72.1568479984957;
 Sat, 14 Sep 2019 09:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
In-Reply-To: <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 09:52:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
Message-ID: <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 9:35 AM Alexander E. Patrakov
<patrakov@gmail.com> wrote:
>
> Let me repeat: not -EINVAL, please. Please find some other error code,
> so that the application could sensibly distinguish between this case
> (low quality entropy is in the buffer) and the "kernel is too dumb" case
> (and no entropy is in the buffer).

I'm not convinced we want applications to see that difference.

The fact is, every time an application thinks it cares, it has caused
problems. I can just see systemd saying "ok, the kernel didn't block,
so I'll just do

   while (getrandom(x) == -ENOENTROPY)
       sleep(1);

instead. Which is still completely buggy garbage.

The fact is, we can't guarantee entropy in general. It's probably
there is practice, particularly with user space saving randomness from
last boot etc, but that kind of data may be real entropy, but the
kernel cannot *guarantee* that it is.

And people don't like us guaranteeing that rdrand/rdseed is "real
entropy" either, since they don't trust the CPU hw either.

Which means that we're all kinds of screwed. The whole "we guarantee
entropy" model is broken.

               Linus
