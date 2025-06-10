Return-Path: <linux-ext4+bounces-8344-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9511AD3591
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jun 2025 14:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73721176078
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jun 2025 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D38A28CF7F;
	Tue, 10 Jun 2025 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ri8iSlR6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC728C2C8;
	Tue, 10 Jun 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557220; cv=none; b=N0i7Hpqqc7jloSuUbDHIfDNJd7xuiFMI9cP0ILxUKuQCioGZ5Vm9s506ZH0DRn2Smoz2WTCWbQLnwyHEbhs53+KD3CPK1pQEwn/LbZdSrg/+mZd3NMBNqyJXkQibwupeDKNlGrg4KJqrM0SM9GTtfnhC7OO0B5EbAvQD7qla8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557220; c=relaxed/simple;
	bh=EkMB7KUTjkwge8j0gz9girM5cdLzB5ROPSWijkurCcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEnoYu9dPgbRc8/p5br4uQETfWKR5CHWyZWnIEjcyOSkcnFcqsVuuKUOdlIS6TSE21x4X3W5HwZCx8oI7HWMbWZfl6EVMhxdFVfE/SMxHIOfWj0ajmjCKP1NlcZ7DoAWee3cRtBc1sJ8OvoHl/vvxoKqmLm0u/aX8/YsKm0sFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ri8iSlR6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A8t32c015822;
	Tue, 10 Jun 2025 12:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TfQeFs
	n5OX8Ds6lrkjF8mkNC2ESgwitOsvbH/o3G5ps=; b=ri8iSlR6d8y4F/Zdk7JaeV
	XyyajxIhlzv5SheCSUb2ysTKgnTCKReK6hk+jtrLOdw4Xx//EtQLdgqfP3Zbcs3z
	2ocDCUsp65GP4+xww0uS/BUXFte9VSSn+Km5w3GpRE8DaAlAliwxNx2ZJ4Q/cIzZ
	DQjri92xnbq/zfR/j4lMc3BIHVDvPsJPTmhhOkj5ySzV4F1szNHLka8q4YFYIoXq
	zE4zmBi9NZDXhQylYALL8yXXvk8EDq50HzqKSoTOKV+m98OLvnvxmMH6XpQj7jq1
	xzFivSYJUU/tu3uNrE/PtW+i1IpFxLhntCLXsTM2yN3PGme8rLbrVffpPTU44X9Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m3748-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 12:06:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AA25W8003405;
	Tue, 10 Jun 2025 12:06:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ykj202-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 12:06:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55AC6SNp32375500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 12:06:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 701272004B;
	Tue, 10 Jun 2025 12:06:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7275520040;
	Tue, 10 Jun 2025 12:06:26 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Jun 2025 12:06:26 +0000 (GMT)
Date: Tue, 10 Jun 2025 17:36:24 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH 0/4] ext4: better scalability for ext4 block allocation
Message-ID: <aEgfwKvcJzt9gkGq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <aDchmYDc_OOAu2yC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <f21507f9-ebc6-43ce-97c4-cd055c53747e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f21507f9-ebc6-43ce-97c4-cd055c53747e@huawei.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=68481fc7 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=UN8tCtabBRPHEa8_l9kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pguttIyuptPycXpC454v:22
X-Proofpoint-GUID: -pgdU0MtfYHDtLkLOu8MGqff_Pppmb9N
X-Proofpoint-ORIG-GUID: -pgdU0MtfYHDtLkLOu8MGqff_Pppmb9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5MiBTYWx0ZWRfXyoA4phmBDrun IFs5HTJCRfejvzZ0+Pi9bOLfZlHgV+39QPUXMuvM762oNCaJDEKYTfJuT8HWzYG8vuxhqBdWq+0 PnJ0YVZvddpcAJhAQ1I9ulKFna1Mk3KNJF/7Q/9YOTE9ah2imKiJWdMWis5DshzFcUDveeU/bu8
 sLkZ7/GADNivUsqJlVWZOV77fALUxpdDgjS0ORzQ3vUhGKvK2M1jCS3zEj8gmYAks86vmfBfaf1 afxKCUEYCsxzMnaytkrvbVZDGzOI92LHqktw7G/1jDT6vXndG3PrPJfftYIakeccOfXOyeFhFjK efnCJDp0wH8rbrOKjgZAWY/YCheVdQoyNIqV4+MK2H5IO52EsMBke5TcZg5x3Rp47XvUWGZgPQq
 mAxwvRdfCQ+UU/2GdRolPCnxVMYSeU9R/ab+zdqTyCRreZAmggG9mUd8IliJmxrBVWpN7LuH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100092

On Thu, May 29, 2025 at 08:24:14PM +0800, Baokun Li wrote:
> On 2025/5/28 22:53, Ojaswin Mujoo wrote:
> > On Fri, May 23, 2025 at 04:58:17PM +0800, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>

<...>

> > > |--------|--------|--------|--------|--------|--------|--------|--------|
> > > |    -   |    1   |    2   |    4   |    8   |   16   |   32   |   64   |
> > > |--------|--------|--------|--------|--------|--------|--------|--------|
> > > |  base  | 295287 | 70665  | 33865  | 19387  | 10104  |  5588  |  3588  |
> > > |--------|--------|--------|--------|--------|--------|--------|--------|
> > > | linear | 286328 | 123102 | 119542 | 90653  | 60344  | 35302  | 23280  |
> > > |        | -3.0%  | 74.20% | 252.9% | 367.5% | 497.2% | 531.6% | 548.7% |
> > > |--------|--------|--------|--------|--------|--------|--------|--------|
> > > |mb_optim| 292498 | 133305 | 103069 | 61727  | 29702  | 16845  | 10430  |
> > > |ize_scan| -0.9%  | 88.64% | 204.3% | 218.3% | 193.9% | 201.4% | 190.6% |
> > > |--------|--------|--------|--------|--------|--------|--------|--------|
> > Hey Baokun, nice improvements! The proposed changes make sense to me,
> > however I suspect the performance improvements may come at a cost of
> > slight increase in fragmentation, which might affect rotational disks
> > especially. Maybe comparing e2freefrag numbers with and without the
> > patches might give a better insight into this.
> While this approach might slightly increase free space fragmentation on
> the disk, it significantly reduces file fragmentation, leading to faster
> read speeds on rotational disks.
> 
> When multiple processes contend for free blocks within the same block
> group, the probability of blocks allocated by the same process being
> merged on consecutive allocations is low. This is because other processes
> may preempt the free blocks immediately following the current process's
> last allocated region.
> 
> Normally, we rely on preallocation to avoid files becoming overly
> fragmented (even though preallocation itself can cause fragmentation in
> free disk space). But since fallocate doesn't support preallocation, the
> fragmentation issue is more pronounced. Counterintuitively, skipping busy
> groups actually boosts opportunities for file extent merging, which in turn
> reduces overall file fragmentation.
> 
> Referencing will-it-scale/fallocate2, I tested 64 processes each appending
> 4KB via fallocate to 64 separate files until they reached 1GB. This test
> specifically examines contention in block allocation, unlike fallocate2,
> it omits the contention between fallocate and truncate. Preliminary results
> are provided below; detailed scripts and full test outcomes are attached in
> the email footer.
> 
> ----------------------------------------------------------
>                      |       base      |      patched    |
> ---------------------|--------|--------|--------|--------|
> mb_optimize_scan     | linear |opt_scan| linear |opt_scan|
> ---------------------|--------|--------|--------|--------|
> bw(MiB/s)            | 217    | 219    | 5685   | 5670   |
> Avg. free extent size| 1943732| 1943728| 1439608| 1368328|
> Avg. extents per file| 261879 | 262039 | 744    | 2084   |
> Avg. size per extent | 4      | 4      | 1408   | 503    |
> Fragmentation score  | 100    | 100    | 2      | 6      |
> ----------------------------------------------------------

Hi Baokun,

Thanks for the info and data and apologies for being late, I caught a
viral last week :/ 

These numbers look pretty interesting and your explanation of why the
fragmentation is better makes sense. It is definitely a win-win then for 
performance and fragmentation!

> > Regardless the performance benefits are significant and I feel it is
> > good to have these patches.
> > 
> > I'll give my reviews individually as I'm still going through patch 2
> > However, I wanted to check on a couple things:
> Okay, thank you for your feedback.
> > 
> > 1. I believe you ran these in docker. Would you have any script etc open
> >     sourced that I can use to run some benchmarks on my end (and also
> > 	 understand your test setup).
> Yes, these two patches primarily mitigate contention between block
> allocations and between block allocation and release. The testing script
> can be referenced from the fio script mentioned earlier in the email
> footer. You can also add more truncate calls based on it.

Thanks for the scripts.

> > 2. I notice we are getting way less throughput in mb_optimize_scan? I
> >     wonder why that is the case. Do you have some data on that? Are your
> >     tests starting on an empty FS, maybe in that case linear scan works a
> >     bit better since almost all groups are empty. If so, what are the
> >     numbers like when we start with a fragmented FS?
> The throughput of mb_optimize_scan is indeed much lower, and we continue
> to optimize it, as mb_optimize_scan is the default mount option and
> performs better in scenarios with large volume disks and high space usage.
> 
> Disk space used is about 7%; mb_optimize_scan should perform better with
> less free space. However, this isn't the critical factor. The poor
> throughput here is due to the following reasons。
> 
> One reason is that mb_optimize_scan's list traversal is unordered and
> always selects the first group.
> 
> While traversing the list, holding a spin_lock prevents load_buddy, making
> direct use of ext4_lock_group impossible. This can lead to a "bouncing"
> scenario where spin_is_locked(grp_A) succeeds, but ext4_try_lock_group()
> fails, forcing the list traversal to repeatedly restart from grp_A.
> 
> In contrast, linear traversal directly uses ext4_try_lock_group(),
> avoiding this bouncing. Therefore, we need a lockless, ordered traversal
> to achieve linear-like efficiency.

Hmm, right the non ordered traversal has led to other issues as well in
the past.

> 
> Another reason is that opt_scan tends to allocate from groups that have
> just received freed blocks, causing it to constantly "jump around"
> between certain groups.
> 
> This leads to intense contention between allocation and release, and even
> between release events. In contrast, linear traversal always moves forward
> without revisiting groups, resulting in less contention between allocation
> and release.

By just received free blocks, you mean the blocks got freed in the group
right? I was under the impression that when we free blocks and the group's
largest order/ avg fragment changes, the group is added to the end of
the free fragment list/order list so it should be the last to be picked.
Is that not the case?

> 
> However, because linear involves more groups in allocation, journal
> becomes a bottleneck. If opt_scan first attempts to traverse block groups
> to the right from the target group in all lists, and then from index 0 to
> the left in all lists, competition between block groups would be
> significantly reduced.
> 
> To enable ordered traversal, we attempted to convert list_head to an
> ordered xarray. This ordering prevents "bouncing" during retries.
> Additionally, traversing all right-side groups before left-side groups
> significantly reduced contention. Performance improved from 10430 to 17730.

Do you maybe have some code you can share of this? 

> 
> However, xarray traversal introduces overhead; list_head group selection
> was O(1), while xarray becomes O(n log n). This results in a ~10%
> performance drop in single-process scenarios, and I'm not entirely sure if
> this trade-off is worthwhile. 🤔
> 
> Additionally, by attempting to merge before inserting in
> ext4_mb_free_metadata(), we can eliminate contention on sbi->s_md_lock
> during merges, resulting in roughly a 5% performance gain.
> > 
> >     - Or maybe it is that the lazyinit thread has not yet initialized all
> >     the buddies yet which means we have lesser BGs in the freefrag list
> >     or the order list used by faster CRs. Hence, if they are locked we
> >     are falling more to CR_GOAL_LEN_SLOW. To check if this is the case,
> >     one hack is to cat /proc/fs/ext4/<disk>/mb_groups (or something along
> >     the lines) before the benchmark, which forces init of all the group
> >     buddies thus populating all the lists used by mb_opt_scan. Maybe we
> >     can check if this gives better results.
> All groups are already initialized at the time of testing, and that's not
> where the problem lies.
> > 
> > 3. Also, how much IO are we doing here, are we filling the whole FS?
> > 
> In a single container, create a file, then repeatedly append 8KB using
> fallocate until the file reaches 1MB. After that, truncate the file to
> 0 and continue appending 8KB with fallocate. The 64 containers will
> occupy a maximum of 64MB of disk space in total, so they won't fill the
> entire file system.

Also, as per your theory, if we do similar experiments in a fragmented
FS we should see opt_scan perform better right? I'd like to test this as
well. I'll try to play with the scripts you have shared.

Thanks again for the detailed response and scripts!

Regards,
ojaswin

> 
> Cheers,
> Baokun
> 
> 
> ======================== test script ========================
> 
> #!/bin/bash
> 
> dir="/tmp/test"
> disk="/dev/sda"
> numjobs=64
> iodepth=128
> 
> mkdir -p $dir
> 
> for scan in 0 1 ; do
>     mkfs.ext4 -F -E lazy_itable_init=0,lazy_journal_init=0 -O orphan_file
> $disk
>     mount -o mb_optimize_scan=$scan $disk $dir
> 
>     fio -directory=$dir -direct=1 -iodepth ${iodepth} -thread -rw=write
> -ioengine=falloc -bs=4k -fallocate=none \
>         -size=1G -numjobs=${numjobs} -group_reporting -name=job1
> -cpus_allowed_policy=split -file_append=1
> 
>     e2freefrag $disk
>     e4defrag -c $dir # ** NOTE ** Without the patch, this could take 5-6
> hours.
>     filefrag ${dir}/job* | awk '{print $2}' | awk '{sum+=$1} END {print
> sum/NR}'
>     umount $dir
> done
> 

<snip>

