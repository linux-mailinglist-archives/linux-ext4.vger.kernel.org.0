Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F76DAC10
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Apr 2023 13:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjDGLHs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Apr 2023 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbjDGLHa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Apr 2023 07:07:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C090CB756;
        Fri,  7 Apr 2023 04:07:10 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3378A503022330;
        Fri, 7 Apr 2023 11:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Igk0t6Unw6nnffxVVMel2n1Fllq19+7lPu1A4Ed8kL8=;
 b=OyCsYjZr97oB0TNIjHPW9c5Te/pIigWcVCTTla7UI5rEeJN1etZ9NOM+JURHZKo5V9jK
 eEb8LT0DdtJIbvLW1yowB4j7JcsqIyta/KLN4jg33tubReEcxMM/JluqxuiMtEDUPeFJ
 xSwFNtY7TmlgoFrAIe/ih09+FZMLZrmrqTjGgjKd2ZMwA/TIX5TG6egXnIiZ125D8es4
 GjecEkd0FhpZ6bep6KnwP4npmSavEQUkHvSk2evicCeoHf7Ze55PG+vojioiKvZjV5Hs
 yEjbOTRywu438TSDIWJQrg5dCvjKVmSWVZUC+o+LZ9bj6A35wUn3Vzea6qp0353b2Oyx pg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptaqv0pmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:06:34 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 337Ahkcf030740;
        Fri, 7 Apr 2023 11:06:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ppc86up0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:06:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 337B6UxW17892068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 11:06:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CBCE20049;
        Fri,  7 Apr 2023 11:06:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CDF220043;
        Fri,  7 Apr 2023 11:06:29 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.66.68])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 11:06:29 +0000 (GMT)
Date:   Fri, 7 Apr 2023 16:36:26 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] ext4: treat stripe in block unit
Message-ID: <ZC/5MpJrKxzxMTl6@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
 <20230321161220.418652-6-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321161220.418652-6-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PW0tHlCwIloTnLnFxXPG2ep9xmLZ_wpG
X-Proofpoint-ORIG-GUID: PW0tHlCwIloTnLnFxXPG2ep9xmLZ_wpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070100
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 22, 2023 at 12:12:17AM +0800, Kemeng Shi wrote:
> Stripe is misused in block unit and in cluster unit in different code
> paths. User awared of stripe maybe not awared of bigalloc feature, so
> treat stripe only in block unit to fix this.
> Besides, it's hard to get stripe aligned blocks (start and length are both
> aligned with stripe) if stripe is not aligned with cluster, just disable
> stripe and alert user in this case to simpfy the code and avoid
> unecessary work to get stripe aligned blocks which likely to be failed.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Nice fixes, and I agree that we can disable stripes if it is not aligned
with cluster. There are anyways some gaps in our stripe support eg the
normalization logic doesnt even take stripesize into account when
determining the goal length.

Anyways, for this patch feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/mballoc.c | 18 +++++++++++-------
>  fs/ext4/super.c   | 13 +++++++++++++
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9a40e165e7d2..b963111eeec6 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2178,7 +2178,8 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
>  			     ac->ac_g_ex.fe_len, &ex);
>  	ex.fe_logical = 0xDEADFA11; /* debug value */
>  
> -	if (max >= ac->ac_g_ex.fe_len && ac->ac_g_ex.fe_len == sbi->s_stripe) {
> +	if (max >= ac->ac_g_ex.fe_len &&
> +	    ac->ac_g_ex.fe_len == EXT4_B2C(sbi, sbi->s_stripe)) {
>  		ext4_fsblk_t start;
>  
>  		start = ext4_grp_offs_to_block(ac->ac_sb, &ex);
> @@ -2343,7 +2344,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
>  	struct ext4_free_extent ex;
>  	ext4_fsblk_t first_group_block;
>  	ext4_fsblk_t a;
> -	ext4_grpblk_t i;
> +	ext4_grpblk_t i, stripe;
>  	int max;
>  
>  	BUG_ON(sbi->s_stripe == 0);
> @@ -2355,10 +2356,12 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
>  	do_div(a, sbi->s_stripe);
>  	i = (a * sbi->s_stripe) - first_group_block;
>  
> +	stripe = EXT4_B2C(sbi, sbi->s_stripe);
> +	i = EXT4_B2C(sbi, i);
>  	while (i < EXT4_CLUSTERS_PER_GROUP(sb)) {
>  		if (!mb_test_bit(i, bitmap)) {
> -			max = mb_find_extent(e4b, i, sbi->s_stripe, &ex);
> -			if (max >= sbi->s_stripe) {
> +			max = mb_find_extent(e4b, i, stripe, &ex);
> +			if (max >= stripe) {
>  				ac->ac_found++;
>  				ex.fe_logical = 0xDEADF00D; /* debug value */
>  				ac->ac_b_ex = ex;
> @@ -2366,7 +2369,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
>  				break;
>  			}
>  		}
> -		i += sbi->s_stripe;
> +		i += stripe;
>  	}
>  }
>  
> @@ -2727,7 +2730,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  			if (cr == 0)
>  				ext4_mb_simple_scan_group(ac, &e4b);
>  			else if (cr == 1 && sbi->s_stripe &&
> -					!(ac->ac_g_ex.fe_len % sbi->s_stripe))
> +				 !(ac->ac_g_ex.fe_len %
> +				 EXT4_B2C(sbi, sbi->s_stripe)))
>  				ext4_mb_scan_aligned(ac, &e4b);
>  			else
>  				ext4_mb_complex_scan_group(ac, &e4b);
> @@ -3441,7 +3445,7 @@ int ext4_mb_init(struct super_block *sb)
>  	 */
>  	if (sbi->s_stripe > 1) {
>  		sbi->s_mb_group_prealloc = roundup(
> -			sbi->s_mb_group_prealloc, sbi->s_stripe);
> +			sbi->s_mb_group_prealloc, EXT4_B2C(sbi, sbi->s_stripe));
>  	}
>  
>  	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index f226f8ab469b..0a5bf375df5c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5231,6 +5231,19 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		goto failed_mount3;
>  
>  	sbi->s_stripe = ext4_get_stripe_size(sbi);
> +	/*
> +	 * It's hard to get stripe aligned blocks if stripe is not aligned with
> +	 * cluster, just disable stripe and alert user to simpfy code and avoid
> +	 * stripe aligned allocation which will rarely successes.
> +	 */
> +	if (sbi->s_stripe > 0 && sbi->s_cluster_ratio > 1 &&
> +	    sbi->s_stripe % sbi->s_cluster_ratio != 0) {
> +		ext4_msg(sb, KERN_WARNING,
> +			 "stripe (%lu) is not aligned with cluster size (%u), "
> +			 "stripe is disabled",
> +			 sbi->s_stripe, sbi->s_cluster_ratio);
> +		sbi->s_stripe = 0;
> +	}
>  	sbi->s_extent_max_zeroout_kb = 32;
>  
>  	/*
> -- 
> 2.30.0
> 
