Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3713B8689
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 17:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhF3P5J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 11:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235743AbhF3P5I (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 11:57:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0063861396;
        Wed, 30 Jun 2021 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625068479;
        bh=qlYyhBvmHsTpPy3I9pj0pIlgn5j/xaDWpd7eannfSK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGDAol1AoqycvJKcpsT6VIkggwZ0AMUmDDcHfs1OziqQdRI7IbegZqYDoMC2uPMHO
         lquXzbZZgYof2iVXGTQvTD0TrECh1gAWc2Q35g3VvlEvyJwvVObGcwiipnkAmpBk7R
         30kbRyDA8HLp0n4MhLXmstfmzWm0pAKMWDHfNedKSMSlMTyB5doOy6uXB3bwqvcBGb
         t1oIRBxN0i/t8Cq091e9+5aQvGMP1wEat4lkt2njNL+k5vR72sE7F7VBhhgC63MIQo
         jcq60RSlbSgGDclu7Mt3xLmSA59R0lxB+YqKbBz4EYt/JzuMS7DXXfON6WTVswD7UC
         vyL4EN4J6yozQ==
Date:   Wed, 30 Jun 2021 08:54:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] ext4: Speedup ext4 orphan inode handling
Message-ID: <20210630155438.GD13743@locust>
References: <20210616105655.5129-1-jack@suse.cz>
 <20210616105655.5129-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616105655.5129-4-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 16, 2021 at 12:56:54PM +0200, Jan Kara wrote:
> Ext4 orphan inode handling is a bottleneck for workloads which heavily
> truncate / unlink small files since it contends on the global
> s_orphan_mutex lock (and generally it's difficult to improve scalability
> of the ondisk linked list of orphaned inodes).
> 
> This patch implements new way of handling orphan inodes. Instead of
> linking orphaned inode into a linked list, we store it's inode number in
> a new special file which we call "orphan file". Currently we still
> protect the orphan file with a spinlock for simplicity but even in this
> setting we can substantially reduce the length of the critical section
> and thus speedup some workloads.
> 
> Note that the change is backwards compatible when the filesystem is
> clean - the existence of the orphan file is a compat feature, we set
> another ro-compat feature indicating orphan file needs scanning for
> orphaned inodes when mounting filesystem read-write. This ro-compat
> feature gets cleared on unmount / remount read-only.
> 
> Some performance data from 80 CPU Xeon Server with 512 GB of RAM,
> filesystem located on SSD, average of 5 runs:
> 
> stress-orphan (microbenchmark truncating files byte-by-byte from N
> processes in parallel)
> 
> Threads Time            Time
>         Vanilla         Patched
>   1       1.057200        0.945600
>   2       1.680400        1.331800
>   4       2.547000        1.995000
>   8       7.049400        6.424200
>  16      14.827800       14.937600
>  32      40.948200       33.038200
>  64      87.787400       60.823600
> 128     206.504000      122.941400
> 
> So we can see significant wins all over the board.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/ext4.h   |  70 +++++++++--
>  fs/ext4/orphan.c | 319 ++++++++++++++++++++++++++++++++++++++++++-----
>  fs/ext4/super.c  |  34 ++++-
>  3 files changed, 379 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 33508487516f..83298c0b6dae 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1025,7 +1025,14 @@ struct ext4_inode_info {
>  	 */
>  	struct rw_semaphore xattr_sem;
>  
> -	struct list_head i_orphan;	/* unlinked but open inodes */
> +	/*
> +	 * Inodes with EXT4_STATE_ORPHAN_FILE use i_orphan_idx. Otherwise
> +	 * i_orphan is used.
> +	 */
> +	union {
> +		struct list_head i_orphan;	/* unlinked but open inodes */
> +		unsigned int i_orphan_idx;	/* Index in orphan file */
> +	};
>  
>  	/* Fast commit related info */
>  
> @@ -1419,7 +1426,8 @@ struct ext4_super_block {
>  	__u8    s_last_error_errcode;
>  	__le16  s_encoding;		/* Filename charset encoding */
>  	__le16  s_encoding_flags;	/* Filename charset encoding flags */
> -	__le32	s_reserved[95];		/* Padding to the end of the block */
> +	__le32  s_orphan_file_inum;	/* Inode for tracking orphan inodes */
> +	__le32	s_reserved[94];		/* Padding to the end of the block */
>  	__le32	s_checksum;		/* crc32c(superblock) */
>  };
>  
> @@ -1440,6 +1448,7 @@ struct ext4_super_block {
>  
>  /* Types of ext4 journal triggers */
>  enum ext4_journal_trigger_type {
> +	EXT4_JTR_ORPHAN_FILE,
>  	EXT4_JTR_NONE	/* This must be the last entry for indexing to work! */
>  };
>  
> @@ -1456,6 +1465,36 @@ static inline struct ext4_journal_trigger *EXT4_TRIGGER(
>  	return container_of(trigger, struct ext4_journal_trigger, tr_triggers);
>  }
>  
> +#define EXT4_ORPHAN_BLOCK_MAGIC 0x0b10ca04
> +
> +/* Structure at the tail of orphan block */
> +struct ext4_orphan_block_tail {
> +	__le32 ob_magic;
> +	__le32 ob_checksum;
> +};

Can you add the ondisk format changes to the appropriate place in
Documentation/filesystems/ext4/ please?

--D

> +
> +static inline int ext4_inodes_per_orphan_block(struct super_block *sb)
> +{
> +	return (sb->s_blocksize - sizeof(struct ext4_orphan_block_tail)) /
> +			sizeof(u32);
> +}
> +
> +struct ext4_orphan_block {
> +	int ob_free_entries;	/* Number of free orphan entries in block */
> +	struct buffer_head *ob_bh;	/* Buffer for orphan block */
> +};
> +
> +/*
> + * Info about orphan file.
> + */
> +struct ext4_orphan_info {
> +	spinlock_t of_lock;
> +	int of_blocks;			/* Number of orphan blocks in a file */
> +	__u32 of_csum_seed;		/* Checksum seed for orphan file */
> +	struct ext4_orphan_block *of_binfo;	/* Array with info about orphan
> +						 * file blocks */
> +};
> +
>  /*
>   * fourth extended-fs super-block data in memory
>   */
> @@ -1509,9 +1548,11 @@ struct ext4_sb_info {
>  
>  	/* Journaling */
>  	struct journal_s *s_journal;
> -	struct list_head s_orphan;
> -	struct mutex s_orphan_lock;
>  	unsigned long s_ext4_flags;		/* Ext4 superblock flags */
> +	struct mutex s_orphan_lock;	/* Protects on disk list changes */
> +	struct list_head s_orphan;	/* List of orphaned inodes in on disk
> +					   list */
> +	struct ext4_orphan_info s_orphan_info;
>  	unsigned long s_commit_interval;
>  	u32 s_max_batch_time;
>  	u32 s_min_batch_time;
> @@ -1846,6 +1887,7 @@ enum {
>  	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
>  	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
>  	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
> +	EXT4_STATE_ORPHAN_FILE,		/* Inode orphaned in orphan file */
>  };
>  
>  #define EXT4_INODE_BIT_FNS(name, field, offset)				\
> @@ -1947,6 +1989,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
>   */
>  #define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
>  #define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
> +#define EXT4_FEATURE_COMPAT_ORPHAN_FILE		0x1000	/* Orphan file exists */
>  
>  #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
>  #define EXT4_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
> @@ -1955,6 +1998,8 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
>  #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM		0x0010
>  #define EXT4_FEATURE_RO_COMPAT_DIR_NLINK	0x0020
>  #define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE	0x0040
> +#define EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT	0x0080 /* Orphan file may be
> +							  non-empty */
>  #define EXT4_FEATURE_RO_COMPAT_QUOTA		0x0100
>  #define EXT4_FEATURE_RO_COMPAT_BIGALLOC		0x0200
>  /*
> @@ -1964,6 +2009,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
>   * GDT_CSUM bits are mutually exclusive.
>   */
>  #define EXT4_FEATURE_RO_COMPAT_METADATA_CSUM	0x0400
> +/* 0x0800 Reserved for EXT4_FEATURE_RO_COMPAT_REPLICA */
>  #define EXT4_FEATURE_RO_COMPAT_READONLY		0x1000
>  #define EXT4_FEATURE_RO_COMPAT_PROJECT		0x2000
>  #define EXT4_FEATURE_RO_COMPAT_VERITY		0x8000
> @@ -2050,6 +2096,7 @@ EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
>  EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
>  EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		FAST_COMMIT)
>  EXT4_FEATURE_COMPAT_FUNCS(stable_inodes,	STABLE_INODES)
> +EXT4_FEATURE_COMPAT_FUNCS(orphan_file,		ORPHAN_FILE)
>  
>  EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
>  EXT4_FEATURE_RO_COMPAT_FUNCS(large_file,	LARGE_FILE)
> @@ -2064,6 +2111,7 @@ EXT4_FEATURE_RO_COMPAT_FUNCS(metadata_csum,	METADATA_CSUM)
>  EXT4_FEATURE_RO_COMPAT_FUNCS(readonly,		READONLY)
>  EXT4_FEATURE_RO_COMPAT_FUNCS(project,		PROJECT)
>  EXT4_FEATURE_RO_COMPAT_FUNCS(verity,		VERITY)
> +EXT4_FEATURE_RO_COMPAT_FUNCS(orphan_present,	ORPHAN_PRESENT)
>  
>  EXT4_FEATURE_INCOMPAT_FUNCS(compression,	COMPRESSION)
>  EXT4_FEATURE_INCOMPAT_FUNCS(filetype,		FILETYPE)
> @@ -2097,7 +2145,8 @@ EXT4_FEATURE_INCOMPAT_FUNCS(casefold,		CASEFOLD)
>  					 EXT4_FEATURE_RO_COMPAT_LARGE_FILE| \
>  					 EXT4_FEATURE_RO_COMPAT_BTREE_DIR)
>  
> -#define EXT4_FEATURE_COMPAT_SUPP	EXT4_FEATURE_COMPAT_EXT_ATTR
> +#define EXT4_FEATURE_COMPAT_SUPP	(EXT4_FEATURE_COMPAT_EXT_ATTR| \
> +					 EXT4_FEATURE_COMPAT_ORPHAN_FILE)
>  #define EXT4_FEATURE_INCOMPAT_SUPP	(EXT4_FEATURE_INCOMPAT_FILETYPE| \
>  					 EXT4_FEATURE_INCOMPAT_RECOVER| \
>  					 EXT4_FEATURE_INCOMPAT_META_BG| \
> @@ -2122,7 +2171,8 @@ EXT4_FEATURE_INCOMPAT_FUNCS(casefold,		CASEFOLD)
>  					 EXT4_FEATURE_RO_COMPAT_METADATA_CSUM|\
>  					 EXT4_FEATURE_RO_COMPAT_QUOTA |\
>  					 EXT4_FEATURE_RO_COMPAT_PROJECT |\
> -					 EXT4_FEATURE_RO_COMPAT_VERITY)
> +					 EXT4_FEATURE_RO_COMPAT_VERITY |\
> +					 EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT)
>  
>  #define EXTN_FEATURE_FUNCS(ver) \
>  static inline bool ext4_has_unknown_ext##ver##_compat_features(struct super_block *sb) \
> @@ -2172,7 +2222,6 @@ static inline int ext4_forced_shutdown(struct ext4_sb_info *sbi)
>  	return test_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
>  }
>  
> -
>  /*
>   * Default values for user and/or group using reserved blocks
>   */
> @@ -3751,6 +3800,13 @@ extern int ext4_orphan_add(handle_t *, struct inode *);
>  extern int ext4_orphan_del(handle_t *, struct inode *);
>  extern void ext4_orphan_cleanup(struct super_block *sb,
>  				struct ext4_super_block *es);
> +extern void ext4_release_orphan_info(struct super_block *sb);
> +extern int ext4_init_orphan_info(struct super_block *sb);
> +extern int ext4_orphan_file_empty(struct super_block *sb);
> +extern void ext4_orphan_file_block_trigger(
> +				struct jbd2_buffer_trigger_type *triggers,
> +				struct buffer_head *bh,
> +				void *data, size_t size);
>  
>  /*
>   * Add new method to test whether block and inode bitmaps are properly
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index 732b16ef655b..ac22667b7fd5 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -8,6 +8,52 @@
>  #include "ext4.h"
>  #include "ext4_jbd2.h"
>  
> +static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
> +{
> +	int i, j;
> +	struct ext4_orphan_info *oi = &EXT4_SB(inode->i_sb)->s_orphan_info;
> +	int ret = 0;
> +	__le32 *bdata;
> +	int inodes_per_ob = ext4_inodes_per_orphan_block(inode->i_sb);
> +
> +	spin_lock(&oi->of_lock);
> +	for (i = 0; i < oi->of_blocks && !oi->of_binfo[i].ob_free_entries; i++);
> +	if (i == oi->of_blocks) {
> +		spin_unlock(&oi->of_lock);
> +		/*
> +		 * For now we don't grow or shrink orphan file. We just use
> +		 * whatever was allocated at mke2fs time. The additional
> +		 * credits we would have to reserve for each orphan inode
> +		 * operation just don't seem worth it.
> +		 */
> +		return -ENOSPC;
> +	}
> +	oi->of_binfo[i].ob_free_entries--;
> +	spin_unlock(&oi->of_lock);
> +
> +	/*
> +	 * Get access to orphan block. We have dropped of_lock but since we
> +	 * have decremented number of free entries we are guaranteed free entry
> +	 * in our block.
> +	 */
> +	ret = ext4_journal_get_write_access(handle, inode->i_sb,
> +				oi->of_binfo[i].ob_bh, EXT4_JTR_ORPHAN_FILE);
> +	if (ret)
> +		return ret;
> +
> +	bdata = (__le32 *)(oi->of_binfo[i].ob_bh->b_data);
> +	spin_lock(&oi->of_lock);
> +	/* Find empty slot in a block */
> +	for (j = 0; j < inodes_per_ob && bdata[j]; j++);
> +	BUG_ON(j == inodes_per_ob);
> +	bdata[j] = cpu_to_le32(inode->i_ino);
> +	EXT4_I(inode)->i_orphan_idx = i * inodes_per_ob + j;
> +	ext4_set_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
> +	spin_unlock(&oi->of_lock);
> +
> +	return ext4_handle_dirty_metadata(handle, NULL, oi->of_binfo[i].ob_bh);
> +}
> +
>  /*
>   * ext4_orphan_add() links an unlinked or truncated inode into a list of
>   * such inodes, starting at the superblock, in case we crash before the
> @@ -34,10 +80,10 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
>  	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
>  		     !inode_is_locked(inode));
>  	/*
> -	 * Exit early if inode already is on orphan list. This is a big speedup
> -	 * since we don't have to contend on the global s_orphan_lock.
> +	 * Inode orphaned in orphan file or in orphan list?
>  	 */
> -	if (!list_empty(&EXT4_I(inode)->i_orphan))
> +	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> +	    !list_empty(&EXT4_I(inode)->i_orphan))
>  		return 0;
>  
>  	/*
> @@ -49,6 +95,16 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
>  	ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>  		  S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
>  
> +	if (sbi->s_orphan_info.of_blocks) {
> +		err = ext4_orphan_file_add(handle, inode);
> +		/*
> +		 * Fallback to normal orphan list of orphan file is
> +		 * out of space
> +		 */
> +		if (err != -ENOSPC)
> +			return err;
> +	}
> +
>  	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
>  	err = ext4_journal_get_write_access(handle, sb, sbi->s_sbh,
>  					    EXT4_JTR_NONE);
> @@ -103,6 +159,37 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
>  	return err;
>  }
>  
> +static int ext4_orphan_file_del(handle_t *handle, struct inode *inode)
> +{
> +	struct ext4_orphan_info *oi = &EXT4_SB(inode->i_sb)->s_orphan_info;
> +	__le32 *bdata;
> +	int blk, off;
> +	int inodes_per_ob = ext4_inodes_per_orphan_block(inode->i_sb);
> +	int ret = 0;
> +
> +	if (!handle)
> +		goto out;
> +	blk = EXT4_I(inode)->i_orphan_idx / inodes_per_ob;
> +	off = EXT4_I(inode)->i_orphan_idx % inodes_per_ob;
> +
> +	ret = ext4_journal_get_write_access(handle, inode->i_sb,
> +				oi->of_binfo[blk].ob_bh, EXT4_JTR_ORPHAN_FILE);
> +	if (ret)
> +		goto out;
> +
> +	bdata = (__le32 *)(oi->of_binfo[blk].ob_bh->b_data);
> +	spin_lock(&oi->of_lock);
> +	bdata[off] = 0;
> +	oi->of_binfo[blk].ob_free_entries++;
> +	spin_unlock(&oi->of_lock);
> +	ret = ext4_handle_dirty_metadata(handle, NULL, oi->of_binfo[blk].ob_bh);
> +out:
> +	ext4_clear_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
> +	INIT_LIST_HEAD(&EXT4_I(inode)->i_orphan);
> +
> +	return ret;
> +}
> +
>  /*
>   * ext4_orphan_del() removes an unlinked or truncated inode from the list
>   * of such inodes stored on disk, because it is finally being cleaned up.
> @@ -121,6 +208,9 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
>  
>  	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
>  		     !inode_is_locked(inode));
> +	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
> +		return ext4_orphan_file_del(handle, inode);
> +
>  	/* Do this quick check before taking global s_orphan_lock. */
>  	if (list_empty(&ei->i_orphan))
>  		return 0;
> @@ -196,6 +286,39 @@ static int ext4_quota_on_mount(struct super_block *sb, int type)
>  					EXT4_SB(sb)->s_jquota_fmt, type);
>  }
>  
> +static void ext4_process_orphan(struct inode *inode,
> +				int *nr_truncates, int *nr_orphans)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	int ret;
> +
> +	dquot_initialize(inode);
> +	if (inode->i_nlink) {
> +		if (test_opt(sb, DEBUG))
> +			ext4_msg(sb, KERN_DEBUG,
> +				"%s: truncating inode %lu to %lld bytes",
> +				__func__, inode->i_ino, inode->i_size);
> +		jbd_debug(2, "truncating inode %lu to %lld bytes\n",
> +			  inode->i_ino, inode->i_size);
> +		inode_lock(inode);
> +		truncate_inode_pages(inode->i_mapping, inode->i_size);
> +		ret = ext4_truncate(inode);
> +		if (ret)
> +			ext4_std_error(inode->i_sb, ret);
> +		inode_unlock(inode);
> +		(*nr_truncates)++;
> +	} else {
> +		if (test_opt(sb, DEBUG))
> +			ext4_msg(sb, KERN_DEBUG,
> +				"%s: deleting unreferenced inode %lu",
> +				__func__, inode->i_ino);
> +		jbd_debug(2, "deleting unreferenced inode %lu\n",
> +			  inode->i_ino);
> +		(*nr_orphans)++;
> +	}
> +	iput(inode);  /* The delete magic happens here! */
> +}
> +
>  /* ext4_orphan_cleanup() walks a singly-linked list of inodes (starting at
>   * the superblock) which were deleted from all directories, but held open by
>   * a process at the time of a crash.  We walk the list and try to delete these
> @@ -216,12 +339,17 @@ static int ext4_quota_on_mount(struct super_block *sb, int type)
>  void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
>  {
>  	unsigned int s_flags = sb->s_flags;
> -	int ret, nr_orphans = 0, nr_truncates = 0;
> +	int nr_orphans = 0, nr_truncates = 0;
> +	struct inode *inode;
> +	int i, j;
>  #ifdef CONFIG_QUOTA
>  	int quota_update = 0;
> -	int i;
>  #endif
> -	if (!es->s_last_orphan) {
> +	__le32 *bdata;
> +	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
> +	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
> +
> +	if (!es->s_last_orphan && !oi->of_blocks) {
>  		jbd_debug(4, "no orphan inodes to clean up\n");
>  		return;
>  	}
> @@ -285,8 +413,6 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
>  #endif
>  
>  	while (es->s_last_orphan) {
> -		struct inode *inode;
> -
>  		/*
>  		 * We may have encountered an error during cleanup; if
>  		 * so, skip the rest.
> @@ -304,31 +430,21 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
>  		}
>  
>  		list_add(&EXT4_I(inode)->i_orphan, &EXT4_SB(sb)->s_orphan);
> -		dquot_initialize(inode);
> -		if (inode->i_nlink) {
> -			if (test_opt(sb, DEBUG))
> -				ext4_msg(sb, KERN_DEBUG,
> -					"%s: truncating inode %lu to %lld bytes",
> -					__func__, inode->i_ino, inode->i_size);
> -			jbd_debug(2, "truncating inode %lu to %lld bytes\n",
> -				  inode->i_ino, inode->i_size);
> -			inode_lock(inode);
> -			truncate_inode_pages(inode->i_mapping, inode->i_size);
> -			ret = ext4_truncate(inode);
> -			if (ret)
> -				ext4_std_error(inode->i_sb, ret);
> -			inode_unlock(inode);
> -			nr_truncates++;
> -		} else {
> -			if (test_opt(sb, DEBUG))
> -				ext4_msg(sb, KERN_DEBUG,
> -					"%s: deleting unreferenced inode %lu",
> -					__func__, inode->i_ino);
> -			jbd_debug(2, "deleting unreferenced inode %lu\n",
> -				  inode->i_ino);
> -			nr_orphans++;
> +		ext4_process_orphan(inode, &nr_truncates, &nr_orphans);
> +	}
> +
> +	for (i = 0; i < oi->of_blocks; i++) {
> +		bdata = (__le32 *)(oi->of_binfo[i].ob_bh->b_data);
> +		for (j = 0; j < inodes_per_ob; j++) {
> +			if (!bdata[j])
> +				continue;
> +			inode = ext4_orphan_get(sb, le32_to_cpu(bdata[j]));
> +			if (IS_ERR(inode))
> +				continue;
> +			ext4_set_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
> +			EXT4_I(inode)->i_orphan_idx = i * inodes_per_ob + j;
> +			ext4_process_orphan(inode, &nr_truncates, &nr_orphans);
>  		}
> -		iput(inode);  /* The delete magic happens here! */
>  	}
>  
>  #define PLURAL(x) (x), ((x) == 1) ? "" : "s"
> @@ -350,3 +466,142 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
>  #endif
>  	sb->s_flags = s_flags; /* Restore SB_RDONLY status */
>  }
> +
> +void ext4_release_orphan_info(struct super_block *sb)
> +{
> +	int i;
> +	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
> +
> +	if (!oi->of_blocks)
> +		return;
> +	for (i = 0; i < oi->of_blocks; i++)
> +		brelse(oi->of_binfo[i].ob_bh);
> +	kfree(oi->of_binfo);
> +}
> +
> +static struct ext4_orphan_block_tail *ext4_orphan_block_tail(
> +						struct super_block *sb,
> +						struct buffer_head *bh)
> +{
> +	return (struct ext4_orphan_block_tail *)(bh->b_data + sb->s_blocksize -
> +				sizeof(struct ext4_orphan_block_tail));
> +}
> +
> +static int ext4_orphan_file_block_csum_verify(struct super_block *sb,
> +					      struct buffer_head *bh)
> +{
> +	__u32 calculated;
> +	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
> +	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
> +	struct ext4_orphan_block_tail *ot;
> +
> +	if (!ext4_has_metadata_csum(sb))
> +		return 1;
> +
> +	ot = ext4_orphan_block_tail(sb, bh);
> +	calculated = ext4_chksum(EXT4_SB(sb), oi->of_csum_seed,
> +				 (__u8 *)bh->b_data,
> +				 inodes_per_ob * sizeof(__u32));
> +	return le32_to_cpu(ot->ob_checksum) == calculated;
> +}
> +
> +/* This gets called only when checksumming is enabled */
> +void ext4_orphan_file_block_trigger(struct jbd2_buffer_trigger_type *triggers,
> +				    struct buffer_head *bh,
> +				    void *data, size_t size)
> +{
> +	struct super_block *sb = EXT4_TRIGGER(triggers)->sb;
> +	__u32 csum;
> +	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
> +	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
> +	struct ext4_orphan_block_tail *ot;
> +
> +	csum = ext4_chksum(EXT4_SB(sb), oi->of_csum_seed, (__u8 *)data,
> +			   inodes_per_ob * sizeof(__u32));
> +	ot = ext4_orphan_block_tail(sb, bh);
> +	ot->ob_checksum = cpu_to_le32(csum);
> +}
> +
> +int ext4_init_orphan_info(struct super_block *sb)
> +{
> +	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
> +	struct inode *inode;
> +	int i, j;
> +	int ret;
> +	int free;
> +	__le32 *bdata;
> +	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
> +	struct ext4_orphan_block_tail *ot;
> +	ino_t orphan_ino = le32_to_cpu(EXT4_SB(sb)->s_es->s_orphan_file_inum);
> +
> +	spin_lock_init(&oi->of_lock);
> +
> +	if (!ext4_has_feature_orphan_file(sb))
> +		return 0;
> +
> +	inode = ext4_iget(sb, orphan_ino, EXT4_IGET_NORMAL);
> +	if (IS_ERR(inode)) {
> +		ext4_msg(sb, KERN_ERR, "get orphan inode failed");
> +		return PTR_ERR(inode);
> +	}
> +	oi->of_blocks = inode->i_size >> sb->s_blocksize_bits;
> +	oi->of_csum_seed = EXT4_I(inode)->i_csum_seed;
> +	oi->of_binfo = kmalloc(oi->of_blocks*sizeof(struct ext4_orphan_block),
> +			       GFP_KERNEL);
> +	if (!oi->of_binfo) {
> +		ret = -ENOMEM;
> +		goto out_put;
> +	}
> +	for (i = 0; i < oi->of_blocks; i++) {
> +		oi->of_binfo[i].ob_bh = ext4_bread(NULL, inode, i, 0);
> +		if (IS_ERR(oi->of_binfo[i].ob_bh)) {
> +			ret = PTR_ERR(oi->of_binfo[i].ob_bh);
> +			goto out_free;
> +		}
> +		if (!oi->of_binfo[i].ob_bh) {
> +			ret = -EIO;
> +			goto out_free;
> +		}
> +		ot = ext4_orphan_block_tail(sb, oi->of_binfo[i].ob_bh);
> +		if (le32_to_cpu(ot->ob_magic) != EXT4_ORPHAN_BLOCK_MAGIC) {
> +			ext4_error(sb, "orphan file block %d: bad magic", i);
> +			ret = -EIO;
> +			goto out_free;
> +		}
> +		if (!ext4_orphan_file_block_csum_verify(sb,
> +						oi->of_binfo[i].ob_bh)) {
> +			ext4_error(sb, "orphan file block %d: bad checksum", i);
> +			ret = -EIO;
> +			goto out_free;
> +		}
> +		bdata = (__le32 *)(oi->of_binfo[i].ob_bh->b_data);
> +		free = 0;
> +		for (j = 0; j < inodes_per_ob; j++)
> +			if (bdata[j] == 0)
> +				free++;
> +		oi->of_binfo[i].ob_free_entries = free;
> +	}
> +	iput(inode);
> +	return 0;
> +out_free:
> +	for (i--; i >= 0; i--)
> +		brelse(oi->of_binfo[i].ob_bh);
> +	kfree(oi->of_binfo);
> +out_put:
> +	iput(inode);
> +	return ret;
> +}
> +
> +int ext4_orphan_file_empty(struct super_block *sb)
> +{
> +	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
> +	int i;
> +	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
> +
> +	if (!ext4_has_feature_orphan_file(sb))
> +		return 1;
> +	for (i = 0; i < oi->of_blocks; i++)
> +		if (oi->of_binfo[i].ob_free_entries != inodes_per_ob)
> +			return 0;
> +	return 1;
> +}
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6e43c8546dc5..06f63b0cd988 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1164,6 +1164,7 @@ static void ext4_put_super(struct super_block *sb)
>  
>  	flush_work(&sbi->s_error_work);
>  	destroy_workqueue(sbi->rsv_conversion_wq);
> +	ext4_release_orphan_info(sb);
>  
>  	/*
>  	 * Unregister sysfs before destroying jbd2 journal.
> @@ -1189,6 +1190,7 @@ static void ext4_put_super(struct super_block *sb)
>  
>  	if (!sb_rdonly(sb) && !aborted) {
>  		ext4_clear_feature_journal_needs_recovery(sb);
> +		ext4_clear_feature_orphan_present(sb);
>  		es->s_state = cpu_to_le16(sbi->s_mount_state);
>  	}
>  	if (!sb_rdonly(sb))
> @@ -2695,8 +2697,11 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
>  		es->s_max_mnt_count = cpu_to_le16(EXT4_DFL_MAX_MNT_COUNT);
>  	le16_add_cpu(&es->s_mnt_count, 1);
>  	ext4_update_tstamp(es, s_mtime);
> -	if (sbi->s_journal)
> +	if (sbi->s_journal) {
>  		ext4_set_feature_journal_needs_recovery(sb);
> +		if (ext4_has_feature_orphan_file(sb))
> +			ext4_set_feature_orphan_present(sb);
> +	}
>  
>  	err = ext4_commit_super(sb);
>  done:
> @@ -3971,6 +3976,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		silent = 1;
>  		goto cantfind_ext4;
>  	}
> +	ext4_setup_csum_trigger(sb, EXT4_JTR_ORPHAN_FILE,
> +				ext4_orphan_file_block_trigger);
>  
>  	/* Load the checksum driver */
>  	sbi->s_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
> @@ -4635,6 +4642,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_root = NULL;
>  
>  	needs_recovery = (es->s_last_orphan != 0 ||
> +			  ext4_has_feature_orphan_present(sb) ||
>  			  ext4_has_feature_journal_needs_recovery(sb));
>  
>  	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb))
> @@ -4924,12 +4932,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	if (err)
>  		goto failed_mount7;
>  
> +	err = ext4_init_orphan_info(sb);
> +	if (err)
> +		goto failed_mount8;
>  #ifdef CONFIG_QUOTA
>  	/* Enable quota usage during mount. */
>  	if (ext4_has_feature_quota(sb) && !sb_rdonly(sb)) {
>  		err = ext4_enable_quotas(sb);
>  		if (err)
> -			goto failed_mount8;
> +			goto failed_mount9;
>  	}
>  #endif  /* CONFIG_QUOTA */
>  
> @@ -4948,7 +4959,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		ext4_msg(sb, KERN_INFO, "recovery complete");
>  		err = ext4_mark_recovery_complete(sb, es);
>  		if (err)
> -			goto failed_mount8;
> +			goto failed_mount9;
>  	}
>  	if (EXT4_SB(sb)->s_journal) {
>  		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
> @@ -4994,6 +5005,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
>  	goto failed_mount;
>  
> +failed_mount9:
> +	ext4_release_orphan_info(sb);
>  failed_mount8:
>  	ext4_unregister_sysfs(sb);
>  	kobject_put(&sbi->s_kobj);
> @@ -5505,8 +5518,15 @@ static int ext4_mark_recovery_complete(struct super_block *sb,
>  	if (err < 0)
>  		goto out;
>  
> -	if (ext4_has_feature_journal_needs_recovery(sb) && sb_rdonly(sb)) {
> +	if (sb_rdonly(sb) && (ext4_has_feature_journal_needs_recovery(sb) ||
> +	    ext4_has_feature_orphan_present(sb))) {
> +		if (!ext4_orphan_file_empty(sb)) {
> +			ext4_error(sb, "Orphan file not empty on read-only fs.");
> +			err = -EFSCORRUPTED;
> +			goto out;
> +		}
>  		ext4_clear_feature_journal_needs_recovery(sb);
> +		ext4_clear_feature_orphan_present(sb);
>  		ext4_commit_super(sb);
>  	}
>  out:
> @@ -5649,6 +5669,8 @@ static int ext4_freeze(struct super_block *sb)
>  
>  		/* Journal blocked and flushed, clear needs_recovery flag. */
>  		ext4_clear_feature_journal_needs_recovery(sb);
> +		if (ext4_orphan_file_empty(sb))
> +			ext4_clear_feature_orphan_present(sb);
>  	}
>  
>  	error = ext4_commit_super(sb);
> @@ -5671,6 +5693,8 @@ static int ext4_unfreeze(struct super_block *sb)
>  	if (EXT4_SB(sb)->s_journal) {
>  		/* Reset the needs_recovery flag before the fs is unlocked. */
>  		ext4_set_feature_journal_needs_recovery(sb);
> +		if (ext4_has_feature_orphan_file(sb))
> +			ext4_set_feature_orphan_present(sb);
>  	}
>  
>  	ext4_commit_super(sb);
> @@ -5876,7 +5900,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  			 * around from a previously readonly bdev mount,
>  			 * require a full umount/remount for now.
>  			 */
> -			if (es->s_last_orphan) {
> +			if (es->s_last_orphan || !ext4_orphan_file_empty(sb)) {
>  				ext4_msg(sb, KERN_WARNING, "Couldn't "
>  				       "remount RDWR because of unprocessed "
>  				       "orphan inode list.  Please "
> -- 
> 2.26.2
> 
