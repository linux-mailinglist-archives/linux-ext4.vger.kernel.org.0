Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56075BBF9
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2019 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfGAMn0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Jul 2019 08:43:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33403 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfGAMn0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Jul 2019 08:43:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id u15so9697678oiv.0;
        Mon, 01 Jul 2019 05:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0ZbxY3O8o2NP9TexAMOwwfSs+xrQAQGyizd11XhK8Uk=;
        b=TIgRyR0LA86uJoZTcDD5dBk/CNS5MM8HUecDdf9mvRhh+N3CUyuJnM6lXDyGzupcbI
         29DXSpm6yE9T7vd1gO8F27XB7FcBJO7NGu8IljyJo2+nPMJupYTkJDpjoplL1xpn1dkE
         WiIxzQBUHGgOB4VjzzNlVxvpbEa07dWEozIZVBRx/dhP6NKpsR+2mSYYE3EvttTtX7Da
         68AucV46Lm4FkNK7u1+gxf63CzA6HEsfzVHwk45gUV5buXuNJiR/uCklzvZcyZtewzwm
         0yqitgYS7FIDBebnOyncR7wMESum1Ox5s484yb6M2vgTS4H0UkqNTuGdKSUWitOylLT/
         DqVQ==
X-Gm-Message-State: APjAAAXGFha8aLUadTfGmb2nHg3CpYOtO5U0ZvbneQmjXvI12Jpo8gOK
        QwndgKV5/zSY6So3cP1nqHbYPQwmsuEK+/5GgJ4=
X-Google-Smtp-Source: APXvYqyblOS/qtfu8kJg+Wvk3SX2O68dr4THZP1KeL8DXVnYrMO7nsHTasiHahYQ+V+HrFxwliyZczCQoa9yogvWNJI=
X-Received: by 2002:aca:bd43:: with SMTP id n64mr6147488oif.148.1561985005437;
 Mon, 01 Jul 2019 05:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net>
 <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com>
 <20190511220659.GB8507@mit.edu> <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net>
 <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net> <17C30FA3-1AB3-4DAD-9B86-9FA9088F11C9@internode.on.net>
 <20190515045717.GB5394@mit.edu> <CAMuHMdV=63MwLdOB2kcX0=23itHg+_q22wXCycTvH3yn4zsfWw@mail.gmail.com>
In-Reply-To: <CAMuHMdV=63MwLdOB2kcX0=23itHg+_q22wXCycTvH3yn4zsfWw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Jul 2019 14:43:14 +0200
Message-ID: <CAMuHMdU-vfWjomDpttYTqgp4YzBu7z__p48r7rq6TSUwx7uFqQ@mail.gmail.com>
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Fri, May 17, 2019 at 6:44 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, May 15, 2019 at 6:57 AM Theodore Ts'o <tytso@mit.edu> wrote:
> > Ah, I think I see the problem.  Sorry, this one was my fault.  Does
> > this fix things for you?
>
> Thanks!
> Sorry for missing this patch in the thread before.
>
> > From 0c72924ef346d54e8627440e6d71257aa5b56105 Mon Sep 17 00:00:00 2001
> > From: Theodore Ts'o <tytso@mit.edu>
> > Date: Wed, 15 May 2019 00:51:19 -0400
> > Subject: [PATCH] ext4: fix block validity checks for journal inodes using indirect blocks
> >
> > Commit 345c0dbf3a30 ("ext4: protect journal inode's blocks using
> > block_validity") failed to add an exception for the journal inode in
> > ext4_check_blockref(), which is the function used by ext4_get_branch()
> > for indirect blocks.  This caused attempts to read from the ext3-style
> > journals to fail with:
> >
> > [  848.968550] EXT4-fs error (device sdb7): ext4_get_branch:171: inode #8: block 30343695: comm jbd2/sdb7-8: invalid block
> >
> > Fix this by adding the missing exception check.
> >
> > Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using block_validity")
> > Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> Intermittent issue no more seen in 10 test boots, so
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Despite this fix having been applied upstream,  the kernel prints from
time to time:

    EXT4-fs (sda1): error count since last fsck: 5
    EXT4-fs (sda1): initial error at time 1557931133:
ext4_get_branch:171: inode 1980: block 27550
    EXT4-fs (sda1): last error at time 1558114349:
ext4_get_branch:171: inode 1980: block 27550

This happens even after a manual run of "e2fsck -f" (while it's mounted
RO), which reports a clean file system.

The inode and block numbers match the numbers printed due to the
previous bug.

Do you have an idea what's wrong?
Note that I run a very old version of e2fsck (from a decade ago).

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
