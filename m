Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14D22F5100
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jan 2021 18:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbhAMRU0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 12:20:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:34688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbhAMRU0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 13 Jan 2021 12:20:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B0DEACAC;
        Wed, 13 Jan 2021 17:19:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DA9031E083D; Wed, 13 Jan 2021 18:19:43 +0100 (CET)
Date:   Wed, 13 Jan 2021 18:19:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        joseph qi <joseph.qi@linux.alibaba.com>
Subject: Re: code questions about ext4_inode_datasync_dirty()
Message-ID: <20210113171943.GB26686@quack2.suse.cz>
References: <c95ac3d6-5e9c-b706-28f7-3bbe4b75964b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95ac3d6-5e9c-b706-28f7-3bbe4b75964b@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Tue 12-01-21 19:45:06, Xiaoguang Wang wrote:
> I use io_uring to evaluate ext4 randread performance(direct io), observed
> obvious overhead in jbd2_transaction_committed():
> Samples: 124K of event 'cycles:ppp', Event count (approx.): 80630088951
> Overhead  Command          Shared Object      Symbol
>    7.02%  io_uring-sq-per  [kernel.kallsyms]  [k] jbd2_transaction_committed

Hum, that's quite a bit. Likely due to cacheline contention on
j_state_lock. Thanks for reporting this!

> The codes:
> 	/*
> 	 * Writes that span EOF might trigger an I/O size update on completion,
> 	 * so consider them to be dirty for the purpose of O_DSYNC, even if
> 	 * there is no other metadata changes being made or are pending.
> 	 */
> 	iomap->flags = 0;
> 	if (ext4_inode_datasync_dirty(inode) ||
> 	    offset + length > i_size_read(inode))
> 		iomap->flags |= IOMAP_F_DIRTY;
> 
> ext4_inode_datasync_dirty() calls jbd2_transaction_committed(). Sorry, I
> don't spend much time to learn iomap codes yet, just ask a quick question
> here. Do we need to call ext4_inode_datasync_dirty() for a read
> operation?

So strictly speaking we don't need to know the value of IOMAP_F_DIRTY in
that path (or any read path for that matter) but I'm somewhat reluctant to
optimize out setting of this flag because later some user might start to
depend on it being set correctly.

> If we must call ext4_inode_datasync_dirty() for a read operation, can we improve
> jbd2_transaction_committed() a bit, for example, have a quick check between
> inode->i_datasync_tid and j_commit_sequence, if inode->i_datasync_tid is less than
> or equal to j_commit_sequence, we also don't call jbd2_transaction_committed()?

Well, the modification would belong directly to
jbd2_transaction_committed(). Using j_commit_sequence is somewhat awkward
since TIDs can wrap around and so very old TIDs can suddently start to give
false positives leading to a strange results (this was one of motivations
to switch jbd2_transaction_committed() to a comparison for equality). But
it could certainly be done.

But j_state_lock is a scalability bottleneck in other cases as well. So
what I rather have in mind is that we could change transactions to be RCU
freed and then a majority of places where we use

  read_lock(&journal->j_state_lock);

can be switched to using plain RCU which should significantly reduce the
contention on the lock.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
