Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE251343985
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Mar 2021 07:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhCVGe7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Mar 2021 02:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCVGec (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Mar 2021 02:34:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75B0C061574
        for <linux-ext4@vger.kernel.org>; Sun, 21 Mar 2021 23:34:31 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id a8so11975505oic.11
        for <linux-ext4@vger.kernel.org>; Sun, 21 Mar 2021 23:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctx0cKNhQS9328kca7vR4oHoCxhtBTgUFocYP5+COxA=;
        b=e7g6+G9wSxvk2maOqAcEstni6NV+PgCz5yYU1f1A31Kew299DwGpnYapc8gun1x7v8
         alZFSvdAG4IlXrZQt09cAKybq7tnOVkMiKePmX+82ZLC8FTfRUd8ayZ6Fx56iOKlmrc/
         qT8TqGuGfa/DyhWV9M9oIQjkBb8LtygSK5+miLTF6V76sj7GBwRy2hYM/OArhgplYdlj
         bhXNM0pd5WPIFCAUyfozd66JVA/Et5aqh8IkxK/aGrwtrOMcjy+xhraEja1EQnwTo2Ae
         UTu0aM8ZckhVUCv0xBeNxkoP5bHfM4jHUmbDvf8Fx0Fxp/Y3o5inZmsLJ7Wq8Cvsj8xJ
         xJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctx0cKNhQS9328kca7vR4oHoCxhtBTgUFocYP5+COxA=;
        b=QbC9jRxUHnjctO/Ub8L/kHa1XG7pNrQpVhyCNEyf83ORSUVKRqCqm3pZPGXRZe5zgT
         IDl6KnOMCQZ6MuW16UirASl3aKahiQNBSKYCx3qL4m0EFo45WWlBLiEg9JE6WUUCGD5s
         lnm5me5ycuAzQ+DnfkIkDLaVClxzeaLlxbK4zGFMv2rR+rzlYndE9c+vUclSMVejj4k/
         PnO/2l0zLqojtpJflbytYKBNVNKGtknOMVGtyE5K/TOL/U+F5ByVMcP2zHwc3MR5CQzH
         WWxDQadZgMYm504+Yle51gD2N2cUdzH/I6INANuTvgz/k+iUGqkN6/vGHaQDmpTXvFAK
         TjTw==
X-Gm-Message-State: AOAM531400mQZ5Sw5oCNfzij96hQVYm8HsOCDuj80clLkodnrdedfwZA
        WAFQs2CzX1Ek+M9dG/6rkNM3IpggrRx4NhfupEPepWBymB5QSA==
X-Google-Smtp-Source: ABdhPJxFqFQh4r35vd4ePfHn68ToKGpblLX92ESCOc8jlHIori3NGAiQXv3+96NVAAslSS34cZ6dQvac8g+eNg6/QkY=
X-Received: by 2002:aca:578b:: with SMTP id l133mr9072690oib.96.1616394871201;
 Sun, 21 Mar 2021 23:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <CADve3d51po2wh6rmgrzM8-k9h=JzE9+mC57Y5V2BxfFkKPFMsw@mail.gmail.com>
 <YEtjuGZCfD+7vCFd@mit.edu> <CADve3d7bioEAMwQ=i8KZ=hjrBDMk7gJK8kTUu2E5Q=W_KbUMPg@mail.gmail.com>
 <YE2FOTpWOaidmT52@mit.edu> <CADve3d4h7QmxJUCe8ggHtSb41PbDnvZoj4_m74hHgYD96xjZNw@mail.gmail.com>
 <YFI299oMXylsG9kB@mit.edu> <CADve3d7gZVP_wzuRFymox9EEU05jbsTGdf=nGOAHeouBuR1jog@mail.gmail.com>
 <YFTAZdfbKUsMmb9A@mit.edu>
In-Reply-To: <YFTAZdfbKUsMmb9A@mit.edu>
From:   Shashidhar Patil <shashidhar.patil@gmail.com>
Date:   Mon, 22 Mar 2021 12:04:19 +0530
Message-ID: <CADve3d47X-q_+kn3=LhWV-D-FqtZ_9+juE1NqPwjAhRpVVwHjQ@mail.gmail.com>
Subject: Re: jbd2 task hung in jbd2_journal_commit_transaction
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Theodore

On Fri, Mar 19, 2021 at 8:46 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Mar 18, 2021 at 12:27:44PM +0530, Shashidhar Patil wrote:
> > Hi Theodore,
> >     I forgot to include two important  details , the stack trace of
> > loop0 driver and sar output, which clearly nail  the problem.
> > The losetup with Ubuntu16.05 does not have O_DIRECT support  and we
> > were not aware of bypassing of journalling if
> > O_DIRECT combined with preallocated file scenario.
>
> Which version of the kernel are you using?  The use of O_DIRECT for

I am using *antediluvian* ubunut 16.04 LTS as below

$ uname -a
Linux ubuntu 4.15.0-117-generic #118~16.04.1-Ubuntu SMP Sat Sep 5
23:35:06 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

> loop devices requires kernel and losetup support.  (Also note that

As per the backtrace of loop0 driver attached it does look like a
problem, right ?

> upstream developers really generally don't pay attention --- or
> support --- distribution kernels unless they work for the company for
> which you are paying $$$ for support, and Ubuntu 16.05 isn't even a

$$$ again. No respite from $$ urge. $ Not good :-)

$ $$$
-bash: 31163$: command not found
:-)
> Long-Term Support distribution.)
>
> My suggestion is to see if you can replicate the problem on a modern
> userspace with the latest kernel.  And if not, then that's an object

I will try to recreate the problem with latest upstream kernel used by
upstream developers.

> lesson about why using a antediluvian is not a great life choice.  :-)
>
I agree with "antediluvian is not a great life choice" but can't
comment on "antediluvian is not a great choice in corporates".

Thank you
-Shashidhar
> Cheers,
>
>                                                 - Ted
