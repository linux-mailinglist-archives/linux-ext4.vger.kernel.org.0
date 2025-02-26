Return-Path: <linux-ext4+bounces-6575-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEF6A45278
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2025 02:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF733A531F
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2025 01:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4819D06B;
	Wed, 26 Feb 2025 01:56:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B6EBE;
	Wed, 26 Feb 2025 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534960; cv=none; b=G+mzjPf1fgThwkVoiH+Z+Q+hd+/6W75y8Jk+4TGKFXxaXAVj6pPYOwcefoSQFW3ZigGDlkIbNJqM2YJf0aOb/Yorjpzrs+wQ3/4OUxpyf8sHCdrKDdpvwRM+C513NmOxBnvTaCmWA1v2D5qtQD46rCGEJo0tXbYBLRBKWNNVTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534960; c=relaxed/simple;
	bh=X2A7UwowDWu/Qmzix8RvMOFH9CCjbmuFESHKLu4VyVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f2YBhEayxjY3QFbCZ4YD8RDmdi+NMCKXEMlWS2PM2V6XFcacdkJ0HiOV+1/x6N93ltL9jo9iv241BHsMPc1FDmypJUNXSpeHaW9AXlId4CJxg3sTkIEDm9Qu588I0fPdmCm/O2WYRLLJd6kUaGgfNWfBmbXPzmp4YcPN8iLjm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z2crY2Zctzdb7f;
	Wed, 26 Feb 2025 09:51:09 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 43C22140795;
	Wed, 26 Feb 2025 09:55:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Feb
 2025 09:55:53 +0800
Message-ID: <1a1ff87b-6f75-4d43-ad7b-54883bea13f8@huawei.com>
Date: Wed, 26 Feb 2025 09:55:52 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Mahesh Kumar
	<maheshkumar657g@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>, Yang
 Erkun <yangerkun@huawei.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
 <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
 <3f9a67e2-ef08-47d4-b35e-41841e24bb71@huawei.com>
 <Z72yUqGWHdRyCE25@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Z72yUqGWHdRyCE25@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/2/25 20:06, Ojaswin Mujoo wrote:
> On Tue, Feb 25, 2025 at 09:53:10AM +0800, Baokun Li wrote:
>> On 2025/2/22 16:40, Ojaswin Mujoo wrote:
>>> Presently we always BUG_ON if trying to start a transaction on a journal
>>> marked with JBD2_UNMOUNT, since this should never happen. However while
>>> running stress tests it was observed that in case of some error handling
>>> paths, it is possible for update_super_work to start a transaction after
>>> the journal is destroyed eg:
>>>
>>> (umount)
>>> ext4_kill_sb
>>>     kill_block_super
>>>       generic_shutdown_super
>>>         sync_filesystem /* commits all txns */
>>>         evict_inodes
>>>           /* might start a new txn */
>>>         ext4_put_super
>>> 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>>>           jbd2_journal_destroy
>>>             journal_kill_thread
>>>               journal->j_flags |= JBD2_UNMOUNT;
>>>             jbd2_journal_commit_transaction
>>>               jbd2_journal_get_descriptor_buffer
>>>                 jbd2_journal_bmap
>>>                   ext4_journal_bmap
>>>                     ext4_map_blocks
>>>                       ...
>>>                       ext4_inode_error
>> Just curious, since jbd2_journal_bmap() only queries the map and does not
>> create it, how does it fail here? Is there more information in dmesg?
>> Is s_journal_inum normal after file system corruption?
> Hey Baokun,
Hello Ojaswin,

Thanks for your detailed explanation!
>
> So I dug a bit more into the vmcore. The error information in sbi looks
> like this:
>
>    s_add_error_count = 1,
>    s_first_error_code = 117,
>    s_first_error_line = 475,
>    s_first_error_ino = 0,
>    s_first_error_block = 0,
>    s_first_error_func = 0xc0080000055300d0 <__func__.6> "ext4_read_block_bitmap_nowait",
>    s_first_error_time = 1737023235,
>
>    s_last_error_code = 117,
>    s_last_error_line = 609,
>    s_last_error_ino = 8,
>    s_last_error_block = 783,
>    s_last_error_func = 0xc008000005531b10 <__func__.41> "ext4_map_blocks",
>    s_last_error_time = 1737023236,
>
>    The first error is here:
>
>        if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
>       474               (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
>    *  475                   ext4_error(sb, "Invalid block bitmap block %llu in "
>       476                              "block_group %u", bitmap_blk, block_group);
>       477                   ext4_mark_group_bitmap_corrupted(sb, block_group,
>       478                                           EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>       479                   return ERR_PTR(-EFSCORRUPTED);
>       480           }
>
> and the last error is here:
>
>      608           if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
>   *  609                   ret = check_block_validity(inode, map);
>      610                   if (ret != 0)
>      611                           return ret;
>      612           }
>
>
> And indeed we have the traces of the first error in dmesg:
>
> [75284.713463] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
> [75284.713470] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
> [75284.713476] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
>
> However, the last error seems strange. It seems like check_block_validity
> should ideally never fail for a journal inode.Unfortunately, sbi->s_es page is
> not recorded in the crash dump for some reason so idk the exact value at the
> time of the check, but looking in journal->j_inode->i_ino, the inode num is 8,
> which seems fine to me. So yeah, I'm a bit unsure what caused the corruption.
> I'll look a bit more into the proc01 ltp to see if we can recreate the failure
> to get more info.
Right, check_block_validity() skips the journal inode check. If
the journal inode check fails, that shows s_es->s_journal_inum and
journal->j_inode->i_ino are different. The file system doesn't modify
s_journal_inum, so it should be modified by some other writer bypassing
the file system (i.e. writing to bare disk).

If that's how it is, we could avoid this issue by using EXT4_JOURNAL_INO
directly or saving s_journal_inum to ext4_sb_info (which offers better
compatibility).


Cheers,
Baokun
>> Thanks,
>> Baokun
>>>                         ext4_handle_error
>>>                           schedule_work(&sbi->s_sb_upd_work)
>>>
>>>                                                  /* work queue kicks in */
>>>                                                  update_super_work
>>>                                                    jbd2_journal_start
>>>                                                      start_this_handle
>>>                                                        BUG_ON(journal->j_flags &
>>>                                                               JBD2_UNMOUNT)
>>>
>>> Hence, make sure we only defer the update of ext4 sb if the sb is still
>>> active.  Otherwise, just fallback to an un-journaled commit.
>>>
>>> The important thing to note here is that we must only defer sb update if
>>> we have not yet flushed the s_sb_update_work queue in umount path else
>>> this race can be hit (point 1 below). Since we don't have a direct way
>>> to check for that we use SB_ACTIVE instead. The SB_ACTIVE check is a bit
>>> subtle so adding some notes below for future reference:
>>>
>>> 1. Ideally we would want to have a something like (flags & JBD2_UNMOUNT
>>> == 0) however this is not correct since we could end up scheduling work
>>> after it has been flushed:
>>>
>>>    ext4_put_super
>>>     flush_work(&sbi->s_sb_upd_work)
>>>
>>>                              **kjournald2**
>>>                              jbd2_journal_commit_transaction
>>>                              ...
>>>                              ext4_inode_error
>>>                                /* JBD2_UNMOUNT not set */
>>>                                schedule_work(s_sb_upd_work)
>>>
>>>      jbd2_journal_destroy
>>>       journal->j_flags |= JBD2_UNMOUNT;
>>>
>>>                                         **workqueue**
>>>                                         update_super_work
>>>                                          jbd2_journal_start
>>>                                           start_this_handle
>>>                                             BUG_ON(JBD2_UNMOUNT)
>>>
>>> Something like the above doesn't happen with SB_ACTIVE check because we
>>> are sure that the workqueue would be flushed at a later point if we are
>>> in the umount path.
>>>
>>> 2. We don't need a similar check in ext4_grp_locked_error since it is
>>> only called from mballoc and AFAICT it would be always valid to schedule
>>> work here.
>>>
>>> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
>>> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
>>> Suggested-by: Ritesh Harjani <ritesh.list@gmail.com>
>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>> ---
>>>    fs/ext4/super.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>> index a963ffda692a..b7341e9acf62 100644
>>> --- a/fs/ext4/super.c
>>> +++ b/fs/ext4/super.c
>>> @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>>>    		 * constraints, it may not be safe to do it right here so we
>>>    		 * defer superblock flushing to a workqueue.
>>>    		 */
>>> -		if (continue_fs && journal)
>>> +		if (continue_fs && journal && (sb->s_flags & SB_ACTIVE))
>>>    			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
>>>    		else
>>>    			ext4_commit_super(sb);
>>


