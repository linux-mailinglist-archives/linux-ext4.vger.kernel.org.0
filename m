Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95316950F5
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjBMTrh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBMTrg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:47:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAFD3AB1;
        Mon, 13 Feb 2023 11:47:35 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DIql7p028905;
        Mon, 13 Feb 2023 19:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=JczqwtPWEqutxs3Ncgl4Oe4XzBSRsGqvHT24NVSI4dg=;
 b=MeWNuVU+vLvDp8IacRhfU2DD8IWtfR4YHLotJmFF7pR8khfoxFy47FF/nw/lkdVIJKDN
 Og/vlZWR8IJZ9w7p604FhpHDVOVeUxrLl+GW4leoDZVM4aS8zHVFwhQO5igaPyiOQiKi
 IOH3ITl5y+I/R+u4DWOUqQEeZWxPSjrtW3osBLPydL5NeAGxEwgBVS+C0dy3m/cvFvgR
 IOniBHXQJjGR1JK836VBVTKkeInFUaxaxrNKaOa4HbMNIhCB/PJ6qwG9wZs6xQU3qDVw
 Jv2dV1P5ld02azuQio164NL5ltcoGcIZbZhCxxa544U8UbE6PKiJnv4qcgxX7vSlCTzH Zg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqtvds8v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:47:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DDBuJU010804;
        Mon, 13 Feb 2023 19:47:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6u2rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:47:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJlMRM46989804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:47:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B3182004E;
        Mon, 13 Feb 2023 19:47:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D94CB20040;
        Mon, 13 Feb 2023 19:47:20 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:47:20 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:17:18 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/21] ext4: remove unused return value of
 ext4_mb_try_best_found and ext4_mb_free_metadata
Message-ID: <Y+qTxiAFv69MstVd@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-10-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-10-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JF51wHRBj1utC4yblAPnYQTGOLsOA5QO
X-Proofpoint-GUID: JF51wHRBj1utC4yblAPnYQTGOLsOA5QO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:13AM +0800, Kemeng Shi wrote:
> Return value static function ext4_mb_try_best_found and
> ext4_mb_free_metadata is not used. Just remove unused return value.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 17ac98c501ed..ad9e3b7d3198 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2124,7 +2124,7 @@ static void ext4_mb_measure_extent(struct ext4_allocation_context *ac,
>  }
>  
>  static noinline_for_stack
> -int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
> +void ext4_mb_try_best_found(struct ext4_allocation_context *ac,
>  					struct ext4_buddy *e4b)
>  {
>  	struct ext4_free_extent ex = ac->ac_b_ex;
> @@ -2135,7 +2135,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
>  	BUG_ON(ex.fe_len <= 0);
>  	err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
>  	if (err)
> -		return err;
> +		return;
>  
>  	ext4_lock_group(ac->ac_sb, group);
>  	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
> @@ -2147,8 +2147,6 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
>  
>  	ext4_unlock_group(ac->ac_sb, group);
>  	ext4_mb_unload_buddy(e4b);
> -
> -	return 0;
>  }
>  
>  static noinline_for_stack
> @@ -5699,7 +5697,7 @@ static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
>  	kmem_cache_free(ext4_free_data_cachep, entry);
>  }
>  
> -static noinline_for_stack int
> +static noinline_for_stack void
>  ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  		      struct ext4_free_data *new_entry)
>  {
> @@ -5742,7 +5740,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  				EXT4_C2B(sbi, cluster),
>  				"Block already on to-be-freed list");
>  			kmem_cache_free(ext4_free_data_cachep, new_entry);
> -			return 0;
> +			return;
>  		}
>  	}
>  
> @@ -5768,7 +5766,6 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list);
>  	sbi->s_mb_free_pending += clusters;
>  	spin_unlock(&sbi->s_md_lock);
> -	return 0;
>  }
>  
>  /*
> -- 
> 2.30.0
> 
Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
