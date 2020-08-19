Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C36249448
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 07:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgHSFBG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 01:01:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63842 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725275AbgHSFBG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Aug 2020 01:01:06 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07J4XJua185997;
        Wed, 19 Aug 2020 01:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=3yCVTE2ZD0j285tr5W+PRQSHrD9xufwjMmZcd4j65H8=;
 b=Op9aaVBsLSHA/vIJ5U2+cRJr821ywvlCTrxpYtmezO7BoRA9Z6CS2B3Ady6hGBik60QQ
 9zFrT0fwcdwUFxmUEQj0n8ZMOKyL4R+eO9crXL82dF3zlBUbSjI3ioayiPM2LmOZM1vW
 2JqMhFi5RJ6kb4rF3O0+vIqWlD0oJGQUlDhyucP9e4bW1tizLYN2+eqsC2k9wuGoIkVX
 6Ctr5Z6zwZugxUbnTD2HUJI5hAf7Y8vLvL+gTJz1viENAKrIyTmaY2x7YrJ3agp22WHu
 85EVl/76M052QRZq0UsSNKWeEvYs2COhuGFeHSVwh1c2/XLySR2pnQOACBSTqOmC+oJz 0Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304r456gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 01:00:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07J4tCtx020120;
        Wed, 19 Aug 2020 05:00:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3304um1e2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 05:00:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07J50qHB25821540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 05:00:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BADA711C050;
        Wed, 19 Aug 2020 05:00:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F103511C073;
        Wed, 19 Aug 2020 05:00:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Aug 2020 05:00:49 +0000 (GMT)
Subject: Re: [PATCH -next] ext2: remove duplicate include
To:     Wang Hai <wanghai38@huawei.com>, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200819025434.65763-1-wanghai38@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 19 Aug 2020 10:30:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200819025434.65763-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200819050049.F103511C073@d06av25.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_02:2020-08-18,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190039
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/19/20 8:24 AM, Wang Hai wrote:
> Remove linux/fiemap.h which is included more than once
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>


LGTM, please feel free to add,
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext2/inode.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 80662e1f7889..de6b97612410 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -36,7 +36,6 @@
>   #include <linux/iomap.h>
>   #include <linux/namei.h>
>   #include <linux/uio.h>
> -#include <linux/fiemap.h>
>   #include "ext2.h"
>   #include "acl.h"
>   #include "xattr.h"
> 
