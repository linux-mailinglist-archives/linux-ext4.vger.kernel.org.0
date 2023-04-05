Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA96D86E7
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 21:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDETcB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDETcB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 15:32:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC0B59FF;
        Wed,  5 Apr 2023 12:32:00 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335GqaEG002326;
        Wed, 5 Apr 2023 19:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Xusx0WIuOnuJSlKM6U6oU6iz9j/ILhQQRdLjmYOHOtE=;
 b=K6JIvaQ3UxKXNmVC3Tlj9bXU2ElEVKqDKiHUl3wItNTV5l3XHX372IBVC5BRnREA92l0
 jVMWpUuk2ipdziKIgZiFxhgJACV0Aa/LZU+aM5Td7hX2tORiJsvDSdjbE91u0vTFfUCE
 HEO91VLlZXk1HTPbz7E0vQjFJTs5aErWx9/dvD/9PZv1POGQWyIutos38FaN2cNweKXX
 qoDZvp07sh+syG0c8I9lDOnjFx3UcLeQvorQpj8b9UmovXa1nDOqz2khihQAzwmzBM3W
 cR69qOVV5LvI9omGByev0/o95CJzD1030AgZiHSbqM3/MiScWEBmv1kJ3vTAB7sqSynB BA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps9bu9y1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 19:31:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 335HxmdD002409;
        Wed, 5 Apr 2023 19:31:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ppbvg3jxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 19:31:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335JVnfa17105498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 19:31:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39E8120043;
        Wed,  5 Apr 2023 19:31:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 810582004B;
        Wed,  5 Apr 2023 19:31:47 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.12.224])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 19:31:47 +0000 (GMT)
Date:   Thu, 6 Apr 2023 01:01:45 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] ext4: add EXT4_MB_HINT_GOAL_ONLY test in
 ext4_mb_use_preallocated
Message-ID: <ZC3MoWn2UO6p+Swp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
 <20230321161220.418652-7-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321161220.418652-7-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LpukHDFQx8Q_qPqFoKzkXuG1RIyEywER
X-Proofpoint-ORIG-GUID: LpukHDFQx8Q_qPqFoKzkXuG1RIyEywER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_13,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050175
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 22, 2023 at 12:12:18AM +0800, Kemeng Shi wrote:
> ext4_mb_use_preallocated will ignore the demand to alloc goal blocks,
> although the EXT4_MB_HINT_GOAL_ONLY is requested.
> For group pa, ext4_mb_group_or_file will not set EXT4_MB_HINT_GROUP_ALLOC
> if EXT4_MB_HINT_GOAL_ONLY is set. So we will not alloc goal blocks from
> group pa if EXT4_MB_HINT_GOAL_ONLY is set.
> For inode pa, ext4_mb_pa_goal_check is added to check if free extent in
> found inode pa meets goal blocks when EXT4_MB_HINT_GOAL_ONLY is set.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/mballoc.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b963111eeec6..5b837918c624 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4351,6 +4351,37 @@ ext4_mb_check_group_pa(ext4_fsblk_t goal_block,
>  	return pa;
>  }
>  
> +/*
> + * check if found pa meets EXT4_MB_HINT_GOAL_ONLY
> + */
> +static bool
> +ext4_mb_pa_goal_check(struct ext4_allocation_context *ac,
> +		      struct ext4_prealloc_space *pa)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> +	ext4_fsblk_t start;
> +
> +	if (likely(!(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY)))
> +		return true;
> +
> +	/*
> +	 * If EXT4_MB_HINT_GOAL_ONLY is set, ac_g_ex will not be adjusted
> +	 * in ext4_mb_normalize_request and will keep same with ac_o_ex
> +	 * from ext4_mb_initialize_context. Choose ac_g_ex here to keep
> +	 * consistent with ext4_mb_find_by_goal.
> +	 */
> +	start = pa->pa_pstart +
> +		(ac->ac_g_ex.fe_logical - pa->pa_lstart);
> +	if (ext4_grp_offs_to_block(ac->ac_sb, &ac->ac_g_ex) != start)
> +		return false;
> +
> +	if (ac->ac_g_ex.fe_len > pa->pa_len -
> +	    EXT4_B2C(sbi, ac->ac_g_ex.fe_logical - pa->pa_lstart))
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * search goal blocks in preallocated space
>   */
> @@ -4387,7 +4418,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  
>  		/* found preallocated blocks, use them */
>  		spin_lock(&pa->pa_lock);
> -		if (pa->pa_deleted == 0 && pa->pa_free) {
> +		if (pa->pa_deleted == 0 && pa->pa_free &&
> +		    likely(ext4_mb_pa_goal_check(ac, pa))) {
Alright so this looks good to me, I just have one concern. 

Consider the following scenario:

		1. We find a PA that cover our logical blocks but the physical blocks in
			 the PA don't match our goal and we return false.

		2. We then proceed in ext4_mb_regular_allocator and actually manage to
			 allocate the goal blocks.

		3. Now the logical blocks of the file are associated to the blocks
			 allocated in Step 2 and the logical blocks of the PA would actually never get
			 utilized, and hence they are wasted space.

That being said, I think fixing this would be a bit tricky and I'm not sure if
it's even worth the trouble as GOAL_ONLY is not a very common case anyways. Would like
to hear other people's thoughts on this.


Regards,
ojaswin
>  			atomic_inc(&pa->pa_count);
>  			ext4_mb_use_inode_pa(ac, pa);
>  			spin_unlock(&pa->pa_lock);
> -- 
> 2.30.0
> 
