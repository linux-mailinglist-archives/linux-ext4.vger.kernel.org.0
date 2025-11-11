Return-Path: <linux-ext4+bounces-11748-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B86CC4B5B5
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 04:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A254D4EBD9E
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 03:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61B934A774;
	Tue, 11 Nov 2025 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BjMPtRNL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8167640E;
	Tue, 11 Nov 2025 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762832595; cv=none; b=srkF9q+J9nB7hQ45b4unBX2wUnTkHgcHPhEf0E3hSOig1rZvgoY5GzeKz9EauIBFbiREgb5Kr4LORQAYYDiIWhCdOL9UOxezP+bjfZ2i/VFByr+BJpJOrg+tmortX1C2Cyj8EiNi6ZSXcAcVhpUw4hAtE2ExC0IzpV6/KsAcRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762832595; c=relaxed/simple;
	bh=UmbMwPFQDhX0sgemsDZP1cEnjvFz1CTV1maBqxb2RPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XMIedw4EKXhCIPIALw66A4swR6hvx+58xnkJSYy9clWundU27B1+ZURc/vhhnXSWXyEFkHkUtqPD4qUG6sKysq4VQ5TVCYOeK+eFQJEuXBnjtyH//KwZaWnNljXJMOCf9mzffd6sYMP7qnU8lW2HGrCtpm2q7TYbaAafJnMXBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BjMPtRNL; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0kaa3vUiwcAr53RbTBFcjCZZteWEUfi4Wdgy/IuyaD8=;
	b=BjMPtRNLi+CcIV6s6FBTzainP0aydUB3TmqKoZGdqEmnOiFKUJmBgDMKhlSQls1S43E6WM7+p
	114ek8lmUZbarbWH+isnSzgy2y50xikq4gxFeynLc75PZKPdYTON4BnDEEAKrdmKqDdxTq8GK0t
	yx04ydq9h37K7jgZfg+4em4=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d5C4k2c1fz1prLS;
	Tue, 11 Nov 2025 11:41:26 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id B4EBF180087;
	Tue, 11 Nov 2025 11:43:05 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Nov
 2025 11:43:04 +0800
Message-ID: <46c68bcf-8ad4-45ed-9fba-cc908328069b@huawei.com>
Date: Tue, 11 Nov 2025 11:43:03 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/24] ext4: enable block size larger than page size
Content-Language: en-GB
To: Theodore Ts'o <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <ebiggers@kernel.org>, <willy@infradead.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<libaokun@huaweicloud.com>, Baokun Li <libaokun1@huawei.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-25-libaokun@huaweicloud.com>
 <20251110151604.GE2988753@mit.edu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251110151604.GE2988753@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-10 23:16, Theodore Ts'o wrote:
> On Fri, Nov 07, 2025 at 10:42:49PM +0800, libaokun@huaweicloud.com wrote:
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
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Could you add:
>
> #ifdef CONFIG_TRANSPARENT_HUGEPAGES
> EXT4_ATTR_FEATURE(blocksize_gt_pagesize);
> #endif
>
> in fs/sys/sysfs.c, so that userspace programs (like those in e2fsprogs
> and xfstests) can test /sys/fs/ext4/features/... to determine whether
> or not blocksize > pagesize is supported?  That way we can more easily
> determine whether to test the 64k blocksize configurations in
> xfstests, and so we can supress the mke2fs warnings:
>
> mke2fs: 65536-byte blocks too big for system (max 4096)
> Proceed anyway? (y,N) y
> Warning: 65536-byte blocks too big for system (max 4096), forced to continue
>
> ... if the feature flag file is present.
>
Good idea — sure!

In my earlier tests I just dropped the warning in mke2fs. That’s a bit
clumsy though; adding an interface so mke2fs and the kernel can work
together is much nicer.

It also lets us do what was mentioned in another thread: warn in mke2fs
instead of in the kernel. I’ll take your suggestion in the next version
and drop the experimental tag.

Thank you for your suggestion!


Regards,
Baokun


