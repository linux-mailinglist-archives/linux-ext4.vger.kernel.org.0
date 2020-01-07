Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3B133739
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2020 00:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgAGXUB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 18:20:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60598 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAGXUA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jan 2020 18:20:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007NJS1O022237;
        Tue, 7 Jan 2020 23:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=HMNVQYf2L6i1rImoc77FBwwcKZmVc8Ro2oxJgICj6ow=;
 b=JhCslAlHTZiRtpRujLDtLor9uxwb0P6uIHIZYXVS6xJ6EEscLr9uK0U5UT4M7tiQom92
 qQEV8ygoCY3IkovJRMO3iOB6erVz/PLszaaMnYjzkwpq612JAt2XZWurd0kn9pzeYJs4
 b3+XiamlEeGY/66tIYIyrJssRvcQt5qjDdQKU/0ElhQUdPRxe4UN2Yly59EnS8EDu+0E
 uwEH06G2xih+yN1+pI8eZztRLDU8izODfDFl6c0FYpk6GFqRdIU5aAHPaJwHQCj7auef
 uLRF92qXHxaHXEJcm6+PzumfXS/+V/MsvSRTarpib9cIn6k4QB3gudjcf7AHm9oyNxHC Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xajnq0mkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 23:19:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007NJCpk153348;
        Tue, 7 Jan 2020 23:19:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xcpanhpbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 23:19:35 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 007NJVtg018325;
        Tue, 7 Jan 2020 23:19:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 15:19:31 -0800
Date:   Tue, 7 Jan 2020 15:19:29 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>,
        Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix ext4 unused-variable warning
Message-ID: <20200107231929.GA472639@magnolia>
References: <20200107200233.3244877-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107200233.3244877-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=878
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070186
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=939 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070186
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 07, 2020 at 09:02:12PM +0100, Arnd Bergmann wrote:
> A bugfix introduce a harmless warning:
> 
> fs/ext4/inode.c: In function 'ext4_page_mkwrite':
> fs/ext4/inode.c:5910:24: error: unused variable 'mapping' [-Werror=unused-variable]
> 
> Remove the now-unused variable.
> 
> Fixes: 4a58d8158f6d ("fs: Fix page_mkwrite off-by-one errors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

FWIW I dropped the f2fs parts of the patch because there were conflicts
and they never acked the patch, so I fixed this at the same time.

--D

> ---
>  fs/ext4/inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9a3e8d075cd0..d0049fd0bfd4 100644
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
> 2.20.0
> 
