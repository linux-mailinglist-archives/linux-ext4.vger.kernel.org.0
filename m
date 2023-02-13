Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59680693FD1
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 09:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBMInE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 03:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBMInD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 03:43:03 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C695B775;
        Mon, 13 Feb 2023 00:43:02 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D7xgbK004245;
        Mon, 13 Feb 2023 08:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=SQO+Y5aVpcbnpSCkCwLdw9OJ9Tq2Ic/kqk6N9Te4vfM=;
 b=luA+8pq+zoraIo8IAJGJnMYOgFRcnZOf48IQDpKLmi4ibHs9IyZQtOTjPHSs/xzGWzhZ
 nQjWRC7tdMyn08MQmcMH330JUg8vVrdiPi6uhYIfnwOHxMY/BTn6HFaI1Xga+FOGYVdg
 hEHx0y3oA1i1dYFrvn6bP21vKVIWFzeyrbKKFb8f0kTNTa0iDV3ZYnJK75l9HAk49CCf
 /ruvE+141HzrRyRgRIar9GMF2xrMHLlySiSCIZpaiZxQYzLkxNnae3BE3ESBoKNhbudi
 A4paCeyDP7jF+NuuLV1tHNspFKhQPnmC8XkusI5kok6WZDI5bECogunPz9FPJ1Oz5lMH PA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqha28xhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 08:42:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31CIUfP9031193;
        Mon, 13 Feb 2023 08:42:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3np29fjdej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 08:42:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31D8gpwx42729836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 08:42:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C22F20049;
        Mon, 13 Feb 2023 08:42:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D03620040;
        Mon, 13 Feb 2023 08:42:49 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 08:42:49 +0000 (GMT)
Date:   Mon, 13 Feb 2023 14:12:46 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/21] ext4: protect pa->pa_free in
 ext4_discard_allocated_blocks
Message-ID: <Y+n4Bgph6QpjU8m+@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-8-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-8-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZPFEQGeuuNleqb69f1HLK6oA1D4Gruz8
X-Proofpoint-GUID: ZPFEQGeuuNleqb69f1HLK6oA1D4Gruz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_04,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:11AM +0800, Kemeng Shi wrote:
> If ext4_mb_mark_diskspace_used fails in ext4_mb_new_blocks, we may
> discard pa already in list. Protect pa with pa_lock to avoid race.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 433337ac8da2..4e1caac74b44 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4263,8 +4263,11 @@ static void ext4_discard_allocated_blocks(struct ext4_allocation_context *ac)
>  		ext4_mb_unload_buddy(&e4b);
>  		return;
>  	}
> -	if (pa->pa_type == MB_INODE_PA)
> +	if (pa->pa_type == MB_INODE_PA) {
> +		spin_lock(&pa->pa_lock);
>  		pa->pa_free += ac->ac_b_ex.fe_len;
> +		spin_unlock(&pa->pa_lock);
> +	}
>  }
>  
>  /*
> -- 
> 2.30.0
> 
Looks correct. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 

