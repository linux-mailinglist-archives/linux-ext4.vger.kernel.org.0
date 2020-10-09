Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1481E288F8E
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389878AbgJIREe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 13:04:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37886 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389529AbgJIREd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 13:04:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099H2NrM082224;
        Fri, 9 Oct 2020 13:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VpWuZTLfkgNqz75tQHFnkHegSHN/WqTQGlwBIILdDog=;
 b=m+fMaNFwG3mc6y1v8cagIpE34CcrbIGWkCaEksQMMgotiImktE4vpCA5tHm1Ufw+G216
 yE/LnI1GTyciTedszjiDPy/86nAroCzC81PU1jbbDAem6YvnuPOU/2qRvi7W53HBZIb4
 I7cxBKbG3wKujf1wjaa3BhQ84GS/uO7BTiMyQ9nLFKAxerj0XjzWS+iDQMFWP4IcKeUT
 hPUcNXVH3LrmkyePAbSZrlanHg5acqi5eDsHdpP5EkW6Q091lKsLfWkqEoLJpHn52+tg
 I19gR22O6j8Mf1boh/0lEFmFS6Wifo7WqYmNaOGVJzN27XwNgqf7JV3cItjPRAIaypjq ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342tr9t5yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 13:04:17 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 099H2Xfi082889;
        Fri, 9 Oct 2020 13:04:17 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342tr9t5xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 13:04:17 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099Gqmi4010728;
        Fri, 9 Oct 2020 17:04:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 342pbsg4qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 17:04:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099H4DNa32244220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Oct 2020 17:04:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0730642047;
        Fri,  9 Oct 2020 17:04:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABCF342042;
        Fri,  9 Oct 2020 17:04:11 +0000 (GMT)
Received: from [9.199.46.138] (unknown [9.199.46.138])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Oct 2020 17:04:11 +0000 (GMT)
Subject: Re: [PATCH v9 5/9] ext4: main fast-commit commit path
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-6-harshadshirwadkar@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <c7d7d7b8-c7fe-4780-002b-8f68db988b19@linux.ibm.com>
Date:   Fri, 9 Oct 2020 22:34:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200919005451.3899779-6-harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_08:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090125
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 9/19/20 6:24 AM, Harshad Shirwadkar wrote:
> This patch adds main fast commit commit path handlers. The overall
> patch can be divided into two inter-related parts:
> 
> (A) Metadata updates tracking
> 
>      This part consists of helper functions to track changes that need
>      to be committed during a commit operation. These updates are
>      maintained by Ext4 in different in-memory queues. Following are
>      the APIs and their short description that are implemented in this
>      patch:
> 
>      - ext4_fc_track_link/unlink/creat() - Track unlink. link and creat
>        operations
>      - ext4_fc_track_range() - Track changed logical block offsets
>        inodes
>      - ext4_fc_track_inode() - Track inodes
>      - ext4_fc_mark_ineligible() - Mark file system fast commit
>        ineligible()
>      - ext4_fc_start_update() / ext4_fc_stop_update() /
>        ext4_fc_start_ineligible() / ext4_fc_stop_ineligible() These
>        functions are useful for co-ordinating inode updates with
>        commits.
> 
> (B) Main commit Path
> 
>      This part consists of functions to convert updates tracked in
>      in-memory data structures into on-disk commits. Function
>      ext4_fc_commit() is the main entry point to commit path.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>   fs/ext4/acl.c               |    2 +
>   fs/ext4/ext4.h              |   61 ++
>   fs/ext4/extents.c           |   48 +-
>   fs/ext4/fast_commit.c       | 1209 +++++++++++++++++++++++++++++++++++
>   fs/ext4/fast_commit.h       |  111 ++++
>   fs/ext4/file.c              |   10 +-
>   fs/ext4/fsync.c             |    2 +-
>   fs/ext4/inode.c             |   41 +-
>   fs/ext4/ioctl.c             |   16 +-
>   fs/ext4/namei.c             |   36 +-
>   fs/ext4/super.c             |   31 +
>   fs/ext4/xattr.c             |    3 +
>   fs/jbd2/commit.c            |   42 ++
>   fs/jbd2/journal.c           |  119 +++-
>   include/linux/jbd2.h        |    6 +
>   include/trace/events/ext4.h |  172 +++++
>   16 files changed, 1882 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
> index 76f634d185f1..68aaed48315f 100644
> --- a/fs/ext4/acl.c
> +++ b/fs/ext4/acl.c
> @@ -242,6 +242,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
>   	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
>   	if (IS_ERR(handle))
>   		return PTR_ERR(handle);
> +	ext4_fc_start_update(inode);
> 
>   	if ((type == ACL_TYPE_ACCESS) && acl) {
>   		error = posix_acl_update_mode(inode, &mode, &acl);
> @@ -259,6 +260,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
>   	}
>   out_stop:
>   	ext4_journal_stop(handle);
> +	ext4_fc_stop_update(inode);
>   	if (error == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>   		goto retry;
>   	return error;
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9af3971dd12e..27d48d166e5d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1022,6 +1022,27 @@ struct ext4_inode_info {
> 
>   	struct list_head i_orphan;	/* unlinked but open inodes */
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
> +	struct mutex i_fc_lock;

Although the code does explain the use of i_fc_lock.
But a small comment here explaining what does this mutex lock protects 
will be helpful.

>   	/*
>   	 * i_disksize keeps track of what the inode size is ON DISK, not
>   	 * in memory.  During truncate, i_size is set to the new size by
> @@ -1142,6 +1163,10 @@ struct ext4_inode_info {
>   #define	EXT4_VALID_FS			0x0001	/* Unmounted cleanly */
>   #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
>   #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
> +#define EXT4_FC_INELIGIBLE		0x0008	/* Fast commit ineligible */
> +#define EXT4_FC_COMMITTING		0x0010	/* File system underoing a fast
> +						 * commit.
> +						 */
> 
>   /*
>    * Misc. filesystem flags
> @@ -1614,6 +1639,25 @@ struct ext4_sb_info {
>   	/* Record the errseq of the backing block device */
>   	errseq_t s_bdev_wb_err;
>   	spinlock_t s_bdev_wb_lock;
> +
> +	/* Ext4 fast commit stuff */
> +	atomic_t s_fc_subtid;
> +	atomic_t s_fc_ineligible_updates;
> +	/*
> +	 * After commit starts, the main queue gets locked, and the further
> +	 * updates get added in the the staging queue
> +	 */
> +#define FC_Q_MAIN	0
> +#define FC_Q_STAGING	1
> +	struct list_head s_fc_q[2];	/* Inodes staged for fast commit
> +					 * that have data changes in them.
> +					 */
> +	struct list_head s_fc_dentry_q[2];	/* directory entry updates */
> +	int s_fc_bytes;

We don't need unsigned long for s_fc_bytes here is it?


> +	spinlock_t s_fc_lock;

some comment pls explaining what all this s_fc_lock protects?

> +	struct buffer_head *s_fc_bh;
> +	struct ext4_fc_stats s_fc_stats;
> +	u64 s_fc_avg_commit_time;
>   };


Also I really like this i_fc_** & s_fc_** & ext4_fc_**() convention :)


> 
>   static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
> @@ -1724,6 +1768,7 @@ enum {
>   	EXT4_STATE_EXT_PRECACHED,	/* extents have been precached */
>   	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
>   	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
> +	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
>   };
> 
>   #define EXT4_INODE_BIT_FNS(name, field, offset)				\
> @@ -2683,6 +2728,22 @@ extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
>   /* fast_commit.c */
> 
>   void ext4_fc_init(struct super_block *sb, journal_t *journal);
> +void ext4_fc_init_inode(struct inode *inode);
> +void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
> +			 ext4_lblk_t end);
> +void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry);
> +void ext4_fc_track_link(struct inode *inode, struct dentry *dentry);
> +void ext4_fc_track_create(struct inode *inode, struct dentry *dentry);
> +void ext4_fc_track_inode(struct inode *inode);
> +void ext4_fc_mark_ineligible(struct super_block *sb, int reason);
> +void ext4_fc_start_ineligible(struct super_block *sb, int reason);
> +void ext4_fc_stop_ineligible(struct super_block *sb);
> +void ext4_fc_start_update(struct inode *inode);
> +void ext4_fc_stop_update(struct inode *inode);
> +void ext4_fc_del(struct inode *inode);
> +int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
> +int __init ext4_fc_init_dentry_cache(void);
> +
>   /* mballoc.c */
>   extern const struct seq_operations ext4_mb_seq_groups_ops;
>   extern long ext4_mb_stats;
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a0481582187a..8de236fedade 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3723,6 +3723,7 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
>   	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
>   out:
>   	ext4_ext_show_leaf(inode, path);
> +	ext4_fc_track_range(inode, ee_block, ee_block + ee_len - 1);
>   	return err;
>   }
> 
> @@ -3794,6 +3795,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>   	if (*allocated > map->m_len)
>   		*allocated = map->m_len;
>   	map->m_len = *allocated;
> +	ext4_fc_track_range(inode, ee_block, ee_block + ee_len - 1);
>   	return 0;
>   }
> 
> @@ -4327,7 +4329,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   	map->m_len = ar.len;
>   	allocated = map->m_len;
>   	ext4_ext_show_leaf(inode, path);
> -
> +	ext4_fc_track_range(inode, map->m_lblk, map->m_len);

Shouldn't the last argument be map->m_lblk + map->m_len - 1, no?



>   out:
>   	ext4_ext_drop_refs(path);
>   	kfree(path);
> @@ -4600,7 +4602,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>   	ret = ext4_mark_inode_dirty(handle, inode);
>   	if (unlikely(ret))
>   		goto out_handle;
> -
> +	ext4_fc_track_range(inode, offset >> inode->i_sb->s_blocksize_bits,
> +			(offset + len - 1) >> inode->i_sb->s_blocksize_bits);
>   	/* Zero out partial block at the edges of the range */
>   	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
>   	if (ret >= 0)
> @@ -4648,23 +4651,34 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>   		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
>   		     FALLOC_FL_INSERT_RANGE))
>   		return -EOPNOTSUPP;
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
>   	ret = ext4_convert_inline_data(inode);
>   	if (ret)
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
>   	trace_ext4_fallocate_enter(inode, offset, len, mode);
>   	lblk = offset >> blkbits;
> 
> @@ -4698,12 +4712,14 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>   		goto out;
> 
>   	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
> -		ret = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
> -						EXT4_I(inode)->i_sync_tid);
> +		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
> +					EXT4_I(inode)->i_sync_tid);
>   	}
>   out:
>   	inode_unlock(inode);
>   	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
> +exit:
> +	ext4_fc_stop_update(inode);
>   	return ret;
>   }
> 
> @@ -5291,6 +5307,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>   		ret = PTR_ERR(handle);
>   		goto out_mmap;
>   	}
> +	ext4_fc_start_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
> 
>   	down_write(&EXT4_I(inode)->i_data_sem);
>   	ext4_discard_preallocations(inode, 0);
> @@ -5329,6 +5346,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
> 
>   out_stop:
>   	ext4_journal_stop(handle);
> +	ext4_fc_stop_ineligible(sb);
>   out_mmap:
>   	up_write(&EXT4_I(inode)->i_mmap_sem);
>   out_mutex:
> @@ -5429,6 +5447,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
>   		ret = PTR_ERR(handle);
>   		goto out_mmap;
>   	}
> +	ext4_fc_start_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE);
> 
>   	/* Expand file to avoid data loss if there is error while shifting */
>   	inode->i_size += len;
> @@ -5503,6 +5522,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
> 
>   out_stop:
>   	ext4_journal_stop(handle);
> +	ext4_fc_stop_ineligible(sb);
>   out_mmap:
>   	up_write(&EXT4_I(inode)->i_mmap_sem);
>   out_mutex:
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index f2d11b4c6b62..1c3e5f39d643 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -7,13 +7,1211 @@
>    *
>    * Ext4 fast commits routines.
>    */
> +#include "ext4.h"
>   #include "ext4_jbd2.h"
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
> + * - EXT4_FC_TAG_DEL_RANGE	- recordd deletion of blocks from an inode

s/recordd/records


> + *
> + * (C) Inode metadata (mtime / ctime etc):
> + *
> + * - EXT4_FC_TAG_INODE_FULL	- record the inode that should be replayed as is
> + *				  during recovery. This tag is useful for
> + *				  setting up a new inode. This tag is necessary
> + *				  for CREAT tag.
> + * - EXT4_FC_TAG_INODE_PARTIAL	- record the inode that should only partially be
> + *				  be replayed during recovery. This tag is
> + *				  useful when the same inode has had updates
> + *				  recorded as ADD_RANGE or DEL_RANGE tags.

So we keep INODE_FULL to only track the inode metdata.
and PARTIAL is to track for any extent add/del range operations right?
Is there anything else that I am missing?


> + *
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
> + * uses "EXT4_FC_TAG_TAIL" tag that marks a fast commit as complete. Tail
> + * tag contains CRC of the contents and TID of the transaction after which
> + * this fast commit should be applied. Recovery code replays fast commit
> + * logs only if there's at least 1 valid tail present. For every fast commit
> + * operation, there is 1 tail. This means, we may end up with multiple tails
> + * in the fast commit space. Here's an example:
> + *
> + * - Create a new file A and remove existing file B
> + * - fsync()
> + * - Append contents to file A
> + * - Truncate file A
> + * - fsync()
> + *
> + * The fast commit space at the end of above operations would look like this:
> + *      [HEAD] [CREAT A] [UNLINK B] [TAIL] [ADD_RANGE A] [DEL_RANGE A] [TAIL]
> + *             |<---  Fast Commit 1   --->|<---      Fast Commit 2     ---->|
> + *
> + * Replay code should thus check for all the valid tails in the FC area.
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
> +	if (list_empty(&EXT4_I(inode)->i_fc_list))

We can use ei->i_fc_list directly.



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


Redundant check, so let's remove this.



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
> +		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> +		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +		schedule();
> +		finish_wait(wq, &wait.wq_entry);
> +		goto restart;
> +	}
> +	if (!list_empty(&ei->i_fc_list))
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
> +		node->fcd_name.name = kmalloc(dentry->d_name.len, GFP_KERNEL);


Shouldn't this be GFP_NOFS too?



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
> +	lock_buffer(bh);
> +	clear_buffer_dirty(bh);
> +	set_buffer_uptodate(bh);

Please don't mind me asking this.
But shouldn't we clear the buffer dirty after the IO is submitted
and update will be set once the IO is completed?
Maybe I am missing something here.


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

why do we need +1 here?



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
> +static int ext4_fc_write_inode(struct inode *inode, u32 *crc, int tag)
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
> +	tl.fc_tag = cpu_to_le16(tag);
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
> +
> +	return 0;
> +}
> +
> +/*
> + * Writes updated data ranges for the inode in question. Updates CRC.
> + * Returns 0 on success, error otherwise.
> + */
> +static int ext4_fc_write_data(struct inode *inode, u32 *crc)
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
> +			ex->ee_len = cpu_to_le32(map.m_len);
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
> +/*
> + * Commit data inode. If tag == EXT4_FC_TAG_INODE_PARTIAL, we write the
> + * updated ranges for that inode before committing the inode itself.
> + * This ensures that the during the replay inode->i_block[] is properly
> + * initiated before the partial replay of the inode.
> + */
> +static int ext4_fc_commit_inode(journal_t *journal, struct inode *inode,
> +				u32 *crc, int tag)
> +{
> +	int ret;
> +	int commit_full_inode =
> +		tag == EXT4_FC_TAG_INODE_FULL || ext4_has_inline_data(inode);
> +
> +	if (commit_full_inode) {
> +		ret = ext4_fc_write_inode(inode, crc, tag);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = ext4_fc_write_data(inode, crc);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!commit_full_inode)
> +		ret = ext4_fc_write_inode(inode, crc, tag);
> +
> +	return ret;
> +}
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
> +		ret = jbd2_submit_inode_data(journal, ei->jinode);
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
> +	spin_lock(&sbi->s_fc_lock);
> +	if (list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN])) {
> +		spin_unlock(&sbi->s_fc_lock);
> +		return 0;
> +	}
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
> +		ret = ext4_fc_commit_inode(journal, inode, crc,
> +						EXT4_FC_TAG_INODE_FULL);
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
> +	spin_unlock(&sbi->s_fc_lock);
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
> +	if (!list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN])) {

This looks redundant check here. Since we anyway check for list
emptiness inside ext4_fc_commit_dentry_updates func()
with s_fc_lock held.
That should simplify this code block. I guess then we only need to call
ext4_fc_commit_dentry_updates().

> +		spin_unlock(&sbi->s_fc_lock);
> +		ret = ext4_fc_commit_dentry_updates(journal, &crc);
> +		if (ret)
> +			goto out;
> +		spin_lock(&sbi->s_fc_lock);
> +	}
> +
> +	list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
> +		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
> +		inode = &iter->vfs_inode;
> +		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
> +			continue;
> +
> +		spin_unlock(&sbi->s_fc_lock);
> +		/*
> +		 * Given that we have already written data range updates for
> +		 * this inode, we don't want the recovery code to recreate
> +		 * the entire inode at this point. Also, the recovery code
> +		 * allocator may make slightly different decisions for
> +		 * extent tree blocks allocations, resulting in potentially
> +		 * different inode.i_blocks and inode.i_block[]. So, until
> +		 * we have identical allocator in recovery path, we should
> +		 * record only partial inode here.
> +		 */
> +		ret = ext4_fc_commit_inode(journal, inode, &crc,
> +						EXT4_FC_TAG_INODE_PARTIAL);
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
> +	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
> +		(ext4_fc_is_ineligible(sb))) {
> +		reason = EXT4_FC_REASON_INELIGIBLE;
> +		goto out;
> +	}
> +
> +	start_time = ktime_get();
> +restart_fc:
> +	ret = jbd2_fc_start(journal, commit_tid);
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
> +	jbd2_fc_stop(journal);
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
> +		return jbd2_fc_stop_do_commit(journal, commit_tid);
> +	if (reason == EXT4_FC_REASON_FC_START_FAILED ||
> +		reason == EXT4_FC_REASON_INELIGIBLE)
> +		return jbd2_complete_transaction(journal, commit_tid);
> +	return 0;
> +}
> +
>   /*
>    * Fast commit cleanup routine. This is called after every fast commit and
>    * full commit. full is true if we are called after a full commit.
>    */
>   static void ext4_fc_cleanup(journal_t *journal, int full)
>   {
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
>   }
> 
>   void ext4_fc_init(struct super_block *sb, journal_t *journal)
> @@ -26,3 +1224,14 @@ void ext4_fc_init(struct super_block *sb, journal_t *journal)
>   		ext4_clear_feature_fast_commit(sb);
>   	}
>   }
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
> index 8362bf5e6e00..a541d2bbe24b 100644
> --- a/fs/ext4/fast_commit.h
> +++ b/fs/ext4/fast_commit.h
> @@ -6,4 +6,115 @@
>   /* Number of blocks in journal area to allocate for fast commits */
>   #define EXT4_NUM_FC_BLKS		256
> 
> +/* Fast commit tags */
> +#define EXT4_FC_TAG_ADD_RANGE		0x0001
> +#define EXT4_FC_TAG_DEL_RANGE		0x0002
> +#define EXT4_FC_TAG_CREAT		0x0003
> +#define EXT4_FC_TAG_LINK		0x0004
> +#define EXT4_FC_TAG_UNLINK		0x0005
> +#define EXT4_FC_TAG_INODE_FULL		0x0006
> +#define EXT4_FC_TAG_INODE_PARTIAL	0x0007
> +#define EXT4_FC_TAG_PAD			0x0008
> +#define EXT4_FC_TAG_TAIL		0x0009
> +#define EXT4_FC_TAG_HEAD		0x000A
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
> +	int fc_ineligible_reason_count[EXT4_FC_REASON_MAX];
> +	int fc_num_commits;
> +	int fc_ineligible_commits;
> +	int fc_numblks; > +};

I guess, all above counters should be unsigned int or unsigned long right?




> +
>   #endif /* __FAST_COMMIT_H__ */
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index e608ce3fb535..018f698caa71 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -260,6 +260,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>   	if (iocb->ki_flags & IOCB_NOWAIT)
>   		return -EOPNOTSUPP;
> 
> +	ext4_fc_start_update(inode);
>   	inode_lock(inode);
>   	ret = ext4_write_checks(iocb, from);
>   	if (ret <= 0)
> @@ -271,6 +272,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> 
>   out:
>   	inode_unlock(inode);
> +	ext4_fc_stop_update(inode);
>   	if (likely(ret > 0)) {
>   		iocb->ki_pos += ret;
>   		ret = generic_write_sync(iocb, ret);
> @@ -527,6 +529,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (unaligned_io)
>   		inode_dio_wait(inode);
> 
> +	ext4_fc_start_update(inode);
>   	if (extend) {
>   		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>   		if (IS_ERR(handle)) {
> @@ -556,6 +559,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		inode_unlock_shared(inode);
>   	else
>   		inode_unlock(inode);
> +	ext4_fc_stop_update(inode);
> 
>   	if (ret >= 0 && iov_iter_count(from)) {
>   		ssize_t err;
> @@ -654,8 +658,8 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   #endif
>   	if (iocb->ki_flags & IOCB_DIRECT)
>   		return ext4_dio_write_iter(iocb, from);
> -
> -	return ext4_buffered_write_iter(iocb, from);
> +	else
> +		return ext4_buffered_write_iter(iocb, from);
>   }
> 
>   #ifdef CONFIG_FS_DAX
> @@ -755,6 +759,7 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>   	if (!daxdev_mapping_supported(vma, dax_dev))
>   		return -EOPNOTSUPP;
> 
> +	ext4_fc_start_update(inode);
>   	file_accessed(file);
>   	if (IS_DAX(file_inode(file))) {
>   		vma->vm_ops = &ext4_dax_vm_ops;
> @@ -762,6 +767,7 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>   	} else {
>   		vma->vm_ops = &ext4_file_vm_ops;
>   	}
> +	ext4_fc_stop_update(inode);
>   	return 0;
>   }
> 
> diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
> index 1d668c8f131f..7c9fa35a01d1 100644
> --- a/fs/ext4/fsync.c
> +++ b/fs/ext4/fsync.c
> @@ -112,7 +112,7 @@ static int ext4_fsync_journal(struct inode *inode, bool datasync,
>   	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
>   		*needs_barrier = true;
> 
> -	return jbd2_complete_transaction(journal, commit_tid);
> +	return ext4_fc_commit(journal, commit_tid);
>   }
> 
>   /*
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 77543f988258..26eed76812f9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -729,6 +729,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>   			if (ret)
>   				return ret;
>   		}
> +		ext4_fc_track_range(inode, map->m_lblk,
> +			    map->m_lblk + map->m_len - 1);
>   	}
> 
>   	if (retval < 0)
> @@ -4073,6 +4075,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
> 
>   		up_write(&EXT4_I(inode)->i_data_sem);
>   	}
> +	ext4_fc_track_range(inode, first_block, stop_block);
>   	if (IS_SYNC(inode))
>   		ext4_handle_sync(handle);
> 
> @@ -4703,6 +4706,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>   	for (block = 0; block < EXT4_N_BLOCKS; block++)
>   		ei->i_data[block] = raw_inode->i_block[block];
>   	INIT_LIST_HEAD(&ei->i_orphan);
> +	ext4_fc_init_inode(&ei->vfs_inode);
> 
>   	/*
>   	 * Set transaction id's of transactions that have to be committed
> @@ -5149,7 +5153,7 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
>   		if (wbc->sync_mode != WB_SYNC_ALL || wbc->for_sync)
>   			return 0;
> 
> -		err = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
> +		err = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
>   						EXT4_I(inode)->i_sync_tid);
>   	} else {
>   		struct ext4_iloc iloc;
> @@ -5278,6 +5282,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
>   		if (error)
>   			return error;
>   	}
> +	ext4_fc_start_update(inode);
>   	if ((ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
>   	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
>   		handle_t *handle;
> @@ -5301,6 +5306,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
> 
>   		if (error) {
>   			ext4_journal_stop(handle);
> +			ext4_fc_stop_update(inode);
>   			return error;
>   		}
>   		/* Update corresponding info in inode so that everything is in
> @@ -5323,11 +5329,15 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
>   		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
>   			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> 
> -			if (attr->ia_size > sbi->s_bitmap_maxbytes)
> +			if (attr->ia_size > sbi->s_bitmap_maxbytes) {
> +				ext4_fc_stop_update(inode);
>   				return -EFBIG;
> +			}
>   		}
> -		if (!S_ISREG(inode->i_mode))
> +		if (!S_ISREG(inode->i_mode)) {
> +			ext4_fc_stop_update(inode);
>   			return -EINVAL;
> +		}
> 
>   		if (IS_I_VERSION(inode) && attr->ia_size != inode->i_size)
>   			inode_inc_iversion(inode);
> @@ -5351,7 +5361,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
>   		rc = ext4_break_layouts(inode);
>   		if (rc) {
>   			up_write(&EXT4_I(inode)->i_mmap_sem);
> -			return rc;
> +			goto err_out;
>   		}
> 
>   		if (attr->ia_size != inode->i_size) {
> @@ -5372,6 +5382,21 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
>   				inode->i_mtime = current_time(inode);
>   				inode->i_ctime = inode->i_mtime;
>   			}
> +
> +			if (shrink)
> +				ext4_fc_track_range(inode,
> +					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
> +					inode->i_sb->s_blocksize_bits,
> +					(oldsize > 0 ? oldsize - 1 : 0) >>
> +					inode->i_sb->s_blocksize_bits);
> +			else
> +				ext4_fc_track_range(
> +					inode,
> +					(oldsize > 0 ? oldsize - 1 : oldsize) >>
> +					inode->i_sb->s_blocksize_bits,
> +					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
> +					inode->i_sb->s_blocksize_bits);
> +
>   			down_write(&EXT4_I(inode)->i_data_sem);
>   			EXT4_I(inode)->i_disksize = attr->ia_size;
>   			rc = ext4_mark_inode_dirty(handle, inode);
> @@ -5430,9 +5455,11 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
>   		rc = posix_acl_chmod(inode, inode->i_mode);
> 
>   err_out:
> -	ext4_std_error(inode->i_sb, error);
> +	if  (error)
> +		ext4_std_error(inode->i_sb, error);
>   	if (!error)
>   		error = rc;
> +	ext4_fc_stop_update(inode);
>   	return error;
>   }
> 
> @@ -5614,6 +5641,8 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>   		put_bh(iloc->bh);
>   		return -EIO;
>   	}
> +	ext4_fc_track_inode(inode);
> +
>   	if (IS_I_VERSION(inode))
>   		inode_inc_iversion(inode);
> 
> @@ -5937,6 +5966,8 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
>   	if (IS_ERR(handle))
>   		return PTR_ERR(handle);
> 
> +	ext4_fc_mark_ineligible(inode->i_sb,
> +		EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
>   	err = ext4_mark_inode_dirty(handle, inode);
>   	ext4_handle_sync(handle);
>   	ext4_journal_stop(handle);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 36eca3bc036a..d2f8f50deef6 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -165,6 +165,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>   		err = -EINVAL;
>   		goto err_out;
>   	}
> +	ext4_fc_start_ineligible(sb, EXT4_FC_REASON_SWAP_BOOT);
> 
>   	/* Protect extent tree against block allocations via delalloc */
>   	ext4_double_down_write_data_sem(inode, inode_bl);
> @@ -247,6 +248,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
> 
>   err_out1:
>   	ext4_journal_stop(handle);
> +	ext4_fc_stop_ineligible(sb);
>   	ext4_double_up_write_data_sem(inode, inode_bl);
> 
>   err_out:
> @@ -807,7 +809,7 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>   	return error;
>   }
> 
> -long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   {
>   	struct inode *inode = file_inode(filp);
>   	struct super_block *sb = inode->i_sb;
> @@ -1074,6 +1076,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> 
>   		err = ext4_resize_fs(sb, n_blocks_count);
>   		if (EXT4_SB(sb)->s_journal) {
> +			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE);
>   			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
>   			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
>   			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
> @@ -1308,6 +1311,17 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   	}
>   }
> 
> +long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	long ret;
> +
> +	ext4_fc_start_update(file_inode(filp));
> +	ret = __ext4_ioctl(filp, cmd, arg);
> +	ext4_fc_stop_update(file_inode(filp));
> +
> +	return ret;
> +}
> +
>   #ifdef CONFIG_COMPAT
>   long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   {
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 153a9fbe1dd0..563243f3b682 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2611,7 +2611,7 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>   		       bool excl)
>   {
>   	handle_t *handle;
> -	struct inode *inode;
> +	struct inode *inode, *inode_save;
>   	int err, credits, retries = 0;
> 
>   	err = dquot_initialize(dir);
> @@ -2629,7 +2629,11 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>   		inode->i_op = &ext4_file_inode_operations;
>   		inode->i_fop = &ext4_file_operations;
>   		ext4_set_aops(inode);
> +		inode_save = inode;
> +		ihold(inode_save);
>   		err = ext4_add_nondir(handle, dentry, &inode);
> +		ext4_fc_track_create(inode_save, dentry);

Shouldn't we check for err before calling ext4_fc_track_create?


> +		iput(inode_save);
>   	}
>   	if (handle)
>   		ext4_journal_stop(handle);
> @@ -2644,7 +2648,7 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
>   		      umode_t mode, dev_t rdev)
>   {
>   	handle_t *handle;
> -	struct inode *inode;
> +	struct inode *inode, *inode_save;
>   	int err, credits, retries = 0;
> 
>   	err = dquot_initialize(dir);
> @@ -2661,7 +2665,12 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
>   	if (!IS_ERR(inode)) {
>   		init_special_inode(inode, inode->i_mode, rdev);
>   		inode->i_op = &ext4_special_inode_operations;
> +		inode_save = inode;
> +		ihold(inode_save);
>   		err = ext4_add_nondir(handle, dentry, &inode);
> +		if (!err)
> +			ext4_fc_track_create(inode_save, dentry);
> +		iput(inode_save);
>   	}
>   	if (handle)
>   		ext4_journal_stop(handle);
> @@ -2825,6 +2834,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>   		iput(inode);
>   		goto out_retry;
>   	}
> +	ext4_fc_track_create(inode, dentry);
>   	ext4_inc_count(handle, dir);
>   	ext4_update_dx_flag(dir);
>   	err = ext4_mark_inode_dirty(handle, dir);
> @@ -3165,6 +3175,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
>   		goto end_rmdir;
>   	ext4_dec_count(handle, dir);
>   	ext4_update_dx_flag(dir);
> +	ext4_fc_track_unlink(inode, dentry);
>   	retval = ext4_mark_inode_dirty(handle, dir);
> 
>   #ifdef CONFIG_UNICODE
> @@ -3251,6 +3262,8 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
>   	inode->i_ctime = current_time(inode);
>   	retval = ext4_mark_inode_dirty(handle, inode);
> 
> +	if (!retval)
> +		ext4_fc_track_unlink(d_inode(dentry), dentry);
>   #ifdef CONFIG_UNICODE
>   	/* VFS negative dentries are incompatible with Encoding and
>   	 * Case-insensitiveness. Eventually we'll want avoid
> @@ -3872,6 +3885,22 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
>   	retval = ext4_mark_inode_dirty(handle, old.dir);
>   	if (unlikely(retval))
>   		goto end_rename;
> +
> +	if (S_ISDIR(old.inode->i_mode)) {
> +		/*
> +		 * We disable fast commits here that's because the
> +		 * replay code is not yet capable of changing dot dot
> +		 * dirents in directories.
> +		 */
> +		ext4_fc_mark_ineligible(old.inode->i_sb,
> +			EXT4_FC_REASON_RENAME_DIR);
> +	} else {
> +		if (new.inode)
> +			ext4_fc_track_unlink(new.inode, new.dentry);
> +		ext4_fc_track_link(old.inode, new.dentry);
> +		ext4_fc_track_unlink(old.inode, old.dentry);
> +	}
> +
>   	if (new.inode) {
>   		retval = ext4_mark_inode_dirty(handle, new.inode);
>   		if (unlikely(retval))
> @@ -4015,7 +4044,8 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>   	retval = ext4_mark_inode_dirty(handle, new.inode);
>   	if (unlikely(retval))
>   		goto end_rename;
> -
> +	ext4_fc_mark_ineligible(new.inode->i_sb,
> +				EXT4_FC_REASON_CROSS_RENAME);
>   	if (old.dir_bh) {
>   		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
>   		if (retval)
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 94aaaf940449..2a959e2c7a91 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1149,6 +1149,8 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>   	ei->i_datasync_tid = 0;
>   	atomic_set(&ei->i_unwritten, 0);
>   	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
> +	ext4_fc_init_inode(&ei->vfs_inode);
> +	mutex_init(&ei->i_fc_lock);
>   	return &ei->vfs_inode;
>   }
> 
> @@ -1166,6 +1168,10 @@ static int ext4_drop_inode(struct inode *inode)
>   static void ext4_free_in_core_inode(struct inode *inode)
>   {
>   	fscrypt_free_inode(inode);
> +	if (!list_empty(&(EXT4_I(inode)->i_fc_list))) {
> +		pr_warn("%s: inode %ld still in fc list",
> +			__func__, inode->i_ino);
> +	}
>   	kmem_cache_free(ext4_inode_cachep, EXT4_I(inode));
>   }
> 
> @@ -1191,6 +1197,7 @@ static void init_once(void *foo)
>   	init_rwsem(&ei->i_data_sem);
>   	init_rwsem(&ei->i_mmap_sem);
>   	inode_init_once(&ei->vfs_inode);
> +	ext4_fc_init_inode(&ei->vfs_inode);
>   }
> 
>   static int __init init_inodecache(void)
> @@ -1219,6 +1226,7 @@ static void destroy_inodecache(void)
> 
>   void ext4_clear_inode(struct inode *inode)
>   {
> +	ext4_fc_del(inode);
>   	invalidate_inode_buffers(inode);
>   	clear_inode(inode);
>   	ext4_discard_preallocations(inode, 0);
> @@ -4540,6 +4548,19 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>   	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
>   	mutex_init(&sbi->s_orphan_lock);
> 
> +	/* Initialize fast commit stuff */
> +	atomic_set(&sbi->s_fc_subtid, 0);
> +	atomic_set(&sbi->s_fc_ineligible_updates, 0);
> +	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_MAIN]);
> +	INIT_LIST_HEAD(&sbi->s_fc_q[FC_Q_STAGING]);
> +	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_MAIN]);
> +	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_STAGING]);
> +	sbi->s_fc_bytes = 0;
> +	sbi->s_mount_state &= ~EXT4_FC_INELIGIBLE;
> +	sbi->s_mount_state &= ~EXT4_FC_COMMITTING;
> +	spin_lock_init(&sbi->s_fc_lock);
> +	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
> +
>   	sb->s_root = NULL;
> 
>   	needs_recovery = (es->s_last_orphan != 0 ||
> @@ -6312,6 +6333,10 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
>   	brelse(bh);
>   out:
>   	if (inode->i_size < off + len) {
> +		ext4_fc_track_range(inode,
> +			(inode->i_size > 0 ? inode->i_size - 1 : 0)
> +				>> inode->i_sb->s_blocksize_bits,
> +			(off + len) >> inode->i_sb->s_blocksize_bits);
>   		i_size_write(inode, off + len);
>   		EXT4_I(inode)->i_disksize = inode->i_size;
>   		err2 = ext4_mark_inode_dirty(handle, inode);
> @@ -6440,6 +6465,11 @@ static int __init ext4_init_fs(void)
>   	err = init_inodecache();
>   	if (err)
>   		goto out1;
> +
> +	err = ext4_fc_init_dentry_cache();
> +	if (err)
> +		goto out05;
> +
>   	register_as_ext3();
>   	register_as_ext2();
>   	err = register_filesystem(&ext4_fs_type);
> @@ -6450,6 +6480,7 @@ static int __init ext4_init_fs(void)
>   out:
>   	unregister_as_ext2();
>   	unregister_as_ext3();
> +out05:
>   	destroy_inodecache();
>   out1:
>   	ext4_exit_mballoc();
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index cba4b877c606..6127e94ea4f5 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2419,6 +2419,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
>   		if (IS_SYNC(inode))
>   			ext4_handle_sync(handle);
>   	}
> +	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR);
> 
>   cleanup:
>   	brelse(is.iloc.bh);
> @@ -2496,6 +2497,7 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
>   		if (error == 0)
>   			error = error2;
>   	}
> +	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR);
> 
>   	return error;
>   }
> @@ -2928,6 +2930,7 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
>   					 error);
>   			goto cleanup;
>   		}
> +		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR);
>   	}
>   	error = 0;
>   cleanup:
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index ba35ecb18616..dadd9994e74b 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -202,6 +202,47 @@ static int journal_submit_inode_data_buffers(struct address_space *mapping,
>   	return ret;
>   }
> 
> +/* Send all the data buffers related to an inode */
> +int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
> +{
> +	struct address_space *mapping;
> +	loff_t dirty_start;
> +	loff_t dirty_end;
> +	int ret;
> +
> +	if (!jinode)
> +		return 0;
> +
> +	dirty_start = jinode->i_dirty_start;
> +	dirty_end = jinode->i_dirty_end;
> +
> +	if (!(jinode->i_flags & JI_WRITE_DATA))
> +		return 0;

This can be clubbed with above if logic to check if !jinode

> +
> +	dirty_start = jinode->i_dirty_start;
> +	dirty_end = jinode->i_dirty_end;

redundant check

> +
> +	mapping = jinode->i_vfs_inode->i_mapping;
> +
> +	trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
> +	ret = journal_submit_inode_data_buffers(mapping, dirty_start,
> +						dirty_end);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(jbd2_submit_inode_data);
> +
> +int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode)
> +{
> +	if (!jinode || !(jinode->i_flags & JI_WAIT_DATA) ||
> +		!jinode->i_vfs_inode || !jinode->i_vfs_inode->i_mapping)
> +		return 0;
> +	return filemap_fdatawait_range_keep_errors(
> +		jinode->i_vfs_inode->i_mapping, jinode->i_dirty_start,
> +		jinode->i_dirty_end);
> +}
> +EXPORT_SYMBOL(jbd2_wait_inode_data);
> +
>   /*
>    * Submit all the data buffers of inode associated with the transaction to
>    * disk.
> @@ -434,6 +475,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>   			commit_transaction->t_tid);
> 
>   	write_lock(&journal->j_state_lock);
> +	journal->j_fc_off = 0;
>   	J_ASSERT(commit_transaction->t_state == T_RUNNING);
>   	commit_transaction->t_state = T_LOCKED;
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 17a30a2c38f9..0661e00b46c0 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -157,7 +157,9 @@ static void commit_timeout(struct timer_list *t)
>    *
>    * 1) COMMIT:  Every so often we need to commit the current state of the
>    *    filesystem to disk.  The journal thread is responsible for writing
> - *    all of the metadata buffers to disk.
> + *    all of the metadata buffers to disk. If a fast commit is ongoing
> + *    journal thread waits until it's done and then continues from
> + *    there on.
>    *
>    * 2) CHECKPOINT: We cannot reuse a used section of the log file until all
>    *    of the data in that part of the log has been rewritten elsewhere on
> @@ -848,6 +850,109 @@ int jbd2_journal_next_log_block(journal_t *journal, unsigned long long *retp)
>   	return jbd2_journal_bmap(journal, blocknr, retp);
>   }
> 
> +/* Map one fast commit buffer for use by the file system */
> +int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
> +{
> +	unsigned long long pblock;
> +	unsigned long blocknr;
> +	int ret = 0;
> +	struct buffer_head *bh;
> +	int fc_off;
> +
> +	*bh_out = NULL;
> +	write_lock(&journal->j_state_lock);
> +
> +	if (journal->j_fc_off + journal->j_first_fc < journal->j_last_fc) {
> +		fc_off = journal->j_fc_off;
> +		blocknr = journal->j_first_fc + fc_off;
> +		journal->j_fc_off++;


Not sure if we need to should roll back j_fc_off in case of errors from
this func.

-ritesh


> +	} else {
> +		ret = -EINVAL;
> +	}
> +	write_unlock(&journal->j_state_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = jbd2_journal_bmap(journal, blocknr, &pblock);
> +	if (ret)
> +		return ret;
> +
> +	bh = __getblk(journal->j_dev, pblock, journal->j_blocksize);
> +	if (!bh)
> +		return -ENOMEM;
> +
> +	lock_buffer(bh);
> +
> +	clear_buffer_uptodate(bh);
> +	set_buffer_dirty(bh);
> +	unlock_buffer(bh);
> +	journal->j_fc_wbuf[fc_off] = bh;
> +
> +	*bh_out = bh;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(jbd2_fc_get_buf);
> +
> +/*
> + * Wait on fast commit buffers that were allocated by jbd2_fc_get_buf
> + * for completion.
> + */
> +int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
> +{
> +	struct buffer_head *bh;
> +	int i, j_fc_off;
> +
> +	read_lock(&journal->j_state_lock);
> +	j_fc_off = journal->j_fc_off;
> +	read_unlock(&journal->j_state_lock);
> +
> +	/*
> +	 * Wait in reverse order to minimize chances of us being woken up before
> +	 * all IOs have completed
> +	 */
> +	for (i = j_fc_off - 1; i >= j_fc_off - num_blks; i--) {
> +		bh = journal->j_fc_wbuf[i];
> +		wait_on_buffer(bh);
> +		put_bh(bh);
> +		journal->j_fc_wbuf[i] = NULL;
> +		if (unlikely(!buffer_uptodate(bh)))
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(jbd2_fc_wait_bufs);
> +
> +/*
> + * Wait on fast commit buffers that were allocated by jbd2_fc_get_buf
> + * for completion.
> + */
> +int jbd2_fc_release_bufs(journal_t *journal)
> +{
> +	struct buffer_head *bh;
> +	int i, j_fc_off;
> +
> +	read_lock(&journal->j_state_lock);
> +	j_fc_off = journal->j_fc_off;
> +	read_unlock(&journal->j_state_lock);
> +
> +	/*
> +	 * Wait in reverse order to minimize chances of us being woken up before
> +	 * all IOs have completed
> +	 */
> +	for (i = j_fc_off - 1; i >= 0; i--) {
> +		bh = journal->j_fc_wbuf[i];
> +		if (!bh)
> +			break;
> +		put_bh(bh);
> +		journal->j_fc_wbuf[i] = NULL;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * Conversion of logical to physical block numbers for the journal
>    *
> @@ -1559,6 +1664,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
>   static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
>   {
>   	journal_superblock_t *sb = journal->j_superblock;
> +	bool had_fast_commit = false;
> 
>   	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
>   	lock_buffer(journal->j_sb_buffer);
> @@ -1572,9 +1678,20 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
> 
>   	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
>   	sb->s_start    = cpu_to_be32(0);
> +	if (jbd2_has_feature_fast_commit(journal)) {
> +		/*
> +		 * When journal is clean, no need to commit fast commit flag and
> +		 * make file system incompatible with older kernels.
> +		 */
> +		jbd2_clear_feature_fast_commit(journal);
> +		had_fast_commit = true;
> +	}
> 
>   	jbd2_write_superblock(journal, write_op);
> 
> +	if (had_fast_commit)
> +		jbd2_set_feature_fast_commit(journal);
> +
>   	/* Log is no longer empty */
>   	write_lock(&journal->j_state_lock);
>   	journal->j_flags |= JBD2_FLUSHED;
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index aad986a9f3ff..11c4ec967662 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1567,6 +1567,12 @@ int jbd2_fc_init(journal_t *journal, int num_fc_blks);
>   int jbd2_fc_start(journal_t *journal, tid_t tid);
>   int jbd2_fc_stop(journal_t *journal);
>   int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid);
> +int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
> +int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
> +int jbd2_fc_release_bufs(journal_t *journal);
> +int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
> +int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
> +
>   /*
>    * is_journal_abort
>    *
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 4c8b99ec8606..c8cb43189f02 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -95,6 +95,16 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
>   	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
>   	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
> 
> +#define show_fc_reason(reason)						\
> +	__print_symbolic(reason,					\
> +		{ EXT4_FC_REASON_XATTR,		"XATTR"},		\
> +		{ EXT4_FC_REASON_CROSS_RENAME,	"CROSS_RENAME"},	\
> +		{ EXT4_FC_REASON_JOURNAL_FLAG_CHANGE, "JOURNAL_FLAG_CHANGE"}, \
> +		{ EXT4_FC_REASON_MEM,	"NO_MEM"},			\
> +		{ EXT4_FC_REASON_SWAP_BOOT,	"SWAP_BOOT"},		\
> +		{ EXT4_FC_REASON_RESIZE,	"RESIZE"},		\
> +		{ EXT4_FC_REASON_RENAME_DIR,	"RENAME_DIR"},		\
> +		{ EXT4_FC_REASON_FALLOC_RANGE,	"FALLOC_RANGE"})
> 
>   TRACE_EVENT(ext4_other_inode_update_time,
>   	TP_PROTO(struct inode *inode, ino_t orig_ino),
> @@ -2791,6 +2801,168 @@ TRACE_EVENT(ext4_lazy_itable_init,
>   		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->group)
>   );
> 
> +TRACE_EVENT(ext4_fc_commit_start,
> +	TP_PROTO(struct super_block *sb),
> +
> +	TP_ARGS(sb),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev = sb->s_dev;
> +	),
> +
> +	TP_printk("fast_commit started on dev %d,%d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev))
> +);
> +
> +TRACE_EVENT(ext4_fc_commit_stop,
> +	    TP_PROTO(struct super_block *sb, int nblks, int reason),
> +
> +	TP_ARGS(sb, nblks, reason),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(int, nblks)
> +		__field(int, reason)
> +		__field(int, num_fc)
> +		__field(int, num_fc_ineligible)
> +		__field(int, nblks_agg)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev = sb->s_dev;
> +		__entry->nblks = nblks;
> +		__entry->reason = reason;
> +		__entry->num_fc = EXT4_SB(sb)->s_fc_stats.fc_num_commits;
> +		__entry->num_fc_ineligible =
> +			EXT4_SB(sb)->s_fc_stats.fc_ineligible_commits;
> +		__entry->nblks_agg = EXT4_SB(sb)->s_fc_stats.fc_numblks;
> +	),
> +
> +	TP_printk("fc on [%d,%d] nblks %d, reason %d, fc = %d, ineligible = %d, agg_nblks %d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->nblks, __entry->reason, __entry->num_fc,
> +		  __entry->num_fc_ineligible, __entry->nblks_agg)
> +);
> +
> +#define FC_REASON_NAME_STAT(reason)					\
> +	show_fc_reason(reason),						\
> +	__entry->sbi->s_fc_stats.fc_ineligible_reason_count[reason]
> +
> +TRACE_EVENT(ext4_fc_stats,
> +	    TP_PROTO(struct super_block *sb),
> +
> +	    TP_ARGS(sb),
> +
> +	    TP_STRUCT__entry(
> +		    __field(dev_t, dev)
> +		    __field(struct ext4_sb_info *, sbi)
> +		    __field(int, count)
> +		    ),
> +
> +	    TP_fast_assign(
> +		    __entry->dev = sb->s_dev;
> +		    __entry->sbi = EXT4_SB(sb);
> +		    ),
> +
> +	    TP_printk("dev %d:%d fc ineligible reasons:\n"
> +		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s,%d; "
> +		      "num_commits:%d, ineligible: %d, numblks: %d",
> +		      MAJOR(__entry->dev), MINOR(__entry->dev),
> +		      FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
> +		      FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
> +		      FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
> +		      FC_REASON_NAME_STAT(EXT4_FC_REASON_MEM),
> +		      FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
> +		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
> +		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
> +		      FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
> +		      __entry->sbi->s_fc_stats.fc_num_commits,
> +		      __entry->sbi->s_fc_stats.fc_ineligible_commits,
> +		      __entry->sbi->s_fc_stats.fc_numblks)
> +
> +);
> +
> +#define DEFINE_TRACE_DENTRY_EVENT(__type)				\
> +	TRACE_EVENT(ext4_fc_track_##__type,				\
> +	    TP_PROTO(struct inode *inode, struct dentry *dentry, int ret), \
> +									\
> +	    TP_ARGS(inode, dentry, ret),				\
> +									\
> +	    TP_STRUCT__entry(						\
> +		    __field(dev_t, dev)					\
> +		    __field(int, ino)					\
> +		    __field(int, error)					\
> +		    ),							\
> +									\
> +	    TP_fast_assign(						\
> +		    __entry->dev = inode->i_sb->s_dev;			\
> +		    __entry->ino = inode->i_ino;			\
> +		    __entry->error = ret;				\
> +		    ),							\
> +									\
> +	    TP_printk("dev %d:%d, inode %d, error %d, fc_%s",		\
> +		      MAJOR(__entry->dev), MINOR(__entry->dev),		\
> +		      __entry->ino, __entry->error,			\
> +		      #__type)						\
> +	)
> +
> +DEFINE_TRACE_DENTRY_EVENT(create);
> +DEFINE_TRACE_DENTRY_EVENT(link);
> +DEFINE_TRACE_DENTRY_EVENT(unlink);
> +
> +TRACE_EVENT(ext4_fc_track_inode,
> +	    TP_PROTO(struct inode *inode, int ret),
> +
> +	    TP_ARGS(inode, ret),
> +
> +	    TP_STRUCT__entry(
> +		    __field(dev_t, dev)
> +		    __field(int, ino)
> +		    __field(int, error)
> +		    ),
> +
> +	    TP_fast_assign(
> +		    __entry->dev = inode->i_sb->s_dev;
> +		    __entry->ino = inode->i_ino;
> +		    __entry->error = ret;
> +		    ),
> +
> +	    TP_printk("dev %d:%d, inode %d, error %d",
> +		      MAJOR(__entry->dev), MINOR(__entry->dev),
> +		      __entry->ino, __entry->error)
> +	);
> +
> +TRACE_EVENT(ext4_fc_track_range,
> +	    TP_PROTO(struct inode *inode, long start, long end, int ret),
> +
> +	    TP_ARGS(inode, start, end, ret),
> +
> +	    TP_STRUCT__entry(
> +		    __field(dev_t, dev)
> +		    __field(int, ino)
> +		    __field(long, start)
> +		    __field(long, end)
> +		    __field(int, error)
> +		    ),
> +
> +	    TP_fast_assign(
> +		    __entry->dev = inode->i_sb->s_dev;
> +		    __entry->ino = inode->i_ino;
> +		    __entry->start = start;
> +		    __entry->end = end;
> +		    __entry->error = ret;
> +		    ),
> +
> +	    TP_printk("dev %d:%d, inode %d, error %d, start %ld, end %ld",
> +		      MAJOR(__entry->dev), MINOR(__entry->dev),
> +		      __entry->ino, __entry->error, __entry->start,
> +		      __entry->end)
> +	);
> +
>   #endif /* _TRACE_EXT4_H */
> 
>   /* This part must be outside protection */
> 
