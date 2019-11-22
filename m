Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCB105D84
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2019 01:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKVAJj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Nov 2019 19:09:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44426 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKVAJj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Nov 2019 19:09:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM04h0w038582;
        Fri, 22 Nov 2019 00:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=3WEjtwgOHTN1Zh8R+D88fKeIyBz12No6pO1N4peTdRM=;
 b=d+RSlFxRUQA5NYwe2XwOHmGseRGg2BOXcYeZRiCV4G0UvVFRCytqHFrFaERJWweeq151
 5YwxOk1nQpTjpFOccgshCHKdshXd8aVmYXfXfaVnqPIzpF7pdOSWt2oY8IGnnSx2qZat
 wP+AACVmSrwEtwUqJyZPkA9Ja5fc9q+/naXQxiwljPXTOpJnpoQzke1j4oD+Eq3tkGbX
 rFexytQkAaiUoPvb7bfdh6pYo4vGC/ObyxDH9+TTQf5iRj2JgcbbRmlGpOm+wIwwuoVh
 AVMV50KXvBBkVANUqqFMmD/HJrzpMWCYsrlDA53UUtZ0mVZPwqgWj7xJfVqZUNzUY/UN zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wa9rqyh8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 00:09:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM08jXO031499;
        Fri, 22 Nov 2019 00:09:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wd47xvsax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 00:09:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAM09Yp5021248;
        Fri, 22 Nov 2019 00:09:34 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 16:09:34 -0800
Date:   Thu, 21 Nov 2019 16:09:33 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: simulate various I/O and checksum errors when
 reading metadata
Message-ID: <20191122000933.GG6213@magnolia>
References: <20191121183036.29385-1-tytso@mit.edu>
 <20191121183036.29385-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121183036.29385-2-tytso@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210203
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210203
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 21, 2019 at 01:30:36PM -0500, Theodore Ts'o wrote:
> This allows us to test various error handling code paths
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/balloc.c |  4 +++-
>  fs/ext4/ext4.h   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  fs/ext4/ialloc.c |  4 +++-
>  fs/ext4/inode.c  |  6 +++++-
>  fs/ext4/namei.c  | 11 ++++++++---
>  fs/ext4/sysfs.c  | 23 +++++++++++++++++++++++
>  6 files changed, 84 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 102c38527a10..5f993a411251 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -371,7 +371,8 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>  	if (buffer_verified(bh))
>  		goto verified;
>  	if (unlikely(!ext4_block_bitmap_csum_verify(sb, block_group,
> -			desc, bh))) {
> +						    desc, bh) ||
> +		     ext4_simulate_fail(sb, EXT4_SIM_BBITMAP_CRC))) {
>  		ext4_unlock_group(sb, block_group);
>  		ext4_error(sb, "bg %u: bad block bitmap checksum", block_group);
>  		ext4_mark_group_bitmap_corrupted(sb, block_group,
> @@ -505,6 +506,7 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
>  	if (!desc)
>  		return -EFSCORRUPTED;
>  	wait_on_buffer(bh);
> +	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_BBITMAP_EIO);
>  	if (!buffer_uptodate(bh)) {
>  		ext4_set_errno(sb, EIO);
>  		ext4_error(sb, "Cannot read block bitmap - "
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1c9ac0fc8715..e6798db4634c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1557,6 +1557,9 @@ struct ext4_sb_info {
>  	/* Barrier between changing inodes' journal flags and writepages ops. */
>  	struct percpu_rw_semaphore s_journal_flag_rwsem;
>  	struct dax_device *s_daxdev;
> +#ifdef CONFIG_EXT4_DEBUG
> +	unsigned long s_simulate_fail;
> +#endif
>  };
>  
>  static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
> @@ -1575,6 +1578,45 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
>  		 ino <= le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count));
>  }
>  
> +static inline int ext4_simulate_fail(struct super_block *sb,
> +				     unsigned long flag)

Nit: bool?

> +{
> +#ifdef CONFIG_EXT4_DEBUG
> +	unsigned long old, new;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	do {
> +		old = READ_ONCE(sbi->s_simulate_fail);
> +		if (likely((old & flag) == 0))
> +			return 0;
> +		new = old & ~flag;
> +	} while (unlikely(cmpxchg(&sbi->s_simulate_fail, old, new) != old));

If I'm reading this correctly, this means that userspace sets a
s_simulate_fail bit via sysfs knob, and the next time the filesystem
calls ext4_simulate_fail with the same bit set in @flag we'll return
true to say "simulate the failure" and clear the bit in s_simulate_fail?

IOWs, the simulated failures have to be re-armed every time?

Seems reasonable, but consider the possibility that in the future it
might be useful if you could set up periodic failures (e.g. directory
lookups fail 10% of the time) so that you can see how something like
fsstress reacts to less-predictable failures?

Of course that also increases the amount of fugly sysfs boilerplate so
that each knob can have its own sysfs file... that alone is half of a
reason not to do that. :(

--D

> +	return 1;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static inline void ext4_simulate_fail_bh(struct super_block *sb,
> +					 struct buffer_head *bh,
> +					 unsigned long flag)
> +{
> +	if (!IS_ERR(bh) && ext4_simulate_fail(sb, flag))
> +		clear_buffer_uptodate(bh);
> +}
> +
> +/*
> + * Simulate_fail flags
> + */
> +#define EXT4_SIM_BBITMAP_EIO	0x00000001
> +#define EXT4_SIM_BBITMAP_CRC	0x00000002
> +#define EXT4_SIM_IBITMAP_EIO	0x00000004
> +#define EXT4_SIM_IBITMAP_CRC	0x00000008
> +#define EXT4_SIM_INODE_EIO	0x00000010
> +#define EXT4_SIM_INODE_CRC	0x00000020
> +#define EXT4_SIM_DIRBLOCK_EIO	0x00000040
> +#define EXT4_SIM_DIRBLOCK_CRC	0x00000080
> +
>  /*
>   * Error number codes for s_{first,last}_error_errno
>   *
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 31a5fd6f5e6a..f7033594f4a0 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -94,7 +94,8 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
>  		goto verified;
>  	blk = ext4_inode_bitmap(sb, desc);
>  	if (!ext4_inode_bitmap_csum_verify(sb, block_group, desc, bh,
> -					   EXT4_INODES_PER_GROUP(sb) / 8)) {
> +					   EXT4_INODES_PER_GROUP(sb) / 8) ||
> +	    ext4_simulate_fail(sb, EXT4_SIM_IBITMAP_CRC)) {
>  		ext4_unlock_group(sb, block_group);
>  		ext4_error(sb, "Corrupt inode bitmap - block_group = %u, "
>  			   "inode_bitmap = %llu", block_group, blk);
> @@ -192,6 +193,7 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
>  	get_bh(bh);
>  	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
>  	wait_on_buffer(bh);
> +	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_IBITMAP_EIO);
>  	if (!buffer_uptodate(bh)) {
>  		put_bh(bh);
>  		ext4_set_errno(sb, EIO);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b67ffa24ae0a..564f88040de9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4243,6 +4243,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
>  	bh = sb_getblk(sb, block);
>  	if (unlikely(!bh))
>  		return -ENOMEM;
> +	if (ext4_simulate_fail(sb, EXT4_SIM_INODE_EIO))
> +		goto simulate_eio;
>  	if (!buffer_uptodate(bh)) {
>  		lock_buffer(bh);
>  
> @@ -4341,6 +4343,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
>  		blk_finish_plug(&plug);
>  		wait_on_buffer(bh);
>  		if (!buffer_uptodate(bh)) {
> +		simulate_eio:
>  			ext4_set_errno(inode->i_sb, EIO);
>  			EXT4_ERROR_INODE_BLOCK(inode, block,
>  					       "unable to read itable block");
> @@ -4555,7 +4558,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  					      sizeof(gen));
>  	}
>  
> -	if (!ext4_inode_csum_verify(inode, raw_inode, ei)) {
> +	if (!ext4_inode_csum_verify(inode, raw_inode, ei) ||
> +	    ext4_simulate_fail(sb, EXT4_SIM_INODE_CRC)) {
>  		ext4_set_errno(inode->i_sb, EFSBADCRC);
>  		ext4_error_inode(inode, function, line, 0,
>  				 "iget: checksum invalid");
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index cee7c28e070d..be14e33e5103 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -109,7 +109,10 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
>  	struct ext4_dir_entry *dirent;
>  	int is_dx_block = 0;
>  
> -	bh = ext4_bread(NULL, inode, block, 0);
> +	if (ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_EIO))
> +		bh = ERR_PTR(-EIO);
> +	else
> +		bh = ext4_bread(NULL, inode, block, 0);
>  	if (IS_ERR(bh)) {
>  		__ext4_warning(inode->i_sb, func, line,
>  			       "inode #%lu: lblock %lu: comm %s: "
> @@ -153,7 +156,8 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
>  	 * caller is sure it should be an index block.
>  	 */
>  	if (is_dx_block && type == INDEX) {
> -		if (ext4_dx_csum_verify(inode, dirent))
> +		if (ext4_dx_csum_verify(inode, dirent) &&
> +		    !ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_CRC))
>  			set_buffer_verified(bh);
>  		else {
>  			ext4_set_errno(inode->i_sb, EFSBADCRC);
> @@ -164,7 +168,8 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
>  		}
>  	}
>  	if (!is_dx_block) {
> -		if (ext4_dirblock_csum_verify(inode, bh))
> +		if (ext4_dirblock_csum_verify(inode, bh) &&
> +		    !ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_CRC))
>  			set_buffer_verified(bh);
>  		else {
>  			ext4_set_errno(inode->i_sb, EFSBADCRC);
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index eb1efad0e20a..a990d28d191b 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -29,6 +29,7 @@ typedef enum {
>  	attr_last_error_time,
>  	attr_feature,
>  	attr_pointer_ui,
> +	attr_pointer_ul,
>  	attr_pointer_atomic,
>  	attr_journal_task,
>  } attr_id_t;
> @@ -160,6 +161,9 @@ static struct ext4_attr ext4_attr_##_name = {			\
>  #define EXT4_RW_ATTR_SBI_UI(_name,_elname)	\
>  	EXT4_ATTR_OFFSET(_name, 0644, pointer_ui, ext4_sb_info, _elname)
>  
> +#define EXT4_RW_ATTR_SBI_UL(_name,_elname)	\
> +	EXT4_ATTR_OFFSET(_name, 0644, pointer_ul, ext4_sb_info, _elname)
> +
>  #define EXT4_ATTR_PTR(_name,_mode,_id,_ptr) \
>  static struct ext4_attr ext4_attr_##_name = {			\
>  	.attr = {.name = __stringify(_name), .mode = _mode },	\
> @@ -194,6 +198,9 @@ EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.int
>  EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
>  EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
>  EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
> +#ifdef CONFIG_EXT4_DEBUG
> +EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
> +#endif
>  EXT4_RO_ATTR_ES_UI(errors_count, s_error_count);
>  EXT4_ATTR(first_error_time, 0444, first_error_time);
>  EXT4_ATTR(last_error_time, 0444, last_error_time);
> @@ -228,6 +235,9 @@ static struct attribute *ext4_attrs[] = {
>  	ATTR_LIST(first_error_time),
>  	ATTR_LIST(last_error_time),
>  	ATTR_LIST(journal_task),
> +#ifdef CONFIG_EXT4_DEBUG
> +	ATTR_LIST(simulate_fail),
> +#endif
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(ext4);
> @@ -318,6 +328,11 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>  		else
>  			return snprintf(buf, PAGE_SIZE, "%u\n",
>  					*((unsigned int *) ptr));
> +	case attr_pointer_ul:
> +		if (!ptr)
> +			return 0;
> +		return snprintf(buf, PAGE_SIZE, "%lu\n",
> +				*((unsigned long *) ptr));
>  	case attr_pointer_atomic:
>  		if (!ptr)
>  			return 0;
> @@ -361,6 +376,14 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>  		else
>  			*((unsigned int *) ptr) = t;
>  		return len;
> +	case attr_pointer_ul:
> +		if (!ptr)
> +			return 0;
> +		ret = kstrtoul(skip_spaces(buf), 0, &t);
> +		if (ret)
> +			return ret;
> +		*((unsigned long *) ptr) = t;
> +		return len;
>  	case attr_inode_readahead:
>  		return inode_readahead_blks_store(sbi, buf, len);
>  	case attr_trigger_test_error:
> -- 
> 2.23.0
> 
