Return-Path: <linux-ext4+bounces-8207-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0710AC6C4F
	for <lists+linux-ext4@lfdr.de>; Wed, 28 May 2025 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35E77A28D4
	for <lists+linux-ext4@lfdr.de>; Wed, 28 May 2025 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DDE28B4FA;
	Wed, 28 May 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qadhF+PL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D8288C8C;
	Wed, 28 May 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444033; cv=none; b=thSZXvUVjvvF++hUugczw6uNxH1vSDRUiwOv7aRZLgnW8WgnxJKaMpmrXhRRlHdJIiqvkT9qQ4dPBQyPxNY/bz6+S8pbjuslavMmpnacWxuqsQUZla8PGz3HJt38/ZwdOYxW9YRt9c3D/ydzE9jz6LtP3BCQygLF25eU3pUxq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444033; c=relaxed/simple;
	bh=lFDV1HaeUob008ZddkZRHixO8/o/65lcZVfKDJi4TjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4+1snETZ7rpLf8WoWwjEs98CjjgWbC1Axsi1t55GPP/zcX92fZfKe2DejxYyQ5b0AZYmAJewUgOqM2sX7Z1ivMzSsSRxz4cm7CrdolqjSAV+eCoC1z4vfcEuxMKb54+MOBeD9A5ASkPZ1IJ152DWg2Ph8XLpWTSGawTskf4xVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qadhF+PL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9XOR032017;
	Wed, 28 May 2025 14:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=C+Ax56K/8glZJmSH+KSxWGDGC6oik9
	dHEUVf8/VFNLg=; b=qadhF+PLwysgEZYOoIUKp8ZxmQfyZULiZB8WGRrq18v9a0
	pzQi8ZD9ORDbTJJRJzoGRUGpSSiUNC9jquapZxvmH8B0rqGX50M1+LqOYaAA+FNU
	26d6ODgWX55VmQWLFqMOOCc6oPsCHmpnzo1v2XcUPuyqNdgVPkqX2S7BU998yerX
	M4JJSKDWZPB27WrJzxhiBf1y+GGf2/61jdj2rcP0uGagZ5MDPjr8vW8JuWVaUTIV
	ImUTootbcsqdfo8IiASP53G/szXa+VmUi7iMCXe/Jp6vJGV9z8EPOGwc1I7+TCmP
	R4Cjpe9hF4oBHEUatWe/GCV9iMbVjHCM72lplFIw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40jr8k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 14:53:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SAecxA021326;
	Wed, 28 May 2025 14:53:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46utnmqreh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 14:53:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SErQfB52232568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 14:53:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8373120040;
	Wed, 28 May 2025 14:53:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56D912004B;
	Wed, 28 May 2025 14:53:22 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.18.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 14:53:22 +0000 (GMT)
Date: Wed, 28 May 2025 20:23:15 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 0/4] ext4: better scalability for ext4 block allocation
Message-ID: <aDchmYDc_OOAu2yC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523085821.1329392-1-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SdL3duRu c=1 sm=1 tr=0 ts=68372369 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=rC1FfmAkVqhJs6Hui7oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: qxy6T5DMMWDnVa8xMLTdHn_p_De3-cJ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEyNyBTYWx0ZWRfX8V4UXs5k8tO6 OtIu1brpWBcDIXyReUW9V8cKeKqERrjcXIOkkNF1tsYryGnynWrNl5S6P4ot7mWJ3rM+SQ92KFK hPPy4Ar9VjfDbHp7GVDd4EuAtEi+GcfDddnT4edOmxAKpGAuI0X5zG4TKK3lOcGv1ORwC9N0zYD
 HDAvLXCMX1W7ZTgjG0sknTk7L1lgRs6IrwL3eWb6/0w8TloXmyhpSDxP++cazECD9W3Eq+nupOq /ebeZc0nYQ13Oi6VWaXyEWNtaWjD+Z+xQwlamQIqNw2zsxiXOvsRioZRHFWIALcvXogwTp47Yey yhvLgLpI6ohxFx/NmmsCDEN2EK+OdTWsNMXphdKwlboqXqY1WjJkC5NOqAJ+iCtSwgEqcOekUdb
 3YCl1mYhxdl5uX4GPPNy8+aHjTlx6J9XOlMRbmujA9A+BIdT5gi71WmVa8A1umb1V1tRGzvq
X-Proofpoint-ORIG-GUID: qxy6T5DMMWDnVa8xMLTdHn_p_De3-cJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=732 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280127

On Fri, May 23, 2025 at 04:58:17PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Since servers have more and more CPUs, and we're running more containers
> on them, we've been using will-it-scale to test how well ext4 scales. The
> fallocate2 test (append 8KB to 1MB, truncate to 0, repeat) run concurrently
> on 64 containers revealed significant contention in block allocation/free,
> leading to much lower aggregate fallocate OPS compared to a single
> container (see below).
> 
>    1   |    2   |    4   |    8   |   16   |   32   |   64
> -------|--------|--------|--------|--------|--------|-------
> 295287 | 70665  | 33865  | 19387  | 10104  |  5588  |  3588
> 
> The main bottleneck was the ext4_lock_group(), which both block allocation
> and free fought over. While the block group for block free is fixed and
> unoptimizable, the block group for allocation is selectable. Consequently,
> the ext4_try_lock_group() helper function was added to avoid contention on
> busy groups, and you can see more in Patch 1.
> 
> After we fixed the ext4_lock_group bottleneck, another one showed up:
> s_md_lock. This lock protects different data when allocating and freeing
> blocks. We got rid of the s_md_lock call in block allocation by making
> stream allocation work per inode instead of globally. You can find more
> details in Patch 2.
> 
> Patches 3 and 4 are just some minor cleanups.
> 
> Performance test data follows:
> 
> CPU: HUAWEI Kunpeng 920
> Memory: 480GB
> Disk: 480GB SSD SATA 3.2
> Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
>  Observation: Average fallocate operations per container per second.

> 
> |--------|--------|--------|--------|--------|--------|--------|--------|
> |    -   |    1   |    2   |    4   |    8   |   16   |   32   |   64   |
> |--------|--------|--------|--------|--------|--------|--------|--------|
> |  base  | 295287 | 70665  | 33865  | 19387  | 10104  |  5588  |  3588  |
> |--------|--------|--------|--------|--------|--------|--------|--------|
> | linear | 286328 | 123102 | 119542 | 90653  | 60344  | 35302  | 23280  |
> |        | -3.0%  | 74.20% | 252.9% | 367.5% | 497.2% | 531.6% | 548.7% |
> |--------|--------|--------|--------|--------|--------|--------|--------|
> |mb_optim| 292498 | 133305 | 103069 | 61727  | 29702  | 16845  | 10430  |
> |ize_scan| -0.9%  | 88.64% | 204.3% | 218.3% | 193.9% | 201.4% | 190.6% |
> |--------|--------|--------|--------|--------|--------|--------|--------|

Hey Baokun, nice improvements! The proposed changes make sense to me,
however I suspect the performance improvements may come at a cost of
slight increase in fragmentation, which might affect rotational disks
especially. Maybe comparing e2freefrag numbers with and without the
patches might give a better insight into this.

Regardless the performance benefits are significant and I feel it is
good to have these patches.

I'll give my reviews individually as I'm still going through patch 2
However, I wanted to check on a couple things:

1. I believe you ran these in docker. Would you have any script etc open
   sourced that I can use to run some benchmarks on my end (and also
	 understand your test setup).

2. I notice we are getting way less throughput in mb_optimize_scan? I
   wonder why that is the case. Do you have some data on that? Are your
   tests starting on an empty FS, maybe in that case linear scan works a 
   bit better since almost all groups are empty. If so, what are the
   numbers like when we start with a fragmented FS?

   - Or maybe it is that the lazyinit thread has not yet initialized all
   the buddies yet which means we have lesser BGs in the freefrag list
   or the order list used by faster CRs. Hence, if they are locked we
   are falling more to CR_GOAL_LEN_SLOW. To check if this is the case,
   one hack is to cat /proc/fs/ext4/<disk>/mb_groups (or something along
   the lines) before the benchmark, which forces init of all the group
   buddies thus populating all the lists used by mb_opt_scan. Maybe we
   can check if this gives better results.

3. Also, how much IO are we doing here, are we filling the whole FS?

Regards,
ojaswin

