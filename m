Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9272700081
	for <lists+linux-ext4@lfdr.de>; Fri, 12 May 2023 08:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbjELGaH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 02:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239966AbjELGaG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 02:30:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE24C1D;
        Thu, 11 May 2023 23:29:30 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C6NeEV031915;
        Fri, 12 May 2023 06:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VPupIsObVPjkoywtDzYWtyUiPBFH2FAqmiOReM9a9yM=;
 b=QHfilpk+QUSY8jlwZ7YfF4hY/EztGzYgV7lLX74cd/oZxl8D+zqC8UC0I1nhykPPAv3u
 o/cfz0MAj5jQfsIRYlrk7V5l5i7ZV/dwi31iLAe4vVW0eO10o1QP3WebXv1Ax96Kv0th
 Qcgu9Na8NUcrzeuNSgJK+SttyYI/gtXj+Gpd2v1l1ueGoSgxNVED8rTHFSLwksF6riHn
 rld0Wi+eCc+KLVP4OJ339HWWAvy8/m1oylPZiWCNTnA1MZ0BKbM9jAN5AbfonP4zCvuo
 O0VkJeVt49g+KCHqQ77bS/uld4AN1ec8qonovhJF1QSxjj5RBkeHmFHorUhiOZDb9sE4 SA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhg59g5pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 06:29:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34C48chq025905;
        Fri, 12 May 2023 06:29:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qf896t5ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 06:29:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34C6TFuO30540284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 06:29:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E687D2004F;
        Fri, 12 May 2023 06:29:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C5CC20040;
        Fri, 12 May 2023 06:29:13 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.7.84])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 12 May 2023 06:29:13 +0000 (GMT)
Date:   Fri, 12 May 2023 11:59:10 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/19] ext4: get block from bh before pass it to
 ext4_free_blocks_simple in ext4_free_blocks
Message-ID: <ZF3cpYZKI0GMrFoR@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
 <20230417110617.2664129-9-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417110617.2664129-9-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mezc7_4AfWoVGQsu2DEMqqndvSRFJwbs
X-Proofpoint-ORIG-GUID: mezc7_4AfWoVGQsu2DEMqqndvSRFJwbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=706 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 07:06:06PM +0800, Kemeng Shi wrote:
> ext4_free_blocks will retrieve block from bh if block parameter is zero.
> Retrieve block before ext4_free_blocks_simple to avoid potentially
> passing wrong block to ext4_free_blocks_simple.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Hi Kemeng,

Nice catch! feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/mballoc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e980513c7a14..f37e921c11e5 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6310,12 +6310,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  
>  	sbi = EXT4_SB(sb);
>  
> -	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
> -		ext4_free_blocks_simple(inode, block, count);
> -		return;
> -	}
> -
> -	might_sleep();
>  	if (bh) {
>  		if (block)
>  			BUG_ON(block != bh->b_blocknr);
> @@ -6323,6 +6317,13 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  			block = bh->b_blocknr;
>  	}
>  
> +	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
> +		ext4_free_blocks_simple(inode, block, count);
> +		return;
> +	}
> +
> +	might_sleep();
> +
>  	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
>  	    !ext4_inode_block_valid(inode, block, count)) {
>  		ext4_error(sb, "Freeing blocks not in datazone - "
> -- 
> 2.30.0
> 
