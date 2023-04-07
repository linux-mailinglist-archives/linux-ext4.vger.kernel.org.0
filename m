Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65F06DABE8
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Apr 2023 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjDGLBk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Apr 2023 07:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbjDGLB1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Apr 2023 07:01:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15156A5CD;
        Fri,  7 Apr 2023 04:01:16 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337AuJjE012014;
        Fri, 7 Apr 2023 11:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sHT4lAySk1ihuBjcDkSnNv9OFUtg3scTS44U/D5mJwA=;
 b=oRFA7InHEH722uLoUWRVajwD5hX3XF6VBwS0M6kWxlnIrqMDj2Pj2o3WbSAQ+T+JasC+
 Rs1nFWfO+8yOzo17twn67wRjktXhi2FxzWzNQtHRNjRNnr1Mpfjl6ieNJRNZfQOV5251
 PX8h9h5E6mUnQRHa0kKftgn0p0shq/+GDVe3nx+fOQPwb5V597k33AnCxQYlsQfZ7wkZ
 q96hmEWEi1rfRw1rzsu4iCdnzKkfIXCeYRJKhVi3vIB+y8SzgwlQIxbHVaweN2bcMZzu
 c4KsG/0nTwG+QUaT+rJZUTS7FREQOmDboqcVVyIGngrQ3+yilUtYvF2Efa3PhRQKFK3p 2A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pthutg27f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:01:05 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 337AhkcQ030740;
        Fri, 7 Apr 2023 11:00:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ppc86unx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:00:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 337B0Zux31523512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 11:00:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D56020043;
        Fri,  7 Apr 2023 11:00:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B9672004E;
        Fri,  7 Apr 2023 11:00:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.66.68])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 11:00:33 +0000 (GMT)
Date:   Fri, 7 Apr 2023 16:30:31 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] ext4: fix wrong unit use in ext4_mb_normalize_request
Message-ID: <ZC/3z7wLCDbwtlQG@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
 <20230321161220.418652-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321161220.418652-2-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: szC-kS_ZSoIGzpRG8iUDhAnjlHTVsN-X
X-Proofpoint-GUID: szC-kS_ZSoIGzpRG8iUDhAnjlHTVsN-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070100
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 22, 2023 at 12:12:13AM +0800, Kemeng Shi wrote:
> NRL_CHECK_SIZE will compare input req and size, so req and size should
> be in same unit. Input req "fe_len" is in cluster unit while input
> size "(8<<20)>>bsbits" is in block unit. Convert "fe_len" to block
> unit to fix the mismatch.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 63a68cee36c6..6318c763a239 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4056,7 +4056,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
>  							(22 - bsbits)) << 22;
>  		size = 4 * 1024 * 1024;
> -	} else if (NRL_CHECK_SIZE(ac->ac_o_ex.fe_len,
> +	} else if (NRL_CHECK_SIZE(EXT4_C2B(sbi, ac->ac_o_ex.fe_len),
>  					(8<<20)>>bsbits, max, 8 * 1024)) {
>  		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
>  							(23 - bsbits)) << 23;
> -- 
> 2.30.0
> 

Hi Kemeng,

So I ran xfstests with bigalloc on Powerpc (64k pagesize/64k blocksize &
64k pagesize/4k blocksize) and everything looks good.

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

