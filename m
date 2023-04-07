Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76286DABEB
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Apr 2023 13:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjDGLCU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Apr 2023 07:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbjDGLCC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Apr 2023 07:02:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C6CB454;
        Fri,  7 Apr 2023 04:01:54 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3379n4YO032658;
        Fri, 7 Apr 2023 11:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=8bjjcjn9PC16289I+YMACz2S66oCvhbCkHuIn54JQ5Y=;
 b=raqYjNIPqCLz3/VXwI5s3Hk7/clAOlPLZnsYNlMGfmhHIB0lFXsur3aU17dWCM+6jJC/
 iHnexOwE97vcyFvbr4BVwAZSvv0drna45VIVamzL/58cJ9nsR87WUkX6vqN1+kDtPm26
 T3cK7h1NkoiUAHU5wp300d80jng4lpXH7jgPwYw8cPOWjFajlhKnUjWHzmInyMdsLsGX
 KQnFr7VpnGncWG84/mxSUNiAzLMdVS102FixvUi9lC0SLMUbfggBGjcBjq9ZEvniP2Di
 c/ZBugys10peZW0A3MtXmp9sQbrKvlSx3Kg7dRKVeDVyHAP9/OGI4yKRzCkkoEIHVOCj uw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pt6fh54c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:01:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3372HLv6005573;
        Fri, 7 Apr 2023 11:01:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ppc874wr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:01:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 337B1e1m45875728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 11:01:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E223D2004D;
        Fri,  7 Apr 2023 11:01:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DA992004B;
        Fri,  7 Apr 2023 11:01:38 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.66.68])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 11:01:38 +0000 (GMT)
Date:   Fri, 7 Apr 2023 16:31:35 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] ext4: fix unit mismatch in ext4_mb_new_blocks_simple
Message-ID: <ZC/4Dz25RsMce9do@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
 <20230321161220.418652-3-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321161220.418652-3-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PRXx1XQZ5Kjak7IyZESEg44p4kWGLPqf
X-Proofpoint-GUID: PRXx1XQZ5Kjak7IyZESEg44p4kWGLPqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070100
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 22, 2023 at 12:12:14AM +0800, Kemeng Shi wrote:
> The "i" returned from mb_find_next_zero_bit is in cluster unit and we
> need offset "block" corresponding to "i" in block unit. Convert "i" to
> block unit to fix the unit mismatch.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/mballoc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 6318c763a239..7f695830621a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5761,6 +5761,7 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
>  {
>  	struct buffer_head *bitmap_bh;
>  	struct super_block *sb = ar->inode->i_sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	ext4_group_t group;
>  	ext4_grpblk_t blkoff;
>  	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
> @@ -5789,7 +5790,8 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
>  			if (i >= max)
>  				break;
>  			if (ext4_fc_replay_check_excluded(sb,
> -				ext4_group_first_block_no(sb, group) + i)) {
> +				ext4_group_first_block_no(sb, group) +
> +				EXT4_C2B(sbi, i))) {
>  				blkoff = i + 1;
>  			} else
>  				break;
> @@ -5806,7 +5808,7 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
>  		return 0;
>  	}
>  
> -	block = ext4_group_first_block_no(sb, group) + i;
> +	block = ext4_group_first_block_no(sb, group) + EXT4_C2B(sbi, i);
>  	ext4_mb_mark_bb(sb, block, 1, 1);
>  	ar->len = 1;
>  
> -- 
> 2.30.0
> 
