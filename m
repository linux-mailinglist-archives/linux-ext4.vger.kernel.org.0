Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBFA6950F0
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjBMTqp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBMTqo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:46:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AB92723;
        Mon, 13 Feb 2023 11:46:42 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DIiM9c000858;
        Mon, 13 Feb 2023 19:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=JpNH6EZxhyluvKxPmNPCdN4258NVtLLLTX4e3+Dtcmw=;
 b=CEcB+8GaM8GMsATejkC6c9RFjh6x1rKINlr044D7HckN+9ZKm3bdcR/p5L+jAdlo3dKm
 /F1IUZN9ZHoj3Ck0yx4pGOcksN6HLb1wj0BbFqNAtv7O233kVgAseEn/JE1hRWnwpuwe
 OifY/VcXiCAtc+PPm4ZGuLm6iggIFlkojfajjNXNGDPovX4AXj8fmwlow+vp1CZMuStI
 yktA68b1T0KnfjL0Wt3Q4OB/9bAaDKwEsSoy7bqxWBh2G1fzljnfvtOPc+mosj8E0Ww5
 UPC0aHqLvaFHXY31houXcE+pj9/mlHIKjG+i16GG1U8yk6146K2Iy6RFZcVItjiq3YC/ bg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqtr516n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:46:30 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31D809RE007386;
        Mon, 13 Feb 2023 19:46:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3np29fa9et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:46:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJkQb751642810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:46:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEB842004B;
        Mon, 13 Feb 2023 19:46:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A1F120040;
        Mon, 13 Feb 2023 19:46:25 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:46:24 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:16:22 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/21] ext4: add missed brelse in ext4_free_blocks_simple
Message-ID: <Y+qTdjjN/D29V09I@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-9-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-9-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EMhR3tbFUGvkcJQ2CJbqDMf_4FqkWiV4
X-Proofpoint-ORIG-GUID: EMhR3tbFUGvkcJQ2CJbqDMf_4FqkWiV4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=891 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:12AM +0800, Kemeng Shi wrote:
> Release bitmap buffer_head we got if error occurs.
> Besides, this patch remove unused assignment to err.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4e1caac74b44..17ac98c501ed 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5848,13 +5848,12 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
>  	bitmap_bh = ext4_read_block_bitmap(sb, group);
>  	if (IS_ERR(bitmap_bh)) {
> -		err = PTR_ERR(bitmap_bh);
>  		pr_warn("Failed to read block bitmap\n");
>  		return;
>  	}
>  	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
>  	if (!gdp)
> -		return;
> +		goto err_out;
>  
>  	for (i = 0; i < count; i++) {
>  		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data))
> @@ -5863,7 +5862,7 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  	mb_clear_bits(bitmap_bh->b_data, blkoff, count);
>  	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
>  	if (err)
> -		return;
> +		goto err_out;
>  	ext4_free_group_clusters_set(
>  		sb, gdp, ext4_free_group_clusters(sb, gdp) +
>  		count - already_freed);
> @@ -5872,6 +5871,8 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
>  	sync_dirty_buffer(bitmap_bh);
>  	sync_dirty_buffer(gdp_bh);
> +
> +err_out:
>  	brelse(bitmap_bh);
>  }
>  
> -- 
> 2.30.0
> 
Looks good, I'm also okay with removing the err variable out completely.
Either ways, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 


