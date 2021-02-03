Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C7C30D6BB
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Feb 2021 10:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhBCJwY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Feb 2021 04:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhBCJwV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Feb 2021 04:52:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B666BC061788;
        Wed,  3 Feb 2021 01:51:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 7so23437359wrz.0;
        Wed, 03 Feb 2021 01:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWjEkbuWLlblTtjuIWif0x7AzX7GeK00PJG/7+QyP+g=;
        b=AidCjKbLKSnA/0Mc3oxvE3ZZOkhleknUJCYl2tYBiAxKjpE8JD7Bh8g2fwAlDJvvtn
         E03CpGOgrAKtEoCuUXqwP+PRLLLNWTbLWKDPuRENY3xxOAq8rvK55a1XyLr429KhU+c7
         6kFQ7Q2xVTeE5H45M/41V+nDs7jvJHsxwWd0P2xO6KDtyyiGqqN2w368HHbqPh+f9Z4x
         uRC/S+M9J5tMJfsw2KsPV8w6b9p2xOeC8rdHZXZliD8gyLA+3WTu2YTa2I1e/1tpWcg+
         MQAZHlA59gZuJt5jN1RjoBC3UML7Qqy8NpWOapU3XjmjsklqHoYHCM+bRp88shomHCEB
         gbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWjEkbuWLlblTtjuIWif0x7AzX7GeK00PJG/7+QyP+g=;
        b=ByFUxk1eJX3psdoplVU31rY4PT8unNm4rzVP7O2bBswvx7jU4Yxu4aqh64tZOBSP+S
         +S8QmgCZAuYW7J2gs2VJeoUqqoIfBWFvChkWR/xxYp9Phgr00iLRCSi+51x1kx/eKE3l
         i/xnXAarsGrEA9YLUwVKm6M5jMEPINMUIgd8qDSA+IZ8qHgGyKIZElD/p4nC2Jz/R1LL
         uIF18irfbnSZCUtmq8xXGogZaP/h829Jwn5KHBFAfaPM9dZEpYAQ9uHQeiPPM92yX2UW
         /rCrUz6tgOrGaswHTsU406MVuBKTc4GJUppR2yYrWmgUvD62yvxp8UheHPZjV3mkxdkN
         2eEQ==
X-Gm-Message-State: AOAM533HqqbAPCPy092zER+AD5HeVnlvOk0eotisO61xLWbYxZxMA3Y3
        DSDbJ9ATI26CuUT4ZZSMrQnRvrEaZTWhI8yy9wE=
X-Google-Smtp-Source: ABdhPJyMqE6Wc+e5vmqeI4Xt0k2hIzTgXucEC4AiLGmtIm/SKbqM7oMhZuoRipbkFcpW4wF+H6JpCaKJbsigqfaOwwk=
X-Received: by 2002:a05:6000:188b:: with SMTP id a11mr2459195wri.151.1612345897392;
 Wed, 03 Feb 2021 01:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20210202080508.GA3550351@infradead.org> <20210202162837.129631-1-viniciustinti@gmail.com>
 <YBo29/SdgCkZZinT@mit.edu>
In-Reply-To: <YBo29/SdgCkZZinT@mit.edu>
From:   Vinicius Tinti <viniciustinti@gmail.com>
Date:   Wed, 3 Feb 2021 06:51:26 -0300
Message-ID: <CALD9WKz-Jgmz7inOghv37ZwzD_8sVPT_-YZUX5FpQE5aKrDJJg@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: Enable code path when DX_DEBUG is set
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 3, 2021 at 2:39 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Feb 02, 2021 at 04:28:37PM +0000, Vinicius Tinti wrote:
> > Clang with -Wunreachable-code-aggressive is being used to try to find
> > unreachable code that could cause potential bugs. There is no plan to
> > enable it by default.
> >
> > The following code was detected as unreachable:
> >
> > fs/ext4/namei.c:831:17: warning: code will never be executed
> > [-Wunreachable-code]
> >                         unsigned n = count - 1;
> >                                      ^~~~~
> > fs/ext4/namei.c:830:7: note: silence by adding parentheses to mark code as
> > explicitly dead
> >                 if (0) { // linear search cross check
> >                     ^
> >                     /* DISABLES CODE */ ( )
> >
> > This has been present since commit ac27a0ec112a ("[PATCH] ext4: initial
> > copy of files from ext3") and fs/ext3 had it present at the beginning of
> > git history. It has not been changed since.
> >
> > This patch moves the code to a new function `htree_rep_invariant_check`
> > which only performs the check when DX_DEBUG is set. This allows the
> > function to be used in other parts of the code.
> >
> > Suggestions from: Andreas, Christoph, Nathan, Nick and Ted.
> >
> > Signed-off-by: Vinicius Tinti <viniciustinti@gmail.com>
>
> Thanks, applied, although I rewrote the commit description:
>
>     ext4: factor out htree rep invariant check
>
>     This patch moves some debugging code which is used to validate the
>     hash tree node when doing a binary search of an htree node into a
>     separate function, which is disabled by default (since it is only used
>     by developers when they are modifying the htree code paths).
>
>     In addition to cleaning up the code to make it more maintainable, it
>     silences a Clang compiler warning when -Wunreachable-code-aggressive
>     is enabled.  (There is no plan to enable this warning by default, since
>     there it has far too many false positives; nevertheless, this commit
>     reduces one of the many false positives by one.)
>
> The original description buried the lede, in terms of the primary
> reason why I think the change was worthwhile (although I know you have
> different priorities than mine :-).
>
> Thanks for working to find a way to improve the code in a way that
> makes both of us happy!

Thanks for the feedback.

And thanks for all the ones who reviewed.

>                                         - Ted
