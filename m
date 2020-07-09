Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6221A79D
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jul 2020 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgGITPo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jul 2020 15:15:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGITPo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jul 2020 15:15:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069J6c88049825;
        Thu, 9 Jul 2020 19:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=scD0dRNk66GYxAvzVfjhVk7XV0N9HiU1EB24wa/KmfU=;
 b=lYpySmdDlEakTQsJASSHisCQtuHxzB57Cj3PEUjiuRNEZJaiJPe9V8E+5QnLl+m5bnAo
 WL4I5DZc8Dj6dxixgbIMZ0TUKN/qJaP9TzRqAzUBEAKCllSywJHpaeHFdQwxN5f38cil
 1JNcN2SI+uGTo4haUdngzrasOZOH7WC5BDYbvQfiI1Skm9A+vEA/rXVo+U70ZmmfxzfY
 aGLg5/7J0AmAZk2CZ82qWakesyg+SyzsNVocST7eDJounuBI1ih5rkcC8+9Urk4KA0HR
 5RnVMY0RBFGVqmVM3/LkO25SwccwfK0cHeI/ad/Elrkt6Z9LAfeg7etD6KKV35vRSxN3 lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 325y0akpqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 19:15:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069J9HEW169804;
        Thu, 9 Jul 2020 19:13:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 325k3hrfb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 19:13:40 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 069JDd9A030528;
        Thu, 9 Jul 2020 19:13:39 GMT
Received: from localhost (/10.159.229.94)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 12:13:39 -0700
Date:   Thu, 9 Jul 2020 12:13:38 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] generic/530: Require metadata journaling
Message-ID: <20200709191338.GA848607@magnolia>
References: <20200709095753.3514-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709095753.3514-1-jack@suse.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=1 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=1
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090131
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 09, 2020 at 11:57:53AM +0200, Jan Kara wrote:
> Test generic/530 doesn't make sence without metadata journalling as in
> that case, there's no way to recover shutdown fs besides fsck. ext4
> can be configured without a journal and it supports shutdown ioctl even
> in that mode which makes this test fail for that configuration. Add
> requirement for metadata journalling to this test so that it's properly
> skipped.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

<shudder> Right, I forgot about that...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/530 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/530 b/tests/generic/530
> index cb874ace902b..153a045dca87 100755
> --- a/tests/generic/530
> +++ b/tests/generic/530
> @@ -33,6 +33,7 @@ _supported_fs generic
>  _supported_os Linux
>  _require_scratch
>  _require_scratch_shutdown
> +_require_metadata_journaling
>  _require_test_program "t_open_tmpfiles"
>  
>  rm -f $seqres.full
> -- 
> 2.16.4
> 
