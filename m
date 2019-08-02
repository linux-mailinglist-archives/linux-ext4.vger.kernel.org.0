Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169287F59F
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 13:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392191AbfHBLAR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 07:00:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:36760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392118AbfHBLAR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Aug 2019 07:00:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C355B61A;
        Fri,  2 Aug 2019 11:00:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A05EC1E3F4D; Fri,  2 Aug 2019 13:00:14 +0200 (CEST)
Date:   Fri, 2 Aug 2019 13:00:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
Subject: Re: [PATCH] jbd2: flush_descriptor(): Do not decrease buffer head's
 ref count
Message-ID: <20190802110014.GA9339@quack2.suse.cz>
References: <20190725131409.32172-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725131409.32172-1-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 25-07-19 18:44:09, Chandan Rajendra wrote:
> When executing generic/388 on a ppc64le machine, we notice the following
> call trace,
> 
> VFS: brelse: Trying to free free buffer
> WARNING: CPU: 0 PID: 6637 at /root/repos/linux/fs/buffer.c:1195 __brelse+0x84/0xc0
> 
> Call Trace:
>  __brelse+0x80/0xc0 (unreliable)
>  invalidate_bh_lru+0x78/0xc0
>  on_each_cpu_mask+0xa8/0x130
>  on_each_cpu_cond_mask+0x130/0x170
>  invalidate_bh_lrus+0x44/0x60
>  invalidate_bdev+0x38/0x70
>  ext4_put_super+0x294/0x560
>  generic_shutdown_super+0xb0/0x170
>  kill_block_super+0x38/0xb0
>  deactivate_locked_super+0xa4/0xf0
>  cleanup_mnt+0x164/0x1d0
>  task_work_run+0x110/0x160
>  do_notify_resume+0x414/0x460
>  ret_from_except_lite+0x70/0x74
> 
> The above occurs due to the following sequence of events,
> 1. Get a buffer head for holding a descriptor buffer for a Revoke
>    record. This causes buffer_head->b_count to have a value of 2,
>    - The first ref count corresponds to JBD code holding a reference to the
>      buffer head.
>    - Another ref count correponds to adding the buffer head to the
>      per-cpu LRU list.
>    The buffer head is also added to the list of log_bufs tracking the
>    buffer heads that need to be written to the on-disk journal.
> 2. When writing the revoke record to the disk, if journal is aborted,
>    flush_descriptor() gives up one ref count by invoking put_bh().
> 3. jbd2_journal_commit_transaction() then loops across the buffer heads
>    in the log_bufs list. While doing so, it decrements the buffer head's ref
>    count to 0 by invoking __brelse().
> 4. On unmount, invalidate_bdev() invokes __brelse() via
>    invalidate_bh_lru() to remove the buffer head from the per-cpu LRU
>    list. Here __brelse() prints the call trace shown above since
>    buffer_head->b_count already has a value of 0.
> 
> Hence this commit removes the call to put_bh() inside
> flush_descriptor().
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>

Thanks for the patch! It patch looks good, just the analysis above doesn't
really explain why it is correct to remove the put_bh() call in
flush_descriptor(). So I'd just replace the above points with:

The warning happens because flush_descriptor() drops bh reference it does
not own. The bh reference acquired by jbd2_journal_get_descriptor_buffer()
is owned by the log_bufs list and gets released when this list is
processed. The reference for doing IO is only acquired in
write_dirty_buffer() later in flush_descriptor().

With this updated feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/revoke.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index 69b9bc329964..f08073d7bbf5 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -638,10 +638,8 @@ static void flush_descriptor(journal_t *journal,
>  {
>  	jbd2_journal_revoke_header_t *header;
>  
> -	if (is_journal_aborted(journal)) {
> -		put_bh(descriptor);
> +	if (is_journal_aborted(journal))
>  		return;
> -	}
>  
>  	header = (jbd2_journal_revoke_header_t *)descriptor->b_data;
>  	header->r_count = cpu_to_be32(offset);
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
