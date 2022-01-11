Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D6C48B1EE
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jan 2022 17:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349866AbiAKQUM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Jan 2022 11:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349922AbiAKQUF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Jan 2022 11:20:05 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364C3C061748
        for <linux-ext4@vger.kernel.org>; Tue, 11 Jan 2022 08:20:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a18so68246049edj.7
        for <linux-ext4@vger.kernel.org>; Tue, 11 Jan 2022 08:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4x5N/JXGJTsGUQhsE81ZfSKOEQ5lT1kVmjGzS+9mXD8=;
        b=WFifv+LmvoQBcgEXxkWgaGmmr/ey71gwLLOrZ6WbbL1Y420pyCfrtow/gezxW4y0FJ
         ZhvolLY4IEltJC6sJ/bD3ah09656GD6x3Hu7bi0lh6x5lbIHYoIINjcwvsHmLUiB5gUL
         WuyXLbfOMX1W2b7Ad3hHU4SK7+Lmb/G1hhX4+HBG3kolnbhiwJv2u9TlEXVFhIE7djOf
         ECGHTWY2XZ/ZIjBNzTZ0ZYBDMhDwarcbjbub9LOXN+VvpR+0ErIXZM8sxBgLbh/YXjCG
         +yhnwddc9l8ODm2pJtkBx/kZVmr9o3fOwEbJruEnKXsOAp4A228E6Yql4S4AKD5oFZKg
         Cctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4x5N/JXGJTsGUQhsE81ZfSKOEQ5lT1kVmjGzS+9mXD8=;
        b=u0M8zhM2jgogo43W3xh2HVTsEG0MfEETN7HRdRnK/AV+ydmOeFF/SmeH0Rikt900B3
         qKoUuChe6c66qv2rCU/iFX5PjY65araemnwo3m5XSpHkOZfho693E6dIdAyBIg5tl3UK
         0IMMAnML/iMCNf79QrSOUsAUzLA9a7swDsmwsyTGnfop7qcGWsnpt+CEoqr/p8xiWVN5
         tvg6o0NpfG4PEsK/b6p4C4bRYRSFByyGLhZzrf/kC0gctwUVsG4czzwRWqt37dq5zzmi
         J1OKcEc64i7/fbQYKGQUFfLsnE84/i1XYbvuCN6n/QBFczVpfYwd6OSHVbM86mIT1LiT
         3G4A==
X-Gm-Message-State: AOAM532hgNRynVvgTdQesUhGQ/mginxgX+xERkfTl9yiNapsuTk1ghjU
        90dhVQ2bu2ixoKf8daqnL6HDQmwuyZOaKMBXotk=
X-Google-Smtp-Source: ABdhPJxFGy9J276Z+w0ijGlh7Ri8+SLYz974ffV5LhI6NQQXdhFZzEzoG0CHkeIr+hWUfJniyZf1bj6Lr7AboJPh5bE=
X-Received: by 2002:a05:6402:4241:: with SMTP id g1mr5085586edb.11.1641918001772;
 Tue, 11 Jan 2022 08:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20211223202140.2061101-1-harshads@google.com> <20220111125257.ffdn4gmtvfdkunr2@riteshh-domain>
In-Reply-To: <20220111125257.ffdn4gmtvfdkunr2@riteshh-domain>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 11 Jan 2022 08:19:50 -0800
Message-ID: <CAD+ocbxw8oYg6RVXViwwwh1zuu4mrOQdJ6p0rT_FuXF=sMGaJA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ext4 fast commit API cleanup
To:     riteshh <riteshh@linux.ibm.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshads@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Ritesh,

Yes, your understanding is correct, this patch series does have a side
effect that the entire file system gets locked before starting a fast
commit. However, this regression is meant to be temporary (mainly to
prevent merging of unnecessary correctness patches). I am working on
another series which fixes this by only locking the inode that is
being committed. That patch should be out shortly.

The reason I hurried this patch series in without the inode locking
patches first was that we had some consistency and file system hanging
issues which needed to be fixed in the right way before the code
becomes more cluttered with temporary correctness fixes which would
eventually get dropped out. The hope is that with these patches, such
fixes wouldn't need to be merged in.

But yeah, I am fully aware of the performance degradation that this
series introduces and you will soon see another patch series that
fixes that issue.

Thanks,
Harshad

On Tue, Jan 11, 2022 at 4:53 AM riteshh <riteshh@linux.ibm.com> wrote:
>
> On 21/12/23 12:21PM, Harshad Shirwadkar wrote:
> > This patch series fixes up fast commit APIs. There are NO on-disk
> > format changes introduced in this series. The main contribution of the
> > series is that it drops fast commit specific transaction APIs and
> > makes fast commits work with journal transaction APIs of JBD2
> > journalling system. With these changes, a fast commit eligible
> > transaction is simply enclosed in calls to "jbd2_journal_start()" and
> > "jbd2_journal_stop()". If the update that is being performed is fast
> > commit ineligible, one must simply call ext4_fc_mark_ineligible()
> > after starting a transaction using "jbd2_journal_start()". The last
> > patch in the series simplifies fast commit stats recording by moving
> > it to a different function.
> >
> > I verified that the patch series introduces no regressions in "quick"
> > and "log" groups when "fast_commit" feature is enabled.
> >
> > Changes from V1:
> > ---------------
> >
> > - In the V1 of the patch series, there's performance regression. With
> >   this patch series, we lock the entire file system from starting any
> >   new handles during (which ensures consistency at the cost of
> >   performance). What we ideally want to do is to lock individual
> >   inodes from starting new updates during a commit. To do so, the V2
> >   of this patch series retains the infrastructure of inode level
> >   transactions (ext4_fc_start/stop_update()). In future (not in this
> >   series), we would build on this infrastructure to lock individual
> >   inodes and drop the file system level locking during the commit path.
>
> Hello Harshad,
>
> Sorry about being so late in the game :(
>
> So from what I understood from your above commit msg is that even the current
> v2 patch series suffers from the same performance regression which is:-
> we lock the filesystem from any starting transaction updates
> (by taking j_barrier or say by calling jbd2_journal_lock_updates()) while
> fast_commit's commit operation is in progress (which happens during a file fsync()).
> This means when fast_commit's commit operation is in progress, then we can't even
> start a new transaction for recording any metadata updates to any inodes of my FS.
>
> Is above understanding correct w.r.t this v2 patch series?
> If yes, then why do we need to lock the full filesystem from starting any
> journal txns? Why can't we let any process starts a new transaction while
> the previous fast_commit's commit operation is in progress?
>
> JBD2 does allow us to do that right? i.e. while a jbd2 commit is in progress,
> a new running transaction can be allocated and all the new metadata updates will
> now be tracked in the new running txn, right?
>
> -ritesh
>
>
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > Harshad Shirwadkar (4):
> >   ext4: use ext4_journal_start/stop for fast commit transactions
> >   ext4: drop ineligible txn start stop APIs
> >   ext4: simplify updating of fast commit stats
> >   ext4: update fast commit TODOs
> >
> >  fs/ext4/acl.c         |   2 -
> >  fs/ext4/ext4.h        |   7 +-
> >  fs/ext4/extents.c     |   9 +-
> >  fs/ext4/fast_commit.c | 188 ++++++++++++++++--------------------------
> >  fs/ext4/fast_commit.h |  27 +++---
> >  fs/ext4/file.c        |   4 -
> >  fs/ext4/inode.c       |   7 +-
> >  fs/ext4/ioctl.c       |  13 +--
> >  fs/ext4/super.c       |   1 -
> >  fs/jbd2/journal.c     |   2 +
> >  10 files changed, 96 insertions(+), 164 deletions(-)
> >
> > --
> > 2.34.1.307.g9b7440fafd-goog
> >
