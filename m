Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA06D86CE
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 21:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjDET0p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 15:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjDET0j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 15:26:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3716E81;
        Wed,  5 Apr 2023 12:26:38 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335H9bnK006737;
        Wed, 5 Apr 2023 19:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=S+33/pgyoxtd9MjBH4Z12tl+VNtdXnPUGY+UOZET5fk=;
 b=b82h+2aPiC5Bnm/2U6QNKDt20KCWdc2G2IpYpFAk/muKZSLKWdQwszcZlOLbWBvC8gUu
 Rox3n1NDnxZMFpPHvRJ6M4fQCsT6474G6zUZ9t7fcjXlydy5Xfn4bz5wQ4WQCbotF0A9
 Jvjj/T6GkzsvS8rgc3z90xsc8r+JudP0lxtvyG/zeoqI2nLx//xYiMEs+fOb86t12i/R
 1MzKy0bUmrux3MlRTqVGpiz91REezyxNtHQOY6EDOknHLgWGhzDcJq5WtSGyccsrMnVR
 4wcIwID83DXgMgjHpvlVZ+eODhMfZEopz3YzWA8JEBdD3MCBS0mt70zHMW7Dtzss1cEB Qw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3psaamyy09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 19:26:30 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3354LpMD003805;
        Wed, 5 Apr 2023 19:26:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ppbvftqt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 19:26:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335JQPFN28246714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 19:26:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A23220043;
        Wed,  5 Apr 2023 19:26:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA9FA20040;
        Wed,  5 Apr 2023 19:26:23 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.12.224])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 19:26:23 +0000 (GMT)
Date:   Thu, 6 Apr 2023 00:56:21 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] ext4: fix wrong unit use in ext4_mb_new_inode_pa
Message-ID: <ZC3LXYKjp5zwYfO1@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
 <20230321161220.418652-4-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321161220.418652-4-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qewt5pUpOTtzDUTJsSFEgoklDhcmgBWd
X-Proofpoint-ORIG-GUID: Qewt5pUpOTtzDUTJsSFEgoklDhcmgBWd
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_13,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=895 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050170
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 22, 2023 at 12:12:15AM +0800, Kemeng Shi wrote:
> fe_logical and win are both in block unit. Remove wrong convertion for
> win from block unit to cluster unit.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 7f695830621a..86d978e1f7dc 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4640,8 +4640,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  		if (offs && offs < win)
>  			win = offs;
>  
> -		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical -
> -			EXT4_NUM_B2C(sbi, win);
> +		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical - win;
>  		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>  		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);

So this bit of code is removed in the patchset I sent here [1]. My patchset
is mostly ready to be merged and Ted did mention that he was going to
pick that up soon. So would it be okay with you if we drop this particular patch?

[1]
https://lore.kernel.org/linux-ext4/9b35f3955a1d7b66bbd713eca1e63026e01f78c1.1679731817.git.ojaswin@linux.ibm.com
>  	}
> -- 
> 2.30.0
> 
