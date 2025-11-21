Return-Path: <linux-ext4+bounces-11993-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D56C78835
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 935FA4E6E85
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A794F342C8B;
	Fri, 21 Nov 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bP4ROQnl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FC33C186;
	Fri, 21 Nov 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720871; cv=none; b=nxXU4jPITxUKuqf7lRKqLH9ZaNqp//2NvLUMAlLR20133vVf3N+ZKu8SFQOpLAW3J5UBXHIjomL7JA3F43LLQLBPwnEkLK1d/o9wnjUsTbkHVRDPc9XnobkOMoY9GzZ+7yNaSZwyNU2Ea50hn+w4//yNYUmrI2NVM4pzC9neYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720871; c=relaxed/simple;
	bh=oTmy4MjyXrS9hSdwAJTyXXeuFgwILvrNfw6TM7TWFGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmQYyBvacaj+5ie+APMW7r25NWCWhlzEEAuJte22IRkr/LPkan72vhIofQ91xCIdMbnCjq7L5+9e83OK+qe09NxmYwG0PlsssHYwD/YfOC1tMogPrC/emvEgcbrmNDIlvYLtA9a1KRed8cQe5zeionEqaDo36s398BfoauZ0NLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bP4ROQnl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL0JfJ5027962;
	Fri, 21 Nov 2025 10:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9vecSi
	t01xQCyqb2nbUhoPWEOANoTiBGUWLkTD1Kj7Q=; b=bP4ROQnlsJtcxcF9lLgR3P
	dOjusxoJaw5BlV+7R9ispnApG+/hqgeelGP8vk/T2stKGK+lFDGZQx2RaRtGLAjW
	/a+jVG81lvo1VsCymJXWyO+vWFkAHFLIBoZUhlqClqThyv3CU+mRWoHT3v1yy13a
	CXg0Ue4UpX0YMj5BL+20ip1Tg8Q0dl0KMSs+Wx9U+EpUy1/gAZUR924Edw0TJVOU
	8jjkkWfx8ZTTxhGk4Z0C/Tj+KjaXTHD373y5yvhVX/njC1LoMqt1+yOs4ttE96qw
	PpcXoAVEWAKlnmNxQijlp4PLapw8Y/lhfql0k5OztSKiNGePOC0zyMpz+fACnSdA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejkab834-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 10:26:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL8Pfbl005137;
	Fri, 21 Nov 2025 10:26:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bkkmtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 10:26:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALAQnGb29950396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 10:26:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 706CE2004F;
	Fri, 21 Nov 2025 10:26:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7545C20040;
	Fri, 21 Nov 2025 10:26:46 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.77])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Nov 2025 10:26:46 +0000 (GMT)
Date: Fri, 21 Nov 2025 15:56:44 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH v4 00/24] ext4: enable block size larger than page size
Message-ID: <aSA-ZGmpyPHqM4AY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121090654.631996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251121090654.631996-1-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DJaPugpITROw1Wgj-YPKfmkMn7_6yssS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX6OIdYRxpVcft
 enOtuCHezRv8cmH81RHw8CmnvhE0zjNol0LbICwuwfNvQkKl719zRAK+/W3gcQUor3nrZZ7NoHO
 84gzp5RxllWhckF9AHbAp5uHGr3AJe15xaHjdYdzyXjqizTcy/CDY22EMDQMGstMH3wUZkF9+t2
 esWmuakH2CteFQ8sucXGToaH0KDcijTs8mZwJGXzFm8FZ35F7Z7JxGNMphyxR9RmXA4WqUXJRtB
 gDFnoBL3hTtJgnYn9oV7l1yNOzsoTFQ/qBsXIywS+Et/i075Ei+j8xjeB2OYFDn/MtUrD2xoJFm
 SvOOQqhlGTtzTY3ukEIczovA1gKHDed28B0vzhJMUAU7Ftym/GNMT3nAt/QHWhcPQrc1JB3a0bG
 V4abAY2aqIdF81tI+80bdBQuu/3BMQ==
X-Proofpoint-ORIG-GUID: DJaPugpITROw1Wgj-YPKfmkMn7_6yssS
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=69203e6c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=mxKVMIqUBOM7otbjx6IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Fri, Nov 21, 2025 at 05:06:30PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Changes since v3:
>  * Collect RVB from Jan Kara, Zhang Yi and Pankaj Raghav.
>     (Thank you for your review!)
>  * Patch 21: Fix lock imbalance in ext4_change_inode_journal_flag.
>     (Suggested by Dan Carpenter)
> 
> [v3]: https://lore.kernel.org/r/20251111142634.3301616-1-libaokun@huaweicloud.com
> 
> Changes since v2:
>  * Collect RVB from Jan Kara, Zhang Yi and Pankaj Raghav.
>     (Thank you for your review!)
>  * Patch 21: Before switching the inode journalling mode, drop all
>     page cache of that inode and invoke filemap_write_and_wait()
>     unconditionally. (Suggested by Jan Kara)
>  * Patch 22: Extend fs-verity to support large folios in addition to
>     large block size. (Suggested by Jan Kara)
>  * Patch 24: Add a blocksize_gt_pagesize sysfs interface to help users
>     (e.g., mke2fs) determine whether the current kernel supports bs > ps.
>     In addition, remove the experimental tag. (Suggested by Theodore Ts'o)
> 
> [v2]: https://lore.kernel.org/r/20251107144249.435029-1-libaokun@huaweicloud.com
> 
> Changes since v1:
>  * Collect RVB from Jan Kara and Zhang Yi. (Thanks for your review!)
>  * Patch 4: Just use blocksize in the rounding.(Suggested by Jan Kara)
>  * Patch 7: use kvmalloc() instead of allocating contiguous physical
>     pages.(Suggested by Jan Kara)
>  * Patch 12: Fix some typos.(Suggested by Jan Kara)
>  * Use clearer naming: EXT4_LBLK_TO_PG() and EXT4_PG_TO_LBLK().
>     (Suggested by Jan Kara)
>  * Patch 21: removed. After rebasing on Ted’s latest dev branch, this
>     patch is no longer needed.
>  * Patch 22-23: removed. The issue was resolved by removing the WARN_ON
>     in the MM code, so we now rely on patch [1].(Suggested by Matthew)
>  * Add new Patch 21 to support data=journal under LBS. (Suggested by
>     Jan Kara)
>  * Add new Patch 22 to support fs verity under LBS.
>  * New Patch 23: add the s_max_folio_order field instead of introducing
>     the EXT4_MF_LARGE_FOLIO flag.
>  * New Patch 24: rebase adaptation.
> 
> [v1]: https://lore.kernel.org/r/20251025032221.2905818-1-libaokun@huaweicloud.com
> 
> ======
> 
> This series enables block size > page size (Large Block Size) in EXT4.
> 
> Since large folios are already supported for regular files, the required
> changes are not substantial, but they are scattered across the code.
> The changes primarily focus on cleaning up potential division-by-zero
> errors, resolving negative left/right shifts, and correctly handling
> mutually exclusive mount options.
> 
> One somewhat troublesome issue is that allocating page units greater than
> order-1 with __GFP_NOFAIL in __alloc_pages_slowpath() can trigger an
> unexpected WARN_ON. With LBS support, EXT4 and jbd2 may use __GFP_NOFAIL
> to allocate large folios when reading metadata. The issue was resolved by
> removing the WARN_ON in the MM code, so we now rely on patch [1].
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ee040cbd6e48
> 
> Patch series based on Ted’s latest dev branch.
> 
> `kvm-xfstests -c ext4/all -g auto` has been executed with no new failures.
> `kvm-xfstests -c ext4/32k -g auto` has been executed with no new failures.
> `kvm-xfstests -c ext4/64k -g auto` has been executed with no new failures,
> but allocation failures for large folios may trigger warn_alloc() warnings,
> tests with 32k or smaller block sizes have not exhibited any page allocation
> failures.
> 
> Here are some performance test data for your reference:
> 
> Testing EXT4 filesystems with different block sizes, measuring
> single-threaded dd bandwidth for BIO/DIO with varying bs values.
> 
> Before(PAGE_SIZE=4096):
> 
>       BIO     | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
> --------------|----------|----------|----------|----------|------------
>  4k           | 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
>  8k (bigalloc)| 1.4 GB/s | 2.0 GB/s | 2.6 GB/s | 3.1 GB/s | 3.4 GB/s
>  16k(bigalloc)| 1.5 GB/s | 2.0 GB/s | 2.6 GB/s | 3.2 GB/s | 3.6 GB/s
>  32k(bigalloc)| 1.5 GB/s | 2.1 GB/s | 2.7 GB/s | 3.3 GB/s | 3.7 GB/s
>  64k(bigalloc)| 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
>               
>       DIO     | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
> --------------|----------|----------|----------|----------|------------
>  4k           | 194 MB/s | 366 MB/s | 626 MB/s | 1.0 GB/s | 1.4 GB/s
>  8k (bigalloc)| 188 MB/s | 359 MB/s | 612 MB/s | 996 MB/s | 1.4 GB/s
>  16k(bigalloc)| 208 MB/s | 378 MB/s | 642 MB/s | 1.0 GB/s | 1.4 GB/s
>  32k(bigalloc)| 184 MB/s | 368 MB/s | 637 MB/s | 995 MB/s | 1.4 GB/s
>  64k(bigalloc)| 208 MB/s | 389 MB/s | 634 MB/s | 1.0 GB/s | 1.4 GB/s
> 
> Patched(PAGE_SIZE=4096):
> 
>    BIO   | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
> ---------|----------|----------|----------|----------|------------
>  4k      | 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
>  8k (LBS)| 1.7 GB/s | 2.3 GB/s | 3.2 GB/s | 4.2 GB/s | 4.7 GB/s
>  16k(LBS)| 2.0 GB/s | 2.7 GB/s | 3.6 GB/s | 4.7 GB/s | 5.4 GB/s
>  32k(LBS)| 2.2 GB/s | 3.1 GB/s | 3.9 GB/s | 4.9 GB/s | 5.7 GB/s
>  64k(LBS)| 2.4 GB/s | 3.3 GB/s | 4.2 GB/s | 5.1 GB/s | 6.0 GB/s
> 
>    DIO   | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
> ---------|----------|----------|----------|----------|------------
>  4k      | 204 MB/s | 355 MB/s | 627 MB/s | 1.0 GB/s | 1.4 GB/s
>  8k (LBS)| 210 MB/s | 356 MB/s | 602 MB/s | 997 MB/s | 1.4 GB/s
>  16k(LBS)| 191 MB/s | 361 MB/s | 589 MB/s | 981 MB/s | 1.4 GB/s
>  32k(LBS)| 181 MB/s | 330 MB/s | 581 MB/s | 951 MB/s | 1.3 GB/s
>  64k(LBS)| 148 MB/s | 272 MB/s | 499 MB/s | 840 MB/s | 1.3 GB/s
> 
> 
> The results show:
> 
>  * The code changes have almost no impact on the original 4k write
>    performance of ext4.
>  * Compared with bigalloc, LBS improves BIO write performance by about 50%
>    on average.
>  * Compared with bigalloc, LBS shows degradation in DIO write performance,
>    which increases as the filesystem block size grows and the test bs
>    decreases, with a maximum degradation of about 30%.
> 
> The DIO regression is primarily due to the increased time spent in
> crc32c_arch() within ext4_block_bitmap_csum_set() during block allocation,
> as the block size grows larger. This indicates that larger filesystem block
> sizes are not always better; please choose an appropriate block size based
> on your I/O workload characteristics.
> 
> We are also planning further optimizations for block allocation under LBS
> in the future.
> 
> Comments and questions are, as always, welcome.
> 
> Thanks,
> Baokun

Hi Baokun,

I've gone throught the series and the changes look mostly straight
forward to me. I've started running some regression tests on my PowerPC
machine. It's 64k pgsz so I can only test upto bs == ps, but everything
looks normal for now. I'll report here if there are any regressions.

Regardless, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks,
Ojaswin

> 
> 
> Baokun Li (21):
>   ext4: remove page offset calculation in ext4_block_truncate_page()
>   ext4: remove PAGE_SIZE checks for rec_len conversion
>   ext4: make ext4_punch_hole() support large block size
>   ext4: enable DIOREAD_NOLOCK by default for BS > PS as well
>   ext4: introduce s_min_folio_order for future BS > PS support
>   ext4: support large block size in ext4_calculate_overhead()
>   ext4: support large block size in ext4_readdir()
>   ext4: add EXT4_LBLK_TO_B macro for logical block to bytes conversion
>   ext4: add EXT4_LBLK_TO_PG and EXT4_PG_TO_LBLK for block/page
>     conversion
>   ext4: support large block size in ext4_mb_load_buddy_gfp()
>   ext4: support large block size in ext4_mb_get_buddy_page_lock()
>   ext4: support large block size in ext4_mb_init_cache()
>   ext4: prepare buddy cache inode for BS > PS with large folios
>   ext4: support large block size in ext4_mpage_readpages()
>   ext4: support large block size in ext4_block_write_begin()
>   ext4: support large block size in mpage_map_and_submit_buffers()
>   ext4: support large block size in mpage_prepare_extent_to_map()
>   ext4: make data=journal support large block size
>   ext4: support verifying data from large folios with fs-verity
>   ext4: add checks for large folio incompatibilities when BS > PS
>   ext4: enable block size larger than page size
> 
> Zhihao Cheng (3):
>   ext4: remove page offset calculation in ext4_block_zero_page_range()
>   ext4: rename 'page' references to 'folio' in multi-block allocator
>   ext4: support large block size in __ext4_block_zero_page_range()
> 
>  fs/ext4/dir.c       |   8 +--
>  fs/ext4/ext4.h      |  26 ++++-----
>  fs/ext4/ext4_jbd2.c |   3 +-
>  fs/ext4/extents.c   |   2 +-
>  fs/ext4/inode.c     | 112 +++++++++++++++---------------------
>  fs/ext4/mballoc.c   | 137 +++++++++++++++++++++++---------------------
>  fs/ext4/namei.c     |   8 +--
>  fs/ext4/readpage.c  |   7 +--
>  fs/ext4/super.c     |  61 ++++++++++++++++----
>  fs/ext4/sysfs.c     |   6 ++
>  fs/ext4/verity.c    |   2 +-
>  11 files changed, 197 insertions(+), 175 deletions(-)
> 
> -- 
> 2.46.1
> 

