Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD313372A
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2020 00:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgAGXQk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 18:16:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57960 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgAGXQk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jan 2020 18:16:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007N9Z3v015483;
        Tue, 7 Jan 2020 23:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=IGnUQkIqlonHOlUqU1WosXHkUGO7eZVXN+CSVmkG9ss=;
 b=Uy4pOGtCNgTSoKLNAhpl+3m4T/1cnT3YDJBuuvQyIeom21xwfgycUWILjWNBtJWs5g4f
 gCDI+T+lh/CXA5nfm3Up/p1vkBKoJoFXBAT+yG5eSA8ShHKU88xm6+tcucFfAO9ld6lw
 8bqV/ZoMNGX0W54p5BInxb80cSBg0U740wSFiSIXmzTO/DoOvuVtcopU/xA8na11AxPT
 kSEoZMdBTc/gs1Zp9LIzjHofpv51ZqIlKAdQCWQxReuZ5SPDwyR9Xhu/22I4tkBuyXyN
 /JZ8/aZt5qNrG60BFowRE6P4VPmKJ9tidTjoK3WjMaz5ZdxAOcLpG+f184iaTG7kVfNR Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xajnq0ma6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 23:16:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007NE1ta086268;
        Tue, 7 Jan 2020 23:16:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xcpcra74n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 23:16:28 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 007NGQqh001833;
        Tue, 7 Jan 2020 23:16:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 15:16:26 -0800
Date:   Tue, 7 Jan 2020 15:16:23 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, agruenba@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: remove unused variable 'mapping'
Message-ID: <20200107231623.GF472665@magnolia>
References: <20200107062355.40624-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107062355.40624-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070185
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 07, 2020 at 02:23:55PM +0800, YueHaibing wrote:
> fs/ext4/inode.c: In function 'ext4_page_mkwrite':
> fs/ext4/inode.c:5910:24: warning: unused variable 'mapping' [-Wunused-variable]
> 
> commit 4a58d8158f6d ("fs: Fix page_mkwrite off-by-one errors")
> left behind this unused variable.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Er, I had to rebase the branch this morning to remove the f2fs parts
(there's a conflict and they never acked the patch) so I cleaned this up
at the same time.

--D

> ---
>  fs/ext4/inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9a3e8d0..d0049fd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5907,7 +5907,6 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  	vm_fault_t ret;
>  	struct file *file = vma->vm_file;
>  	struct inode *inode = file_inode(file);
> -	struct address_space *mapping = inode->i_mapping;
>  	handle_t *handle;
>  	get_block_t *get_block;
>  	int retries = 0;
> -- 
> 2.7.4
> 
> 
