Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F13695134
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBMT7S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjBMT7P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:59:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827759EE1;
        Mon, 13 Feb 2023 11:59:11 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DJt7vZ007971;
        Mon, 13 Feb 2023 19:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=s9sdLbMr05WxW9bAxlL+lTboeXzneabh/3OIEeH86xM=;
 b=Cv9Jl7yYr2Yt9aBuQKXPNE0QtKytJ+/wXRZ7po0sfDzzbnGOtMNQOiUYE7yt65JVV3M5
 9Q4+V2S6BqPIX0cPIb8d8c2x4jiu79KkC8ti6Ion9t0uhUbiYGN53ADUie2slgbd3YXI
 CfSHRpUMxloCE0RnZR+6Pz8m/pRzIJuIElB9gogupjmgC8eZjSvWh2U6r8FzLyKIEmaz
 LQU3exbVE0SJuwGcQMwmlIhx+PglkVDkRF/79omsJ8rinN2mQkEnzSprL22HogQAprkG
 W2Uaz/IoTONwRaSnUGwSDHfwDNDYBZSBkLQmIqGYgEEkkBfpO0gpkDtY4IMfPkPH9UbG FQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqusd01r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:59:03 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8Wiru008524;
        Mon, 13 Feb 2023 19:59:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3np2n6a9ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:59:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJwxOU22544654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:58:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ACC720043;
        Mon, 13 Feb 2023 19:58:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DF5220040;
        Mon, 13 Feb 2023 19:58:57 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:58:57 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:28:54 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/21] ext4: remove unnecessary goto in
 ext4_mb_mark_diskspace_used
Message-ID: <Y+qWfqUC1tF3b06F@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-19-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-19-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D2DfmWTk1EHLyQriGECVYbfupqxCOZEi
X-Proofpoint-GUID: D2DfmWTk1EHLyQriGECVYbfupqxCOZEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=968 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:22AM +0800, Kemeng Shi wrote:
> When ext4_read_block_bitmap fails, we can return PTR_ERR(bitmap_bh) to
> remove unnecessary NULL check of bitmap_bh.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f9fc461b633f..7d6991af50d8 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3739,9 +3739,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  
>  	bitmap_bh = ext4_read_block_bitmap(sb, ac->ac_b_ex.fe_group);
>  	if (IS_ERR(bitmap_bh)) {
> -		err = PTR_ERR(bitmap_bh);
> -		bitmap_bh = NULL;

It's probably trivial but the fact that we no longer have `bitmap_bh =
NULL` is making me a bit paranoid. Although I think it should be
okay but maybe someone else can help double check this :)

> -		goto out_err;
> +		return PTR_ERR(bitmap_bh);
>  	}
>  
>  	BUFFER_TRACE(bitmap_bh, "getting write access");
> -- 
> 2.30.0
> 

