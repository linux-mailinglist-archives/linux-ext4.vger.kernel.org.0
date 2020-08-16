Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF4245617
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Aug 2020 07:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgHPFZ6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Aug 2020 01:25:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730042AbgHPFZ6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 16 Aug 2020 01:25:58 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07G51VvH143665;
        Sun, 16 Aug 2020 01:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=6+42SENjtXeP411A1lHI3bOQ7qxYGbOgtVKZPhhsY2M=;
 b=AWEqLyzEMFu/Iz+QuMOYzoxBTGdxZWtBKEUaVf2o+SLuvF4oFLwWYdsXf/1zdW2mDEKD
 jdRCI63jdb4bNxkEWigIbHBwr9H7SDChD5mFpJhPJnW64NegYhwNEA4E644LjNE6Iatc
 J5USnlnn2qHnO9rzLZzT4jnB9i1RR/XNQ38Em76T0sYSa1pM+YX06Xac1uZi0PxrQve3
 2O65DLtOTNPxztA742l0seG02/xreaHntE3MHt1CMMIWmQ/85aJ1Zx6yRQcuHA6EoFek
 aUc4cfyXb38PeLPiLjDo+3Sgjv4hxrRfotAceoFemFphYVCDEzJrWMCAwSbJO50fmR+1 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32xsubdcx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 01:25:54 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07G51Pr9143214;
        Sun, 16 Aug 2020 01:25:54 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32xsubdcwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 01:25:54 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07G5P9wj018455;
        Sun, 16 Aug 2020 05:25:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 32x7b7gk2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 05:25:52 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07G5Po3w7864594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Aug 2020 05:25:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A89F11C050;
        Sun, 16 Aug 2020 05:25:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FF6811C04C;
        Sun, 16 Aug 2020 05:25:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Aug 2020 05:25:49 +0000 (GMT)
Subject: Re: [PATCH v3] ext4: fix log printing of ext4_mb_regular_allocator()
To:     brookxu <brookxu.cn@gmail.com>, adilger.kernel@dilger.ca,
        tytso@mit.edu, linux-ext4@vger.kernel.org
References: <0a165ac0-1912-aebd-8a0d-b42e7cd1aea1@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sun, 16 Aug 2020 10:55:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0a165ac0-1912-aebd-8a0d-b42e7cd1aea1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <20200816052549.6FF6811C04C@d06av25.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-16_01:2020-08-14,2020-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008160038
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/15/20 5:40 AM, brookxu wrote:
> Fix log printing of ext4_mb_regular_allocator()，it may be an
> unintentional behavior.
> 
> V3:
> It may be better to add a comma between start and len, which is
> convenient for script processing.
> 
> V2:
> Add more valuable information, such as group, start, len, lost.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

LGTM, please feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/mballoc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c0a331e..70b110f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2218,6 +2218,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>   	struct ext4_sb_info *sbi;
>   	struct super_block *sb;
>   	struct ext4_buddy e4b;
> +	unsigned int lost;
>   
>   	sb = ac->ac_sb;
>   	sbi = EXT4_SB(sb);
> @@ -2341,22 +2342,24 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>   		 * We've been searching too long. Let's try to allocate
>   		 * the best chunk we've found so far
>   		 */
> -
>   		ext4_mb_try_best_found(ac, &e4b);
>   		if (ac->ac_status != AC_STATUS_FOUND) {
>   			/*
>   			 * Someone more lucky has already allocated it.
>   			 * The only thing we can do is just take first
>   			 * found block(s)
> -			printk(KERN_DEBUG "EXT4-fs: someone won our chunk\n");
>   			 */
> +			lost = (unsigned int)atomic_inc_return(&sbi->s_mb_lost_chunks);
> +			mb_debug(sb, "lost chunk, group: %u, start: %d, len: %d, lost: %u\n",
> +				 ac->ac_b_ex.fe_group, ac->ac_b_ex.fe_start,
> +				 ac->ac_b_ex.fe_len, lost);
> +
>   			ac->ac_b_ex.fe_group = 0;
>   			ac->ac_b_ex.fe_start = 0;
>   			ac->ac_b_ex.fe_len = 0;
>   			ac->ac_status = AC_STATUS_CONTINUE;
>   			ac->ac_flags |= EXT4_MB_HINT_FIRST;
>   			cr = 3;
> -			atomic_inc(&sbi->s_mb_lost_chunks);
>   			goto repeat;
>   		}
>   	}
> 
