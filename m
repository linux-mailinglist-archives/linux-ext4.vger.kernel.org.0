Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B9695125
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBMT5F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBMT5E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:57:04 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5B1CACF;
        Mon, 13 Feb 2023 11:57:01 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DINkIY021740;
        Mon, 13 Feb 2023 19:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=HerWC2ET+A8WuGrlKlgGoJcGkj0yLS1SYi5bhbzZ4+I=;
 b=bcIJVfQ7tQz3L0CQUeu8PHczynK7ct7VSoZjk4ox3C555R5uLLw/UGLbZV3yc3MWpRsH
 EIllI8ZpLtcKPKgcIEZOIf0do6YNS2vV2198A7qZP0SfN6G8WBONzyPrZpT+SrGio2aN
 89QFBvujtp7f7fmnwxMBZmtwaeHo5KbVFwo6Pbjijj0J9qWY1HXYkepQo7WLbf/yaq5d
 ueqEYAs69s5vq6ELTXqhlFewcqmrPugPCJUFzpcJ+PLwXbu6h80QE5x6gOu+9IONQJhy
 TX74cLy9g3tDpW4a8GNMvZhceVFfEdW4ZDRZNxmUKRUGEXKCQXdDMOAAsC5IgUUdF5x/ Pg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqtetj00c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:56:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DCJ7Hc031329;
        Mon, 13 Feb 2023 19:56:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3np29fk3ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:56:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJunSh48890320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:56:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C04D820043;
        Mon, 13 Feb 2023 19:56:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2331D20040;
        Mon, 13 Feb 2023 19:56:48 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:56:47 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:26:45 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/21] ext4: remove unnecessary count2 in
 ext4_free_data_in_buddy
Message-ID: <Y+qV/TF4PJdI3oh/@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-18-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-18-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RrrqGD5Dyl2D0uawNOPqV951cxWpWQ1k
X-Proofpoint-ORIG-GUID: RrrqGD5Dyl2D0uawNOPqV951cxWpWQ1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:21AM +0800, Kemeng Shi wrote:
> count2 is always 1 in mb_debug, just remove unnecessary count2.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 289dcd81dd5a..f9fc461b633f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3590,7 +3590,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
>  {
>  	struct ext4_buddy e4b;
>  	struct ext4_group_info *db;
> -	int err, count = 0, count2 = 0;
> +	int err, count = 0;
>  
>  	mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
>  		 entry->efd_count, entry->efd_group, entry);
> @@ -3606,7 +3606,6 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
>  	db = e4b.bd_info;
>  	/* there are blocks to put in buddy to make them really free */
>  	count += entry->efd_count;
> -	count2++;
>  	ext4_lock_group(sb, entry->efd_group);
>  	/* Take it out of per group rb tree */
>  	rb_erase(&entry->efd_node, &(db->bb_free_root));
> @@ -3631,8 +3630,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
>  	ext4_unlock_group(sb, entry->efd_group);
>  	ext4_mb_unload_buddy(&e4b);
>  
> -	mb_debug(sb, "freed %d blocks in %d structures\n", count,
> -		 count2);
> +	mb_debug(sb, "freed %d blocks in 1 structures\n", count);
>  }
>  
>  /*
> -- 
> 2.30.0
> 
If we always have 1 in the debug message, maybe we can change "structures"
to "structure". Other than that, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
