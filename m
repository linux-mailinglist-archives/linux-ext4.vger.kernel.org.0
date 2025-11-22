Return-Path: <linux-ext4+bounces-12003-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC25C7BFF4
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Nov 2025 01:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59773A5751
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Nov 2025 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90D172612;
	Sat, 22 Nov 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jI2ETpt/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF947081A;
	Sat, 22 Nov 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770428; cv=none; b=QHn2v2nUOwHKeFgPkOieN3BViEKdbM6KDPr8U6BQXBlcJfR6s5Ztg4cRea49y1BX2PYBhOoghSiYu5lWfvCtiYCjSqpKNVaFfZfil2xmwTH3JAXuRgkVpjepmtku/lg6iFHF6cc/dSWEFHNzVJZhgUvn90DSAgg8tgu84a0ykE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770428; c=relaxed/simple;
	bh=I9ZJW8fzOwRYzDSxJBdEMcGi3U2oFhbSBAl3bhrBXsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m441FcDsO5xRh77N1NfC4rniUF5QCQey97CxKaVmO4HOMrqrPws+EIs5pPJ8PYdVMbuuyhAq8obszSX2KHQQVjjKcTdhLJg6+1YfEO5xm7PUppnOr4/ju1k0h7B8tBm6txWW3OyEO+MPe8nOmP3E4GHtMcRLDggcS/oMA5Qlt14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jI2ETpt/; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HwI45p2c8gMsjRtN0LGYAtwh7xc/Se/HfrYlUyAld44=;
	b=jI2ETpt/DhXAn7tnxpDiULZve+yVxbIaE8FZPsj6rNuOS5DFr5nIRhtCpCcPAiU+lXv14iB4r
	0xTmf9VUPlgfvttcODcNRbqcMFIuWAPXrxFw6l2mingS6a4HBImM/iJKMPJwidLDbfMzCUsHrjc
	tfN9vYpeXjWCTnz25e6c5P8=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dCsvV5R9zzcZyV;
	Sat, 22 Nov 2025 08:11:34 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id C957F180BD1;
	Sat, 22 Nov 2025 08:13:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 22 Nov
 2025 08:13:40 +0800
Message-ID: <6fe9c4be-a2d6-4000-85e1-cdf3c0dab196@huawei.com>
Date: Sat, 22 Nov 2025 08:13:39 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/24] ext4: enable block size larger than page size
Content-Language: en-GB
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, <libaokun@huaweicloud.com>,
	<kernel@pankajraghav.com>, <mcgrof@kernel.org>, <ebiggers@kernel.org>,
	<willy@infradead.org>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<chengzhihao1@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20251121090654.631996-1-libaokun@huaweicloud.com>
 <aSA-ZGmpyPHqM4AY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aSA-ZGmpyPHqM4AY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-21 18:26, Ojaswin Mujoo wrote:
> On Fri, Nov 21, 2025 at 05:06:30PM +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Changes since v3:
>>  * Collect RVB from Jan Kara, Zhang Yi and Pankaj Raghav.
>>     (Thank you for your review!)
>>  * Patch 21: Fix lock imbalance in ext4_change_inode_journal_flag.
>>     (Suggested by Dan Carpenter)
>>
>> [v3]: https://lore.kernel.org/r/20251111142634.3301616-1-libaokun@huaweicloud.com
>>
>> Changes since v2:
>>  * Collect RVB from Jan Kara, Zhang Yi and Pankaj Raghav.
>>     (Thank you for your review!)
>>  * Patch 21: Before switching the inode journalling mode, drop all
>>     page cache of that inode and invoke filemap_write_and_wait()
>>     unconditionally. (Suggested by Jan Kara)
>>  * Patch 22: Extend fs-verity to support large folios in addition to
>>     large block size. (Suggested by Jan Kara)
>>  * Patch 24: Add a blocksize_gt_pagesize sysfs interface to help users
>>     (e.g., mke2fs) determine whether the current kernel supports bs > ps.
>>     In addition, remove the experimental tag. (Suggested by Theodore Ts'o)
>>
>> [v2]: https://lore.kernel.org/r/20251107144249.435029-1-libaokun@huaweicloud.com
>>
>> Changes since v1:
>>  * Collect RVB from Jan Kara and Zhang Yi. (Thanks for your review!)
>>  * Patch 4: Just use blocksize in the rounding.(Suggested by Jan Kara)
>>  * Patch 7: use kvmalloc() instead of allocating contiguous physical
>>     pages.(Suggested by Jan Kara)
>>  * Patch 12: Fix some typos.(Suggested by Jan Kara)
>>  * Use clearer naming: EXT4_LBLK_TO_PG() and EXT4_PG_TO_LBLK().
>>     (Suggested by Jan Kara)
>>  * Patch 21: removed. After rebasing on Ted’s latest dev branch, this
>>     patch is no longer needed.
>>  * Patch 22-23: removed. The issue was resolved by removing the WARN_ON
>>     in the MM code, so we now rely on patch [1].(Suggested by Matthew)
>>  * Add new Patch 21 to support data=journal under LBS. (Suggested by
>>     Jan Kara)
>>  * Add new Patch 22 to support fs verity under LBS.
>>  * New Patch 23: add the s_max_folio_order field instead of introducing
>>     the EXT4_MF_LARGE_FOLIO flag.
>>  * New Patch 24: rebase adaptation.
>>
>> [v1]: https://lore.kernel.org/r/20251025032221.2905818-1-libaokun@huaweicloud.com
>>
>> ======
>>
>> This series enables block size > page size (Large Block Size) in EXT4.
>>
>> Since large folios are already supported for regular files, the required
>> changes are not substantial, but they are scattered across the code.
>> The changes primarily focus on cleaning up potential division-by-zero
>> errors, resolving negative left/right shifts, and correctly handling
>> mutually exclusive mount options.
>>
>> One somewhat troublesome issue is that allocating page units greater than
>> order-1 with __GFP_NOFAIL in __alloc_pages_slowpath() can trigger an
>> unexpected WARN_ON. With LBS support, EXT4 and jbd2 may use __GFP_NOFAIL
>> to allocate large folios when reading metadata. The issue was resolved by
>> removing the WARN_ON in the MM code, so we now rely on patch [1].
>>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ee040cbd6e48
>>
>> Patch series based on Ted’s latest dev branch.
>>
>> `kvm-xfstests -c ext4/all -g auto` has been executed with no new failures.
>> `kvm-xfstests -c ext4/32k -g auto` has been executed with no new failures.
>> `kvm-xfstests -c ext4/64k -g auto` has been executed with no new failures,
>> but allocation failures for large folios may trigger warn_alloc() warnings,
>> tests with 32k or smaller block sizes have not exhibited any page allocation
>> failures.
>>
>> Here are some performance test data for your reference:
>>
>> Testing EXT4 filesystems with different block sizes, measuring
>> single-threaded dd bandwidth for BIO/DIO with varying bs values.
>>
>> Before(PAGE_SIZE=4096):
>>
>>       BIO     | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
>> --------------|----------|----------|----------|----------|------------
>>  4k           | 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
>>  8k (bigalloc)| 1.4 GB/s | 2.0 GB/s | 2.6 GB/s | 3.1 GB/s | 3.4 GB/s
>>  16k(bigalloc)| 1.5 GB/s | 2.0 GB/s | 2.6 GB/s | 3.2 GB/s | 3.6 GB/s
>>  32k(bigalloc)| 1.5 GB/s | 2.1 GB/s | 2.7 GB/s | 3.3 GB/s | 3.7 GB/s
>>  64k(bigalloc)| 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
>>               
>>       DIO     | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
>> --------------|----------|----------|----------|----------|------------
>>  4k           | 194 MB/s | 366 MB/s | 626 MB/s | 1.0 GB/s | 1.4 GB/s
>>  8k (bigalloc)| 188 MB/s | 359 MB/s | 612 MB/s | 996 MB/s | 1.4 GB/s
>>  16k(bigalloc)| 208 MB/s | 378 MB/s | 642 MB/s | 1.0 GB/s | 1.4 GB/s
>>  32k(bigalloc)| 184 MB/s | 368 MB/s | 637 MB/s | 995 MB/s | 1.4 GB/s
>>  64k(bigalloc)| 208 MB/s | 389 MB/s | 634 MB/s | 1.0 GB/s | 1.4 GB/s
>>
>> Patched(PAGE_SIZE=4096):
>>
>>    BIO   | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
>> ---------|----------|----------|----------|----------|------------
>>  4k      | 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
>>  8k (LBS)| 1.7 GB/s | 2.3 GB/s | 3.2 GB/s | 4.2 GB/s | 4.7 GB/s
>>  16k(LBS)| 2.0 GB/s | 2.7 GB/s | 3.6 GB/s | 4.7 GB/s | 5.4 GB/s
>>  32k(LBS)| 2.2 GB/s | 3.1 GB/s | 3.9 GB/s | 4.9 GB/s | 5.7 GB/s
>>  64k(LBS)| 2.4 GB/s | 3.3 GB/s | 4.2 GB/s | 5.1 GB/s | 6.0 GB/s
>>
>>    DIO   | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
>> ---------|----------|----------|----------|----------|------------
>>  4k      | 204 MB/s | 355 MB/s | 627 MB/s | 1.0 GB/s | 1.4 GB/s
>>  8k (LBS)| 210 MB/s | 356 MB/s | 602 MB/s | 997 MB/s | 1.4 GB/s
>>  16k(LBS)| 191 MB/s | 361 MB/s | 589 MB/s | 981 MB/s | 1.4 GB/s
>>  32k(LBS)| 181 MB/s | 330 MB/s | 581 MB/s | 951 MB/s | 1.3 GB/s
>>  64k(LBS)| 148 MB/s | 272 MB/s | 499 MB/s | 840 MB/s | 1.3 GB/s
>>
>>
>> The results show:
>>
>>  * The code changes have almost no impact on the original 4k write
>>    performance of ext4.
>>  * Compared with bigalloc, LBS improves BIO write performance by about 50%
>>    on average.
>>  * Compared with bigalloc, LBS shows degradation in DIO write performance,
>>    which increases as the filesystem block size grows and the test bs
>>    decreases, with a maximum degradation of about 30%.
>>
>> The DIO regression is primarily due to the increased time spent in
>> crc32c_arch() within ext4_block_bitmap_csum_set() during block allocation,
>> as the block size grows larger. This indicates that larger filesystem block
>> sizes are not always better; please choose an appropriate block size based
>> on your I/O workload characteristics.
>>
>> We are also planning further optimizations for block allocation under LBS
>> in the future.
>>
>> Comments and questions are, as always, welcome.
>>
>> Thanks,
>> Baokun
> Hi Baokun,
>
> I've gone throught the series and the changes look mostly straight
> forward to me. I've started running some regression tests on my PowerPC
> machine. It's 64k pgsz so I can only test upto bs == ps, but everything
> looks normal for now. I'll report here if there are any regressions.
>
> Regardless, feel free to add:
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thank you for your review and testing!


Cheers,
Baokun


