Return-Path: <linux-ext4+bounces-666-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F5823BF4
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 06:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAD9285A9C
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 05:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EF918C3D;
	Thu,  4 Jan 2024 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dU2fAWE0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDC918EBD;
	Thu,  4 Jan 2024 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4045AW5g003555;
	Thu, 4 Jan 2024 05:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=LYjP6l6ccwWyulGOSKOxb1lXvRXMy12sfK4tBYthV8k=;
 b=dU2fAWE00B74zsckVxAXa6hTRfeJfJjPmEt+BhoO0RbTgVgC34ez2pze8Bu3IdTx5KJ0
 eHMzePHpHjinHv9MqzAj5NA7g9tucfkGrtSR6YMsUW+ybOUA+dCV/kFm0YSHkz8htv0u
 GauVJUlpf09pqm5ekO1OmW8R+YCCNtPZkH7mboOI1vRS9BYAzDQYhWPz54Kcms8P3Ih9
 /Tf6+H18cBYoMAjb6lKnkvAhu1jwZvYuO3HShgoU4HKS7eUKkOIOJfxu1318QXs0Oo5g
 cNUroxkbXEg8p7yZuulq1prsqnl1oQEdCXd7W8TfvSOhlr0G5oPMzOKkaHNEg7PU6APj LA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdhg38w2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:57:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40437dsq019309;
	Thu, 4 Jan 2024 05:57:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30sppjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:57:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4045vq3124904420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 05:57:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 634182004B;
	Thu,  4 Jan 2024 05:57:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC29520040;
	Thu,  4 Jan 2024 05:57:50 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jan 2024 05:57:50 +0000 (GMT)
Date: Thu, 4 Jan 2024 11:27:47 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] ext4: remove unused parameter group in
 ext4_mb_choose_next_group_*()
Message-ID: <ZZZI2yTyAXs3gIzL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240103102821.448134-1-shikemeng@huaweicloud.com>
 <20240103102821.448134-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103102821.448134-3-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8dnK-ZWpIo9dbZCmBmeHrOhEg4RCg4tA
X-Proofpoint-ORIG-GUID: 8dnK-ZWpIo9dbZCmBmeHrOhEg4RCg4tA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=844 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040040

On Wed, Jan 03, 2024 at 06:28:14PM +0800, Kemeng Shi wrote:
> Remove unused parameter group in ext4_mb_choose_next_group_*().

Hey Kemeng, 

Just a small thing, the parameter we are removing is "ngroups" rather
than "group" so maybe fix that in the commit message. 

Other than that looks good, feel free to add

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/mballoc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9f9b8dd06..765b62729 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -870,7 +870,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>   * cr level needs an update.
>   */
>  static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context *ac,
> -			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> +			enum criteria *new_cr, ext4_group_t *group)
>  {

