Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2AB6CC0
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfIRTjE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 15:39:04 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:42788 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfIRTjD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Sep 2019 15:39:03 -0400
Received: by mail-lf1-f52.google.com with SMTP id c195so520521lfg.9
        for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2019 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvhEddV5arJ7kaE02ns4J/avAB+kinH7CQEi/JKElsk=;
        b=hyt7b1C+ejKMUOkm3wdH5sM3HZ0Yx3jENhtBKmZzMXUDrLLnMX0hYCGd4/JdZv8YEE
         TyVAlXluZqwjYt7TpfNih3FI/oO6rDGTrPOj8NLmh/zNBX46U2iKHHALvbYoY65a8plv
         eQvWR+ESaaepqApPmlM6BFf/L6h5y1J1D9bNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvhEddV5arJ7kaE02ns4J/avAB+kinH7CQEi/JKElsk=;
        b=LcMnf164CuqUqAx0WhQvRioFq3rTVwS8wWzwVuMS0I8nDSRryUEBTzP7ovsK8YpVs5
         0UsV0bE6AYShCvt569p2wfSsTHStLl+dIZWYPdV2Kee3fzr+WF+faR2+VmkCvLzoh0i9
         mIRnNIE0eSLPCjPr5vmz+5JWITykVmd5196C9tDs9tAGULd53EiEjD4E60sx68WVnWgx
         dRRqmrXDGWiKLOdygHag65PLc/MFFDp98vqpP6sRb/DrT/xKh+FM+wJ7oTkP25g9ZEwW
         8xIe8BJG/mSIysBTZNxoZft7QdfBrBg9JRXZdEE2MtjoURPkD8QSEL/Xmw35nnG2Za3T
         LgSg==
X-Gm-Message-State: APjAAAXhbqUeuasD1OAntfzRifLlaPU5M9gjJ3WOLDppeEoZzFcCt21d
        7VzrZ40Xn1J6wXeAGxGQ2IWuexiUK3g=
X-Google-Smtp-Source: APXvYqy8m2vekXmL+KgAbpDOUoN4Nd5wOCZrwmxiEHiSknY5ZjxDR9lGoBRODq/lgn+YVvHIUQWr7Q==
X-Received: by 2002:ac2:4424:: with SMTP id w4mr1379756lfl.65.1568835541105;
        Wed, 18 Sep 2019 12:39:01 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id j22sm1184443lja.4.2019.09.18.12.39.00
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 12:39:00 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id v24so1148147ljj.3
        for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2019 12:39:00 -0700 (PDT)
X-Received: by 2002:a2e:1208:: with SMTP id t8mr1170191lje.84.1568835100782;
 Wed, 18 Sep 2019 12:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login> <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
 <CAHk-=wgOCv2eOT2M8Vw9GD_yOpsTwF364-hkeADyEu9erHgMGw@mail.gmail.com> <89aeae9d-0bca-2a59-5ce2-1e18f6479936@rasmusvillemoes.dk>
In-Reply-To: <89aeae9d-0bca-2a59-5ce2-1e18f6479936@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 12:31:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whORuqf+e=G5vfjXZfzj0wv4zzyPoojfi4SkgLjuvHy0g@mail.gmail.com>
Message-ID: <CAHk-=whORuqf+e=G5vfjXZfzj0wv4zzyPoojfi4SkgLjuvHy0g@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
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

On Wed, Sep 18, 2019 at 2:33 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> And unrelated to the non-use of the RTC (which I agree seems weird), but
> because there's no better place in this thread: How "random" is the
> contents of RAM after boot?

It varies all over the place.

Some machines will most definitely clear it at each boot.

Others will clear it on cold boots but not warm boots.

Yet other environments never clear it at all, or leave it with odd patterns.

So it _could_ be useful as added input to the initial random state,
but it equally well might be totally pointless. It's really hard to
even guess.

There would be nothing wrong by trying to do add_device_randomness()
from some unused-at-boot memory area, but it's unclear what memory
area you should even attempt to use. Certainly not beginning of RAM or
end of RAM, which are both special and more likely to have been used
by the boot sequence even if it is then marked as unused in the memory
maps.

And if you do it, it's not clear it will add any noise at all. It
_might_. But it might equally well not.

             Linus
