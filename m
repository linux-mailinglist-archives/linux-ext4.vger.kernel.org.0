Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84B6DAC13
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Apr 2023 13:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjDGLIf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Apr 2023 07:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjDGLIW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Apr 2023 07:08:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E984D4C2D;
        Fri,  7 Apr 2023 04:08:08 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337AZinx022417;
        Fri, 7 Apr 2023 11:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9CEcUBB9OgbOKgNZURZQRIM6lCFY6fXYr5cXMb/P23Y=;
 b=Xrb29BA8hBXdI5Mji4rxFxNFobn1GioS3o1SD+8N1qg6HPzfsMAqyPPwkEZsY58rkk52
 6cjU+wNv31yWzQuptSgIFN6jag3MwntHy1oiDBPsTsA/q/GAtBsniN96pNjj8JZUElHH
 4u0tOdT0OoAlSeK0rDMQYFSZbFGKprXeUbTiPEEj/Lcl1zUkA0MBsGAw83yZLGCZHcLH
 iCNVZcQS2MfRfJzDjs0sMSf/2mgQeB4UMyCwcJNsTdHcEv7OED0FBGDWdxIEDfoeVtwP
 wG/TsqQj83vHN9AyQ6712Ovgb7k5J7haBx8yPgaOvuMRmwwp0QrFPr4hlngMl9F2AYjL aQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pteatvvyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:08:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3379WJkW026032;
        Fri, 7 Apr 2023 11:07:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ppc87cx0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:07:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 337B7uCu9241160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 11:07:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B887520043;
        Fri,  7 Apr 2023 11:07:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5022220040;
        Fri,  7 Apr 2023 11:07:55 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.66.68])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 11:07:54 +0000 (GMT)
Date:   Fri, 7 Apr 2023 16:37:52 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] ext4: remove ext4_block_group and
 ext4_block_group_offset declaration
Message-ID: <ZC/5iDmCfX5HmJZu@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
 <20230321161220.418652-8-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321161220.418652-8-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TMyxXvIjrQLJROfnCb8r2WHnisAW_Vcd
X-Proofpoint-GUID: TMyxXvIjrQLJROfnCb8r2WHnisAW_Vcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=972 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
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

On Wed, Mar 22, 2023 at 12:12:19AM +0800, Kemeng Shi wrote:
> For ext4_block_group and ext4_block_group_offset, there are only
> declaration without definition. Just remove them.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/ext4.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9b2cfc32cf78..f25f13a357de 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2697,10 +2697,6 @@ extern void ext4_get_group_no_and_offset(struct super_block *sb,
>  extern ext4_group_t ext4_get_group_number(struct super_block *sb,
>  					  ext4_fsblk_t block);
>  
> -extern unsigned int ext4_block_group(struct super_block *sb,
> -			ext4_fsblk_t blocknr);
> -extern ext4_grpblk_t ext4_block_group_offset(struct super_block *sb,
> -			ext4_fsblk_t blocknr);
>  extern int ext4_bg_has_super(struct super_block *sb, ext4_group_t group);
>  extern unsigned long ext4_bg_num_gdb(struct super_block *sb,
>  			ext4_group_t group);
> -- 
> 2.30.0
> 
