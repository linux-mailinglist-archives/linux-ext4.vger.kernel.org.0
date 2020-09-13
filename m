Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A857267D4F
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Sep 2020 04:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIMCj6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Sep 2020 22:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgIMCjy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Sep 2020 22:39:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEF7C061574
        for <linux-ext4@vger.kernel.org>; Sat, 12 Sep 2020 19:39:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u4so15630520ljd.10
        for <linux-ext4@vger.kernel.org>; Sat, 12 Sep 2020 19:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2C/qz8WTQg0h0JMo2/r0VFEztzIc2ITvUiyhbZtdyQg=;
        b=Izk6OPa4qUb+khxBOAgR1fle5sieDHyxqjm9jpILoEO8u1K+OHUG84kO/1INA6hRCG
         ePFHOC5QcsUjPBaQLZ/XmWz8NLkZ/vMkS6s49DPLhmxzE02EXRvFI2E7Y9eY8YJ2CrKQ
         o+ouBlYIOmUBs6BsvnZoky/SHLY7xY6j0j/YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2C/qz8WTQg0h0JMo2/r0VFEztzIc2ITvUiyhbZtdyQg=;
        b=jBWaK5HouvY1WeG7yDiFeF/P8Fuo2FyWLo/gLUrC0Im++XtQ8+8Yp6wUn2uPRklNdS
         0sAFrX3C1h2t3GaJgSsPCFNg9qNRdMTbZl/tJlhhk5ygRY2LHopdfb5hNPSp6A7l7Gr1
         cy6iEJ3g3VaCwIdqyndhjX9qAWba8HsI8dICeBsluwtpjfXRwceVrNz4TCMDNR2/j2vo
         nPxw5bOp31wUdGGOMcX2Bwi+HPMx+2BoVkECcM8/hwKmG815B+CfT4Ej69CntKdjQJ6K
         HK3YT0oMGQiltkQHuDvTalRvbLnw+miS1Fvmtp6aetGZH75pkXmmBxkI+kiBV+URt+Ml
         QAmw==
X-Gm-Message-State: AOAM532xdRCTUehg1obEOn0omiJx5PkCAF6Z2EjMenSh/gZS9LROTWyr
        owdTlNkvu17i6nbWkDBIZ0Wmh57N4iQ1WA==
X-Google-Smtp-Source: ABdhPJzNqh2zuPrDxM/QbaF2niziwgT3T/k7ilkaMwwxtQ07hwjkHve8Fbbzc7xag//uPURT1ukxxg==
X-Received: by 2002:a2e:240e:: with SMTP id k14mr2889139ljk.169.1599964789889;
        Sat, 12 Sep 2020 19:39:49 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id z6sm1732362lfq.297.2020.09.12.19.39.48
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2020 19:39:48 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id d15so9778495lfq.11
        for <linux-ext4@vger.kernel.org>; Sat, 12 Sep 2020 19:39:48 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr2585356lfg.344.1599964787701;
 Sat, 12 Sep 2020 19:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com> <20200913004057.GR12096@dread.disaster.area>
In-Reply-To: <20200913004057.GR12096@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Sep 2020 19:39:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5Lyr9Tr8wpNDXKeNt=Ngc3jwWaOsN_WbQr+1dAuhJSQ@mail.gmail.com>
Message-ID: <CAHk-=wh5Lyr9Tr8wpNDXKeNt=Ngc3jwWaOsN_WbQr+1dAuhJSQ@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Dave Chinner <david@fromorbit.com>
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

On Sat, Sep 12, 2020 at 5:41 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Hmmmm. So this is a typically a truncate race check, but this isn't
> sufficient to protect the fault against all page invalidation races
> as the page can be re-inserted into the same mapping at a different
> page->index now within EOF.

Using some "move" ioctl or similar and using a "invalidate page
mapping, then move it to a different point" model?

Yeah. I think that ends up being basically an extended special case of
the truncate thing (for the invalidate), and would require the
filesystem to serialize externally to the page anyway.

Which they would presumably already do with the MMAPLOCK or similar,
so I guess that's not a huge deal.

The real worry with (d) is that we are using the page lock for other
things too, not *just* the truncate check. Things where the inode lock
wouldn't be helping, like locking against throwing pages out of the
page cache entirely, or the hugepage splitting/merging etc. It's not
being truncated, it's just the VM shrinking the cache or modifying
things in other ways.

So I do worry a bit about trying to make things per-inode (or even
some per-range thing with a smarter lock) for those reasons. We use
the page lock not just for synchronizing with filesystem operations,
but for other page state synchronization too.

In many ways I think keeping it as a page-lock, and making the
filesystem operations just act on the range of pages would be safer.

But the page locking code does have some extreme downsides, exactly
because there are so _many_ pages and we end up having to play some
extreme size games due to that (ie the whole external hashing, but
also just not being able to use any debug locks etc, because we just
don't have the resources to do debugging locks at that kind of
granularity).

That's somewhat more longer-term. I'll try to do another version of
the "hybrid fairness" page lock (and/or just try some limited
optimistic spinning) to see if I can at least avoid the nasty
regression. Admittedly it really probably only happens for these kinds
of microbenchmarks that just hammer on one page over and over again,
but it's a big enough regression for a "real enough" load that I
really don't like it.

                 Linus
