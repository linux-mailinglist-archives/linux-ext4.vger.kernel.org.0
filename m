Return-Path: <linux-ext4+bounces-6182-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E597BA17F6C
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 15:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CC13A3489
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7E1F37A2;
	Tue, 21 Jan 2025 14:08:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B163CF;
	Tue, 21 Jan 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468513; cv=none; b=lcoRgYZls3AhCZodpkNpCMzlT/SiCjAp3OlHWOxCbtBDJWKGJswjyO/C9axHvRekSNAJQue0fHeF41CBAVdI+JWY8uFTGUI7y092rppiknmjuC5sCgAFOwb2PLEuEJjJsQZ0gqD5vM/Ut4aMhK64g686hpyNy8ECh88d+TGgYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468513; c=relaxed/simple;
	bh=8zLhnbe8SuDvCU9PeCY2Z0vIHY8nGVTgdEkTOHFiVlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HY92MwTV6ZisucTG9VgZqPArny3owyc+6B6GHCs4Co+esCcnMBym+ow7iF27pH0J4ouhQyWhMiFR5Z6ng/rpVS64rbzf6aIqUEGqVSRVFG5G1uzt5gsbNuS3TdEg/jsl50anQ4ISbhFtDRlTBAN9GnmzdHM34EL2OYqBweyw2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ycpsw59YnzmZ5N;
	Tue, 21 Jan 2025 22:06:44 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id B51351802D1;
	Tue, 21 Jan 2025 22:08:23 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 22:08:22 +0800
Message-ID: <9c62bb25-cfe4-4dbc-a1f0-c0afe5a005b5@huawei.com>
Date: Tue, 21 Jan 2025 22:08:21 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] ext4: add ext4_sb_rdonly() helper function
To: Jan Kara <jack@suse.cz>
CC: <libaokun@huaweicloud.com>, <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
 <20250117082315.2869996-5-libaokun@huaweicloud.com>
 <lnxxxz7xxwhtcywd2yaudkypffubonvl3zu5ehahzznqj5woov@fn6w6asmsw4q>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <lnxxxz7xxwhtcywd2yaudkypffubonvl3zu5ehahzznqj5woov@fn6w6asmsw4q>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/21 21:11, Jan Kara wrote:
> On Fri 17-01-25 16:23:12, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Because both SB_RDONLY and EXT4_FLAGS_EMERGENCY_RO indicate the file system
>> is read-only, the ext4_sb_rdonly() helper function is added. This function
>> returns true if either flag is set, signifying that the file system is
>> read-only.
>>
>> Then replace some sb_rdonly() with ext4_sb_rdonly() to avoid unexpected
>> failures of some read-only operations or modification of the superblock
>> after setting EXT4_FLAGS_EMERGENCY_RO.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> I'm not sure we really need this. I rather think more places need
> additional ext4_emergency_state() checks. Look:
Make sense. 🤔
>
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index 6db052a87b9b..70b556c87b88 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -844,7 +844,7 @@ static int ext4_sample_last_mounted(struct super_block *sb,
>>   	if (likely(ext4_test_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED)))
>>   		return 0;
>>   
>> -	if (sb_rdonly(sb) || !sb_start_intwrite_trylock(sb))
>> +	if (ext4_sb_rdonly(sb) || !sb_start_intwrite_trylock(sb))
> We don't want to be modifying superblock if the filesystem is shutdown so I
> think we should have here something like:
>
> 	if (ext4_emergency_state(sb) || sb_rdonly(sb) ||
> 	    !sb_start_intwrite_trylock(sb))
That's right, if the file system is already down, the caller will
return -EIO before calling ext4_sample_last_mounted().
>>   		return 0;
>>   
>>   	ext4_set_mount_flag(sb, EXT4_MF_MNTDIR_SAMPLED);
>> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
>> index 7b9ce71c1c81..0807ee8cbcdc 100644
>> --- a/fs/ext4/ioctl.c
>> +++ b/fs/ext4/ioctl.c
>> @@ -1705,7 +1705,7 @@ int ext4_update_overhead(struct super_block *sb, bool force)
>>   {
>>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>>   
>> -	if (sb_rdonly(sb))
>> +	if (ext4_sb_rdonly(sb))
>>   		return 0;
> Similarly here I think we should have:
>
> 	if (ext4_emergency_state(sb) || sb_rdonly(sb))
> 		return 0;
Alright, even though there could be some overhead inconsistencies here,
we update s_overhead when mounting if bigalloc is not enabled.
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index c12133628ee9..fc5d30123f22 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -473,7 +473,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
>>   	__u64 lifetime_write_kbytes;
>>   	__u64 diff_size;
>>   
>> -	if (sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
>> +	if (ext4_sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
>>   	    !journal || (journal->j_flags & JBD2_UNMOUNT))
>>   		return;
> And here we should add ext4_emergency_state() check as well.
Right, the return value doesn't matter here.
>> @@ -707,7 +707,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>>   	if (test_opt(sb, WARN_ON_ERROR))
>>   		WARN_ON_ONCE(1);
>>   
>> -	if (!continue_fs && !sb_rdonly(sb)) {
>> +	if (!continue_fs && !ext4_sb_rdonly(sb)) {
> Here I actually think we should just drop the sb_rdonly() check completely?
> Because callers have already checked we are not in emergency state yet and
> we want to shutdown the fs (or later flag the emergency RO state) even if
> the filesystem is mounted read only?
Yeah, I totally agree, the error handling is now completely
independent of sb_rdonly(), so we can get rid of it.
>
>>   		set_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
>>   		if (journal)
>>   			jbd2_journal_abort(journal, -EIO);
>> @@ -737,7 +737,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>>   			sb->s_id);
>>   	}
>>   
>> -	if (sb_rdonly(sb) || continue_fs)
>> +	if (ext4_sb_rdonly(sb) || continue_fs)
>>   		return;
> This will need a bit of reworking with the emergency ro flag anyway so for
> now I'd leave it as is.
Yes, we can keep it here for now and then replace it with
ext4_emergency_ro() later on.
>>   
>>   	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
>> @@ -765,7 +765,7 @@ static void update_super_work(struct work_struct *work)
>>   	 * We use directly jbd2 functions here to avoid recursing back into
>>   	 * ext4 error handling code during handling of previous errors.
>>   	 */
>> -	if (!sb_rdonly(sbi->s_sb) && journal) {
>> +	if (!ext4_sb_rdonly(sbi->s_sb) && journal) {
>>   		struct buffer_head *sbh = sbi->s_sbh;
>>   		bool call_notify_err = false;
> Again here I think we should just add ext4_emergency_state() check because
> we don't want to be modifying superblock on shutdown filesystem either. And
> in the four cases below as well.
Yeah, let me just use ext4_emergency_state() directly instead of
a new helper function in the next version.

Thanks for your review and the detailed explanation!


Regards,
Baokun

>> @@ -1325,12 +1325,12 @@ static void ext4_put_super(struct super_block *sb)
>>   	ext4_mb_release(sb);
>>   	ext4_ext_release(sb);
>>   
>> -	if (!sb_rdonly(sb) && !aborted) {
>> +	if (!ext4_sb_rdonly(sb) && !aborted) {
>>   		ext4_clear_feature_journal_needs_recovery(sb);
>>   		ext4_clear_feature_orphan_present(sb);
>>   		es->s_state = cpu_to_le16(sbi->s_mount_state);
>>   	}
>> -	if (!sb_rdonly(sb))
>> +	if (!ext4_sb_rdonly(sb))
>>   		ext4_commit_super(sb);
>>   
>>   	ext4_group_desc_free(sbi);
>> @@ -3693,7 +3693,8 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
>>   		if (group >= elr->lr_next_group) {
>>   			ret = 1;
>>   			if (elr->lr_first_not_zeroed != ngroups &&
>> -			    !sb_rdonly(sb) && test_opt(sb, INIT_INODE_TABLE)) {
>> +			    !ext4_sb_rdonly(sb) &&
>> +			    test_opt(sb, INIT_INODE_TABLE)) {
>>   				elr->lr_next_group = elr->lr_first_not_zeroed;
>>   				elr->lr_mode = EXT4_LI_MODE_ITABLE;
>>   				ret = 0;
>> @@ -3998,7 +3999,7 @@ int ext4_register_li_request(struct super_block *sb,
>>   		goto out;
>>   	}
>>   
>> -	if (sb_rdonly(sb) ||
>> +	if (ext4_sb_rdonly(sb) ||
>>   	    (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
>>   	     (first_not_zeroed == ngroups || !test_opt(sb, INIT_INODE_TABLE))))
>>   		goto out;
>
> 								Honza



