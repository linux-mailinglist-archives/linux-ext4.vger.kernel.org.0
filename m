Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73B7243C82
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHMPbg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 11:31:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726334AbgHMPbb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Aug 2020 11:31:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DFV6Is127396;
        Thu, 13 Aug 2020 11:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=7iIwFrCd5jcvRsetFMxktC7T1Id4PjhLGN1t/IGGTEw=;
 b=O9GYiiIDtsa8wwM/7yau8kwuHbBRUsREM6Ehg5YS3fNzGvy5r8n6FVNhwmrUCRYQtaXi
 bN4Fh4lf9JI+5xFQZkK5c9KATjBPZdJMc+ckfys/TAyuU31NYVnS5LtczKYmODSdH1oS
 V6q4/QpjGP16WSo5FESDSQ5vQF+IsqwVFwQI8LI1wfLK/g646ZuiLCF7OdII0vNaiwUm
 x+P4eoY2GbkXdyRgurKB4o9tMJmzANnOdYhGiHKAsNuedaj3HLwDYqlzbkZzXDC95TnI
 CtcGuqy/lbmIC5ZfvmdPPqQVB/0lw6tgGmTxFTsuEd7VtJ/MmZAQuKYeslN8pT5Ha41y vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w0n0qxfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:31:27 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DFVPWL129515;
        Thu, 13 Aug 2020 11:31:26 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w0n0qxde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:31:25 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DFPWkH027446;
        Thu, 13 Aug 2020 15:31:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 32skp7uh4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 15:31:22 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DFVKfk16515372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 15:31:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17590A4053;
        Thu, 13 Aug 2020 15:31:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50611A405B;
        Thu, 13 Aug 2020 15:31:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Aug 2020 15:31:19 +0000 (GMT)
Subject: Re: [PATCH] ext4: optimize the implementation of ext4_mb_good_group()
To:     brookxu <brookxu.cn@gmail.com>, adilger.kernel@dilger.ca,
        tytso@mit.edu, linux-ext4@vger.kernel.org
References: <e20b2d8f-1154-adb7-3831-a9e11ba842e9@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 13 Aug 2020 21:01:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e20b2d8f-1154-adb7-3831-a9e11ba842e9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200813153119.50611A405B@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_14:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 suspectscore=2 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130114
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/7/20 7:31 PM, brookxu wrote:
> It might be better to adjust the code in two places:
> 1. Determine whether grp is currupt or not should be placed first.
> 2. (cr<=2 && free <ac->ac_g_ex.fe_len)should may belong to the crx
>     strategy, and it may be more appropriate to put it in the
>     subsequent switch statement block. For cr1, cr2, the conditions
>     in switch potentially realize the above judgment. For cr0, we
>     should add (free <ac->ac_g_ex.fe_len) judgment, and then delete
>     (free / fragments) >= ac->ac_g_ex.fe_len), because cr0 returns
>     true by default.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>


Nice cleanup. This makes it less confusing :)

Logic looks fine to me.
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/mballoc.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 28a139f..4304113 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2119,13 +2119,11 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
> 
>   	BUG_ON(cr < 0 || cr >= 4);
> 
> -	free = grp->bb_free;
> -	if (free == 0)
> -		return false;
> -	if (cr <= 2 && free < ac->ac_g_ex.fe_len)
> +	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
>   		return false;
> 
> -	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
> +	free = grp->bb_free;
> +	if (free == 0)
>   		return false;
> 
>   	fragments = grp->bb_fragments;
> @@ -2142,8 +2140,10 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
>   		    ((group % flex_size) == 0))
>   			return false;
> 
> -		if ((ac->ac_2order > ac->ac_sb->s_blocksize_bits+1) ||
> -		    (free / fragments) >= ac->ac_g_ex.fe_len)
> +		if (free < ac->ac_g_ex.fe_len)
> +			return false;
> +
> +		if (ac->ac_2order > ac->ac_sb->s_blocksize_bits+1)
>   			return true;
> 
>   		if (grp->bb_largest_free_order < ac->ac_2order)
> 
