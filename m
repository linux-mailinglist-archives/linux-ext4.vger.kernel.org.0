Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2947239253F
	for <lists+linux-ext4@lfdr.de>; Thu, 27 May 2021 05:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhE0DNW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 23:13:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234456AbhE0DNT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 May 2021 23:13:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R3407s072108;
        Wed, 26 May 2021 23:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Z7ib4nP+2xqCgM/Aq6MYwkMP4TlkDjzIOIT6pTUL6fM=;
 b=M4GBwm+G9SSa+dZ/MXSt4L35LhDRe2TYZOHa7jkpKtpyDNmzss8bhz2Lnidktz7ov/sk
 fyPykLRP7t6iSv5Tqsur/FVSuEXuJBcyzD+Q1fXCdLJ+1HOh/mkIf7O/DOc9JehqLPSG
 tnyPO9KVu/rIhrcFocR4y40KLSkrHCFfmzGoXoDdn0B4XsR8WFAUIDr5yE7FxM0dB2AB
 AfUq4GMSfUZU9qM7iT5XtKMNraBHNKvaS5oqFzBVAOvUGV/6VeEVW8+snAGOSQc23FgW
 fXOKECGdAONxgOAtEf5btZ2xdfX3CWh8Vn/gKoRUmSLw60zOgXBgTyyvVl3AjsTxnJ4Y Yg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38t2whgr15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 23:11:40 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14R392Li003171;
        Thu, 27 May 2021 03:11:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 38s1ssrgy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 03:11:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14R3BZrT27984258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 03:11:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89AD0A4040;
        Thu, 27 May 2021 03:11:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3225FA4053;
        Thu, 27 May 2021 03:11:35 +0000 (GMT)
Received: from localhost (unknown [9.85.91.152])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 May 2021 03:11:35 +0000 (GMT)
Date:   Thu, 27 May 2021 08:41:34 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Remy Card <card@masi.ibp.fr>,
        "David S. Miller" <davem@caip.rutgers.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] fs: ext4: namei: trivial: Fix a couple of small
 whitespace issues
Message-ID: <20210527031134.zqewpd2tqo7umoho@riteshh-domain>
References: <20210520125558.3476318-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520125558.3476318-1-lee.jones@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s-jjUVvTx-dlLQyaHuKN3uEBIpyem9Rb
X-Proofpoint-ORIG-GUID: s-jjUVvTx-dlLQyaHuKN3uEBIpyem9Rb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_01:2021-05-26,2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270019
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/05/20 01:55PM, Lee Jones wrote:

Hi Lee,

Thanks for your patch. I see we could a little better here.
There are several other checkpatch ERROR msgs in this file.
Care to fix all of those ERRORS within the same patch itself?

./scripts/checkpatch.pl -f fs/ext4/namei.c | sed -n '/ERROR/,/^$/p'

e.g. to list a few of them -
ERROR: do not use assignment in if condition
#1605: FILE: fs/ext4/namei.c:1605:
+               if ((bh = bh_use[ra_ptr++]) == NULL)

ERROR: space required after that ',' (ctx:VxV)
#1902: FILE: fs/ext4/namei.c:1902:
+                       struct buffer_head **bh,struct dx_frame *frame,
                                               ^

ERROR: space required after that ',' (ctx:VxV)
#2249: FILE: fs/ext4/namei.c:2249:
+       de = do_split(handle,dir, &bh2, frame, &fname->hinfo);
                            ^

ERROR: spaces required around that '=' (ctx:VxV)
#2288: FILE: fs/ext4/namei.c:2288:
+       int     dx_fallback=0;

-ritesh

> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Remy Card <card@masi.ibp.fr>
> Cc: "David S. Miller" <davem@caip.rutgers.edu>
> Cc: linux-ext4@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  fs/ext4/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index afb9d05a99bae..7e780cf311c5a 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1899,7 +1899,7 @@ static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
>   * Returns pointer to de in block into which the new entry will be inserted.
>   */
>  static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
> -			struct buffer_head **bh,struct dx_frame *frame,
> +			struct buffer_head **bh, struct dx_frame *frame,
>  			struct dx_hash_info *hinfo)
>  {
>  	unsigned blocksize = dir->i_sb->s_blocksize;
> @@ -2246,7 +2246,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
>  	if (retval)
>  		goto out_frames;
>
> -	de = do_split(handle,dir, &bh2, frame, &fname->hinfo);
> +	de = do_split(handle, dir, &bh2, frame, &fname->hinfo);
>  	if (IS_ERR(de)) {
>  		retval = PTR_ERR(de);
>  		goto out_frames;
> --
> 2.31.1
>
