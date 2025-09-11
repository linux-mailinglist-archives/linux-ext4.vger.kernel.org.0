Return-Path: <linux-ext4+bounces-9918-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D77B52C28
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA50A00779
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632372E5B1F;
	Thu, 11 Sep 2025 08:47:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50BD293B73
	for <linux-ext4@vger.kernel.org>; Thu, 11 Sep 2025 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580427; cv=none; b=dIl2FjTvSQOmxYZAkSCWlFY8x8+s1m5uctVmgMj9N/bL8QsHZLf86dpOIwVp6d0uFiSn+ME1H+J+Spz14Sxxoy7d6UKtu3zRGTxAcqy7T3/McvmGdWsjPooEdkGteVgqf0fp7xTg1z/d1NXCoIruiaez/xcUYztFT9lwZvqYsWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580427; c=relaxed/simple;
	bh=OE2CHddBB2ZqBwAVFBTGF1cv14SUlRmddpn63oDgQMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H1DNznMhRlQBoSimUnjpYQyq+CZUKQmZpcxW2o8dIGGf4ORa+lc436twJi1E5ll5LAnjTcpiCc83q6zJdZYgAv0GEeRCQmpRUA3kAHNcwnD4u2H7xYq67hF57iEz2Cv0oCSpTmYY7VFMD7bNn+Fz3seN/Fvu67ERt/docpYh1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cMrGl5RdRzdcDK;
	Thu, 11 Sep 2025 16:25:35 +0800 (CST)
Received: from kwepemo500015.china.huawei.com (unknown [7.202.194.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A76818007F;
	Thu, 11 Sep 2025 16:30:08 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 kwepemo500015.china.huawei.com (7.202.194.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 16:30:07 +0800
Message-ID: <3f6bb822-2eff-4a8b-9d6c-dbb151510804@huawei.com>
Date: Thu, 11 Sep 2025 16:29:56 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ext4: increase i_disksize to offset + len in
 ext4_update_disksize_before_punch()
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>, <chengzhihao1@huawei.com>
References: <20250911025412.186872-1-sunyongjian@huaweicloud.com>
 <8d1ee18e-6bf4-423b-b046-16a5d55a7030@huaweicloud.com>
From: Sun Yongjian <sunyongjian1@huawei.com>
In-Reply-To: <8d1ee18e-6bf4-423b-b046-16a5d55a7030@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500015.china.huawei.com (7.202.194.227)



在 2025/9/11 14:16, Zhang Yi 写道:
> On 9/11/2025 10:54 AM, Yongjian Sun wrote:
>> From: Yongjian Sun <sunyongjian1@huawei.com>
>>
>> After running a stress test combined with fault injection,
>> we performed fsck -a followed by fsck -fn on the filesystem
>> image. During the second pass, fsck -fn reported:
>>
>> Inode 131512, end of extent exceeds allowed value
>> 	(logical block 405, physical block 1180540, len 2)
>>
>> This inode was not in the orphan list. Analysis revealed the
>> following call chain that leads to the inconsistency:
>>
>>                               ext4_da_write_end()
>>                                //does not update i_disksize
>>                               ext4_punch_hole()
>>                                //truncate folio, keep size
>> ext4_page_mkwrite()
>>   ext4_block_page_mkwrite()
>>    ext4_block_write_begin()
>>      ext4_get_block()
>>       //insert written extent without update i_disksize
>> journal commit
>> echo 1 > /sys/block/xxx/device/delete
>>
>> da-write path updates i_size but does not update i_disksize. Then
>> ext4_punch_hole truncates the da-folio yet still leaves i_disksize
>> unchanged(in the ext4_update_disksize_before_punch function, the
>> condition offset + len < size is met). Then ext4_page_mkwrite sees
>> ext4_nonda_switch return 1 and takes the nodioread_nolock path, the
>> folio about to be written has just been punched out, and it’s offset
>> sits beyond the current i_disksize. This may result in a written
>> extent being inserted, but again does not update i_disksize. If the
>> journal gets committed and then the block device is yanked, we might
>> run into this. It should be noted that replacing ext4_punch_hole with
>> ext4_zero_range in the call sequence may also trigger this issue, as
>> neither will update i_disksize under these circumstances.
>>
>> To fix this, we can modify ext4_update_disksize_before_punch to
>> increase i_disksize to min(offset + len) when both i_size and
>> (offset + len) are greater than i_disksize.
>>
>> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
> 
> Looks good to me, and feel free to add:
> 
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> 
> BTW, since Jan has no other review comments and has allowed you to
> add his review tag after improving the language, you can also add his
> review tag when sending this version.
> 
> Thanks,
> Yi.
> 
Get it. Thanks for your patience

>> ---
>> Changes in v4:
>> - Make the comments simpler and clearer.
>> - Link to v3: https://lore.kernel.org/all/20250910042516.3947590-1-sunyongjian@huaweicloud.com/
>> Changes in v3:
>> - Add a condition to avoid increasing i_disksize and include some comments.
>> - Link to v2: https://lore.kernel.org/all/20250908063355.3149491-1-sunyongjian@huaweicloud.com/
>> Changes in v2:
>> - The modification of i_disksize should be moved into ext4_update_disksize_before_punch,
>>    rather than being done in ext4_page_mkwrite.
>> - Link to v1: https://lore.kernel.org/all/20250731140528.1554917-1-sunyongjian@huaweicloud.com/
>> ---
>>   fs/ext4/inode.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 5b7a15db4953..f82f7fb84e17 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4287,7 +4287,11 @@ int ext4_can_truncate(struct inode *inode)
>>    * We have to make sure i_disksize gets properly updated before we truncate
>>    * page cache due to hole punching or zero range. Otherwise i_disksize update
>>    * can get lost as it may have been postponed to submission of writeback but
>> - * that will never happen after we truncate page cache.
>> + * that will never happen if we remove the folio containing i_size from the
>> + * page cache. Also if we punch hole within i_size but above i_disksize,
>> + * following ext4_page_mkwrite() may mistakenly allocate written blocks over
>> + * the hole and thus introduce allocated blocks beyond i_disksize which is
>> + * not allowed (e2fsck would complain in case of crash).
>>    */
>>   int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>>   				      loff_t len)
>> @@ -4298,9 +4302,11 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>>   	loff_t size = i_size_read(inode);
>>   
>>   	WARN_ON(!inode_is_locked(inode));
>> -	if (offset > size || offset + len < size)
>> +	if (offset > size)
>>   		return 0;
>>   
>> +	if (offset + len < size)
>> +		size = offset + len;
>>   	if (EXT4_I(inode)->i_disksize >= size)
>>   		return 0;
>>   
> 


