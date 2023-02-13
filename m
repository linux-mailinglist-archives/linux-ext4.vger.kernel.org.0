Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC536950F9
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjBMTs0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjBMTs0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:48:26 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF44C1A;
        Mon, 13 Feb 2023 11:48:25 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DINf3C021619;
        Mon, 13 Feb 2023 19:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=d1tFLPXrbNvvWu9cPufctBsOFiSwOguAEb7uyG/PgBA=;
 b=apXchMhpK16CAiNOeGsz5ClGhuzNhuRhosf6LOzzwYyR20IqLOCTqhpV5W0OmTmHKtLC
 M+c5NXMD2Wk7us59U1n5virOzbO7UGoxFHdAU3/+iP4MW8H3gtPBwIk0er/Y4xaw9S5m
 CeSIFXgKM7eB/oQSX7SYGNDIgEt78RDeg0rFpywrjc+fVvlb3A8Oe1Ayqa/McAsZtyZn
 b5VcTYgVhOYVShDI+pDwG9oeYTSlwAuZBh6Yw2nH30vClWk6e6d2vjjicaO7/1gasM8g
 DgdCcdBLk2JV82ZojuC8W11iQBkXgvu5gJ1vNmpgmFIyy2v0aSEJljqr7BH27dawg74w 4A== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqtethth0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:48:12 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DJhMOV028289;
        Mon, 13 Feb 2023 19:48:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3np2n6a9gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:48:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJm8qF49545542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:48:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C9B220043;
        Mon, 13 Feb 2023 19:48:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B43A320040;
        Mon, 13 Feb 2023 19:48:06 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:48:06 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:18:03 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/21] ext4: Remove unnecessary release when memory
 allocation failed in ext4_mb_init_cache
Message-ID: <Y+qT83KMcIgkKjiB@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-11-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-11-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BsWrfuTIEM6w21C60u2ukSaXUgAYWXzX
X-Proofpoint-ORIG-GUID: BsWrfuTIEM6w21C60u2ukSaXUgAYWXzX
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

On Fri, Feb 10, 2023 at 03:48:14AM +0800, Kemeng Shi wrote:
> If we alloc array of buffer_head failed, there is no resource need to be
> freed and we can simpily return error.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index ad9e3b7d3198..15fc7105becc 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1168,10 +1168,8 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
>  	if (groups_per_page > 1) {
>  		i = sizeof(struct buffer_head *) * groups_per_page;
>  		bh = kzalloc(i, gfp);
> -		if (bh == NULL) {
> -			err = -ENOMEM;
> -			goto out;
> -		}
> +		if (bh == NULL)
> +			return -ENOMEM;
>  	} else
>  		bh = &bhs;
>  
> -- 
> 2.30.0
> 
Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
