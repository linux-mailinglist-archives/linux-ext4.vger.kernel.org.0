Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508DFF3DE1
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2019 03:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfKHCIh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Nov 2019 21:08:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47388 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbfKHCIg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Nov 2019 21:08:36 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA822KWX184814
        for <linux-ext4@vger.kernel.org>; Thu, 7 Nov 2019 21:08:34 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w41w7mxxt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 07 Nov 2019 21:08:34 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 8 Nov 2019 02:08:32 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 02:08:29 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA828SPT62390484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 02:08:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 925C4AE045;
        Fri,  8 Nov 2019 02:08:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15D1EAE056;
        Fri,  8 Nov 2019 02:08:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.36.138])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 02:08:26 +0000 (GMT)
Subject: Re: [PATCH] ext4: deaccount delayed allocations at freeing inode in
 ext4_evict_inode()
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Eric Whitney <enwlinux@gmail.com>
References: <157233344808.4027.17162642259754563372.stgit@buzz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 8 Nov 2019 07:38:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <157233344808.4027.17162642259754563372.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19110802-0020-0000-0000-0000038394DC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110802-0021-0000-0000-000021D9CB6A
Message-Id: <20191108020827.15D1EAE056@d06av26.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080018
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 10/29/19 12:47 PM, Konstantin Khlebnikov wrote:
> If inode->i_blocks is zero then ext4_evict_inode() skips ext4_truncate().
> Delayed allocation extents are freed later in ext4_clear_inode() but this
> happens when quota reference is already dropped. This leads to leak of
> reserved space in quota block, which disappears after umount-mount.
> 
> This seems broken for a long time but worked somehow until recent changes
> in delayed allocation.

Sorry, I may have missed it, but could you please help understand
what recent changes in delayed allocation make this break or worse?


A silly query, since I couldn't figure it out. Maybe the code has been
there ever since like this:-
So why can't we just move drop_dquot later after the 
ext4_es_remove_extent() (in function ext4_clear_inode)? Any known
problems around that?

-ritesh


> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   fs/ext4/inode.c |    9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..580898145e8f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -293,6 +293,15 @@ void ext4_evict_inode(struct inode *inode)
>   				   inode->i_ino, err);
>   			goto stop_handle;
>   		}
> +	} else if (EXT4_I(inode)->i_reserved_data_blocks) {
> +		/* Deaccount reserve if inode has only delayed allocations. */
> +		err = ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
> +		if (err) {
> +			ext4_warning(inode->i_sb,
> +				     "couldn't remove extents %lu (err %d)",
> +				     inode->i_ino, err);
> +			goto stop_handle;
> +		}
>   	}
> 
>   	/* Remove xattr references. */
> 

