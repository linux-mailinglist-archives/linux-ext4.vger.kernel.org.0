Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556E2B318D
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfIOTIy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 15:08:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38003 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfIOTIy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 15:08:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id u28so4964311lfc.5
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FC6oplaM/uLQVrJ7puxoeIhZgwICvODF/vPEHCG2N4M=;
        b=H8aeNSjUbHEYQw38GMjoyn9XHob6uka2vY7wVgLQDsFuRYIpWKHEOXFjfKOwAOpbRD
         fzQz/sjksOMUjfFHHoJbP1NELmEJRgPUZ9+WAFmXZDAleQmykxS+ss+2fYrhKaZhhX4/
         bT/VS5+fpR8ZyOIIW2ZolBDrjqNHyHlJCVzr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FC6oplaM/uLQVrJ7puxoeIhZgwICvODF/vPEHCG2N4M=;
        b=cBxSnoZDxoFgTKYjny04ceFK6/V3e1PLPZKKrh1y5YxIDEitLLb2zCzGD7QP568dZa
         7KtkeqMcnQW4dbQiHUvp2TjEUefLqac2EXflcRrZZ2kFU9iScFe2VJsp2nsEepKfymtk
         HNLEYBkH8u7ApxnYQjT1KlCmbtE/Luski1NYnxMVjtwGrBb2kZPRcYwEUSopNeCj4ZAg
         r0ws79nZie/V6EZhskUhTo4Yx93fDGqkeWJLDYgcP2yzUpWO54AoFrgye2MkxgprCdFa
         fqwQaGjDMEmeUpgrbjs9rKrt4pWpH7l2SKc4SZ8p8wOC3REnR7paYrWVZClZCeRvqgSj
         k2oA==
X-Gm-Message-State: APjAAAXfVnAG+5YwZMsL6nZQ6SpK+Zb/7L2jHB+3VRGsU80Wp8rDZ83G
        yvwrqYR85yFjaZUuSqVSsmXTJLuTWfs=
X-Google-Smtp-Source: APXvYqxb22n70PBoYq5bs2RcKq5VHqoT9+ex7IWwKuQeJsftDY8xMMGsDYuDlskxNdeznur1e13sug==
X-Received: by 2002:a19:488f:: with SMTP id v137mr35422951lfa.26.1568574532587;
        Sun, 15 Sep 2019 12:08:52 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 81sm8046545lje.70.2019.09.15.12.08.49
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 12:08:51 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id x80so25766058lff.3
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 12:08:49 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr36322038lfc.106.1568574529013;
 Sun, 15 Sep 2019 12:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190915183240.GA23155@1wt.eu> <20190915183659.GA23179@1wt.eu>
In-Reply-To: <20190915183659.GA23179@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 12:08:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFrRCL3WP7vyuZ-92xyqb97ADc=JNyyVCucZ1Q9oh8TA@mail.gmail.com>
Message-ID: <CAHk-=wgFrRCL3WP7vyuZ-92xyqb97ADc=JNyyVCucZ1Q9oh8TA@mail.gmail.com>
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

On Sun, Sep 15, 2019 at 11:37 AM Willy Tarreau <w@1wt.eu> wrote:
>
> I also wanted to ask, are we going to enforce the same strategy on
> /dev/urandom ?

Right now the strategy for /dev/urandom is "print a one-line warning,
then do the read".

I don't see why we should change that. The whole point of urandom has
been that it doesn't block, and doesn't use up entropy.

It's the _blocking_ behavior that has always been problematic. It's
why almost nobody uses /dev/random in practice.

getrandom() looks like /dev/urandom in not using up entropy, but had
that blocking behavior of /dev/random that was problematic.

And exactly the same way it was problematic for /dev/random users, it
has now shown itself to be problematic for getrandom().

My suggested patch left the /dev/random blocking behavior, because
hopefully people *know* about the problems there.

And hopefully people understand that getrandom(GRND_RANDOM) has all
the same issues.

If you want that behavior, you can still use GRND_RANDOM or
/dev/random, but they are simply not acceptable for boot-time
schenarios. Never have been,

... exactly the way the "block forever" wasn't acceptable for getrandom().

                Linus
