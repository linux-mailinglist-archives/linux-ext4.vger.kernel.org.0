Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71D4693E8C
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 07:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBMG5d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 01:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjBMG5c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 01:57:32 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0967ACC0B;
        Sun, 12 Feb 2023 22:57:30 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D4E8Da026676;
        Mon, 13 Feb 2023 06:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RPSx18UwPMm6YSKTVw6dtYFBjOCwXvJOZ6oNUiv5vTs=;
 b=eQ7XPeO+hUT0d2ngO/dOFl99pxFaI3ryumgfthScIMofnx0mMl1Ixc3tPccIz8n//bGp
 hqNY/bBRFzWsWVFI3zaS3ngBkr5ZbHvawy17p0fKuFaj8YBhVw8OlyTduPZylUJyN0UT
 4yklwKDuPstWOT8X2U6HntjYDpKQTFK7YTKqepXQTdztd49infElMvoliPX9AYOKL/o7
 Tc9tC41N8YG1SvpafcclM2w7Rg/sAypypsSmXZPrxHm26EifVoaYP4CZNyjTG5aqcWiB
 uABtdzkRrYOsYgzgY0Y5/QQNaZYdR4aogLYGvqLaBCps+WCORC1prvoPi7jUcdgVkbuu 4g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq35bkwct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 06:57:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31CIWW9Q029878;
        Mon, 13 Feb 2023 06:57:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3np29fj9c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 06:57:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31D6vGFL47645056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 06:57:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E9862004D;
        Mon, 13 Feb 2023 06:57:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C67D20040;
        Mon, 13 Feb 2023 06:57:14 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 06:57:14 +0000 (GMT)
Date:   Mon, 13 Feb 2023 12:27:11 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/21] ext4: allow to find by goal if
 EXT4_MB_HINT_GOAL_ONLY is set
Message-ID: <Y+nfR+5egaE46Mrd@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-3-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-3-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _H5Gqw4o7dtEmsxsBrygB6VnzuTtWB0S
X-Proofpoint-ORIG-GUID: _H5Gqw4o7dtEmsxsBrygB6VnzuTtWB0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:06AM +0800, Kemeng Shi wrote:
> If EXT4_MB_HINT_GOAL_ONLY is set, ext4_mb_regular_allocator will only
> allocate blocks from ext4_mb_find_by_goal. Allow to find by goal in
> ext4_mb_find_by_goal if EXT4_MB_HINT_GOAL_ONLY is set or allocation
> with EXT4_MB_HINT_GOAL_ONLY set will always fail.
> 
> EXT4_MB_HINT_GOAL_ONLY is not used at all, so the problem is not
> found for now.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 0650a1dc870e..375d9655b525 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2162,7 +2162,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
>  	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
>  	struct ext4_free_extent ex;
>  
> -	if (!(ac->ac_flags & EXT4_MB_HINT_TRY_GOAL))
> +	if (!(ac->ac_flags & (EXT4_MB_HINT_TRY_GOAL | EXT4_MB_HINT_GOAL_ONLY)))
>  		return 0;
>  	if (grp->bb_free == 0)
>  		return 0;
Looks good to me, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
