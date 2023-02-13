Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC969510C
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjBMTtY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjBMTtX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:49:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DD02723;
        Mon, 13 Feb 2023 11:49:22 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DJQTaJ013939;
        Mon, 13 Feb 2023 19:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=OuV9srwyO68QnCq2ith/2oDoMd7QZFArDqqzrX9z+4c=;
 b=C88Tx1PKByvaWPTgnC3Hy7LZOnCZ8u/DaJqBs6KYY2ry9x5N5bOtiJdIyUtoA5kQ3prB
 giSWSdJg+wyYFzN2orbzfAhgtRy7xtI8jJ1EbIMmh1R2I2SMiLjER6CvTwlV0Tm7nzNp
 dYztwZkz0gtkH4OHDWy3jPT0b+OfQxolb8IJzPnWiX2HYr4H80s4eIwC57VhOMu57gre
 BmKxJJF0tCLZfhdP2uQXtkVq7Ha9m6KXxAP8ZuUeTT3haB4OS7QUPj+FDpQPT8CYgbKb
 rwdDWT5pVjLyflGEDHEpm1ctekNzyeOkEh9tPzkxTrbV5FwkgY+1lqxqow+tGF4v62Y4 8A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nquc88dmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:49:15 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8iLnl007931;
        Mon, 13 Feb 2023 19:49:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3np2n6a997-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:49:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJnBuq17432876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:49:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25EB620049;
        Mon, 13 Feb 2023 19:49:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8733420043;
        Mon, 13 Feb 2023 19:49:09 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:49:09 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:19:06 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/21] ext4: remove unnecessary check in
 ext4_mb_new_blocks
Message-ID: <Y+qUMgVKwxvAik5L@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-13-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-13-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3jbGcfn_ZxUXPy7O-4_8azsX16bsv-ao
X-Proofpoint-ORIG-GUID: 3jbGcfn_ZxUXPy7O-4_8azsX16bsv-ao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=827 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:16AM +0800, Kemeng Shi wrote:
> 1. remove unnecessary ac check:
> We always go to out tag before ac is successfully allocated, then we can
> move out tag after free of ac and remove NULL check of ac.
> 
> 2. remove unnecessary *errp check:
> We always go to errout tag if *errp is non-zero, then we can move errout
> tag into error handle if *errp is non-zero.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 74da24c9bf14..bdabe0d81d4a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5641,16 +5641,15 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  		*errp = -ENOSPC;
>  	}
>  
> -errout:
>  	if (*errp) {
> +errout:
>  		ac->ac_b_ex.fe_len = 0;
>  		ar->len = 0;
>  		ext4_mb_show_ac(ac);
>  	}
>  	ext4_mb_release_context(ac);
> +	kmem_cache_free(ext4_ac_cachep, ac);
>  out:
> -	if (ac)
> -		kmem_cache_free(ext4_ac_cachep, ac);
>  	if (inquota && ar->len < inquota)
>  		dquot_free_block(ar->inode, EXT4_C2B(sbi, inquota - ar->len));
>  	if (!ar->len) {
> -- 
> 2.30.0
> 
Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
