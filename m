Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4F830B321
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 00:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBAXKK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 18:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhBAXKI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 18:10:08 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C7AC06174A
        for <linux-ext4@vger.kernel.org>; Mon,  1 Feb 2021 15:09:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lw17so690339pjb.0
        for <linux-ext4@vger.kernel.org>; Mon, 01 Feb 2021 15:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEACQRgbmcNz8U0z7UDtnpZG1N/k6q1juxg0BiyuRck=;
        b=jcCexse5x5viIjyqRk/y5mlMoRBb37kn+h2DynfRh9CPkpCUZvw57riM5Gi3chT72o
         CbjVM0TyHXwMcYIJF7XQk7oSx3tqL0DJoW+6ZTL7awz2PCOAzWALcKtKIkscqgdAS+Gc
         77zQL6+T9j9Y50TtmJl9WyyTglQbUcODNt/KvAwo9Ankwfj2hcsMdDLtVxBimPo7YNch
         4OBb+qFKWQsAS4jSny4JBlmxDnDQsDOJT8zE6iLkurDsvmCMW0kb8R/BDefizWxpO0KE
         owCJjEWFWzDtQJs+egmj+wBYbKprb/ZVKDFql/vVQCyVTjKpytpTsrvltZRB1Qf0pIV+
         kSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEACQRgbmcNz8U0z7UDtnpZG1N/k6q1juxg0BiyuRck=;
        b=B5RycF0YiR27Ubqrkv/DkWk+xx8VeFUbFLRygBuWPqLqwKOslzANiMXRhdYkDA3Bow
         K1VhN9DwJov7OfJvYyP+CoctDxjDkGf8D3RnIRLemMnyR7yo3Bqn/JTT4QZ+zD5a2T9I
         kEas98AmZTH+gFI68SIoUneL3RXcfADYGmR1biPuhJQnAQhUP9833e2lpQT4isM2591W
         cC8S+PlKHu1XRYhZSB9jPUkJGWgSPhLx/yErlBe45hwCF1wbczd8G4HX6KWADdBkFnJd
         do2Sg64raTEg1Xh/3EBU7G4a1DvHu2TubjlE2Bg6Ypm7prwvF2B2x5DqMKLKmJRuBauQ
         VOKw==
X-Gm-Message-State: AOAM5328afe5FSIndqAXqmOBFlHMLxohozO4CNOt1orpkJ8FZwmGSAKA
        t4luJSaO6ME9MFVICVDcAnSldYyRMnGmF0nTnkQ+FQ==
X-Google-Smtp-Source: ABdhPJyUeJz/A2+S7M/6sGFuaKli4u2WLQhwpVweNnvF5ZutgJsE2TgbxoIasIyhDAnP65Mb9LCHT0k8gzhoZqWGsvk=
X-Received: by 2002:a17:902:728f:b029:e1:70dd:ac67 with SMTP id
 d15-20020a170902728fb02900e170ddac67mr4444213pll.29.1612220967989; Mon, 01
 Feb 2021 15:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20210201003125.90257-1-viniciustinti@gmail.com>
 <20210201124924.GA3284018@infradead.org> <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
 <YBg20AuSC3/9w2zz@mit.edu> <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
 <YBhuHJgZ3QPqHheV@mit.edu> <CAKwvOd=ny2TeYV8SGZMD+aj8Yb6OSYGKAzSb-45r-HKk6WTUCQ@mail.gmail.com>
 <YBh0ywVzkUIR3fXg@mit.edu> <CAKwvOdkZRdBzzW19sVAs+pX-7wWwN6AWrxUkkZwP8L4OT7SLfQ@mail.gmail.com>
 <CALD9WKx6HREQeTRXuv81v-=DTVuznXG_56YFm2dM1GOG3s4BRQ@mail.gmail.com> <YBiFVgatiz+owBs9@mit.edu>
In-Reply-To: <YBiFVgatiz+owBs9@mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Feb 2021 15:09:16 -0800
Message-ID: <CAKwvOdk_OdMB5+YMKdWmK08Px=qYFy1X+imK+LqJbyptesEEQw@mail.gmail.com>
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

On Mon, Feb 1, 2021 at 2:48 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Feb 01, 2021 at 07:05:11PM -0300, Vinicius Tinti wrote:
> >
> > The goal is to try to detect real bugs. In this instance specifically I
> > suggested to remove the "if (0) {...}" because it sounded like an
> > unused code.
> >
> > If it is useful it is fine to keep.
>
> The trick was that it was unused code, but it was pretty obviously
> deliberate, which should have implied that at some point, it was
> considered useful.   :-)
>
> It was the fact that you were so determined to find a way to suppress
> the warning, suggesting multiple tactics, which made me wonder.... why
> were you going through so much effort to silence the warning if the
> goal was *not* to turn it on unconditionally everywhere?

Because a maintainer might say "oh, I meant to turn that back on years
ago" or "that should not have been committed!"  Hasn't happened yet,
doesn't mean it's impossible.  Vinicius asked how he can help. I said
"go see if any instances of this warning are that case."

>
> I suspect the much more useful thing to consider is how can we suggest
> hueristics to the Clang folks to make the warning more helpful.  For
> example, Coverity will warn about the following:
>
> void test_func(unsigned int arg)
> {
>         if (arg < 0) {
>                 printf("Hello, world\n")
>         }
> }

Put that code in in godbolt.org (https://godbolt.org/z/E7KK9T) and
you'll see that both compilers already warn here on -Wextra (via
-Wtautological-unsigned-zero-compare in clang or -Wtype-limits in
GCC).
clang:

warning: result of comparison of unsigned expression < 0 is always
false [-Wtautological-unsigned-zero-compare]
        if (arg < 0) {
            ~~~ ^ ~

gcc:

warning: comparison of unsigned expression in '< 0' is always false
[-Wtype-limits]
    3 |         if (arg < 0) {
      |                 ^


>
> P.S.  If anyone wants to file a feature request bug with the Clang
> developers, feel free.  :-)



-- 
Thanks,
~Nick Desaulniers
