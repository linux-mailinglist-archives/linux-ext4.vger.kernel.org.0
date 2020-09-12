Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47BA267C89
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Sep 2020 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgILVQT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Sep 2020 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgILVQR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Sep 2020 17:16:17 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3F6C061573
        for <linux-ext4@vger.kernel.org>; Sat, 12 Sep 2020 14:16:17 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m5so9424133lfp.7
        for <linux-ext4@vger.kernel.org>; Sat, 12 Sep 2020 14:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0P+Oqlcn0sJDfwdqNyIyKS9/DVLVFKrfZQWJBwa72bU=;
        b=JMoFlErO24SBAUEL67rjId4FitgMyZrTA5pxg4bs6hZ9mg6dQ/Mg32elNVF/k953HC
         RV7UdX2KK1eXoPRtGrgI9u3qqi1mxs7ad07Jsqc/vU4uuqopui4UEvwbIt+SfpvhFk0A
         7DkvZaBTYRQ9vDpKQj9VYQId/0dri/roQyEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0P+Oqlcn0sJDfwdqNyIyKS9/DVLVFKrfZQWJBwa72bU=;
        b=HYlEtoF4lzBz8odC5Ldmgl8JCGP6tjQ1TkIdPR10HUY41FuFNFTqoTeUX/dh8dWlnA
         k1wjQQepI4m3hDuMH6X8KqLLaMDD6XPgeqjVraNE1blWU3IGdgHEQuAbRdPmDimjwhLN
         WcEQlBBQwgdi2muS02YNuGxadwn9837RZFc6cc+HGQ4uryWRuBgea5HW2g/TT++M2i5k
         E37wiN3rVpjfcNZNr83a9EzNDqLRjrTZ1RDqWju1IltsX9Ny2+HRGZ/h743KUhJNPkOD
         DftN9xZpaE1oQM4WhXRUjy/dCJ2yPNr4EkklGB69Y1sidT3k9I+ZHDWmIuODyUvCSn8r
         gqDQ==
X-Gm-Message-State: AOAM532AJer+U2X+XnCSKl1EHoOBK4QBW4brEFjOadqs1UWcRXidgH3W
        28SScrH6vsdCSFXURZkpDW0kkouXapG3qw==
X-Google-Smtp-Source: ABdhPJwQ1k6dj6GPSg5otLpghEAljB+IHBfG/BICIQAhaSkC+QSKZOZxCd3EL0LnHaKZMEedSPrXTg==
X-Received: by 2002:a19:e003:: with SMTP id x3mr1909367lfg.597.1599945374881;
        Sat, 12 Sep 2020 14:16:14 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 203sm1429268lfc.112.2020.09.12.14.16.13
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2020 14:16:13 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id u21so15381108ljl.6
        for <linux-ext4@vger.kernel.org>; Sat, 12 Sep 2020 14:16:13 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr2578354ljp.314.1599945372972;
 Sat, 12 Sep 2020 14:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
 <aa90f272-1186-f9e1-8fdb-eefd332fdae8@MichaelLarabel.com> <CAHk-=wh_31_XBNHbdF7EUJceLpEpwRxVF+_1TONzyBUym6Pw4w@mail.gmail.com>
 <e24ef34d-7b1d-dd99-082d-28ca285a79ff@MichaelLarabel.com> <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
 <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com> <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
 <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com> <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com> <1599944388.6060.25.camel@HansenPartnership.com>
In-Reply-To: <1599944388.6060.25.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Sep 2020 14:15:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTpK7=5Sd8i9D_FTtRSerMUP3ux4qEL+fZdDYmfLrBAg@mail.gmail.com>
Message-ID: <CAHk-=wjTpK7=5Sd8i9D_FTtRSerMUP3ux4qEL+fZdDYmfLrBAg@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 12, 2020 at 1:59 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sat, 2020-09-12 at 10:59 -0700, Linus Torvalds wrote:
> [...]
> > Any other suggestions than those (a)-(d) ones above?
>
> What about revert and try to fix the outliers?  Say by having a timer
> set when a process gets put to sleep waiting on the page lock.

No timer needed, I suspect.

I tried to code something like this up yesterday (hjmm. Thursday?) as
a "hybrid" scheme, where we'd start out with the old behavior and let
people unfairly get the lock while there were waiters, but when a
waiter woke up and noticed that it still couldn't get the lock, _then_
it would stat using the new scheme.

So still be unfair for a bit, but limit the unfairness so that a
waiter won't lose the lock more than once (but obviously while the
waiter initially slept, _many_ other lockers could have come through).

I ended up with a code mess and gave up on it (it seemed to just get
all the complications from the old _and_ the new model), but maybe I
should try again now that I know what went wrong last time. I think I
tried too hard to actually mix the old and the new code.

(If I tried again, I'd not try to mix the new and the old code, I'd
make the new one start out with a non-exclusive wait - which the code
already supports for that whole "wait for PG_writeback to end" as
opposed to "wait to take PG_lock" - and then turn it into an exclusive
wait if it fails.. That might work out better and not mix entirely
different approaches).

             Linus
