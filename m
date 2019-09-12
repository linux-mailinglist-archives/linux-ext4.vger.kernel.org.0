Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F11C8B0DF1
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2019 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfILLfG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Sep 2019 07:35:06 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:35150 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730982AbfILLfG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Sep 2019 07:35:06 -0400
Received: by mail-lj1-f172.google.com with SMTP id q22so18667994ljj.2
        for <linux-ext4@vger.kernel.org>; Thu, 12 Sep 2019 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJEjXo6Uv0jyp2+Brgg1JL8WxFYC+E50/NKS1o8RgP4=;
        b=SoqpQsGN0urBE3TZhDDbfGxMqQFL1cSw3SqSCRD7jsTJhbHzZSr7ZZSQZhcXfxdkDc
         rNbyzfu3s7rI7jD4hkuWmJhs7sZYsjUnj7IUIPx0yWxF6qwKRfkFXQOSdwttIBTxaccA
         Gqqy35oMPqJwLuP5+0ltXVj/AffUCCXYemJFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJEjXo6Uv0jyp2+Brgg1JL8WxFYC+E50/NKS1o8RgP4=;
        b=b54qBpyfsv/jKAPy+h1iTQJEkxFzjkU06UsaJNnYyo9tBO12+OiNuXy+Kf7rf9gAw1
         55tu0U+1yWoRt9C55qmEg+7ZcuIVTopceKvvWT3mq+H+yEADFcl/UOsFR8kx3JSeQLC7
         VhUcYamH93lJsj9xg9lf5bNS5oYOPyHzhTn2CIPs/P7ZxJDP3hoQjlc5JhEMA11srNjP
         1wRKb6v6njyxGSDYMXPdw77cIJWnAPMSTLp291DCMz3C/YqGjmLy4R6pkCmCVorDTNbH
         5hAgXs6gY+2iSCA92Wxr4XO7uS50BLfheWejMxeoSdio0qlvHrGEEY/vp1xhB0f2hCBF
         sI9A==
X-Gm-Message-State: APjAAAWLafqmSwDHXq0OiGjNNg/adD/0NR1KqYRHI6rbyrrTPiIVB6dr
        ShzHtyNUkno5e3hRWKLFhTcAb+mKsIKIUg==
X-Google-Smtp-Source: APXvYqzQmD7B29KPodHQGPUQGnKwRgNDHg13eDWpjLHj1UWg+4KPN8sf80sMpYJofJBJqS+xeZggPQ==
X-Received: by 2002:a2e:9d0d:: with SMTP id t13mr4999972lji.169.1568288103832;
        Thu, 12 Sep 2019 04:35:03 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id d12sm6175262lfn.93.2019.09.12.04.35.01
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 04:35:01 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id y5so12435391lji.4
        for <linux-ext4@vger.kernel.org>; Thu, 12 Sep 2019 04:35:01 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr26938394ljg.72.1568288101290;
 Thu, 12 Sep 2019 04:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc> <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
In-Reply-To: <20190912082530.GA27365@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Sep 2019 12:34:45 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
Message-ID: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
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

On Thu, Sep 12, 2019 at 9:25 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Hmm, one thought might be GRND_FAILSAFE, which will wait up to two
> minutes before returning "best efforts" randomness and issuing a huge
> massive warning if it is triggered?

Yeah, based on (by now) _years_ of experience with people mis-using
"get me random numbers", I think the sense of a new flag needs to be
"yeah, I'm willing to wait for it".

Because most people just don't want to wait for it, and most people
don't think about it, and we need to make the default be for that
"don't think about it" crowd, with the people who ask for randomness
sources for a secure key having to very clearly and very explicitly
say "Yes, I understand that this can take minutes and can only be done
long after boot".

Even then people will screw that up because they copy code, or some
less than gifted rodent writes a library and decides "my library is so
important that I need that waiting sooper-sekrit-secure random
number", and then people use that broken library by mistake without
realizing that it's not going to be reliable at boot time.

An alternative might be to make getrandom() just return an error
instead of waiting. Sure, fill the buffer with "as random as we can"
stuff, but then return -EINVAL because you called us too early.

                  Linus
