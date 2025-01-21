Return-Path: <linux-ext4+bounces-6178-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A6A17DE4
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 13:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E081615CF
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97291F192B;
	Tue, 21 Jan 2025 12:40:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6B07462;
	Tue, 21 Jan 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463245; cv=none; b=TpCPchX9oEPUwgwQ/7TMbwD2oyhlWd6GDTELKAc5TwXhlv2we7U2hqt0G03gAR59mTZo/JcEZCIcJAGb6sXSwsoMN57eggi12EmVeMp2yBOcP8VrCLdauumeN1E5x5lefJa9FGVkjHR69yg0i7HBEkjOzQ7sA8oLquzLgdyBlmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463245; c=relaxed/simple;
	bh=vJwE1dicOExyGKHaB6uZRNdKjhQCqXqGQ5JjPK66Dhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m47kgDX49HGFhQC0MB8eRDRM6SMv0BQxZcctN8UIIWwmZGxFQ/bN1gXyDwMW+iyNGytScFeHBcbmYruvQUpvpalHQAw6zNDY8ru53EZLzow4DyWcXFOsu4z/SfwYfhe5B1kmEmKBp8eL6GohfOrKfffjBB/QL9KxOuzcxlYo8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ycmsy6KM2zjY88;
	Tue, 21 Jan 2025 20:36:38 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id D01031800D1;
	Tue, 21 Jan 2025 20:40:37 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 20:40:36 +0800
Message-ID: <ac90b827-d3e9-4385-8024-e967d21c7dc1@huawei.com>
Date: Tue, 21 Jan 2025 20:40:36 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] ext4: add ext4_is_emergency() helper function
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>, Baokun Li
	<libaokun@huaweicloud.com>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
 <20250117082315.2869996-4-libaokun@huaweicloud.com>
 <wxsrvwqzfobohnn7tbgrheqwcnmdkvcvfzj36genpfbv35lkhp@kitqutr3avyf>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <wxsrvwqzfobohnn7tbgrheqwcnmdkvcvfzj36genpfbv35lkhp@kitqutr3avyf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/21 20:14, Jan Kara wrote:
> On Fri 17-01-25 16:23:11, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Since both SHUTDOWN and EMERGENCY_RO are emergency states of the ext4 file
>> system, and they are checked in similar locations, we have added a helper
>> function, ext4_is_emergency(), to determine whether the current file system
>> is in one of these two emergency states.
>>
>> Then, replace calls to ext4_forced_shutdown() with ext4_is_emergency() in
>> those functions that could potentially trigger write operations.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Looks good, just one naming suggestion:
>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index c5b775482897..ca01b476e42b 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -2249,6 +2249,15 @@ static inline int ext4_emergency_ro(struct super_block *sb)
>>   	return test_bit(EXT4_FLAGS_EMERGENCY_RO, &EXT4_SB(sb)->s_ext4_flags);
>>   }
>>   
>> +static inline int ext4_is_emergency(struct super_block *sb)
>> +{
>> +	if (unlikely(ext4_forced_shutdown(sb)))
>> +		return -EIO;
>> +	if (unlikely(ext4_emergency_ro(sb)))
>> +		return -EROFS;
>> +	return 0;
>> +}
> Since this actually returns error I'd call it ext4_emergency_state() or
> something like that. Otherwise feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
Yeah, ext4_emergency_state() sounds better than ext4_is_emergency().
We thought about ext4_sb_permission, ext4_check_writable, and
ext4_sb_access, but felt that none of them were quite suitable.

I'll use ext4_emergency_state() in the next version.
Thanks for your review and the naming suggestion!


Cheers,
Baokun

>
>> +
>>   /*
>>    * Default values for user and/or group using reserved blocks
>>    */
>> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
>> index da4a82456383..2c4e976360f1 100644
>> --- a/fs/ext4/ext4_jbd2.c
>> +++ b/fs/ext4/ext4_jbd2.c
>> @@ -63,12 +63,14 @@ static void ext4_put_nojournal(handle_t *handle)
>>    */
>>   static int ext4_journal_check_start(struct super_block *sb)
>>   {
>> +	int ret;
>>   	journal_t *journal;
>>   
>>   	might_sleep();
>>   
>> -	if (unlikely(ext4_forced_shutdown(sb)))
>> -		return -EIO;
>> +	ret = ext4_is_emergency(sb);
>> +	if (unlikely(ret))
>> +		return ret;
>>   
>>   	if (WARN_ON_ONCE(sb_rdonly(sb)))
>>   		return -EROFS;
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index a5205149adba..6db052a87b9b 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -688,10 +688,12 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   static ssize_t
>>   ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   {
>> +	int ret;
>>   	struct inode *inode = file_inode(iocb->ki_filp);
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> -		return -EIO;
>> +	ret = ext4_is_emergency(inode->i_sb);
>> +	if (unlikely(ret))
>> +		return ret;
>>   
>>   #ifdef CONFIG_FS_DAX
>>   	if (IS_DAX(inode))
>> @@ -700,7 +702,6 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   
>>   	if (iocb->ki_flags & IOCB_ATOMIC) {
>>   		size_t len = iov_iter_count(from);
>> -		int ret;
>>   
>>   		if (len < EXT4_SB(inode->i_sb)->s_awu_min ||
>>   		    len > EXT4_SB(inode->i_sb)->s_awu_max)
>> @@ -803,11 +804,16 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
>>   
>>   static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>>   {
>> +	int ret;
>>   	struct inode *inode = file->f_mapping->host;
>>   	struct dax_device *dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> -		return -EIO;
>> +	if (file->f_mode & FMODE_WRITE)
>> +		ret = ext4_is_emergency(inode->i_sb);
>> +	else
>> +		ret = ext4_forced_shutdown(inode->i_sb) ? -EIO : 0;
>> +	if (unlikely(ret))
>> +		return ret;
>>   
>>   	/*
>>   	 * We don't support synchronous mappings for non-DAX files and
>> @@ -881,8 +887,12 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
>>   {
>>   	int ret;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> -		return -EIO;
>> +	if (filp->f_mode & FMODE_WRITE)
>> +		ret = ext4_is_emergency(inode->i_sb);
>> +	else
>> +		ret = ext4_forced_shutdown(inode->i_sb) ? -EIO : 0;
>> +	if (unlikely(ret))
>> +		return ret;
>>   
>>   	ret = ext4_sample_last_mounted(inode->i_sb, filp->f_path.mnt);
>>   	if (ret)
>> diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
>> index b40d3b29f7e5..ee9078a5d098 100644
>> --- a/fs/ext4/fsync.c
>> +++ b/fs/ext4/fsync.c
>> @@ -132,20 +132,16 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>>   	bool needs_barrier = false;
>>   	struct inode *inode = file->f_mapping->host;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> -		return -EIO;
>> +	ret = ext4_is_emergency(inode->i_sb);
>> +	if (unlikely(ret))
>> +		return ret;
>>   
>>   	ASSERT(ext4_journal_current_handle() == NULL);
>>   
>>   	trace_ext4_sync_file_enter(file, datasync);
>>   
>> -	if (sb_rdonly(inode->i_sb)) {
>> -		/* Make sure that we read updated s_ext4_flags value */
>> -		smp_rmb();
>> -		if (ext4_forced_shutdown(inode->i_sb))
>> -			ret = -EROFS;
>> +	if (sb_rdonly(inode->i_sb))
>>   		goto out;
>> -	}
>>   
>>   	if (!EXT4_SB(inode->i_sb)->s_journal) {
>>   		ret = ext4_fsync_nojournal(file, start, end, datasync,
>> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
>> index 21d228073d79..4d0af20fa319 100644
>> --- a/fs/ext4/ialloc.c
>> +++ b/fs/ext4/ialloc.c
>> @@ -951,8 +951,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>>   	sb = dir->i_sb;
>>   	sbi = EXT4_SB(sb);
>>   
>> -	if (unlikely(ext4_forced_shutdown(sb)))
>> -		return ERR_PTR(-EIO);
>> +	ret2 = ext4_is_emergency(sb);
>> +	if (unlikely(ret2))
>> +		return ERR_PTR(ret2);
>>   
>>   	ngroups = ext4_get_groups_count(sb);
>>   	trace_ext4_request_inode(dir, mode);
>> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
>> index 3536ca7e4fcc..d44cc9b5589e 100644
>> --- a/fs/ext4/inline.c
>> +++ b/fs/ext4/inline.c
>> @@ -228,7 +228,7 @@ static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
>>   	struct ext4_inode *raw_inode;
>>   	int cp_len = 0;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> +	if (unlikely(ext4_is_emergency(inode->i_sb)))
>>   		return;
>>   
>>   	BUG_ON(!EXT4_I(inode)->i_inline_off);
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 7c54ae5fcbd4..3971e10874eb 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1149,8 +1149,9 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>   	pgoff_t index;
>>   	unsigned from, to;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> -		return -EIO;
>> +	ret = ext4_is_emergency(inode->i_sb);
>> +	if (unlikely(ret))
>> +		return ret;
>>   
>>   	trace_ext4_write_begin(inode, pos, len);
>>   	/*
>> @@ -2273,7 +2274,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>>   		if (err < 0) {
>>   			struct super_block *sb = inode->i_sb;
>>   
>> -			if (ext4_forced_shutdown(sb))
>> +			if (ext4_is_emergency(sb))
>>   				goto invalidate_dirty_pages;
>>   			/*
>>   			 * Let the uper layers retry transient errors.
>> @@ -2599,10 +2600,9 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>>   	 * *never* be called, so if that ever happens, we would want
>>   	 * the stack trace.
>>   	 */
>> -	if (unlikely(ext4_forced_shutdown(mapping->host->i_sb))) {
>> -		ret = -EROFS;
>> +	ret = ext4_is_emergency(mapping->host->i_sb);
>> +	if (unlikely(ret))
>>   		goto out_writepages;
>> -	}
>>   
>>   	/*
>>   	 * If we have inline data and arrive here, it means that
>> @@ -2817,8 +2817,9 @@ static int ext4_writepages(struct address_space *mapping,
>>   	int ret;
>>   	int alloc_ctx;
>>   
>> -	if (unlikely(ext4_forced_shutdown(sb)))
>> -		return -EIO;
>> +	ret = ext4_is_emergency(sb);
>> +	if (unlikely(ret))
>> +		return ret;
>>   
>>   	alloc_ctx = ext4_writepages_down_read(sb);
>>   	ret = ext4_do_writepages(&mpd);
>> @@ -2858,8 +2859,9 @@ static int ext4_dax_writepages(struct address_space *mapping,
>>   	struct inode *inode = mapping->host;
>>   	int alloc_ctx;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> -		return -EIO;
>> +	ret = ext4_is_emergency(inode->i_sb);
>> +	if (unlikely(ret))
>> +		return ret;
>>   
>>   	alloc_ctx = ext4_writepages_down_read(inode->i_sb);
>>   	trace_ext4_writepages(inode, wbc);
>> @@ -2915,8 +2917,9 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>>   	pgoff_t index;
>>   	struct inode *inode = mapping->host;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> -		return -EIO;
>> +	ret = ext4_is_emergency(inode->i_sb);
>> +	if (unlikely(ret))
>> +		return ret;
>>   
>>   	index = pos >> PAGE_SHIFT;
>>   
>> @@ -5228,8 +5231,9 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
>>   	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC))
>>   		return 0;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> -		return -EIO;
>> +	err = ext4_is_emergency(inode->i_sb);
>> +	if (unlikely(err))
>> +		return err;
>>   
>>   	if (EXT4_SB(inode->i_sb)->s_journal) {
>>   		if (ext4_journal_current_handle()) {
>> @@ -5351,8 +5355,9 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>   	const unsigned int ia_valid = attr->ia_valid;
>>   	bool inc_ivers = true;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> -		return -EIO;
>> +	error = ext4_is_emergency(inode->i_sb);
>> +	if (unlikely(error))
>> +		return error;
>>   
>>   	if (unlikely(IS_IMMUTABLE(inode)))
>>   		return -EPERM;
>> @@ -5796,9 +5801,10 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>>   {
>>   	int err = 0;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb))) {
>> +	err = ext4_is_emergency(inode->i_sb);
>> +	if (unlikely(err)) {
>>   		put_bh(iloc->bh);
>> -		return -EIO;
>> +		return err;
>>   	}
>>   	ext4_fc_track_inode(handle, inode);
>>   
>> @@ -5822,8 +5828,9 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
>>   {
>>   	int err;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> -		return -EIO;
>> +	err = ext4_is_emergency(inode->i_sb);
>> +	if (unlikely(err))
>> +		return err;
>>   
>>   	err = ext4_get_inode_loc(inode, iloc);
>>   	if (!err) {
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index b25a27c86696..7c783cb2a1dc 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -5653,7 +5653,7 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
>>   {
>>   	ext4_group_t i, ngroups;
>>   
>> -	if (ext4_forced_shutdown(sb))
>> +	if (ext4_is_emergency(sb))
>>   		return;
>>   
>>   	ngroups = ext4_get_groups_count(sb);
>> @@ -5687,7 +5687,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
>>   {
>>   	struct super_block *sb = ac->ac_sb;
>>   
>> -	if (ext4_forced_shutdown(sb))
>> +	if (ext4_is_emergency(sb))
>>   		return;
>>   
>>   	mb_debug(sb, "Can't allocate:"
>> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
>> index d64c04ed061a..a3ae72ce3aa1 100644
>> --- a/fs/ext4/mmp.c
>> +++ b/fs/ext4/mmp.c
>> @@ -162,7 +162,7 @@ static int kmmpd(void *data)
>>   	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
>>   	       sizeof(mmp->mmp_nodename));
>>   
>> -	while (!kthread_should_stop() && !ext4_forced_shutdown(sb)) {
>> +	while (!kthread_should_stop() && !ext4_is_emergency(sb)) {
>>   		if (!ext4_has_feature_mmp(sb)) {
>>   			ext4_warning(sb, "kmmpd being stopped since MMP feature"
>>   				     " has been disabled.");
>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> index 536d56d15072..72907dd96e6a 100644
>> --- a/fs/ext4/namei.c
>> +++ b/fs/ext4/namei.c
>> @@ -3151,8 +3151,9 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
>>   	struct ext4_dir_entry_2 *de;
>>   	handle_t *handle = NULL;
>>   
>> -	if (unlikely(ext4_forced_shutdown(dir->i_sb)))
>> -		return -EIO;
>> +	retval = ext4_is_emergency(dir->i_sb);
>> +	if (unlikely(retval))
>> +		return retval;
>>   
>>   	/* Initialize quotas before so that eventual writes go in
>>   	 * separate transaction */
>> @@ -3309,8 +3310,9 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
>>   {
>>   	int retval;
>>   
>> -	if (unlikely(ext4_forced_shutdown(dir->i_sb)))
>> -		return -EIO;
>> +	retval = ext4_is_emergency(dir->i_sb);
>> +	if (unlikely(retval))
>> +		return retval;
>>   
>>   	trace_ext4_unlink_enter(dir, dentry);
>>   	/*
>> @@ -3376,8 +3378,9 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
>>   	struct fscrypt_str disk_link;
>>   	int retries = 0;
>>   
>> -	if (unlikely(ext4_forced_shutdown(dir->i_sb)))
>> -		return -EIO;
>> +	err = ext4_is_emergency(dir->i_sb);
>> +	if (unlikely(err))
>> +		return err;
>>   
>>   	err = fscrypt_prepare_symlink(dir, symname, len, dir->i_sb->s_blocksize,
>>   				      &disk_link);
>> @@ -4199,8 +4202,9 @@ static int ext4_rename2(struct mnt_idmap *idmap,
>>   {
>>   	int err;
>>   
>> -	if (unlikely(ext4_forced_shutdown(old_dir->i_sb)))
>> -		return -EIO;
>> +	err = ext4_is_emergency(old_dir->i_sb);
>> +	if (unlikely(err))
>> +		return err;
>>   
>>   	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>>   		return -EINVAL;
>> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
>> index 69b8a7221a2b..0e5e1de6b534 100644
>> --- a/fs/ext4/page-io.c
>> +++ b/fs/ext4/page-io.c
>> @@ -183,7 +183,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
>>   
>>   	io_end->handle = NULL;	/* Following call will use up the handle */
>>   	ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
>> -	if (ret < 0 && !ext4_forced_shutdown(inode->i_sb)) {
>> +	if (ret < 0 && !ext4_is_emergency(inode->i_sb)) {
>>   		ext4_msg(inode->i_sb, KERN_EMERG,
>>   			 "failed to convert unwritten extents to written "
>>   			 "extents -- potential data loss!  "
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index a50e5c31b937..c12133628ee9 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -819,7 +819,7 @@ void __ext4_error(struct super_block *sb, const char *function,
>>   	struct va_format vaf;
>>   	va_list args;
>>   
>> -	if (unlikely(ext4_forced_shutdown(sb)))
>> +	if (unlikely(ext4_is_emergency(sb)))
>>   		return;
>>   
>>   	trace_ext4_error(sb, function, line);
>> @@ -844,7 +844,7 @@ void __ext4_error_inode(struct inode *inode, const char *function,
>>   	va_list args;
>>   	struct va_format vaf;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> +	if (unlikely(ext4_is_emergency(inode->i_sb)))
>>   		return;
>>   
>>   	trace_ext4_error(inode->i_sb, function, line);
>> @@ -879,7 +879,7 @@ void __ext4_error_file(struct file *file, const char *function,
>>   	struct inode *inode = file_inode(file);
>>   	char pathname[80], *path;
>>   
>> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>> +	if (unlikely(ext4_is_emergency(inode->i_sb)))
>>   		return;
>>   
>>   	trace_ext4_error(inode->i_sb, function, line);
>> @@ -959,7 +959,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
>>   	char nbuf[16];
>>   	const char *errstr;
>>   
>> -	if (unlikely(ext4_forced_shutdown(sb)))
>> +	if (unlikely(ext4_is_emergency(sb)))
>>   		return;
>>   
>>   	/* Special case: if the error is EROFS, and we're not already
>> @@ -1053,7 +1053,7 @@ __acquires(bitlock)
>>   	struct va_format vaf;
>>   	va_list args;
>>   
>> -	if (unlikely(ext4_forced_shutdown(sb)))
>> +	if (unlikely(ext4_is_emergency(sb)))
>>   		return;
>>   
>>   	trace_ext4_error(sb, function, line);
>> @@ -6336,8 +6336,9 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
>>   	bool needs_barrier = false;
>>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>>   
>> -	if (unlikely(ext4_forced_shutdown(sb)))
>> -		return -EIO;
>> +	ret = ext4_is_emergency(sb);
>> +	if (unlikely(ret))
>> +		return ret;
>>   
>>   	trace_ext4_sync_fs(sb, wait);
>>   	flush_workqueue(sbi->rsv_conversion_wq);
>> @@ -6419,7 +6420,7 @@ static int ext4_freeze(struct super_block *sb)
>>    */
>>   static int ext4_unfreeze(struct super_block *sb)
>>   {
>> -	if (ext4_forced_shutdown(sb))
>> +	if (ext4_is_emergency(sb))
>>   		return 0;
>>   
>>   	if (EXT4_SB(sb)->s_journal) {
>> @@ -6575,7 +6576,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>>   	flush_work(&sbi->s_sb_upd_work);
>>   
>>   	if ((bool)(fc->sb_flags & SB_RDONLY) != sb_rdonly(sb)) {
>> -		if (ext4_forced_shutdown(sb)) {
>> +		if (ext4_is_emergency(sb)) {
>>   			err = -EROFS;
>>   			goto restore_opts;
>>   		}
>> -- 
>> 2.39.2
>>


