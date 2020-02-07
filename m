Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4776155AAA
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 16:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGPZU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Feb 2020 10:25:20 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:32938 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGPZU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Feb 2020 10:25:20 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so1181665qvn.0
        for <linux-ext4@vger.kernel.org>; Fri, 07 Feb 2020 07:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MSgIhLT9MS3E/985TuYKmwiwO+TZQ03cLLaFjvL/Z7U=;
        b=IUYmddKhYx0BQ5iFOb6zxHRgzGKJ7udijtTNO0hLE65pPoMxVYugOW3q6quSQKH7AF
         Ut6A5oiaxZ+CfPxKUxpxfflGd4WgkaF2+cYtzFN2fhqi6WkYstEIcz+qu2IGuhFxRevu
         17cwrq3CuG4L+CN5UwBEPkDmqQq+kfm5ZUjXwEA98mmc/Ui/M5xAuHumbLi7/GODdLE/
         RykIOeH4VutXQC7vMXcR3Cr+X9MnfzQ/pOwV2W69DLFllaIlUbNLy5qLUwq4+OCH8Ee0
         7jh3W/dS2CPJC9gg76UNTnFi4ynFDPdtehxIWSE1eXX/f1OEownfNKV336GVmFFcLM5F
         B03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MSgIhLT9MS3E/985TuYKmwiwO+TZQ03cLLaFjvL/Z7U=;
        b=Kli3LXtJgeA85kR3Kr6DvyO7uM6W0lrHO4EikgAiIlN7EpOsJfKzu9dcy/VafsZ+cb
         Au241Cu2aoUuUXjxBS35M8iSn/c3h3s9/Ky2WdgneMYpitFlj5GZAQ5DsldDIZIfbROC
         ZouV8TccQ1X6ej81AEvYB/gPb/G5eKbfDGIymeAvDjIkxsuYBZFQWyP+0V1UAEQ1cYw8
         2LJIlp2U90ei/TWOPsJXiLP0ML1C/IutMxyvVF2TubFkJWi27Hx8H6S0jTEDJ5MsZIV0
         vHu3gjUJ+ZrJXzdJp53tXz8KL/MC7cEAOyLbJJm96e0at/Nv5rB5A4dVnJCDRuiVjB3L
         EKAQ==
X-Gm-Message-State: APjAAAXZxHHfoJJKb3GEBTKZbnJ3/cpKB8Je1lOZYEL5+fj4TPpsOURz
        GG0ay6EBpIWosVmcXTlw+sME0g==
X-Google-Smtp-Source: APXvYqxFkZh3ph0+MsylYpZQNcAL/nm9I9QhXBiDskX6+/sTWSwKUX6qo7XMUWzarf2yRCFeX/MhLA==
X-Received: by 2002:a0c:cdcb:: with SMTP id a11mr7109886qvn.244.1581089119238;
        Fri, 07 Feb 2020 07:25:19 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a145sm1424090qkg.128.2020.02.07.07.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 07:25:18 -0800 (PST)
Message-ID: <1581089117.7365.18.camel@lca.pw>
Subject: Re: [PATCH v2] ext4: fix a data race in EXT4_I(inode)->i_disksize
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Feb 2020 10:25:17 -0500
In-Reply-To: <CANpmjNNqNzfMbFPGkSQgC7Q7yti30K0xcZmUsG9EtVdXsppjnw@mail.gmail.com>
References: <1581085751-31793-1-git-send-email-cai@lca.pw>
         <CANpmjNNqNzfMbFPGkSQgC7Q7yti30K0xcZmUsG9EtVdXsppjnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 2020-02-07 at 16:12 +0100, Marco Elver wrote:
> On Fri, 7 Feb 2020 at 15:29, Qian Cai <cai@lca.pw> wrote:
> > 
> > EXT4_I(inode)->i_disksize could be accessed concurrently as noticed by
> > KCSAN,
> > 
> >  BUG: KCSAN: data-race in ext4_write_end [ext4] / ext4_writepages [ext4]
> > 
> >  write to 0xffff91c6713b00f8 of 8 bytes by task 49268 on cpu 127:
> >   ext4_write_end+0x4e3/0x750 [ext4]
> >   ext4_update_i_disksize at fs/ext4/ext4.h:3032
> >   (inlined by) ext4_update_inode_size at fs/ext4/ext4.h:3046
> >   (inlined by) ext4_write_end at fs/ext4/inode.c:1287
> >   generic_perform_write+0x208/0x2a0
> >   ext4_buffered_write_iter+0x11f/0x210 [ext4]
> >   ext4_file_write_iter+0xce/0x9e0 [ext4]
> >   new_sync_write+0x29c/0x3b0
> >   __vfs_write+0x92/0xa0
> >   vfs_write+0x103/0x260
> >   ksys_write+0x9d/0x130
> >   __x64_sys_write+0x4c/0x60
> >   do_syscall_64+0x91/0xb47
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> >  read to 0xffff91c6713b00f8 of 8 bytes by task 24872 on cpu 37:
> >   ext4_writepages+0x10ac/0x1d00 [ext4]
> >   mpage_map_and_submit_extent at fs/ext4/inode.c:2468
> >   (inlined by) ext4_writepages at fs/ext4/inode.c:2772
> >   do_writepages+0x5e/0x130
> >   __writeback_single_inode+0xeb/0xb20
> >   writeback_sb_inodes+0x429/0x900
> >   __writeback_inodes_wb+0xc4/0x150
> >   wb_writeback+0x4bd/0x870
> >   wb_workfn+0x6b4/0x960
> >   process_one_work+0x54c/0xbe0
> >   worker_thread+0x80/0x650
> >   kthread+0x1e0/0x200
> >   ret_from_fork+0x27/0x50
> > 
> >  Reported by Kernel Concurrency Sanitizer on:
> >  CPU: 37 PID: 24872 Comm: kworker/u261:2 Tainted: G        W  O L 5.5.0-next-20200204+ #5
> >  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> >  Workqueue: writeback wb_workfn (flush-7:0)
> > 
> > Since only the read is operating as lockless (outside of the
> > "i_data_sem"), load tearing could introduce a logic bug. Fix it by
> > adding READ_ONCE() for the read and WRITE_ONCE() for the write.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> > 
> > v2: also add WRITE_ONCE() which is recommended even for fixing load tearing.
> 
> Just a note: I keep seeing 'load tearing' mentioned as the only reason:
> 
>   - The WRITE_ONCE avoids store-tearing (and other optimizations).

In general, yes, but in this case, store tearing can't happen because those
concurrent writers are protected by "i_data_sem", i.e., 

down_write(&EXT4_I(inode)->i_data_sem);

> 
>   - We're not only interested in avoiding load/store tearing. There
> are plenty other compiler optimizations that can break concurrent
> code: https://lwn.net/Articles/793253/
> 
> Thanks,
> -- Marco
> 
> 
> >  fs/ext4/ext4.h  | 2 +-
> >  fs/ext4/inode.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 9a2ee2428ecc..8329ccc82fa9 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -3029,7 +3029,7 @@ static inline void ext4_update_i_disksize(struct inode *inode, loff_t newsize)
> >                      !inode_is_locked(inode));
> >         down_write(&EXT4_I(inode)->i_data_sem);
> >         if (newsize > EXT4_I(inode)->i_disksize)
> > -               EXT4_I(inode)->i_disksize = newsize;
> > +               WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize);
> >         up_write(&EXT4_I(inode)->i_data_sem);
> >  }
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 3313168b680f..6f9862bf63f1 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -2465,7 +2465,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
> >          * truncate are avoided by checking i_size under i_data_sem.
> >          */
> >         disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
> > -       if (disksize > EXT4_I(inode)->i_disksize) {
> > +       if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
> >                 int err2;
> >                 loff_t i_size;
> > 
> > --
> > 1.8.3.1
> > 
