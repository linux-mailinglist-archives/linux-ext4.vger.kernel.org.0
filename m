Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469447428BE
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjF2Onr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjF2Onf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jun 2023 10:43:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936035B6;
        Thu, 29 Jun 2023 07:43:28 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TENCCU026321;
        Thu, 29 Jun 2023 14:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eiXTRdg0gT1rq2HTYY5jeBN/xLVc4P6F8V+u2KYIp/A=;
 b=rylkxOO0ibutXNGtCkKoKhHb4bY3sHcxi8ZX8LnIWEflamg2B/gsjGPp9UiP8A9ASdCg
 NbwVW43KJbJkTPwEb6jiwXomAzwnIYbZ0kwmTTw0drbReAwuiODGUdY8GMYFVysioJ/T
 tdQ2jzVfapxCEh57Oy+POTh+OXRm6NJSFRXmmm4cbRl4Z34tfrS2ciyRit+gf0xyfDtw
 eGwSh3sQH3U2Cxy3M/nwahWlJginnoePCbf4Ba9qEX7d0u8CGD96SDMd2/EtYAfvwwob
 P3zCxjKguCve8z3jk4Q2hXa5ajwCmpOp32w13tqQ+Ou1ritCBOq7K18cXE+uDdr/kQR2 Vg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhbnu8nfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:43:13 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35T9UexC018753;
        Thu, 29 Jun 2023 14:41:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr453ddk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:41:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35TEfgLs62521850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 14:41:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F91A2004B;
        Thu, 29 Jun 2023 14:41:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0331C20043;
        Thu, 29 Jun 2023 14:41:41 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.95.242])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Jun 2023 14:41:40 +0000 (GMT)
Date:   Thu, 29 Jun 2023 20:11:38 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>
Subject: Re: [PATCH] ext4: Replace CR_FAST macro with inline function for
 readability
Message-ID: <ZJ2YIr5EVbz4ezIc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230629134719.108104-1-ojaswin@linux.ibm.com>
 <20230629140018.duaaxqnxe55yfvqq@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629140018.duaaxqnxe55yfvqq@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GqgDT4e5Wf1eIZmML9vU-v-GLqi64ynT
X-Proofpoint-GUID: GqgDT4e5Wf1eIZmML9vU-v-GLqi64ynT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxlogscore=536 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 04:00:18PM +0200, Jan Kara wrote:
> On Thu 29-06-23 19:17:19, Ojaswin Mujoo wrote:
> > Replace CR_FAST with ext4_mb_cr_expensive() inline function for better
> > readability. This function returns true if the criteria is one of the
> > expensive/slower ones where lots of disk IO/prefetching is acceptable.
> > 
> > No functional changes are intended in this patch.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Thanks for this cleanup! Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Just one suggestion for consideration below:
> 
> > @@ -2630,7 +2630,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
> >  	free = grp->bb_free;
> >  	if (free == 0)
> >  		goto out;
> > -	if (cr <= CR_FAST && free < ac->ac_g_ex.fe_len)
> > +	if (cr <= CR_GOAL_LEN_SLOW && free < ac->ac_g_ex.fe_len)
> 
> Maybe this could be (!ext4_mb_cr_expensive(cr) || cr == CR_GOAL_LEN_SLOW)?
> Or maybe more explanatory would be (cr < CR_ANY_FREE) because AFAIU that's
> the only scan where we bother scanning groups that have no chance of
> satisfying the full allocation? Anyway a short comment explaining this
> might be useful. And in either case we can get rid of a bit confusing
> CR_FAST define.
> 
> 								Honza

Thanks for the review Jan! I actually had the same idea since it 
felt like (cr <= CR_GOAL_LEN_SLOW) doesnt clearly express the intent of this
check. I think I ultimately decided to leave it untouched to keep things
simple.

However, I like the idea of making it (cr < CR_ANY_FREE) with a comment
to explain the intent behind this condition. If it's fine with everyone I can
address it in v2.

Regards,
ojaswin
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
