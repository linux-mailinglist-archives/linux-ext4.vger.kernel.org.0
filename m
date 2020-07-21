Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160C4227D38
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 12:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgGUKjG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 06:39:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726084AbgGUKjG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 06:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595327943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zq9fgUweEYVk2v3FpHjbP2TMsShgrOhZxI7SSDxDAIQ=;
        b=YBUUYKS9/lqAB4AN0pkWhbgbel3N2DDyHickuRMn+kotfpyQPbizWuG6EiaOvZa5uVuCmx
        fw7QnbVRKA28M0Gxc6B9plMZdSLNApdOqan8wLLBAOudFVtsrkRrGdLzshwZBDQDgLvktd
        /SUCDas5MbHGZh+h91pRT6cf4ph2rDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-8Ui5Y1O1O_aHc1RndTv5Kg-1; Tue, 21 Jul 2020 06:39:01 -0400
X-MC-Unique: 8Ui5Y1O1O_aHc1RndTv5Kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E03980046D;
        Tue, 21 Jul 2020 10:39:00 +0000 (UTC)
Received: from work (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAA4F90345;
        Tue, 21 Jul 2020 10:38:58 +0000 (UTC)
Date:   Tue, 21 Jul 2020 12:38:55 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Wolfgang Frisch <wolfgang.frisch@suse.com>
Subject: Re: [PATCH 3/4] ext4: Check journal inode extents more carefully
Message-ID: <20200721103855.c5a6ki32ocpe2nwe@work>
References: <20200715131812.7243-1-jack@suse.cz>
 <20200715131812.7243-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715131812.7243-4-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 15, 2020 at 03:18:11PM +0200, Jan Kara wrote:
> Currently, system zones just track ranges of block, that are "important"
> fs metadata (bitmaps, group descriptors, journal blocks, etc.). This
> however complicates how extent tree (or indirect blocks) can be checked
> for inodes that actually track such metadata - currently the journal
> inode but arguably we should be treating quota files or resize inode
> similarly. We cannot run __ext4_ext_check() on such metadata inodes when
> loading their extents as that would immediately trigger the validity
> checks and so we just hack around that and special-case the journal
> inode. This however leads to a situation that a journal inode which has
> extent tree of depth at least one can have invalid extent tree that gets
> unnoticed until ext4_cache_extents() crashes.
> 
> To overcome this limitation, track inode number each system zone belongs
> to (0 is used for zones not belonging to any inode). We can then verify
> inode number matches the expected one when verifying extent tree and
> thus avoid the false errors. With this there's no need to to
> special-case journal inode during extent tree checking anymore so remove
> it.
> 
> Fixes: 0a944e8a6c66 ("ext4: don't perform block validity checks on the journal inode")
> Reported-by: Wolfgang Frisch <wolfgang.frisch@suse.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/block_validity.c | 49 ++++++++++++++++++++++++------------------------
>  fs/ext4/ext4.h           |  6 +++---
>  fs/ext4/extents.c        | 16 ++++++----------
>  fs/ext4/indirect.c       |  6 ++----
>  fs/ext4/inode.c          |  5 ++---
>  fs/ext4/mballoc.c        |  4 ++--
>  6 files changed, 40 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index b394a50ebbe3..3602356cbf09 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -24,6 +24,7 @@ struct ext4_system_zone {
>  	struct rb_node	node;
>  	ext4_fsblk_t	start_blk;
>  	unsigned int	count;
> +	u32		ino;
>  };
>  
>  static struct kmem_cache *ext4_system_zone_cachep;
> @@ -45,7 +46,8 @@ void ext4_exit_system_zone(void)
>  static inline int can_merge(struct ext4_system_zone *entry1,
>  		     struct ext4_system_zone *entry2)
>  {
> -	if ((entry1->start_blk + entry1->count) == entry2->start_blk)
> +	if ((entry1->start_blk + entry1->count) == entry2->start_blk &&
> +	    entry1->ino == entry2->ino)
>  		return 1;
>  	return 0;
>  }
> @@ -66,7 +68,7 @@ static void release_system_zone(struct ext4_system_blocks *system_blks)
>   */
>  static int add_system_zone(struct ext4_system_blocks *system_blks,
>  			   ext4_fsblk_t start_blk,
> -			   unsigned int count)
> +			   unsigned int count, u32 ino)
>  {
>  	struct ext4_system_zone *new_entry, *entry;
>  	struct rb_node **n = &system_blks->root.rb_node, *node;
> @@ -89,6 +91,7 @@ static int add_system_zone(struct ext4_system_blocks *system_blks,
>  		return -ENOMEM;
>  	new_entry->start_blk = start_blk;
>  	new_entry->count = count;
> +	new_entry->ino = ino;
>  	new_node = &new_entry->node;
>  
>  	rb_link_node(new_node, parent, n);
> @@ -149,7 +152,7 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
>  static int ext4_data_block_valid_rcu(struct ext4_sb_info *sbi,
>  				     struct ext4_system_blocks *system_blks,
>  				     ext4_fsblk_t start_blk,
> -				     unsigned int count)
> +				     unsigned int count, ino_t ino)
>  {
>  	struct ext4_system_zone *entry;
>  	struct rb_node *n;
> @@ -170,7 +173,7 @@ static int ext4_data_block_valid_rcu(struct ext4_sb_info *sbi,
>  		else if (start_blk >= (entry->start_blk + entry->count))
>  			n = n->rb_right;
>  		else
> -			return 0;
> +			return entry->ino == ino;
>  	}
>  	return 1;
>  }
> @@ -204,19 +207,18 @@ static int ext4_protect_reserved_inode(struct super_block *sb,
>  		if (n == 0) {
>  			i++;
>  		} else {
> -			if (!ext4_data_block_valid_rcu(sbi, system_blks,
> -						map.m_pblk, n)) {
> -				err = -EFSCORRUPTED;
> -				__ext4_error(sb, __func__, __LINE__, -err,
> -					     map.m_pblk, "blocks %llu-%llu "
> -					     "from inode %u overlap system zone",
> -					     map.m_pblk,
> -					     map.m_pblk + map.m_len - 1, ino);
> +			err = add_system_zone(system_blks, map.m_pblk, n, ino);
> +			if (err < 0) {
> +				if (err == -EFSCORRUPTED) {
> +					__ext4_error(sb, __func__, __LINE__,
> +						     -err, map.m_pblk,
> +						     "blocks %llu-%llu from inode %u overlap system zone",
> +						     map.m_pblk,
> +						     map.m_pblk + map.m_len - 1,
> +						     ino);
> +				}
>  				break;
>  			}
> -			err = add_system_zone(system_blks, map.m_pblk, n);
> -			if (err < 0)
> -				break;
>  			i += n;
>  		}
>  	}
> @@ -270,19 +272,19 @@ int ext4_setup_system_zone(struct super_block *sb)
>  		    ((i < 5) || ((i % flex_size) == 0)))
>  			add_system_zone(system_blks,
>  					ext4_group_first_block_no(sb, i),
> -					ext4_bg_num_gdb(sb, i) + 1);
> +					ext4_bg_num_gdb(sb, i) + 1, 0);

Is there a good reason we don't check the return value, it can still
fail right ?

Other than that the patch looks good to me.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

-Lukas

>  		gdp = ext4_get_group_desc(sb, i, NULL);
>  		ret = add_system_zone(system_blks,
> -				ext4_block_bitmap(sb, gdp), 1);
> +				ext4_block_bitmap(sb, gdp), 1, 0);
>  		if (ret)
>  			goto err;
>  		ret = add_system_zone(system_blks,
> -				ext4_inode_bitmap(sb, gdp), 1);
> +				ext4_inode_bitmap(sb, gdp), 1, 0);
>  		if (ret)
>  			goto err;
>  		ret = add_system_zone(system_blks,
>  				ext4_inode_table(sb, gdp),
> -				sbi->s_itb_per_group);
> +				sbi->s_itb_per_group, 0);
>  		if (ret)
>  			goto err;
>  	}
> @@ -331,7 +333,7 @@ void ext4_release_system_zone(struct super_block *sb)
>  		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
>  }
>  
> -int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
> +int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
>  			  unsigned int count)
>  {
>  	struct ext4_system_blocks *system_blks;
> @@ -344,8 +346,8 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
>  	 */
>  	rcu_read_lock();
>  	system_blks = rcu_dereference(sbi->system_blks);
> -	ret = ext4_data_block_valid_rcu(sbi, system_blks, start_blk,
> -					count);
> +	ret = ext4_data_block_valid_rcu(EXT4_SB(inode->i_sb), system_blks,
> +					start_blk, count, inode->i_ino);
>  	rcu_read_unlock();
>  	return ret;
>  }
> @@ -364,8 +366,7 @@ int ext4_check_blockref(const char *function, unsigned int line,
>  	while (bref < p+max) {
>  		blk = le32_to_cpu(*bref++);
>  		if (blk &&
> -		    unlikely(!ext4_data_block_valid(EXT4_SB(inode->i_sb),
> -						    blk, 1))) {
> +		    unlikely(!ext4_inode_block_valid(inode, blk, 1))) {
>  			ext4_error_inode(inode, function, line, blk,
>  					 "invalid block");
>  			return -EFSCORRUPTED;
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 42f5060f3cdf..42815304902b 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3363,9 +3363,9 @@ extern void ext4_release_system_zone(struct super_block *sb);
>  extern int ext4_setup_system_zone(struct super_block *sb);
>  extern int __init ext4_init_system_zone(void);
>  extern void ext4_exit_system_zone(void);
> -extern int ext4_data_block_valid(struct ext4_sb_info *sbi,
> -				 ext4_fsblk_t start_blk,
> -				 unsigned int count);
> +extern int ext4_inode_block_valid(struct inode *inode,
> +				  ext4_fsblk_t start_blk,
> +				  unsigned int count);
>  extern int ext4_check_blockref(const char *, unsigned int,
>  			       struct inode *, __le32 *, unsigned int);
>  
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 221f240eae60..d75054570e44 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -340,7 +340,7 @@ static int ext4_valid_extent(struct inode *inode, struct ext4_extent *ext)
>  	 */
>  	if (lblock + len <= lblock)
>  		return 0;
> -	return ext4_data_block_valid(EXT4_SB(inode->i_sb), block, len);
> +	return ext4_inode_block_valid(inode, block, len);
>  }
>  
>  static int ext4_valid_extent_idx(struct inode *inode,
> @@ -348,7 +348,7 @@ static int ext4_valid_extent_idx(struct inode *inode,
>  {
>  	ext4_fsblk_t block = ext4_idx_pblock(ext_idx);
>  
> -	return ext4_data_block_valid(EXT4_SB(inode->i_sb), block, 1);
> +	return ext4_inode_block_valid(inode, block, 1);
>  }
>  
>  static int ext4_valid_extent_entries(struct inode *inode,
> @@ -507,14 +507,10 @@ __read_extent_tree_block(const char *function, unsigned int line,
>  	}
>  	if (buffer_verified(bh) && !(flags & EXT4_EX_FORCE_CACHE))
>  		return bh;
> -	if (!ext4_has_feature_journal(inode->i_sb) ||
> -	    (inode->i_ino !=
> -	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum))) {
> -		err = __ext4_ext_check(function, line, inode,
> -				       ext_block_hdr(bh), depth, pblk);
> -		if (err)
> -			goto errout;
> -	}
> +	err = __ext4_ext_check(function, line, inode,
> +			       ext_block_hdr(bh), depth, pblk);
> +	if (err)
> +		goto errout;
>  	set_buffer_verified(bh);
>  	/*
>  	 * If this is a leaf block, cache all of its entries
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index be2b66eb65f7..402641825712 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -858,8 +858,7 @@ static int ext4_clear_blocks(handle_t *handle, struct inode *inode,
>  	else if (ext4_should_journal_data(inode))
>  		flags |= EXT4_FREE_BLOCKS_FORGET;
>  
> -	if (!ext4_data_block_valid(EXT4_SB(inode->i_sb), block_to_free,
> -				   count)) {
> +	if (!ext4_inode_block_valid(inode, block_to_free, count)) {
>  		EXT4_ERROR_INODE(inode, "attempt to clear invalid "
>  				 "blocks %llu len %lu",
>  				 (unsigned long long) block_to_free, count);
> @@ -1004,8 +1003,7 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
>  			if (!nr)
>  				continue;		/* A hole */
>  
> -			if (!ext4_data_block_valid(EXT4_SB(inode->i_sb),
> -						   nr, 1)) {
> +			if (!ext4_inode_block_valid(inode, nr, 1)) {
>  				EXT4_ERROR_INODE(inode,
>  						 "invalid indirect mapped "
>  						 "block %lu (level %d)",
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 10dd470876b3..92573f8540ab 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -394,8 +394,7 @@ static int __check_block_validity(struct inode *inode, const char *func,
>  	    (inode->i_ino ==
>  	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
>  		return 0;
> -	if (!ext4_data_block_valid(EXT4_SB(inode->i_sb), map->m_pblk,
> -				   map->m_len)) {
> +	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
>  		ext4_error_inode(inode, func, line, map->m_pblk,
>  				 "lblock %lu mapped to illegal pblock %llu "
>  				 "(length %d)", (unsigned long) map->m_lblk,
> @@ -4760,7 +4759,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  
>  	ret = 0;
>  	if (ei->i_file_acl &&
> -	    !ext4_data_block_valid(EXT4_SB(sb), ei->i_file_acl, 1)) {
> +	    !ext4_inode_block_valid(inode, ei->i_file_acl, 1)) {
>  		ext4_error_inode(inode, function, line, 0,
>  				 "iget: bad extended attribute block %llu",
>  				 ei->i_file_acl);
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c0a331e2feb0..38719c156573 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3090,7 +3090,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  	block = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
>  
>  	len = EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> -	if (!ext4_data_block_valid(sbi, block, len)) {
> +	if (!ext4_inode_block_valid(ac->ac_inode, block, len)) {
>  		ext4_error(sb, "Allocating blocks %llu-%llu which overlap "
>  			   "fs metadata", block, block+len);
>  		/* File system mounted not to panic on error
> @@ -4915,7 +4915,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  
>  	sbi = EXT4_SB(sb);
>  	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
> -	    !ext4_data_block_valid(sbi, block, count)) {
> +	    !ext4_inode_block_valid(inode, block, count)) {
>  		ext4_error(sb, "Freeing blocks not in datazone - "
>  			   "block = %llu, count = %lu", block, count);
>  		goto error_return;
> -- 
> 2.16.4
> 

