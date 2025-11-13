Return-Path: <linux-ext4+bounces-11851-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFC1C568BF
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 10:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D634349ED0
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1C62D9798;
	Thu, 13 Nov 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aU6k2/W/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EF30217C;
	Thu, 13 Nov 2025 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025306; cv=none; b=GU8eRX9lfDbNTwgUQmdB2fe9+Fjn+MLTmm9nqfOxhZBjwbvK6WD2pMaImUHrPZ+449BfaOhXgpVCl/NX5ggpfXNm18lp98IO5AR9cAZXwJb3YtCZd8sarecRyfWwkW3F6b5AciqoaF4oMM6z4FffcO/TSiILPmn9P5ozSn+1EVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025306; c=relaxed/simple;
	bh=OcT8ud378Gs2Qtdn2sEJs0owXjt4K6jRZVdemqrew5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tQGo2eUXzU/J2kpfu47TyNpQDzRije5Dg9U5LwZqT/uI7oEnxlQ2yUBMt9coIo6mAomFHGLU06x9BZT7po84UZl5Lrk2cgYzm8uBT637YoHcGVDigSQef/FX9Ssd3yANG+cjpbTFlFdD1Wk8LfIvn/V6Yzq/mE2ZnvoNI8P6RWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aU6k2/W/; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gVaVlDillLGy1hBjaeaiITckggxoDozYZ3Fwd0ya8ro=;
	b=aU6k2/W/0X0YAQTxoNgi3Yjd+5ihhQRoRYYtZHTtIE/wbqb6O8oGnip8pEOue/9ZMme62pyrv
	WhxIEX35KkB564H9PhdjfXASuA/a/L4UjVYZUfFC+A4SrsjK7NC+MsGoQSXrDL8aP3aVVDOUT1B
	X1Og7IR5sfjdoWg6Yhd1LWw=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d6ZLr0V10znTVv;
	Thu, 13 Nov 2025 17:13:24 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id E929B1400CB;
	Thu, 13 Nov 2025 17:14:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Nov
 2025 17:14:53 +0800
Message-ID: <c244379f-71c8-4ce7-af87-1bfa6507af28@huawei.com>
Date: Thu, 13 Nov 2025 17:14:52 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
Content-Language: en-GB
To: Theodore Ts'o <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <ebiggers@kernel.org>, <willy@infradead.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	Baokun Li <libaokun@huaweicloud.com>, "Darrick J. Wong" <djwong@kernel.org>
References: <20251112040220.GO2988753@mit.edu>
 <21efa577-a577-48ce-a82b-bce446539fba@huawei.com>
 <20251112152933.GC3131573@mit.edu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251112152933.GC3131573@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-12 23:29, Theodore Ts'o wrote:
> On Wed, Nov 12, 2025 at 02:27:19PM +0800, Baokun Li wrote:
>> Darrick’s reply in another thread has already made a similar change,
>> so we can apply that patch first for testing.
> I'll give that a try when I have a chance.  For now, here's a test run
> using a version of my test appliance which excludes the way group for
> the config ext4/lbs, and which has a modified e2fsprogs (built from
> the latest e2fsprogs git repo) which suppresses both warnings when
> using large block sizes if the kernel has the blocksize_gt_pagesize
> feature detected.
>
> ext4/lbs: 595 tests, 6 failures, 101 skipped, 6656 seconds
>   Failures: ext4/033 generic/620 generic/759 generic/760
>   Flaky: generic/251: 60% (3/5)   generic/645: 40% (2/5)
> Totals: 619 tests, 101 skipped, 25 failures, 0 errors, 6291s
>
> Fixing all of these filures is not a blocker for getting this patchset
> upstream, but it would be nice for us to figure out the root cause for
> them, so we can decide whether it's better to exclude the tests for
> now, or whether there's an easy fix.

Thank you for your testing! I have analyzed the above failing cases, and
they are basically unrelated to this patch set. My analysis is as follows:

# generic/759 generic/760
Require CONFIG_HUGETLB_PAGE and CONFIG_HUGETLBFS enabled.

# generic/620
vdc needs at least 33G. Passed after replacing with a 2T disk. Suggest
putting this test case into exclude.

# ext4/033
1. With 64k block size, inodes_per_group=$((blksz*8)) does not hold;
2. Creating a 400+T snapshot and formatting it as a 64k ext4 filesystem
    requires more than 1T of disk space just for metadata;
3. With 64k block size ext4, when orphan file is enabled by default,
    it fails because orphan file size exceeds 8 << 20. Fixed in [1].
    [1]:
https://lore.kernel.org/r/20251113090122.2385797-1-libaokun@huaweicloud.com
After resolving the above issues, the test passes with a 2T disk. However,
since the inode number overflow is unrelated to block size, suggest putting
this test case into exclude.

# generic/645
This test checks that idmapped mounts behave correctly with complex user
namespaces. On my side the reproduction rate is very low, about 1/100.
Even before the code was merged, occasional failures also appeared in the
4k tests. Based on the test content, I think it is unrelated to LBS.


Cheers,
Baokun



