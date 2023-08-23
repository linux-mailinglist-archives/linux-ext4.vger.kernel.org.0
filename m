Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BEE785DE3
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Aug 2023 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjHWQvP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Aug 2023 12:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjHWQvO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Aug 2023 12:51:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A31910C3
        for <linux-ext4@vger.kernel.org>; Wed, 23 Aug 2023 09:51:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 134CF20968;
        Wed, 23 Aug 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692809470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UepCwDy7KHDBTNYQO3AP60g6wuLfjeF9C7t9NS1CHzo=;
        b=x8OViuc0s9zhlYF9hyDhhVeNaoR40jXLh4bWYCvDJMQ8hY4o4YDGu9N3lorIO5wACKxnG/
        27oza2vBUzJ74PGp1p3ZSEzxQCm6aYixjidbc7D7EWZLlE8KWcX/m/yC0l9W1CFHEq1pma
        4KHj2KG/kLkwv76SbkwpstzIJrSnAus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692809470;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UepCwDy7KHDBTNYQO3AP60g6wuLfjeF9C7t9NS1CHzo=;
        b=LR+I6UUOcjhQy/xGZi8t9eGw1GjJJgaXxCsdVXgacHCVdR5F8e087c0XeeDjrayCuxeHx4
        5LUvvdnQApV/izDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDB8D1351F;
        Wed, 23 Aug 2023 16:51:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j7L/Of045mQTTwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 16:51:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 79FE0A0774; Wed, 23 Aug 2023 18:51:09 +0200 (CEST)
Date:   Wed, 23 Aug 2023 18:51:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wu Bo <wubo@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, wubo40@huawei.com
Subject: Re: [PATCH v2] ext4: Adds helpers for s_mount_state
Message-ID: <20230823165109.r5d4g2fuvgd5njjf@quack3>
References: <1692103002-37994-1-git-send-email-wubo@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692103002-37994-1-git-send-email-wubo@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 15-08-23 20:36:42, Wu Bo wrote:
> From: Wu Bo <wubo40@huawei.com>
> 
> This patch adds helpers for s_mount_state to replace open code.
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>

The patch looks correct but why did you decide to create these helpers in
the first place? If the helper is trivial as in this case, I don't think it
really adds much value...

								Honza

> ---
>  fs/ext4/balloc.c         |  2 +-
>  fs/ext4/ext4.h           | 14 ++++++++++++++
>  fs/ext4/ext4_jbd2.c      |  2 +-
>  fs/ext4/extents_status.c | 16 ++++++++--------
>  fs/ext4/fast_commit.c    |  6 +++---
>  fs/ext4/ialloc.c         | 14 +++++++-------
>  fs/ext4/inode.c          | 12 ++++++------
>  fs/ext4/mballoc.c        |  8 ++++----
>  fs/ext4/namei.c          |  4 ++--
>  fs/ext4/orphan.c         |  7 ++++---
>  fs/ext4/resize.c         |  4 ++--
>  fs/ext4/super.c          | 20 ++++++++++----------
>  12 files changed, 62 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 1f72f977c6db..9baa88cacbe0 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -402,7 +402,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>  	ext4_fsblk_t	blk;
>  	struct ext4_group_info *grp;
>  
> -	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(sb, EXT4_FC_REPLAY))
>  		return 0;
>  
>  	grp = ext4_get_group_info(sb, block_group);
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 0a2d55faa095..5b1995986704 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1817,6 +1817,20 @@ static inline int ext4_test_mount_flag(struct super_block *sb, int bit)
>  	return test_bit(bit, &EXT4_SB(sb)->s_mount_flags);
>  }
>  
> +static inline void ext4_set_mount_state(struct super_block *sb, int state)
> +{
> +	EXT4_SB(sb)->s_mount_state |= state;
> +}
> +
> +static inline void ext4_clear_mount_state(struct super_block *sb, int state)
> +{
> +	EXT4_SB(sb)->s_mount_state &= ~state;
> +}
> +
> +static inline int ext4_test_mount_state(struct super_block *sb, int state)
> +{
> +	return EXT4_SB(sb)->s_mount_state & state;
> +}
>  
>  /*
>   * Simulate_fail codes
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 77f318ec8abb..6ba75ae2c188 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -106,7 +106,7 @@ handle_t *__ext4_journal_start_sb(struct inode *inode,
>  		return ERR_PTR(err);
>  
>  	journal = EXT4_SB(sb)->s_journal;
> -	if (!journal || (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
> +	if (!journal || ext4_test_mount_state(sb, EXT4_FC_REPLAY))
>  		return ext4_get_nojournal();
>  	return jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
>  				   GFP_NOFS, type, line);
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 9b5b8951afb4..b37b9c29c9fa 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -309,7 +309,7 @@ void ext4_es_find_extent_range(struct inode *inode,
>  			       ext4_lblk_t lblk, ext4_lblk_t end,
>  			       struct extent_status *es)
>  {
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>  		return;
>  
>  	trace_ext4_es_find_extent_range_enter(inode, lblk);
> @@ -362,7 +362,7 @@ bool ext4_es_scan_range(struct inode *inode,
>  {
>  	bool ret;
>  
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>  		return false;
>  
>  	read_lock(&EXT4_I(inode)->i_es_lock);
> @@ -408,7 +408,7 @@ bool ext4_es_scan_clu(struct inode *inode,
>  {
>  	bool ret;
>  
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>  		return false;
>  
>  	read_lock(&EXT4_I(inode)->i_es_lock);
> @@ -842,7 +842,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	struct extent_status *es1 = NULL;
>  	struct extent_status *es2 = NULL;
>  
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>  		return;
>  
>  	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
> @@ -917,7 +917,7 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>  	struct extent_status newes;
>  	ext4_lblk_t end = lblk + len - 1;
>  
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>  		return;
>  
>  	newes.es_lblk = lblk;
> @@ -955,7 +955,7 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
>  	struct rb_node *node;
>  	int found = 0;
>  
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>  		return 0;
>  
>  	trace_ext4_es_lookup_extent_enter(inode, lblk);
> @@ -1468,7 +1468,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	int reserved = 0;
>  	struct extent_status *es = NULL;
>  
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>  		return;
>  
>  	trace_ext4_es_remove_extent(inode, lblk, len);
> @@ -2024,7 +2024,7 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  	struct extent_status *es1 = NULL;
>  	struct extent_status *es2 = NULL;
>  
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>  		return;
>  
>  	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index b06de728b3b6..023e13ec9fdc 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -232,7 +232,7 @@ __releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
>  static bool ext4_fc_disabled(struct super_block *sb)
>  {
>  	return (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
> -		(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY));
> +		ext4_test_mount_state(sb, EXT4_FC_REPLAY));
>  }
>  
>  /*
> @@ -1975,7 +1975,7 @@ void ext4_fc_replay_cleanup(struct super_block *sb)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  
> -	sbi->s_mount_state &= ~EXT4_FC_REPLAY;
> +	ext4_clear_mount_state(sb, EXT4_FC_REPLAY);
>  	kfree(sbi->s_fc_replay_state.fc_regions);
>  	kfree(sbi->s_fc_replay_state.fc_modified_inodes);
>  }
> @@ -2165,7 +2165,7 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
>  
>  	if (state->fc_current_pass != pass) {
>  		state->fc_current_pass = pass;
> -		sbi->s_mount_state |= EXT4_FC_REPLAY;
> +		ext4_set_mount_state(sb, EXT4_FC_REPLAY);
>  	}
>  	if (!sbi->s_fc_replay_state.fc_replay_num_tags) {
>  		ext4_debug("Replay stops\n");
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 754f961cd9fd..09ec20b2e761 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -84,7 +84,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
>  	ext4_fsblk_t	blk;
>  	struct ext4_group_info *grp;
>  
> -	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(sb, EXT4_FC_REPLAY))
>  		return 0;
>  
>  	grp = ext4_get_group_info(sb, block_group);
> @@ -291,7 +291,7 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
>  		bitmap_bh = NULL;
>  		goto error_return;
>  	}
> -	if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +	if (!ext4_test_mount_state(sb, EXT4_FC_REPLAY)) {
>  		grp = ext4_get_group_info(sb, block_group);
>  		if (!grp || unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
>  			fatal = -EFSCORRUPTED;
> @@ -1040,7 +1040,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		if (ext4_free_inodes_count(sb, gdp) == 0)
>  			goto next_group;
>  
> -		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +		if (!ext4_test_mount_state(sb, EXT4_FC_REPLAY)) {
>  			grp = ext4_get_group_info(sb, group);
>  			/*
>  			 * Skip groups with already-known suspicious inode
> @@ -1053,7 +1053,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		brelse(inode_bitmap_bh);
>  		inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
>  		/* Skip groups with suspicious inode tables */
> -		if (((!(sbi->s_mount_state & EXT4_FC_REPLAY))
> +		if (((!ext4_test_mount_state(sb, EXT4_FC_REPLAY))
>  		     && EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) ||
>  		    IS_ERR(inode_bitmap_bh)) {
>  			inode_bitmap_bh = NULL;
> @@ -1073,7 +1073,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  			goto next_group;
>  		}
>  
> -		if ((!(sbi->s_mount_state & EXT4_FC_REPLAY)) && !handle) {
> +		if (!ext4_test_mount_state(sb, EXT4_FC_REPLAY) && !handle) {
>  			BUG_ON(nblocks <= 0);
>  			handle = __ext4_journal_start_sb(NULL, dir->i_sb,
>  				 line_no, handle_type, nblocks, 0,
> @@ -1181,7 +1181,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		int free;
>  		struct ext4_group_info *grp = NULL;
>  
> -		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +		if (!ext4_test_mount_state(sb, EXT4_FC_REPLAY)) {
>  			grp = ext4_get_group_info(sb, group);
>  			if (!grp) {
>  				err = -EFSCORRUPTED;
> @@ -1207,7 +1207,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		if (ino > free)
>  			ext4_itable_unused_set(sb, gdp,
>  					(EXT4_INODES_PER_GROUP(sb) - ino));
> -		if (!(sbi->s_mount_state & EXT4_FC_REPLAY))
> +		if (!ext4_test_mount_state(sb, EXT4_FC_REPLAY))
>  			up_read(&grp->alloc_sem);
>  	} else {
>  		ext4_lock_group(sb, group);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 43775a6ca505..b830a13ca651 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -502,7 +502,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		return -EFSCORRUPTED;
>  
>  	/* Lookup extent status tree firstly */
> -	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
> +	if (!(ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY)) &&
>  	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
>  		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
>  			map->m_pblk = ext4_es_pblock(&es) +
> @@ -810,7 +810,7 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
>  	bool nowait = map_flags & EXT4_GET_BLOCKS_CACHED_NOWAIT;
>  	int err;
>  
> -	ASSERT((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	ASSERT(ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY)
>  		    || handle != NULL || create == 0);
>  	ASSERT(create == 0 || !nowait);
>  
> @@ -831,7 +831,7 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
>  		return ERR_PTR(-ENOMEM);
>  	if (map.m_flags & EXT4_MAP_NEW) {
>  		ASSERT(create != 0);
> -		ASSERT((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		ASSERT(ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY)
>  			    || (handle != NULL));
>  
>  		/*
> @@ -4723,7 +4723,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  
>  	if ((!ext4_inode_csum_verify(inode, raw_inode, ei) ||
>  	    ext4_simulate_fail(sb, EXT4_SIM_INODE_CRC)) &&
> -	     (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))) {
> +	     (!ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))) {
>  		ext4_error_inode_err(inode, function, line, 0,
>  				EFSBADCRC, "iget: checksum invalid");
>  		ret = -EFSBADCRC;
> @@ -4760,7 +4760,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	 */
>  	if (inode->i_nlink == 0) {
>  		if ((inode->i_mode == 0 || flags & EXT4_IGET_SPECIAL ||
> -		     !(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ORPHAN_FS)) &&
> +		     !ext4_test_mount_state(inode->i_sb, EXT4_ORPHAN_FS)) &&
>  		    ino != EXT4_BOOT_LOADER_INO) {
>  			/* this inode is deleted or unallocated */
>  			if (flags & EXT4_IGET_SPECIAL) {
> @@ -4884,7 +4884,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		goto bad_inode;
>  	} else if (!ext4_has_inline_data(inode)) {
>  		/* validate the block references in the inode */
> -		if (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
> +		if (!ext4_test_mount_state(sb, EXT4_FC_REPLAY) &&
>  			(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>  			(S_ISLNK(inode->i_mode) &&
>  			!ext4_inode_is_fast_symlink(inode)))) {
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 21b903fe546e..920b03a5cb7a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1911,7 +1911,7 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>  
>  		blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
>  		blocknr += EXT4_C2B(sbi, block);
> -		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +		if (!ext4_test_mount_state(sb, EXT4_FC_REPLAY)) {
>  			ext4_grp_locked_error(sb, e4b->bd_group,
>  					      inode ? inode->i_ino : 0,
>  					      blocknr,
> @@ -5538,7 +5538,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  		return;
>  	}
>  
> -	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(sb, EXT4_FC_REPLAY))
>  		return;
>  
>  	mb_debug(sb, "discard preallocation for inode %lu\n",
> @@ -6175,7 +6175,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  	sbi = EXT4_SB(sb);
>  
>  	trace_ext4_request_blocks(ar);
> -	if (sbi->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(sb, EXT4_FC_REPLAY))
>  		return ext4_mb_new_blocks_simple(ar, errp);
>  
>  	/* Allow to use superuser reservation for quota file */
> @@ -6672,7 +6672,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  			block = bh->b_blocknr;
>  	}
>  
> -	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
> +	if (ext4_test_mount_state(sb, EXT4_FC_REPLAY)) {
>  		ext4_free_blocks_simple(inode, block, EXT4_NUM_B2C(sbi, count));
>  		return;
>  	}
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 0caf6c730ce3..01e00f8a9c7a 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3251,7 +3251,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
>  		 * the inode. That's because it might have gotten
>  		 * renamed to a different inode number
>  		 */
> -		if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>  			skip_remove_dentry = 1;
>  		else
>  			goto out_bh;
> @@ -3996,7 +3996,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  		if (new.inode)
>  			ext4_fc_track_unlink(handle, new.dentry);
>  		if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
> -		    !(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
> +		    !(ext4_test_mount_state(sb, EXT4_FC_REPLAY)) &&
>  		    !(ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE))) {
>  			__ext4_fc_track_link(handle, old.inode, new.dentry);
>  			__ext4_fc_track_unlink(handle, old.inode, old.dentry);
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index e5b47dda3317..f663e41c20bd 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -233,7 +233,8 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
>  	struct ext4_iloc iloc;
>  	int err = 0;
>  
> -	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
> +	if (!sbi->s_journal &&
> +	    !ext4_test_mount_state(inode->i_sb, EXT4_ORPHAN_FS))
>  		return 0;
>  
>  	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
> @@ -408,7 +409,7 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
>  		return;
>  	}
>  
> -	if (EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS) {
> +	if (ext4_test_mount_state(sb, EXT4_ERROR_FS)) {
>  		/* don't clear list on RO mount w/ errors */
>  		if (es->s_last_orphan && !(s_flags & SB_RDONLY)) {
>  			ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
> @@ -458,7 +459,7 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
>  		 * We may have encountered an error during cleanup; if
>  		 * so, skip the rest.
>  		 */
> -		if (EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS) {
> +		if (ext4_test_mount_state(sb, EXT4_ERROR_FS)) {
>  			ext4_debug("Skipping orphan recovery on fs with errors.\n");
>  			es->s_last_orphan = 0;
>  			break;
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 0361c20910de..f656a8fcc0c2 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -79,7 +79,7 @@ int ext4_resize_begin(struct super_block *sb)
>  	 * We are not allowed to do online-resizing on a filesystem mounted
>  	 * with error, because it can destroy the filesystem easily.
>  	 */
> -	if (EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS) {
> +	if (ext4_test_mount_state(sb, EXT4_ERROR_FS)) {
>  		ext4_warning(sb, "There are errors in the filesystem, "
>  			     "so online resizing is not allowed");
>  		return -EPERM;
> @@ -1230,7 +1230,7 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
>  	if (err) {
>  		ext4_warning(sb, "can't update backup for group %u (err %d), "
>  			     "forcing fsck on next reboot", group, err);
> -		sbi->s_mount_state &= ~EXT4_VALID_FS;
> +		ext4_clear_mount_state(sb, EXT4_VALID_FS);
>  		sbi->s_es->s_state &= cpu_to_le16(~EXT4_VALID_FS);
>  		mark_buffer_dirty(sbi->s_sbh);
>  	}
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c94ebf704616..c88ad66644d9 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -652,7 +652,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  	journal_t *journal = EXT4_SB(sb)->s_journal;
>  	bool continue_fs = !force_ro && test_opt(sb, ERRORS_CONT);
>  
> -	EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
> +	ext4_set_mount_state(sb, EXT4_ERROR_FS);
>  	if (test_opt(sb, WARN_ON_ERROR))
>  		WARN_ON_ONCE(1);
>  
> @@ -1014,7 +1014,7 @@ __acquires(bitlock)
>  	if (test_opt(sb, ERRORS_CONT)) {
>  		if (test_opt(sb, WARN_ON_ERROR))
>  			WARN_ON_ONCE(1);
> -		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
> +		ext4_set_mount_state(sb, EXT4_ERROR_FS);
>  		if (!bdev_read_only(sb->s_bdev)) {
>  			save_error_info(sb, EFSCORRUPTED, ino, block, function,
>  					line);
> @@ -3090,10 +3090,10 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
>  	}
>  	if (read_only)
>  		goto done;
> -	if (!(sbi->s_mount_state & EXT4_VALID_FS))
> +	if (!ext4_test_mount_state(sb, EXT4_VALID_FS))
>  		ext4_msg(sb, KERN_WARNING, "warning: mounting unchecked fs, "
>  			 "running e2fsck is recommended");
> -	else if (sbi->s_mount_state & EXT4_ERROR_FS)
> +	else if (ext4_test_mount_state(sb, EXT4_ERROR_FS))
>  		ext4_msg(sb, KERN_WARNING,
>  			 "warning: mounting fs with errors, "
>  			 "running e2fsck is recommended");
> @@ -5573,9 +5573,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
>  				 &sbi->s_bdev_wb_err);
>  	sb->s_bdev->bd_super = sb;
> -	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
> +	ext4_set_mount_state(sb, EXT4_ORPHAN_FS);
>  	ext4_orphan_cleanup(sb, es);
> -	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
> +	ext4_clear_mount_state(sb, EXT4_ORPHAN_FS);
>  	/*
>  	 * Update the checksum after updating free space/inode counters and
>  	 * ext4_orphan_cleanup. Otherwise the superblock can have an incorrect
> @@ -6023,8 +6023,8 @@ static int ext4_load_journal(struct super_block *sb,
>  		}
>  		kfree(save);
>  		orig_state = es->s_state;
> -		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
> -					   EXT4_ERROR_FS);
> +		es->s_state |= cpu_to_le16(ext4_test_mount_state(sb,
> +					   EXT4_ERROR_FS));
>  		if (orig_state != es->s_state)
>  			changed = true;
>  		/* Write out restored error information to the superblock */
> @@ -6263,7 +6263,7 @@ static int ext4_clear_journal_err(struct super_block *sb,
>  		ext4_warning(sb, "Filesystem error recorded "
>  			     "from previous mount: %s", errstr);
>  
> -		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
> +		ext4_set_mount_state(sb, EXT4_ERROR_FS);
>  		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
>  		j_errno = ext4_commit_super(sb);
>  		if (j_errno)
> @@ -6544,7 +6544,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  			 * mark the partition as valid again.
>  			 */
>  			if (!(es->s_state & cpu_to_le16(EXT4_VALID_FS)) &&
> -			    (sbi->s_mount_state & EXT4_VALID_FS))
> +			    (ext4_test_mount_state(sb, EXT4_VALID_FS)))
>  				es->s_state = cpu_to_le16(sbi->s_mount_state);
>  
>  			if (sbi->s_journal) {
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
