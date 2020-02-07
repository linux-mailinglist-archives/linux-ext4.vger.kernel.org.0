Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729E4155ADD
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 16:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBGPix (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Feb 2020 10:38:53 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42786 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgBGPix (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Feb 2020 10:38:53 -0500
Received: by mail-qv1-f66.google.com with SMTP id dc14so1184879qvb.9
        for <linux-ext4@vger.kernel.org>; Fri, 07 Feb 2020 07:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NPvBxYGpUTsxl7iWOZAXwkDlpzSA2ZRxjWHhDN+lvr4=;
        b=J/tivbI99R2ONXMd9Yxr5Gj2f2qOfin0VZU1rIiDAkVRV0O/GkwhfLNSFcPixeUTHH
         PxfIsCQXYrCdFeVXTGX2ers4wpHNMprSvHneabq5tIvRKoXR7StFwiaiVTr2i5q2yJo3
         of8KyFfZzMClVmXsj3a3OjE6ObaIrevxQameAxIspRWLdaAYoibtECCN1n+B/M45j+YJ
         q8mR7EE2Li56JlGjFGf5TsC0RGu/0hSgSifUpNFnqcsZFMtU6ayMoAGONrlk9NUEqI+1
         sRckWIuOqdywYgsI1AkPOBPp5W0Z5n/E+zvJzRFKZlwmUHby5r3zk5OejH9al7ANaidZ
         ia+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NPvBxYGpUTsxl7iWOZAXwkDlpzSA2ZRxjWHhDN+lvr4=;
        b=QtgZDswukRSkCAcfh5vjWsKcinXtUnvUiEdSWPdCYvAOAIT9KYDrEf2y4Lnf87+A5R
         E0Pd0yiXHWksM/vw33nk6Dy7kWJIRvoNb/PK6HZiJ+ANUFj+ifMcw3qjbaSn9V3bvCQj
         fPYlDaAvCI+fNWxviebhFrK4wqL4Owa0O8WPzch+0jk4I7fJmbup6rRDkU7pjOGoIQj8
         QQD4Adu0Cv8d4/Muxhivjej7kBuLQ2ChjTt2DFJlZARbjcTU3zZL8JgdZgCLCq2Dn+iB
         q9W37FrxlJL3FeDLcB3TRcQgqBFTBowNyCOfvOgRCmOyyY+1r5j1EUqj6erfP1VEr5x2
         d9YQ==
X-Gm-Message-State: APjAAAWGO6legOZJ3pVm1UJ/k5f8dfd+QaP9Hrb5nHQywGVcyVHlGX9+
        b8QV1bS3bMWIGrQ/8oVhf3xFVi5igHN3sg==
X-Google-Smtp-Source: APXvYqzdedWDvOlTA/40j3OkXkuVs413jLaIqL8ncKzmGTz7cskcYaPh5Klf9IGhvuouVDjK4ZOLEQ==
X-Received: by 2002:a05:6214:176e:: with SMTP id et14mr7036366qvb.133.1581089931799;
        Fri, 07 Feb 2020 07:38:51 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v78sm1457459qkb.48.2020.02.07.07.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 07:38:51 -0800 (PST)
Message-ID: <1581089930.7365.20.camel@lca.pw>
Subject: Re: [PATCH v2] ext4: fix a data race in EXT4_I(inode)->i_disksize
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Feb 2020 10:38:50 -0500
In-Reply-To: <CANpmjNNqNzfMbFPGkSQgC7Q7yti30K0xcZmUsG9EtVdXsppjnw@mail.gmail.com>
References: <1581085751-31793-1-git-send-email-cai@lca.pw>
         <CANpmjNNqNzfMbFPGkSQgC7Q7yti30K0xcZmUsG9EtVdXsppjnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
> 
>   - We're not only interested in avoiding load/store tearing. There
> are plenty other compiler optimizations that can break concurrent
> code: https://lwn.net/Articles/793253/

I also realized that from that article, store tearing is strictly from multiple
concurrent writers. However, in the sense of without the WRITE_ONCE() here,
compilers could still have 2 store instructions, so

CPU0:	CPU1:
	store #1
read
	store #2

which was not mentioned in that article. I called it also load tearing, but
maybe you will call that store tearing. Do I understand correctly?

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
