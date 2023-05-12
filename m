Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E3B7000EC
	for <lists+linux-ext4@lfdr.de>; Fri, 12 May 2023 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbjELG4D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 02:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbjELG4C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 02:56:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6E7D873;
        Thu, 11 May 2023 23:56:02 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C6muFm003626;
        Fri, 12 May 2023 06:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=k6eQEwVkhHpVFgAToRNikXg7UybtiNVZ4Ox/Wo9gFn4=;
 b=afuIfYNV/CV/bea++cAGmUojjKZWyjkHKFQWXX0/a8BYrlHGPbSOol4x6Fgxit3fO8PM
 KazdkFF63STxX0NQ9uNQyzYD9T0q4/Qgm+twrVicUexXef8ZxXpbdx+r5wD3+cnizwZH
 iohvEem3kRPwX14m0nzGRoT0GVbns6JJGF8+3GskrKFN9EyMTlshGuxcatzTGCPruYS6
 WiV7kpC0nRT2HKsOmSVVLc9mUuBHmL2voA9g6fipw9p3bZp7cwJIOEurYClDY2wrfUJe
 S8DINSSpzen3f+7ItNkmjZctlF9an24FTgtQ48iufq9/bb1G5EbHpXFmbObXXXMgRYQy 5w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhg7cgvq9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 06:55:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34C1ceT6024739;
        Fri, 12 May 2023 06:37:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qf7nh25gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 06:37:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34C6bXBc23200300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 06:37:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4883F20043;
        Fri, 12 May 2023 06:37:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D86E820040;
        Fri, 12 May 2023 06:37:31 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.7.84])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 12 May 2023 06:37:31 +0000 (GMT)
Date:   Fri, 12 May 2023 12:07:29 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/19] ext4: fix wrong unit use in ext4_mb_clear_bb
Message-ID: <ZF3eqTUg7+No6vjI@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
 <20230417110617.2664129-11-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417110617.2664129-11-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ehlFx9-cTiO-Z2o7TmGiQMj3PWU3xf19
X-Proofpoint-GUID: ehlFx9-cTiO-Z2o7TmGiQMj3PWU3xf19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=983 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 07:06:08PM +0800, Kemeng Shi wrote:
> Function ext4_issue_discard need count in cluster. Pass count_clusters
> instead of count to fix the mismatch.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  fs/ext4/mballoc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 774f969b39d8..4a345e3c1c78 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6222,8 +6222,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  		 * them with group lock_held
>  		 */
>  		if (test_opt(sb, DISCARD)) {
> -			err = ext4_issue_discard(sb, block_group, bit, count,
> -						 NULL);
> +			err = ext4_issue_discard(sb, block_group, bit,
> +						 count_clusters, NULL);
>  			if (err && err != -EOPNOTSUPP)
>  				ext4_msg(sb, KERN_WARNING, "discard request in"
>  					 " group:%u block:%d count:%lu failed"
> -- 
> 2.30.0
> 
