Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD3695105
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjBMTs4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjBMTsx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:48:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D1B1717A;
        Mon, 13 Feb 2023 11:48:44 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DJNJoT020113;
        Mon, 13 Feb 2023 19:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=nTSRkp5G58BQ+8jkD2cJV+s/tsywDl3FRcLjTf2txLE=;
 b=LX+LH9bqbVs1wOn5vcqigh9XvOQQE3n8rJfeV98rxbe4/rZg9xjpxIUMynGzNS8TICxV
 +EuHF9wbMw4B6mFXWi+05OcSNAaK7kWJ/yDjdqHT2fBa3RdixHggay1LIl1T80+ALJKy
 3ba1cMD5yn/dNHr7VHdkT6TM9AGvzKT4pImh1GswaH9H3crcU6w90G+hKZTeNMBT5G3l
 XweXldwjVi3Ewr2dkfUmwlB90yMG8G3+WUFv5bYCzPyMIFoOUWLa+o0jLVJLlzD3dpY8
 CsBVqm8tXG96+pUWp48SxXtQJs/bIkx/fC4q4XOLxEMWsNEFRlTx9jpHLjn2jf6hDcJS YA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nquam8jua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:48:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DCxTAU017665;
        Mon, 13 Feb 2023 19:48:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6k2cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:48:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJmXxd41550116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:48:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E92F420043;
        Mon, 13 Feb 2023 19:48:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5992720040;
        Mon, 13 Feb 2023 19:48:31 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:48:31 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:18:28 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/21] ext4: remove unnecessary e4b->bd_buddy_page check
 in ext4_mb_load_buddy_gfp
Message-ID: <Y+qUDCseZoFoYFyj@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-12-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-12-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bpgn2eqONWbRhlB0Zkecodf25clr0lSv
X-Proofpoint-ORIG-GUID: Bpgn2eqONWbRhlB0Zkecodf25clr0lSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=908 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:15AM +0800, Kemeng Shi wrote:
> e4b->bd_buddy_page is only set if we initialize ext4_buddy successfully. So
> e4b->bd_buddy_page is always NULL in error handle branch. Just remove the
> dead check.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 15fc7105becc..74da24c9bf14 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1555,8 +1555,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
>  		put_page(page);
>  	if (e4b->bd_bitmap_page)
>  		put_page(e4b->bd_bitmap_page);
> -	if (e4b->bd_buddy_page)
> -		put_page(e4b->bd_buddy_page);
> +
>  	e4b->bd_buddy = NULL;
>  	e4b->bd_bitmap = NULL;
>  	return ret;
> -- 
> 2.30.0
> 
Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
