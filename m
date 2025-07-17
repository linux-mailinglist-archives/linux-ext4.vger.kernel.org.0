Return-Path: <linux-ext4+bounces-9035-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC28B08A4E
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 12:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309AE1AA2F35
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90962298CB6;
	Thu, 17 Jul 2025 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pOt1xFZV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D76D295DBA;
	Thu, 17 Jul 2025 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747012; cv=none; b=EjGjwntdQzhntcryM0rA2J/jc4MHe+++TtpiwTlJ2b198ajaJEloSv8Ts/OrlId4U6prfrPtMNnYX96Qu30NN7LBHrlnHOgxrjj9J0Pb50uHgyDQ5UoiTZmgxZ1Iz/PWK7S8YdCJRYGiFbfo+HCDF6VwfN4Qp+kxAIMzJcWJIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747012; c=relaxed/simple;
	bh=fM66syPDBDaGXozEXczdoyxzbBDgGN1br0Q5Pn9cP1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHtgPN/4nzgyEzGPIaUGeIYLRRcS1a2/dRAjLMbwU943mdUBChT1aED4NmxNyyD1RR1RbFNs11fzVRrpMeOTGatocEeCm5Ba2btox3RWgLRBJoQz1diOdbwJ9Y/M3Pj/kSJ8OIxGiko/lePoP+R0y4L+gN+heJcGnZhgShLl4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pOt1xFZV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H5qELY007702;
	Thu, 17 Jul 2025 10:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0CFBkZpd3OJObSfMTq/xvQJl1QNj8J
	fGuKu8YtLUZpg=; b=pOt1xFZVUxwg32jLjBdczRHWAkMb9pCngBryK40IMEyPsx
	l3UQJ+e/vUboPW7vQMUYPWTvpWc0PhT6jHsL6lFWyGA2+HbB/EnApcW6GFYN5Clb
	iTNPuMjs2KkWnsQYb5A2fVz2Drjgb76PI/lTSTCxu8YL28/Ygnw73OUuI0ukWSjh
	RZ7ipKx0k4Se+fPGmEK8tl8KtS2yKQzrFQjxSVs7uN1ZcDiuQMJRa3EjdluKVWEF
	zsqFBNRLv8mEw8HBWdbNYMGREYsmzQLnNBIpNLMyCPB6nQUVavfMXqVhI7mrEVHa
	WDLQdbjkc4QrK6Ljfbjw1T+/V1JncWgZauvsTIAg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmw4ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:09:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56H64uif021890;
	Thu, 17 Jul 2025 10:09:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r3bb35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:09:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HA9kOg58786170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 10:09:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34F102006E;
	Thu, 17 Jul 2025 10:09:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 361BD2006F;
	Thu, 17 Jul 2025 10:09:43 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.40])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Jul 2025 10:09:42 +0000 (GMT)
Date: Thu, 17 Jul 2025 15:39:40 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
        yi.zhang@huawei.com, yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH v3 01/17] ext4: add ext4_try_lock_group() to skip busy
 groups
Message-ID: <aHjL5J3Ui9VMZt2o@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-2-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714130327.1830534-2-libaokun1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d3hsKeZUeIe_zX55JxWI8zSE4AZ2VVNH
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=6878cbed cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=G4Sw1XTuHnxZOQXlz7YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: d3hsKeZUeIe_zX55JxWI8zSE4AZ2VVNH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA4NSBTYWx0ZWRfXzFogapu+5LWm /OY2AuZQwC8c6cBeUlZFlP1y/LRUkxHVM8OnpgNZYDure/yuBlIeG73A/FI0zwIxMDR0NP0F0LC 1T8Zww+7D0wxgxvS8oeeil9wl7vYRmakmDg2jlyvwIPD3lKahYm9i2wcbmRj9N4PMKU2fJfqcqU
 IJzCRf2Wl+b3Yhf5ezz0DEOMRqrtfG0vv8sAkbUFsMhfoW6bJXT5xy9zcwZSSmFJ0y2yq7FWo4D OmGlu4u5n2U/ozHFDvrj24DM3RfXMxaBfm16M0RpIbf4UEv5HTgdpdR88mEmxmjrGaOuvo3iAaC TUhGXW1rTicW+CG1sNcV+Vd2vlGw+c+qPSUcxAB0MVvaF4zhzIFAD3eMdfT1TQ9sxSPkUERJhkN
 0IA9QHoJO+ma4mu6X8NjtTkUMomfn3uhOo/fs7fGGmzzow/IjRxVw8fWypwsYNvOOsEQyQd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=565 malwarescore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170085

On Mon, Jul 14, 2025 at 09:03:11PM +0800, Baokun Li wrote:
> When ext4 allocates blocks, we used to just go through the block groups
> one by one to find a good one. But when there are tons of block groups
> (like hundreds of thousands or even millions) and not many have free space
> (meaning they're mostly full), it takes a really long time to check them
> all, and performance gets bad. So, we added the "mb_optimize_scan" mount
> option (which is on by default now). It keeps track of some group lists,
> so when we need a free block, we can just grab a likely group from the
> right list. This saves time and makes block allocation much faster.
> 
> But when multiple processes or containers are doing similar things, like
> constantly allocating 8k blocks, they all try to use the same block group
> in the same list. Even just two processes doing this can cut the IOPS in
> half. For example, one container might do 300,000 IOPS, but if you run two
> at the same time, the total is only 150,000.
> 
> Since we can already look at block groups in a non-linear way, the first
> and last groups in the same list are basically the same for finding a block
> right now. Therefore, add an ext4_try_lock_group() helper function to skip
> the current group when it is locked by another process, thereby avoiding
> contention with other processes. This helps ext4 make better use of having
> multiple block groups.
> 
> Also, to make sure we don't skip all the groups that have free space
> when allocating blocks, we won't try to skip busy groups anymore when
> ac_criteria is CR_ANY_FREE.
> 
> Performance test data follows:
> 
> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
> Observation: Average fallocate operations per container per second.
> 
> |CPU: Kunpeng 920   |          P80            |
> |Memory: 512GB      |-------------------------|
> |960GB SSD (0.5GB/s)| base  |    patched      |
> |-------------------|-------|-----------------|
> |mb_optimize_scan=0 | 2667  | 4821  (+80.7%)  |
> |mb_optimize_scan=1 | 2643  | 4784  (+81.0%)  |
> 
> |CPU: AMD 9654 * 2  |          P96            |
> |Memory: 1536GB     |-------------------------|
> |960GB SSD (1GB/s)  | base  |    patched      |
> |-------------------|-------|-----------------|
> |mb_optimize_scan=0 | 3450  | 15371 (+345%)   |
> |mb_optimize_scan=1 | 3209  | 6101  (+90.0%)  |
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Hey Baokun, I reviewed some of the patches in v2 but i think that was
very last moment so I'll add the comments in this series, dont mind the
copy paste :)

The patch itself looks good, thanks for the changes.

Feel free to add:

 Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin


