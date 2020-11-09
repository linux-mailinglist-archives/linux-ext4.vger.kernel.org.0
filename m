Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C22AC4ED
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 20:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgKITYa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 14:24:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58242 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgKITYa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Nov 2020 14:24:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9J9PjD033536;
        Mon, 9 Nov 2020 19:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=EJ2xV4attu41zzTE55YEVstvKJAQi6Yf7o04ZIsKKH4=;
 b=mNaVAmT/TDnqvhLcymYKN7dYtBI+9FYRfrvmdgeS10guq+i1TPCtxu6gzBF/P4p+JcRB
 FATJR9eAPpb3tCMixrMM689HUp93YPbi6qnIIYNIABVVfIZDsjExvnSQv7TkTlu3oBih
 DKHDQj5EVD2c9AzTnD5ZzQVY6kLEgGbjKcsimPJhWgQF/DWPCuzpYhe0dJN3qdfTNe5h
 GwDNFEAy5ROwdUIpM8vqalr1mL5Bi/MJXAcAlmgGwynLzpVyV+1NuHC1xyUzskVcGx1/
 fjoZ1CKTMbg/Y4iv0tBy8lHc3p4ygArji4Kjh1tBciHaOin79lK36vXDqCzsBplltzDP Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72edy9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 19:24:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9J59g1172874;
        Mon, 9 Nov 2020 19:24:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34p55mbwp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 19:24:22 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9JOKB3022047;
        Mon, 9 Nov 2020 19:24:20 GMT
Received: from localhost (/10.159.146.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 11:24:20 -0800
Date:   Mon, 9 Nov 2020 11:24:19 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs: show the dax option in mount options.
Message-ID: <20201109192419.GC9695@magnolia>
References: <cover.1604948373.git.msuchanek@suse.de>
 <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=1 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090129
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 09, 2020 at 08:10:08PM +0100, Michal Suchanek wrote:
> xfs accepts both dax and dax_enum but shows only dax_enum. Show both
> options.
> 
> Fixes: 8d6c3446ec23 ("fs/xfs: Make DAX mount option a tri-state")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  fs/xfs/xfs_super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e3e229e52512..a3b00003840d 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -163,7 +163,7 @@ xfs_fs_show_options(
>  		{ XFS_MOUNT_GRPID,		",grpid" },
>  		{ XFS_MOUNT_DISCARD,		",discard" },
>  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> -		{ XFS_MOUNT_DAX_ALWAYS,		",dax=always" },
> +		{ XFS_MOUNT_DAX_ALWAYS,		",dax,dax=always" },

NAK, programs that require DAX semantics for files stored on XFS must
call statx to detect the STATX_ATTR_DAX flag, as outlined in "Enabling
DAX on xfs" in Documentation/filesystems/dax.txt.

--D

>  		{ XFS_MOUNT_DAX_NEVER,		",dax=never" },
>  		{ 0, NULL }
>  	};
> -- 
> 2.26.2
> 
