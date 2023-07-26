Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B9976398F
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jul 2023 16:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGZOvI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jul 2023 10:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjGZOvH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jul 2023 10:51:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC41FDD;
        Wed, 26 Jul 2023 07:51:04 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QEg8VX019731;
        Wed, 26 Jul 2023 14:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=EJcsrSdqCiciidgYzCYrBcbrS/N5lLi5ni1hJMCHRJc=;
 b=GzrSnCSOGBqpY9WeafSpyblXQ84VlenQrT/QrcrQc71fjI1moBcbvqKEU4HZo/QaeFzr
 jh7N+XoIxzpL77gAWoDTeot3yp4uk7rgiWvS7WH0Fh7t92bP4ffPJVlaftDLWLG/dM8+
 dT81B2igwyZknrWJlIDOWJp7DzfHvknNZ3BB+psTgtOSx3ZIU41QYAoSd/Bzass8nWjE
 1RO2BLuSiHKyWAjEeQ4tjuCWRkQjmYUigJnpEtihLgJk5nuy59H6/1fzTJNaXTYsbkH9
 BY64KbkTdAoFldp6+ulTbibKC86n5XOGL9GCCWYdtCJ+ll+y9NrNaeQ+PSqLfpbYVs8r 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s35330tq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:50:53 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36QEgF6f021001;
        Wed, 26 Jul 2023 14:50:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s35330tpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:50:52 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36QCd2Vu014370;
        Wed, 26 Jul 2023 14:50:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0sty5usp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:50:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36QEonNt45220340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 14:50:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD67220043;
        Wed, 26 Jul 2023 14:50:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FDD320040;
        Wed, 26 Jul 2023 14:50:47 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.87.146])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 26 Jul 2023 14:50:46 +0000 (GMT)
Date:   Wed, 26 Jul 2023 20:20:44 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] ext4: correct some stale comment of criteria
Message-ID: <ZMEyxLauFkXBwgUZ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230725185106.2147273-1-shikemeng@huaweicloud.com>
 <20230725185106.2147273-11-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725185106.2147273-11-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DA-8FhdRhAu4rHYXFMe3M46H41gG7Q9c
X-Proofpoint-GUID: cvtDe6xRowjhcvackPOi70R1UNSnPmr5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 26, 2023 at 02:51:06AM +0800, Kemeng Shi wrote:
> We named criteria with CR_XXX, correct stale comment to criteria with
> raw number.

Hi Kemeng,

Thanks for the cleanups.

> 
> Fixes: f52f3d2b9fba ("ext4: Give symbolic names to mballoc criterias")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/mballoc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 36eea63eaace..de5da76e6748 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2777,8 +2777,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  
>  	/*
>  	 * ac->ac_2order is set only if the fe_len is a power of 2
> -	 * if ac->ac_2order is set we also set criteria to 0 so that we
> -	 * try exact allocation using buddy.
> +	 * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
> +	 * so that we try exact allocation using buddy.
>  	 */
>  	i = fls(ac->ac_g_ex.fe_len);
>  	ac->ac_2order = 0;
> @@ -2835,8 +2835,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  			/*
>  			 * Batch reads of the block allocation bitmaps
>  			 * to get multiple READs in flight; limit
> -			 * prefetching at cr=0/1, otherwise mballoc can
> -			 * spend a lot of time loading imperfect groups
> +			 * prefetching at cr below CR_FAST, otherwise mballoc

One of my earlier patchset has replaced the CR_FAST macro with
ext4_mb_cr_expensive() so maybe we can account for that here:

https://lore.kernel.org/linux-ext4/20230630085927.140137-1-ojaswin@linux.ibm.com/

Regards,
ojaswin

> +			 * can spend a lot of time loading imperfect groups

>  			 */
>  			if ((prefetch_grp == group) &&
>  			    (cr >= CR_FAST ||
> -- 
> 2.30.0
> 
