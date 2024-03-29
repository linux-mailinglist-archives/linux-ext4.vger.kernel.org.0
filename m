Return-Path: <linux-ext4+bounces-1776-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B8E891409
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 08:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC95B23083
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 07:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811253FBB6;
	Fri, 29 Mar 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="asHzqvwe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB693FB97;
	Fri, 29 Mar 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696468; cv=none; b=clXGAbRHRBAWt/lEwaFxNtGNs4S3Dj3htsEcDbUvFIlk7FI+inbrc86VVHGNOfj23ndM3UwaRREIiH0iOcscwGMtKJRfqYVOg1gWR4xt+bEcippFj/sBtvZiSAmuGjqWgIxmgKkfgQd/Y5RDmmUgKW0ER3jaiubAOJGqH7zJSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696468; c=relaxed/simple;
	bh=XwpcPuEhfNnZeIlXZpZM8WFDw8TjiTSemeZAA/NgeZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwtyD7h+Wmd4k56oaqV/rE6SZxVMmjmUM3sKWMBTGsY9DhHNWJPARQlNDCuHnZIpGV8i/XXq+idwfnbQgi4af8xguKDlZMgXubxTJVzTTIPz4xAH43tbmcx9Iad2W5vhgmJucryRWru1QclSZGQ1EO8YQDISCRND/ZP2dmNJf20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=asHzqvwe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42T6qls9025950;
	Fri, 29 Mar 2024 07:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=g/O51oeJGtQl1vH1UnX1c2dlOHF4t0y6H623R0jRn4c=;
 b=asHzqvwex1ok7qCXNJ/MzzD70HxZWsEOGOMAuYxttzkwaI8A9i4ik8bpFYxQLNHFW26z
 q3G0cLIU8tNMNbP6y/YEAYcHP7vH8Pz9bHzDIjat8fEVetED0cPQAXvTos3aKmB8lWN3
 oSjJ+R/bCD0UcLBmbNJ/e6zO5NDN7lbQj0Tw+UbePOz4Szxl0ZarHYfib3z/sRIu0YmB
 e13rSQtTGAs0EkAYXeb41QZoDN0GlgG/dIonYmuutLftXwQC7E/QZriUVZl/Os2ZEJ4I
 AnnR3vvfrE1uuqh3CGXitRws+RuY3GnSNq/6/WBKLV2et+zEg6p3R6qCkonKYTBh1ZB2 Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5rrng18x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:14:14 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42T7EDt5031473;
	Fri, 29 Mar 2024 07:14:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5rrng18v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:14:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42T65k56012975;
	Fri, 29 Mar 2024 07:14:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t12sh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:14:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42T7E8sv45809920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 07:14:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA6392004B;
	Fri, 29 Mar 2024 07:14:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 376912004D;
	Fri, 29 Mar 2024 07:14:07 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.115.153])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 07:14:07 +0000 (GMT)
Date: Fri, 29 Mar 2024 12:44:04 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, ritesh.list@gmail.com
Subject: Re: [PATCH 5/5] ext4: expand next_linear_group to remove repeat
 check for linear scan.
Message-ID: <ZgZqPJbEBG09dzSh@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
 <20240326213823.528302-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326213823.528302-6-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eyKq2AJ_nUi955UZeqJaSicD4fLNOCZu
X-Proofpoint-ORIG-GUID: ezamj0hqSWa2mObJbOyAsOLXMamtGcx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290060

On Wed, Mar 27, 2024 at 05:38:23AM +0800, Kemeng Shi wrote:
> Expand next_linear_group to remove repat check for linear scan.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 37 ++++++-------------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 0f8a34513bf6..561780a274cd 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1075,31 +1075,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
>   return 1;
>  }
>  
> -/*
> - * Return next linear group for allocation. If linear traversal should not be
> - * performed, this function just returns the same group
> - */
> -static ext4_group_t
> -next_linear_group(struct ext4_allocation_context *ac, ext4_group_t group,
> -     ext4_group_t ngroups)
> -{
> - if (!should_optimize_scan(ac))
> -   goto inc_and_return;
> -
> - if (ac->ac_groups_linear_remaining) {
> -   ac->ac_groups_linear_remaining--;
> -   goto inc_and_return;
> - }
> -
> - return group;
> -inc_and_return:
> - /*
> -  * Artificially restricted ngroups for non-extent
> -  * files makes group > ngroups possible on first loop.
> -  */
> - return group + 1 >= ngroups ? 0 : group + 1;
> -}
> -
>  /*
>   * ext4_mb_choose_next_group: choose next group for allocation.
>   *
> @@ -1118,12 +1093,12 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  {
>   *new_cr = ac->ac_criteria;
>  
> - if (!should_optimize_scan(ac) || ac->ac_groups_linear_remaining) {
> -   *group = next_linear_group(ac, *group, ngroups);
> -   return;
> - }
> -
> - if (*new_cr == CR_POWER2_ALIGNED) {
> + if (!should_optimize_scan(ac))
> +   *group = *group + 1 >= ngroups ? 0 : *group + 1;
> + else if (ac->ac_groups_linear_remaining) {
> +   ac->ac_groups_linear_remaining--;
> +   *group = *group + 1 >= ngroups ? 0 : *group + 1;
> + } else if (*new_cr == CR_POWER2_ALIGNED) {


Hi Kemeng, thanks for the cleanups

I feel that open coding this logic and having a single if for linear scan and
non linear scan cases is making the code a bit more harder to follow and we are
losing some comments as well.

Since our main aim is to avoid the double checking, maybe we can keep
next_linear_group() strictly for getting the next linear group correctly and
rest of the checks outside. So something like:

static ext4_group_t
next_linear_group(ext4_group_t group, ext4_group_t ngroups)
{

  /*
   * Artificially restricted ngroups for non-extent
   * files makes group > ngroups possible on first loop.
   */
  return group + 1 >= ngroups ? 0 : group + 1;
}

static void ext4_mb_choose_next_group(...)
{
  ...

  /*
   * Fallback to linear scan when optimized scanning is disabled
   */
  if (!should_optimize_scan(ac)) {
    *group = next_linear_group(*group, ngroups);
    return;
  }

  /*
   * Optimized scanning can return non adjacent groups which can cause
   * seek overhead for rotational disks. So try few linear groups before 
   * trying optimized scan.
   */
  if (ac->ac_groups_linear_remaining) {
    *group = next_linear_group(*group, ngroups);
    ac->ac_groups_linear_remaining--;
    return;
  }
  
  ...
}

Let me know your thought. 

Regards,
ojaswin

>     ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group);
>   } else if (*new_cr == CR_GOAL_LEN_FAST) {
>     ext4_mb_choose_next_group_goal_fast(ac, new_cr, group);
> -- 
> 2.30.0
> 




