Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2730AFAB
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 19:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhBASmu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 13:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhBASmp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 13:42:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD50C061573;
        Mon,  1 Feb 2021 10:42:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l12so17777871wry.2;
        Mon, 01 Feb 2021 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmtu6bNpF5dPnSRFTlVUqn3pIC+xqRbu0mxekXQ1e2w=;
        b=WssRBfUX/BP94btJvmYdMC1fwhYweLqdT/gL24i2x8cZbzZqcExDKOPndrRlHiP79a
         +ZQy9+L8YnXCVSnptYFeVq08iWCvSgqdkWdwFv9UhfRLKdGlaVOV0c5EQkJBFztNGKiG
         AtP2ywGwFmQXj6sWtdtlNgb5RXe8kqam2YN76dI0jccMUOQHCia2MGWxks8/woiKbSci
         RULGqr0al2n8tg088fXcJVds9bdoq+A1+p00BszIm8eR3xNOGwWxjZnXiVffo7MA1in+
         RpzAAAxQi+jZgBikBo+Z+UdVGhTXExfnl2ArBulZdu1H0/svJ+KuYreAvHkJ4lvEw01J
         grfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmtu6bNpF5dPnSRFTlVUqn3pIC+xqRbu0mxekXQ1e2w=;
        b=aAYIB9CHW47cyM8jIn69axc4s+ndc0RGsmuc943HBgx9jsnNlGyCuHSRhPmh1dxYan
         wdKgmwlHv/ERdiylJDi7TqQD6TuxUgGpumhmSZE73NCnHWkwyxeRJUiLbWDlOEEVS/dQ
         6Wf32jeinVjRx0YXkGca/Y8o/znBFuNb8HtuCOfI8o0LApFSQLOlbb7ya4SgPheWE3mf
         Q2xVBq0wUxKCv6B7XfwInxvUTgKwfXtawK/Rri01o8G7E6GxTQoYmhUfPt66BhNYdOpv
         uXJUKNWDgbwwj9vJouV4gPQulWH9ANexsXD2Wv/Lp7pMDkZpXKgIGooE9ySsFtn4wFv9
         lSRg==
X-Gm-Message-State: AOAM533XaAeYFFLtsr+gn3XZ824bPVieReki3tv+AVDStD603fV5nrhW
        onNQEQ2dupDQxz0k8odfb/7k/IK8efDOBAiwMww=
X-Google-Smtp-Source: ABdhPJy1mD5KiQw9cpQUdYd28pbpaBz11CVQjBrnrPbhNCuFNUsXXIHBLMwYVjSHwmEsvwTcDFCXVXC/MfjTFpkCtZk=
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr19861502wry.254.1612204921821;
 Mon, 01 Feb 2021 10:42:01 -0800 (PST)
MIME-Version: 1.0
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com> <20210201124924.GA3284018@infradead.org>
 <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com> <YBg20AuSC3/9w2zz@mit.edu>
In-Reply-To: <YBg20AuSC3/9w2zz@mit.edu>
From:   Vinicius Tinti <viniciustinti@gmail.com>
Date:   Mon, 1 Feb 2021 15:41:50 -0300
Message-ID: <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 1, 2021 at 2:13 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Feb 01, 2021 at 01:15:29PM -0300, Vinicius Tinti wrote:
> > On Mon, Feb 1, 2021 at 9:49 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > DX_DEBUG is completely dead code, so either kill it off or make it an
> > > actual CONFIG_* symbol through Kconfig if it seems useful.
> >
> > About the unreachable code in "if (0)" I think it could be removed.
> > It seems to be doing an extra check.
> >
> > About the DX_DEBUG I think I can do another patch adding it to Kconfig
> > as you and Nathan suggested.
>
> Yes, it's doing another check which is useful in terms of early
> detection of bugs when a developer has the code open for
> modifications.  It slows down performance under normal circumstances,
> and assuming the code is bug-free(tm), it's entirely unnecessary ---
> which is why it's under an "if (0)".

My goal is to avoid having a dead code. Three options come to mind.

The first would be to add another #ifdef SOMETHING (suggest a name).
But this doesn't remove the code and someone could enable it by accident.

The second would be to add the code in a block comment. Then document
that it is for checking an invariant. This will make it harder to cause
problems.

The third would be to remove the code and explain the invariant in a block
comment. Maybe add a pseudo code too in the comment.

What do you think?

> However, if there *is* a bug, having an early detection that the
> representation invariant of the data structure has been violated can
> be useful in root causing a bug.  This would probably be clearer if
> the code was pulled out into a separate function with comments
> explaining that this is a rep invariant check.

Good idea. I will do that too.

> The main thing about DX_DEBUG right now is that it is **super**
> verbose.  Unwary users who enable it.... will be sorry.  If we want to
> make it to be a first-class feature enabled via CONFIG_EXT4_DEBUG, we
> should convert all of the dx_trace calls to use pr_debug so they are
> enabled only if dynamic debug enables those pr_debug() statements.
> And this should absolutely be a separate patch.

Agreed. For now I only want to focus on the "if (0)".

Regards,
Vinicius

> Cheers,
>
>                                                 - Ted
