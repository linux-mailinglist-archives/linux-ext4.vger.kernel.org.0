Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AD766BE21
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jan 2023 13:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjAPMtd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Jan 2023 07:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAPMtc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Jan 2023 07:49:32 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF1314EA3;
        Mon, 16 Jan 2023 04:49:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d3so30215720plr.10;
        Mon, 16 Jan 2023 04:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44zs51iYjVjPaEr7KjXam/bis8RNnVGo7ZyjmlmrgOM=;
        b=p6JdB7W3FdUHN55Tn9TUB4CGmWgFziCdM5qEuTZatL1nkyrhaiDUvvW5UHaBmq4Rh4
         64mFbaTsi75AOumTcVU/SG5X2l8KsYJKPOd9Xq7ryZekGA6AerqHigjvL95N9k7bItw5
         3SoJqs5QThl8T0DL6T3MulphXmMTvv1eFwmHgznJjIlAIRdB6WNmHOmNUS/KwnKGPDTy
         6IM5X4rUk1rkq8lfSm5FVtHx55Up2IugQLaxeiuyDyN2taabV4S+gSlMX2R8RpQVxF0Y
         G5P/Z0Ej92jGG1oja6eMxaV7o+pAtp7uUkEwxSBAIYZCJu2vXNbzr0coXH0pQkLXKP0I
         eDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44zs51iYjVjPaEr7KjXam/bis8RNnVGo7ZyjmlmrgOM=;
        b=oP9Hz+aL6Nuzi4MFFG6F+OeW5IqATAUgFtycjQ77zHHJ9O4vVud49sQtGbbsk2Gvi7
         Wr2dHpec6HhiXQjOGhxTgSizun9McSKEdFINYEhNZsKIQ/7Om6zyzXNo2rGQHoeG9m2+
         76ckav5dsW++5HZ13xwH9hRXBqRHl9KSwd4GVjkARfjWC2K1Vm32cFtvPPvmoekUk0+E
         I3+gKw8vX2vhbM3KXD86tIUsvxUS7CXBfY0SZxlaaS7wjjUgSYedtGO4TqaCftSRF+fd
         wqzfT0z7VnKWslAGnAAGAOcBfjvG6PSDA1SMQ35YJQH1n8BermkBptl5TBOE0d+5m7DG
         oZPA==
X-Gm-Message-State: AFqh2kpWLP0U+q2PAKA8KdTURKgIKeaZvb2m9bzQDNle8BDhUzx2bWd8
        xeY8DVjBgmlm90jkkyGevUw=
X-Google-Smtp-Source: AMrXdXvQx3vpFKnQF9XPgmoFE5QQUGDoVlw6oov/aXy1uJQciRKkjbBZq6EeXvTaLTALl/jP0RiahA==
X-Received: by 2002:a17:903:240b:b0:192:991f:d8e8 with SMTP id e11-20020a170903240b00b00192991fd8e8mr73835795plo.53.1673873370744;
        Mon, 16 Jan 2023 04:49:30 -0800 (PST)
Received: from localhost ([129.41.58.21])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b00186727e5f5csm19242387plb.248.2023.01.16.04.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:29 -0800 (PST)
Date:   Mon, 16 Jan 2023 18:19:20 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+68223fe9f6c95ad43bed@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix WARNING in mb_find_extent
Message-ID: <20230116124920.ljzoax6ao6hxposw@rh-tp>
References: <20230113100205.2987532-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113100205.2987532-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 23/01/13 06:02PM, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> Syzbot found the following issue:
>
> EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!
> EXT4-fs (loop0): orphan cleanup on readonly fs
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5067 at fs/ext4/mballoc.c:1869 mb_find_extent+0x8a1/0xe30
> Modules linked in:
> CPU: 1 PID: 5067 Comm: syz-executor307 Not tainted 6.2.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:mb_find_extent+0x8a1/0xe30 fs/ext4/mballoc.c:1869
> RSP: 0018:ffffc90003c9e098 EFLAGS: 00010293
> RAX: ffffffff82405731 RBX: 0000000000000041 RCX: ffff8880783457c0
> RDX: 0000000000000000 RSI: 0000000000000041 RDI: 0000000000000040
> RBP: 0000000000000040 R08: ffffffff82405723 R09: ffffed10053c9402
> R10: ffffed10053c9402 R11: 1ffff110053c9401 R12: 0000000000000000
> R13: ffffc90003c9e538 R14: dffffc0000000000 R15: ffffc90003c9e2cc
> FS:  0000555556665300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056312f6796f8 CR3: 0000000022437000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ext4_mb_complex_scan_group+0x353/0x1100 fs/ext4/mballoc.c:2307
>  ext4_mb_regular_allocator+0x1533/0x3860 fs/ext4/mballoc.c:2735
>  ext4_mb_new_blocks+0xddf/0x3db0 fs/ext4/mballoc.c:5605
>  ext4_ext_map_blocks+0x1868/0x6880 fs/ext4/extents.c:4286
>  ext4_map_blocks+0xa49/0x1cc0 fs/ext4/inode.c:651
>  ext4_getblk+0x1b9/0x770 fs/ext4/inode.c:864
>  ext4_bread+0x2a/0x170 fs/ext4/inode.c:920
>  ext4_quota_write+0x225/0x570 fs/ext4/super.c:7105
>  write_blk fs/quota/quota_tree.c:64 [inline]
>  get_free_dqblk+0x34a/0x6d0 fs/quota/quota_tree.c:130
>  do_insert_tree+0x26b/0x1aa0 fs/quota/quota_tree.c:340
>  do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
>  do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
>  do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
>  dq_insert_tree fs/quota/quota_tree.c:401 [inline]
>  qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:420
>  v2_write_dquot+0x11b/0x190 fs/quota/quota_v2.c:358
>  dquot_acquire+0x348/0x670 fs/quota/dquot.c:444
>  ext4_acquire_dquot+0x2dc/0x400 fs/ext4/super.c:6740
>  dqget+0x999/0xdc0 fs/quota/dquot.c:914
>  __dquot_initialize+0x3d0/0xcf0 fs/quota/dquot.c:1492
>  ext4_process_orphan+0x57/0x2d0 fs/ext4/orphan.c:329
>  ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
>  __ext4_fill_super fs/ext4/super.c:5516 [inline]
>  ext4_fill_super+0x81cd/0x8700 fs/ext4/super.c:5644
>  get_tree_bdev+0x400/0x620 fs/super.c:1282
>  vfs_get_tree+0x88/0x270 fs/super.c:1489
>  do_new_mount+0x289/0xad0 fs/namespace.c:3145
>  do_mount fs/namespace.c:3488 [inline]
>  __do_sys_mount fs/namespace.c:3697 [inline]
>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>

So, IIUC from your logs what seems to be happening is,
We have s_blocks_per_group = 64 and s_clusters_per_group = 64.
That means (s_cluster_ratio = 1).
But e4b->bd_blkbits is 12. Since blocksize is 4k.
This makes the number of blocks available in a blockgroup as 32768.

This is causing a problem in below loop, because when you reach
64th block, it's bitmap is not set and it's order is 0 so you end up
adding that into the ex->fe_len. This is happening since we have
64th block bit as not set in e4b->bd_bitmap.

mb_find_extent() {
<...>
	while (needed > ex->fe_len &&
	       mb_find_buddy(e4b, order, &max)) {

		if (block + 1 >= max)
			break;

		next = (block + 1) * (1 << order);
		if (mb_test_bit(next, e4b->bd_bitmap))
			break;

		order = mb_find_order_for_block(e4b, next);

		block = next >> order;
		ex->fe_len += 1 << order;
	}
<...>

Later when the loop exits and compared ex->fe_start + ex->fe_len against
EXT4_CLUSTERS_PER_GROUP, it fails and causes the warning.


So I think the idea behind -g blocks_per_group in mkfs.ext4 option also is that
it will set the remaining blocks in the blockgroup bits to 1 as padded bits?
Is this understanding correct?

Based on that what you are trying to do here is, you are validating whether
the block bitmap has all the padded bits set or not. If not then let's mark this
block group as corrupted so that no allocation happens from here to avoid such
warning. This was exactly what was hitting in this case due to
ext4_quota_write() in the mount path. right?

-ritesh


> Add some debug information:
> mb_find_extent: mb_find_extent block=41, order=0 needed=64 next=0 ex=0/41/1@3735929054 64 64 7
> block_bitmap: ff 3f 0c 00 fc 01 00 00 d2 3d 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
> Acctually, blocks per group is 64, but block bitmap indicate at least has
> 128 blocks. Now, ext4_validate_block_bitmap() didn't check invalid block's
> bitmap if set.


> To resolve above issue, add check like fsck "Padding at end of block bitmap is
> not set".
>
> Reported-by: syzbot+68223fe9f6c95ad43bed@syzkaller.appspotmail.com
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/balloc.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 8ff4b9192a9f..8c9d3bc712c8 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -303,6 +303,23 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
>  	return desc;
>  }
>
> +static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
> +						    ext4_group_t block_group,
> +						    struct buffer_head *bh)
> +{
> +	ext4_grpblk_t next_zero_bit;
> +	unsigned long blocksize = EXT4_NUM_B2C(EXT4_SB(sb),
> +					       (sb->s_blocksize * 8));
> +	unsigned int offset = num_clusters_in_group(sb, block_group);
> +
> +	if (blocksize <= offset)
> +		return 0;
> +
> +	next_zero_bit = ext4_find_next_zero_bit(bh->b_data, blocksize, offset);
> +
> +	return (next_zero_bit < blocksize ? next_zero_bit : 0);
> +}
> +
>  /*
>   * Return the block number which was discovered to be invalid, or 0 if
>   * the block bitmap is valid.
> @@ -401,6 +418,15 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>  					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  		return -EFSCORRUPTED;
>  	}
> +	blk = ext4_valid_block_bitmap_padding(sb, block_group, bh);
> +	if (unlikely(blk != 0)) {
> +		ext4_unlock_group(sb, block_group);
> +		ext4_error(sb, "bg %u: block %llu: padding at end of block bitmap is not set",
> +			   block_group, blk);
> +		ext4_mark_group_bitmap_corrupted(sb, block_group,
> +						 EXT4_GROUP_INFO_BBITMAP_CORRUPT);
> +		return -EFSCORRUPTED;
> +	}
>  	set_buffer_verified(bh);
>  verified:
>  	ext4_unlock_group(sb, block_group);
> --
> 2.31.1
>
