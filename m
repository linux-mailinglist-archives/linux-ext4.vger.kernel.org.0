Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8EC1BAB42
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Apr 2020 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD0R3h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Apr 2020 13:29:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42586 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgD0R3h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Apr 2020 13:29:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RHTO6M049408;
        Mon, 27 Apr 2020 17:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RTsYoAfpOkgaypobVZPWm8gy+wTNb8IqCneeyWeapFw=;
 b=UC66wOxr2kzxF3KGb1zwTvQscun/KmczMwAvHaoypdLAofBXNGwcjVMu1YCFsGBTb0Hk
 9/fwSA8dSIXXLVT+Zamni1RZu4esacd2FrqX5HirZv36ubbbK3wJisUxg3Mu1VxmBSsr
 gPDJTVWPF1sun4R7ZsYh9lrFtQ/Hy0j3j3Cd8b6eIWpxr4gCcl1ztPwKkQlEBNZDMMlg
 u/6k6MFU5IqnXX1IlxNaO/OqGppB5/i+dwTZPp8MVQQdjdtQiYJr58mhDDn2tO2r8fzL
 VmdX2OYqASSq9ndKMo5wS72HcIm4LMUhgs8byD+O6Wh/gPBb6dsB+dI+Y1Jmr3pNRnbn Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30p2p00e65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 17:29:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RHRwg6129775;
        Mon, 27 Apr 2020 17:29:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30mxrqqm8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 17:29:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03RHTUTe019355;
        Mon, 27 Apr 2020 17:29:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 10:29:30 -0700
Date:   Mon, 27 Apr 2020 10:29:29 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH RFC 1/2] xfstests: fsx: add support for cluster size
Message-ID: <20200427172929.GL6740@magnolia>
References: <1587720830-11955-1-git-send-email-jefflexu@linux.alibaba.com>
 <1587720830-11955-2-git-send-email-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587720830-11955-2-git-send-email-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270143
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 24, 2020 at 05:33:49PM +0800, Jeffle Xu wrote:
> The offset and size should be aligned with cluster size when inserting
> or collapsing range on ext4 with 'bigalloc' feature enabled. Currently
> I can find only ext4 with this limitation.

ocfs2 also has this magic, um, ability.

As does xfs under certain circumstance (realtime volumes).

> Since fsx should have no assumption of the underlying filesystem, and
> thus add the '-u cluster_size' option. Tests can set this option when
> the underlying filesystem is ext4 with bigalloc enabled.

Do copyrange, clonerange, or deduperange have this problem? ;)

> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  ltp/fsx.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 9d598a4..5fe5738 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -133,6 +133,7 @@ int	dirpath = 0;			/* -P flag */
>  int	fd;				/* fd for our test file */
>  
>  blksize_t	block_size = 0;
> +blksize_t	cluster_size = 0;
>  off_t		file_size = 0;
>  off_t		biggest = 0;
>  long long	testcalls = 0;		/* calls to function "test" */
> @@ -2146,8 +2147,8 @@ have_op:
>  		break;
>  	case OP_COLLAPSE_RANGE:
>  		TRIM_OFF_LEN(offset, size, file_size - 1);
> -		offset = offset & ~(block_size - 1);
> -		size = size & ~(block_size - 1);
> +		offset = offset & ~(cluster_size - 1);
> +		size = size & ~(cluster_size - 1);
>  		if (size == 0) {
>  			log4(OP_COLLAPSE_RANGE, offset, size, FL_SKIPPED);
>  			goto out;
> @@ -2157,8 +2158,8 @@ have_op:
>  	case OP_INSERT_RANGE:
>  		TRIM_OFF(offset, file_size);
>  		TRIM_LEN(file_size, size, maxfilelen);
> -		offset = offset & ~(block_size - 1);
> -		size = size & ~(block_size - 1);
> +		offset = offset & ~(cluster_size - 1);
> +		size = size & ~(cluster_size - 1);
>  		if (size == 0) {
>  			log4(OP_INSERT_RANGE, offset, size, FL_SKIPPED);
>  			goto out;
> @@ -2231,7 +2232,7 @@ void
>  usage(void)
>  {
>  	fprintf(stdout, "usage: %s",
> -		"fsx [-dknqxABEFJLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
> +		"fsx [-dknqxABEFJLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-u csize] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
>  	-b opnum: beginning operation number (default 1)\n\
>  	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
>  	-d: debug output for all operations\n\
> @@ -2249,6 +2250,7 @@ usage(void)
>  	-r readbdy: 4096 would make reads page aligned (default 1)\n\
>  	-s style: 1 gives smaller truncates (default 0)\n\
>  	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
> +	-u csize: filesystem specific cluster size that may be used for ops like insert/collapse range\n\
>  	-w writebdy: 4096 would make writes page aligned (default 1)\n\
>  	-x: preallocate file space before starting, XFS only (default 0)\n\
>  	-y synchronize changes to a file\n"
> @@ -2485,7 +2487,7 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "b:c:dfg:i:j:kl:m:no:p:qr:s:t:w:xyABD:EFJKHzCILN:OP:RS:WXZ",
> +				 "b:c:dfg:i:j:kl:m:no:p:qr:s:t:u:w:xyABD:EFJKHzCILN:OP:RS:WXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
>  		case 'b':
> @@ -2579,6 +2581,11 @@ main(int argc, char **argv)
>  			if (truncbdy <= 0)
>  				usage();
>  			break;
> +		case 'u':
> +			cluster_size = getnum(optarg, &endp);
> +			if (cluster_size <= 0)
> +				usage();
> +			break;
>  		case 'w':
>  			writebdy = getnum(optarg, &endp);
>  			if (writebdy <= 0)
> @@ -2720,6 +2727,7 @@ main(int argc, char **argv)
>  		exit(91);
>  	}
>  	block_size = statbuf.st_blksize;
> +	cluster_size = cluster_size ? : block_size;
>  #ifdef XFS
>  	if (prealloc) {
>  		xfs_flock64_t	resv = { 0 };
> -- 
> 1.8.3.1
> 
