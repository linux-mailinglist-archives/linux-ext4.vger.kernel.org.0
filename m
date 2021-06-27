Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753B23B55C9
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jun 2021 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhF0XPn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Jun 2021 19:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhF0XPm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 27 Jun 2021 19:15:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01B4C061574
        for <linux-ext4@vger.kernel.org>; Sun, 27 Jun 2021 16:13:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l8so9799753wry.13
        for <linux-ext4@vger.kernel.org>; Sun, 27 Jun 2021 16:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1iUrs8dAfHDtBEzhFAIF8vunt4UpMaMnt70oTygcqs=;
        b=rsx/qIe5Yqs/IA5OY+Px4/rd4376d3y+YjR4duzHk8evHwreODPZyUGr7ZabWPOrAL
         4paTnCMO6Cjal92C3qefJ3X9j/6wNvH8q8/n2kCE+l3KUN9K636daz72EyO1hEfvPLBe
         p9pTU8oL1ypPGNGNColgk5npLLGhhYjGtJ6us74+udp5rmkzMlGlj+ToWc5JS+0kH/8y
         zeX7FdygPNTDVlFAeW/9poiIa2EzNKDAHbT+pFzXpyVaTn6odvf1IJ3ZnVLUKOBFrnAl
         ENn2vtZccfOmeIXq3V7C4N/kF+CgU+/UqPXX5VbJfI2+brxZV3YJl3Y9V/4Tc1Rieka4
         Mpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1iUrs8dAfHDtBEzhFAIF8vunt4UpMaMnt70oTygcqs=;
        b=F/viLRRTQR0qRrWa6JDURjdGwBi637lNNqVLC4Sd/hWP42AxP/jfKwoDtHH+QoK2k9
         1bS8CQEZZVG0pGcSLCzKmrgmeN1bKBTSytPWMsW2OtAiOst4Z7K879Ee2CFp2tTdoqLR
         FGJYPopTraZEssRmHBSlcS5BoC2/jdrlMGj49O/PB1FzMg/sQmZYzjIH/Fjz4+pGwVCd
         y/+AeoKK2KT9OGBKWbHzJFTxLRe420286+QJb6g7jQ49rLYmr4FPISqeOdkZEGd4Et6T
         Ri1bV6x+Gq+L8BvJa/Zs4EGMcy80GAN7cjT8G4tNQ+tnZvjvHIXv9O/OZkQ2svGqD5DW
         CZDw==
X-Gm-Message-State: AOAM531+tgZFdyrJRWbGkX3wHtyesJTJBdJRCH5bc4S4ceF3cZFx7FVR
        l5bNfEu19Z4eakR7BModLxGyhJPvZecK9q+X49c=
X-Google-Smtp-Source: ABdhPJz8SHNhs8YGqnlydrFgJMGzkBbNsKIRzBBIzCZEjCFjxa6kSEpg/IaigvekZD5fNLd9SJ4Zji8FyE//9Gm2uKs=
X-Received: by 2002:adf:f048:: with SMTP id t8mr23771405wro.35.1624835595302;
 Sun, 27 Jun 2021 16:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210625124033.5639-1-wangshilong1991@gmail.com> <20210627224217.GL2419729@dread.disaster.area>
In-Reply-To: <20210627224217.GL2419729@dread.disaster.area>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Mon, 28 Jun 2021 07:13:04 +0800
Message-ID: <CAP9B-Qnngwh+PL3wEBRWZQszaO00h5W=wiQG1WT3MBT65oMhyw@mail.gmail.com>
Subject: Re: [PATCH] ext4: forbid U32_MAX project ID
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 28, 2021 at 6:42 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Jun 25, 2021 at 08:40:33AM -0400, Wang Shilong wrote:
> > From: Wang Shilong <wshilong@ddn.com>
> >
> > U32_MAX is reserved for special purpose,
> > qid_has_mapping() will return false if projid is
> > 4294967295, dqget() will return NULL for it.
> >
> > So U32_MAX is unsupported Project ID, fix to forbid
> > it.
>
> Actually, it's INVALID_PROJID, not U32_MAX, and we already have a
> check function for that:
>
> static inline bool projid_valid(kprojid_t projid)
> {
>         return !projid_eq(projid, INVALID_PROJID);
> }
>

I was not aware of this, thanks for pointing it out.

> > Signed-off-by: Wang Shilong <wshilong@ddn.com>
> > ---
> >  fs/ext4/ioctl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > index 31627f7dc5cd..f3a8d962c291 100644
> > --- a/fs/ext4/ioctl.c
> > +++ b/fs/ext4/ioctl.c
> > @@ -744,6 +744,9 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
> >       u32 flags = fa->flags;
> >       int err = -EOPNOTSUPP;
> >
> > +     if (fa->fsx_projid >= U32_MAX)
> > +             return -EINVAL;
> > +
>
> This should actually be calling qid_valid() or projid_valid(),
> and it should be in generic code because multiple filesystems
> support project quotas.  i.e this should be checked in
> fileattr_set_prepare(), not in ext4 specific code.

I tried to fix ext4/f2fs, i am not sure about XFS, it looks to me XFS
implemented quota mostly by itself.

Anyway, let me fix this in generic code.


>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
