Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE262BCF5
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Nov 2022 13:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiKPMEs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Nov 2022 07:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbiKPMEc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Nov 2022 07:04:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96FCDF2;
        Wed, 16 Nov 2022 03:56:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 92AE3336F0;
        Wed, 16 Nov 2022 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668599779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHiaZjx9nsV+QX7MltHTO7orWU5S9kcNYLzN+JX3DCM=;
        b=YFT9v0Xw1X/b16yQ5tShk2Jx7/1oixClCIaC9vBP0rfzkOayU1/QtnfpSWYDMI9R0rTKqg
        on1qggEt/+ZXn8PWcqojG/6RX2LfnfEP+TldXujrtzwRf+x2Md6E5X32PC/UwMwAe9qDTl
        sLR+nKLtUv/tpir+29x1WWLPvmAIY3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668599779;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHiaZjx9nsV+QX7MltHTO7orWU5S9kcNYLzN+JX3DCM=;
        b=gQuLTXdiC4HWGh1wSqjXY8k2GQOSYmTddcJNtzrv+QyNbReYly+jXYhL/ngsLcYvtyjKqp
        UaCmbfki7iqId7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7619D134CE;
        Wed, 16 Nov 2022 11:56:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3PLHHOPPdGO7eQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Nov 2022 11:56:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 96B7FA0709; Wed, 16 Nov 2022 12:56:18 +0100 (CET)
Date:   Wed, 16 Nov 2022 12:56:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 3/3] ext4: fix corruption when online resizing a 1K
 bigalloc fs
Message-ID: <20221116115618.bnbnabifqnhvi5ii@quack3>
References: <20221116072802.526990-1-libaokun1@huawei.com>
 <20221116072802.526990-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116072802.526990-4-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 16-11-22 15:28:02, Baokun Li wrote:
> When a backup superblock is updated in update_backups(), the primary
> superblock's offset in the group (that is, sbi->s_sbh->b_blocknr) is used
> as the backup superblock's offset in its group. However, when the block
> size is 1K and bigalloc is enabled, the two offsets are not equal. This
> causes the backup group descriptors to be overwritten by the superblock
> in update_backups(). Moreover, if meta_bg is enabled, the file system will
> be corrupted because this feature uses backup group descriptors.
> 
> To solve this issue, we use a more accurate ext4_group_first_block_no() as
> the offset of the backup superblock in its group.
> 
> Fixes: d77147ff443b ("ext4: add support for online resizing with bigalloc")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V1->V2:
>     Replace s_first_data_block with ext4_group_first_block_no() to avoid
>     type warning.(Reported-by: kernel test robot <lkp@intel.com>)
> 
>  fs/ext4/resize.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 32fbfc173571..98e544c2f97d 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1591,8 +1591,8 @@ static int ext4_flex_group_add(struct super_block *sb,
>  		int meta_bg = ext4_has_feature_meta_bg(sb);
>  		sector_t old_gdb = 0;
>  
> -		update_backups(sb, sbi->s_sbh->b_blocknr, (char *)es,
> -			       sizeof(struct ext4_super_block), 0);
> +		update_backups(sb, ext4_group_first_block_no(sb, 0),
> +			       (char *)es, sizeof(struct ext4_super_block), 0);
>  		for (; gdb_num <= gdb_num_end; gdb_num++) {
>  			struct buffer_head *gdb_bh;
>  
> @@ -1803,7 +1803,7 @@ static int ext4_group_extend_no_check(struct super_block *sb,
>  		if (test_opt(sb, DEBUG))
>  			printk(KERN_DEBUG "EXT4-fs: extended group to %llu "
>  			       "blocks\n", ext4_blocks_count(es));
> -		update_backups(sb, EXT4_SB(sb)->s_sbh->b_blocknr,
> +		update_backups(sb, ext4_group_first_block_no(sb, 0),
>  			       (char *)es, sizeof(struct ext4_super_block), 0);
>  	}
>  	return err;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
