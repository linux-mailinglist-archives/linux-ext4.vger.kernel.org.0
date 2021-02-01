Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BD30B291
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 23:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhBAWHk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 17:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBAWGE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 17:06:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A451C0613D6;
        Mon,  1 Feb 2021 14:05:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b3so165586wrj.5;
        Mon, 01 Feb 2021 14:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXrTNqZ1a2NxntCInW2qtCvN4u7gpYCSwOi9amzGB3k=;
        b=SgwYSbrvvUpYp+tyZ7e71TPaScwW7TXdeh+CYCIgudEMBM2UW2Viqfd3SKONnHamlZ
         het5ll/X1CSgLRvRdx+C/HLH4tt/LGXeUqlCH88/ShTPM+cPlR7ywAST1eCfTOEd1jen
         s//lmBLinbfdirdKDB7/QuxhOuOMI2lvGXzQyUUCn8OzDSM3e0a8BNGF1ti9gC1e960a
         5PgE4M3OOQbs/vsPmQ6UhQTGx9UfObtU9LDUKIk62ES+SIAHQgjFOKpXaEM/nel9lvmR
         G7vtbuqYKfS7IjH+ibucbYUQkYDX91tXd+Xq/i6Jkx+aQOJ3gSb6yJCgY276LCbV7HuL
         ychQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXrTNqZ1a2NxntCInW2qtCvN4u7gpYCSwOi9amzGB3k=;
        b=rfmGlFH7L4bB4zpwvXUrgyYn7KHzhSmojWS+wxDQ9rses9Ad+uK3G6Hohkm/UJMFct
         7afn27uD1gtZ9lFtEl/7ZVGwwS37kkE7V8skb8eTA12TTQ0zWk/LWION54/3tTASYWb5
         r72ncqWzEVBoTxxijjAec5w9zR4tXj6kkmJF8IdYCoXrBnfv5lzg2SKQ221ye32N6I0K
         jm0qRCZJYdQXaF7/Sey9jJqMqLKT91SEb5sDBf0ognecaLEheqPLK2s1xRyJ9/wTdZa7
         LZ4gFnKR4NaYXqZ19KeJQiyAiUXrFPN0BIn5VJi6pB41vTxCZ4stt2WPApE+SNDsfvOq
         kc+g==
X-Gm-Message-State: AOAM533G7QgEhXBIHRg/VJIt4O2+4uiWSrufDUB1jta6kK35Ef3CPZ++
        zdGlDw+3bfiP9hnc8thOm805NLohKTF/AqOe+wY=
X-Google-Smtp-Source: ABdhPJyCqGRoRr94G8UsAS59zzgQKkariIHpoAW12U3We55qvp1D1SoV1dHYBHF7csf+VcKyDwPkWpjLBPV+M+sp6TI=
X-Received: by 2002:adf:f303:: with SMTP id i3mr20222409wro.60.1612217122143;
 Mon, 01 Feb 2021 14:05:22 -0800 (PST)
MIME-Version: 1.0
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com> <20210201124924.GA3284018@infradead.org>
 <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
 <YBg20AuSC3/9w2zz@mit.edu> <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
 <YBhuHJgZ3QPqHheV@mit.edu> <CAKwvOd=ny2TeYV8SGZMD+aj8Yb6OSYGKAzSb-45r-HKk6WTUCQ@mail.gmail.com>
 <YBh0ywVzkUIR3fXg@mit.edu> <CAKwvOdkZRdBzzW19sVAs+pX-7wWwN6AWrxUkkZwP8L4OT7SLfQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkZRdBzzW19sVAs+pX-7wWwN6AWrxUkkZwP8L4OT7SLfQ@mail.gmail.com>
From:   Vinicius Tinti <viniciustinti@gmail.com>
Date:   Mon, 1 Feb 2021 19:05:11 -0300
Message-ID: <CALD9WKx6HREQeTRXuv81v-=DTVuznXG_56YFm2dM1GOG3s4BRQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
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

On Mon, Feb 1, 2021 at 6:41 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Feb 1, 2021 at 1:38 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Mon, Feb 01, 2021 at 01:16:19PM -0800, Nick Desaulniers wrote:
> > > I agree; Vinicius, my recommendation for -Wunreachable-* with Clang
> > > was to see whether dead code identified by this more aggressive
> > > diagnostic (than -Wunused-function) was to ask maintainers whether
> > > code identified by it was intentionally dead and if they would
> > > consider removing it.  If they say "no," that's fine, and doesn't need
> > > to be pushed.  It's not clear to maintainers that:
> > > 1. this warning is not on by default
> > > 2. we're not looking to pursue turning this on by default

Ok. I will make it clear in next commit messages.

> > >
> > > If maintainers want to keep the dead code, that's fine, let them and
> > > move on to the next instance to see if that's interesting (or not).
> >
> > It should be noted that in Documenting/process/coding-style.rst, there
> > is an expicit recommendation to code in a way that will result in dead
> > code warnings:
> >
> >    Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
> >    symbol into a C boolean expression, and use it in a normal C conditional:
> >
> >    .. code-block:: c
> >
> >         if (IS_ENABLED(CONFIG_SOMETHING)) {
> >                 ...
> >         }
> >
> >    The compiler will constant-fold the conditional away, and include or exclude
> >    the block of code just as with an #ifdef, so this will not add any runtime
> >    overhead.  However, this approach still allows the C compiler to see the code
> >    inside the block, and check it for correctness (syntax, types, symbol
> >    references, etc).  Thus, you still have to use an #ifdef if the code inside the
> >    block references symbols that will not exist if the condition is not met.
> >
> > So our process documentation *explicitly* recommends against using
> > #ifdef CONFIG_XXX ... #endif, and instead use something that will
> > -Wunreachable-code-aggressive to cause the compiler to complain.
>
> I agree.

I agree too.

> >
> > Hence, this is not a warning that we will *ever* be able to enable
> > unconditionally ---
>
> I agree.
>
> > so why work hard to remove such warnings from the
> > code?  If the goal is to see if we can detect real bugs using this
>
> Because not every instance of -Wunreachable-code-aggressive may be that pattern.

The goal is to try to detect real bugs. In this instance specifically I
suggested to remove the "if (0) {...}" because it sounded like an
unused code.

If it is useful it is fine to keep.

For now I am only looking for dead code that cannot be enabled
by a configuration file or architecture. In fact, there are several
warnings that I am ignoring because they are a dead code in my
build but may not be in another.

> > technique, well and good.  If the data shows that this warning
> > actually is useful in finding bugs, then manybe we can figure out a
> > way that we can explicitly hint to the compiler that in *this* case,
> > the maintainer actually knew what they were doing.
> >
> > But if an examination of the warnings shows that
> > -Wunreachable-code-aggressive isn't actually finding any real bugs,
> > then perhaps it's not worth it.
>
> I agree. Hence the examination of instances found by Vinicius.

I liked the idea to create htree_rep_invariant_check. I will be doing
that.

Thanks for the help and suggestions.

> --
> Thanks,
> ~Nick Desaulniers
