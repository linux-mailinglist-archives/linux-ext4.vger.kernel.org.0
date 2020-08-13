Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223C4243C56
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 17:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgHMPTF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 11:19:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbgHMPTE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Aug 2020 11:19:04 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DF3cCH053560;
        Thu, 13 Aug 2020 11:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=of7Q//GabpaNvdfBC7bYVf0IO/XXxjK5Y6fZjYg2cfs=;
 b=FbpjWZLpRXDdJw3AEhqfSosmZbYSItthZdko39si/5I/bx5rJnXZ7f7h7+ZLp82Ur9DS
 WluXTKbkskAd5dVOjhUVXOexYV5Rh58Fxki2sTTXNtSxqq7IEe7cB/WgBYpmmz9xZuc4
 uacbhlFdjBlaGxyCLM6Knuo9GRKufsgeSdNMe/JQ9pZ88quKSfH6JL6grl/C65vipdXh
 J2KlbDbgt/PWdcTNO6BNRD/yybSLmA9R/YJmY9zlb8PN+yPAG1GPmCrSQ+T0CI+gqatQ
 BFm5xlS2QeO41X9Ged/y+rZd9uL5/t+R4CzzJ78xA5Yhs77g9VT1ojjcrOQYu5RYiNwp Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w6ttj20s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:18:59 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DFCIFm090661;
        Thu, 13 Aug 2020 11:18:57 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w6ttj1yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:18:57 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DFFAS7017298;
        Thu, 13 Aug 2020 15:18:55 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 32skp8dp4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 15:18:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DFIqLF28311842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 15:18:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3256BA4057;
        Thu, 13 Aug 2020 15:18:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E455A404D;
        Thu, 13 Aug 2020 15:18:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Aug 2020 15:18:51 +0000 (GMT)
Subject: Re: [PATCH] ext4: put grp related checks into ext4_mb_good_group()
To:     brookxu <brookxu.cn@gmail.com>, adilger.kernel@dilger.ca,
        tytso@mit.edu, linux-ext4@vger.kernel.org
References: <a53fe585-2b31-3a2e-f3eb-edc6f80ad85f@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 13 Aug 2020 20:48:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a53fe585-2b31-3a2e-f3eb-edc6f80ad85f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200813151851.5E455A404D@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_13:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=2
 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=903
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130110
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/7/20 7:31 PM, brookxu wrote:
> We will make these judgments in ext4_mb_good_group(), maybe there
> is no need to repeat judgments here.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Nack. This could essentially cause performance issues.
But then maybe we should add a comment saying these extra checks are
intentionally done here without explicit ext4_lock_group() for
performance optimizations.

-ritesh



> ---
>   fs/ext4/mballoc.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4304113..84871f7 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2178,21 +2178,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>   	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
>   	struct super_block *sb = ac->ac_sb;
>   	bool should_lock = ac->ac_flags & EXT4_MB_STRICT_CHECK;
> -	ext4_grpblk_t free;
>   	int ret = 0;
> 
> -	if (should_lock)
> -		ext4_lock_group(sb, group);
> -	free = grp->bb_free;
> -	if (free == 0)
> -		goto out;
> -	if (cr <= 2 && free < ac->ac_g_ex.fe_len)
> -		goto out;
> -	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
> -		goto out;
> -	if (should_lock)
> -		ext4_unlock_group(sb, group);
> -
>   	/* We only do this if the grp has never been initialized */
>   	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
>   		ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
> @@ -2202,8 +2189,9 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
> 
>   	if (should_lock)
>   		ext4_lock_group(sb, group);
> +
>   	ret = ext4_mb_good_group(ac, group, cr);
> -out:
> +
>   	if (should_lock)
>   		ext4_unlock_group(sb, group);
>   	return ret;
> 
