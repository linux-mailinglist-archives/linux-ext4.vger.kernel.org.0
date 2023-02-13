Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B11693E9D
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 08:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBMHFC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 02:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBMHFA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 02:05:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FEC143;
        Sun, 12 Feb 2023 23:04:59 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D5MJSG023732;
        Mon, 13 Feb 2023 07:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=r/M7D3238awQAi3WCQ8nSW9eDbJKPdfuuRVOniBw+tE=;
 b=KRY6suI+Q0NpBCdkjlz6f+PbwKAjHfCc/D7pAeomNwaKaZKJMqkA15g0xeFIPVCL7Iwr
 Y21wiAS2DUaKu8L7FcbQkXjZ5wPnyjFMvZJkYeWA2m7tXN7b8Av4sHNmPU3DntQbC/be
 Eg6aPBLfxD/0ev2RRZgpWjTiDmmLbIcU30KVCKpvaUF/gI0ypaY2TdpaQKXb9TncATna
 0OAf8LZGQJFg7algc76cknjpg7K5ARWkLwAxbmwI3xJkZmwOo1DJn9lIh2udxV4/vyev
 nbypCkQ8hPMfW8NWy2M24ND9TzzoMFhazCFMPlZ+v9YDSBXOCNLdttV2lv90TMoZW64U ow== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq4ftb32d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:04:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31CLvO7U009809;
        Mon, 13 Feb 2023 07:04:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6j8hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:04:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31D74jDA44892516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 07:04:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1745220040;
        Mon, 13 Feb 2023 07:04:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C5BB20049;
        Mon, 13 Feb 2023 07:04:43 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 07:04:43 +0000 (GMT)
Date:   Mon, 13 Feb 2023 12:34:41 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/21] ext4: correct calculation of s_mb_preallocated
Message-ID: <Y+nhCUVbH0IA2FwV@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-6-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-6-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SVSXxTIDfPy4kA8Ljn4f94aKDEJmkgre
X-Proofpoint-ORIG-GUID: SVSXxTIDfPy4kA8Ljn4f94aKDEJmkgre
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=824 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:09AM +0800, Kemeng Shi wrote:
> We will add pa_free to s_mb_preallocated when new ext4_prealloc_space is
> created. In ext4_mb_new_inode_pa, we will call ext4_mb_use_inode_pa
> before adding pa_free to s_mb_preallocated. However, ext4_mb_use_inode_pa
> will consume pa_free for block allocation which triggerred the creation
> of ext4_prealloc_space. Add pa_free to s_mb_preallocated before
> ext4_mb_use_inode_pa to correct calculation of s_mb_preallocated.
> There is no such problem in ext4_mb_new_group_pa as pa_free of group pa
> is consumed in ext4_mb_release_context instead of ext4_mb_use_group_pa.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f24f80ecf318..2bffc93778d5 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4670,8 +4670,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  		 pa->pa_len, pa->pa_lstart);
>  	trace_ext4_mb_new_inode_pa(ac, pa);
>  
> -	ext4_mb_use_inode_pa(ac, pa);
>  	atomic_add(pa->pa_free, &sbi->s_mb_preallocated);
> +	ext4_mb_use_inode_pa(ac, pa);
>  
>  	ei = EXT4_I(ac->ac_inode);
>  	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
> -- 
> 2.30.0
> 
My understanding is that s_mb_preallocated is for all the blocks we ever preallocated and
so we need to add 'original' pa_len instead of (pa_len - best_len).

Hence, the patch looks correct to me. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
