Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79D3631CED
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 10:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKUJgB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 04:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKUJgA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 04:36:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D856D975;
        Mon, 21 Nov 2022 01:35:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C95D1F85D;
        Mon, 21 Nov 2022 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669023358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5M/j/w2eL24UN3n7RWsNt3EHzQXxvHqEqFxwXJ4ghcc=;
        b=YruWUDOdabKS/0iaPelFFRAzOGTOSbwp1E09+8yQG2IHub3mm97ZVvjp23V/2i859rJzxJ
        /GBLwMQviKpztm0/j6XGdp0r+VbkLPZEuZFabb0CwZh6dyk/FxfV0howOf7ccTHghu+Uqb
        j922drlhK79VZBYsmsUA9evKi8RW/uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669023358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5M/j/w2eL24UN3n7RWsNt3EHzQXxvHqEqFxwXJ4ghcc=;
        b=xtpgc+cuOzyzcPqb1nPL0je8gFITZPLyTRkh84Ku9SgPOdgwOPAum7NMOS3noxU2ncGR6Q
        Wo0Zies21fx3DBAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F10C1377F;
        Mon, 21 Nov 2022 09:35:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WX4xF35Ge2MqcQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Nov 2022 09:35:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DC5A2A070A; Mon, 21 Nov 2022 10:35:57 +0100 (CET)
Date:   Mon, 21 Nov 2022 10:35:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v3 2/3] ext4: fix corrupt backup group descriptors after
 online resize
Message-ID: <20221121093557.vz2gmpvmxxmzhz4p@quack3>
References: <20221117040341.1380702-1-libaokun1@huawei.com>
 <20221117040341.1380702-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117040341.1380702-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 17-11-22 12:03:40, Baokun Li wrote:
> In commit 9a8c5b0d0615 ("ext4: update the backup superblock's at the end
> of the online resize"), it is assumed that update_backups() only updates
> backup superblocks, so each b_data is treated as a backupsuper block to
> update its s_block_group_nr and s_checksum. However, update_backups()
> also updates the backup group descriptors, which causes the backup group
> descriptors to be corrupted.
> 
> The above commit fixes the problem of invalid checksum of the backup
> superblock. The root cause of this problem is that the checksum of
> ext4_update_super() is not set correctly. This problem has been fixed
> in the previous patch ("ext4: fix bad checksum after online resize").
> 
> However, we do need to set block_group_nr for the backup superblock in
> update_backups(). When a block is in a group that contains a backup
> superblock, and the block is the first block in the group, the block is
> definitely a superblock. We add a helper function that includes setting
> s_block_group_nr and updating checksum, and then call it only when the
> above conditions are met to prevent the backup group descriptors from
> being incorrectly modified.
> 
> Fixes: 9a8c5b0d0615 ("ext4: update the backup superblock's at the end of the online resize")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me now. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V2->V3:
>     Modify the scheme and retain s_block_group_nr.
> 
>  fs/ext4/resize.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index cb99b410c9fa..66ceabbd83ad 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1110,6 +1110,16 @@ static int reserve_backup_gdb(handle_t *handle, struct inode *inode,
>  	return err;
>  }
>  
> +static inline void ext4_set_block_group_nr(struct super_block *sb, char *data,
> +					   ext4_group_t group)
> +{
> +	struct ext4_super_block *es = (struct ext4_super_block *) data;
> +
> +	es->s_block_group_nr = cpu_to_le16(group);
> +	if (ext4_has_metadata_csum(sb))
> +		es->s_checksum = ext4_superblock_csum(sb, es);
> +}
> +
>  /*
>   * Update the backup copies of the ext4 metadata.  These don't need to be part
>   * of the main resize transaction, because e2fsck will re-write them if there
> @@ -1158,7 +1168,8 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
>  	while (group < sbi->s_groups_count) {
>  		struct buffer_head *bh;
>  		ext4_fsblk_t backup_block;
> -		struct ext4_super_block *es;
> +		int has_super = ext4_bg_has_super(sb, group);
> +		ext4_fsblk_t first_block = ext4_group_first_block_no(sb, group);
>  
>  		/* Out of journal space, and can't get more - abort - so sad */
>  		err = ext4_resize_ensure_credits_batch(handle, 1);
> @@ -1168,8 +1179,7 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
>  		if (meta_bg == 0)
>  			backup_block = ((ext4_fsblk_t)group) * bpg + blk_off;
>  		else
> -			backup_block = (ext4_group_first_block_no(sb, group) +
> -					ext4_bg_has_super(sb, group));
> +			backup_block = first_block + has_super;
>  
>  		bh = sb_getblk(sb, backup_block);
>  		if (unlikely(!bh)) {
> @@ -1187,10 +1197,8 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
>  		memcpy(bh->b_data, data, size);
>  		if (rest)
>  			memset(bh->b_data + size, 0, rest);
> -		es = (struct ext4_super_block *) bh->b_data;
> -		es->s_block_group_nr = cpu_to_le16(group);
> -		if (ext4_has_metadata_csum(sb))
> -			es->s_checksum = ext4_superblock_csum(sb, es);
> +		if (has_super && (backup_block == first_block))
> +			ext4_set_block_group_nr(sb, bh->b_data, group);
>  		set_buffer_uptodate(bh);
>  		unlock_buffer(bh);
>  		err = ext4_handle_dirty_metadata(handle, NULL, bh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
