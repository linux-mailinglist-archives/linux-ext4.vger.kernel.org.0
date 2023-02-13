Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A7269516E
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 21:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjBMULM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 15:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjBMULL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 15:11:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339021941;
        Mon, 13 Feb 2023 12:11:05 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DIiMJO000858;
        Mon, 13 Feb 2023 20:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=Q80EsKNrY1PRjZiuPkpqIzvM00rfSjdnNFvDvLyvpSs=;
 b=buAAea+lmAQtA9qasHnhCW29H8jIHYoQJf1q27VglYeRujX2TCjjeCxewXr3dbS5I5xw
 Ihe8Bgn8yJAPmAMI5z67MRHvuIvBsMiYO3HsfU43UPSt0O/kTcjXlbUbHOaFFqI2CUH5
 L+LDC09fN9qVqoNqJRYFytMq7jqJtWh8vOljAjXRY26Yoc0yV2AGctO3tPRzrw0370XF
 ctial/DIqpNqRKeR/CoPgL8OOYhJSpl/U279xvabig+P+MHEPDbkKU5aAAoOKR3PRj1e
 IHnsyYkbh7apsvya4rv9Vh9urnVJ8MM9uO99sZtoS2QMsNe+zFVifACZ9x/b4tY0suiO qw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqtr51qm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 20:10:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DCxTBw017665;
        Mon, 13 Feb 2023 20:10:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6k335-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 20:10:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DKAqb837486986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 20:10:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8EAF20043;
        Mon, 13 Feb 2023 20:10:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5415E20040;
        Mon, 13 Feb 2023 20:10:50 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 20:10:50 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:40:47 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/21] ext4: remove repeat assignment to ac_f_ex
Message-ID: <Y+qZR8ayTYSch9KT@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-20-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-20-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IOgL5Ho9j3HbcSqfCh7EdaO6no7HMOYi
X-Proofpoint-ORIG-GUID: IOgL5Ho9j3HbcSqfCh7EdaO6no7HMOYi
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=856 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130176
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:23AM +0800, Kemeng Shi wrote:
> Call trace to assign ac_f_ex:
> ext4_mb_use_best_found
> 	ac->ac_f_ex = ac->ac_b_ex;
> 	ext4_mb_new_preallocation
> 		ext4_mb_new_group_pa
> 			ac->ac_f_ex = ac->ac_b_ex;
> 		ext4_mb_new_inode_pa
> 			ac->ac_f_ex = ac->ac_b_ex;
> 
> Actually allocated blocks is already stored in ac_f_ex in
> ext4_mb_use_best_found, so there is no need to assign ac_f_ex
> in ext4_mb_new_group_pa and ext4_mb_new_inode_pa.
> Just remove repeat assignment to ac_f_ex in ext4_mb_new_group_pa
> and ext4_mb_new_inode_pa.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 7d6991af50d8..dec716f331ac 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4635,10 +4635,6 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
>  	}
>  
> -	/* preallocation can change ac_b_ex, thus we store actually
> -	 * allocated blocks for history */
> -	ac->ac_f_ex = ac->ac_b_ex;
> -
Alright, so we should note that the ac_b_ex being assigned to ac_f_ex
here can differ from the last allocation of ac_f_ex in
ext4_mb_use_best_found() in the case that bex_len < gex_len and we enter
the PA window adjustment if condition that is just above this line.

In such a case, we should maybe see which of the bex do we actually want
to store in fex. IMO, this patch does the right thing as the allocation
in ext4_mb_use_best_found() gives us an idea of how much the allocator
was exactly able to allocate before other PA related logics start making
changes to the best ex. Further, following the discussion here [1], we
might end up rewriting the PA window adjustment logic in future, and
that could also change the length of ac_b_ex, which we would not want to
reflect in ac_f_ex (again since i see ac_f_ex as the record of actual ex
that allocator was able to find).

So this patch looks like the right thing to do for me. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 

[1]
https://lore.kernel.org/linux-ext4/Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/
>  	pa->pa_lstart = ac->ac_b_ex.fe_logical;
>  	pa->pa_pstart = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
>  	pa->pa_len = ac->ac_b_ex.fe_len;
> @@ -4689,10 +4685,6 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
>  
>  	pa = ac->ac_pa;
>  
> -	/* preallocation can change ac_b_ex, thus we store actually
> -	 * allocated blocks for history */
> -	ac->ac_f_ex = ac->ac_b_ex;
> -
>  	pa->pa_pstart = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
>  	pa->pa_lstart = pa->pa_pstart;
>  	pa->pa_len = ac->ac_b_ex.fe_len;
> -- 
> 2.30.0
> 
