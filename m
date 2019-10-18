Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6BDBC0D
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2019 06:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441926AbfJREys (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Oct 2019 00:54:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42214 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725995AbfJREyr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Oct 2019 00:54:47 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9I27njI019643
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 22:07:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C808420458; Thu, 17 Oct 2019 22:07:49 -0400 (EDT)
Date:   Thu, 17 Oct 2019 22:07:49 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 10/13] ext4: fast-commit recovery path changes
Message-ID: <20191018020749.GC21137@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-11-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001074101.256523-11-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 01, 2019 at 12:40:59AM -0700, Harshad Shirwadkar wrote:
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 0b202e00d93f..2433f12d2d88 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -360,7 +360,12 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>  				      struct buffer_head *bh)
>  {
>  	ext4_fsblk_t	blk;
> -	struct ext4_group_info *grp = ext4_get_group_info(sb, block_group);
> +	struct ext4_group_info *grp;
> +
> +	if (EXT4_SB(sb)->s_fc_replay)
> +		return 0;

Instead of adding a bool (s_fc_replay) to sbi, why not just use
sbi->s_mount_state and define a new bit, EXT4_REPLAY_FC (alongside
EXT4_ORPHAN_FS, et. al)?

> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index fd7740372438..12d6e70bf676 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c

> +int ext4_fc_create_inode(struct super_block *sb, struct ext4_inode *raw_inode,
> +			 int ino, unsigned long parent, const char *dname,
> +			 int dlen)
> +{
> +	struct inode *dir = NULL, *inode = NULL;
> +	struct dentry *dentry_dir = NULL, *dentry_inode = NULL;
> +	struct qstr qstr_dname = QSTR_INIT(dname, dlen);
> +	struct ext4_dir_entry_2 *res_dir = NULL;
> +	struct buffer_head *dirent_bh;
> +	int ret = 0, inlined;
> +
	...
> +		if (le32_to_cpu(res_dir->inode) != inode->i_ino) {
> +			jbd_debug(1, "Entry exists and mismatched inode nos.");
> +			brelse(dirent_bh);
> +			ret = -EEXIST;
> +			goto out;


We have a number of statements where ret gets set to an error, but
then when look at what happens after the out label...

> +out:
	...
> +
> +	return 0;
> +}

It always returns 0; I think we should be returning ret?


> +static int ext4_journal_fc_replay_cb(journal_t *journal, struct buffer_head *bh,
> +				     enum passtype pass, int off)
> +{
> +	struct super_block *sb = journal->j_private;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_fc_commit_hdr *fc_hdr;
> +	struct ext4_fc_tl *tl;
> +	struct ext4_iloc iloc;
> +	struct ext4_extent *ex;
> +	struct inode *inode;
> +	char *dname = NULL;
> +	int dname_len = 0;
> +	int parent_ino = -1;
> +	int i, j, ret;
> +
> +	if (pass == PASS_SCAN)
> +		return ext4_journal_fc_replay_scan(sb, bh, off);
> +
> +	if (sbi->s_fc_replay_state.fc_replay_error) {
> +		jbd_debug(1, "FC replay error set = %d\n",
> +			  sbi->s_fc_replay_state.fc_replay_error);
> +		return sbi->s_fc_replay_state.fc_replay_error;
> +	}
> +
> +	sbi->s_fc_replay = true;
> +	fc_hdr = (struct ext4_fc_commit_hdr *)
> +		  ((__u8 *)bh->b_data + sizeof(journal_header_t));
> +
> +	jbd_debug(3, "%s: Got FC block for inode %d at [%d,%d]", __func__,
> +		  le32_to_cpu(fc_hdr->fc_ino),
> +		  be32_to_cpu(((journal_header_t *)bh->b_data)->h_sequence),
> +		  le32_to_cpu(fc_hdr->fc_subtid));
> +
> +	tl = (struct ext4_fc_tl *)(fc_hdr + 1);
> +	if (le16_to_cpu(fc_hdr->fc_num_tlvs) >= 2) {
> +		for (i = 0; i < 2; i++) {
> +			switch (le16_to_cpu(tl->fc_tag)) {
> +			case EXT4_FC_TAG_DNAME:
> +				dname = fc_tag_val(tl);
> +				dname_len = fc_tag_len(tl);
> +				break;
> +			case EXT4_FC_TAG_PARENT_INO:
> +				parent_ino = le32_to_cpu(
> +				    *(__le32 *)fc_tag_val(tl));
> +				break;
> +			}
> +			tl = (struct ext4_fc_tl *)(fc_tag_val(tl) +
> +						   fc_tag_len(tl));
> +		}
> +	}
> +
> +	if (parent_ino && dname) {
> +		ret = ext4_fc_create_inode(sb, &fc_hdr->inode,
> +				     le32_to_cpu(fc_hdr->fc_ino), parent_ino,
> +				     dname, dname_len);
> +		if (ret) {
> +			jbd_debug(1, "Failed to create ext4 inode.");
> +			return ret;
> +		}
> +	}
> +
> +	inode = ext4_iget(sb, le32_to_cpu(fc_hdr->fc_ino), EXT4_IGET_NORMAL);
> +	if (IS_ERR(inode))
> +		return 0;
> +
> +	ret = ext4_get_inode_loc(inode, &iloc);
> +	if (ret)
> +		return ret;
> +
> +	inode_lock(inode);
> +	tl = (struct ext4_fc_tl *)(fc_hdr + 1);
> +	for (i = 0; i < le16_to_cpu(fc_hdr->fc_num_tlvs); i++) {
> +		switch (le16_to_cpu(tl->fc_tag)) {
> +		case EXT4_FC_TAG_EXT:
> +			ex = (struct ext4_extent *)(tl + 1);
> +			/*
> +			 * We add block by block because part of extent may
> +			 * already have been added by a previous fast commit
> +			 * replay.
> +			 */
> +			for (j = 0; j < ext4_ext_get_actual_len(ex); j++)
> +				ext4_fc_add_block(inode,
> +						  le32_to_cpu(ex->ee_block) + j,
> +						  ext4_ext_pblock(ex) + j,
> +						  ext4_ext_is_unwritten(ex));
> +			break;
> +		case EXT4_FC_TAG_PARENT_INO:
> +		case EXT4_FC_TAG_DNAME:
> +			break;
> +		default:
> +			jbd_debug(1, "Unknown tag found.\n");
> +		}
> +		tl = (struct ext4_fc_tl *)((__u8 *)tl +
> +					   le16_to_cpu(tl->fc_len) +
> +					   sizeof(*tl));
> +	}
> +	ext4_reserve_inode_write(NULL, inode, &iloc);
> +	inode_unlock(inode);
> +
> +	/*
> +	 * Unless inode contains inline data, copy everything except
> +	 * i_blocks. i_blocks would have been set alright by ext4_fc_add_block
> +	 * call above.
> +	 */
> +	if (ext4_has_inline_data(inode)) {
> +		memcpy(ext4_raw_inode(&iloc), &fc_hdr->inode,
> +		       sizeof(struct ext4_inode));
> +	} else {
> +		memcpy(ext4_raw_inode(&iloc), &fc_hdr->inode,
> +		       offsetof(struct ext4_inode, i_block));
> +		memcpy(&ext4_raw_inode(&iloc)->i_generation,
> +		       &fc_hdr->inode.i_generation,
> +		       sizeof(struct ext4_inode) -
> +		       offsetof(struct ext4_inode, i_generation));
> +	}
> +	inode->i_generation = le32_to_cpu(ext4_raw_inode(&iloc)->i_generation);
> +	ext4_reset_inode_seed(inode);
> +
> +	ext4_inode_csum_set(inode, ext4_raw_inode(&iloc), EXT4_I(inode));
> +	ret = ext4_handle_dirty_metadata(NULL, inode, iloc.bh);
> +	brelse(iloc.bh);
> +	iput(inode);
> +	if (!ret)
> +		ret = blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
> +
> +	sbi->s_fc_replay = false;
> +
> +	return ret;
> +}
> +
>  void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
>  {
>  	if (ext4_should_fast_commit(sb)) {
>  		journal->j_fc_commit_callback = ext4_journal_fc_commit_cb;
>  		journal->j_fc_cleanup_callback = ext4_journal_fc_cleanup_cb;
>  	}
> +
> +	/*
> +	 * We set replay callback even if fast commit disabled because we may
> +	 * could still have fast commit blocks that need to be replayed even if
> +	 * fast commit has now been turned off.
> +	 */
> +	journal->j_fc_replay_callback = ext4_journal_fc_replay_cb;
>  }
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index dea4c2632272..d70c09cbbc3f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2903,9 +2903,11 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>  	ext_debug("truncate since %u to %u\n", start, end);
>  
>  	/* probably first extent we're gonna free will be last in block */
> -	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, depth + 1);
> -	if (IS_ERR(handle))
> -		return PTR_ERR(handle);
> +	if (!sbi->s_fc_replay) {
> +		handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, depth + 1);
> +		if (IS_ERR(handle))
> +			return PTR_ERR(handle);
> +	}


I'm curious; what fast commits will result in our needing to call
ext4_ext_remove_space?  I thought we weren't supporting truncate,
punch hole, etc.

> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 47d04a33a3ca..d32dea0757fe 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -287,15 +292,17 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
	...
> +	if (!sbi->s_fc_replay) {
> +		grp = ext4_get_group_info(sb, block_group);
> +		if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
> +			fatal = -EFSCORRUPTED;
> +			goto error_return;

And ditto for ext4_free_inode?

> @@ -758,7 +765,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,

And I'm surprised we're want to use ext4_new_inode for fast commit,
since for fast commit, we already know what inode number should be
used for a newly created file.  ext4_new_inode() is going to be
searching for what inode to allocate which we wouldn't need to do for
fast_commit, no?

						- Ted
