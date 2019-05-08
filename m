Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E52171C8
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2019 08:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEHGil (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 May 2019 02:38:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36616 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHGil (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 May 2019 02:38:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x486cLb0189048;
        Wed, 8 May 2019 06:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5mw4iLZCxZsPvWBywmREwMoaRrDcvmRx4Soriv+tdGk=;
 b=35Kf+kiC7b10mhUrnDAZFNorPBXFBBDd9C5YTqLo8l194OJqPa7OMI9HHDNz2SqrpqLB
 3jAPrM3v8FKFoljdVUF9Mrxdxy/+7bAuZySByd2hw5iIVZxz7aKZ+E+X4iMtiXhhLdLU
 1zgIfN/ZFks4SuLJuajEiZwK9iX+nR8M79fOWb3npQ+OG5OuQsbTB8v22hNm02CePq8p
 K033SP7rCOE+QTxckgmkMBOzoZmknUP4ZSnwPga9uDr10nW6bm3yOX3lca9LF9uqUsSy
 StPTsyjgMgqgcv13PitZRs4HdOQgT0XDmYc1CNWG5j4QIm2FVk8sTXw/PM+Lt8QWrqUy 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s94bg1rr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 May 2019 06:38:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x486btm4158779;
        Wed, 8 May 2019 06:38:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2sagyuc6b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 May 2019 06:38:33 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x486cWI6009183;
        Wed, 8 May 2019 06:38:32 GMT
Received: from [10.182.69.248] (/10.182.69.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 May 2019 23:38:32 -0700
Subject: Re: [PATCH 1/3] jbd2: fix potential double free
To:     Chengguang Xu <cgxu519@gmail.com>, jack@suse.com, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1557054064-3504-1-git-send-email-cgxu519@gmail.com>
From:   "sunny.s.zhang" <sunny.s.zhang@oracle.com>
Message-ID: <a931ed92-763c-0a18-ed3d-4ac1c4fbcb8d@oracle.com>
Date:   Wed, 8 May 2019 14:38:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1557054064-3504-1-git-send-email-cgxu519@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9250 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905080043
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9250 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905080043
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Chengguang,

在 2019年05月05日 19:01, Chengguang Xu 写道:
> When fail from creating cache jbd2_inode_cache, we will
> destroy previously created cache jbd2_handle_cache twice.
> This patch fixes it by removing first destroy in error path.
>
> Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
> ---
>   fs/jbd2/journal.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 382c030cc78b..49797854ccb8 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2642,7 +2642,6 @@ static int __init jbd2_journal_init_handle_cache(void)
>   	jbd2_inode_cache = KMEM_CACHE(jbd2_inode, 0);
>   	if (jbd2_inode_cache == NULL) {
>   		printk(KERN_EMERG "JBD2: failed to create inode cache\n");
> -		kmem_cache_destroy(jbd2_handle_cache);
Maybe we should keep it, and set the jbd2_handle_cache to NULL.
If there are some changes in the future,  we may forget to change the 
function
of jbd2_journal_destroy_handle_cache.

Thanks,
Sunny

>   		return -ENOMEM;
>   	}
>   	return 0;

