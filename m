Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D9716FDC6
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 12:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgBZLc1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Feb 2020 06:32:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbgBZLc0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Feb 2020 06:32:26 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QBRIUe064366
        for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2020 06:32:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydcntk3ft-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2020 06:32:25 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 26 Feb 2020 11:32:23 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 11:32:20 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01QBWJcM11731410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 11:32:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD22852057;
        Wed, 26 Feb 2020 11:32:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.58.45])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 16F065205A;
        Wed, 26 Feb 2020 11:32:18 +0000 (GMT)
Subject: Re: [PATCH v2] ext2: Silence lockdep warning about reclaim under
 xattr_sem
To:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Cc:     "J. R. Okajima" <hooanon05g@gmail.com>
References: <20200225120803.7901-1-jack@suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 26 Feb 2020 17:02:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200225120803.7901-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022611-0020-0000-0000-000003ADBB67
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022611-0021-0000-0000-00002205D5EA
Message-Id: <20200226113219.16F065205A@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_03:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=785 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260087
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2/25/20 5:38 PM, Jan Kara wrote:
> Lockdep complains about a chain:
>    sb_internal#2 --> &ei->xattr_sem#2 --> fs_reclaim
> 
> and shrink_dentry_list -> ext2_evict_inode -> ext2_xattr_delete_inode ->
> down_write(ei->xattr_sem) creating a locking cycle in the reclaim path.
> This is however a false positive because when we are in
> ext2_evict_inode() we are the only holder of the inode reference and
> nobody else should touch xattr_sem of that inode. So we cannot ever
> block on acquiring the xattr_sem in the reclaim path.
> 
> Silence the lockdep warning by using down_write_trylock() in
> ext2_xattr_delete_inode() to not create false locking dependency.
> 
> Reported-by: "J. R. Okajima" <hooanon05g@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Agreed with evict() will only be called when it's the last reference 
going down and so we won't be blocked on xattr_sem.
Thanks for clearly explaining the problem in the cover letter.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext2/xattr.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> Changes since v1:
> - changed WARN_ON to WARN_ON_ONCE
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 0456bc990b5e..9ad07c7ef0b3 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -790,7 +790,15 @@ ext2_xattr_delete_inode(struct inode *inode)
>   	struct buffer_head *bh = NULL;
>   	struct ext2_sb_info *sbi = EXT2_SB(inode->i_sb);
> 
> -	down_write(&EXT2_I(inode)->xattr_sem);
> +	/*
> +	 * We are the only ones holding inode reference. The xattr_sem should
> +	 * better be unlocked! We could as well just not acquire xattr_sem at
> +	 * all but this makes the code more futureproof. OTOH we need trylock
> +	 * here to avoid false-positive warning from lockdep about reclaim
> +	 * circular dependency.
> +	 */
> +	if (WARN_ON_ONCE(!down_write_trylock(&EXT2_I(inode)->xattr_sem)))
> +		return;
>   	if (!EXT2_I(inode)->i_file_acl)
>   		goto cleanup;
> 

