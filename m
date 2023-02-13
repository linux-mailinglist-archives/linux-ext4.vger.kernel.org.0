Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA82693E87
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 07:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBMG5J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 01:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBMG5I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 01:57:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1364E10279;
        Sun, 12 Feb 2023 22:57:05 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D4JuCK024077;
        Mon, 13 Feb 2023 06:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=OABYe9h6yV6EEvAXQLdjL9ipo9yPBk2jCz1SEalZNBs=;
 b=TdVaGtshogv1wFal55wu3eyySKOSSVStk33R+ehT1w1FW15taM88Wc2QiJRfp/czwrNu
 uAemYOEUsmYBD8VUhUZxqvrXIqcNKRK4ZjM+5eMIDk3YMfNOVQcqAKBuNkJOEQpf8Kke
 3FEihso2HufeyBPn6xnP8Trhbe962tXyPWOUpjgqeXWKZO0wSLK4TbBJfoYTVvSXQtIs
 bCo0mFlNG60gxtss4CBlbaqf3daSK7di7XqVdHiNHlGrgq1UC1KyEhtEeXJY0Lx4ID7+
 jWIgkV+PB0pM/FEFnmM8v4Qd5eEuifb/mlw0m37ZyTP/L32O3zr5YLgra9V9wSA10mVS lw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq4ftawh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 06:56:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31CJA7xb018185;
        Mon, 13 Feb 2023 06:56:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6j883-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 06:56:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31D6ujtG37749022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 06:56:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACF9420043;
        Mon, 13 Feb 2023 06:56:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 103CB20040;
        Mon, 13 Feb 2023 06:56:44 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 06:56:43 +0000 (GMT)
Date:   Mon, 13 Feb 2023 12:26:38 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] ext4: set goal start correctly in
 ext4_mb_normalize_request
Message-ID: <Y+nfJrIWy9CBWDW/@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-2-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G9C0fJfRKLKkoTZkKV_lji38oRtgyRGP
X-Proofpoint-ORIG-GUID: G9C0fJfRKLKkoTZkKV_lji38oRtgyRGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=856 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:05AM +0800, Kemeng Shi wrote:
> We need to set ac_g_ex to notify the goal start used in
> ext4_mb_find_by_goal. Set ac_g_ex instead of ac_f_ex in
> ext4_mb_normalize_request.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5b2ae37a8b80..0650a1dc870e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4191,15 +4191,15 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	if (ar->pright && (ar->lright == (start + size))) {
>  		/* merge to the right */
>  		ext4_get_group_no_and_offset(ac->ac_sb, ar->pright - size,
> -						&ac->ac_f_ex.fe_group,
> -						&ac->ac_f_ex.fe_start);
> +						&ac->ac_g_ex.fe_group,
> +						&ac->ac_g_ex.fe_start);
>  		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
>  	}
>  	if (ar->pleft && (ar->lleft + 1 == start)) {
>  		/* merge to the left */
>  		ext4_get_group_no_and_offset(ac->ac_sb, ar->pleft + 1,
> -						&ac->ac_f_ex.fe_group,
> -						&ac->ac_f_ex.fe_start);
> +						&ac->ac_g_ex.fe_group,
> +						&ac->ac_g_ex.fe_start);
>  		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
>  	}

Hi Kemeng,

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 

