Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C11693FCA
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 09:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBMIil (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 03:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjBMIik (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 03:38:40 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3E64C0A;
        Mon, 13 Feb 2023 00:38:39 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8Ln7q004417;
        Mon, 13 Feb 2023 08:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=iW4QlO+M/Cz+2rOSOobCIw15xr8jaLQx/aOyS2Gq0gg=;
 b=YSX9H1EICtsiJ88lumzH9XaDvjIgVeo3FalFCbCZuUdaMo8QPnqeavQAZlDkIGwYhUvb
 BXa/i+SP5qPk5nUBeUeliRCxPaivHClZBE+EiA9VE2ixIGOTVeRlCVPk7gryqZjiFcR0
 pgNG7WjyYDSa0OtO1idSAPQnoYrR8E4Nn6Tft6B5Fplabehi/SxDd2pG+mI9AiPldrDn
 noovj5kGl7Qu7jy5yUgl9L3UmPd8CH5jVKZXy6ZT0S1IKOWbuvx1FUjnmYG/vnfDEmoC
 83VG2aMLcBm0qjBmKlL8hPIccn6FWRb5gUeUYt2z+LCStcrnoSPmgulBEsBttJxcsF1K 1w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqhmnr9x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 08:38:28 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31CImXIj010856;
        Mon, 13 Feb 2023 08:38:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6tcs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 08:38:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31D8cNDJ20382166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 08:38:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D7862004B;
        Mon, 13 Feb 2023 08:38:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A07620040;
        Mon, 13 Feb 2023 08:38:22 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 08:38:21 +0000 (GMT)
Date:   Mon, 13 Feb 2023 14:08:19 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/21] ext4: avoid to use preallocated blocks if
 EXT4_MB_HINT_GOAL_ONLY is set
Message-ID: <Y+n2+7pjkeb3vWQ7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-4-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-4-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fJdF6FuAx3eqb8yhNXj9yL7QAUim8BDK
X-Proofpoint-ORIG-GUID: fJdF6FuAx3eqb8yhNXj9yL7QAUim8BDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_04,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=794 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:07AM +0800, Kemeng Shi wrote:
> ext4_mb_use_preallocated will ignore the demand to alloc at goal block
> only. Return false if EXT4_MB_HINT_GOAL_ONLY is set before use
> preallocated blocks in ext4_mb_use_preallocated.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 375d9655b525..352ac9139fee 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4368,6 +4368,9 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
>  		return false;
>  
> +	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
> +		return false;
> +
>  	/* first, try per-file preallocation */
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
> -- 
> 2.30.0
> 
So with the flag, even when we request for a logical/goal block
combination that can be satisfied by one of the inode PAs in the list,
we would still exit early and the allocation would eventually fail since
the goal block would be marked "in-use" in the buddy. This doesn't seem
to be desirable.

Maybe instead of exiting early we should try to find a PA that satisfies
the logical block we are asking for and then incase of
EXT4_MB_HINT_GOAL_ONLY, we can add a check to see if the physical block
of the PA corresponds to the goal block. Would like to hear your
thoughts on this.

Regards,
ojaswin
