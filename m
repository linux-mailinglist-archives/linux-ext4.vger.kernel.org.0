Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120EE15ADF2
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2020 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgBLRCn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Feb 2020 12:02:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43904 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLRCn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Feb 2020 12:02:43 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CH2cZa107905;
        Wed, 12 Feb 2020 17:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0eZIQwVu64mt5L6W1tWAbnwdQdeKAzb/S4WRro88aX8=;
 b=bqZKtyUMVyIc2cYbakJ5GvFdotj3WIBg583qkioSjjvrjipaygX1skvPz9/WbqSxC3BH
 jOV9UT09BLC82TXDN4vbPWXWvifxNZfcn4TlP8H5wY5CGaRqAM2kIhg0m6BhZg0FqpZL
 uUjFfP0yDYyVgkdEQWewdpmKxwZ2pj+xOB4X69HcDvty95DMtL6LjOraxhvx8diEuJEP
 upg14iCXcdUmwoXtKO9tY+SgXIDrq5DsYRSDuOiId8HfvD6pQB0AdIoiy3NcDM55fq6W
 fTXy6EPFDUsPjhasP9vp9yrHNnA4bmPVEwX5ZXJnukVcpLWxQiPW498d/9vEbZh+69yN XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y2jx6cht1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 17:02:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CH1jkO171333;
        Wed, 12 Feb 2020 17:02:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y4k7x13rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 17:02:38 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01CH2cTx011402;
        Wed, 12 Feb 2020 17:02:38 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 09:02:37 -0800
Date:   Wed, 12 Feb 2020 09:02:36 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4:  delete declaration for ext4_split_extent()
Message-ID: <20200212170236.GA6863@magnolia>
References: <20200212162141.22381-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212162141.22381-1-enwlinux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120129
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 12, 2020 at 11:21:41AM -0500, Eric Whitney wrote:
> There are no forward references for ext4_split_extent() in extents.c,
> so delete its unnecessary declaration.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ext4/extents.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 89aa9c7ae293..a5338a8da2ab 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -83,13 +83,6 @@ static void ext4_extent_block_csum_set(struct inode *inode,
>  	et->et_checksum = ext4_extent_block_csum(inode, eh);
>  }
>  
> -static int ext4_split_extent(handle_t *handle,
> -				struct inode *inode,
> -				struct ext4_ext_path **ppath,
> -				struct ext4_map_blocks *map,
> -				int split_flag,
> -				int flags);
> -
>  static int ext4_split_extent_at(handle_t *handle,
>  			     struct inode *inode,
>  			     struct ext4_ext_path **ppath,
> -- 
> 2.11.0
> 
