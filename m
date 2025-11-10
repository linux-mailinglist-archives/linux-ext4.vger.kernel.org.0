Return-Path: <linux-ext4+bounces-11726-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581FAC470A7
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 14:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214321891A89
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A4630FC17;
	Mon, 10 Nov 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zhH2UlpG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2855225417;
	Mon, 10 Nov 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782838; cv=none; b=LNtO6WqXX9om4ydqWtRkPQOHHqK5Sv9IoE9EFOGPgWKMSpepNYK3+hxnEFkgi8Y1Rmkm/64inRn+8MQZHycXNOll2OSLcMTXmPp5SHiUQ71HwnbZE1uibWF+97ctQZldMPK84J17DQj+6u/FHyIda/cSOjgsoJurNvIZIH/3zB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782838; c=relaxed/simple;
	bh=Ron+HvGkKg+JisLRgvoQjq5k1daRdv+R+0NlGR9OeQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ANiFw9VwuCQMPXdTfuimtRm4lTctN3sBAVq6njSMbJEJ2eCf0xEoN+61yrp+QznwVweIBx3sOi2+AUpfzrDKkYLEVxX9xClxW9L3CjsvceVvYwOMP4vjhGavgkOJGJ9IYC+Mwun0TeTV99cjp+dmpbS8QxGOKQqhinPNWK2wvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zhH2UlpG; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RKlfRV4djsyJngR6aGtPVAaq73trDTQOwc7Rfy0NYSE=;
	b=zhH2UlpGBQqLdBbXBIOe9lAyzgJYhKDusvLOyVnmq43St3QIe8VK7jPTp56S1CMcP6WpHmiIx
	KyW1998tuLOEzJHjFNp+9x6YVXpmvFORicDoWB9cH2l/8PYW7G8WXPx5o76X7971sGiOGHLBrfZ
	qg1NZ2RoT9f+ziUAVu522I0=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d4rhG2qJsz1T4Gh;
	Mon, 10 Nov 2025 21:52:30 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EA8A180495;
	Mon, 10 Nov 2025 21:53:51 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 10 Nov
 2025 21:53:50 +0800
Message-ID: <e714ec6b-a412-4780-a8ac-27055dbccae3@huawei.com>
Date: Mon, 10 Nov 2025 21:53:49 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/24] ext4: support large block size in ext4_readdir()
Content-Language: en-GB
To: Pankaj Raghav <kernel@pankajraghav.com>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>, <ebiggers@kernel.org>,
	<willy@infradead.org>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun@huaweicloud.com>, <chengzhihao1@huawei.com>,
	<linux-ext4@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-9-libaokun@huaweicloud.com>
 <af30cb7e-a59d-4937-8fc5-1b9c68685939@pankajraghav.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <af30cb7e-a59d-4937-8fc5-1b9c68685939@pankajraghav.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-10 20:26, Pankaj Raghav wrote:
> On 11/7/25 15:42, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> In ext4_readdir(), page_cache_sync_readahead() is used to readahead mapped
>> physical blocks. With LBS support, this can lead to a negative right shift.
>>
>> To fix this, the page index is now calculated by first converting the
>> physical block number (pblk) to a file position (pos) before converting
>> it to a page index. Also, the correct number of pages to readahead is now
>> passed.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> ---
> Minor general comments below.
>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Thanks for the review!
>
>>  fs/ext4/dir.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
>> index d4164c507a90..256fe2c1d4c1 100644
>> --- a/fs/ext4/dir.c
>> +++ b/fs/ext4/dir.c
>> @@ -192,13 +192,13 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
>>  			continue;
>>  		}
>>  		if (err > 0) {
>> -			pgoff_t index = map.m_pblk >>
>> -					(PAGE_SHIFT - inode->i_blkbits);
>> +			pgoff_t index = map.m_pblk << inode->i_blkbits >>
>> +					PAGE_SHIFT;
> It will be nice to have some common helper for this operation. We do something
> similar in filemap.c as well.

In patch 10, we introduced a macro to handle the conversion from lblk
to page index. In this particular case, though, it is pblk, which has
a different value range compared to lblk. As this is the only instance
in the code, I applied a standalone modification here.

>
>>  			if (!ra_has_index(&file->f_ra, index))
>>  				page_cache_sync_readahead(
>>  					sb->s_bdev->bd_mapping,
>> -					&file->f_ra, file,
>> -					index, 1);
>> +					&file->f_ra, file, index,
>> +					1 << EXT4_SB(sb)->s_min_folio_order);
> Just a personal opinion but it would be nice to have some variable for this instead of doing it
> inline? It could be defined along with index.
>
> unsigned long min_nr_pages = 1UL << EXT4_SB(sb)->s_min_folio_order;
>
Thank you for the suggestion. This is indeed a bit easier to understand,
but the space here is limited and the variable is only used once,
so I prefer the current direct style.


Cheers,
Baokun

>>  			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
>>  			bh = ext4_bread(NULL, inode, map.m_lblk, 0);
>>  			if (IS_ERR(bh)) {
>


