Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9552CBEC
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 08:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiESG3g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiESG3g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 02:29:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC4811152
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 23:29:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so7867106pjp.3
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 23:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/5P075IKDsXmEY19T/BXSOQJ7xMckKDtIX+Hsya6NnQ=;
        b=k4ldAnuhGW4CpTZdjDLR5eTWn7sVgcPAYkAsjy5m0SuGcC2HtpUlPqRlM8jy5RWb23
         vjMmZuOmeSf9F2Xri8RYrjtxBYGbiFwp1vGXnjNLkZPIhNhvAWW3XfKGQdU+GyaTwRFv
         qJbrKnipMeHCxnNd4hotJiJ7zreW76XYmNrnMAcKhU8k7GgTtdx9mhqfQ0qeyoQxaUBk
         dnJCIUTKAnD2MxJF62/M/1tHVI9WgmLyTgMozbBdRwi58M8g0YPzfTYqPskR04q5LD7X
         GMaxz4p9gQftBIsWVSYr/XDwR2R7BlUrimqorgqX//oRA2A7OXFG3FIDMWcCfyumQhcx
         QzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/5P075IKDsXmEY19T/BXSOQJ7xMckKDtIX+Hsya6NnQ=;
        b=pKDyLpOELWSBtLKheE4t6EGyLoQm7x77B5JHZozKUw0kzdrtDz/3nTfAI2cn0cRJ2H
         kWb1mWhwwDRbEMlJEUVEQe7vB5WmA5rHZUM4xJHmFWUpnzhcUjuOWnjpHfTu7LQ+tu7w
         3/e+wrh0efefFN9I7Sjc6EhHQNaR9bjV539u+mpufg+oVdo/ajJOKB1BvVHMpVbJpNcS
         yyFPxlHyJd+T1K3qYiI6Z3NIryIQU+OXPugCZBE8kdfH0DNKJVyp6jXnHbb1NMhmD7Ce
         R8eZshv6fKBgwLBnUWKeWm7QTYrRm5iZ5I8lDnvvqg1otSygGHT7H53BfFffr0Fe91Vx
         g47Q==
X-Gm-Message-State: AOAM532gfDad0foFMngxJD0621J94A4EwLrCe6jH5UZTgqQBtpVFF3zs
        QPoGbnxufR7GhgKa5oMbwXk=
X-Google-Smtp-Source: ABdhPJwO+uPoH2x077+bdAVHNgVfKTadzEZuAQ9BZ/Oi+YzosSVUmXcHkuWeKLkxX9CMnlGHyBgNsQ==
X-Received: by 2002:a17:90a:f3c2:b0:1df:8d56:d8ce with SMTP id ha2-20020a17090af3c200b001df8d56d8cemr3460433pjb.86.1652941774392;
        Wed, 18 May 2022 23:29:34 -0700 (PDT)
Received: from localhost ([2406:7400:63:532d:c4bb:97f7:b03d:2c53])
        by smtp.gmail.com with ESMTPSA id n9-20020a629709000000b005180df18990sm3120987pfe.168.2022.05.18.23.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 23:29:33 -0700 (PDT)
Date:   Thu, 19 May 2022 11:59:29 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix warning when submitting superblock in
 ext4_commit_super()
Message-ID: <20220519062929.i52y2mwonnrbvr64@riteshh-domain>
References: <20220518141020.2432652-1-yi.zhang@huawei.com>
 <20220518170617.vooz4ycfe73xsszx@riteshh-domain>
 <94e7b5f7-54c8-d04a-3a3a-31768b630862@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e7b5f7-54c8-d04a-3a3a-31768b630862@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/19 11:13AM, Zhang Yi wrote:
> On 2022/5/19 1:06, Ritesh Harjani wrote:
> > On 22/05/18 10:10PM, Zhang Yi wrote:
> >> We have already check the io_error and uptodate flag before submitting
> >> the superblock buffer, and re-set the uptodate flag if it has been
> >> failed to write out. But it was lockless and could be raced by another
> >> ext4_commit_super(), and finally trigger '!uptodate' WARNING when
> >> marking buffer dirty. Fix it by submit buffer directly.
> >
> > I agree that there could be a race with multiple processes trying to call
> > ext4_commit_super(). Do you have a easy reproducer for this issue?
> >
>
> Sorry, I don't have a easy reproducer, but we can always reproduce it through
> inject delay and add filters into the ext4_commit_super().

Sure, thanks for sharing.

>
> 1. Apply below diff.
>  static int ext4_commit_super(struct super_block *sb)
>  {
>  	struct buffer_head *sbh = EXT4_SB(sb)->s_sbh;
> @@ -6026,9 +6027,22 @@ static int ext4_commit_super(struct super_block *sb)
>  		set_buffer_uptodate(sbh);
>  	}
>  	BUFFER_TRACE(sbh, "marking dirty");
> +	if (!strcmp(current->comm, "touch"))
> +		pr_err("touch (%d) enter\n", current->pid);
> +	if (!strcmp(current->comm, "mkdir")) {
> +		pr_err("mkdir(%d): wait touch sync\n", current->pid);
> +		msleep(1000);
> +		pr_err("mkdir(%d): wait touch sync %d\n", current->pid, buffer_uptodate(sbh));
> +	}
>  	mark_buffer_dirty(sbh);
> +	if (!strcmp(current->comm, "mkdir"))
> +		pr_err("mkdir(%d): mark\n", current->pid);
>  	error = __sync_dirty_buffer(sbh,
>  		REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
> +	if (error) {
> +		pr_err("%s(%d) sync fail %d\n", current->comm, current->pid, buffer_uptodate(sbh));
> +		msleep(2000);
> +	}
>  	if (buffer_write_io_error(sbh)) {
>  		ext4_msg(sb, KERN_ERR, "I/O error while writing "
>  		       "superblock");
>
> 2. Run this script.
> #!/bin/bash
> echo running > /sys/block/sdb/device/state
> sleep 1
> umount /mnt
> mkfs.ext4 -F -E lazy_itable_init=0,lazy_journal_init=0 /dev/sdb
> mount /dev/sdb -o errors=remount-ro,stripe=2048,data_err=abort /mnt
> mkdir /mnt/dir_a
> mkdir -p /mnt/dir_b
>
> sync
> sync
>
> echo 3 > /proc/sys/vm/drop_caches
> echo offline > /sys/block/sdb/device/state
>
> sleep 1
> mkdir /mnt/dir_a/a &
> touch /mnt/dir_b/b
>
>
> [ 1586.472287] ------------[ cut here ]------------
> [ 1586.473834] WARNING: CPU: 14 PID: 1425 at fs/buffer.c:1081 mark_buffer_dirty+0x28f/0x330
> [ 1586.476519] Modules linked in:
> [ 1586.477567] CPU: 14 PID: 1425 Comm: mkdir Not tainted 5.18.0-rc7-dirty #745
> [ 1586.479854] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc4
> [ 1586.482709] RIP: 0010:mark_buffer_dirty+0x28f/0x330
> [ 1586.483400] Code: a8 00 00 00 48 83 05 8f dd 0d 03 01 48 83 e8 01 e9 df fe ff ff 48 83 05 fe e1 0d 033
> [ 1586.488136] RSP: 0018:ffffa8a6c0ef3b90 EFLAGS: 00010202
> [ 1586.490142] RAX: 0000000000116418 RBX: ffff93f5bd899000 RCX: 0000000000000000
> [ 1586.492571] RDX: 0000000000000000 RSI: ffffffff8bef9549 RDI: ffff93f5bd899000
> [ 1586.494988] RBP: ffff93f5beffd000 R08: 0000000000000000 R09: ffffa8a6c0ef39c0
> [ 1586.497380] R10: 0000000000000001 R11: 0000000000000001 R12: ffff93f5b3de0000
> [ 1586.499674] R13: 0000000000000000 R14: ffffffff8b849da0 R15: 0000000000000000
> [ 1586.501964] FS:  00007f561455c0c0(0000) GS:ffff93fc65980000(0000) knlGS:0000000000000000
> [ 1586.504493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1586.506303] CR2: 00007f5614706f80 CR3: 0000000105534000 CR4: 00000000000006e0
> [ 1586.508561] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1586.509652] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1586.510654] Call Trace:
> [ 1586.511560]  <TASK>
> [ 1586.512228]  ext4_commit_super+0xb1/0x2e0
> [ 1586.513362]  ext4_handle_error+0x287/0x2a0
> [ 1586.514508]  __ext4_error+0x138/0x240
> [ 1586.515527]  ? __might_sleep+0x56/0xb0
> [ 1586.516571]  ? __getblk_gfp+0x47/0x630
> [ 1586.517636]  ext4_journal_check_start+0xd1/0xf0
> [ 1586.518884]  __ext4_journal_start_sb+0x61/0x1f0
> [ 1586.520126]  __ext4_new_inode+0x12ee/0x2670
> [ 1586.521283]  ? ext4_lookup+0x297/0x340
> [ 1586.522322]  ext4_mkdir+0x1a5/0x4f0
> [ 1586.523298]  vfs_mkdir+0x7c/0x1b0
> [ 1586.523981]  do_mkdirat+0x9e/0x160
> [ 1586.524488]  __x64_sys_mkdir+0x41/0x60
> [ 1586.525054]  do_syscall_64+0x3b/0x90
> [ 1586.525590]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1586.526341] RIP: 0033:0x7f5614710ecb
>
> > Also do you think something like below should fix the problem too?
> > So if you lock the buffer from checking until marking the buffer dirty, that
> > should avoid the race too that you are reporting.
> > Thoughts?
> >
>
> Thanks for your suggestion. I've thought about this solution and yes it's simpler
> to fix the race, but I think we lock and unlock the sbh several times just for
> calling standard buffer write helpers is not so good. Opencode the submit
> procedure looks more clear to me.

I agree your solution was cleaner since it does not has a lot of lock/unlock.
My suggestion came in from looking at the history.
This lock was added here [1] and I think it somehow got removed in this patch[2]

[1]: https://lore.kernel.org/linux-ext4/1467285150-15977-2-git-send-email-pranjas@gmail.com/
[2]: https://lore.kernel.org/linux-ext4/20201216101844.22917-5-jack@suse.cz/

Rather then solutions, I had few queries :)
1. What are the implications of not using mark_buffer_dirty()/__sync_dirty_buffer()
2. In your solution one thing which I was not clear of, was whether we should
	call clear_buffer_dirty() before calling submit_bh(), in case if somehow(?)
	the state of the buffer was already marked dirty? Not sure how this can
	happen, but I see the logic in mark_buffer_dirty() which checks, if the
	buffer is already marked dirty, it simply returns. Then __sync_dirty_buffer()
	clears the buffer dirty state.

> Anyway, Your solution is also fine by me.

I think if we get some answers to above. It will give us more confidence on
whether should we open code submit_bh() logic or should we use
mark_buffer_dirty()/__sync_dirty_buffer() (with lock_buffer() to prevent the
warning which you reported).

-ritesh

>
> Thanks,
> Yi.
>
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 6900da973ce2..3447841fe654 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -6007,6 +6007,7 @@ static int ext4_commit_super(struct super_block *sb)
> >
> >         ext4_update_super(sb);
> >
> > +       lock_buffer(sbh);
> >         if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
> >                 /*
> >                  * Oh, dear.  A previous attempt to write the
> > @@ -6023,6 +6024,7 @@ static int ext4_commit_super(struct super_block *sb)
> >         }
> >         BUFFER_TRACE(sbh, "marking dirty");
> >         mark_buffer_dirty(sbh);
> > +       unlock_buffer(sbh);
> >         error = __sync_dirty_buffer(sbh,
> >                 REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
> >         if (buffer_write_io_error(sbh)) {
> > .
> >
