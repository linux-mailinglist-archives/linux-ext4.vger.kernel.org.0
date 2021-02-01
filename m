Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C130B238
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 22:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhBAVmb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 16:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhBAVm1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 16:42:27 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D86C061756
        for <linux-ext4@vger.kernel.org>; Mon,  1 Feb 2021 13:41:47 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id o20so12553675pfu.0
        for <linux-ext4@vger.kernel.org>; Mon, 01 Feb 2021 13:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omXjXu9fWF573tSXobtbnzQwWlvXEFA3qfAQWygo3mA=;
        b=XVEcRzdKTgv6oWVIC7ldetczFBWdAjRFmTpbYbTZlHtB6H7aUwHVj0akiYZk5N2RM2
         fOIZIALS6ikaDlMI//E6lPAcXY6Z+PjbTQ5gZXCdWTmqq1DLJfR57yiEVRt3nxeSkvAb
         tJGHfp/uPFelHfb5tuN3owSy7DvcjlthJ+Dd2X/R7foMOSdoK+NL6nfpmRnHRewU2l9k
         6IDMnINUEGsGQZLUgWtcVIamUe5SDNfH89cT6pZZeJW1hckLpPkvRu3q0s+WvmxRlyE7
         Jf0wqrbeZ+cAii6BVkF8c66ir5MuHQlAkBd+pusa8d9Q1J6BGTc1POEP3BipeTjEk+Bz
         S4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omXjXu9fWF573tSXobtbnzQwWlvXEFA3qfAQWygo3mA=;
        b=oARAePNVwPgRe1kw/SdvY7iY/eA43cO0WKZPnW1cRokSS6KP4IVozpq5sXVvGhoZvQ
         /xMVWVfYB80ubnO8nL/N3DyG9uq/hQVva9HbQ2s281s9IHduWUq8D7g5yLRLeId69tCe
         0VCvZ872DCk99jLNC8yN1D2hGXcV5BdmP3I6nWT7TRy4FQorsaroyAq950m+1OJMWgt7
         +aS/+TrSixIFSfAUjE6HGHiAr9ocXC11KZ6jtILgCssIJEV/n+ekgpS1g3TlUPbtQ2P8
         W+wjU6pc7Kgf0NovMAaje6pi4SyYMeHIeCdSIkYu2y/INmSl4gUigpMsbjX9GUtT7NhF
         Q8Fg==
X-Gm-Message-State: AOAM5334nn5k1SGccGEFWnssqnNqOIm/NVjXbpCChbxOTbSqo4csDJGQ
        7DUSpXWPVPf0ag4ONHbRuMdnosZpXwiZpZsLLJYHJw==
X-Google-Smtp-Source: ABdhPJyAoqBpiDc6ud45MnBvOhoJU4la3Lt8G+wChR1rjqMji/fTgrh6pdK5q4S4WIPLIkJBELYQn2uSSDD89C4XX+o=
X-Received: by 2002:a65:4201:: with SMTP id c1mr18769495pgq.10.1612215706453;
 Mon, 01 Feb 2021 13:41:46 -0800 (PST)
MIME-Version: 1.0
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com> <20210201124924.GA3284018@infradead.org>
 <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
 <YBg20AuSC3/9w2zz@mit.edu> <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
 <YBhuHJgZ3QPqHheV@mit.edu> <CAKwvOd=ny2TeYV8SGZMD+aj8Yb6OSYGKAzSb-45r-HKk6WTUCQ@mail.gmail.com>
 <YBh0ywVzkUIR3fXg@mit.edu>
In-Reply-To: <YBh0ywVzkUIR3fXg@mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Feb 2021 13:41:35 -0800
Message-ID: <CAKwvOdkZRdBzzW19sVAs+pX-7wWwN6AWrxUkkZwP8L4OT7SLfQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Vinicius Tinti <viniciustinti@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 1, 2021 at 1:38 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Feb 01, 2021 at 01:16:19PM -0800, Nick Desaulniers wrote:
> > I agree; Vinicius, my recommendation for -Wunreachable-* with Clang
> > was to see whether dead code identified by this more aggressive
> > diagnostic (than -Wunused-function) was to ask maintainers whether
> > code identified by it was intentionally dead and if they would
> > consider removing it.  If they say "no," that's fine, and doesn't need
> > to be pushed.  It's not clear to maintainers that:
> > 1. this warning is not on by default
> > 2. we're not looking to pursue turning this on by default
> >
> > If maintainers want to keep the dead code, that's fine, let them and
> > move on to the next instance to see if that's interesting (or not).
>
> It should be noted that in Documenting/process/coding-style.rst, there
> is an expicit recommendation to code in a way that will result in dead
> code warnings:
>
>    Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
>    symbol into a C boolean expression, and use it in a normal C conditional:
>
>    .. code-block:: c
>
>         if (IS_ENABLED(CONFIG_SOMETHING)) {
>                 ...
>         }
>
>    The compiler will constant-fold the conditional away, and include or exclude
>    the block of code just as with an #ifdef, so this will not add any runtime
>    overhead.  However, this approach still allows the C compiler to see the code
>    inside the block, and check it for correctness (syntax, types, symbol
>    references, etc).  Thus, you still have to use an #ifdef if the code inside the
>    block references symbols that will not exist if the condition is not met.
>
> So our process documentation *explicitly* recommends against using
> #ifdef CONFIG_XXX ... #endif, and instead use something that will
> -Wunreachable-code-aggressive to cause the compiler to complain.

I agree.

>
> Hence, this is not a warning that we will *ever* be able to enable
> unconditionally ---

I agree.

> so why work hard to remove such warnings from the
> code?  If the goal is to see if we can detect real bugs using this

Because not every instance of -Wunreachable-code-aggressive may be that pattern.

> technique, well and good.  If the data shows that this warning
> actually is useful in finding bugs, then manybe we can figure out a
> way that we can explicitly hint to the compiler that in *this* case,
> the maintainer actually knew what they were doing.
>
> But if an examination of the warnings shows that
> -Wunreachable-code-aggressive isn't actually finding any real bugs,
> then perhaps it's not worth it.

I agree. Hence the examination of instances found by Vinicius.
-- 
Thanks,
~Nick Desaulniers
