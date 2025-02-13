Return-Path: <linux-ext4+bounces-6433-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2402BA3402A
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 14:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED967A4871
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD4E227E88;
	Thu, 13 Feb 2025 13:20:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7923F420;
	Thu, 13 Feb 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452828; cv=none; b=okA5Xkdw2TtI6/S6rzhu7OS3DBICIE4IJ88BAYgjRcMjZnXuBrSDAibfz8ryGmzfG1ihk2VQnohFSq5QSxCWCd3IGmLUrCSYg5LscRs16SjSOuexXTNX31V5RrluPt4ClsSHpeCgjhabdAba7wKIQKQqFfgha6lHodO1AoBRl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452828; c=relaxed/simple;
	bh=H4AxgIP+F4D1aXH5JdycCNiUL/xrl0gdsuXIYL8S7xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ltR06aG7UODaCqU9ualBNiuOvg/y/8eFxYXDWBaJBNGS8jWyIQvduZv1BL3sR6Z8FgLGWT9XBzxvTcuHOxcZtdMzSKRrOrfHNTZKZQA6PjSObuL/4D/Nc3HwWb12yskkGs9ulWLN65RSOZo5izduMz0Ze5dQumFplOiTlp/4+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YtwgR33K4z2FdXs;
	Thu, 13 Feb 2025 21:16:35 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id AEB6B1400D2;
	Thu, 13 Feb 2025 21:20:22 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Feb
 2025 21:20:21 +0800
Message-ID: <5e39cc34-99e8-451e-8f61-4f0187a8db6a@huawei.com>
Date: Thu, 13 Feb 2025 21:20:21 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: goto right label 'out_mmap_sem' in ext4_setattr()
To: Brian Foster <bfoster@redhat.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>, Baokun Li
	<libaokun@huaweicloud.com>
References: <20250213112247.3168709-1-libaokun@huaweicloud.com>
 <Z63qzaDONxM9fRVl@bfoster>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Z63qzaDONxM9fRVl@bfoster>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

Hi,

On 2025/2/13 20:51, Brian Foster wrote:
> On Thu, Feb 13, 2025 at 07:22:47PM +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Otherwise, if ext4_inode_attach_jinode() fails, a hung task will
>> happen because filemap_invalidate_unlock() isn't called to unlock
>> mapping->invalidate_lock. Like this:
>>
>> EXT4-fs error (device sda) in ext4_setattr:5557: Out of memory
>> INFO: task fsstress:374 blocked for more than 122 seconds.
>>        Not tainted 6.14.0-rc1-next-20250206-xfstests-dirty #726
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:fsstress state:D stack:0     pid:374   tgid:374   ppid:373
>>                                    task_flags:0x440140 flags:0x00000000
>> Call Trace:
>>   <TASK>
>>   __schedule+0x2c9/0x7f0
>>   schedule+0x27/0xa0
>>   schedule_preempt_disabled+0x15/0x30
>>   rwsem_down_read_slowpath+0x278/0x4c0
>>   down_read+0x59/0xb0
>>   page_cache_ra_unbounded+0x65/0x1b0
>>   filemap_get_pages+0x124/0x3e0
>>   filemap_read+0x114/0x3d0
>>   vfs_read+0x297/0x360
>>   ksys_read+0x6c/0xe0
>>   do_syscall_64+0x4b/0x110
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Fixes: c7fc0366c656 ("ext4: partial zero eof block on unaligned inode size extension")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
> First off, thank you for catching this. :)
Thanks for your review!
>
>>   fs/ext4/inode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 3cc8da6357aa..04ffd802dbde 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -5452,7 +5452,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>   			    oldsize & (inode->i_sb->s_blocksize - 1)) {
>>   				error = ext4_inode_attach_jinode(inode);
>>   				if (error)
>> -					goto err_out;
>> +					goto out_mmap_sem;
>>   			}
> This looks reasonable to me, but I notice that the immediate previous
> error check looks like this:
>
> 		...
>                  rc = ext4_break_layouts(inode);
>                  if (rc) {
>                          filemap_invalidate_unlock(inode->i_mapping);
>                          goto err_out;
>                  }
> 		...
>
> ... and then the following after the broken logic uses out_mmap_sem.
> Could we be a little more consistent here one way or the other? The
> change looks functionally correct to me either way:
>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
>
> Brian
Indeed, this is confusing.

The reason is that we don't want to call ext4_std_error() when
ext4_break_layouts() fails. So we first store the error in 'rc', and then
pass the error to 'error' at the end. (See b9c1c26739ec
("ext4: gracefully handle ext4_break_layouts() failure during truncate"))

However, because 'error' is not assigned, the goto out_mmap_sem label will
execute some code that shouldn't be executed. Therefore, in the error
handling of ext4_break_layouts(), we unlock and then goto err_out label.

While under normal error conditions, 'error' is assigned, and it should
enter the out_mmap_sem label. Therefore, in the error handling of
ext4_inode_attach_jinode(), we directly goto out_mmap_sem label.

The handling of 'rc' in this function is indeed very subtle.


Cheers,
Baokun
>>   
>>   			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
>> -- 
>> 2.39.2
>>
>>


