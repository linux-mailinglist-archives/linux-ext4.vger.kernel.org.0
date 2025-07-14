Return-Path: <linux-ext4+bounces-8973-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02075B0376E
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 08:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B4B16D9BF
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 06:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15F72288EE;
	Mon, 14 Jul 2025 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sAAjEShL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F03BE65;
	Mon, 14 Jul 2025 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476048; cv=none; b=RZp15AIdeJ0Uqsz+EsOTkkyg1Cq6ET4flc/Eq8/Atvx9RMbH+xvZiR2jqLPBf56NjqIOy+XmvG1xacmB+k2k+Zv/UEdU84bRKUFyQI4MAEUDwAWfSTWGRTt3eJQ9Y38bExOLGT5sQ7G0mKrOVmvjmbFFBaRQS/QQanII1yzCQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476048; c=relaxed/simple;
	bh=trVG2f4buu2+4oM+u59GKmTkk9pA0hGNzYqTR3u3D8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7EoMtePgDRCewharGtM08wSPnNLAQ7RGRRVfLQh/CuvL6Oi0Fh09rTPnIgjvSqU3PtdVBsQ6KkMDRFpvgafxDTNevg9Zxci534jpjGoheYpN5rCLIZhJNEp+ZdVN7TROjJ+QT1zAHzztaIWn6XAVef/vWI8CDKiDO3uMybYUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sAAjEShL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNtlhM002849;
	Mon, 14 Jul 2025 06:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5IEIgTExw2nSrI0cq1DIj0kuY0Gjph
	8sAgtMBsqnDCo=; b=sAAjEShLBljMyMl8i6KR2ou0URliyg/4y0i9Rm7jX64o9y
	FiSak/xLEz/F0FA0B3rMsewTdc5C4D+QD433F2I22tZtdbJGL4MkhALRyYV2maLw
	NgHF4BNS7PJMKi/XWD6csKAdru4+jq7UyQTdRg+DAIjTfZfVeG71NvMV3igPg5xa
	NaqTDs8KA/CwNK304E+9PL6mKmVuKzMyCiFP1RY6ERxZMbSpKTlJTCkYOAuGMo8h
	f/YTCDfC1MKp6L1Wha8/Jju+LUNCozDqsv2q4owbMK1YtZmuUtnHh7Mglnj4s1W/
	dqbp7ezMdKd/itCO/JhrjnJ6PaNFBeY3AJfLvNPQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cr3tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 06:53:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56E6kJXd021906;
	Mon, 14 Jul 2025 06:53:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r2vdmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 06:53:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56E6rngV50594296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 06:53:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92CE520043;
	Mon, 14 Jul 2025 06:53:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8FEB20040;
	Mon, 14 Jul 2025 06:53:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Jul 2025 06:53:47 +0000 (GMT)
Date: Mon, 14 Jul 2025 12:23:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 01/16] ext4: add ext4_try_lock_group() to skip busy
 groups
Message-ID: <aHSpeVzn1Bhxd2YO@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-2-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623073304.3275702-2-libaokun1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xoInn4410jql_Z_YsNNwsKoDP0BQeOmp
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=6874a980 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=G4Sw1XTuHnxZOQXlz7YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: xoInn4410jql_Z_YsNNwsKoDP0BQeOmp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzOSBTYWx0ZWRfX3JLgSIHK5sj6 atIty4JwCceSsDmWdNOD2Zyx1V00ddtv3lXEX3zMKe6KPld0GuZTqKssyuLGxGNYc4qK7z+wRtG 2jH4mZZxN7aXzFA5jFoaetHVtLrtG/d6+KEO2sJnobEhRfSQRQxf87D3pFGQSQlFwWq4DGaN78l
 1wiJvIowkLXA1QV1wQxYXpg5DpIEm5pw4hjWk6hy4iHZl5wPwxw/jTjgZPO6QREFHCD6RbTzjFb df7B9P+lz+DeDckBFdw7wxhEJINMvnVMTVvHe2Ah5/37bzEgCtVWkpO6jFdOYv8t5a8bWadCgFl QvcveCu3K/+b97fMWXx7WPeHg+BWHKuCMVOHAdgt/IDOkSQB30/QXXejqyA6TFCEEnUQC+yfE6Q
 GkxfwgyjLloMi1zLArZwunFVpYcDVmWBje3O4t1ZbetTAkV5SprCmZFBXX/LgKKC4iclB7d6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=693 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140039

On Mon, Jun 23, 2025 at 03:32:49PM +0800, Baokun Li wrote:
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
>                    | Kunpeng 920 / 512GB -P80| AMD 9654 / 1536GB -P96  |
>  Disk: 960GB SSD   |-------------------------|-------------------------|
>                    | base  |    patched      | base  |    patched      |
> -------------------|-------|-----------------|-------|-----------------|
> mb_optimize_scan=0 | 2667  | 4821  (+80.7%)  | 3450  | 15371 (+345%)   |
> mb_optimize_scan=1 | 2643  | 4784  (+81.0%)  | 3209  | 6101  (+90.0%)  |
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Hey Baokun, sorry I'm a bit late to the review, been caught up with a
few things last couple weeks.

The patch itself looks good, thanks for the changes.

Feel free to add:

 Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>


Regards,
ojaswin


