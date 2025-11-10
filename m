Return-Path: <linux-ext4+bounces-11718-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63180C46654
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 12:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EEA11883B94
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74607309EFF;
	Mon, 10 Nov 2025 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RzfKYxSW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247432EB87F;
	Mon, 10 Nov 2025 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775631; cv=none; b=RtH79nI8vFYZAw/SFq7GTrIxgzcemsDaq3lz7bRhgjDHeLoLafAYk03xcIWfTLJRwxaiBeQrOEZ4PBnSvgJL+cepgOoPkaflp2BEdRAzscFOpkfq4bslJp9pvFMoU1WMS6Nl1WPesq85R8uhUvCiWRvP4aaPWQ9nYeC7RqIvnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775631; c=relaxed/simple;
	bh=RXMDFWHoPjtIXzowWCmTOgffUV+hgTt3ySQLyBH/QU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f2x1Dzv0ij9iVWQ3ZqmO3lroS3Cyp4TXCjwKH6gwF21SHeR+uQ/OuSDGS61WaR+3++wsReQaWn0g0szhn2+hRd0CJDRgol9zdPDd5PNBRFXSNUwcQ/upbaNI2ai1yzTUhfl+6Mxeq7UgMKhbJ5zSDVzIuf0QJKDW5RFBUOkKFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RzfKYxSW; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yEGmkXbOr7mtjgPnoGoKfiUGT9PqeS/urvU4eY+8abI=;
	b=RzfKYxSWPftH1sI93cHul55M/JGzdsmo6aGP29YWE2lAcCfPPnQorIqza1ZA7u0++rteDM5N3
	OFgdaGLQ6Mtk0ppVVlTNjOfuBDMYRW6uEXQc0cXFicbMY8qmX4qLqGhjwUO5XeFzYNTaX7b6wnB
	lTt2NTJC2PvjfxHc/ZeJ/V4=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d4p1J3wwBz1prKK;
	Mon, 10 Nov 2025 19:52:04 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EB70140258;
	Mon, 10 Nov 2025 19:53:43 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 10 Nov
 2025 19:53:42 +0800
Message-ID: <5be37f62-500f-42cb-838b-e017a5c227fd@huawei.com>
Date: Mon, 10 Nov 2025 19:53:41 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/24] ext4: make data=journal support large block size
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <ebiggers@kernel.org>, <willy@infradead.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<libaokun@huaweicloud.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-22-libaokun@huaweicloud.com>
 <4xsntqfuxy3xiezmztf26qytijdfi3zwxjjgvkpsmxnumkpsf5@2gr4h36mti3g>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <4xsntqfuxy3xiezmztf26qytijdfi3zwxjjgvkpsmxnumkpsf5@2gr4h36mti3g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-10 17:48, Jan Kara wrote:
> On Fri 07-11-25 22:42:46, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Currently, ext4_set_inode_mapping_order() does not set max folio order
>> for files with the data journalling flag. For files that already have
>> large folios enabled, ext4_inode_journal_mode() ignores the data
>> journalling flag once max folio order is set.
>>
>> This is not because data journalling cannot work with large folios, but
>> because credit estimates will go through the roof if there are too many
>> blocks per folio.
>>
>> Since the real constraint is blocks-per-folio, to support data=journal
>> under LBS, we now set max folio order to be equal to min folio order for
>> files with the journalling flag. When LBS is disabled, the max folio order
>> remains unset as before.
>>
>> Additionally, the max_order check in ext4_inode_journal_mode() is removed,
>> and mapping order is reset in ext4_change_inode_journal_flag().
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ...
>
>> @@ -6585,6 +6590,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
>>  		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
>>  	}
>>  	ext4_set_aops(inode);
>> +	ext4_set_inode_mapping_order(inode);
>>  
>>  	jbd2_journal_unlock_updates(journal);
>>  	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
> I think more needs to be done here because this way we could leave folios
> in the page cache that would be now larger than max order. To simplify the
> logic I'd make filemap_write_and_wait() call in
> ext4_change_inode_journal_flag() unconditional and add there
> truncate_pagecache() call to evict all the page cache before we switch the
> inode journalling mode.
>
> 								Honza

That makes sense. I forgot to truncate the old page cache here.

I will make the changes according to your suggestion in the next version.

Thank you for your advice!


Cheers,
Baokun


