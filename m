Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577151D2C1D
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgENKET (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 06:04:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725952AbgENKES (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 May 2020 06:04:18 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EA1NXp093468;
        Thu, 14 May 2020 06:04:17 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3112s3t4tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 06:04:16 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04E9xwqM008828;
        Thu, 14 May 2020 10:04:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3100ubhcme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:04:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04EA4C9W35520764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 10:04:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA040A405B;
        Thu, 14 May 2020 10:04:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1A15A405C;
        Thu, 14 May 2020 10:04:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.39.201])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 May 2020 10:04:11 +0000 (GMT)
Subject: Re: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <0B6BF408-EDF7-4363-80CD-BDA0136BF62C@whamcloud.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 14 May 2020 15:34:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0B6BF408-EDF7-4363-80CD-BDA0136BF62C@whamcloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200514100411.D1A15A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 cotscore=-2147483648 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140086
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 4/27/20 9:33 AM, Alex Zhuravlev wrote:
> Hi, yet another patch.
Not needed in a commit msg.


> 
> cr=0 is supposed to be an optimization to save CPU cycles, but if buddy data (in memory)
> is not initialized then all this makes no sense as we have to do sync IO taking a lot of cycles.
> also, at cr=0 mballoc doesn't store any avaibale chunk. cr=1 also skips groups using heuristic
/s/avaibale/available/

> based on avg. fragment size. it's more useful to skip such groups and switch to cr=2 where
> groups will be scanned for available chunks.
> 
> using sparse image and dm-slow virtual device of 120TB was simulated. then the image was
> formatted and filled using debugfs to mark ~85% of available space as busy. mount process w/o
> the patch couldn't complete in half an hour (according to vmstat it would take ~10-11 hours).
> with the patch applied mount took ~20 seconds.

I guess what we should edit the commit msg to explain that it is not the
mount process but the very first write whose performance is improved via
this patch.


> 
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-12988

Not sure if we need this.

> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
> Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
> ---
>   fs/ext4/mballoc.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e84c298e739b..83e3e6ab1240 100644
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
> @@ -2060,7 +2075,15 @@ static int ext4_mb_good_group(struct ext4_allocation_context *ac,
>   
>   	/* We only do this if the grp has never been initialized */
>   	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
> -		int ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
> +		int ret;
> +
> +		/* cr=0/1 is a very optimistic search to find large
> +		 * good chunks almost for free. if buddy data is
> +		 * not ready, then this optimization makes no sense */

I guess it will be also helpful to mention a comment related to the
discussion that we had on why this should be ok to skip those groups.
Because this could result into we skipping the group which is closer to
our inode. I somehow couldn't recollect it completely.


> +
> +		if (cr < 2 && !ext4_mb_uninit_on_disk(ac->ac_sb, group))
> +			return 0;
> +		ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
>   		if (ret)
>   			return ret;
>   	}
> 
