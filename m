Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4268829FAF3
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 02:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgJ3B52 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 21:57:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39976 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3B52 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Oct 2020 21:57:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TKxMhp076672;
        Thu, 29 Oct 2020 21:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=b9Eybl/kXwCQLEYPHlsMF9500flCIdapjz1uqSSLeGA=;
 b=N4Oz3H6zho41m1HWactdv86yx+yYx1oGG9QQecIdaViuGrwv4svCDlC0knSTZre4pEF0
 vZxQtTGuwG5MLrcwzB+8rSCt9TqcX9O0ho9kNeFt5UnouC2sWfBNvUAr3eXbyyRXX2Pg
 /VcErpRKGfTNSKrnUr4iLiyirmGwHyQn6coRdwJuDb/M6IRv/V1zNGCDJhELsdG4lfSv
 r/lzw19t3sqgWfFM/y7txqFWp8O/If0jdXNC4vWzw7GXCX1i1Iu2/u96oZDF32eVlvm1
 Df50R9iNSRBAIUVBmDa4VSZXMFz2t4vay1/ifRCAtbR7S3tL+s5nrRpqHbk6nhqcirmR ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34c9sb7797-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 21:04:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TKuPw5172410;
        Thu, 29 Oct 2020 21:04:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34cx1tp8tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 21:04:31 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TL4PmC019065;
        Thu, 29 Oct 2020 21:04:25 GMT
Received: from localhost (/10.159.244.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 14:04:25 -0700
Date:   Thu, 29 Oct 2020 14:04:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, anju@linux.vnet.ibm.com,
        Eryu Guan <guan@eryu.me>, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] common/rc: source common/xfs and common/btrfs
Message-ID: <20201029210424.GD1061252@magnolia>
References: <cover.1604000570.git.riteshh@linux.ibm.com>
 <8d7db41971a227c5bd83677464d139399607e720.1604000570.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d7db41971a227c5bd83677464d139399607e720.1604000570.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290146
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 30, 2020 at 01:22:53AM +0530, Ritesh Harjani wrote:
> Without this patch I am unable to test for multiple different
> filesystem sections for the same tests. Since we anyway have only
> function definitions in these files, so it should be ok to source it
> by default too.
> e.g. when I run ./check -s btrfs tests/generic/613 with 3 different [***_fs]
> sections from local.config file, I see below failures.
> 
> ./common/rc: line 2801: _check_btrfs_filesystem: command not found
> 
> ./check -s xfs_4k -g swap (for XFS this fails like below)
> ./common/rc: line 749: _scratch_mkfs_xfs: command not found
> check: failed to mkfs $SCRATCH_DEV using specified options
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  common/rc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 4c59968a6bd3..e9ba1b6e8265 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3,6 +3,8 @@
>  # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
>  
>  . common/config
> +. ./common/xfs
> +. ./common/btrfs

Uhh, what happens if you run xfs and nfs one after the other?

--D

>  
>  BC=$(which bc 2> /dev/null) || BC=
>  
> -- 
> 2.26.2
> 
