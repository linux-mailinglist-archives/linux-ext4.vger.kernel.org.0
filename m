Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14CB66939C
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jan 2023 11:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjAMKDN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Jan 2023 05:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjAMKCr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Jan 2023 05:02:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF237BC5;
        Fri, 13 Jan 2023 02:02:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D047253D5;
        Fri, 13 Jan 2023 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673604163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4yaLatNAtUQ6n1J9/DtLwS9+iJDUm3CTom3dL1OEBU=;
        b=L+J/VqMxtpwTrAuEr2EW3szFPdlGWVnax5/JgQiMoS+aVyUceYJKhPyLJoWL0yg7sBQ8ac
        NXbIJRcORd7Pe8uHLPDAWL5pLQ4qqiH1WOsOKlbeey9ilIzHh/COQ3lpl3ZonxCd7qQQqI
        Zru9HWyGynt3GgDoMtAhjPqiwaB0JR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673604163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4yaLatNAtUQ6n1J9/DtLwS9+iJDUm3CTom3dL1OEBU=;
        b=CM4MkZrDMyxqdoAYYhLqnc2RiH7CdJEmbGTQbpgyiylvtagIFKWyEctYIXGfKkn8TL/ZSu
        LFEwzvJ0H+B9lQCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1ECC213913;
        Fri, 13 Jan 2023 10:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RXuNB0MswWP6CQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 13 Jan 2023 10:02:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A103DA0744; Fri, 13 Jan 2023 11:02:42 +0100 (CET)
Date:   Fri, 13 Jan 2023 11:02:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+68223fe9f6c95ad43bed@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix WARNING in mb_find_extent
Message-ID: <20230113100242.52wsvbdwv2vjeid5@quack3>
References: <20230113100205.2987532-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113100205.2987532-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 13-01-23 18:02:05, Ye Bin wrote:
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

A few smaller comments below.

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

Maybe call this "bitmap_size" because that's the meaning of the variable
AFAIU? Also shouldn't it be just sb->s_blocksize * 8? Because we want the
block to be filled with 1's upto the end regardless of a possible cluster
size?

								Honza

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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
