Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B093226A5E7
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 15:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIONHg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 09:07:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:35540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgIONHN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Sep 2020 09:07:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EFBD2AC19;
        Tue, 15 Sep 2020 13:07:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 412451E12EF; Tue, 15 Sep 2020 15:07:11 +0200 (CEST)
Date:   Tue, 15 Sep 2020 15:07:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.com
Subject: Re: [PATCH] ext4: clear buffer verified flag if read meta block from
 disk
Message-ID: <20200915130711.GP4863@quack2.suse.cz>
References: <20200914112420.1906407-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914112420.1906407-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 14-09-20 19:24:20, zhangyi (F) wrote:
> The metadata buffer is no longer trusted after we read it from disk
> again because it is not uptodate for some reasons (e.g. failed to write
> back). Otherwise we may get below memory corruption problem in
> ext4_ext_split()->memset() if we read stale data from the newly
> allocated extent block on disk which has been failed to async write
> out but miss verify again since the verified bit has already been set
> on the buffer.
> 
> [   29.774674] BUG: unable to handle kernel paging request at ffff88841949d000
> ...
> [   29.783317] Oops: 0002 [#2] SMP
> [   29.784219] R10: 00000000000f4240 R11: 0000000000002e28 R12: ffff88842fa1c800
> [   29.784627] CPU: 1 PID: 126 Comm: kworker/u4:3 Tainted: G      D W
> [   29.785546] R13: ffffffff9cddcc20 R14: ffffffff9cddd420 R15: ffff88842fa1c2f8
> [   29.786679] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),BIOS ?-20190727_0738364
> [   29.787588] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
> [   29.789288] Workqueue: writeback wb_workfn
> [   29.790319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.790321]  (flush-8:0)
> [   29.790844] CR2: 0000000000000008 CR3: 00000004234f2000 CR4: 00000000000006f0
> [   29.791924] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   29.792839] RIP: 0010:__memset+0x24/0x30
> [   29.793739] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   29.794256] Code: 90 90 90 90 90 90 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 033
> [   29.795161] Kernel panic - not syncing: Fatal exception in interrupt
> ...
> [   29.808149] Call Trace:
> [   29.808475]  ext4_ext_insert_extent+0x102e/0x1be0
> [   29.809085]  ext4_ext_map_blocks+0xa89/0x1bb0
> [   29.809652]  ext4_map_blocks+0x290/0x8a0
> [   29.809085]  ext4_ext_map_blocks+0xa89/0x1bb0
> [   29.809652]  ext4_map_blocks+0x290/0x8a0
> [   29.810161]  ext4_writepages+0xc85/0x17c0
> ...
> 
> Fix this by clear buffer's verified bit if we read it from disk again.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Good spotting! When looking at the patch I was just wondering that it's
rather easy to miss clearing of buffer_verified() bit in some place where
we read metadata block from disk. So I was wondering that maybe it would be
less error prone to have:

ext4_buffer_verified() -> buffer_verified() && !buffer_write_io_error()
ext4_set_buffer_verified() -> clear_buffer_write_io_error(); set_buffer_verified();

And this should make sure we recheck the buffer contents as needed. What do
people think?

								Honza

> ---
>  fs/ext4/balloc.c  | 1 +
>  fs/ext4/extents.c | 1 +
>  fs/ext4/ialloc.c  | 1 +
>  fs/ext4/inode.c   | 5 ++++-
>  fs/ext4/super.c   | 1 +
>  5 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 48c3df47748d..8e7e9715cde9 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -494,6 +494,7 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
>  	 * submit the buffer_head for reading
>  	 */
>  	set_buffer_new(bh);
> +	clear_buffer_verified(bh);
>  	trace_ext4_read_block_bitmap_load(sb, block_group, ignore_locked);
>  	bh->b_end_io = ext4_end_bitmap_read;
>  	get_bh(bh);
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a0481582187a..0a5205edc00a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -501,6 +501,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
>  
>  	if (!bh_uptodate_or_lock(bh)) {
>  		trace_ext4_ext_load_extent(inode, pblk, _RET_IP_);
> +		clear_buffer_verified(bh);
>  		err = bh_submit_read(bh);
>  		if (err < 0)
>  			goto errout;
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index df25d38d6539..20cda952c621 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -188,6 +188,7 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
>  	/*
>  	 * submit the buffer_head for reading
>  	 */
> +	clear_buffer_verified(bh);
>  	trace_ext4_load_inode_bitmap(sb, block_group);
>  	bh->b_end_io = ext4_end_bitmap_read;
>  	get_bh(bh);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf596467c234..7eaa55651d29 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -884,6 +884,7 @@ struct buffer_head *ext4_bread(handle_t *handle, struct inode *inode,
>  		return bh;
>  	if (!bh || ext4_buffer_uptodate(bh))
>  		return bh;
> +	clear_buffer_verified(bh);
>  	ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1, &bh);
>  	wait_on_buffer(bh);
>  	if (buffer_uptodate(bh))
> @@ -909,9 +910,11 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
>  
>  	for (i = 0; i < bh_count; i++)
>  		/* Note that NULL bhs[i] is valid because of holes. */
> -		if (bhs[i] && !ext4_buffer_uptodate(bhs[i]))
> +		if (bhs[i] && !ext4_buffer_uptodate(bhs[i])) {
> +			clear_buffer_verified(bhs[i]);
>  			ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1,
>  				    &bhs[i]);
> +		}
>  
>  	if (!wait)
>  		return 0;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ea425b49b345..9e760bf9e8b1 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -156,6 +156,7 @@ ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
>  		return ERR_PTR(-ENOMEM);
>  	if (ext4_buffer_uptodate(bh))
>  		return bh;
> +	clear_buffer_verified(bh);
>  	ll_rw_block(REQ_OP_READ, REQ_META | op_flags, 1, &bh);
>  	wait_on_buffer(bh);
>  	if (buffer_uptodate(bh))
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
