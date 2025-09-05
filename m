Return-Path: <linux-ext4+bounces-9818-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376AEB44C41
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 05:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2417B7A6F9B
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 03:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E972641E3;
	Fri,  5 Sep 2025 03:26:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C422FE0F
	for <linux-ext4@vger.kernel.org>; Fri,  5 Sep 2025 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757042768; cv=none; b=cyhz3wYstZ3MYmJAkT381rmyJ2PxWL7Is4SN9S2WUtZCJZkPVFKNcGuAQEzPoCbIv7WCeb5wPJK4DBex8L4SDGuZWGcLeZKMNboiYI+eSyFPg6RN6Y92xvxdaNLyOrJ45DZH/WPyOA9wrzsvzGrBsV7o3J9KI1mFFWx2Ze9bP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757042768; c=relaxed/simple;
	bh=oSBs2s1h2KMY35oflQOnDHuTg7rjkleclKCCin3q+7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kbGosG7GCyrXS1kmYuShvxo89lhjWgr27MTBHyNIBCbLETEKYbsRAD5Tkyfw0xPvwB4gnsHVgt3qilp/eqmrjEmwsorE6Op3K0e4Rh9JBinJ9znDzV4d4N/H+bCGrwYPmvA38s3FNPUU1+2UY8FssLTMYj1/k+WcvmzKIY1IuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cJ1pg6JYrzPtMt;
	Fri,  5 Sep 2025 11:21:31 +0800 (CST)
Received: from kwepemo500015.china.huawei.com (unknown [7.202.194.227])
	by mail.maildlp.com (Postfix) with ESMTPS id EC55B18007F;
	Fri,  5 Sep 2025 11:26:01 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 kwepemo500015.china.huawei.com (7.202.194.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 11:26:01 +0800
Message-ID: <634dec5f-af5f-41c6-b0cf-0da740625240@huawei.com>
Date: Fri, 5 Sep 2025 11:25:49 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ext4: add an update to i_disksize in
 ext4_block_page_mkwrite
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
	<yi.zhang@huawei.com>, <libaokun1@huawei.com>, <tytso@mit.edu>
References: <20250731140528.1554917-1-sunyongjian@huaweicloud.com>
 <f78e3cf5-41b1-4b84-bb25-dc0de03fd30f@huawei.com>
 <uxqef2v6p6mjmkm7t3vjbqf7bpr7fcgz5ryktu27hds3cdoruv@wm7giw7hi3kx>
From: Sun Yongjian <sunyongjian1@huawei.com>
In-Reply-To: <uxqef2v6p6mjmkm7t3vjbqf7bpr7fcgz5ryktu27hds3cdoruv@wm7giw7hi3kx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500015.china.huawei.com (7.202.194.227)



在 2025/9/4 17:11, Jan Kara 写道:
> On Mon 01-09-25 15:01:45, Sun Yongjian wrote:
>> 在 2025/7/31 22:05, sunyongjian@huaweicloud.com 写道:
>> Gentle ping.
>>> From: Yongjian Sun <sunyongjian1@huawei.com>
>>>
>>> After running a stress test combined with fault injection,
>>> we performed fsck -a followed by fsck -fn on the filesystem
>>> image. During the second pass, fsck -fn reported:
>>>
>>> Inode 131512, end of extent exceeds allowed value
>>> 	(logical block 405, physical block 1180540, len 2)
>>>
>>> This inode was not in the orphan list. Analysis revealed the
>>> following call chain that leads to the inconsistency:
>>>
>>>                                ext4_da_write_end()
>>>                                 //does not update i_disksize
>>>                                ext4_punch_hole()
>>>                                 //truncate folio, keep size
>>> ext4_page_mkwrite()
>>>    ext4_block_page_mkwrite()
>>>     ext4_block_write_begin()
>>>       ext4_get_block()
>>>        //insert written extent without update i_disksize
>>> journal commit
>>> echo 1 > /sys/block/xxx/device/delete
>>>
>>> da-write path updates i_size but does not update i_disksize. Then
>>> ext4_punch_hole truncates the da-folio yet still leaves i_disksize
>>> unchanged. Then ext4_page_mkwrite sees ext4_nonda_switch return 1
>>> and takes the nodioread_nolock path, the folio about to be written
>>> has just been punched out, and it’s offset sits beyond the current
>>> i_disksize. This may result in a written extent being inserted, but
>>> again does not update i_disksize. If the journal gets committed and
>>> then the block device is yanked, we might run into this.
>>>
>>> To fix this, we now check in ext4_block_page_mkwrite whether
>>> i_disksize needs to be updated to cover the newly allocated blocks.
>>>
>>> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
> 
> OK, after the discussion with Ritesh your solution looks like the best one.
> Just two nits below:
> 
>>> ---
>>>    fs/ext4/inode.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>> index ed54c4d0f2f9..050270b265ae 100644
>>> --- a/fs/ext4/inode.c
>>> +++ b/fs/ext4/inode.c
>>> @@ -6666,8 +6666,18 @@ static int ext4_block_page_mkwrite(struct inode *inode, struct folio *folio,
>>>    		goto out_error;
>>>    	if (!ext4_should_journal_data(inode)) {
>>> +		loff_t disksize = folio_pos(folio) + len;
> 
> Use an empty line between declarations and the code please.
> 
>>>    		block_commit_write(folio, 0, len);
>>>    		folio_mark_dirty(folio);
>>> +		if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
>>> +			down_write(&EXT4_I(inode)->i_data_sem);
>>> +			if (disksize > EXT4_I(inode)->i_disksize)
>>> +				EXT4_I(inode)->i_disksize = disksize;
>>> +			up_write(&EXT4_I(inode)->i_data_sem);
>>> +			ret = ext4_mark_inode_dirty(handle, inode);
>>> +			if (ret)
>>> +				goto out_error;
>>> +		}
> 
> Since we don't support delalloc with data journalling, your code is correct
> but I think it would be more understandable if you just moved the
> i_disksize update outside of the "if (!ext4_should_journal_data(inode))"
> condition.
> 
>>>    	} else {
>>>    		ret = ext4_journal_folio_buffers(handle, folio, len);
>>>    		if (ret)
>>
> 
> 								Honza
Thanks for the review, I will send a patch to improve this!

