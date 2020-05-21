Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C11DC74D
	for <lists+linux-ext4@lfdr.de>; Thu, 21 May 2020 09:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgEUHEj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 May 2020 03:04:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbgEUHEi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 21 May 2020 03:04:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04L73sOx186309;
        Thu, 21 May 2020 03:04:38 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312c8qkvve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 03:04:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04L72e2W022546;
        Thu, 21 May 2020 07:04:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 313xas53vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 07:04:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04L74Xdh64028718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 07:04:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A01F52057;
        Thu, 21 May 2020 07:04:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.40.126])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AE06852051;
        Thu, 21 May 2020 07:04:32 +0000 (GMT)
Subject: Re: [PATCH 2/2] ext4: mballoc - limit scanning of uninitialized
 groups
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <48DC3E7A-AA4E-494D-A520-3D301FBC573B@whamcloud.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 21 May 2020 12:34:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <48DC3E7A-AA4E-494D-A520-3D301FBC573B@whamcloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200521070432.AE06852051@d06av21.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_04:2020-05-20,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210047
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 5/20/20 3:15 PM, Alex Zhuravlev wrote:
> cr=0 is supposed to be an optimization to save CPU cycles, but if
> buddy data (in memory) is not initialized then all this makes no
> sense as we have to do sync IO taking a lot of cycles.
> also, at cr=0 mballoc doesn't store any available chunk. cr=1 also
> skips groups using heuristic based on avg. fragment size. it's more
> useful to skip such groups and switch to cr=2 where groups will be
> scanned for available chunks.
> 
> The goal group is not skipped to prevent allocations in foreign groups,
> which can happen after mount while buddy data is still being populated.
> 
> using sparse image and dm-slow virtual device of 120TB was simulated.
> then the image was formatted and filled using debugfs to mark ~85% of
> available space as busy. the very first allocation w/o the patch could
> not complete in half an hour (according to vmstat it would take ~10-1
> hours). with the patch applied the allocation took ~20 seconds.
> 
> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
> Reviewed-by: Andreas Dilger <adilger@whamcloud.com>

This looks even better to me. Feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> 
>   fs/ext4/mballoc.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 30d5d97548c4..f719714862b5 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1877,6 +1877,21 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
>   	return 0;
>   }
>   
> +static inline int ext4_mb_uninit_on_disk(struct super_block *sb,
> +				    ext4_group_t group)
> +{
> +	struct ext4_group_desc *desc;
> +
> +	if (!ext4_has_group_desc_csum(sb))
> +		return 0;
> +
> +	desc = ext4_get_group_desc(sb, group, NULL);
> +	if (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))
> +		return 1;
> +
> +	return 0;
> +}
> +
>   /*
>    * The routine scans buddy structures (not bitmap!) from given order
>    * to max order and tries to find big enough chunk to satisfy the req
> @@ -2060,7 +2075,20 @@ static int ext4_mb_good_group(struct ext4_allocation_context *ac,
>   
>   	/* We only do this if the grp has never been initialized */
>   	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
> -		int ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
> +		int ret;
> +
> +		/* cr=0/1 is a very optimistic search to find large
> +		 * good chunks almost for free. if buddy data is
> +		 * not ready, then this optimization makes no sense.
> +		 * instead it leads to loading (synchronously) lots
> +		 * of groups and very slow allocations.
> +		 * but don't skip the goal group to keep blocks in
> +		 * the inode's group. */
> +
> +		if (cr < 2 && !ext4_mb_uninit_on_disk(ac->ac_sb, group) &&
> +		    ac->ac_g_ex.fe_group != group)
> +			return 0;
> +		ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
>   		if (ret)
>   			return ret;
>   	}
> 
