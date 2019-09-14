Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BDB2CA6
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 21:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfINTTo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 15:19:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38567 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfINTTo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 15:19:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so29776449ljn.5
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPQUiN+MJCiURQJKXosBWd3fof3PGiz/eGjFjKhHooQ=;
        b=WnL0j3pyjxPnM4hyGPIMKPvliWuoPrHkG3hgdyb3sUJcufozYIh7VZ+bBUf44lWAB4
         pcl0tDtzPQqDxymM/g3YLvtkLjejtwFbg4lioNHR9dtkICNJTYZ6/F3XTY/AgKJG9z1d
         EuP51x7okTZmjwEK/BHlvdQaggkLC8U+lNfw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPQUiN+MJCiURQJKXosBWd3fof3PGiz/eGjFjKhHooQ=;
        b=B1+Q8+LJls6O/ToR2PIxqGt2pnm5CX7PwmQYBiK74CiE3+0wHvLaOWG27I+h9ixjPP
         1I+9+rg5aoBgIthxc9qpnasqDhe0+HOd20TiiH98xSCCzCbnMxwAeik3ZipvtLpx/TJY
         m1sul4QyRRktPy196xXxkGhIx63j1aSz96EpjwbC1jExGUh1gO4v27kbQhsYXU6rS8J0
         wxrz5hcirVWlbVkmmzUQWnuffx3URwYdpWpaA4WL6UKzbb7THLw6itD7ztXk/JkY2N+A
         huBKDZmPC6Pss39c7QrQCudRwjp76W2vuntBpkhRBSZ7mIihgsokwmulWLq1bgscds3i
         poYQ==
X-Gm-Message-State: APjAAAWNOy4sofaRF9lWzbSV86QhnAS5uR6Z/96629Wzj+vyuLkCRzvV
        8AVdX2yIIxUg4cg3hbYhaP+MHh+RsEU=
X-Google-Smtp-Source: APXvYqy4aWKzQA5Khrf1hJEKUwzJo87JqEerBhm7RzoIK39YfCvpXN7YxRtuUVA0HfAVBq8JNoXnOw==
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr34299459ljo.131.1568488781574;
        Sat, 14 Sep 2019 12:19:41 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id n9sm4956312ljh.53.2019.09.14.12.19.39
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 12:19:40 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id q64so19597069ljb.12
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 12:19:39 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr34140740ljg.72.1568488779341;
 Sat, 14 Sep 2019 12:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com> <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <8c2a47cc-a519-ad94-5d9a-18bb03ba2fd7@gmail.com>
In-Reply-To: <8c2a47cc-a519-ad94-5d9a-18bb03ba2fd7@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 12:19:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSbo=dBiqozLoa6TFmMgbeB8d9krXXvXBKtpRWkG0rMQ@mail.gmail.com>
Message-ID: <CAHk-=whSbo=dBiqozLoa6TFmMgbeB8d9krXXvXBKtpRWkG0rMQ@mail.gmail.com>
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

On Sat, Sep 14, 2019 at 10:09 AM Alexander E. Patrakov
<patrakov@gmail.com> wrote:
>
> > Which means that we're all kinds of screwed. The whole "we guarantee
> > entropy" model is broken.
>
> I agree here. Given that you suggested "to just fill the buffer and
> return 0" in the previous mail (well, I think you really meant "return
> buflen", otherwise ENOENTROPY == 0 and your previous objection applies),

Right.

The question remains when we should WARN_ON(), though.

For example, if somebody did save entropy between boots, we probably
should accept that - at least in the sense of not warning when they
then ask for randomness data back.

And if the hardware does have a functioning rdrand, we probably should
accept that too - simply because not accepting it and warning sounds a
bit too annoying.

But we definitely *should* have a warning for people who build
embedded devices that we can't see any reasonable amount of possible
entropy. Those have definitely happened, and it's a serious and real
security issue.

> let's do just that. As a bonus, it saves applications from the complex
> dance with retrying via /dev/urandom and finally brings a reliable API
> (modulo old and broken kernels) to get random numbers (well, as random
> as possible right now) without needing a file descriptor.

Yeah, well, the question in the end always is "what is reliable".

Waiting has definitely not been reliable, and has only ever caused problems.

Returning an error (or some status while still doing a best effort)
would be reasonable, but I really do think that people will mis-use
that. We just have too much of a history of people having the mindset
that they can just fall back to something better - like waiting - and
they are always wrong.

Just returning random data is the right thing, but we do need to make
sure that system developers see a warning if they do something
obviously wrong (so that the embedded people without even a real-time
clock to initialize any bits of entropy AT ALL won't think that they
can generate a system key on their router).

               Linus
