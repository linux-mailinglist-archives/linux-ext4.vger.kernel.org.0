Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5C6288FCF
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 19:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbgJIRO2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 13:14:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732603AbgJIROW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 13:14:22 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099H3EQr076533;
        Fri, 9 Oct 2020 13:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=L9DmEJTHSVPh+cqu1P4oSist4V4Rf9z2PlVA2RHRvNU=;
 b=PbK/vfA5fo54KBsCAK1y6rBPsrqAZnfaO8KEeyAMD8zidGaxxNM21VkDQSOQo9ySC5ol
 jlWeNnt7TOTJEtQpTu69XPLJfcfMc+8Uvt8WtNKXn2NIzxtKTK1fh7Ry9C48ie+QvLyg
 rMsLOwjlymDxzHZWMCwMt1og000eMPzNcl5xGy/9nfOYU9G4E84UGD15NdcDlKj1+OQ5
 MlC3JNN8scQ+es6GD9NCh3HLsDZGBRjUp4HP+/KoAsYmzvCc9DwFBCHZr2f8z5S1HRZa
 Ik+lbeFX5CLqLdR3N6XqH2tj6UliW/Lir8cgA6wO7Me+nx2KT+lKA6ltRzM3p6vgL5Wp rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342ttdaks2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 13:14:11 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 099H3N9G077323;
        Fri, 9 Oct 2020 13:14:10 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342ttdakqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 13:14:10 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099HE4wp027291;
        Fri, 9 Oct 2020 17:14:08 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3429h9rejd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 17:14:07 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099HE5kD27066746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Oct 2020 17:14:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D80B42041;
        Fri,  9 Oct 2020 17:14:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64B554203F;
        Fri,  9 Oct 2020 17:14:04 +0000 (GMT)
Received: from [9.199.46.138] (unknown [9.199.46.138])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Oct 2020 17:14:04 +0000 (GMT)
Subject: Re: [PATCH v9 7/9] ext4: fast commit recovery path
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-8-harshadshirwadkar@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <dcf720bd-8644-3001-75b4-d845a2495f72@linux.ibm.com>
Date:   Fri, 9 Oct 2020 22:44:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200919005451.3899779-8-harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_09:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 clxscore=1015
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090126
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 9/19/20 6:24 AM, Harshad Shirwadkar wrote:
> This patch adds fast commit recovery path support for Ext4 file
> system. We add several helper functions that are similar in spirit to
> e2fsprogs journal recovery path handlers. Example of such functions
> include - a simple block allocator, idempotent block bitmap update
> function etc. Using these routines and the fast commit log in the fast
> commit area, the recovery path (ext4_fc_replay()) performs fast commit
> log recovery.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>   fs/ext4/balloc.c            |   7 +-
>   fs/ext4/ext4.h              |  26 ++
>   fs/ext4/ext4_jbd2.c         |   2 +-
>   fs/ext4/extents.c           | 261 +++++++++++
>   fs/ext4/extents_status.c    |  24 +
>   fs/ext4/fast_commit.c       | 881 +++++++++++++++++++++++++++++++++++-
>   fs/ext4/fast_commit.h       |  40 ++
>   fs/ext4/ialloc.c            | 165 ++++++-
>   fs/ext4/inode.c             |  89 ++--
>   fs/ext4/ioctl.c             |   6 +-
>   fs/ext4/mballoc.c           | 208 ++++++++-
>   fs/ext4/namei.c             | 149 +++---
>   fs/ext4/super.c             |  21 +
>   include/trace/events/ext4.h |  56 ++-
>   14 files changed, 1804 insertions(+), 131 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 48c3df47748d..77108c99ae90 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -368,7 +368,12 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>   				      struct buffer_head *bh)
>   {
>   	ext4_fsblk_t	blk;
> -	struct ext4_group_info *grp = ext4_get_group_info(sb, block_group);
> +	struct ext4_group_info *grp;
> +
> +	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return 0;
> +
> +	grp = ext4_get_group_info(sb, block_group);
> 
>   	if (buffer_verified(bh))
>   		return 0;
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 27d48d166e5d..372a38292ed1 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1167,6 +1167,7 @@ struct ext4_inode_info {
>   #define EXT4_FC_COMMITTING		0x0010	/* File system underoing a fast
>   						 * commit.
>   						 */
> +#define EXT4_FC_REPLAY			0x0020	/* Fast commit replay ongoing */
> 
>   /*
>    * Misc. filesystem flags
> @@ -1658,6 +1659,10 @@ struct ext4_sb_info {
>   	struct buffer_head *s_fc_bh;
>   	struct ext4_fc_stats s_fc_stats;
>   	u64 s_fc_avg_commit_time;
> +#ifdef CONFIG_EXT4_DEBUG
> +	int s_fc_debug_max_replay;
> +#endif
> +	struct ext4_fc_replay_state s_fc_replay_state;
>   };
> 
>   static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
> @@ -2700,6 +2705,7 @@ extern int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
>   			  struct dx_hash_info *hinfo);
> 
>   /* ialloc.c */
> +extern int ext4_mark_inode_used(struct super_block *sb, int ino);
>   extern struct inode *__ext4_new_inode(handle_t *, struct inode *, umode_t,
>   				      const struct qstr *qstr, __u32 goal,
>   				      uid_t *owner, __u32 i_flags,
> @@ -2741,6 +2747,8 @@ void ext4_fc_stop_ineligible(struct super_block *sb);
>   void ext4_fc_start_update(struct inode *inode);
>   void ext4_fc_stop_update(struct inode *inode);
>   void ext4_fc_del(struct inode *inode);
> +bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
> +void ext4_fc_replay_cleanup(struct super_block *sb);
>   int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
>   int __init ext4_fc_init_dentry_cache(void);
> 
> @@ -2773,8 +2781,12 @@ extern int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
>   				ext4_fsblk_t block, unsigned long count);
>   extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
>   extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
> +extern void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
> +		       int len, int state);
> 
>   /* inode.c */
> +void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
> +			 struct ext4_inode_info *ei);
>   int ext4_inode_is_fast_symlink(struct inode *inode);
>   struct buffer_head *ext4_getblk(handle_t *, struct inode *, ext4_lblk_t, int);
>   struct buffer_head *ext4_bread(handle_t *, struct inode *, ext4_lblk_t, int);
> @@ -2821,6 +2833,8 @@ extern int  ext4_sync_inode(handle_t *, struct inode *);
>   extern void ext4_dirty_inode(struct inode *, int);
>   extern int ext4_change_inode_journal_flag(struct inode *, int);
>   extern int ext4_get_inode_loc(struct inode *, struct ext4_iloc *);
> +extern int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
> +			  struct ext4_iloc *iloc);
>   extern int ext4_inode_attach_jinode(struct inode *inode);
>   extern int ext4_can_truncate(struct inode *inode);
>   extern int ext4_truncate(struct inode *);
> @@ -2854,12 +2868,15 @@ extern int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
>   /* ioctl.c */
>   extern long ext4_ioctl(struct file *, unsigned int, unsigned long);
>   extern long ext4_compat_ioctl(struct file *, unsigned int, unsigned long);
> +extern void ext4_reset_inode_seed(struct inode *inode);
> 
>   /* migrate.c */
>   extern int ext4_ext_migrate(struct inode *);
>   extern int ext4_ind_migrate(struct inode *inode);
> 
>   /* namei.c */
> +extern int ext4_init_new_dir(handle_t *handle, struct inode *dir,
> +			     struct inode *inode);
>   extern int ext4_dirblock_csum_verify(struct inode *inode,
>   				     struct buffer_head *bh);
>   extern int ext4_orphan_add(handle_t *, struct inode *);
> @@ -3426,6 +3443,10 @@ extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
>   extern int ext4_ci_compare(const struct inode *parent,
>   			   const struct qstr *fname,
>   			   const struct qstr *entry, bool quick);
> +extern int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
> +			 struct inode *inode);
> +extern int __ext4_link(struct inode *dir, struct inode *inode,
> +		       struct dentry *dentry);
> 
>   #define S_SHIFT 12
>   static const unsigned char ext4_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
> @@ -3526,6 +3547,11 @@ extern int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu);
>   extern int ext4_datasem_ensure_credits(handle_t *handle, struct inode *inode,
>   				       int check_cred, int restart_cred,
>   				       int revoke_cred);
> +extern void ext4_ext_replay_shrink_inode(struct inode *inode, ext4_lblk_t end);
> +extern int ext4_ext_replay_set_iblocks(struct inode *inode);
> +extern int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
> +		int len, int unwritten, ext4_fsblk_t pblk);
> +extern int ext4_ext_clear_bb(struct inode *inode);
> 
> 
>   /* move_extent.c */
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 760b9ee49dc0..0fd0c42a4f7d 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -100,7 +100,7 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
>   		return ERR_PTR(err);
> 
>   	journal = EXT4_SB(sb)->s_journal;
> -	if (!journal)
> +	if (!journal || (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
>   		return ext4_get_nojournal();
>   	return jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
>   				   GFP_NOFS, type, line);
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 8de236fedade..29945f1172fc 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5804,3 +5804,264 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
> 
>   	return err ? err : mapped;
>   }
> +
> +/*
> + * Updates physical block address and unwritten status of extent starting at
> + * lblk start and of len. If such an extent doesn't exist, this function
> + * splits the extent tree appropriately to create an extent like this.
> + * This function is called in Ext4 fast commit replay path. Returns 0 on success
> + * and error on failure.
> + */
> +int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
> +		int len, int unwritten, ext4_fsblk_t pblk)
> +{
> +	struct ext4_ext_path *path = NULL, *ppath;
> +	struct ext4_extent *ex;
> +	int ret;
> +
> +	path = ext4_find_extent(inode, start, NULL, 0);
> +	if (!path)
> +		return -EINVAL;
> +	ex = path[path->p_depth].p_ext;
> +	if (!ex) {
> +		ret = -EFSCORRUPTED;
> +		goto out;
> +	}
> +
> +	if (le32_to_cpu(ex->ee_block) != start ||
> +		ext4_ext_get_actual_len(ex) != len) {
> +		/* We need to split this extent to match our extent first */
> +		ppath = path;
> +		down_write(&EXT4_I(inode)->i_data_sem);
> +		ret = ext4_force_split_extent_at(NULL, inode, &ppath, start, 1);
> +		up_write(&EXT4_I(inode)->i_data_sem);
> +		if (ret)
> +			goto out;
> +		kfree(path);
> +		path = ext4_find_extent(inode, start, NULL, 0);
> +		if (IS_ERR(path))
> +			return -1;
> +		ppath = path;
> +		ex = path[path->p_depth].p_ext;
> +		WARN_ON(le32_to_cpu(ex->ee_block) != start);
> +		if (ext4_ext_get_actual_len(ex) != len) {
> +			down_write(&EXT4_I(inode)->i_data_sem);
> +			ret = ext4_force_split_extent_at(NULL, inode, &ppath,
> +							 start + len, 1);
> +			up_write(&EXT4_I(inode)->i_data_sem);
> +			if (ret)
> +				goto out;
> +			kfree(path);
> +			path = ext4_find_extent(inode, start, NULL, 0);
> +			if (IS_ERR(path))
> +				return -EINVAL;
> +			ex = path[path->p_depth].p_ext;
> +		}
> +	}
> +	if (unwritten)
> +		ext4_ext_mark_unwritten(ex);
> +	else
> +		ext4_ext_mark_initialized(ex);
> +	ext4_ext_store_pblock(ex, pblk);
> +	down_write(&EXT4_I(inode)->i_data_sem);
> +	ret = ext4_ext_dirty(NULL, inode, &path[path->p_depth]);
> +	up_write(&EXT4_I(inode)->i_data_sem);
> +out:
> +	ext4_ext_drop_refs(path);
> +	kfree(path);
> +	ext4_mark_inode_dirty(NULL, inode);
> +	return ret;
> +}
> +
> +/* Try to shrink the extent tree */
> +void ext4_ext_replay_shrink_inode(struct inode *inode, ext4_lblk_t end)
> +{
> +	struct ext4_ext_path *path = NULL;
> +	struct ext4_extent *ex;
> +	ext4_lblk_t old_cur, cur = 0;
> +
> +	while (cur < end) {
> +		path = ext4_find_extent(inode, cur, NULL, 0);
> +		if (IS_ERR(path))
> +			return;
> +		ex = path[path->p_depth].p_ext;
> +		if (!ex) {
> +			ext4_ext_drop_refs(path);
> +			kfree(path);
> +			ext4_mark_inode_dirty(NULL, inode);
> +			return;
> +		}
> +		old_cur = cur;
> +		cur = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
> +		if (cur <= old_cur)
> +			cur = old_cur + 1;
> +		ext4_ext_try_to_merge(NULL, inode, path, ex);
> +		down_write(&EXT4_I(inode)->i_data_sem);
> +		ext4_ext_dirty(NULL, inode, &path[path->p_depth]);
> +		up_write(&EXT4_I(inode)->i_data_sem);
> +		ext4_mark_inode_dirty(NULL, inode);
> +		ext4_ext_drop_refs(path);
> +		kfree(path);
> +	}
> +}
> +
> +/* Check if *cur is a hole and if it is, skip it */
> +static void skip_hole(struct inode *inode, ext4_lblk_t *cur)
> +{
> +	int ret;
> +	struct ext4_map_blocks map;
> +
> +	map.m_lblk = *cur;
> +	map.m_len = ((inode->i_size) >> inode->i_sb->s_blocksize_bits) - *cur;
> +
> +	ret = ext4_map_blocks(NULL, inode, &map, 0);
> +	if (ret != 0)
> +		return;
> +	*cur = *cur + map.m_len;
> +}
> +
> +/* Count number of blocks used by this inode and update i_blocks */
> +int ext4_ext_replay_set_iblocks(struct inode *inode)
> +{
> +	struct ext4_ext_path *path = NULL, *path2 = NULL;
> +	struct ext4_extent *ex;
> +	ext4_lblk_t cur = 0, end;
> +	int numblks = 0, i, ret = 0;
> +	ext4_fsblk_t cmp1, cmp2;
> +	struct ext4_map_blocks map;
> +
> +	/* Determin the size of the file first */
> +	path = ext4_find_extent(inode, EXT_MAX_BLOCKS - 1, NULL,
> +					EXT4_EX_NOCACHE);
> +	if (IS_ERR(path))
> +		return PTR_ERR(path);
> +	ex = path[path->p_depth].p_ext;
> +	if (!ex) {
> +		ext4_ext_drop_refs(path);
> +		kfree(path);
> +		goto out;
> +	}
> +	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
> +	ext4_ext_drop_refs(path);
> +	kfree(path);
> +
> +	/* Count the number of data blocks */
> +	cur = 0;
> +	while (cur < end) {
> +		map.m_lblk = cur;
> +		map.m_len = end - cur;
> +		ret = ext4_map_blocks(NULL, inode, &map, 0);
> +		if (ret < 0)
> +			break;
> +		if (ret > 0)
> +			numblks += ret;
> +		cur = cur + map.m_len;
> +	}
> +
> +	/*
> +	 * Count the number of extent tree blocks. We do it by looking up
> +	 * two successive extents and determining the difference between
> +	 * their paths. When path is different for 2 successive extents
> +	 * we compare the blocks in the path at each level and increment
> +	 * iblocks by total number of differences found.
> +	 */
> +	cur = 0;
> +	skip_hole(inode, &cur);
> +	path = ext4_find_extent(inode, cur, NULL, 0);
> +	if (IS_ERR(path))
> +		goto out;
> +	numblks += path->p_depth;
> +	ext4_ext_drop_refs(path);
> +	kfree(path);
> +	while (cur < end) {
> +		path = ext4_find_extent(inode, cur, NULL, 0);
> +		if (IS_ERR(path))
> +			break;
> +		ex = path[path->p_depth].p_ext;
> +		if (!ex) {
> +			ext4_ext_drop_refs(path);
> +			kfree(path);
> +			return 0;
> +		}
> +		cur = max(cur + 1, le32_to_cpu(ex->ee_block) +
> +					ext4_ext_get_actual_len(ex));
> +		skip_hole(inode, &cur);
> +
> +		path2 = ext4_find_extent(inode, cur, NULL, 0);
> +		if (IS_ERR(path2)) {
> +			ext4_ext_drop_refs(path);
> +			kfree(path);
> +			break;
> +		}
> +		ex = path2[path2->p_depth].p_ext;
> +		for (i = 0; i <= max(path->p_depth, path2->p_depth); i++) {
> +			cmp1 = cmp2 = 0;
> +			if (i <= path->p_depth)
> +				cmp1 = path[i].p_bh ?
> +					path[i].p_bh->b_blocknr : 0;
> +			if (i <= path2->p_depth)
> +				cmp2 = path2[i].p_bh ?
> +					path2[i].p_bh->b_blocknr : 0;
> +			if (cmp1 != cmp2 && cmp2 != 0)
> +				numblks++;
> +		}
> +		ext4_ext_drop_refs(path);
> +		ext4_ext_drop_refs(path2);
> +		kfree(path);
> +		kfree(path2);
> +	}
> +
> +out:
> +	inode->i_blocks = numblks << (inode->i_sb->s_blocksize_bits - 9);
> +	ext4_mark_inode_dirty(NULL, inode);
> +	return 0;
> +}
> +
> +int ext4_ext_clear_bb(struct inode *inode)
> +{
> +	struct ext4_ext_path *path = NULL;
> +	struct ext4_extent *ex;
> +	ext4_lblk_t cur = 0, end;
> +	int j, ret = 0;
> +	struct ext4_map_blocks map;
> +
> +	/* Determin the size of the file first */
> +	path = ext4_find_extent(inode, EXT_MAX_BLOCKS - 1, NULL,
> +					EXT4_EX_NOCACHE);
> +	if (IS_ERR(path))
> +		return PTR_ERR(path);
> +	ex = path[path->p_depth].p_ext;
> +	if (!ex) {
> +		ext4_ext_drop_refs(path);
> +		kfree(path);
> +		return 0;
> +	}
> +	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
> +	ext4_ext_drop_refs(path);
> +	kfree(path);
> +
> +	cur = 0;
> +	while (cur < end) {
> +		map.m_lblk = cur;
> +		map.m_len = end - cur;
> +		ret = ext4_map_blocks(NULL, inode, &map, 0);
> +		if (ret < 0)
> +			break;
> +		if (ret > 0) {
> +			path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
> +			if (!IS_ERR_OR_NULL(path)) {
> +				for (j = 0; j < path->p_depth; j++) {
> +
> +					ext4_mb_mark_bb(inode->i_sb,
> +							path[j].p_block, 1, 0);
> +				}
> +				ext4_ext_drop_refs(path);
> +				kfree(path);
> +			}
> +			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
> +		}
> +		cur = cur + map.m_len;
> +	}
> +
> +	return 0;
> +}
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index e75171535375..0a729027322d 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -311,6 +311,9 @@ void ext4_es_find_extent_range(struct inode *inode,
>   			       ext4_lblk_t lblk, ext4_lblk_t end,
>   			       struct extent_status *es)
>   {
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return;
> +
>   	trace_ext4_es_find_extent_range_enter(inode, lblk);
> 
>   	read_lock(&EXT4_I(inode)->i_es_lock);
> @@ -361,6 +364,9 @@ bool ext4_es_scan_range(struct inode *inode,
>   {
>   	bool ret;
> 
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return false;
> +
>   	read_lock(&EXT4_I(inode)->i_es_lock);
>   	ret = __es_scan_range(inode, matching_fn, lblk, end);
>   	read_unlock(&EXT4_I(inode)->i_es_lock);
> @@ -404,6 +410,9 @@ bool ext4_es_scan_clu(struct inode *inode,
>   {
>   	bool ret;
> 
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return false;
> +
>   	read_lock(&EXT4_I(inode)->i_es_lock);
>   	ret = __es_scan_clu(inode, matching_fn, lblk);
>   	read_unlock(&EXT4_I(inode)->i_es_lock);
> @@ -812,6 +821,9 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>   	int err = 0;
>   	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> 
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return 0;
> +
>   	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
>   		 lblk, len, pblk, status, inode->i_ino);
> 
> @@ -873,6 +885,9 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>   	struct extent_status newes;
>   	ext4_lblk_t end = lblk + len - 1;
> 
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return;
> +
>   	newes.es_lblk = lblk;
>   	newes.es_len = len;
>   	ext4_es_store_pblock_status(&newes, pblk, status);
> @@ -908,6 +923,9 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
>   	struct rb_node *node;
>   	int found = 0;
> 
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return 0;
> +
>   	trace_ext4_es_lookup_extent_enter(inode, lblk);
>   	es_debug("lookup extent in block %u\n", lblk);
> 
> @@ -1419,6 +1437,9 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>   	int err = 0;
>   	int reserved = 0;
> 
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return 0;
> +
>   	trace_ext4_es_remove_extent(inode, lblk, len);
>   	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
>   		 lblk, len, inode->i_ino);
> @@ -1969,6 +1990,9 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>   	struct extent_status newes;
>   	int err = 0;
> 
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return 0;
> +
>   	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
>   		 lblk, inode->i_ino);
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 6e251b5682b4..63429076ad59 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -170,7 +170,8 @@ void ext4_fc_start_update(struct inode *inode)
>   {
>   	struct ext4_inode_info *ei = EXT4_I(inode);
> 
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> +	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
>   		return;
> 
>   restart:
> @@ -209,7 +210,8 @@ void ext4_fc_stop_update(struct inode *inode)
>   {
>   	struct ext4_inode_info *ei = EXT4_I(inode);
> 
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> +	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
>   		return;
> 
>   	if (atomic_dec_and_test(&ei->i_fc_updates))
> @@ -224,11 +226,8 @@ void ext4_fc_del(struct inode *inode)
>   {
>   	struct ext4_inode_info *ei = EXT4_I(inode);
> 
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> -		return;
> -
> -
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> +	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
>   		return;
> 
>   restart:
> @@ -270,6 +269,10 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason)
>   {
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
> 
> +	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
> +	    (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
> +		return;
> +
>   	sbi->s_mount_state |= EXT4_FC_INELIGIBLE;
>   	WARN_ON(reason >= EXT4_FC_REASON_MAX);
>   	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
> @@ -283,6 +286,10 @@ void ext4_fc_start_ineligible(struct super_block *sb, int reason)
>   {
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
> 
> +	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
> +	    (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
> +		return;
> +
>   	WARN_ON(reason >= EXT4_FC_REASON_MAX);
>   	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
>   	atomic_inc(&sbi->s_fc_ineligible_updates);
> @@ -295,6 +302,10 @@ void ext4_fc_start_ineligible(struct super_block *sb, int reason)
>    */
>   void ext4_fc_stop_ineligible(struct super_block *sb)
>   {
> +	if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
> +	    (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
> +		return;
> +
>   	EXT4_SB(sb)->s_mount_state |= EXT4_FC_INELIGIBLE;
>   	atomic_dec(&EXT4_SB(sb)->s_fc_ineligible_updates);
>   }
> @@ -325,7 +336,8 @@ static int ext4_fc_track_template(
>   	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>   	int ret;
> 
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> +	    (sbi->s_mount_state & EXT4_FC_REPLAY))
>   		return -EOPNOTSUPP;
> 
>   	if (ext4_fc_is_ineligible(inode->i_sb))
> @@ -1214,13 +1226,864 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
>   	trace_ext4_fc_stats(sb);
>   }
> 
> +/* Ext4 Replay Path Routines */
> +
> +/* Get length of a particular tlv */
> +static inline int ext4_fc_tag_len(struct ext4_fc_tl *tl)
> +{
> +	return le16_to_cpu(tl->fc_len);
> +}
> +
> +/* Get a pointer to "value" of a tlv */
> +static inline u8 *ext4_fc_tag_val(struct ext4_fc_tl *tl)
> +{
> +	return (u8 *)tl + sizeof(*tl);
> +}
> +
> +/* Helper struct for dentry replay routines */
> +struct dentry_info_args {
> +	int parent_ino, dname_len, ino, inode_len;
> +	char *dname;
> +};
> +
> +static inline void tl_to_darg(struct dentry_info_args *darg,
> +				struct  ext4_fc_tl *tl)
> +{
> +	struct ext4_fc_dentry_info *fcd;
> +
> +	fcd = (struct ext4_fc_dentry_info *)ext4_fc_tag_val(tl);
> +
> +	darg->parent_ino = le32_to_cpu(fcd->fc_parent_ino);
> +	darg->ino = le32_to_cpu(fcd->fc_ino);
> +	darg->dname = fcd->fc_dname;
> +	darg->dname_len = ext4_fc_tag_len(tl) -
> +			sizeof(struct ext4_fc_dentry_info);
> +}
> +
> +/* Unlink replay function */
> +static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl)
> +{
> +	struct inode *inode, *old_parent;
> +	struct qstr entry;
> +	struct dentry_info_args darg;
> +	int ret = 0;
> +
> +	tl_to_darg(&darg, tl);
> +
> +	trace_ext4_fc_replay(sb, EXT4_FC_TAG_UNLINK, darg.ino,
> +			darg.parent_ino, darg.dname_len);
> +
> +	entry.name = darg.dname;
> +	entry.len = darg.dname_len;
> +	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
> +
> +	if (IS_ERR_OR_NULL(inode)) {
> +		jbd_debug(1, "Inode %d not found", darg.ino);
> +		return 0;
> +	}
> +
> +	old_parent = ext4_iget(sb, darg.parent_ino,
> +				EXT4_IGET_NORMAL);
> +	if (IS_ERR_OR_NULL(old_parent)) {
> +		jbd_debug(1, "Dir with inode  %d not found", darg.parent_ino);
> +		iput(inode);
> +		return 0;
> +	}
> +
> +	ret = __ext4_unlink(old_parent, &entry, inode);
> +	/* -ENOENT ok coz it might not exist anymore. */
> +	if (ret == -ENOENT)
> +		ret = 0;
> +	iput(old_parent);
> +	iput(inode);
> +	return ret;
> +}
> +
> +static int ext4_fc_replay_link_internal(struct super_block *sb,
> +				struct dentry_info_args *darg,
> +				struct inode *inode)
> +{
> +	struct inode *dir = NULL;
> +	struct dentry *dentry_dir = NULL, *dentry_inode = NULL;
> +	struct qstr qstr_dname = QSTR_INIT(darg->dname, darg->dname_len);
> +	int ret = 0;
> +
> +	dir = ext4_iget(sb, darg->parent_ino, EXT4_IGET_NORMAL);
> +	if (IS_ERR(dir)) {
> +		jbd_debug(1, "Dir with inode %d not found.", darg->parent_ino);
> +		dir = NULL;
> +		goto out;
> +	}
> +
> +	dentry_dir = d_obtain_alias(dir);
> +	if (IS_ERR(dentry_dir)) {
> +		jbd_debug(1, "Failed to obtain dentry");
> +		dentry_dir = NULL;
> +		goto out;
> +	}
> +
> +	dentry_inode = d_alloc(dentry_dir, &qstr_dname);
> +	if (!dentry_inode) {
> +		jbd_debug(1, "Inode dentry not created.");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = __ext4_link(dir, inode, dentry_inode);
> +	/*
> +	 * It's possible that link already existed since data blocks
> +	 * for the dir in question got persisted before we crashed OR
> +	 * we replayed this tag and crashed before the entire replay
> +	 * could complete.
> +	 */
> +	if (ret && ret != -EEXIST) {
> +		jbd_debug(1, "Failed to link\n");
> +		goto out;
> +	}
> +
> +	ret = 0;
> +out:
> +	if (dentry_dir) {
> +		d_drop(dentry_dir);
> +		dput(dentry_dir);
> +	} else if (dir) {
> +		iput(dir);
> +	}
> +	if (dentry_inode) {
> +		d_drop(dentry_inode);
> +		dput(dentry_inode);
> +	}
> +
> +	return ret;
> +}
> +
> +/* Link replay function */
> +static int ext4_fc_replay_link(struct super_block *sb, struct ext4_fc_tl *tl)
> +{
> +	struct inode *inode;
> +	struct dentry_info_args darg;
> +	int ret = 0;
> +
> +	tl_to_darg(&darg, tl);
> +	trace_ext4_fc_replay(sb, EXT4_FC_TAG_LINK, darg.ino,
> +			darg.parent_ino, darg.dname_len);
> +
> +	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
> +	if (IS_ERR_OR_NULL(inode)) {
> +		jbd_debug(1, "Inode not found.");
> +		return 0;
> +	}
> +
> +	ret = ext4_fc_replay_link_internal(sb, &darg, inode);
> +	iput(inode);
> +	return ret;
> +}
> +
> +/*
> + * Record all the modified inodes during replay. We use this later to setup
> + * block bitmaps correctly.
> + */
> +static int ext4_fc_record_modified_inode(struct super_block *sb, int ino)
> +{
> +	struct ext4_fc_replay_state *state;
> +	int i;
> +
> +	state = &EXT4_SB(sb)->s_fc_replay_state;
> +	for (i = 0; i < state->fc_modified_inodes_used; i++)
> +		if (state->fc_modified_inodes[i] == ino)
> +			return 0;
> +	if (state->fc_modified_inodes_used == state->fc_modified_inodes_size) {
> +		state->fc_modified_inodes_size +=
> +			EXT4_FC_REPLAY_REALLOC_INCREMENT;
> +		state->fc_modified_inodes = krealloc(
> +					state->fc_modified_inodes, sizeof(int) *
> +					state->fc_modified_inodes_size,
> +					GFP_KERNEL);
> +		if (!state->fc_modified_inodes)
> +			return -ENOMEM;
> +	}
> +	state->fc_modified_inodes[state->fc_modified_inodes_used++] = ino;
> +	return 0;
> +}
> +
> +/*
> + * Inode replay function
> + *
> + * If the tag is EXT4_FC_TAG_INODE_FULL, copy the entire inode to its location.
> + * If the tag is EXT4_FC_TAG_INODE_PARTIAL, copy everything except i_block.
> + * This is useful if i_block has been modified due to previous ADD_RANGE /
> + * DEL_RANGE tags.
> + */
> +static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
> +{
> +	struct ext4_fc_inode *fc_inode;
> +	u8 *raw_fc_inode;
> +	struct inode *inode = NULL;
> +	struct ext4_iloc iloc;
> +	int inode_len, ino, ret, tag = le16_to_cpu(tl->fc_tag);
> +
> +	fc_inode = (struct ext4_fc_inode *)ext4_fc_tag_val(tl);
> +
> +	ino = le32_to_cpu(fc_inode->fc_ino);
> +	trace_ext4_fc_replay(sb, tag, ino, 0, 0);
> +
> +	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
> +	if (!IS_ERR_OR_NULL(inode)) {
> +		ext4_ext_clear_bb(inode);
> +		iput(inode);
> +	}
> +
> +	ext4_fc_record_modified_inode(sb, ino);
> +
> +	raw_fc_inode = fc_inode->fc_raw_inode;
> +	ret = ext4_get_fc_inode_loc(sb, ino, &iloc);
> +	if (ret)
> +		goto out;
> +
> +	inode_len = ext4_fc_tag_len(tl) - sizeof(struct ext4_fc_inode);
> +
> +	if (tag == EXT4_FC_TAG_INODE_FULL) {
> +		memcpy(ext4_raw_inode(&iloc), raw_fc_inode, inode_len);
> +	} else {
> +		memcpy(ext4_raw_inode(&iloc), raw_fc_inode,
> +			offsetof(struct ext4_inode, i_block));
> +		memcpy(&ext4_raw_inode(&iloc)->i_generation,
> +			&((struct ext4_inode *)(raw_fc_inode))->i_generation,
> +			inode_len -
> +			offsetof(struct ext4_inode, i_generation));
> +	}
> +
> +	/* Immediately update the inode on disk. */
> +	ret = ext4_handle_dirty_metadata(NULL, NULL, iloc.bh);
> +	sync_dirty_buffer(iloc.bh);
> +
> +	ret = ext4_mark_inode_used(sb, ino);
> +	if (ret)
> +		goto out;
> +
> +	/* Given that we just wrote the inode on disk, this SHOULD succeed. */
> +	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
> +	if (IS_ERR_OR_NULL(inode)) {
> +		jbd_debug(1, "Inode not found.");
> +		return -EFSCORRUPTED;
> +	}
> +
> +	/*
> +	 * Our allocator could have made different decisions than before
> +	 * crashing. This should be fixed but until then, we calculate
> +	 * the number of blocks the inode.
> +	 */
> +	if (tag == EXT4_FC_TAG_INODE_PARTIAL)
> +		ext4_ext_replay_set_iblocks(inode);
> +
> +	inode->i_generation = le32_to_cpu(ext4_raw_inode(&iloc)->i_generation);
> +	ext4_reset_inode_seed(inode);
> +
> +	ext4_inode_csum_set(inode, ext4_raw_inode(&iloc), EXT4_I(inode));
> +	ret = ext4_handle_dirty_metadata(NULL, NULL, iloc.bh);
> +	sync_dirty_buffer(iloc.bh);
> +	brelse(iloc.bh);
> +out:
> +	iput(inode);
> +	if (!ret)
> +		blkdev_issue_flush(sb->s_bdev, GFP_KERNEL);
> +
> +	return 0;
> +}
> +
> +/*
> + * Dentry create replay function.
> + *
> + * EXT4_FC_TAG_CREAT is preceded by EXT4_FC_TAG_INODE_FULL. Which means, the
> + * inode for which we are trying to create a dentry here, should already have
> + * been replayed before we start here.
> + */
> +static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl)
> +{
> +	int ret = 0;
> +	struct inode *inode = NULL;
> +	struct inode *dir = NULL;
> +	struct dentry_info_args darg;
> +
> +	tl_to_darg(&darg, tl);
> +
> +	trace_ext4_fc_replay(sb, EXT4_FC_TAG_CREAT, darg.ino,
> +			darg.parent_ino, darg.dname_len);
> +
> +	/* This takes care of update group descriptor and other metadata */
> +	ret = ext4_mark_inode_used(sb, darg.ino);
> +	if (ret)
> +		goto out;
> +
> +	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
> +	if (IS_ERR_OR_NULL(inode)) {
> +		jbd_debug(1, "inode %d not found.", darg.ino);
> +		inode = NULL;
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (S_ISDIR(inode->i_mode)) {
> +		/*
> +		 * If we are creating a directory, we need to make sure that the
> +		 * dot and dot dot dirents are setup properly.
> +		 */
> +		dir = ext4_iget(sb, darg.parent_ino, EXT4_IGET_NORMAL);
> +		if (IS_ERR_OR_NULL(dir)) {
> +			jbd_debug(1, "Dir %d not found.", darg.ino);
> +			goto out;
> +		}
> +		ret = ext4_init_new_dir(NULL, dir, inode);
> +		iput(dir);
> +		if (ret) {
> +			ret = 0;
> +			goto out;
> +		}
> +	}
> +	ret = ext4_fc_replay_link_internal(sb, &darg, inode);
> +	if (ret)
> +		goto out;
> +	set_nlink(inode, 1);
> +	ext4_mark_inode_dirty(NULL, inode);
> +out:
> +	if (inode)
> +		iput(inode);
> +	return ret;
> +}
> +
> +/*
> + * Record physical disk regions which are in use as per fast commit area. Our
> + * simple replay phase allocator excludes these regions from allocation.
> + */
> +static int ext4_fc_record_regions(struct super_block *sb, int ino,
> +		ext4_lblk_t lblk, ext4_fsblk_t pblk, int len)
> +{
> +	struct ext4_fc_replay_state *state;
> +	struct ext4_fc_alloc_region *region;
> +
> +	state = &EXT4_SB(sb)->s_fc_replay_state;
> +	if (state->fc_regions_used == state->fc_regions_size) {
> +		state->fc_regions_size +=
> +			EXT4_FC_REPLAY_REALLOC_INCREMENT;
> +		state->fc_regions = krealloc(
> +					state->fc_regions,
> +					state->fc_regions_size *
> +					sizeof(struct ext4_fc_alloc_region),
> +					GFP_KERNEL);
> +		if (!state->fc_regions)
> +			return -ENOMEM;
> +	}
> +	region = &state->fc_regions[state->fc_regions_used++];
> +	region->ino = ino;
> +	region->lblk = lblk;
> +	region->pblk = pblk;
> +	region->len = len;
> +
> +	return 0;
> +}
> +
> +/* Replay add range tag */
> +static int ext4_fc_replay_add_range(struct super_block *sb,
> +				struct ext4_fc_tl *tl)
> +{
> +	struct ext4_fc_add_range *fc_add_ex;
> +	struct ext4_extent newex, *ex;
> +	struct inode *inode;
> +	ext4_lblk_t start, cur;
> +	int remaining, len;
> +	ext4_fsblk_t start_pblk;
> +	struct ext4_map_blocks map;
> +	struct ext4_ext_path *path = NULL;
> +	int ret;
> +
> +	fc_add_ex = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
> +	ex = (struct ext4_extent *)&fc_add_ex->fc_ex;
> +
> +	trace_ext4_fc_replay(sb, EXT4_FC_TAG_ADD_RANGE,
> +		le32_to_cpu(fc_add_ex->fc_ino), le32_to_cpu(ex->ee_block),
> +		ext4_ext_get_actual_len(ex));
> +
> +	inode = ext4_iget(sb, le32_to_cpu(fc_add_ex->fc_ino),
> +				EXT4_IGET_NORMAL);
> +	if (IS_ERR_OR_NULL(inode)) {
> +		jbd_debug(1, "Inode not found.");
> +		return 0;
> +	}
> +
> +	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> +
> +	start = le32_to_cpu(ex->ee_block);
> +	start_pblk = ext4_ext_pblock(ex);
> +	len = ext4_ext_get_actual_len(ex);
> +
> +	cur = start;
> +	remaining = len;
> +	jbd_debug(1, "ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %ld\n",
> +		  start, start_pblk, len, ext4_ext_is_unwritten(ex),
> +		  inode->i_ino);
> +
> +	while (remaining > 0) {
> +		map.m_lblk = cur;
> +		map.m_len = remaining;
> +		map.m_pblk = 0;
> +		ret = ext4_map_blocks(NULL, inode, &map, 0);
> +
> +		if (ret < 0) {
> +			iput(inode);
> +			return 0;
> +		}
> +
> +		if (ret == 0) {
> +			/* Range not mapped */
> +			path = ext4_find_extent(inode, cur, NULL, 0);
> +			if (!path)
> +				continue;
> +			memset(&newex, 0, sizeof(newex));
> +			newex.ee_block = cpu_to_le32(cur);
> +			ext4_ext_store_pblock(
> +				&newex, start_pblk + cur - start);
> +			newex.ee_len = cpu_to_le16(map.m_len);
> +			if (ext4_ext_is_unwritten(ex))
> +				ext4_ext_mark_unwritten(&newex);
> +			down_write(&EXT4_I(inode)->i_data_sem);
> +			ret = ext4_ext_insert_extent(
> +				NULL, inode, &path, &newex, 0);
> +			up_write((&EXT4_I(inode)->i_data_sem));
> +			ext4_ext_drop_refs(path);
> +			kfree(path);
> +			if (ret) {
> +				iput(inode);
> +				return 0;
> +			}
> +			goto next;
> +		}
> +
> +		if (start_pblk + cur - start != map.m_pblk) { > +			/* Logical to physical mapping changed */


Sorry I am not sure if I understand this correctly. Can we pls put more
comments on when and how can this condition happen?
I am sure I am mising something.

Also what about if the mapping changed and the start pblk is different
but it's still an overlapping mapping?
Do we take care of that case here? why I ask this, because we are
clearing the block bitmaps for map.m_len below.

> +			ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
> +					ext4_ext_is_unwritten(ex),
> +					start_pblk + cur - start);
> +			if (ret) {
> +				iput(inode);
> +				return 0;
> +			}
> +			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
> +			goto next;
> +		}
> +
> +		/* Range is mapped and needs a state change */
> +		jbd_debug(1, "Converting from %d to %d %lld",
> +				map.m_flags & EXT4_MAP_UNWRITTEN,
> +			ext4_ext_is_unwritten(ex), map.m_pblk);
> +		ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
> +					ext4_ext_is_unwritten(ex), map.m_pblk);
> +		if (ret) {
> +			iput(inode);
> +			return 0;
> +		}
> +		/*
> +		 * We may have split the extent tree while toggling the state.
> +		 * Try to shrink the exten tree now.

s/exten/extent



> +		 */
> +		ext4_ext_replay_shrink_inode(inode, start + len);
> +next:
> +		cur += map.m_len;
> +		remaining -= map.m_len;
> +	}
> +	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
> +					sb->s_blocksize_bits);
> +	iput(inode);
> +	return 0;
> +}
> +
> +/* Replay DEL_RANGE tag */
> +static int
> +ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
> +{
> +	struct inode *inode;
> +	struct ext4_fc_del_range *lrange;
> +	struct ext4_map_blocks map;
> +	ext4_lblk_t cur, remaining;
> +	int ret;
> +
> +	lrange = (struct ext4_fc_del_range *)ext4_fc_tag_val(tl);
> +	cur = le32_to_cpu(lrange->fc_lblk);
> +	remaining = le32_to_cpu(lrange->fc_len);
> +
> +	trace_ext4_fc_replay(sb, EXT4_FC_TAG_DEL_RANGE,
> +		le32_to_cpu(lrange->fc_ino), cur, remaining);
> +
> +	inode = ext4_iget(sb, le32_to_cpu(lrange->fc_ino), EXT4_IGET_NORMAL);
> +	if (IS_ERR_OR_NULL(inode)) {
> +		jbd_debug(1, "Inode %d not found", le32_to_cpu(lrange->fc_ino));
> +		return 0;
> +	}
> +
> +	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> +
> +	jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
> +			inode->i_ino, le32_to_cpu(lrange->fc_lblk),
> +			le32_to_cpu(lrange->fc_len));
> +	while (remaining > 0) {
> +		map.m_lblk = cur;
> +		map.m_len = remaining;
> +
> +		ret = ext4_map_blocks(NULL, inode, &map, 0);
> +		if (ret < 0) {
> +			iput(inode);
> +			return 0;
> +		}
> +		if (ret > 0) {
> +			remaining -= ret;
> +			cur += ret;
> +			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
> +		} else {
> +			remaining -= map.m_len;
> +			cur += map.m_len;
> +		}
> +	}
> +
> +	ret = ext4_punch_hole(inode,
> +		le32_to_cpu(lrange->fc_lblk) << sb->s_blocksize_bits,
> +		le32_to_cpu(lrange->fc_len) <<  sb->s_blocksize_bits);
> +	if (ret)
> +		jbd_debug(1, "ext4_punch_hole returned %d", ret);
> +	ext4_ext_replay_shrink_inode(inode,
> +		i_size_read(inode) >> sb->s_blocksize_bits);
> +	ext4_mark_inode_dirty(NULL, inode);
> +	iput(inode);
> +
> +	return 0;
> +}
> +
> +static inline const char *tag2str(u16 tag)
> +{
> +	switch (tag) {
> +	case EXT4_FC_TAG_LINK:
> +		return "TAG_ADD_ENTRY";
> +	case EXT4_FC_TAG_UNLINK:
> +		return "TAG_DEL_ENTRY";
> +	case EXT4_FC_TAG_ADD_RANGE:
> +		return "TAG_ADD_RANGE";
> +	case EXT4_FC_TAG_CREAT:
> +		return "TAG_CREAT_DENTRY";
> +	case EXT4_FC_TAG_DEL_RANGE:
> +		return "TAG_DEL_RANGE";
> +	case EXT4_FC_TAG_INODE_FULL:
> +		return "TAG_INODE_FULL";
> +	case EXT4_FC_TAG_INODE_PARTIAL:
> +		return "TAG_INODE_PARTIAL";
> +	case EXT4_FC_TAG_PAD:
> +		return "TAG_PAD";
> +	case EXT4_FC_TAG_TAIL:
> +		return "TAG_TAIL";
> +	case EXT4_FC_TAG_HEAD:
> +		return "TAG_HEAD";
> +	default:
> +		return "TAG_ERROR";
> +	}
> +}
> +
> +void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)

static ?

> +{
> +	struct ext4_fc_replay_state *state;
> +	struct inode *inode;
> +	struct ext4_ext_path *path = NULL;
> +	struct ext4_map_blocks map;
> +	int i, ret, j;
> +	ext4_lblk_t cur, end;
> +
> +	state = &EXT4_SB(sb)->s_fc_replay_state;
> +	for (i = 0; i < state->fc_modified_inodes_used; i++) {
> +		inode = ext4_iget(sb, state->fc_modified_inodes[i],
> +			EXT4_IGET_NORMAL);
> +		if (IS_ERR_OR_NULL(inode)) {
> +			jbd_debug(1, "Inode %d not found.",
> +				state->fc_modified_inodes[i]);
> +			continue;
> +		}
> +		cur = 0;
> +		end = EXT_MAX_BLOCKS;
> +		while (cur < end) {
> +			map.m_lblk = cur;
> +			map.m_len = end - cur;
> +
> +			ret = ext4_map_blocks(NULL, inode, &map, 0);
> +			if (ret < 0)
> +				break;
> +
> +			if (ret > 0) {
> +				path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
> +				if (!IS_ERR_OR_NULL(path)) {
> +					for (j = 0; j < path->p_depth; j++)
> +						ext4_mb_mark_bb(inode->i_sb,
> +							path[j].p_block, 1, 1);
> +					ext4_ext_drop_refs(path);
> +					kfree(path);
> +				}
> +				cur += ret;
> +				ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
> +							map.m_len, 1);
> +			} else {
> +				cur = cur + (map.m_len ? map.m_len : 1);
> +			}
> +		}
> +		iput(inode);
> +	}
> +}
> +
> +/*
> + * Check if block is in excluded regions for block allocation. The simple
> + * allocator that runs during replay phase is calls this function to see
> + * if it is okay to use a block.
> + */
> +bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t blk)
> +{
> +	int i;
> +	struct ext4_fc_replay_state *state;
> +
> +	state = &EXT4_SB(sb)->s_fc_replay_state;
> +	for (i = 0; i < state->fc_regions_valid; i++) {
> +		if (state->fc_regions[i].ino == 0 ||
> +			state->fc_regions[i].len == 0)
> +			continue;
> +		if (blk >= state->fc_regions[i].pblk &&
> +		    blk < state->fc_regions[i].pblk + state->fc_regions[i].len)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/* Cleanup function called after replay */
> +void ext4_fc_replay_cleanup(struct super_block *sb)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	sbi->s_mount_state &= ~EXT4_FC_REPLAY;
> +	kfree(sbi->s_fc_replay_state.fc_regions);
> +	kfree(sbi->s_fc_replay_state.fc_modified_inodes);
> +}
> +
> +/*
> + * Recovery Scan phase handler
> + *
> + * This function is called during the scan phase and is responsible
> + * for doing following things:
> + * - Make sure the fast commit area has valid tags for replay
> + * - Count number of tags that need to be replayed by the replay handler
> + * - Verify CRC
> + * - Create a list of excluded blocks for allocation during replay phase
> + *
> + * This function returns JBD2_FC_REPLAY_CONTINUE to indicate that SCAN is
> + * incomplete and JBD2 should send more blocks. It returns JBD2_FC_REPLAY_STOP
> + * to indicate that scan has finished and JBD2 can now start replay phase.
> + * It returns a negative error to indicate that there was an error. At the end
> + * of a successful scan phase, sbi->s_fc_replay_state.fc_replay_num_tags is set
> + * to indicate the number of tags that need to replayed during the replay phase.
> + */
> +static int ext4_fc_replay_scan(journal_t *journal,
> +				struct buffer_head *bh, int off,
> +				tid_t expected_tid)
> +{
> +	struct super_block *sb = journal->j_private;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_fc_replay_state *state;
> +	int ret = JBD2_FC_REPLAY_CONTINUE;
> +	struct ext4_fc_add_range *ext;
> +	struct ext4_fc_tl *tl;
> +	struct ext4_fc_tail *tail;
> +	__u8 *start, *end;
> +	struct ext4_fc_head *head;
> +	struct ext4_extent *ex;
> +
> +	state = &sbi->s_fc_replay_state;
> +
> +	start = (u8 *)bh->b_data;
> +	end = (__u8 *)bh->b_data + journal->j_blocksize - 1;
> +
> +	if (state->fc_replay_expected_off == 0) {
> +		state->fc_cur_tag = 0;
> +		state->fc_replay_num_tags = 0;
> +		state->fc_crc = 0;
> +		state->fc_regions = NULL;
> +		state->fc_regions_valid = state->fc_regions_used =
> +			state->fc_regions_size = 0;
> +		/* Check if we can stop early */
> +		if (le16_to_cpu(((struct ext4_fc_tl *)start)->fc_tag)
> +			!= EXT4_FC_TAG_HEAD)
> +			return 0;
> +	}
> +
> +	if (off != state->fc_replay_expected_off) {
> +		ret = -EFSCORRUPTED;
> +		goto out_err;
> +	}
> +
> +	state->fc_replay_expected_off++;
> +	fc_for_each_tl(start, end, tl) {
> +		jbd_debug(3, "Scan phase, tag:%s, blk %lld\n",
> +			  tag2str(le16_to_cpu(tl->fc_tag)), bh->b_blocknr);
> +		switch (le16_to_cpu(tl->fc_tag)) {
> +		case EXT4_FC_TAG_ADD_RANGE:
> +			ext = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
> +			ex = (struct ext4_extent *)&ext->fc_ex;
> +			ret = ext4_fc_record_regions(sb,
> +				le32_to_cpu(ext->fc_ino),
> +				le32_to_cpu(ex->ee_block), ext4_ext_pblock(ex),
> +				ext4_ext_get_actual_len(ex));
> +			if (ret < 0)
> +				break;
> +			ret = JBD2_FC_REPLAY_CONTINUE;
> +			fallthrough;
> +		case EXT4_FC_TAG_DEL_RANGE:
> +		case EXT4_FC_TAG_LINK:
> +		case EXT4_FC_TAG_UNLINK:
> +		case EXT4_FC_TAG_CREAT:
> +		case EXT4_FC_TAG_INODE_FULL:
> +		case EXT4_FC_TAG_INODE_PARTIAL:
> +		case EXT4_FC_TAG_PAD:
> +			state->fc_cur_tag++;
> +			state->fc_crc = ext4_chksum(sbi, state->fc_crc, tl,
> +					sizeof(*tl) + ext4_fc_tag_len(tl));
> +			break;
> +		case EXT4_FC_TAG_TAIL:
> +			state->fc_cur_tag++;
> +			tail = (struct ext4_fc_tail *)ext4_fc_tag_val(tl);
> +			state->fc_crc = ext4_chksum(sbi, state->fc_crc, tl,
> +						sizeof(*tl) +
> +						offsetof(struct ext4_fc_tail,
> +						fc_crc));
> +			if (le32_to_cpu(tail->fc_tid) == expected_tid &&
> +				le32_to_cpu(tail->fc_crc) == state->fc_crc) {
> +				state->fc_replay_num_tags = state->fc_cur_tag;
> +				state->fc_regions_valid =
> +					state->fc_regions_used;
> +			} else {
> +				ret = state->fc_replay_num_tags ?
> +					JBD2_FC_REPLAY_STOP : -EFSBADCRC;
> +			}
> +			state->fc_crc = 0;
> +			break;
> +		case EXT4_FC_TAG_HEAD:
> +			head = (struct ext4_fc_head *)ext4_fc_tag_val(tl);
> +			if (le32_to_cpu(head->fc_features) &
> +				~EXT4_FC_SUPPORTED_FEATURES) {
> +				ret = -EOPNOTSUPP;
> +				break;
> +			}
> +			if (le32_to_cpu(head->fc_tid) != expected_tid) {
> +				ret = JBD2_FC_REPLAY_STOP;
> +				break;
> +			}
> +			state->fc_cur_tag++;
> +			state->fc_crc = ext4_chksum(sbi, state->fc_crc, tl,
> +					sizeof(*tl) + ext4_fc_tag_len(tl));


why do we need to calculate state->fc_crc for HEAD?
I don't see we comparing this anywhere right? anything I missed?

> +			break;
> +		default:
> +			ret = state->fc_replay_num_tags ?
> +				JBD2_FC_REPLAY_STOP : -ECANCELED;
> +		}
> +		if (ret < 0 || ret == JBD2_FC_REPLAY_STOP)
> +			break;
> +	}
> +
> +out_err:
> +	trace_ext4_fc_replay_scan(sb, ret, off);
> +	return ret;
> +}
> +
>   /*
>    * Main recovery path entry point.
> + * The meaning of return codes is similar as above.
>    */
>   static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
>   				enum passtype pass, int off, tid_t expected_tid)
>   {
> -	return 0;
> +	struct super_block *sb = journal->j_private;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_fc_tl *tl;
> +	__u8 *start, *end;
> +	int ret = JBD2_FC_REPLAY_CONTINUE;
> +	struct ext4_fc_replay_state *state = &sbi->s_fc_replay_state;
> +	struct ext4_fc_tail *tail;
> +
> +	if (pass == PASS_SCAN) {
> +		state->fc_current_pass = PASS_SCAN;
> +		return ext4_fc_replay_scan(journal, bh, off, expected_tid);
> +	}
> +
> +	if (state->fc_current_pass != pass) {
> +		state->fc_current_pass = pass;
> +		sbi->s_mount_state |= EXT4_FC_REPLAY;
> +	}
> +	if (!sbi->s_fc_replay_state.fc_replay_num_tags) {
> +		jbd_debug(1, "Replay stops\n");
> +		ext4_fc_set_bitmaps_and_counters(sb);
> +		return 0;
> +	}
> +
> +#ifdef CONFIG_EXT4_DEBUG
> +	if (sbi->s_fc_debug_max_replay && off >= sbi->s_fc_debug_max_replay) {
> +		pr_warn("Dropping fc block %d because max_replay set\n", off);
> +		return -EINVAL;
> +	}
> +#endif
> +
> +	start = (u8 *)bh->b_data;
> +	end = (__u8 *)bh->b_data + journal->j_blocksize - 1;
> +
> +	fc_for_each_tl(start, end, tl) {
> +		if (state->fc_replay_num_tags == 0) {
> +			ret = JBD2_FC_REPLAY_STOP;
> +			ext4_fc_set_bitmaps_and_counters(sb);
> +			break;
> +		}
> +		jbd_debug(3, "Replay phase, tag:%s\n",
> +				tag2str(le16_to_cpu(tl->fc_tag)));
> +		state->fc_replay_num_tags--;
> +		switch (le16_to_cpu(tl->fc_tag)) {
> +		case EXT4_FC_TAG_LINK:
> +			ret = ext4_fc_replay_link(sb, tl);
> +			break;
> +		case EXT4_FC_TAG_UNLINK:
> +			ret = ext4_fc_replay_unlink(sb, tl);
> +			break;
> +		case EXT4_FC_TAG_ADD_RANGE:
> +			ret = ext4_fc_replay_add_range(sb, tl);
> +			break;
> +		case EXT4_FC_TAG_CREAT:
> +			ret = ext4_fc_replay_create(sb, tl);
> +			break;
> +		case EXT4_FC_TAG_DEL_RANGE:
> +			ret = ext4_fc_replay_del_range(sb, tl);
> +			break;
> +		case EXT4_FC_TAG_INODE_PARTIAL:
> +		case EXT4_FC_TAG_INODE_FULL:
> +			ret = ext4_fc_replay_inode(sb, tl);
> +			break;
> +		case EXT4_FC_TAG_PAD:
> +			trace_ext4_fc_replay(sb, EXT4_FC_TAG_PAD, 0,
> +				ext4_fc_tag_len(tl), 0);
> +			break;
> +		case EXT4_FC_TAG_TAIL:
> +			trace_ext4_fc_replay(sb, EXT4_FC_TAG_TAIL, 0,
> +				ext4_fc_tag_len(tl), 0);
> +			tail = (struct ext4_fc_tail *)ext4_fc_tag_val(tl);
> +			WARN_ON(le32_to_cpu(tail->fc_tid) != expected_tid);
> +			break;
> +		case EXT4_FC_TAG_HEAD:
> +			break;
> +		default:
> +			trace_ext4_fc_replay(sb, le16_to_cpu(tl->fc_tag), 0,
> +				ext4_fc_tag_len(tl), 0);
> +			ret = -ECANCELED;
> +			break;
> +		}
> +		if (ret < 0)
> +			break;
> +		ret = JBD2_FC_REPLAY_CONTINUE;
> +	}
> +	return ret;
>   }
> 
>   void ext4_fc_init(struct super_block *sb, journal_t *journal)
> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> index a541d2bbe24b..cf4d8772d055 100644
> --- a/fs/ext4/fast_commit.h
> +++ b/fs/ext4/fast_commit.h
> @@ -117,4 +117,44 @@ struct ext4_fc_stats {
>   	int fc_numblks;
>   };
> 
> +#define EXT4_FC_REPLAY_REALLOC_INCREMENT	4
> +
> +/*
> + * Physical block regions added to different inodes due to fast commit
> + * recovery. These are set during the SCAN phase. During the replay phase,
> + * our allocator excludes these from its allocation. This ensures that
> + * we don't accidentally allocating a block that is going to be used by
> + * another inode.
> + */
> +struct ext4_fc_alloc_region {
> +	ext4_lblk_t lblk;
> +	ext4_fsblk_t pblk;
> +	int ino, len;
> +};
> +
> +/*
> + * Fast commit replay state.
> + */
> +struct ext4_fc_replay_state {
> +	int fc_replay_num_tags;
> +	int fc_replay_expected_off;
> +	int fc_current_pass;
> +	int fc_cur_tag;
> +	int fc_crc;
> +	struct ext4_fc_alloc_region *fc_regions;
> +	int fc_regions_size, fc_regions_used, fc_regions_valid;
> +	int *fc_modified_inodes;
> +	int fc_modified_inodes_used, fc_modified_inodes_size;
> +};
> +
> +#define region_last(__region) (((__region)->lblk) + ((__region)->len) - 1)
> +
> +#define fc_for_each_tl(__start, __end, __tl)				\
> +	for (tl = (struct ext4_fc_tl *)start;				\
> +		(u8 *)tl < (u8 *)end;					\
> +		tl = (struct ext4_fc_tl *)((u8 *)tl +			\
> +					sizeof(struct ext4_fc_tl) +	\
> +					+ le16_to_cpu(tl->fc_len)))
> +
> +
>   #endif /* __FAST_COMMIT_H__ */
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index df25d38d6539..db9b9eeb9560 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -82,7 +82,12 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
>   				      struct buffer_head *bh)
>   {
>   	ext4_fsblk_t	blk;
> -	struct ext4_group_info *grp = ext4_get_group_info(sb, block_group);
> +	struct ext4_group_info *grp;
> +
> +	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return 0;
> +
> +	grp = ext4_get_group_info(sb, block_group);
> 
>   	if (buffer_verified(bh))
>   		return 0;
> @@ -284,15 +289,17 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
>   	bit = (ino - 1) % EXT4_INODES_PER_GROUP(sb);
>   	bitmap_bh = ext4_read_inode_bitmap(sb, block_group);
>   	/* Don't bother if the inode bitmap is corrupt. */
> -	grp = ext4_get_group_info(sb, block_group);
>   	if (IS_ERR(bitmap_bh)) {
>   		fatal = PTR_ERR(bitmap_bh);
>   		bitmap_bh = NULL;
>   		goto error_return;
>   	}
> -	if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
> -		fatal = -EFSCORRUPTED;
> -		goto error_return;
> +	if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +		grp = ext4_get_group_info(sb, block_group);
> +		if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
> +			fatal = -EFSCORRUPTED;
> +			goto error_return;
> +		}
>   	}
> 
>   	BUFFER_TRACE(bitmap_bh, "get_write_access");
> @@ -742,6 +749,119 @@ static int find_inode_bit(struct super_block *sb, ext4_group_t group,
>   	return 1;
>   }
> 
> +int ext4_mark_inode_used(struct super_block *sb, int ino)
> +{
> +	unsigned long max_ino = le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count);
> +	struct buffer_head *inode_bitmap_bh = NULL, *group_desc_bh = NULL;
> +	struct ext4_group_desc *gdp;
> +	ext4_group_t group;
> +	int bit;
> +	int err = -EFSCORRUPTED;
> +
> +	if (ino < EXT4_FIRST_INO(sb) || ino > max_ino)
> +		goto out;
> +
> +	group = (ino - 1) / EXT4_INODES_PER_GROUP(sb);
> +	bit = (ino - 1) % EXT4_INODES_PER_GROUP(sb);
> +	inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
> +	if (IS_ERR(inode_bitmap_bh))
> +		return PTR_ERR(inode_bitmap_bh);
> +
> +	if (ext4_test_bit(bit, inode_bitmap_bh->b_data)) {
> +		err = 0;
> +		goto out;
> +	}
> +
> +	gdp = ext4_get_group_desc(sb, group, &group_desc_bh);
> +	if (!gdp || !group_desc_bh) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	ext4_set_bit(bit, inode_bitmap_bh->b_data);
> +
> +	BUFFER_TRACE(inode_bitmap_bh, "call ext4_handle_dirty_metadata");
> +	err = ext4_handle_dirty_metadata(NULL, NULL, inode_bitmap_bh);
> +	if (err) {
> +		ext4_std_error(sb, err);
> +		goto out;
> +	}
> +	sync_dirty_buffer(inode_bitmap_bh);

Shouldn't we handle error from sync_dirty_buffer()?

> +	BUFFER_TRACE(group_desc_bh, "get_write_access");

The above BUFFER_TRACE() is not correct. We should remove it from here.



> +
> +	/* We may have to initialize the block bitmap if it isn't already */
> +	if (ext4_has_group_desc_csum(sb) &&
> +	    gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
> +		struct buffer_head *block_bitmap_bh;
> +
> +		block_bitmap_bh = ext4_read_block_bitmap(sb, group);
> +		if (IS_ERR(block_bitmap_bh)) {
> +			err = PTR_ERR(block_bitmap_bh);
> +			goto out;
> +		}
> +
> +		BUFFER_TRACE(block_bitmap_bh, "dirty block bitmap");
> +		err = ext4_handle_dirty_metadata(NULL, NULL, block_bitmap_bh);
> +		sync_dirty_buffer(block_bitmap_bh);
> +
> +		/* recheck and clear flag under lock if we still need to */
> +		ext4_lock_group(sb, group);
> +		if (ext4_has_group_desc_csum(sb) &&
> +		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> +			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> +			ext4_free_group_clusters_set(sb, gdp,
> +				ext4_free_clusters_after_init(sb, group, gdp));
> +			ext4_block_bitmap_csum_set(sb, group, gdp,
> +						   block_bitmap_bh);
> +			ext4_group_desc_csum_set(sb, group, gdp);
> +		}
> +		ext4_unlock_group(sb, group);
> +		brelse(block_bitmap_bh);
> +
> +		if (err) {
> +			ext4_std_error(sb, err);
> +			goto out;
> +		}
> +	}
> +
> +	/* Update the relevant bg descriptor fields */
> +	if (ext4_has_group_desc_csum(sb)) {
> +		int free;
> +
> +		ext4_lock_group(sb, group); /* while we modify the bg desc */
> +		free = EXT4_INODES_PER_GROUP(sb) -
> +			ext4_itable_unused_count(sb, gdp);
> +		if (gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT)) {
> +			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_INODE_UNINIT);
> +			free = 0;
> +		}
> +
> +		/*
> +		 * Check the relative inode number against the last used
> +		 * relative inode number in this group. if it is greater
> +		 * we need to update the bg_itable_unused count
> +		 */
> +		if (bit >= free)
> +			ext4_itable_unused_set(sb, gdp,
> +					(EXT4_INODES_PER_GROUP(sb) - bit - 1));
> +	} else {
> +		ext4_lock_group(sb, group);
> +	}
> +
> +	ext4_free_inodes_set(sb, gdp, ext4_free_inodes_count(sb, gdp) - 1);
> +	if (ext4_has_group_desc_csum(sb)) {
> +		ext4_inode_bitmap_csum_set(sb, group, gdp, inode_bitmap_bh,
> +					   EXT4_INODES_PER_GROUP(sb) / 8);
> +		ext4_group_desc_csum_set(sb, group, gdp);
> +	}
> +
> +	ext4_unlock_group(sb, group);
> +	err = ext4_handle_dirty_metadata(NULL, NULL, group_desc_bh);
> +	sync_dirty_buffer(group_desc_bh);
> +out:
> +	return err;
> +}
> +
>   /*
>    * There are two policies for allocating an inode.  If the new inode is
>    * a directory, then a forward search is made for a block group with both
> @@ -771,7 +891,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
>   	struct inode *ret;
>   	ext4_group_t i;
>   	ext4_group_t flex_group;
> -	struct ext4_group_info *grp;
> +	struct ext4_group_info *grp = NULL;
>   	int encrypt = 0;
> 
>   	/* Cannot create files in a deleted directory */
> @@ -909,15 +1029,21 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
>   		if (ext4_free_inodes_count(sb, gdp) == 0)
>   			goto next_group;
> 
> -		grp = ext4_get_group_info(sb, group);
> -		/* Skip groups with already-known suspicious inode tables */
> -		if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
> -			goto next_group;
> +		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +			grp = ext4_get_group_info(sb, group);
> +			/*
> +			 * Skip groups with already-known suspicious inode
> +			 * tables
> +			 */
> +			if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
> +				goto next_group;
> +		}
> 
>   		brelse(inode_bitmap_bh);
>   		inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
>   		/* Skip groups with suspicious inode tables */
> -		if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp) ||
> +		if (((!(sbi->s_mount_state & EXT4_FC_REPLAY))
> +		     && EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) ||
>   		    IS_ERR(inode_bitmap_bh)) {
>   			inode_bitmap_bh = NULL;
>   			goto next_group;
> @@ -936,7 +1062,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
>   			goto next_group;
>   		}
> 
> -		if (!handle) {
> +		if ((!(sbi->s_mount_state & EXT4_FC_REPLAY)) && !handle) {
>   			BUG_ON(nblocks <= 0);
>   			handle = __ext4_journal_start_sb(dir->i_sb, line_no,
>   				 handle_type, nblocks, 0,
> @@ -1040,9 +1166,15 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
>   	/* Update the relevant bg descriptor fields */
>   	if (ext4_has_group_desc_csum(sb)) {
>   		int free;
> -		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
> -
> -		down_read(&grp->alloc_sem); /* protect vs itable lazyinit */
> +		struct ext4_group_info *grp = NULL;
> +
> +		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +			grp = ext4_get_group_info(sb, group);
> +			down_read(&grp->alloc_sem); /*
> +						     * protect vs itable
> +						     * lazyinit
> +						     */
> +		}
>   		ext4_lock_group(sb, group); /* while we modify the bg desc */
>   		free = EXT4_INODES_PER_GROUP(sb) -
>   			ext4_itable_unused_count(sb, gdp);
> @@ -1058,7 +1190,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
>   		if (ino > free)
>   			ext4_itable_unused_set(sb, gdp,
>   					(EXT4_INODES_PER_GROUP(sb) - ino));
> -		up_read(&grp->alloc_sem);
> +		if (!(sbi->s_mount_state & EXT4_FC_REPLAY))
> +			up_read(&grp->alloc_sem);
>   	} else {
>   		ext4_lock_group(sb, group);
>   	}
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 26eed76812f9..9dce088171cc 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -101,8 +101,8 @@ static int ext4_inode_csum_verify(struct inode *inode, struct ext4_inode *raw,
>   	return provided == calculated;
>   }
> 
> -static void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
> -				struct ext4_inode_info *ei)
> +void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
> +			 struct ext4_inode_info *ei)
>   {
>   	__u32 csum;
> 
> @@ -514,7 +514,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>   		return -EFSCORRUPTED;
> 
>   	/* Lookup extent status tree firstly */
> -	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> +	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
> +	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
>   		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
>   			map->m_pblk = ext4_es_pblock(&es) +
>   					map->m_lblk - es.es_lblk;
> @@ -827,7 +828,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
>   	int create = map_flags & EXT4_GET_BLOCKS_CREATE;
>   	int err;
> 
> -	J_ASSERT(handle != NULL || create == 0);
> +	J_ASSERT((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		 || handle != NULL || create == 0);
> 
>   	map.m_lblk = block;
>   	map.m_len = 1;
> @@ -843,7 +845,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
>   		return ERR_PTR(-ENOMEM);
>   	if (map.m_flags & EXT4_MAP_NEW) {
>   		J_ASSERT(create != 0);
> -		J_ASSERT(handle != NULL);
> +		J_ASSERT((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +			 || (handle != NULL));
> 
>   		/*
>   		 * Now that we do not always journal data, we should
> @@ -4255,22 +4258,22 @@ int ext4_truncate(struct inode *inode)
>    * data in memory that is needed to recreate the on-disk version of this
>    * inode.
>    */
> -static int __ext4_get_inode_loc(struct inode *inode,
> -				struct ext4_iloc *iloc, int in_mem)
> +static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
> +				struct ext4_iloc *iloc, int in_mem,
> +				ext4_fsblk_t *ret_block)
>   {
>   	struct ext4_group_desc	*gdp;
>   	struct buffer_head	*bh;
> -	struct super_block	*sb = inode->i_sb;
>   	ext4_fsblk_t		block;
>   	struct blk_plug		plug;
>   	int			inodes_per_block, inode_offset;
> 
>   	iloc->bh = NULL;
> -	if (inode->i_ino < EXT4_ROOT_INO ||
> -	    inode->i_ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
> +	if (ino < EXT4_ROOT_INO ||
> +	    ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
>   		return -EFSCORRUPTED;
> 
> -	iloc->block_group = (inode->i_ino - 1) / EXT4_INODES_PER_GROUP(sb);
> +	iloc->block_group = (ino - 1) / EXT4_INODES_PER_GROUP(sb);
>   	gdp = ext4_get_group_desc(sb, iloc->block_group, NULL);
>   	if (!gdp)
>   		return -EIO;
> @@ -4279,7 +4282,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
>   	 * Figure out the offset within the block group inode table
>   	 */
>   	inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
> -	inode_offset = ((inode->i_ino - 1) %
> +	inode_offset = ((ino - 1) %
>   			EXT4_INODES_PER_GROUP(sb));
>   	block = ext4_inode_table(sb, gdp) + (inode_offset / inodes_per_block);
>   	iloc->offset = (inode_offset % inodes_per_block) * EXT4_INODE_SIZE(sb);
> @@ -4380,7 +4383,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
>   		 * has in-inode xattrs, or we don't have this inode in memory.
>   		 * Read the block from disk.
>   		 */
> -		trace_ext4_load_inode(inode);
> +		trace_ext4_load_inode(sb, ino);
>   		get_bh(bh);
>   		bh->b_end_io = end_buffer_read_sync;
>   		submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
> @@ -4388,8 +4391,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
>   		wait_on_buffer(bh);
>   		if (!buffer_uptodate(bh)) {
>   		simulate_eio:
> -			ext4_error_inode_block(inode, block, EIO,
> -					       "unable to read itable block");
> +			if (ret_block)
> +				*ret_block = block;
>   			brelse(bh);
>   			return -EIO;
>   		}
> @@ -4399,11 +4402,43 @@ static int __ext4_get_inode_loc(struct inode *inode,
>   	return 0;
>   }
> 
> +static int __ext4_get_inode_loc_noinmem(struct inode *inode,
> +					struct ext4_iloc *iloc)
> +{
> +	ext4_fsblk_t err_blk;
> +	int ret;
> +
> +	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, iloc, 0,
> +					&err_blk);
> +
> +	if (ret == -EIO)
> +		ext4_error_inode_block(inode, err_blk, EIO,
> +					"unable to read itable block");
> +
> +	return ret;
> +}
> +
>   int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
>   {
> +	ext4_fsblk_t err_blk;
> +	int ret;
> +
>   	/* We have all inode data except xattrs in memory here. */
> -	return __ext4_get_inode_loc(inode, iloc,
> -		!ext4_test_inode_state(inode, EXT4_STATE_XATTR));
> +	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, iloc,
> +		!ext4_test_inode_state(inode, EXT4_STATE_XATTR), &err_blk);
> +
> +	if (ret == -EIO)
> +		ext4_error_inode_block(inode, err_blk, EIO,
> +					"unable to read itable block");
> +
> +	return ret;
> +}
> +
> +
> +int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
> +			  struct ext4_iloc *iloc)
> +{
> +	return __ext4_get_inode_loc(sb, ino, iloc, 0, NULL);
>   }
> 
>   static bool ext4_should_enable_dax(struct inode *inode)
> @@ -4569,7 +4604,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>   	ei = EXT4_I(inode);
>   	iloc.bh = NULL;
> 
> -	ret = __ext4_get_inode_loc(inode, &iloc, 0);
> +	ret = __ext4_get_inode_loc_noinmem(inode, &iloc);
>   	if (ret < 0)
>   		goto bad_inode;
>   	raw_inode = ext4_raw_inode(&iloc);
> @@ -4615,10 +4650,11 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>   					      sizeof(gen));
>   	}
> 
> -	if (!ext4_inode_csum_verify(inode, raw_inode, ei) ||
> -	    ext4_simulate_fail(sb, EXT4_SIM_INODE_CRC)) {
> -		ext4_error_inode_err(inode, function, line, 0, EFSBADCRC,
> -				     "iget: checksum invalid");
> +	if ((!ext4_inode_csum_verify(inode, raw_inode, ei) ||
> +	    ext4_simulate_fail(sb, EXT4_SIM_INODE_CRC)) &&
> +	     (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))) {
> +		ext4_error_inode_err(inode, function, line, 0,
> +				EFSBADCRC, "iget: checksum invalid");
>   		ret = -EFSBADCRC;
>   		goto bad_inode;
>   	}
> @@ -4772,9 +4808,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>   		goto bad_inode;
>   	} else if (!ext4_has_inline_data(inode)) {
>   		/* validate the block references in the inode */
> -		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> -		   (S_ISLNK(inode->i_mode) &&
> -		    !ext4_inode_is_fast_symlink(inode))) {
> +		if (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
> +			(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> +			(S_ISLNK(inode->i_mode) &&
> +			!ext4_inode_is_fast_symlink(inode)))) {
>   			if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>   				ret = ext4_ext_check_inode(inode);
>   			else
> @@ -5158,7 +5195,7 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
>   	} else {
>   		struct ext4_iloc iloc;
> 
> -		err = __ext4_get_inode_loc(inode, &iloc, 0);
> +		err = __ext4_get_inode_loc_noinmem(inode, &iloc);
>   		if (err)
>   			return err;
>   		/*
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index d2f8f50deef6..f0381876a7e5 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -86,7 +86,7 @@ static void swap_inode_data(struct inode *inode1, struct inode *inode2)
>   	i_size_write(inode2, isize);
>   }
> 
> -static void reset_inode_seed(struct inode *inode)
> +void ext4_reset_inode_seed(struct inode *inode)
>   {
>   	struct ext4_inode_info *ei = EXT4_I(inode);
>   	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> @@ -200,8 +200,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
> 
>   	inode->i_generation = prandom_u32();
>   	inode_bl->i_generation = prandom_u32();
> -	reset_inode_seed(inode);
> -	reset_inode_seed(inode_bl);
> +	ext4_reset_inode_seed(inode);
> +	ext4_reset_inode_seed(inode_bl);
> 
>   	ext4_discard_preallocations(inode, 0);
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 132c118d12e1..ea894529118a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1508,14 +1508,16 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
> 
>   		blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
>   		blocknr += EXT4_C2B(sbi, block);
> -		ext4_grp_locked_error(sb, e4b->bd_group,
> -				      inode ? inode->i_ino : 0,
> -				      blocknr,
> -				      "freeing already freed block "
> -				      "(bit %u); block bitmap corrupt.",
> -				      block);
> -		ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
> +		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +			ext4_grp_locked_error(sb, e4b->bd_group,
> +					      inode ? inode->i_ino : 0,
> +					      blocknr,
> +					      "freeing already freed block (bit %u); block bitmap corrupt.",
> +					      block);
> +			ext4_mark_group_bitmap_corrupted(
> +				sb, e4b->bd_group,
>   				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
> +		}
>   		mb_regenerate_buddy(e4b);
>   		goto done;
>   	}
> @@ -3302,6 +3304,86 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>   	return err;
>   }
> 
> +/*
> + * Idempotent helper for Ext4 fast commit replay path to set the state of
> + * blocks in bitmaps and update counters.
> + */
> +void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
> +			int len, int state)
> +{
> +	struct buffer_head *bitmap_bh = NULL;
> +	struct ext4_group_desc *gdp;
> +	struct buffer_head *gdp_bh;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	ext4_group_t group;
> +	ext4_fsblk_t cluster;

I guess we never use this variable cluster. We can as well drop it.

-ritesh

