Return-Path: <linux-ext4+bounces-11747-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1EC4B539
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 04:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133ED3A94D6
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 03:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5C30EF6A;
	Tue, 11 Nov 2025 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eDUTjYUJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8DD3D6F;
	Tue, 11 Nov 2025 03:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831893; cv=none; b=Jkgbp1Sw8D0igI2/Y+4aUBAOYEsQ5FvC3m5tpxR9oZKebMgKRL7pMrc0BZWaqy0z45eHw8NljXCBApQH3IVIdEXKrto697WKk4jZEi3BF8SG+SX/pbtL8kd2VPXzjhIRD5WvaR5/t/5nT3FH4coksLkUvuYEtOqO1BTlzzyY4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831893; c=relaxed/simple;
	bh=JvwpQLZJ6axvQ0jTgv44RjZ6Og1y4KB2/HoueSL5YUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RPwYv/60QrkwEKDpu8yad/bwfymCPNp/5SEtqNjiV4//5kEAS3iSWSn0I4ykRgnAmEukM95uq0rGnvAl90t17ipdDFxie3GPb7YypMrn0WWFelgYNxqXaq8TrzzuIryDCENlepWjIY3KO6ag8IcxxB26R5H5v/GfHdnErnoiGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eDUTjYUJ; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JvwpQLZJ6axvQ0jTgv44RjZ6Og1y4KB2/HoueSL5YUw=;
	b=eDUTjYUJGZPeVNNUX3O+ibh0dwfgcpGm7C0MhkK3NwK73X4+cBNgL3SInDETbToIXzpbYMJq0
	NhdRpLfVLvJPwM7g7fTFT1lYe2ySCc0T9/SAWTNsGoIFcaOYcavefl9b4G1fKOKiN5z79YW63bD
	wH4aB1hgJ4tNJCMQmTNygAE=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d5BqG4RY8zpTR8;
	Tue, 11 Nov 2025 11:29:46 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 54A75180495;
	Tue, 11 Nov 2025 11:31:27 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Nov
 2025 11:31:26 +0800
Message-ID: <ec57829f-947e-4446-93c7-1e481e4cc70f@huawei.com>
Date: Tue, 11 Nov 2025 11:31:24 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/24] ext4: enable block size larger than page size
Content-Language: en-GB
To: Pankaj Raghav <kernel@pankajraghav.com>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>, <ebiggers@kernel.org>,
	<willy@infradead.org>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<chengzhihao1@huawei.com>, <libaokun@huaweicloud.com>,
	<linux-ext4@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-25-libaokun@huaweicloud.com>
 <52401c3a-26aa-473f-b7e2-1c658550dd37@pankajraghav.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <52401c3a-26aa-473f-b7e2-1c658550dd37@pankajraghav.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-10 20:51, Pankaj Raghav wrote:
> On 11/7/25 15:42, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Since block device (See commit 3c20917120ce ("block/bdev: enable large
>> folio support for large logical block sizes")) and page cache (See commit
>> ab95d23bab220ef8 ("filemap: allocate mapping_min_order folios in the page
>> cache")) has the ability to have a minimum order when allocating folio,
>> and ext4 has supported large folio in commit 7ac67301e82f ("ext4: enable
>> large folio for regular file"), now add support for block_size > PAGE_SIZE
>> in ext4.
>>
>> set_blocksize() -> bdev_validate_blocksize() already validates the block
>> size, so ext4_load_super() does not need to perform additional checks.
>>
>> Here we only need to add the FS_LBS bit to fs_flags.
>>
>> In addition, allocation failures for large folios may trigger warn_alloc()
>> warnings. Therefore, as with XFS, mark this feature as experimental.
>>
> Are you adding the experimental flag because allocation failures can occur with
> LBS configuration or because it is a new feature (or both)?
>
> In XFS we added this flag because this was a new feature and not because of the
> allocation failure that might happen.

Yeah, both. Large folios still have some problems (allocation failures,
fragmentation, memory overhead, etc.) to sort out, and LBS has to be
forced on.

> Is it even possible to get rid of these allocation failures in systems were the
> memory is limited as the page cache works in > PAGE_SIZE allocations?
>
> --
> Pankaj

The MM people are working in this direction, and how to avoid memory
allocation failures has also been a frequent topic of discussion recently.

I believe this issue will be resolved in the near future.


Regards,
Baokun


