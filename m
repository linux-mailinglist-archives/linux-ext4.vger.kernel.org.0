Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7743AAEA7
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 10:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFQIY5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Jun 2021 04:24:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47356 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhFQIY4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Jun 2021 04:24:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1432C218E1;
        Thu, 17 Jun 2021 08:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623918168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o4qKjHRqnBG/LCGn25tvGCpFgET+NFHp0ru3HLS1pp0=;
        b=r+75eUvIk2kaYkhqfjWRW7e78YZN1ZWwvSh0BSd8xYQCs0/YW/lXi/GxwsbQ5h2mcY7N92
        AUI/Psiy/udlIA4s5PB3jq7CnxmVbdVH/9wwfDPi4ZPQq/cNQSWx5QY8rDaIsZ/pYQXhce
        zyNva6ImvsupYXL9osD1No4DyPmIPXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623918168;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o4qKjHRqnBG/LCGn25tvGCpFgET+NFHp0ru3HLS1pp0=;
        b=jSOQKmQuGuu5WSvwJymJQuCCIaJdoZswVgEMpNz5AozOqiZ9gcbPUDN1Afy9OOYMqmLp/9
        Jgmb0l1+e9p8+jDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id BDB5EA3BB7;
        Thu, 17 Jun 2021 08:22:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 849CB1F2C64; Thu, 17 Jun 2021 10:22:47 +0200 (CEST)
Date:   Thu, 17 Jun 2021 10:22:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] ext4: Speedup ext4 orphan inode handling
Message-ID: <20210617082247.GB32587@quack2.suse.cz>
References: <20210616105655.5129-1-jack@suse.cz>
 <20210616105655.5129-4-jack@suse.cz>
 <A8AFE573-798C-4E07-AD66-A369B3B1CC51@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A8AFE573-798C-4E07-AD66-A369B3B1CC51@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 17-06-21 01:44:13, Andreas Dilger wrote:
> On Jun 16, 2021, at 4:56 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > Ext4 orphan inode handling is a bottleneck for workloads which heavily
> > truncate / unlink small files since it contends on the global
> > s_orphan_mutex lock (and generally it's difficult to improve scalability
> > of the ondisk linked list of orphaned inodes).
> > 
> > This patch implements new way of handling orphan inodes. Instead of
> > linking orphaned inode into a linked list, we store it's inode number in
> > a new special file which we call "orphan file". Currently we still
> > protect the orphan file with a spinlock for simplicity but even in this
> > setting we can substantially reduce the length of the critical section
> > and thus speedup some workloads.
> 
> Is it a single spinlock for the whole file?  Did you consider using
> a per-page lock or grouplock?  With a page in the orphan file for each
> CPU core, it would basically be lockless.

See the next patch :) I've made this one simple in terms of locking:

a) to be able to evaluate how global spinlock performs
b) to make code simpler for review

> > +static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
> > +{
> > 	spin_lock(&oi->of_lock);
> > +	for (i = 0; i < oi->of_blocks && !oi->of_binfo[i].ob_free_entries; i++);
> > +	if (i == oi->of_blocks) {
> > +		spin_unlock(&oi->of_lock);
> > +		/*
> > +		 * For now we don't grow or shrink orphan file. We just use
> > +		 * whatever was allocated at mke2fs time. The additional
> > +		 * credits we would have to reserve for each orphan inode
> > +		 * operation just don't seem worth it.
> > +		 */
> > +		return -ENOSPC;
> > +	}
> > +	oi->of_binfo[i].ob_free_entries--;
> > +	spin_unlock(&oi->of_lock);
> 
> How do we know how large to make the orphan file at mkfs time?  What if it
> becomes full during use?  It seems like reserving a fixed number of blocks
> will invariably be incorrect for the actual workload on the filesystem.

If orphan file gets full (too many orphaned inodes at this moment), we will
just fallback to using the good old orphan list. So only performance will
suffer.

In terms of number of blocks, for reasonably large filesystems we reserve
512 4k blocks for orphan file so that allows for 523776 orphaned inodes.
Sure it's possible to exhaust it but frankly I don't find it likely so I'm
not sure dynamic sizing is worth the hassle.

> > @@ -49,6 +95,16 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
> > 	ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> > 		  S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
> > 
> > +	if (sbi->s_orphan_info.of_blocks) {
> > +		err = ext4_orphan_file_add(handle, inode);
> > +		/*
> > +		 * Fallback to normal orphan list of orphan file is
> > +		 * out of space
> > +		 */
> > +		if (err != -ENOSPC)
> > +			return err;
> > +	}
> 
> This could schedule a task on a workqueue to allocate a few more blocks?
> That could easily reserve more credits for this action, without making
> the common case more expensive.  Even if it isn't used with the current
> mount, it would be available for the next mount (which presumably would
> also need additional blocks).
> 
> Whether it is worth the complexity to make this fully dynamic, at least
> it would auto-tune for the workload placed on this filesystem, and would
> not initially be worse than the old single-linked list.

Adding more blocks would not be that hard as you say but if we are growing
a file there may be need to make it shorter as well (as e.g. shortlived
peak in number of orphaned inodes could have accumulated bazilion blocks
for orphan file) and that will be a bit more tricky. It can be done but I
don't think it's worth the complexity...

Thanks for the review!
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
