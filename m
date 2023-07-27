Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BCE764685
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 08:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjG0GN6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jul 2023 02:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjG0GN5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jul 2023 02:13:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF1C1;
        Wed, 26 Jul 2023 23:13:55 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R5YBNj006381;
        Thu, 27 Jul 2023 05:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=XpsdMt1sFgTg69/LY+BKyfJs5QOVuIEG+ovPEwfU5R8=;
 b=J3rvE4I9R+6NeGsGft1bAwxR7jBgYJs9Myxfre3JWCII2tD6fntm5TBCQ1kTlVVH+TB+
 z0QNjPV0F4jYHNTBH3TocNwBGuH0gm0GEiHi+A0b3jffTM3ZetoTLuc7RFpmY35BJSc1
 AyI0g1lPDIoQlGbd3lHAzI2qosVu1iquY9v6/he+eeEzcKTAGPJOYTbjA0+39+H3mGhO
 yad1myGy8fIl01MTDjPMsTG+kmibLQ8cx4696VAa6cjXJZvr2IaMhe7j9MPVxuKo3D6i
 hMEXzsr8xks2IeX3ilKucELbHQAHToiTuxbEUlNh7MDULmcIQkJq0myDIZIy7CtdFmaD VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3jdqr7gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 05:36:11 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36R5QjAm016488;
        Thu, 27 Jul 2023 05:36:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3jdqr7ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 05:36:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36R4KnTq002079;
        Thu, 27 Jul 2023 05:36:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0tenaut2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 05:36:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36R5a73X23266012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 05:36:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76D5D2004E;
        Thu, 27 Jul 2023 05:36:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F19B02004B;
        Thu, 27 Jul 2023 05:36:05 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Jul 2023 05:36:05 +0000 (GMT)
Date:   Thu, 27 Jul 2023 11:06:03 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] ext4: correct some stale comment of criteria
Message-ID: <ZMICQ52W8HTUpvTX@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230725185106.2147273-1-shikemeng@huaweicloud.com>
 <20230725185106.2147273-11-shikemeng@huaweicloud.com>
 <ZMEyxLauFkXBwgUZ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <5db4b292-fee8-9581-841c-206ba10d4b80@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5db4b292-fee8-9581-841c-206ba10d4b80@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3ZRPvx6DLO9c6X_PNXKfVc1EWHWrz0kZ
X-Proofpoint-ORIG-GUID: LHTJWGkoK2v7DrjYbhq-6-elyHpKcbmt
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 27, 2023 at 09:29:11AM +0800, Kemeng Shi wrote:
> 
> 
> on 7/26/2023 10:50 PM, Ojaswin Mujoo wrote:
> > On Wed, Jul 26, 2023 at 02:51:06AM +0800, Kemeng Shi wrote:
> >> We named criteria with CR_XXX, correct stale comment to criteria with
> >> raw number.
> > 
> > Hi Kemeng,
> > 
> > Thanks for the cleanups.
> > 
> >>
> >> Fixes: f52f3d2b9fba ("ext4: Give symbolic names to mballoc criterias")
> >> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> >> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  fs/ext4/mballoc.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> >> index 36eea63eaace..de5da76e6748 100644
> >> --- a/fs/ext4/mballoc.c
> >> +++ b/fs/ext4/mballoc.c
> >> @@ -2777,8 +2777,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> >>  
> >>  	/*
> >>  	 * ac->ac_2order is set only if the fe_len is a power of 2
> >> -	 * if ac->ac_2order is set we also set criteria to 0 so that we
> >> -	 * try exact allocation using buddy.
> >> +	 * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
> >> +	 * so that we try exact allocation using buddy.
> >>  	 */
> >>  	i = fls(ac->ac_g_ex.fe_len);
> >>  	ac->ac_2order = 0;
> >> @@ -2835,8 +2835,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> >>  			/*
> >>  			 * Batch reads of the block allocation bitmaps
> >>  			 * to get multiple READs in flight; limit
> >> -			 * prefetching at cr=0/1, otherwise mballoc can
> >> -			 * spend a lot of time loading imperfect groups
> >> +			 * prefetching at cr below CR_FAST, otherwise mballoc
> > 
> > One of my earlier patchset has replaced the CR_FAST macro with
> > ext4_mb_cr_expensive() so maybe we can account for that here:
> > 
> > https://lore.kernel.org/linux-ext4/20230630085927.140137-1-ojaswin@linux.ibm.com/
> > 
> Hi Ojaswin, sorry for missing this. I still could not find the comment update
> of stale comment "limit prefetching at cr=0/1" in that patch. Maybe we could
> update comment to "prefetching at inexpensive CR, otherwise ...". What do
> you think. Or did I miss anything.

Hey Kemeng,

That's right I missed the update but just wanted to let you know that
CR_FAST would be removed. "prefetching at inexpensive CRs, ..."  sounds
good to me.

Regards,
ojaswin
> 
> -- 
> Best wishes
> Kemeng Shi
> > Regards,
> > ojaswin
> > 
> >> +			 * can spend a lot of time loading imperfect groups
> > 
> >>  			 */
> >>  			if ((prefetch_grp == group) &&
> >>  			    (cr >= CR_FAST ||
> >> -- 
> >> 2.30.0
> >>
> >
> 
