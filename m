Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5083754F6E
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Jul 2023 17:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjGPPmQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Jul 2023 11:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPPmP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Jul 2023 11:42:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F2410E
        for <linux-ext4@vger.kernel.org>; Sun, 16 Jul 2023 08:42:14 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36GFgEiP008610
        for <linux-ext4@vger.kernel.org>; Sun, 16 Jul 2023 15:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=oGBNG/vJzI4ZzwC5caQGbqM31qW3kZBwnUM7N+MSMA8=;
 b=qp2YWC+6lYoSy+APOMkGeiB83TIv3mnWztOb5qcC5I80eM4wyfmDBrGW/5r42EgrlL/F
 xc3CaOF7PHNUaS/440zJzO5Cxpz/8xAzmS4reawJeC1WjkHEamc/7nliIBwZHwDiCw17
 ilNDSJWzpotcgxRXGD1Tx+a1TcHJKpftCS0IHXWy5a3cjkyqfAgAgmzQazlDBmD5O3Kn
 FiJITzyHfkfPcGlz6oSTx1eDmmRaKwFkyO6KOpKJ8t04b9DJ6Q1aSek0popGvSj0q3n+
 9eIK2ri13KttVO3Pv53lN21RZ30p3DsQ8G6tOW+pZlUagYs1jRv3crUVj6CPsQyF/T5P pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rvh9fhby0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Sun, 16 Jul 2023 15:42:13 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36GFgD6P008559
        for <linux-ext4@vger.kernel.org>; Sun, 16 Jul 2023 15:42:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rvh9fhb15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 15:42:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36GDFVHM017202;
        Sun, 16 Jul 2023 15:37:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5srh39v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 15:37:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36GFbKGp21365362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jul 2023 15:37:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2756A20043;
        Sun, 16 Jul 2023 15:37:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2440820040;
        Sun, 16 Jul 2023 15:37:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.75.105])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 16 Jul 2023 15:37:18 +0000 (GMT)
Date:   Sun, 16 Jul 2023 21:07:16 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4: Don't use CR_BEST_AVAIL_LEN for non-regular files
Message-ID: <ZLQOrNLIsCC7aeuS@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <2a694c748ff8b8c4b416995a24f06f07b55047a8.1689516047.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a694c748ff8b8c4b416995a24f06f07b55047a8.1689516047.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CIRfGzBm7p6d5zygLdFJwNCCQV56hpvn
X-Proofpoint-ORIG-GUID: HbjavoAulIyDlaHeGALBRa5PT1Rxk6OY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-16_03,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=730 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307160147
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jul 16, 2023 at 07:33:34PM +0530, Ritesh Harjani (IBM) wrote:
> Using CR_BEST_AVAIL_LEN only make sense for regular files, as for
> non-regular files we never normalize the allocation request length i.e.
> goal len is same as original length (ac_g_ex.fe_len == ac_o_ex.fe_len).
> 
> Hence there is no scope of trimming the goal length to make it
> satisfy original request len. Thus this patch avoids using
> CR_BEST_AVAIL_LEN criteria for non-regular files request.
> 
> Fixes: 33122aa930f1 ("ext4: Add allocation criteria 1.5 (CR1_5)")
> Reported-by: Eric Whitney <enwlinux@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
Hi Ritesh,

patch looks good to me. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin.linux.ibm.com>

Regards,
ojaswin
>  fs/ext4/mballoc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 3ab37533349f..bc004f5d3f3c 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -975,7 +975,18 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
>  		*group = grp->bb_group;
>  		ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
>  	} else {
> -		*new_cr = CR_BEST_AVAIL_LEN;
> +		/*
> +		 * CR_BEST_AVAIL_LEN works based on the concept that we have
> +		 * a larger normalized goal len request which can be trimmed to
> +		 * a smaller goal len such that it can still satisfy original
> +		 * request len. However, allocation request for non-regular
> +		 * files never gets normalized.
> +		 * See function ext4_mb_normalize_request() (EXT4_MB_HINT_DATA).
> +		 */
> +		if (ac->ac_flags & EXT4_MB_HINT_DATA)
> +			*new_cr = CR_BEST_AVAIL_LEN;
> +		else
> +			*new_cr = CR_GOAL_LEN_SLOW;
>  	}
>  }
> 
> --
> 2.40.1
> 
