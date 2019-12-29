Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9A12C0F6
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Dec 2019 07:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfL2G6s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Dec 2019 01:58:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50572 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfL2G6r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Dec 2019 01:58:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so11658375wmb.0
        for <linux-ext4@vger.kernel.org>; Sat, 28 Dec 2019 22:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5gCJKX43/q/Sg91dn2WFD39ZfLqxo3FjBbndIOx0eiM=;
        b=JKI/3sMFlGCXCm2wOQRY+M+pbEGp6roQpobRWGUNEqmCvotav7b9j+//nEyugpuQ/l
         u7RmvtQHX/sdGGnYL77xqooeh9sO9om2GjIV5eMfuiZolX3kCD24BY0cBipzGSPM5YsU
         YvuJ446ifMEgLeV4JEPyO8v27v0aXrCfMgW2Z7fq5gldDFlbiz2URFcHgvup9l/WTWIs
         gOZQI2wt4TbZXt3IYhBaQ2XmOiD4QCOfEflD4xwDav400xXjeeI0OhDvYvPW/eMQWMb/
         5GsPErc1pB3Co/HGDjxcv8r466NhT9lfczSAGyn/I0FajW1iMJ3faHN62LdFRUueueoY
         ypfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5gCJKX43/q/Sg91dn2WFD39ZfLqxo3FjBbndIOx0eiM=;
        b=geaV4I/kl/j8eZLkRSdc/BaznUaZXIZm1nvKQI7t7+EiNKZPIAPxiICQ99pcFXA5Ig
         axPUyTrCgFh5hoK2Hyg3Iuqrs7Gr4VadPbk4zsAiih3j1ws9L9hkIjmyspvSUUWzrSFE
         h6IHJXI+3Jmcc7aiSfAtlb1DI7Ywc/5uDIdvhcmTPoThYAGQDjXJDzwKZzbGkXN53DF7
         rzyMKi4QeB41F1MxXvHPEYanEKPKsq7Cm7PRW78ABdQUouGPCwt9HvqpOB4/aaU42QwJ
         7akF9Zxwgmu2OcfSgh6gRfILgNz3DefGpE0GpyOedSlmfkw1PjUTdSSKNZZ6wkO/1y+P
         orGQ==
X-Gm-Message-State: APjAAAWgSsUpmGEXl7oVVluVfBF+hS2eYoDxcdHbRygZ9r9+lg9suQpQ
        cXo9qKQSmY3ZOZl5HYQR8tHVRqwKJKsiIGjGmk+VAA==
X-Google-Smtp-Source: APXvYqz+1idqLUq4YqYmpQbxZ8DMOQlQZOxc5WbIX/fWeKd+ooM7w2PY7dLY6G9fAw24gDP1m7TRpyOiNrqwNzlcPrE=
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr27837147wmj.130.1577602724560;
 Sat, 28 Dec 2019 22:58:44 -0800 (PST)
MIME-Version: 1.0
References: <CAAJeciUWm9W-AyFwJdUqC3W6n4bBDHMrzBF=V2d_iMywDW2+uQ@mail.gmail.com>
 <20191226130935.GA3158@mit.edu>
In-Reply-To: <20191226130935.GA3158@mit.edu>
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Sun, 29 Dec 2019 14:58:21 +0800
Message-ID: <CAAJeciX4oG9MU9tHEccF3ZTu+G4KFOdssa6bGRNgh6mNX+B5Lg@mail.gmail.com>
Subject: Re: the side effect of enlarger max mount count in ext4 superblock
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi ted :

thank you,  sorry for my late reply.

shall the e2fsck tool can be divided into two parts ?
one part only do the full data consistency check work, focus on
checking if data has inconsistency just when ext4 filesystem has been
frozen or very few IO activities are going on.
and the other part can be doing the actual repair work if data
inconsistent  has encountered.

but i wonder if some problems will happen if doing the full data
consistency checking online, without ext4 filesystem umount.
so even if very few io activities are going on,  the data checking
can't be implemented. just because some file data may be in memory,
not in disk.
so the data consistency checking only can be started when ext4
filesystem has been frozen from my viewpoint, at least at this moment,
file data can be returned back to disk as much as possible.

is my idea showed above right ? thanks if some one give some suggestions on=
 it.
i will investigate the time and frequency of ext4 filesystem frozen on
android system if my idea above is right.



On Thu, Dec 26, 2019 at 9:09 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Dec 26, 2019 at 06:25:01PM +0800, xiaohui li wrote:
> > so i wonder the reason why set EXT4_DFL_MAX_MNT_COUNT value to 20 in
> > fs/ext4/ext4.h and not set a large value to it ?
>
> It sounds like you're still using the old make_ext4fs program that is
> in the older versions of AOSP?  More recently, AOSP uses mke2fs to
> create the file system, in combination with e2fsdroid.  And newer
> versions mke2fs sets the max count value to 0, which means it doesn't
> automatically check the file system after 20 reboots.  This is for the
> reason that you stated; for larger storage devices, a forced e2fsck
> run can take a long time, and if it's not necessary we can skip it.
>
> > is there any reason or any condition when file system data error or
> > stability problems happens and ext4 can't get this information, can't
> > set the error flag in superblock, and so will not call the e2fsck full
> > check during next e2fsck check=EF=BC=9F
> > and because of this reason or condition, it will have to do periodic
> > e2fsck full check.
>
> The reason why we used to set max mount count to 20 is because there
> are indeed many kinds of file system inconsistencies which the kernel
> can not detect at runtime or when it tries to mount the file system,
> and that can lead to data loss or corruption.  So setting a max mount
> count of 20 was way of trying to catch that early, hopefully before
> *too* much data was lost.
>
> Metadata inconsistencies should *not* be happening normally.  Typical
> causes of inconsistencies are kernel bugs or media problems (e.g.,
> eMMC, HDD, SSD failures of some sort; sometimes because they don't do
> the right thing on power drops).
>
> Unfortunately, many Android devices, especially the cheaper priced
> versions, are using older SOC's, with older kernels, which are missing
> a lot of bug fixes.  Even if they have been fixed upstream, kernel
> coming from an old Board Support Package may not have those bug fixes.
> This is one of the reasons my personal advice to friends is get higher
> end Pixels and not some of the cheaper, low-quality Android devices
> coming out of Asia.  (Sorry.)
>
> If you're using one of those older, crappier BSP kernels, one of the
> ways you can find out how horrible it is to see how many tests fail if
> you use something like android-xfstests[1].  In some cases, especially
> with an older kernel (for example, a 3.10 or 3.18 kernel), running
> file system stress tests can cause the kernel to crash.
>
> [1] https://thunk.org/android-xfstests
>
> If you are using high quality eMMC flash (as opposed to the cheapest
> possible grade flash to maximize profits), and you have tested your
> flash to make sure they handle power drops correctly (e.g., that the
> FTL metadata never gets corrupted on a power drop, and all data
> written after a FLUSH CACHE command is retained after a power drop),
> and you are using a kernel which is regularly getting updated to get
> the latest security and bug fixes, then there is no need to set max
> mount count to a non-zero value.
>
> If you are not in that ideal state, then question really boils down to
> "do you feel lucky?".  Although that's probably true with or without
> max mount count set to 20.   :-)
>
> Cheers,
>
>                                         - Ted
