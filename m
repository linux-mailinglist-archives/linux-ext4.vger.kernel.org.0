Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B5E2EB34C
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 20:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbhAETFo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 14:05:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38804 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbhAETFn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 14:05:43 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105Ix7bv186769;
        Tue, 5 Jan 2021 19:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=hiNJz+vMTwFw5Wm5/2XZegBSg3Ri/OpORbESj+GgbTs=;
 b=ZycW79ZnZvcVsA2eZhd8/D/vO+NnukGlEO5y4taiA3bmeAPG1LVEa7VB5L037Std24mN
 r+bJAP63x30WZEbeR3Khv6iNpLAoby9KmOxY3oglq7NUnU1NiWoSMnF7GkxjSm7PEtfL
 yQLu4GkVXZ7tQgeKjms3Mjr0xyTt1iFZ+KMXBdW//VroJmg8Q388X95gX5clV9uVzVS4
 BjoIrJ1GxJAGM4MSnq2OUQv6Bp1XN+FqPgbyGHzR3uRjL2G4jHLZlyH4mzrYpfRkJ/yU
 YoeSj1gmDQ8jk4qVmpG0fBSzjX5H2xymW9CAVmZ5o35GPeFYkprTp5bBH/oQH1T25CqJ yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35tgskt9q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 19:04:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105ItMkU022828;
        Tue, 5 Jan 2021 19:04:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 35vct698rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 19:04:57 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 105J4tdB005921;
        Tue, 5 Jan 2021 19:04:55 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 19:04:55 +0000
Date:   Tue, 5 Jan 2021 11:04:53 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, anju@linux.vnet.ibm.com, guan@eryu.me
Subject: Re: [PATCHv3 1/2] common/rc: swapon should not fail for given FS in
 _require_scratch_swapfile()
Message-ID: <20210105190453.GA6918@magnolia>
References: <aad3aeb9c717c76fc4e5fd124037da2510f51054.1609848797.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad3aeb9c717c76fc4e5fd124037da2510f51054.1609848797.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050109
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 05, 2021 at 08:01:42PM +0530, Ritesh Harjani wrote:
> Filesystems e.g. ext* and XFS supports swapon by default and an error
> returned with swapon should be treated as a failure.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> v2 -> v3:
> 1. Removed whitelisted naming convention.
> 2. Added ext2/ext3 as well as supported FS for swapon.
> 3. Removed local variable $fstyp, instead used $FSTYP directly in switch case.
> 
>  common/rc | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 33b5b598a198..649b1cfd884a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2401,10 +2401,22 @@ _require_scratch_swapfile()
>  	# Minimum size for mkswap is 10 pages
>  	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> 
> -	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> -		_scratch_unmount
> -		_notrun "swapfiles are not supported"
> -	fi
> +	# ext* and xfs have supported all variants of swap files since their
> +	# introduction, so swapon should not fail.
> +	case "$FSTYP" in
> +	ext2|ext3|ext4|xfs)
> +		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> +			_scratch_unmount
> +			_fail "swapon failed for $FSTYP"
> +		fi
> +		;;
> +	*)
> +		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> +			_scratch_unmount
> +			_notrun "swapfiles are not supported"
> +		fi
> +		;;
> +	esac
> 
>  	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
>  	_scratch_unmount
> --
> 2.26.2
> 
