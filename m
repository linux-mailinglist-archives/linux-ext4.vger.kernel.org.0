Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB11B576C
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Apr 2020 10:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgDWImK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 04:42:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbgDWImK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Apr 2020 04:42:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03N83CQr008398
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 04:42:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30k6n9220t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 04:42:08 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 23 Apr 2020 09:41:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Apr 2020 09:41:17 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03N8g2no1114586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 08:42:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8B1B4C04E;
        Thu, 23 Apr 2020 08:42:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 719DB4C040;
        Thu, 23 Apr 2020 08:42:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.60.18])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Apr 2020 08:42:01 +0000 (GMT)
Subject: Re: [PATCH v2] ext4: fix error pointer dereference
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, tytso@mit.edu, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <1587628004-95123-1-git-send-email-jefflexu@linux.alibaba.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 23 Apr 2020 14:12:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1587628004-95123-1-git-send-email-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042308-4275-0000-0000-000003C51AA2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042308-4276-0000-0000-000038DAA4A7
Message-Id: <20200423084201.719DB4C040@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_06:2020-04-22,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230061
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 4/23/20 1:16 PM, Jeffle Xu wrote:
> Don't pass error pointers to brelse().
> 
> commit 7159a986b420 ("ext4: fix some error pointer dereferences") has fixed
> some cases, fix the remaining one case.
> 
> Once ext4_xattr_block_find()->ext4_sb_bread() failed, error pointer is
> stored in @bs->bh, which will be passed to brelse() in the cleanup
> routine of ext4_xattr_set_handle(). This will then cause a NULL panic
> crash in __brelse().
> 
> BUG: unable to handle kernel NULL pointer dereference at 000000000000005b
> RIP: 0010:__brelse+0x1b/0x50
> Call Trace:
>   ext4_xattr_set_handle+0x163/0x5d0
>   ext4_xattr_set+0x95/0x110
>   __vfs_setxattr+0x6b/0x80
>   __vfs_setxattr_noperm+0x68/0x1b0
>   vfs_setxattr+0xa0/0xb0
>   setxattr+0x12c/0x1a0
>   path_setxattr+0x8d/0xc0
>   __x64_sys_setxattr+0x27/0x30
>   do_syscall_64+0x60/0x250
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> In this case, @bs->bh stores '-EIO' actually.
> 
> Fixes: fb265c9cb49e ("ext4: add ext4_sb_bread() to disambiguate ENOMEM cases")
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: stable@kernel.org # 2.6.19

Thanks for your patch. Looks good to me.
Feel free to add:

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/xattr.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 21df43a..01ba663 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1800,8 +1800,11 @@ struct ext4_xattr_block_find {
>   	if (EXT4_I(inode)->i_file_acl) {
>   		/* The inode already has an extended attribute block. */
>   		bs->bh = ext4_sb_bread(sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
> -		if (IS_ERR(bs->bh))
> -			return PTR_ERR(bs->bh);
> +		if (IS_ERR(bs->bh)) {
> +			error = PTR_ERR(bs->bh);
> +			bs->bh = NULL;
> +			return error;
> +		}
>   		ea_bdebug(bs->bh, "b_count=%d, refcount=%d",
>   			atomic_read(&(bs->bh->b_count)),
>   			le32_to_cpu(BHDR(bs->bh)->h_refcount));
> 

