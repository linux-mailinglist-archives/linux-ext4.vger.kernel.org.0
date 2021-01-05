Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B982D2EB34E
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 20:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbhAETGD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 14:06:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39098 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbhAETGD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 14:06:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105IxMId186863;
        Tue, 5 Jan 2021 19:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=kOb6bJbFFxbXXqPO6twPk4MYW9RyY1exuKQAhoM5LNw=;
 b=WZxrr9XlnNAcmEYlFPSkP4ZkLx5xsxgikXsXM1i3uDMYGE7kDLaccRtwlDVlA0iWelIy
 VdCMHLnJjrFLvLmEz2h2GX+RgxDEJHT2YOOtTHXpmCnGRtsoCiOTbt5Blwdv5Y+z/wVI
 KNwpSfXzgUuj+d9WY4ms3jTTRz36bu6/LuTzakjLytSU3mPXSOB7U08yo0SYehMClNuO
 2ZygMrgPF/ssJOeh+1qpO5XH187w5A24TXGDGAlZvIFrT2qzZ9mvlYIhz6uq6aBqsGeR
 j4LckG8z9bCuIyOyreFCQUDBAmOXE7s5OsYrYnZSLtg9RSY1ZiJAODHsxi4CZdgEZ7cY sA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35tgskt9s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 19:05:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105IuMKk089759;
        Tue, 5 Jan 2021 19:05:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 35uxnt38p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 19:05:17 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 105J5Gk2030990;
        Tue, 5 Jan 2021 19:05:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 11:05:16 -0800
Date:   Tue, 5 Jan 2021 11:05:14 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, anju@linux.vnet.ibm.com, guan@eryu.me
Subject: Re: [PATCHv3 2/2] generic/496: ext4 and xfs supports swapon on
 fallocated file
Message-ID: <20210105190514.GB6918@magnolia>
References: <aad3aeb9c717c76fc4e5fd124037da2510f51054.1609848797.git.riteshh@linux.ibm.com>
 <12d1420a4a3fe6be0918a8a13a1960db47032330.1609848797.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12d1420a4a3fe6be0918a8a13a1960db47032330.1609848797.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050109
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 05, 2021 at 08:01:43PM +0530, Ritesh Harjani wrote:
> ext4, xfs should not fail swapon on fallocated file. Currently if this
> fails the fstst was not returning a failure. Fix those for given
> filesystems (for now added ext4/xfs).
> There were some regressions which went unnoticed due to this in ext4
> tree, which later got fixed as part of this patch [1]
> 
> [1]: https://patchwork.ozlabs.org/patch/1357275
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> v2 -> v3:
> 1. Removed whitelisted naming convention.
> 
>  tests/generic/496   | 16 +++++++++++++---
>  tests/generic/group |  2 +-
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/496 b/tests/generic/496
> index 805c6ac1c0ea..1bfd16411b8a 100755
> --- a/tests/generic/496
> +++ b/tests/generic/496
> @@ -5,7 +5,7 @@
>  # FS QA Test No. 496
>  #
>  # Test various swapfile activation oddities on filesystems that support
> -# fallocated swapfiles.
> +# fallocated swapfiles (for given fs ext4/xfs)
>  #
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> @@ -61,8 +61,18 @@ touch $swapfile
>  $CHATTR_PROG +C $swapfile >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c "falloc 0 $len" $swapfile >> $seqres.full
>  "$here/src/mkswap" $swapfile
> -"$here/src/swapon" $swapfile >> $seqres.full 2>&1 || \
> -	_notrun "fallocated swap not supported here"
> +
> +# ext4/xfs should not fail for swapon on fallocated files
> +case $FSTYP in
> +ext4|xfs)
> +	"$here/src/swapon" $swapfile >> $seqres.full 2>&1 || \
> +		_fail "swapon failed on fallocated file"
> +	;;
> +*)
> +	"$here/src/swapon" $swapfile >> $seqres.full 2>&1 || \
> +		_notrun "fallocated swap not supported here"
> +	;;
> +esac
>  swapoff $swapfile
> 
>  # Create a fallocated swap file and touch every other $PAGE_SIZE to create
> diff --git a/tests/generic/group b/tests/generic/group
> index fec35d8e7b12..30a73605610d 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -498,7 +498,7 @@
>  493 auto quick swap dedupe
>  494 auto quick swap punch
>  495 auto quick swap
> -496 auto quick swap
> +496 auto quick swap prealloc
>  497 auto quick swap collapse
>  498 auto quick log
>  499 auto quick rw collapse zero
> --
> 2.26.2
> 
