Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B2484DA7
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 06:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiAEFfc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 00:35:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234116AbiAEFfc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 00:35:32 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2052Yp2j018062;
        Wed, 5 Jan 2022 05:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=3qg4v+t2I5NLloCwcu/qiMn3Ym3/8YHjkNLzx5jDGCE=;
 b=SnR9AQhBIBNQOeUiunjM0jqC2NmG6zyQz7/zYmywIXb2ubdyUQfCZXE8Dt95niBlDnnS
 HyRARAerz17dN0OWmrqNAqEtvDFPPG+GfIK4eKNcZwXoDCOEGw/tWSuGDbrqZOcKXgqy
 ufSbv35iuQnNK2RqkP+/zZ+n4akg4te2f2hrZEekb7sOxixhUNwMIrSr2IHuxDoa9iuw
 MjnPyDIUG8gwQ4YSM/6Am31qjDuejOTap8zSfYyuaJBBNMEpZgCqwmt6S93agJUDNqJr
 2ZU/m1CGra9WEodU+M4XyeudBOF+w6v1Z1JfJL9mYylPKFOQkdF0xfn5Oc5S+JE45cdW +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcp4t7pew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 05:35:29 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2055ZIrr008062;
        Wed, 5 Jan 2022 05:35:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcp4t7pea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 05:35:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2055Rl6N030118;
        Wed, 5 Jan 2022 05:35:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3dae7jxsh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 05:35:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2055ZNix33947914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jan 2022 05:35:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D02204C044;
        Wed,  5 Jan 2022 05:35:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 644664C040;
        Wed,  5 Jan 2022 05:35:23 +0000 (GMT)
Received: from localhost (unknown [9.43.73.10])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jan 2022 05:35:23 +0000 (GMT)
Date:   Wed, 5 Jan 2022 11:05:22 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     cgel.zte@gmail.com
Cc:     lczerner@redhat.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, xu.xin16@zte.com.cn, zealci@zte.com.cn
Subject: Re: [PATCH resend] fs/ext4: use BUG_ON instead of if condition
 followed by BUG
Message-ID: <20220105053522.ql7hg3luxn6gsp7m@riteshh-domain>
References: <20211220102421.sggplg54ncsafcpi@work>
 <20211228073252.580296-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228073252.580296-1-xu.xin16@zte.com.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bexbrjVTwIlMzZJksA276DUxvAZ6yax3
X-Proofpoint-GUID: WQHbT3TZNGECR_75HcaSHTUcCm_iJCoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_01,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 adultscore=0
 mlxlogscore=532 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050037
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/12/28 07:32AM, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
>
> BUG_ON would be better.

While we are at it, I feel correcting below BUG() in the same patch(es?)
might be useful too.

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bfd3545f1e5d..5656b4a9007b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1879,10 +1879,7 @@ static int __ext4_journalled_writepage(struct page *page,
                        goto out;
        } else {
                page_bufs = page_buffers(page);
-               if (!page_bufs) {
-                       BUG();
-                       goto out;
-               }
+               BUG_ON(!page_bufs);
                ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
                                       NULL, bget_one);
        }

-riteshh

>
> This issue was detected with the help of Coccinelle.
>
> Reported-by: Zeal robot <zealci@zte.com.cn>
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  fs/ext4/ext4.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9cc55bcda6ba..00bc3f67d37f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2400,8 +2400,7 @@ ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
>
>  static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
>  {
> -	if ((len > blocksize) || (blocksize > (1 << 18)) || (len & 3))
> -		BUG();
> +	BUG_ON((len > blocksize) || (blocksize > (1 << 18)) || (len & 3));
>  #if (PAGE_SIZE >= 65536)
>  	if (len < 65536)
>  		return cpu_to_le16(len);
> --
> 2.25.1
>
