Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DD296CE4
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 12:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462403AbgJWKaU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 06:30:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:37348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462224AbgJWKaT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 23 Oct 2020 06:30:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E989AAE79;
        Fri, 23 Oct 2020 10:30:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8A7291E1348; Fri, 23 Oct 2020 12:30:13 +0200 (CEST)
Date:   Fri, 23 Oct 2020 12:30:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10 5/9] ext4: main fast-commit commit path
Message-ID: <20201023103013.GF25702@quack2.suse.cz>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-6-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015203802.3597742-6-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-10-20 13:37:57, Harshad Shirwadkar wrote:
> diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
> index 76f634d185f1..68aaed48315f 100644
> --- a/fs/ext4/acl.c
> +++ b/fs/ext4/acl.c
> @@ -242,6 +242,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
>  	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
> +	ext4_fc_start_update(inode);
>  
>  	if ((type == ACL_TYPE_ACCESS) && acl) {
>  		error = posix_acl_update_mode(inode, &mode, &acl);
> @@ -259,6 +260,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
>  	}
>  out_stop:
>  	ext4_journal_stop(handle);
> +	ext4_fc_stop_update(inode);
>  	if (error == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>  		goto retry;
>  	return error;
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2c412d32db0f..6b291cad72be 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1021,6 +1021,28 @@ struct ext4_inode_info {
>  
>  	struct list_head i_orphan;	/* unlinked but open inodes */
>  
> +	/* Fast commit related info */
> +
> +	struct list_head i_fc_list;	/*
> +					 * inodes that need fast commit
> +					 * protected by sbi->s_fc_lock.
> +					 */
> +
> +	/* Start of lblk range that needs to be committed in this fast commit */
> +	ext4_lblk_t i_fc_lblk_start;
> +
> +	/* End of lblk range that needs to be committed in this fast commit */
> +	ext4_lblk_t i_fc_lblk_len;
> +
> +	/* Number of ongoing updates on this inode */
> +	atomic_t  i_fc_updates;
> +
> +	/* Fast commit wait queue for this inode */
> +	wait_queue_head_t i_fc_wait;
> +
> +	/* Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len */
> +	struct mutex i_fc_lock;
> +
>  	/*
>  	 * i_disksize keeps track of what the inode size is ON DISK, not
>  	 * in memory.  During truncate, i_size is set to the new size by
> @@ -1141,6 +1163,10 @@ struct ext4_inode_info {
>  #define	EXT4_VALID_FS			0x0001	/* Unmounted cleanly */
>  #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
>  #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
> +#define EXT4_FC_INELIGIBLE		0x0008	/* Fast commit ineligible */
> +#define EXT4_FC_COMMITTING		0x0010	/* File system underoing a fast
	  ^^ please align these as the previous values
Also the names should have _FS suffix.

Now after more looking, these are actually used in s_mount_state which is
persistently stored on disk which is probably not what you want. You rather
want to use something like sbi->s_mount_flags for these?

And now that I also look at sbi->s_mount_flags, these should use atomic
bitops as currently they seem to be succeptible to RMW races (e.g. due to
EXT4_MF_MNTDIR_SAMPLED flag) and your flags also need the atomic behavior.
That would be a separate patch fixing this.

> +						 * commit.
> +						 */
>  
>  /*
>   * Misc. filesystem flags
> @@ -1613,6 +1639,30 @@ struct ext4_sb_info {
>  	/* Record the errseq of the backing block device */
>  	errseq_t s_bdev_wb_err;
>  	spinlock_t s_bdev_wb_lock;
> +
> +	/* Ext4 fast commit stuff */
> +	atomic_t s_fc_subtid;
> +	atomic_t s_fc_ineligible_updates;
> +	/*
> +	 * After commit starts, the main queue gets locked, and the further
> +	 * updates get added in the staging queue.
> +	 */
> +#define FC_Q_MAIN	0
> +#define FC_Q_STAGING	1
> +	struct list_head s_fc_q[2];	/* Inodes staged for fast commit
> +					 * that have data changes in them.
> +					 */
> +	struct list_head s_fc_dentry_q[2];	/* directory entry updates */
> +	unsigned int s_fc_bytes;
> +	/*
> +	 * Main fast commit lock. This lock protects accesses to the
> +	 * following fields:
> +	 * ei->i_fc_list, s_fc_dentry_q, s_fc_q, s_fc_bytes, s_fc_bh.
> +	 */
> +	spinlock_t s_fc_lock;
> +	struct buffer_head *s_fc_bh;
> +	struct ext4_fc_stats s_fc_stats;
> +	u64 s_fc_avg_commit_time;
>  };
>  
>  static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
> @@ -1723,6 +1773,7 @@ enum {
>  	EXT4_STATE_EXT_PRECACHED,	/* extents have been precached */
>  	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
>  	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
> +	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
>  };
>  
>  #define EXT4_INODE_BIT_FNS(name, field, offset)				\
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e46f3381ba4c..a2bb87d75500 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3723,6 +3723,7 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
>  	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
>  out:
>  	ext4_ext_show_leaf(inode, path);
> +	ext4_fc_track_range(inode, ee_block, ee_block + ee_len - 1);
>  	return err;
>  }
>  
> @@ -3794,6 +3795,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	if (*allocated > map->m_len)
>  		*allocated = map->m_len;
>  	map->m_len = *allocated;
> +	ext4_fc_track_range(inode, ee_block, ee_block + ee_len - 1);
>  	return 0;
>  }
>  
> @@ -4327,7 +4329,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	map->m_len = ar.len;
>  	allocated = map->m_len;
>  	ext4_ext_show_leaf(inode, path);
> -
> +	ext4_fc_track_range(inode, map->m_lblk, map->m_lblk + map->m_len - 1);
>  out:
>  	ext4_ext_drop_refs(path);
>  	kfree(path);
> @@ -4600,7 +4602,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	ret = ext4_mark_inode_dirty(handle, inode);
>  	if (unlikely(ret))
>  		goto out_handle;
> -
> +	ext4_fc_track_range(inode, offset >> inode->i_sb->s_blocksize_bits,
> +			(offset + len - 1) >> inode->i_sb->s_blocksize_bits);
>  	/* Zero out partial block at the edges of the range */
>  	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
>  	if (ret >= 0)
> @@ -4648,23 +4651,34 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
>  		     FALLOC_FL_INSERT_RANGE))
>  		return -EOPNOTSUPP;
> +	ext4_fc_track_range(inode, offset >> blkbits,
> +			(offset + len - 1) >> blkbits);
>  
> -	if (mode & FALLOC_FL_PUNCH_HOLE)
> -		return ext4_punch_hole(inode, offset, len);
> +	ext4_fc_start_update(inode);
> +
> +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> +		ret = ext4_punch_hole(inode, offset, len);
> +		goto exit;
> +	}
>  
>  	ret = ext4_convert_inline_data(inode);
>  	if (ret)
> -		return ret;
> +		goto exit;
>  
> -	if (mode & FALLOC_FL_COLLAPSE_RANGE)
> -		return ext4_collapse_range(inode, offset, len);
> -
> -	if (mode & FALLOC_FL_INSERT_RANGE)
> -		return ext4_insert_range(inode, offset, len);
> +	if (mode & FALLOC_FL_COLLAPSE_RANGE) {
> +		ret = ext4_collapse_range(inode, offset, len);
> +		goto exit;
> +	}
>  
> -	if (mode & FALLOC_FL_ZERO_RANGE)
> -		return ext4_zero_range(file, offset, len, mode);
> +	if (mode & FALLOC_FL_INSERT_RANGE) {
> +		ret = ext4_insert_range(inode, offset, len);
> +		goto exit;
> +	}
>  
> +	if (mode & FALLOC_FL_ZERO_RANGE) {
> +		ret = ext4_zero_range(file, offset, len, mode);
> +		goto exit;
> +	}
>  	trace_ext4_fallocate_enter(inode, offset, len, mode);
>  	lblk = offset >> blkbits;
>  
> @@ -4698,12 +4712,14 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		goto out;
>  
>  	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
> -		ret = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
> -						EXT4_I(inode)->i_sync_tid);
> +		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
> +					EXT4_I(inode)->i_sync_tid);
>  	}
>  out:
>  	inode_unlock(inode);
>  	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
> +exit:
> +	ext4_fc_stop_update(inode);
>  	return ret;
>  }
>  
> @@ -5291,6 +5307,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>  		ret = PTR_ERR(handle);
>  		goto out_mmap;
>  	}
> +	ext4_fc_start_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
>  
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  	ext4_discard_preallocations(inode, 0);
> @@ -5329,6 +5346,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>  
>  out_stop:
>  	ext4_journal_stop(handle);
> +	ext4_fc_stop_ineligible(sb);
>  out_mmap:
>  	up_write(&EXT4_I(inode)->i_mmap_sem);
>  out_mutex:
> @@ -5429,6 +5447,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  		ret = PTR_ERR(handle);
>  		goto out_mmap;
>  	}
> +	ext4_fc_start_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
>  
>  	/* Expand file to avoid data loss if there is error while shifting */
>  	inode->i_size += len;
> @@ -5503,6 +5522,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  
>  out_stop:
>  	ext4_journal_stop(handle);
> +	ext4_fc_stop_ineligible(sb);
>  out_mmap:
>  	up_write(&EXT4_I(inode)->i_mmap_sem);
>  out_mutex:
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index f2d11b4c6b62..e0fa3bd18346 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -7,13 +7,1174 @@
>   *
>   * Ext4 fast commits routines.
>   */
> +#include "ext4.h"
>  #include "ext4_jbd2.h"
> +#include "ext4_extents.h"
> +#include "mballoc.h"
> +
> +/*
> + * Ext4 Fast Commits
> + * -----------------
> + *
> + * Ext4 fast commits implement fine grained journalling for Ext4.
> + *
> + * Fast commits are organized as a log of tag-length-value (TLV) structs. (See
> + * struct ext4_fc_tl). Each TLV contains some delta that is replayed TLV by
> + * TLV during the recovery phase. For the scenarios for which we currently
> + * don't have replay code, fast commit falls back to full commits.
> + * Fast commits record delta in one of the following three categories.
> + *
> + * (A) Directory entry updates:
> + *
> + * - EXT4_FC_TAG_UNLINK		- records directory entry unlink
> + * - EXT4_FC_TAG_LINK		- records directory entry link
> + * - EXT4_FC_TAG_CREAT		- records inode and directory entry creation
> + *
> + * (B) File specific data range updates:
> + *
> + * - EXT4_FC_TAG_ADD_RANGE	- records addition of new blocks to an inode
> + * - EXT4_FC_TAG_DEL_RANGE	- records deletion of blocks from an inode
> + *
> + * (C) Inode metadata (mtime / ctime etc):
> + *
> + * - EXT4_FC_TAG_INODE		- record the inode that should be replayed
> + *				  during recovery. Note that iblocks field is
> + *				  not replayed and instead derived during
> + *				  replay.
> + * Commit Operation
> + * ----------------
> + * With fast commits, we maintain all the directory entry operations in the
> + * order in which they are issued in an in-memory queue. This queue is flushed
> + * to disk during the commit operation. We also maintain a list of inodes
> + * that need to be committed during a fast commit in another in memory queue of
> + * inodes. During the commit operation, we commit in the following order:
> + *
> + * [1] Lock inodes for any further data updates by setting COMMITTING state
> + * [2] Submit data buffers of all the inodes
> + * [3] Wait for [2] to complete
> + * [4] Commit all the directory entry updates in the fast commit space
> + * [5] Commit all the changed inode structures
> + * [6] Write tail tag (this tag ensures the atomicity, please read the following
> + *     section for more details).
> + * [7] Wait for [4], [5] and [6] to complete.
> + *
> + * All the inode updates must call ext4_fc_start_update() before starting an
> + * update. If such an ongoing update is present, fast commit waits for it to
> + * complete. The completion of such an update is marked by
> + * ext4_fc_stop_update().
> + *
> + * Fast Commit Ineligibility
> + * -------------------------
> + * Not all operations are supported by fast commits today (e.g extended
> + * attributes). Fast commit ineligiblity is marked by calling one of the
> + * two following functions:
> + *
> + * - ext4_fc_mark_ineligible(): This makes next fast commit operation to fall
> + *   back to full commit. This is useful in case of transient errors.
> + *
> + * - ext4_fc_start_ineligible() and ext4_fc_stop_ineligible() - This makes all
> + *   the fast commits happening between ext4_fc_start_ineligible() and
> + *   ext4_fc_stop_ineligible() and one fast commit after the call to
> + *   ext4_fc_stop_ineligible() to fall back to full commits. It is important to
> + *   make one more fast commit to fall back to full commit after stop call so
> + *   that it guaranteed that the fast commit ineligible operation contained
> + *   within ext4_fc_start_ineligible() and ext4_fc_stop_ineligible() is
> + *   followed by at least 1 full commit.
> + *
> + * Atomicity of commits
> + * --------------------
> + * In order to gaurantee atomicity during the commit operation, fast commit
                  ^^^ guarantee

> + * uses "EXT4_FC_TAG_TAIL" tag that marks a fast commit as complete. Tail
> + * tag contains CRC of the contents and TID of the transaction after which
> + * this fast commit should be applied. Recovery code replays fast commit
> + * logs only if there's at least 1 valid tail present. For every fast commit
> + * operation, there is 1 tail. This means, we may end up with multiple tails
> + * in the fast commit space. Here's an example:
> + *
> + * - Create a new file A and remove existing file B
> + * - fsync()

Great that there's an example here. But what do we fsync here? A or dir with
A or something else?

> + * - Append contents to file A
> + * - Truncate file A
> + * - fsync()

And what is fsynced here?

> + *
> + * The fast commit space at the end of above operations would look like this:
> + *      [HEAD] [CREAT A] [UNLINK B] [TAIL] [ADD_RANGE A] [DEL_RANGE A] [TAIL]
> + *             |<---  Fast Commit 1   --->|<---      Fast Commit 2     ---->|
> + *
> + * Replay code should thus check for all the valid tails in the FC area.

And one design question: Why do we record unlink of B here? I was kind of
hoping that fastcommit due to fsync(A) would record only operations related
to A. Because the way you wrote it, fast commit is inherently still a
filesystem-global operation requiring global ordering of metadata changes
with all the scalability bottlenecks current journalling code has. It's
faster by some factor due to more efficient packing of "small" changes not
fundamentally faster AFAICT...

> + *
> + * TODOs
> + * -----
> + * 1) Make fast commit atomic updates more fine grained. Today, a fast commit
> + *    eligible update must be protected within ext4_fc_start_update() and
> + *    ext4_fc_stop_update(). These routines are called at much higher
> + *    routines. This can be made more fine grained by combining with
> + *    ext4_journal_start().
> + *
> + * 2) Same above for ext4_fc_start_ineligible() and ext4_fc_stop_ineligible()
> + *
> + * 3) Handle more ineligible cases.
> + */
> +
> +#include <trace/events/ext4.h>
> +static struct kmem_cache *ext4_fc_dentry_cachep;
> +
> +static void ext4_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
> +{
> +	BUFFER_TRACE(bh, "");
> +	if (uptodate) {
> +		ext4_debug("%s: Block %lld up-to-date",
> +			   __func__, bh->b_blocknr);
> +		set_buffer_uptodate(bh);
> +	} else {
> +		ext4_debug("%s: Block %lld not up-to-date",
> +			   __func__, bh->b_blocknr);
> +		clear_buffer_uptodate(bh);
> +	}
> +
> +	unlock_buffer(bh);
> +}
> +
> +static inline void ext4_fc_reset_inode(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	ei->i_fc_lblk_start = 0;
> +	ei->i_fc_lblk_len = 0;
> +}
> +
> +void ext4_fc_init_inode(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	ext4_fc_reset_inode(inode);
> +	ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
> +	INIT_LIST_HEAD(&ei->i_fc_list);
> +	init_waitqueue_head(&ei->i_fc_wait);
> +	atomic_set(&ei->i_fc_updates, 0);
> +}
> +
> +/*
> + * Inform Ext4's fast about start of an inode update
> + *
> + * This function is called by the high level call VFS callbacks before
> + * performing any inode update. This function blocks if there's an ongoing
> + * fast commit on the inode in question.
> + */
> +void ext4_fc_start_update(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> +		return;
> +
> +restart:
> +	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +	if (list_empty(&ei->i_fc_list))
> +		goto out;
> +
> +	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> +		wait_queue_head_t *wq;
> +#if (BITS_PER_LONG < 64)
> +		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> +				EXT4_STATE_FC_COMMITTING);
> +		wq = bit_waitqueue(&ei->i_state_flags,
> +				   EXT4_STATE_FC_COMMITTING);
> +#else
> +		DEFINE_WAIT_BIT(wait, &ei->i_flags,
> +				EXT4_STATE_FC_COMMITTING);
> +		wq = bit_waitqueue(&ei->i_flags,
> +				   EXT4_STATE_FC_COMMITTING);
> +#endif
> +		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> +		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +		schedule();
> +		finish_wait(wq, &wait.wq_entry);
> +		goto restart;
> +	}
> +out:
> +	atomic_inc(&ei->i_fc_updates);
> +	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +}
> +
> +/*
> + * Stop inode update and wake up waiting fast commits if any.
> + */
> +void ext4_fc_stop_update(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> +		return;
> +
> +	if (atomic_dec_and_test(&ei->i_fc_updates))
> +		wake_up_all(&ei->i_fc_wait);
> +}
> +
> +/*
> + * Remove inode from fast commit list. If the inode is being committed
> + * we wait until inode commit is done.
> + */
> +void ext4_fc_del(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> +		return;
> +
> +
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> +		return;

Uh, why testing twice?

> +
> +restart:
> +	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +	if (list_empty(&ei->i_fc_list)) {
> +		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +		return;
> +	}
> +
> +	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> +		wait_queue_head_t *wq;
> +#if (BITS_PER_LONG < 64)
> +		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> +				EXT4_STATE_FC_COMMITTING);
> +		wq = bit_waitqueue(&ei->i_state_flags,
> +				   EXT4_STATE_FC_COMMITTING);
> +#else
> +		DEFINE_WAIT_BIT(wait, &ei->i_flags,
> +				EXT4_STATE_FC_COMMITTING);
> +		wq = bit_waitqueue(&ei->i_flags,
> +				   EXT4_STATE_FC_COMMITTING);
> +#endif

Create a helper function for waiting for EXT4_STATE_FC_COMMITTING? It is
opencoded several times...

> +		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> +		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +		schedule();
> +		finish_wait(wq, &wait.wq_entry);
> +		goto restart;
> +	}
> +	if (!list_empty(&ei->i_fc_list))

You've checked for list_empty() above, no need to recheck again...

> +		list_del_init(&ei->i_fc_list);
> +	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +}
> +
> +/*
> + * Mark file system as fast commit ineligible. This means that next commit
> + * operation would result in a full jbd2 commit.
> + */
> +void ext4_fc_mark_ineligible(struct super_block *sb, int reason)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	sbi->s_mount_state |= EXT4_FC_INELIGIBLE;
> +	WARN_ON(reason >= EXT4_FC_REASON_MAX);
> +	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
> +}
> +
> +/*
> + * Start a fast commit ineligible update. Any commits that happen while
> + * such an operation is in progress fall back to full commits.
> + */
> +void ext4_fc_start_ineligible(struct super_block *sb, int reason)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	WARN_ON(reason >= EXT4_FC_REASON_MAX);
> +	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
> +	atomic_inc(&sbi->s_fc_ineligible_updates);
> +}
> +
> +/*
> + * Stop a fast commit ineligible update. We set EXT4_FC_INELIGIBLE flag here
> + * to ensure that after stopping the ineligible update, at least one full
> + * commit takes place.
> + */
> +void ext4_fc_stop_ineligible(struct super_block *sb)
> +{
> +	EXT4_SB(sb)->s_mount_state |= EXT4_FC_INELIGIBLE;
> +	atomic_dec(&EXT4_SB(sb)->s_fc_ineligible_updates);
> +}
> +
> +static inline int ext4_fc_is_ineligible(struct super_block *sb)
> +{
> +	return (EXT4_SB(sb)->s_mount_state & EXT4_FC_INELIGIBLE) ||
> +		atomic_read(&EXT4_SB(sb)->s_fc_ineligible_updates);
> +}
> +
> +/*
> + * Generic fast commit tracking function. If this is the first time this we are
> + * called after a full commit, we initialize fast commit fields and then call
> + * __fc_track_fn() with update = 0. If we have already been called after a full
> + * commit, we pass update = 1. Based on that, the track function can determine
> + * if it needs to track a field for the first time or if it needs to just
> + * update the previously tracked value.
> + *
> + * If enqueue is set, this function enqueues the inode in fast commit list.
> + */
> +static int ext4_fc_track_template(
> +	struct inode *inode, int (*__fc_track_fn)(struct inode *, void *, bool),
> +	void *args, int enqueue)
> +{
> +	tid_t running_txn_tid;
> +	bool update = false;
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	int ret;
> +
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> +		return -EOPNOTSUPP;
> +
> +	if (ext4_fc_is_ineligible(inode->i_sb))
> +		return -EINVAL;
> +
> +	running_txn_tid = sbi->s_journal ?
> +		sbi->s_journal->j_commit_sequence + 1 : 0;

This looks problematic. The j_commit_sequence sampling is racy - first
without j_state_lock you can be fetching stale value, second you don't
know whether there is transaction currently committing or not. If there is,
j_commit_sequence will contain TID of the transaction before it which is
wrong for your purposes. I think you should pass 'handle' into all the
tracking functions and derive running transaction TID from that as we do it
elsewhere.

> +
> +	mutex_lock(&ei->i_fc_lock);
> +	if (running_txn_tid == ei->i_sync_tid) {
> +		update = true;
> +	} else {
> +		ext4_fc_reset_inode(inode);
> +		ei->i_sync_tid = running_txn_tid;
> +	}
> +	ret = __fc_track_fn(inode, args, update);
> +	mutex_unlock(&ei->i_fc_lock);
> +
> +	if (!enqueue)
> +		return ret;
> +
> +	spin_lock(&sbi->s_fc_lock);
> +	if (list_empty(&EXT4_I(inode)->i_fc_list))
> +		list_add_tail(&EXT4_I(inode)->i_fc_list,
> +				(sbi->s_mount_state & EXT4_FC_COMMITTING) ?
> +				&sbi->s_fc_q[FC_Q_STAGING] :
> +				&sbi->s_fc_q[FC_Q_MAIN]);
> +	spin_unlock(&sbi->s_fc_lock);

OK, so how do you prevent inode from being freed while it is still on
i_fc_list? I don't see anything preventing that and it could cause nasty
use-after-free issues. Note that for similar reasons JBD2 uses external
separately allocated inode for jbd2_inode so that it can have separate
lifetime (related to transaction commits) from struct ext4_inode_info.

> +
> +	return ret;
> +}
> +
> +struct __track_dentry_update_args {
> +	struct dentry *dentry;
> +	int op;
> +};
> +
> +/* __track_fn for directory entry updates. Called with ei->i_fc_lock. */
> +static int __track_dentry_update(struct inode *inode, void *arg, bool update)
> +{
> +	struct ext4_fc_dentry_update *node;
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct __track_dentry_update_args *dentry_update =
> +		(struct __track_dentry_update_args *)arg;
> +	struct dentry *dentry = dentry_update->dentry;
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +
> +	mutex_unlock(&ei->i_fc_lock);
> +	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
> +	if (!node) {
> +		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MEM);
> +		mutex_lock(&ei->i_fc_lock);
> +		return -ENOMEM;
> +	}
> +
> +	node->fcd_op = dentry_update->op;
> +	node->fcd_parent = dentry->d_parent->d_inode->i_ino;
> +	node->fcd_ino = inode->i_ino;
> +	if (dentry->d_name.len > DNAME_INLINE_LEN) {
> +		node->fcd_name.name = kmalloc(dentry->d_name.len, GFP_NOFS);
> +		if (!node->fcd_name.name) {
> +			kmem_cache_free(ext4_fc_dentry_cachep, node);
> +			ext4_fc_mark_ineligible(inode->i_sb,
> +				EXT4_FC_REASON_MEM);
> +			mutex_lock(&ei->i_fc_lock);
> +			return -ENOMEM;
> +		}
> +		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
> +			dentry->d_name.len);
> +	} else {
> +		memcpy(node->fcd_iname, dentry->d_name.name,
> +			dentry->d_name.len);
> +		node->fcd_name.name = node->fcd_iname;
> +	}
> +	node->fcd_name.len = dentry->d_name.len;
> +
> +	spin_lock(&sbi->s_fc_lock);
> +	if (sbi->s_mount_state & EXT4_FC_COMMITTING)
> +		list_add_tail(&node->fcd_list,
> +				&sbi->s_fc_dentry_q[FC_Q_STAGING]);
> +	else
> +		list_add_tail(&node->fcd_list, &sbi->s_fc_dentry_q[FC_Q_MAIN]);
> +	spin_unlock(&sbi->s_fc_lock);
> +	mutex_lock(&ei->i_fc_lock);
> +
> +	return 0;
> +}
> +
> +void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry)
> +{
> +	struct __track_dentry_update_args args;
> +	int ret;
> +
> +	args.dentry = dentry;
> +	args.op = EXT4_FC_TAG_UNLINK;
> +
> +	ret = ext4_fc_track_template(inode, __track_dentry_update,
> +					(void *)&args, 0);
> +	trace_ext4_fc_track_unlink(inode, dentry, ret);
> +}
> +
> +void ext4_fc_track_link(struct inode *inode, struct dentry *dentry)
> +{
> +	struct __track_dentry_update_args args;
> +	int ret;
> +
> +	args.dentry = dentry;
> +	args.op = EXT4_FC_TAG_LINK;
> +
> +	ret = ext4_fc_track_template(inode, __track_dentry_update,
> +					(void *)&args, 0);
> +	trace_ext4_fc_track_link(inode, dentry, ret);
> +}
> +
> +void ext4_fc_track_create(struct inode *inode, struct dentry *dentry)
> +{
> +	struct __track_dentry_update_args args;
> +	int ret;
> +
> +	args.dentry = dentry;
> +	args.op = EXT4_FC_TAG_CREAT;
> +
> +	ret = ext4_fc_track_template(inode, __track_dentry_update,
> +					(void *)&args, 0);
> +	trace_ext4_fc_track_create(inode, dentry, ret);
> +}
> +
> +/* __track_fn for inode tracking */
> +static int __track_inode(struct inode *inode, void *arg, bool update)
> +{
> +	if (update)
> +		return -EEXIST;
> +
> +	EXT4_I(inode)->i_fc_lblk_len = 0;
> +
> +	return 0;
> +}
> +
> +void ext4_fc_track_inode(struct inode *inode)
> +{
> +	int ret;
> +
> +	if (S_ISDIR(inode->i_mode))
> +		return;
> +
> +	ret = ext4_fc_track_template(inode, __track_inode, NULL, 1);
> +	trace_ext4_fc_track_inode(inode, ret);
> +}
> +
> +struct __track_range_args {
> +	ext4_lblk_t start, end;
> +};
> +
> +/* __track_fn for tracking data updates */
> +static int __track_range(struct inode *inode, void *arg, bool update)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	ext4_lblk_t oldstart;
> +	struct __track_range_args *__arg =
> +		(struct __track_range_args *)arg;
> +
> +	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb)) {
> +		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
> +		return -ECANCELED;
> +	}
> +
> +	oldstart = ei->i_fc_lblk_start;
> +
> +	if (update && ei->i_fc_lblk_len > 0) {
> +		ei->i_fc_lblk_start = min(ei->i_fc_lblk_start, __arg->start);
> +		ei->i_fc_lblk_len =
> +			max(oldstart + ei->i_fc_lblk_len - 1, __arg->end) -
> +				ei->i_fc_lblk_start + 1;
> +	} else {
> +		ei->i_fc_lblk_start = __arg->start;
> +		ei->i_fc_lblk_len = __arg->end - __arg->start + 1;
> +	}
> +
> +	return 0;
> +}
> +
> +void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
> +			 ext4_lblk_t end)
> +{
> +	struct __track_range_args args;
> +	int ret;
> +
> +	if (S_ISDIR(inode->i_mode))
> +		return;
> +
> +	args.start = start;
> +	args.end = end;
> +
> +	ret = ext4_fc_track_template(inode,  __track_range, &args, 1);
> +
> +	trace_ext4_fc_track_range(inode, start, end, ret);
> +}
> +
> +static void ext4_fc_submit_bh(struct super_block *sb)
> +{
> +	int write_flags = REQ_SYNC;
> +	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
> +
> +	if (test_opt(sb, BARRIER))
> +		write_flags |= REQ_FUA | REQ_PREFLUSH;

Submitting each fastcommit buffer with REQ_FUA | REQ_PREFLUSH is
unnecessarily expensive (especially if there will be unrelated writes
happening to the filesystem while fastcommit is running). If nothing else,
it's enough to have REQ_PREFLUSH only once during the whole fastcommit to
flush out written back data blocks (plus journal device may be different
from the filesystem device so you need to be flushing the filesystem device
for this - see how the jbd2 commit code does this).

Also REQ_FUA on each block may be overkill for devices that don't support
it natively (and thus REQ_FUA is simulated with full write cache pre and
post flush) - for such devices it would be better to just write out
fastcommit normally and then issue one cache flush. With careful
checksumming, block ID tagging and such, it should be safe against disk
reordering writes. But I guess we can leave this optimization as a TODO
item for later (but I think it would be good to design the on-disk format of
fastcommit blocks so that it does not rely on FUA writes).
 
> +	lock_buffer(bh);
> +	clear_buffer_dirty(bh);
> +	set_buffer_uptodate(bh);
> +	bh->b_end_io = ext4_end_buffer_io_sync;
> +	submit_bh(REQ_OP_WRITE, write_flags, bh);
> +	EXT4_SB(sb)->s_fc_bh = NULL;
> +}
> +
> +/* Ext4 commit path routines */
> +
> +/* memzero and update CRC */
> +static void *ext4_fc_memzero(struct super_block *sb, void *dst, int len,
> +				u32 *crc)
> +{
> +	void *ret;
> +
> +	ret = memset(dst, 0, len);
> +	if (crc)
> +		*crc = ext4_chksum(EXT4_SB(sb), *crc, dst, len);
> +	return ret;
> +}
> +
> +/*
> + * Allocate len bytes on a fast commit buffer.
> + *
> + * During the commit time this function is used to manage fast commit
> + * block space. We don't split a fast commit log onto different
> + * blocks. So this function makes sure that if there's not enough space
> + * on the current block, the remaining space in the current block is
> + * marked as unused by adding EXT4_FC_TAG_PAD tag. In that case,
> + * new block is from jbd2 and CRC is updated to reflect the padding
> + * we added.
> + */
> +static u8 *ext4_fc_reserve_space(struct super_block *sb, int len, u32 *crc)
> +{
> +	struct ext4_fc_tl *tl;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct buffer_head *bh;
> +	int bsize = sbi->s_journal->j_blocksize;
> +	int ret, off = sbi->s_fc_bytes % bsize;
> +	int pad_len;
> +
> +	/*
> +	 * After allocating len, we should have space at least for a 0 byte
> +	 * padding.
> +	 */
> +	if (len + sizeof(struct ext4_fc_tl) > bsize)
> +		return NULL;
> +
> +	if (bsize - off - 1 > len + sizeof(struct ext4_fc_tl)) {
> +		/*
> +		 * Only allocate from current buffer if we have enough space for
> +		 * this request AND we have space to add a zero byte padding.
> +		 */
> +		if (!sbi->s_fc_bh) {
> +			ret = jbd2_fc_get_buf(EXT4_SB(sb)->s_journal, &bh);
> +			if (ret)
> +				return NULL;
> +			sbi->s_fc_bh = bh;
> +		}
> +		sbi->s_fc_bytes += len;
> +		return sbi->s_fc_bh->b_data + off;
> +	}
> +	/* Need to add PAD tag */
> +	tl = (struct ext4_fc_tl *)(sbi->s_fc_bh->b_data + off);
> +	tl->fc_tag = cpu_to_le16(EXT4_FC_TAG_PAD);
> +	pad_len = bsize - off - 1 - sizeof(struct ext4_fc_tl);
> +	tl->fc_len = cpu_to_le16(pad_len);
> +	if (crc)
> +		*crc = ext4_chksum(sbi, *crc, tl, sizeof(*tl));
> +	if (pad_len > 0)
> +		ext4_fc_memzero(sb, tl + 1, pad_len, crc);
> +	ext4_fc_submit_bh(sb);
> +
> +	ret = jbd2_fc_get_buf(EXT4_SB(sb)->s_journal, &bh);
> +	if (ret)
> +		return NULL;
> +	sbi->s_fc_bh = bh;
> +	sbi->s_fc_bytes = (sbi->s_fc_bytes / bsize + 1) * bsize + len;
> +	return sbi->s_fc_bh->b_data;
> +}
> +
> +/* memcpy to fc reserved space and update CRC */
> +static void *ext4_fc_memcpy(struct super_block *sb, void *dst, const void *src,
> +				int len, u32 *crc)
> +{
> +	if (crc)
> +		*crc = ext4_chksum(EXT4_SB(sb), *crc, src, len);
> +	return memcpy(dst, src, len);
> +}
> +
> +/*
> + * Complete a fast commit by writing tail tag.
> + *
> + * Writing tail tag marks the end of a fast commit. In order to guarantee
> + * atomicity, after writing tail tag, even if there's space remaining
> + * in the block, next commit shouldn't use it. That's why tail tag
> + * has the length as that of the remaining space on the block.
> + */
> +static int ext4_fc_write_tail(struct super_block *sb, u32 crc)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_fc_tl tl;
> +	struct ext4_fc_tail tail;
> +	int off, bsize = sbi->s_journal->j_blocksize;
> +	u8 *dst;
> +
> +	/*
> +	 * ext4_fc_reserve_space takes care of allocating an extra block if
> +	 * there's no enough space on this block for accommodating this tail.
> +	 */
> +	dst = ext4_fc_reserve_space(sb, sizeof(tl) + sizeof(tail), &crc);
> +	if (!dst)
> +		return -ENOSPC;
> +
> +	off = sbi->s_fc_bytes % bsize;
> +
> +	tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_TAIL);
> +	tl.fc_len = cpu_to_le16(bsize - off - 1 + sizeof(struct ext4_fc_tail));
> +	sbi->s_fc_bytes = round_up(sbi->s_fc_bytes, bsize);
> +
> +	ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), &crc);
> +	dst += sizeof(tl);
> +	tail.fc_tid = cpu_to_le32(sbi->s_journal->j_running_transaction->t_tid);
> +	ext4_fc_memcpy(sb, dst, &tail.fc_tid, sizeof(tail.fc_tid), &crc);
> +	dst += sizeof(tail.fc_tid);
> +	tail.fc_crc = cpu_to_le32(crc);
> +	ext4_fc_memcpy(sb, dst, &tail.fc_crc, sizeof(tail.fc_crc), NULL);
> +
> +	ext4_fc_submit_bh(sb);
> +
> +	return 0;
> +}

Is there a reason to pass CRC all around (so you have to have special
functions like ext4_fc_memcpy(), ext4_fc_memzero(), ...) instead of just
creating the whole block and then computing CRC in one go?

In fact, as looking through the code, it seems to me it would be slightly
nicer layer separation and interface if JBD2 provided functions for storage
of data blobs and handled the details of space & block management,
checksums, writeout, on recovery verification of correctness (so it would
just provide back a stream of blobs for FS to replay). Just an idea for
consideration, the current interface isn't too bad and we can change it
later if we decide so.

> +
> +/*
> + * Adds tag, length, value and updates CRC. Returns true if tlv was added.
> + * Returns false if there's not enough space.
> + */
> +static bool ext4_fc_add_tlv(struct super_block *sb, u16 tag, u16 len, u8 *val,
> +			   u32 *crc)
> +{
> +	struct ext4_fc_tl tl;
> +	u8 *dst;
> +
> +	dst = ext4_fc_reserve_space(sb, sizeof(tl) + len, crc);
> +	if (!dst)
> +		return false;
> +
> +	tl.fc_tag = cpu_to_le16(tag);
> +	tl.fc_len = cpu_to_le16(len);
> +
> +	ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), crc);
> +	ext4_fc_memcpy(sb, dst + sizeof(tl), val, len, crc);
> +
> +	return true;
> +}
> +
> +/* Same as above, but adds dentry tlv. */
> +static  bool ext4_fc_add_dentry_tlv(struct super_block *sb, u16 tag,
> +					int parent_ino, int ino, int dlen,
> +					const unsigned char *dname,
> +					u32 *crc)
> +{
> +	struct ext4_fc_dentry_info fcd;
> +	struct ext4_fc_tl tl;
> +	u8 *dst = ext4_fc_reserve_space(sb, sizeof(tl) + sizeof(fcd) + dlen,
> +					crc);
> +
> +	if (!dst)
> +		return false;
> +
> +	fcd.fc_parent_ino = cpu_to_le32(parent_ino);
> +	fcd.fc_ino = cpu_to_le32(ino);
> +	tl.fc_tag = cpu_to_le16(tag);
> +	tl.fc_len = cpu_to_le16(sizeof(fcd) + dlen);
> +	ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), crc);
> +	dst += sizeof(tl);
> +	ext4_fc_memcpy(sb, dst, &fcd, sizeof(fcd), crc);
> +	dst += sizeof(fcd);
> +	ext4_fc_memcpy(sb, dst, dname, dlen, crc);
> +	dst += dlen;
> +
> +	return true;
> +}
> +
> +/*
> + * Writes inode in the fast commit space under TLV with tag @tag.
> + * Returns 0 on success, error on failure.
> + */
> +static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	int inode_len = EXT4_GOOD_OLD_INODE_SIZE;
> +	int ret;
> +	struct ext4_iloc iloc;
> +	struct ext4_fc_inode fc_inode;
> +	struct ext4_fc_tl tl;
> +	u8 *dst;
> +
> +	ret = ext4_get_inode_loc(inode, &iloc);
> +	if (ret)
> +		return ret;
> +
> +	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE)
> +		inode_len += ei->i_extra_isize;
> +
> +	fc_inode.fc_ino = cpu_to_le32(inode->i_ino);
> +	tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_INODE);
> +	tl.fc_len = cpu_to_le16(inode_len + sizeof(fc_inode.fc_ino));
> +
> +	dst = ext4_fc_reserve_space(inode->i_sb,
> +			sizeof(tl) + inode_len + sizeof(fc_inode.fc_ino), crc);
> +	if (!dst)
> +		return -ECANCELED;
> +
> +	if (!ext4_fc_memcpy(inode->i_sb, dst, &tl, sizeof(tl), crc))
> +		return -ECANCELED;
> +	dst += sizeof(tl);
> +	if (!ext4_fc_memcpy(inode->i_sb, dst, &fc_inode, sizeof(fc_inode), crc))
> +		return -ECANCELED;
> +	dst += sizeof(fc_inode);
> +	if (!ext4_fc_memcpy(inode->i_sb, dst, (u8 *)ext4_raw_inode(&iloc),
> +					inode_len, crc))
> +		return -ECANCELED;

Isn't this racy? What guarantees the inode state you record here is a valid
one for the fastcommit? I mean this gets called at the time of fastcommit
(i.e., fsync), so a fastcommit code must record changes to all other
metadata that relate to the currently recorded inode state. But this isn't
serialized in any way (AFAICT) with on-going inode changes so how can
fastcommit code guarantee that? This is a similar case as a problem I
describe below...

> +
> +	return 0;
> +}
> +
> +/*
> + * Writes updated data ranges for the inode in question. Updates CRC.
> + * Returns 0 on success, error otherwise.
> + */
> +static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
> +{
> +	ext4_lblk_t old_blk_size, cur_lblk_off, new_blk_size;
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct ext4_map_blocks map;
> +	struct ext4_fc_add_range fc_ext;
> +	struct ext4_fc_del_range lrange;
> +	struct ext4_extent *ex;
> +	int ret;
> +
> +	mutex_lock(&ei->i_fc_lock);
> +	if (ei->i_fc_lblk_len == 0) {
> +		mutex_unlock(&ei->i_fc_lock);
> +		return 0;
> +	}
> +	old_blk_size = ei->i_fc_lblk_start;
> +	new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
> +	ei->i_fc_lblk_len = 0;
> +	mutex_unlock(&ei->i_fc_lock);
> +
> +	cur_lblk_off = old_blk_size;
> +	jbd_debug(1, "%s: will try writing %d to %d for inode %ld\n",
> +		  __func__, cur_lblk_off, new_blk_size, inode->i_ino);
> +
> +	while (cur_lblk_off <= new_blk_size) {
> +		map.m_lblk = cur_lblk_off;
> +		map.m_len = new_blk_size - cur_lblk_off + 1;
> +		ret = ext4_map_blocks(NULL, inode, &map, 0);
> +		if (ret < 0)
> +			return -ECANCELED;

So isn't this actually racy with a risk of stale data exposure? Consider a
situation like:

Task 1:				Task 2:
pwrite(file, buf, 8192, 0)
punch(file, 0, 4096)
fsync(file)
  writeout range 4096-8192
  fastcommit for inode range 0-8192
				pwrite(file, buf, 4096, 0)
    ext4_map_blocks(file)
      - reports that block at offset 0 is mapped so that is recorded in
        fastcommit record. But data for that is not written so after a
        crash we'd expose stale data in that block.

Am I missing something?  

> +
> +		if (map.m_len == 0) {
> +			cur_lblk_off++;
> +			continue;
> +		}
> +
> +		if (ret == 0) {
> +			lrange.fc_ino = cpu_to_le32(inode->i_ino);
> +			lrange.fc_lblk = cpu_to_le32(map.m_lblk);
> +			lrange.fc_len = cpu_to_le32(map.m_len);
> +			if (!ext4_fc_add_tlv(inode->i_sb, EXT4_FC_TAG_DEL_RANGE,
> +					    sizeof(lrange), (u8 *)&lrange, crc))
> +				return -ENOSPC;
> +		} else {
> +			fc_ext.fc_ino = cpu_to_le32(inode->i_ino);
> +			ex = (struct ext4_extent *)&fc_ext.fc_ex;
> +			ex->ee_block = cpu_to_le32(map.m_lblk);
> +			ex->ee_len = cpu_to_le16(map.m_len);
> +			ext4_ext_store_pblock(ex, map.m_pblk);
> +			if (map.m_flags & EXT4_MAP_UNWRITTEN)
> +				ext4_ext_mark_unwritten(ex);
> +			else
> +				ext4_ext_mark_initialized(ex);
> +			if (!ext4_fc_add_tlv(inode->i_sb, EXT4_FC_TAG_ADD_RANGE,
> +					    sizeof(fc_ext), (u8 *)&fc_ext, crc))
> +				return -ENOSPC;
> +		}
> +
> +		cur_lblk_off += map.m_len;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +/* Submit data for all the fast commit inodes */
> +static int ext4_fc_submit_inode_data_all(journal_t *journal)
> +{
> +	struct super_block *sb = (struct super_block *)(journal->j_private);
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_inode_info *ei;
> +	struct list_head *pos;
> +	int ret = 0;
> +
> +	spin_lock(&sbi->s_fc_lock);
> +	sbi->s_mount_state |= EXT4_FC_COMMITTING;
> +	list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
> +		ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
> +		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
> +		while (atomic_read(&ei->i_fc_updates)) {
> +			DEFINE_WAIT(wait);
> +
> +			prepare_to_wait(&ei->i_fc_wait, &wait,
> +						TASK_UNINTERRUPTIBLE);
> +			if (atomic_read(&ei->i_fc_updates)) {
> +				spin_unlock(&sbi->s_fc_lock);
> +				schedule();
> +				spin_lock(&sbi->s_fc_lock);
> +			}
> +			finish_wait(&ei->i_fc_wait, &wait);
> +		}
> +		spin_unlock(&sbi->s_fc_lock);
> +		ret = jbd2_submit_inode_data(ei->jinode);
> +		if (ret)
> +			return ret;
> +		spin_lock(&sbi->s_fc_lock);
> +	}
> +	spin_unlock(&sbi->s_fc_lock);
> +
> +	return ret;
> +}
> +
> +/* Wait for completion of data for all the fast commit inodes */
> +static int ext4_fc_wait_inode_data_all(journal_t *journal)
> +{
> +	struct super_block *sb = (struct super_block *)(journal->j_private);
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_inode_info *pos, *n;
> +	int ret = 0;
> +
> +	spin_lock(&sbi->s_fc_lock);
> +	list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> +		if (!ext4_test_inode_state(&pos->vfs_inode,
> +					   EXT4_STATE_FC_COMMITTING))
> +			continue;
> +		spin_unlock(&sbi->s_fc_lock);
> +
> +		ret = jbd2_wait_inode_data(journal, pos->jinode);
> +		if (ret)
> +			return ret;
> +		spin_lock(&sbi->s_fc_lock);
> +	}
> +	spin_unlock(&sbi->s_fc_lock);
> +
> +	return 0;
> +}
> +
> +/* Commit all the directory entry updates */
> +static int ext4_fc_commit_dentry_updates(journal_t *journal, u32 *crc)
> +{
> +	struct super_block *sb = (struct super_block *)(journal->j_private);
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_fc_dentry_update *fc_dentry;
> +	struct inode *inode;
> +	struct list_head *pos, *n, *fcd_pos, *fcd_n;
> +	struct ext4_inode_info *ei;
> +	int ret;
> +
> +	if (list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN]))
> +		return 0;
> +	list_for_each_safe(fcd_pos, fcd_n, &sbi->s_fc_dentry_q[FC_Q_MAIN]) {
> +		fc_dentry = list_entry(fcd_pos, struct ext4_fc_dentry_update,
> +					fcd_list);
> +		if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT) {
> +			spin_unlock(&sbi->s_fc_lock);
> +			if (!ext4_fc_add_dentry_tlv(
> +				sb, fc_dentry->fcd_op,
> +				fc_dentry->fcd_parent, fc_dentry->fcd_ino,
> +				fc_dentry->fcd_name.len,
> +				fc_dentry->fcd_name.name, crc)) {
> +				return -ENOSPC;
> +			}
> +			spin_lock(&sbi->s_fc_lock);
> +			continue;
> +		}
> +
> +		inode = NULL;
> +		list_for_each_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN]) {
> +			ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
> +			if (ei->vfs_inode.i_ino == fc_dentry->fcd_ino) {
> +				inode = &ei->vfs_inode;
> +				break;
> +			}
> +		}
> +		/*
> +		 * If we don't find inode in our list, then it was deleted,
> +		 * in which case, we don't need to record it's create tag.
> +		 */
> +		if (!inode)
> +			continue;
> +		spin_unlock(&sbi->s_fc_lock);
> +
> +		/*
> +		 * We first write the inode and then the create dirent. This
> +		 * allows the recovery code to create an unnamed inode first
> +		 * and then link it to a directory entry. This allows us
> +		 * to use namei.c routines almost as is and simplifies
> +		 * the recovery code.
> +		 */
> +		ret = ext4_fc_write_inode(inode, crc);
> +		if (ret)
> +			return ret;
> +		ret = ext4_fc_write_inode_data(inode, crc);
> +		if (ret)
> +			return ret;
> +
> +		if (!ext4_fc_add_dentry_tlv(
> +			sb, fc_dentry->fcd_op,
> +			fc_dentry->fcd_parent, fc_dentry->fcd_ino,
> +			fc_dentry->fcd_name.len,
> +			fc_dentry->fcd_name.name, crc))
> +			return -ENOSPC;
> +
> +		spin_lock(&sbi->s_fc_lock);
> +	}
> +	return 0;
> +}
> +
> +static int ext4_fc_perform_commit(journal_t *journal)
> +{
> +	struct super_block *sb = (struct super_block *)(journal->j_private);
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_inode_info *iter;
> +	struct ext4_fc_head head;
> +	struct list_head *pos;
> +	struct inode *inode;
> +	struct blk_plug plug;
> +	int ret = 0;
> +	u32 crc = 0;
> +
> +	ret = ext4_fc_submit_inode_data_all(journal);
> +	if (ret)
> +		return ret;
> +
> +	ret = ext4_fc_wait_inode_data_all(journal);
> +	if (ret)
> +		return ret;
> +
> +	blk_start_plug(&plug);
> +	if (sbi->s_fc_bytes == 0) {
> +		/*
> +		 * Add a head tag only if this is the first fast commit
> +		 * in this TID.
> +		 */
> +		head.fc_features = cpu_to_le32(EXT4_FC_SUPPORTED_FEATURES);
> +		head.fc_tid = cpu_to_le32(
> +			sbi->s_journal->j_running_transaction->t_tid);
> +		if (!ext4_fc_add_tlv(sb, EXT4_FC_TAG_HEAD, sizeof(head),
> +			(u8 *)&head, &crc))
> +			goto out;
> +	}
> +
> +	spin_lock(&sbi->s_fc_lock);
> +	ret = ext4_fc_commit_dentry_updates(journal, &crc);
> +	if (ret) {
> +		spin_unlock(&sbi->s_fc_lock);
> +		goto out;
> +	}
> +
> +	list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
> +		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
> +		inode = &iter->vfs_inode;
> +		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
> +			continue;
> +
> +		spin_unlock(&sbi->s_fc_lock);
> +		ret = ext4_fc_write_inode_data(inode, &crc);
> +		if (ret)
> +			goto out;
> +		ret = ext4_fc_write_inode(inode, &crc);
> +		if (ret)
> +			goto out;
> +		spin_lock(&sbi->s_fc_lock);
> +	}
> +	spin_unlock(&sbi->s_fc_lock);
> +
> +	ret = ext4_fc_write_tail(sb, crc);
> +
> +out:
> +	blk_finish_plug(&plug);
> +	return ret;
> +}
> +
> +/*
> + * The main commit entry point. Performs a fast commit for transaction
> + * commit_tid if needed. If it's not possible to perform a fast commit
> + * due to various reasons, we fall back to full commit. Returns 0
> + * on success, error otherwise.
> + */
> +int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
> +{
> +	struct super_block *sb = (struct super_block *)(journal->j_private);
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	int nblks = 0, ret, bsize = journal->j_blocksize;
> +	int subtid = atomic_read(&sbi->s_fc_subtid);
> +	int reason = EXT4_FC_REASON_OK, fc_bufs_before = 0;
> +	ktime_t start_time, commit_time;
> +
> +	trace_ext4_fc_commit_start(sb);
> +
> +	start_time = ktime_get();
> +
> +	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
> +		(ext4_fc_is_ineligible(sb))) {
> +		reason = EXT4_FC_REASON_INELIGIBLE;
> +		goto out;
> +	}
> +
> +restart_fc:
> +	ret = jbd2_fc_begin_commit(journal, commit_tid);
> +	if (ret == -EALREADY) {
> +		/* There was an ongoing commit, check if we need to restart */
> +		if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
> +			commit_tid > journal->j_commit_sequence)
> +			goto restart_fc;
> +		reason = EXT4_FC_REASON_ALREADY_COMMITTED;
> +		goto out;
> +	} else if (ret) {
> +		sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
> +		reason = EXT4_FC_REASON_FC_START_FAILED;
> +		goto out;
> +	}
> +
> +	fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
> +	ret = ext4_fc_perform_commit(journal);
> +	if (ret < 0) {
> +		sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
> +		reason = EXT4_FC_REASON_FC_FAILED;
> +		goto out;
> +	}
> +	nblks = (sbi->s_fc_bytes + bsize - 1) / bsize - fc_bufs_before;
> +	ret = jbd2_fc_wait_bufs(journal, nblks);
> +	if (ret < 0) {
> +		sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
> +		reason = EXT4_FC_REASON_FC_FAILED;
> +		goto out;
> +	}
> +	atomic_inc(&sbi->s_fc_subtid);
> +	jbd2_fc_end_commit(journal);
> +out:
> +	/* Has any ineligible update happened since we started? */
> +	if (reason == EXT4_FC_REASON_OK && ext4_fc_is_ineligible(sb)) {
> +		sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
> +		reason = EXT4_FC_REASON_INELIGIBLE;
> +	}
> +
> +	spin_lock(&sbi->s_fc_lock);
> +	if (reason != EXT4_FC_REASON_OK &&
> +		reason != EXT4_FC_REASON_ALREADY_COMMITTED) {
> +		sbi->s_fc_stats.fc_ineligible_commits++;
> +	} else {
> +		sbi->s_fc_stats.fc_num_commits++;
> +		sbi->s_fc_stats.fc_numblks += nblks;
> +	}
> +	spin_unlock(&sbi->s_fc_lock);
> +	nblks = (reason == EXT4_FC_REASON_OK) ? nblks : 0;
> +	trace_ext4_fc_commit_stop(sb, nblks, reason);
> +	commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
> +	/*
> +	 * weight the commit time higher than the average time so we don't
> +	 * react too strongly to vast changes in the commit time
> +	 */
> +	if (likely(sbi->s_fc_avg_commit_time))
> +		sbi->s_fc_avg_commit_time = (commit_time +
> +				sbi->s_fc_avg_commit_time * 3) / 4;
> +	else
> +		sbi->s_fc_avg_commit_time = commit_time;
> +	jbd_debug(1,
> +		"Fast commit ended with blks = %d, reason = %d, subtid - %d",
> +		nblks, reason, subtid);
> +	if (reason == EXT4_FC_REASON_FC_FAILED)
> +		return jbd2_fc_end_commit_fallback(journal, commit_tid);
> +	if (reason == EXT4_FC_REASON_FC_START_FAILED ||
> +		reason == EXT4_FC_REASON_INELIGIBLE)
> +		return jbd2_complete_transaction(journal, commit_tid);
> +	return 0;
> +}
> +
>  /*
>   * Fast commit cleanup routine. This is called after every fast commit and
>   * full commit. full is true if we are called after a full commit.
>   */
>  static void ext4_fc_cleanup(journal_t *journal, int full)
>  {
> +	struct super_block *sb = journal->j_private;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_inode_info *iter;
> +	struct ext4_fc_dentry_update *fc_dentry;
> +	struct list_head *pos, *n;
> +
> +	if (full && sbi->s_fc_bh)
> +		sbi->s_fc_bh = NULL;
> +
> +	jbd2_fc_release_bufs(journal);
> +
> +	spin_lock(&sbi->s_fc_lock);
> +	list_for_each_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN]) {
> +		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
> +		list_del_init(&iter->i_fc_list);
> +		ext4_clear_inode_state(&iter->vfs_inode,
> +				       EXT4_STATE_FC_COMMITTING);
> +		ext4_fc_reset_inode(&iter->vfs_inode);
> +		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
> +		smp_mb();
> +#if (BITS_PER_LONG < 64)
> +		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
> +#else
> +		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
> +#endif
> +	}
> +
> +	while (!list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN])) {
> +		fc_dentry = list_first_entry(&sbi->s_fc_dentry_q[FC_Q_MAIN],
> +					     struct ext4_fc_dentry_update,
> +					     fcd_list);
> +		list_del_init(&fc_dentry->fcd_list);
> +		spin_unlock(&sbi->s_fc_lock);
> +
> +		if (fc_dentry->fcd_name.name &&
> +			fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> +			kfree(fc_dentry->fcd_name.name);
> +		kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
> +		spin_lock(&sbi->s_fc_lock);
> +	}
> +
> +	list_splice_init(&sbi->s_fc_dentry_q[FC_Q_STAGING],
> +				&sbi->s_fc_dentry_q[FC_Q_MAIN]);
> +	list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
> +				&sbi->s_fc_q[FC_Q_STAGING]);
> +
> +	sbi->s_mount_state &= ~EXT4_FC_COMMITTING;
> +	sbi->s_mount_state &= ~EXT4_FC_INELIGIBLE;
> +
> +	if (full)
> +		sbi->s_fc_bytes = 0;
> +	spin_unlock(&sbi->s_fc_lock);
> +	trace_ext4_fc_stats(sb);
>  }
>  
>  void ext4_fc_init(struct super_block *sb, journal_t *journal)
> @@ -26,3 +1187,14 @@ void ext4_fc_init(struct super_block *sb, journal_t *journal)
>  		ext4_clear_feature_fast_commit(sb);
>  	}
>  }
> +
> +int __init ext4_fc_init_dentry_cache(void)
> +{
> +	ext4_fc_dentry_cachep = KMEM_CACHE(ext4_fc_dentry_update,
> +					   SLAB_RECLAIM_ACCOUNT);
> +
> +	if (ext4_fc_dentry_cachep == NULL)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> index 8362bf5e6e00..560bc9ca8c79 100644
> --- a/fs/ext4/fast_commit.h
> +++ b/fs/ext4/fast_commit.h
> @@ -6,4 +6,114 @@
>  /* Number of blocks in journal area to allocate for fast commits */
>  #define EXT4_NUM_FC_BLKS		256
>  
> +/* Fast commit tags */
> +#define EXT4_FC_TAG_ADD_RANGE		0x0001
> +#define EXT4_FC_TAG_DEL_RANGE		0x0002
> +#define EXT4_FC_TAG_CREAT		0x0003
> +#define EXT4_FC_TAG_LINK		0x0004
> +#define EXT4_FC_TAG_UNLINK		0x0005
> +#define EXT4_FC_TAG_INODE		0x0006
> +#define EXT4_FC_TAG_PAD			0x0007
> +#define EXT4_FC_TAG_TAIL		0x0008
> +#define EXT4_FC_TAG_HEAD		0x0009
> +
> +#define EXT4_FC_SUPPORTED_FEATURES	0x0
> +
> +/* On disk fast commit tlv value structures */
> +
> +/* Fast commit on disk tag length structure */
> +struct ext4_fc_tl {
> +	__le16 fc_tag;
> +	__le16 fc_len;
> +};
> +
> +/* Value structure for tag EXT4_FC_TAG_HEAD. */
> +struct ext4_fc_head {
> +	__le32 fc_features;
> +	__le32 fc_tid;
> +};
> +
> +/* Value structure for EXT4_FC_TAG_ADD_RANGE. */
> +struct ext4_fc_add_range {
> +	__le32 fc_ino;
> +	__u8 fc_ex[12];
> +};
> +
> +/* Value structure for tag EXT4_FC_TAG_DEL_RANGE. */
> +struct ext4_fc_del_range {
> +	__le32 fc_ino;
> +	__le32 fc_lblk;
> +	__le32 fc_len;
> +};
> +
> +/*
> + * This is the value structure for tags EXT4_FC_TAG_CREAT, EXT4_FC_TAG_LINK
> + * and EXT4_FC_TAG_UNLINK.
> + */
> +struct ext4_fc_dentry_info {
> +	__le32 fc_parent_ino;
> +	__le32 fc_ino;
> +	u8 fc_dname[0];
> +};
> +
> +/* Value structure for EXT4_FC_TAG_INODE and EXT4_FC_TAG_INODE_PARTIAL. */
> +struct ext4_fc_inode {
> +	__le32 fc_ino;
> +	__u8 fc_raw_inode[0];
> +};
> +
> +/* Value structure for tag EXT4_FC_TAG_TAIL. */
> +struct ext4_fc_tail {
> +	__le32 fc_tid;
> +	__le32 fc_crc;
> +};
> +
> +/*
> + * In memory list of dentry updates that are performed on the file
> + * system used by fast commit code.
> + */
> +struct ext4_fc_dentry_update {
> +	int fcd_op;		/* Type of update create / unlink / link */
> +	int fcd_parent;		/* Parent inode number */
> +	int fcd_ino;		/* Inode number */
> +	struct qstr fcd_name;	/* Dirent name */
> +	unsigned char fcd_iname[DNAME_INLINE_LEN];	/* Dirent name string */
> +	struct list_head fcd_list;
> +};
> +
> +/*
> + * Fast commit reason codes
> + */
> +enum {
> +	/*
> +	 * Commit status codes:
> +	 */
> +	EXT4_FC_REASON_OK = 0,
> +	EXT4_FC_REASON_INELIGIBLE,
> +	EXT4_FC_REASON_ALREADY_COMMITTED,
> +	EXT4_FC_REASON_FC_START_FAILED,
> +	EXT4_FC_REASON_FC_FAILED,
> +
> +	/*
> +	 * Fast commit ineligiblity reasons:
> +	 */
> +	EXT4_FC_REASON_XATTR = 0,
> +	EXT4_FC_REASON_CROSS_RENAME,
> +	EXT4_FC_REASON_JOURNAL_FLAG_CHANGE,
> +	EXT4_FC_REASON_MEM,
> +	EXT4_FC_REASON_SWAP_BOOT,
> +	EXT4_FC_REASON_RESIZE,
> +	EXT4_FC_REASON_RENAME_DIR,
> +	EXT4_FC_REASON_FALLOC_RANGE,
> +	EXT4_FC_COMMIT_FAILED,
> +	EXT4_FC_REASON_MAX
> +};
> +
> +struct ext4_fc_stats {
> +	unsigned int fc_ineligible_reason_count[EXT4_FC_REASON_MAX];
> +	unsigned long fc_num_commits;
> +	unsigned long fc_ineligible_commits;
> +	unsigned long fc_numblks;
> +};
> +
>  #endif /* __FAST_COMMIT_H__ */
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 02ffbd29d6b0..d85412d12e3a 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -260,6 +260,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		return -EOPNOTSUPP;
>  
> +	ext4_fc_start_update(inode);
>  	inode_lock(inode);
>  	ret = ext4_write_checks(iocb, from);
>  	if (ret <= 0)
> @@ -271,6 +272,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>  
>  out:
>  	inode_unlock(inode);
> +	ext4_fc_stop_update(inode);
>  	if (likely(ret > 0)) {
>  		iocb->ki_pos += ret;
>  		ret = generic_write_sync(iocb, ret);
> @@ -534,7 +536,9 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			goto out;
>  		}
>  
> +		ext4_fc_start_update(inode);
>  		ret = ext4_orphan_add(handle, inode);
> +		ext4_fc_stop_update(inode);

Why is here protected only the orphan addition? What about other changes
happening to the inode during direct write?

>  		if (ret) {
>  			ext4_journal_stop(handle);
>  			goto out;
> @@ -656,8 +660,8 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  #endif
>  	if (iocb->ki_flags & IOCB_DIRECT)
>  		return ext4_dio_write_iter(iocb, from);
> -
> -	return ext4_buffered_write_iter(iocb, from);
> +	else
> +		return ext4_buffered_write_iter(iocb, from);

Why this change?

>  }
>  
>  #ifdef CONFIG_FS_DAX
> @@ -757,6 +761,7 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (!daxdev_mapping_supported(vma, dax_dev))
>  		return -EOPNOTSUPP;
>  
> +	ext4_fc_start_update(inode);
>  	file_accessed(file);

Uh, is this ext4_fc_start_update() for the file_accessed() call? What about
all the other inode timestamp updates? I'd say handling in ext4_setattr()
should be enough?

Also I don't see anything tracking inode changes due to writes through mmap?
How is that supposed to work?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
