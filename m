Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58A16FBE5
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 11:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBZKUH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Feb 2020 05:20:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbgBZKUH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Feb 2020 05:20:07 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QAAL1N119453
        for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2020 05:20:06 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydcnc95uv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2020 05:20:04 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 26 Feb 2020 10:19:58 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 10:19:55 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01QAJsIR40370456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 10:19:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA79711C050;
        Wed, 26 Feb 2020 10:19:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A109911C05B;
        Wed, 26 Feb 2020 10:19:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.47.18])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Feb 2020 10:19:53 +0000 (GMT)
Subject: Re: [PATCH] ext4: using matching invalidatepage in ext4_writepage
To:     yangerkun <yangerkun@huawei.com>, tytso@mit.edu, jack@suse.com
Cc:     linux-ext4@vger.kernel.org
References: <20200226041002.13914-1-yangerkun@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 26 Feb 2020 15:49:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200226041002.13914-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022610-0028-0000-0000-000003DE1B29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022610-0029-0000-0000-000024A33689
Message-Id: <20200226101953.A109911C05B@d06av25.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_02:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260077
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2/26/20 9:40 AM, yangerkun wrote:
> Run generic/388 with journal data mode sometimes may trigger the warning
> in ext4_invalidatepage. Actually, we should use the matching invalidatepage
> in ext4_writepage.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

generic/388 still fails, but the patch makes sense to me and also avoids
kernel warning.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index fa0ff78dc033..78e805d42ada 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1974,7 +1974,7 @@ static int ext4_writepage(struct page *page,
>   	bool keep_towrite = false;
> 
>   	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
> -		ext4_invalidatepage(page, 0, PAGE_SIZE);
> +		inode->i_mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
>   		unlock_page(page);
>   		return -EIO;
>   	}
> 

