Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5A695117
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBMTvg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBMTvf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:51:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86116AE4;
        Mon, 13 Feb 2023 11:51:22 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DJFYbb020109;
        Mon, 13 Feb 2023 19:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=tpEfbv2z030o3flFW11ptCJobA2BXDbyzFJ17dtcZQI=;
 b=rJwzYTztaqqgD4svo7KCfBg5cASGx1qXacvdtpIT4dl9D1f9z4wjUJoLLpvI8yXCdNL/
 RV84MVare8Gmx5lIeDqijRvFac2cGAw/nV1pc3Gox4tIPmpHogArEmLATVwxQVmVWtSJ
 pXaBEMWLIKjqef+kRKpszWjHBMoxyK989DsB82u80fbtJ91p/DtRutxh5OjE8fUFhg/+
 9eQf76pPFnuidBjxLUbwDSseOspczx4cMNaLMHDvw0zVcbzpFPX24H3g529wDIX15y2Q
 uEPbYsw3jazjZyOIGBwLW28UnMqxHPHHpyfDYh1G+l0mPC6nXXPO7XE6MPUj3/Tu0qoT DA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqu758nc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:51:14 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8dsuG008616;
        Mon, 13 Feb 2023 19:51:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3np2n6a9a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:51:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJp9vX40305012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:51:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C37D20043;
        Mon, 13 Feb 2023 19:51:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC24D20040;
        Mon, 13 Feb 2023 19:51:07 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:51:07 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:21:05 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/21] ext4: remove ac->ac_found > sbi->s_mb_min_to_scan
 dead check in ext4_mb_check_limits
Message-ID: <Y+qUqS323ucRFO5L@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-15-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-15-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vLvN53SdPqpk7LxcxkYuKnSPfKmdOsW2
X-Proofpoint-GUID: vLvN53SdPqpk7LxcxkYuKnSPfKmdOsW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:18AM +0800, Kemeng Shi wrote:
> Only call trace of ext4_mb_check_limits is as following:
> ext4_mb_complex_scan_group
> 	ext4_mb_measure_extent
> 		ext4_mb_check_limits(ac, e4b, 0);
> 	ext4_mb_check_limits(ac, e4b, 1);
> 
> If the first ac->ac_found > sbi->s_mb_max_to_scan check in
> ext4_mb_check_limits is met, we will set ac_status to
> AC_STATUS_BREAK and call ext4_mb_try_best_found to try to use
> ac->ac_b_ex.
> If ext4_mb_try_best_found successes, then block allocation finishs,
> the removed ac->ac_found > sbi->s_mb_min_to_scan check is not reachable.
> If ext4_mb_try_best_found fails, then we set EXT4_MB_HINT_FIRST and
> reset ac->ac_b_ex to retry block allocation. We will use any found
> free extent in ext4_mb_measure_extent before reach the removed
> ac->ac_found > sbi->s_mb_min_to_scan check.
> In summary, the removed ac->ac_found > sbi->s_mb_min_to_scan check is
> not reachable and we can remove that dead check.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 0fdbf16ac180..e53f84de5018 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2039,8 +2039,7 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
>  	if (bex->fe_len < gex->fe_len)
>  		return;
>  
> -	if ((finish_group || ac->ac_found > sbi->s_mb_min_to_scan)
> -			&& bex->fe_group == e4b->bd_group) {
> +	if (finish_group && bex->fe_group == e4b->bd_group) {
>  		/* recheck chunk's availability - we don't know
>  		 * when it was found (within this lock-unlock
>  		 * period or not) */
> -- 
> 2.30.0
> 
Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
