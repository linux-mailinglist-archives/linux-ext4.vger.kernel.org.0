Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0926F8F4
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Sep 2020 11:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIRJIY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Sep 2020 05:08:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbgIRJIX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Sep 2020 05:08:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08I91aON066744;
        Fri, 18 Sep 2020 05:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AlpqPUoL3lKm51GOa5/QnsGNy2HPGd1wqlIthVBX2tM=;
 b=YQbqYIQDFYwaqt3deVDmrFY2n48w/2Rktd9N9AM5B7DMr3yi2fXEAThxe7lSLE5GTDZg
 LL6x/Lq+ocX/M16qAYpHoHZeTm+5JU9MBbFKjjK9KZh27pxJ41J1fc3RSW3FLgfbxPAm
 m4DyNwv21bspQXqbf3t82heBugMu657T6U3lzY7VGTtKYz6t2RDFAxJLFVMXWh4xBivH
 LZmP4jgzkNWRDiLIJAkFEaTniutyRFVKOycu01vKc1GZ11whaXmwNK2H1KvCXX7Js1vE
 1GJ1zAb0Aufz31x+EqwAdIZZKwWQDUijIZs6Et0PjkYMxgTi8+8jFGP+NBnSd3uUrblq wg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33mshu10q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 05:08:11 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08I91bqx032134;
        Fri, 18 Sep 2020 09:07:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 33k9geaugr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 09:07:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08I97HT328508564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 09:07:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9377AA4053;
        Fri, 18 Sep 2020 09:07:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CDFEA404D;
        Fri, 18 Sep 2020 09:07:16 +0000 (GMT)
Received: from [9.199.45.180] (unknown [9.199.45.180])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Sep 2020 09:07:16 +0000 (GMT)
Subject: Re: [PATCH v5 1/2] ext4: Discard preallocations before releasing
 group lock
To:     Ye Bin <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        jack@suse.com, linux-ext4@vger.kernel.org
References: <20200916113859.1556397-1-yebin10@huawei.com>
 <20200916113859.1556397-2-yebin10@huawei.com>
Cc:     jack@suse.cz, tytso@mit.edu
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <0f17c3a5-2785-939b-47c5-55d39b4bf67b@linux.ibm.com>
Date:   Fri, 18 Sep 2020 14:37:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916113859.1556397-2-yebin10@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_10:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 phishscore=0
 suspectscore=2 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009180072
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 9/16/20 5:08 PM, Ye Bin wrote:
> From: Jan Kara <jack@suse.cz>
> 
> ext4_mb_discard_group_preallocations() can be releasing group lock with
> preallocations accumulated on its local list. Thus although
> discard_pa_seq was incremented and concurrent allocating processes will
> be retrying allocations, it can happen that premature ENOSPC error is
> returned because blocks used for preallocations are not available for
> reuse yet. Make sure we always free locally accumulated preallocations
> before releasing group lock.
> 
> Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>   fs/ext4/mballoc.c | 28 +++++++++++-----------------
>   1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 132c118d12e1..f736819a381b 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4215,22 +4215,6 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>   		list_add(&pa->u.pa_tmp_list, &list);
>   	}
>   
> -	/* if we still need more blocks and some PAs were used, try again */
> -	if (free < needed && busy) {
> -		busy = 0;
> -		ext4_unlock_group(sb, group);
> -		cond_resched();
> -		goto repeat;
> -	}
> -
> -	/* found anything to free? */
> -	if (list_empty(&list)) {
> -		BUG_ON(free != 0);
> -		mb_debug(sb, "Someone else may have freed PA for this group %u\n",
> -			 group);
> -		goto out;
> -	}
> -
>   	/* now free all selected PAs */
>   	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
>   
> @@ -4248,7 +4232,17 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>   		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
>   	}
>   
> -out:
> +	/* if we still need more blocks and some PAs were used, try again */
> +	if (free < needed && busy) {
> +		ext4_unlock_group(sb, group);
> +		cond_resched();
> +		busy = 0;
> +		/* Make sure we increment discard_pa_seq again */
> +		needed -= free;
> +		free = 0;

Oops sorry about getting back to this.
But if we are making free 0 here so we may return a wrong free value
when we return from this function. We should fix that by also accounting
previous freed blocks at the time of final return from this function.


-ritesh

> +		goto repeat;
> +	}
> +
>   	ext4_unlock_group(sb, group);
>   	ext4_mb_unload_buddy(&e4b);
>   	put_bh(bitmap_bh);
> 

