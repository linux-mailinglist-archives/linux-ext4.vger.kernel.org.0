Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3D7000B1
	for <lists+linux-ext4@lfdr.de>; Fri, 12 May 2023 08:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbjELGkE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 02:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbjELGkA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 02:40:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB9D84C;
        Thu, 11 May 2023 23:39:54 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C6dQad010886;
        Fri, 12 May 2023 06:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NjhJM1HhhA0VPcFVpNX/0wJVXLUIdOw66qGBc1jz9p8=;
 b=dZ9pgCUdBtsOvx7KzFcB3HFmGVpgPC+Y4VkUQ/RVXvBuT8MK5tnNB1lFohkzBtzNoybW
 /8hdKZg76TTjNd58RzoaBc1ZaHsIF6TKt/QOBXBXcmnBhaBAI+VJ7AcZWkxdgD0Rz6/F
 8ozhvd/5BX8DptENibYPeOzCphWH2EV3ZGU7YIsLIS7NVm1h6rQ63Ccm8VGbLy6emQfU
 G3iwHsd1VD6eo39iFj4fzgCNmJGcqG/4CHLvjkaroWnVDB4t5eEOVxmJ1d/sluqH03Uv
 3w6jiWxkLZym0QRbfWYKL04sLhu9GRyR7TLuWC6RG4O5kCBFTb6wzR1X6UIXmqD0HnEK KA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhg6k8551-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 06:39:44 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34C5bQLr027424;
        Fri, 12 May 2023 06:39:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qf7d1ss62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 06:39:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34C6dceq51052866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 06:39:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD0702004D;
        Fri, 12 May 2023 06:39:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43BCA20040;
        Fri, 12 May 2023 06:39:37 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.7.84])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 12 May 2023 06:39:37 +0000 (GMT)
Date:   Fri, 12 May 2023 12:09:34 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/19] ext4: fix wrong unit use in ext4_mb_new_blocks
Message-ID: <ZF3fJmzhUe2btLrf@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
 <20230417110617.2664129-12-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417110617.2664129-12-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 64kcRisVdRoP8s2-bPUILrPBB2kslYf_
X-Proofpoint-GUID: 64kcRisVdRoP8s2-bPUILrPBB2kslYf_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 07:06:09PM +0800, Kemeng Shi wrote:
> Function ext4_mb_new_blocks_simple needs count in cluster. Function

So there seems to be a typo in the commit header and commit message. I believe
you mean ext4_mb_free_blocks() and ext4_mb_free_blocks_simple() ?

If that is the case, once corrected feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ext4_mb_new_blocks accepts count in block. Convert count to cluster
> to fix the mismatch.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4a345e3c1c78..6d4471fd3049 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6315,7 +6315,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  	}
>  
>  	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
> -		ext4_free_blocks_simple(inode, block, count);
> +		ext4_free_blocks_simple(inode, block, EXT4_NUM_B2C(sbi, count));
>  		return;
>  	}
>  
> -- 
> 2.30.0
> 
