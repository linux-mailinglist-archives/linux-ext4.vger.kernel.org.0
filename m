Return-Path: <linux-ext4+bounces-3445-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4FF93BE4C
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 11:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308791C21225
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 09:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BE71974EA;
	Thu, 25 Jul 2024 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AMhmQEFx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801EB1CD2D;
	Thu, 25 Jul 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898176; cv=none; b=AbVEGGwGsBNlpBLWwkxb3f2rwJCJZqk/WFEdpiv7fxAjhqQVLt/mSM/3wrvVM3wLGMfaeFc+5Uxt2E7dTi/3DD5PLTS9XZSf/vijmMxcW+QTIhCwpkCzQldgoEBUDN6eN2pWX3AjtJYeoDYmmIQE4f4sACvf4atWJK/uVyFeOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898176; c=relaxed/simple;
	bh=KOwYPG6KdLY1A94If6IRJFRTJ9cZDJcFgEsHgnfJkUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oIYUQO0nWAfPn5466dIxMPCUwkQoc3GozaSiUuLmrBzHu9Tro8NI3OqVgbt2aEtK++pCIUHE/5nLRD115fZ4T7M2q5haX6Koi/9MhRMbrepB1mmbAbgW2If/zPeCOZpOT3oaEqJ/WgV3+yJNevxon8MrXhgWi8lF6pY2TFXTAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AMhmQEFx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P8TpES009865;
	Thu, 25 Jul 2024 09:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=XTAaGSjeTVV+VGP8FROU4NHvexX
	hq7wOz0ps4khYi2A=; b=AMhmQEFxPjz3xfInQ4R1zVencCbB/h6JMd+z25OTBB0
	jqUYCtI6YVLMxKeWdvIHSnw52r1BszDF8ZHSj4mhTAh8YGJ0z/VMTn7TsJsfZuiI
	iT9aZeWWqKn6pWxkAW94vgYarJsrdR7ehcGxWw4rw2bgc2cn3bJng61VmzQStjld
	fjy87bjNjGxs8c5CrvmwMPldW8FjxEpAB+GUwL4yMkkK/Zbvm/h0LnTy4BJyniEU
	6SHS4mR/IcUW2/3lti4DUP9gkA6yX1n/JF2i3tq3Af0eKn1a7gdxedop40S+awpr
	pKaKAH2OcjhzQBLku1w1rtvuGpuj2CD9pZAWUa38G1w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kk8382x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 09:02:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46P92Orn002752;
	Thu, 25 Jul 2024 09:02:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kk8382wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 09:02:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46P6OPno006165;
	Thu, 25 Jul 2024 09:02:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2pmumy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 09:02:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46P92J5a23790232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 09:02:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A89B020040;
	Thu, 25 Jul 2024 09:02:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB9D120043;
	Thu, 25 Jul 2024 09:02:17 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 25 Jul 2024 09:02:17 +0000 (GMT)
Date: Thu, 25 Jul 2024 14:32:15 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 00/20] ext4: some bugfixes and cleanups for ext4 extents
 path
Message-ID: <ZqIUl5CcULl8shgf@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-1-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aSmtnw9END0q9d-noWIyH65vk8Nm7Cqp
X-Proofpoint-ORIG-GUID: e04Dqu9_ZzxOtxjdi8zZ-H7orUWrNefK
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_09,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=475 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250058

On Wed, Jul 10, 2024 at 12:06:34PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Hi all!
> 
> This patch series is a hardening of ext4 extents path related code.
> The following is a brief overview of the patches, see the patches for
> more details.
> 
> Patch 1-2: Refactor ext4_ext_rm_idx() as suggested by Jan, and add
> appropriate error handling branches to ext4_ext_rm_idx() and
> ext4_ext_correct_indexes() to avoid inconsistent extents tree.
>  PS: This comes from the previous work of my colleague zhanchengbin
>  (see link), who is no longer in charge of these and I have taken over.
>  Link: https://lore.kernel.org/r/20230213080514.535568-3-zhanchengbin1@huawei.com/
> 
> Patch 3-4: Fix an issue that caused p_bh to be released twice if it wasn't
> set to NULL after path->p_bh was released. And add a helper function after
> the quick fix to prevent this from happening again.
> 
> Patch 5-7: Quick fixes for use-after-free and double-free problems caused
> by mixing path(pointer to an extent path) and ppath(pointer to an extent
> path pointer).
> 
> Patch 8-19: Now the use of path and ppath is so confusing that we can
> trigger use-after-free or double-free by accessing a stale pointer, or
> we can get a memory leak by forgetting to update ppath. And it's very
> difficult to read the code. So to make the code more readable, get rid
> of ppath and pass path between functions uniformly to avoid these risks.
> 
> Patch 20: Reduces the consumption of unnecessary memory operations by
> avoiding repetitive allocation and release paths.
> 
> "kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.
> 
> Comments and questions are, as always, welcome.
> Please let me know what you think.
> 
> Thanks,
> Baokun
> 
> Baokun Li (20):
>   ext4: refactor ext4_ext_rm_idx() to index 'path'
>   ext4: prevent partial update of the extents path
>   ext4: fix double brelse() the buffer of the extents path
>   ext4: add new ext4_ext_path_brelse() helper
>   ext4: fix slab-use-after-free in ext4_split_extent_at()
>   ext4: avoid use-after-free in ext4_ext_show_leaf()
>   ext4: drop ppath from ext4_ext_replay_update_ex() to avoid double-free
>   ext4: get rid of ppath in ext4_find_extent()
>   ext4: get rid of ppath in get_ext_path()
>   ext4: get rid of ppath in ext4_ext_create_new_leaf()
>   ext4: get rid of ppath in ext4_ext_insert_extent()
>   ext4: get rid of ppath in ext4_split_extent_at()
>   ext4: get rid of ppath in ext4_force_split_extent_at()
>   ext4: get rid of ppath in ext4_split_extent()
>   ext4: get rid of ppath in ext4_split_convert_extents()
>   ext4: get rid of ppath in ext4_convert_unwritten_extents_endio()
>   ext4: get rid of ppath in ext4_ext_convert_to_initialized()
>   ext4: get rid of ppath in ext4_ext_handle_unwritten_extents()
>   ext4: get rid of ppath in convert_initialized_extent()
>   ext4: avoid unnecessary extent path frees and allocations
> 
>  fs/ext4/ext4.h        |   9 +-
>  fs/ext4/extents.c     | 746 +++++++++++++++++++++++-------------------
>  fs/ext4/fast_commit.c |  17 +-
>  fs/ext4/migrate.c     |   5 +-
>  fs/ext4/move_extent.c |  36 +-
>  5 files changed, 439 insertions(+), 374 deletions(-)
> 
> -- 
> 2.39.2

Tested kvm-xfstests auto on Powerpc with 4k, 64k and adv and no
new regressions are seen.

Feel free to add:

Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
Ojaswin

