Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2D3392510
	for <lists+linux-ext4@lfdr.de>; Thu, 27 May 2021 04:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhE0CvL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 22:51:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233942AbhE0CvK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 May 2021 22:51:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R2hERx097263;
        Wed, 26 May 2021 22:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0iSdH53yde7QZlYgxnw+cgGzLsxWCbFs5wz8WfelHW8=;
 b=Yra3u6Wdb5qA8dzE+EFqLxhvVfIe5MzpE305IlFDeRqwEXDg3GPlQTw85l+hAHJg2jkM
 w64RIftlgMPqy2Leq5aFQdUKVwMrA9xN2zggvPLEAfb6nRf85zUURzyXrkRg/R6n36bc
 hXAZ2pJrSQp5tXL/PfIV4iQ5xgkvzu15nBJfI9+uJT1o2njgEEN9EE4CDK8DTEbbA2sw
 4gE1siEN7G1WRvdoGA+Sil+yHteIAjjyB9ti43kMlkUvilDxvJaK1SbnuC47SzZjGVUR
 KZZI/eqlEdp3qvb0Dpov+HCxCOTrtjf1j1VhzsvZVoRGWQLyUyjOAtLQV9GDyCmCIgs0 jg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38t2vx05bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 22:49:32 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14R2mLBH007711;
        Thu, 27 May 2021 02:49:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 38s1r48x4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 02:49:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14R2nRKs25428430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 02:49:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AF784C040;
        Thu, 27 May 2021 02:49:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30BCF4C044;
        Thu, 27 May 2021 02:49:27 +0000 (GMT)
Received: from localhost (unknown [9.85.91.152])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 May 2021 02:49:27 +0000 (GMT)
Date:   Thu, 27 May 2021 08:19:26 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     chenyichong <chenyichong@uniontech.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use local variables ei instead of invoking function
 EXT4_I
Message-ID: <20210527024926.oqfxngkm4phgrim4@riteshh-domain>
References: <20210526052930.11278-1-chenyichong@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526052930.11278-1-chenyichong@uniontech.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: twk9c-cgpcFX2PAQQslN-EUYJSzJ0JJj
X-Proofpoint-GUID: twk9c-cgpcFX2PAQQslN-EUYJSzJ0JJj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_01:2021-05-26,2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270015
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/05/26 01:29PM, chenyichong wrote:

Thanks for the patch. Looks good to me.
Feel free to add

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> Signed-off-by: chenyichong <chenyichong@uniontech.com>
> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index fe6045a46599..a5c4cd1c757b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -374,7 +374,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
>  	ei->i_reserved_data_blocks -= used;
>  	percpu_counter_sub(&sbi->s_dirtyclusters_counter, used);
>
> -	spin_unlock(&EXT4_I(inode)->i_block_reservation_lock);
> +	spin_unlock(&ei->i_block_reservation_lock);
>
>  	/* Update quota subsystem for data blocks */
>  	if (quota_claim)
> --
> 2.20.1
>
>
>
