Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E193693E9B
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 08:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBMHD5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 02:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjBMHD4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 02:03:56 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42BC14F;
        Sun, 12 Feb 2023 23:03:54 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D5UrWG035729;
        Mon, 13 Feb 2023 07:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=VY7rrcyZhm9Q1n82vryXuh/a7XCLDqRWKNm4tkoW5JU=;
 b=mUDWMk53ch2s0qsZui7oVnQSVfB8AWkZCaEEDzhsi6Snu0RMndaFb88jf8MzordC2an0
 06c+MDpYOVcQCjOmt7LqL/yZKGEjcVhzZf8DstKeARcX1ObkuFiruBjKy07Buv9saWvB
 iorFIh2l7wTslyKSkM+QKfDIJX+u1kF9Gu+1feyZeRWpHu962hs1VbfbC04Cn57kQcs+
 O23T46FpyU4tQGfS84hpFQ/9A2tVc45Hfq5DtzLStZII3sP4XnmckkYuSietTkfip68Y
 8DhDWoxEcGwA6S7miKHQKKIVG/6kf+5nuaf9ORl7xP0tyxLU1qmtz3wh2BRSyzMKo6G6 iA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3npyney5r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:03:43 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31C55Gxc006567;
        Mon, 13 Feb 2023 07:03:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3np2n69pqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:03:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31D73dF721430730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 07:03:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F337A20040;
        Mon, 13 Feb 2023 07:03:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E65882004E;
        Mon, 13 Feb 2023 07:03:36 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 07:03:36 +0000 (GMT)
Date:   Mon, 13 Feb 2023 12:33:33 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/21] ext4: get correct ext4_group_info in
 ext4_mb_prefetch_fini
Message-ID: <Y+ngxf4fBbhPBHPk@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-5-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-5-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r6spHbpPppK5xUlN1c3Kz_FVhgpZ4p82
X-Proofpoint-GUID: r6spHbpPppK5xUlN1c3Kz_FVhgpZ4p82
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:08AM +0800, Kemeng Shi wrote:
> We always get ext4_group_desc with group + 1 and ext4_group_info with
> group to check if we need do initialize ext4_group_info for the group.
> Just get ext4_group_desc with group for ext4_group_info initialization
> check.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 352ac9139fee..f24f80ecf318 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2570,13 +2570,13 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
>  			   unsigned int nr)
>  {
>  	while (nr-- > 0) {
> -		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
> -								  NULL);
> -		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
> +		struct ext4_group_desc *gdp;
> +		struct ext4_group_info *grp;
>  
>  		if (!group)
>  			group = ext4_get_groups_count(sb);
>  		group--;
> +		gdp = ext4_get_group_desc(sb, group, NULL);
>  		grp = ext4_get_group_info(sb, group);
>  
>  		if (EXT4_MB_GRP_NEED_INIT(grp) &&
> -- 
> 2.30.0
> 

This is a duplicate of [1] :)

But I'm okay with this going in as that patchseries might take some time
to get merged. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 

[1] https://lore.kernel.org/r/85bbcb3774e38de65b737ef0000241ddbdda73aa.1674822311.git.ojaswin@linux.ibm.com
