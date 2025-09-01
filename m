Return-Path: <linux-ext4+bounces-9769-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC824B3DA92
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Sep 2025 09:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908FA1772C7
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Sep 2025 07:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4E120FAAB;
	Mon,  1 Sep 2025 07:02:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E9C45029
	for <linux-ext4@vger.kernel.org>; Mon,  1 Sep 2025 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710123; cv=none; b=Fb7pKpwtOfaXyZkcIf6Z8doeOeP+njTBFER1t7tNo+HwudZNN2sG2H7oyaZfegUoXGtNnO9bXJ0nf94NsiTmbFOY5IX1i1a5kbvx+Sai8fkhdByqa3F1KSV60B0j+YHHeI/Foo3IfPGqn1DrBZTSb4E3RMFhSD51Fd7m6Ze7Md8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710123; c=relaxed/simple;
	bh=YkWkoYmemSoXe4NB9e8ozgU16d8GqwNU+/+3zHYCUoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=dfV+Cb+C5DfY2yYZrSf2XiTbqnI4vv/e8byBVTerOqxVu35gSaKp3yrYb0zQ3FKXhlTg5tQXFnS61e3deXZtVF9V1lTyzRWg4J4/5dwkZW3wTgZQp8yHJgTy3VyrYOjgAL8ofS9/80+5Zw07sBd19Ua3LRU1Ql3VQWe3AWLhx6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cFfpS6xyhz13NGk;
	Mon,  1 Sep 2025 14:58:08 +0800 (CST)
Received: from kwepemo500015.china.huawei.com (unknown [7.202.194.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 9055218048B;
	Mon,  1 Sep 2025 15:01:57 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 kwepemo500015.china.huawei.com (7.202.194.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 15:01:56 +0800
Message-ID: <f78e3cf5-41b1-4b84-bb25-dc0de03fd30f@huawei.com>
Date: Mon, 1 Sep 2025 15:01:45 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ext4: add an update to i_disksize in
 ext4_block_page_mkwrite
To: <linux-ext4@vger.kernel.org>
References: <20250731140528.1554917-1-sunyongjian@huaweicloud.com>
From: Sun Yongjian <sunyongjian1@huawei.com>
CC: <yangerkun@huawei.com>, <yi.zhang@huawei.com>, <libaokun1@huawei.com>,
	<tytso@mit.edu>, <jack@suse.cz>
In-Reply-To: <20250731140528.1554917-1-sunyongjian@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500015.china.huawei.com (7.202.194.227)



在 2025/7/31 22:05, sunyongjian@huaweicloud.com 写道:
Gentle ping.
> From: Yongjian Sun <sunyongjian1@huawei.com>
> 
> After running a stress test combined with fault injection,
> we performed fsck -a followed by fsck -fn on the filesystem
> image. During the second pass, fsck -fn reported:
> 
> Inode 131512, end of extent exceeds allowed value
> 	(logical block 405, physical block 1180540, len 2)
> 
> This inode was not in the orphan list. Analysis revealed the
> following call chain that leads to the inconsistency:
> 
>                               ext4_da_write_end()
>                                //does not update i_disksize
>                               ext4_punch_hole()
>                                //truncate folio, keep size
> ext4_page_mkwrite()
>   ext4_block_page_mkwrite()
>    ext4_block_write_begin()
>      ext4_get_block()
>       //insert written extent without update i_disksize
> journal commit
> echo 1 > /sys/block/xxx/device/delete
> 
> da-write path updates i_size but does not update i_disksize. Then
> ext4_punch_hole truncates the da-folio yet still leaves i_disksize
> unchanged. Then ext4_page_mkwrite sees ext4_nonda_switch return 1
> and takes the nodioread_nolock path, the folio about to be written
> has just been punched out, and it’s offset sits beyond the current
> i_disksize. This may result in a written extent being inserted, but
> again does not update i_disksize. If the journal gets committed and
> then the block device is yanked, we might run into this.
> 
> To fix this, we now check in ext4_block_page_mkwrite whether
> i_disksize needs to be updated to cover the newly allocated blocks.
> 
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
> ---
>   fs/ext4/inode.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ed54c4d0f2f9..050270b265ae 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6666,8 +6666,18 @@ static int ext4_block_page_mkwrite(struct inode *inode, struct folio *folio,
>   		goto out_error;
>   
>   	if (!ext4_should_journal_data(inode)) {
> +		loff_t disksize = folio_pos(folio) + len;
>   		block_commit_write(folio, 0, len);
>   		folio_mark_dirty(folio);
> +		if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
> +			down_write(&EXT4_I(inode)->i_data_sem);
> +			if (disksize > EXT4_I(inode)->i_disksize)
> +				EXT4_I(inode)->i_disksize = disksize;
> +			up_write(&EXT4_I(inode)->i_data_sem);
> +			ret = ext4_mark_inode_dirty(handle, inode);
> +			if (ret)
> +				goto out_error;
> +		}
>   	} else {
>   		ret = ext4_journal_folio_buffers(handle, folio, len);
>   		if (ret)


