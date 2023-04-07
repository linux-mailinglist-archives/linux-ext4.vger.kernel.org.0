Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B66DABEF
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Apr 2023 13:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjDGLDR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Apr 2023 07:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjDGLDN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Apr 2023 07:03:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D1826BC;
        Fri,  7 Apr 2023 04:03:03 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337AZs4P022555;
        Fri, 7 Apr 2023 11:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Cc7ZeYb8nX+dZ7/8PhqTP+l3ajuY5f3jeMlrAhVethQ=;
 b=myy6WXAzGzCGsKQSw7HY8h5vqXwbMIXRclVbCUdnOwE8YW7XyGcjxrA1+7ehVAU4qqwG
 f6wEGmZr3yN0zWwkuGt2rGc+w46evEw//VdhhbIDlQ+l8JTraKXtkkygYbWx5I3a/AQ+
 dSw7TJkI/6LtoEzzoyOfL2LhvWmFBt88EWUhcmcKKCyzhtldRuYfswsrcJlAPgrRvLPz
 L1neNvhEQuwGObLwKRykPaUCcxP1YJ6ObKAQOHUFnM1i+Q2cWjlqulRB6MjhgKL4j0aM
 oKKS87Hw7W5FZXvZHpjTLAmw4y1aER/GyGkBQ9W6MvcxVb9W4wdkv9d4MYb3smbgB4cK iA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pteatvs7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:02:31 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336JiCN5014867;
        Fri, 7 Apr 2023 11:02:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ppbvg4wac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:02:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 337B2Qf923855766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 11:02:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6453E2004B;
        Fri,  7 Apr 2023 11:02:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDEE220040;
        Fri,  7 Apr 2023 11:02:24 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.66.68])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 11:02:24 +0000 (GMT)
Date:   Fri, 7 Apr 2023 16:32:22 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] ext4: fix wrong unit use in ext4_mb_find_by_goal
Message-ID: <ZC/4PrHJhXS79xA7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
 <20230321161220.418652-5-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321161220.418652-5-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N6GU7Q7fG5kxeRFFCTEAVqNIcC-CJldG
X-Proofpoint-GUID: N6GU7Q7fG5kxeRFFCTEAVqNIcC-CJldG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070100
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 22, 2023 at 12:12:16AM +0800, Kemeng Shi wrote:
> We need start in block unit while fe_start is in cluster unit. Use
> ext4_grp_offs_to_block helper to convert fe_start to get start in
> block unit.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/mballoc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 86d978e1f7dc..9a40e165e7d2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2181,8 +2181,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
>  	if (max >= ac->ac_g_ex.fe_len && ac->ac_g_ex.fe_len == sbi->s_stripe) {
>  		ext4_fsblk_t start;
>  
> -		start = ext4_group_first_block_no(ac->ac_sb, e4b->bd_group) +
> -			ex.fe_start;
> +		start = ext4_grp_offs_to_block(ac->ac_sb, &ex);
>  		/* use do_div to get remainder (would be 64-bit modulo) */
>  		if (do_div(start, sbi->s_stripe) == 0) {
>  			ac->ac_found++;
> -- 
> 2.30.0
> 
