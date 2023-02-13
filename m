Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6218869511C
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjBMTyD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjBMTyC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:54:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC96D1C7ED;
        Mon, 13 Feb 2023 11:54:01 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DJS1YK020911;
        Mon, 13 Feb 2023 19:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XwhyzVfxPNRV8QVCyflPLlqVnFnZ6biKS8WtqpnJN3w=;
 b=Sv4ysFd8QYSe3mSa6XT9M0Tb49Sbdpcu+ZKYoQQv9wVrYH2Ym5vEKfNv1dzidD3b5qls
 dEf7qOOw6UIUkpVFiStcbs8l0PDPW/sxL+Drbto9lqqp9YD74zfXfG1XQHsFEak2CNJ/
 CRihJ/NMzP0h0eRfA67NtUr9XwXFEGyul7QnZx+tnEGFFUorxHU82kN6XG/IVTD6bGGq
 iFhWdZGlg+TkGisONow7Gxqzp/xT13rC458WhlbIPUhZ2EQJ5C9VNfpV5tc/6eZQHbcW
 FV6KCeO/aYpYDdMWj89+5Hy4JkBN8s/8Fs/TAu6AovF/NqAQK6D4c6pXeb/WooY6V3+m EQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqucp8ed4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:53:53 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DCxTAp017665;
        Mon, 13 Feb 2023 19:53:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6k2fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:53:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJrmHK31981826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:53:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA56320043;
        Mon, 13 Feb 2023 19:53:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D6A420040;
        Mon, 13 Feb 2023 19:53:47 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:53:46 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:23:44 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/21] ext4: use best found when complex scan of group
 finishs
Message-ID: <Y+qVSCj/dIL68e9g@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-16-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-16-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UqAKeK9IYfmDr5zc0WsIlo6SByR2vlxO
X-Proofpoint-GUID: UqAKeK9IYfmDr5zc0WsIlo6SByR2vlxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:19AM +0800, Kemeng Shi wrote:
> If any bex which meets bex->fe_len >= gex->fe_len is found, then it will
> always be used when complex scan of group that bex belongs to finishs.
> So there will not be any lock-unlock period.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e53f84de5018..c684758d6dbb 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2019,8 +2019,6 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_free_extent *bex = &ac->ac_b_ex;
>  	struct ext4_free_extent *gex = &ac->ac_g_ex;
> -	struct ext4_free_extent ex;
> -	int max;
>  
>  	if (ac->ac_status == AC_STATUS_FOUND)
>  		return;
> @@ -2039,16 +2037,8 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
>  	if (bex->fe_len < gex->fe_len)
>  		return;
>  
> -	if (finish_group && bex->fe_group == e4b->bd_group) {
> -		/* recheck chunk's availability - we don't know
> -		 * when it was found (within this lock-unlock
> -		 * period or not) */
> -		max = mb_find_extent(e4b, bex->fe_start, gex->fe_len, &ex);
> -		if (max >= gex->fe_len) {
> -			ext4_mb_use_best_found(ac, e4b);
> -			return;
> -		}
> -	}
> +	if (finish_group)
> +		ext4_mb_use_best_found(ac, e4b);
>  }
>  
>  /*
> -- 
> 2.30.0
> 
Looks good. So when we have found bex > gex, then we wont have a lock
unlock period since we always allocate the bex when we reach the end of
group. 

Just a small typo in the commit message (finshs -> finishes), but other
than that feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
