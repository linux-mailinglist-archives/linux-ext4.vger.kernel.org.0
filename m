Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E656B155B6E
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 17:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBGQJB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Feb 2020 11:09:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39674 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBGQJA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Feb 2020 11:09:00 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so2624942oty.6
        for <linux-ext4@vger.kernel.org>; Fri, 07 Feb 2020 08:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExCyh8f2qvxA4qvVKJp1KepYAznGBkpQOkRSD2+vZvQ=;
        b=pdbmrQS3ijhW+jkmgozYIp1qaEPvHD/a6haD+u8hi63cYN+qeHtHK36ZCVwo41PeLq
         yhJyGLpCnCQdH39T0K23fsV/KNPx9UIhih03Zl9ltSttvaqm20394aBN0RryNtEcy3Gr
         vcg01TAHAoUOy4t1lwU16nB1e92la3hW50aHfohxuGwgKvtrB0V01CS4MlNkLejj7oT4
         U19h2PI8udZ0drtEUYMnX+C6Z8RJLsIazLhtH6ciQcVSF668Aem91k7r4WzuWgsP5IE0
         near1G+A5emrKzsgopxWFMb+UKhjEMUkOL4GEeBdx0QNJ+ENIdAiBpQRjyXk01xs5TJ4
         MQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExCyh8f2qvxA4qvVKJp1KepYAznGBkpQOkRSD2+vZvQ=;
        b=KKe6HP3yeOsOH2Z6hyyByxYI/La5T7Ntn7QnI+4nRbF1+xpGl1IkDF7rTCwaH6MtEY
         BHi6ytiuYdjoal2v5aa/nKmDoJaZ88jzPjNi8OyasJjyMzSDMSE/hQlMHyqzMRj1zpZZ
         X2FzYqV3xenGydl4B5NUUS7Ig1SX2z4rwmTb2gH++HVmPkdwqcDu08B3v2NM0zK/PWE4
         yIrOkfbBdY9i+MHluPFfHnSVqPcAkSwipxtSI4WLny2+aBPngKwR+1DhC/ortTwj9w1p
         +hUSAaZ54vX7974jet17n3ptaESIn0AGso3+pmZZJu/VppjlwIL7Fa9H/Ffo1pISY4QI
         jeEA==
X-Gm-Message-State: APjAAAUWmNBfUr0wJvf2aQcOVy2m0J8Hyui9RfocYsMHhg/3Rw6aJ9Jm
        oQrLZupFo/iPrT+mYFjGcw3Sb9g3HV27Rvrj+eDh3Q==
X-Google-Smtp-Source: APXvYqxG4k94Rp9wpScirL1ahnOi9g6nzM0xsAK3Yck0YQ/25V8gZJ9uO2yEZWPMQlzo4j2/IEx9w4SJakYf46lj4FQ=
X-Received: by 2002:a9d:66d1:: with SMTP id t17mr56428otm.233.1581091737268;
 Fri, 07 Feb 2020 08:08:57 -0800 (PST)
MIME-Version: 1.0
References: <1581085751-31793-1-git-send-email-cai@lca.pw> <CANpmjNNqNzfMbFPGkSQgC7Q7yti30K0xcZmUsG9EtVdXsppjnw@mail.gmail.com>
 <1581089930.7365.20.camel@lca.pw>
In-Reply-To: <1581089930.7365.20.camel@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 7 Feb 2020 17:08:46 +0100
Message-ID: <CANpmjNPNhqWbdeU3MbyBOCCR4pGBfr6F1Lstu9tWmPeLAJnEFg@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: fix a data race in EXT4_I(inode)->i_disksize
To:     Qian Cai <cai@lca.pw>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 7 Feb 2020 at 16:38, Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2020-02-07 at 16:12 +0100, Marco Elver wrote:
> > On Fri, 7 Feb 2020 at 15:29, Qian Cai <cai@lca.pw> wrote:
> > >
> > > EXT4_I(inode)->i_disksize could be accessed concurrently as noticed by
> > > KCSAN,
> > >
> > >  BUG: KCSAN: data-race in ext4_write_end [ext4] / ext4_writepages [ext4]
> > >
> > >  write to 0xffff91c6713b00f8 of 8 bytes by task 49268 on cpu 127:
> > >   ext4_write_end+0x4e3/0x750 [ext4]
> > >   ext4_update_i_disksize at fs/ext4/ext4.h:3032
> > >   (inlined by) ext4_update_inode_size at fs/ext4/ext4.h:3046
> > >   (inlined by) ext4_write_end at fs/ext4/inode.c:1287
> > >   generic_perform_write+0x208/0x2a0
> > >   ext4_buffered_write_iter+0x11f/0x210 [ext4]
> > >   ext4_file_write_iter+0xce/0x9e0 [ext4]
> > >   new_sync_write+0x29c/0x3b0
> > >   __vfs_write+0x92/0xa0
> > >   vfs_write+0x103/0x260
> > >   ksys_write+0x9d/0x130
> > >   __x64_sys_write+0x4c/0x60
> > >   do_syscall_64+0x91/0xb47
> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >
> > >  read to 0xffff91c6713b00f8 of 8 bytes by task 24872 on cpu 37:
> > >   ext4_writepages+0x10ac/0x1d00 [ext4]
> > >   mpage_map_and_submit_extent at fs/ext4/inode.c:2468
> > >   (inlined by) ext4_writepages at fs/ext4/inode.c:2772
> > >   do_writepages+0x5e/0x130
> > >   __writeback_single_inode+0xeb/0xb20
> > >   writeback_sb_inodes+0x429/0x900
> > >   __writeback_inodes_wb+0xc4/0x150
> > >   wb_writeback+0x4bd/0x870
> > >   wb_workfn+0x6b4/0x960
> > >   process_one_work+0x54c/0xbe0
> > >   worker_thread+0x80/0x650
> > >   kthread+0x1e0/0x200
> > >   ret_from_fork+0x27/0x50
> > >
> > >  Reported by Kernel Concurrency Sanitizer on:
> > >  CPU: 37 PID: 24872 Comm: kworker/u261:2 Tainted: G        W  O L 5.5.0-next-20200204+ #5
> > >  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> > >  Workqueue: writeback wb_workfn (flush-7:0)
> > >
> > > Since only the read is operating as lockless (outside of the
> > > "i_data_sem"), load tearing could introduce a logic bug. Fix it by
> > > adding READ_ONCE() for the read and WRITE_ONCE() for the write.
> > >
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > >
> > > v2: also add WRITE_ONCE() which is recommended even for fixing load tearing.
> >
> > Just a note: I keep seeing 'load tearing' mentioned as the only reason:
> >
> >   - The WRITE_ONCE avoids store-tearing (and other optimizations).
> >
> >   - We're not only interested in avoiding load/store tearing. There
> > are plenty other compiler optimizations that can break concurrent
> > code: https://lwn.net/Articles/793253/
>
> I also realized that from that article, store tearing is strictly from multiple
> concurrent writers. However, in the sense of without the WRITE_ONCE() here,
> compilers could still have 2 store instructions, so
>
> CPU0:   CPU1:
>         store #1
> read
>         store #2
>
> which was not mentioned in that article. I called it also load tearing, but
> maybe you will call that store tearing. Do I understand correctly?

The effect is the same, so yes. If you have the writer side split the
write, but have a concurrent load, the observed value will appear
"teared". Similar if the reader side splits the reads (the more
obvious case).

> >
> > Thanks,
> > -- Marco
> >
> >
> > >  fs/ext4/ext4.h  | 2 +-
> > >  fs/ext4/inode.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 9a2ee2428ecc..8329ccc82fa9 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -3029,7 +3029,7 @@ static inline void ext4_update_i_disksize(struct inode *inode, loff_t newsize)
> > >                      !inode_is_locked(inode));
> > >         down_write(&EXT4_I(inode)->i_data_sem);
> > >         if (newsize > EXT4_I(inode)->i_disksize)
> > > -               EXT4_I(inode)->i_disksize = newsize;
> > > +               WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize);
> > >         up_write(&EXT4_I(inode)->i_data_sem);
> > >  }
> > >
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 3313168b680f..6f9862bf63f1 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -2465,7 +2465,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
> > >          * truncate are avoided by checking i_size under i_data_sem.
> > >          */
> > >         disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
> > > -       if (disksize > EXT4_I(inode)->i_disksize) {
> > > +       if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
> > >                 int err2;
> > >                 loff_t i_size;
> > >
> > > --
> > > 1.8.3.1
> > >
