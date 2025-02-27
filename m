Return-Path: <linux-ext4+bounces-6581-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1512FA47E3D
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Feb 2025 13:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E357A2164
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Feb 2025 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420C822D4F1;
	Thu, 27 Feb 2025 12:51:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499A270043;
	Thu, 27 Feb 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660682; cv=none; b=DwcExn755y/UGxmHFeKvjUGwM2e53uY+HYrBsUhTL+hpVw29UChywTG99R22M3odFM8R1rnZDG9dHWP7EEXabpZv5smxg/B0hDcRb+RYpyiXoW75jC3pFi9bXDGDWLgWx8ImcTquaDYhA0AvScooBVjXyKG+Z8jpd0FItIL5QuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660682; c=relaxed/simple;
	bh=dohw6I9c9axCsPo6XeeMuurb5GYqh6loB8vFn7nVLwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FJKA5zEV6phkfyUtgO+kLMMv/k56slnu8NRPxZk/oJuwIsrqtc8/KteCNryjyBha1e5nYBiOuNXIhIe37HIUk1U9uMi25BEXs69SA/bRkW9wy+cL19+KQMCOyBUxe9NTDrLDyM3ri5/PlJxUSflgWOQpI3czLILzMcMyPrWuNcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z3WM00Wxzz1ltZh;
	Thu, 27 Feb 2025 20:47:08 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id F2DD61402DE;
	Thu, 27 Feb 2025 20:51:12 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 27 Feb
 2025 20:51:12 +0800
Message-ID: <84ebed94-d4ab-4b8c-962c-f10ebaca5a75@huawei.com>
Date: Thu, 27 Feb 2025 20:51:11 +0800
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
 <1a1ff87b-6f75-4d43-ad7b-54883bea13f8@huawei.com>
 <Z8BP4luSfyvz-V4T@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Z8BP4luSfyvz-V4T@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/2/27 19:43, Ojaswin Mujoo wrote:
> On Wed, Feb 26, 2025 at 09:55:52AM +0800, Baokun Li wrote:
>> On 2025/2/25 20:06, Ojaswin Mujoo wrote:
>>> On Tue, Feb 25, 2025 at 09:53:10AM +0800, Baokun Li wrote:
>>>> On 2025/2/22 16:40, Ojaswin Mujoo wrote:
>>>>> Presently we always BUG_ON if trying to start a transaction on a journal
>>>>> marked with JBD2_UNMOUNT, since this should never happen. However while
>>>>> running stress tests it was observed that in case of some error handling
>>>>> paths, it is possible for update_super_work to start a transaction after
>>>>> the journal is destroyed eg:
>>>>>
>>>>> (umount)
>>>>> ext4_kill_sb
>>>>>      kill_block_super
>>>>>        generic_shutdown_super
>>>>>          sync_filesystem /* commits all txns */
>>>>>          evict_inodes
>>>>>            /* might start a new txn */
>>>>>          ext4_put_super
>>>>> 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>>>>>            jbd2_journal_destroy
>>>>>              journal_kill_thread
>>>>>                journal->j_flags |= JBD2_UNMOUNT;
>>>>>              jbd2_journal_commit_transaction
>>>>>                jbd2_journal_get_descriptor_buffer
>>>>>                  jbd2_journal_bmap
>>>>>                    ext4_journal_bmap
>>>>>                      ext4_map_blocks
>>>>>                        ...
>>>>>                        ext4_inode_error
>>>> Just curious, since jbd2_journal_bmap() only queries the map and does not
>>>> create it, how does it fail here? Is there more information in dmesg?
>>>> Is s_journal_inum normal after file system corruption?
>>> Hey Baokun,
>> Hello Ojaswin,
>>
>> Thanks for your detailed explanation!
>>> So I dug a bit more into the vmcore. The error information in sbi looks
>>> like this:
>>>
>>>     s_add_error_count = 1,
>>>     s_first_error_code = 117,
>>>     s_first_error_line = 475,
>>>     s_first_error_ino = 0,
>>>     s_first_error_block = 0,
>>>     s_first_error_func = 0xc0080000055300d0 <__func__.6> "ext4_read_block_bitmap_nowait",
>>>     s_first_error_time = 1737023235,
>>>
>>>     s_last_error_code = 117,
>>>     s_last_error_line = 609,
>>>     s_last_error_ino = 8,
>>>     s_last_error_block = 783,
>>>     s_last_error_func = 0xc008000005531b10 <__func__.41> "ext4_map_blocks",
>>>     s_last_error_time = 1737023236,
>>>
>>>     The first error is here:
>>>
>>>         if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
>>>        474               (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
>>>     *  475                   ext4_error(sb, "Invalid block bitmap block %llu in "
>>>        476                              "block_group %u", bitmap_blk, block_group);
>>>        477                   ext4_mark_group_bitmap_corrupted(sb, block_group,
>>>        478                                           EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>>        479                   return ERR_PTR(-EFSCORRUPTED);
>>>        480           }
>>>
>>> and the last error is here:
>>>
>>>       608           if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
>>>    *  609                   ret = check_block_validity(inode, map);
>>>       610                   if (ret != 0)
>>>       611                           return ret;
>>>       612           }
>>>
>>>
>>> And indeed we have the traces of the first error in dmesg:
>>>
>>> [75284.713463] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
>>> [75284.713470] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
>>> [75284.713476] EXT4-fs error (device loop36): ext4_read_block_bitmap_nowait:475: comm proc01: Invalid block bitmap block 0 in block_group 0
>>>
>>> However, the last error seems strange. It seems like check_block_validity
>>> should ideally never fail for a journal inode.Unfortunately, sbi->s_es page is
>>> not recorded in the crash dump for some reason so idk the exact value at the
>>> time of the check, but looking in journal->j_inode->i_ino, the inode num is 8,
>>> which seems fine to me. So yeah, I'm a bit unsure what caused the corruption.
>>> I'll look a bit more into the proc01 ltp to see if we can recreate the failure
>>> to get more info.
>> Right, check_block_validity() skips the journal inode check. If
>> the journal inode check fails, that shows s_es->s_journal_inum and
>> journal->j_inode->i_ino are different. The file system doesn't modify
>> s_journal_inum, so it should be modified by some other writer bypassing
>> the file system (i.e. writing to bare disk).
>>
>> If that's how it is, we could avoid this issue by using EXT4_JOURNAL_INO
>> directly or saving s_journal_inum to ext4_sb_info (which offers better
>> compatibility).
> Hey Baokun,
>
> So I'm wondering if modifying the check in __check_block_validity the
> right thing to do. The fact that something has changed the on disk
> journal inode number is itself concerning and maybe stopping IO here is
> the right thing to do instead of using a cached journal inode number and
> silently ignoring the issue.
Because the cached journal inode is fine (it was checked when mounting),
and the data we're committing is good too, I think it's okay to keep
committing.  The actual problem is someone modified the superblock
directly, bypassing the file system, and the file system can't protect
against that.
>
> Anyways now that the journal inode is corrupted on disk, will the
> recovery tooling even be able to read the journal anymore?
Actually, the journal inode on disk could still be okay. This just tells us
s_es->s_journal_inum is abnormal, meaning part of the superblock on disk
got changed. If only the superblock was modified, we can use the backup
superblock or grab the latest superblock copy from the journal.


Cheers,
Baokun

