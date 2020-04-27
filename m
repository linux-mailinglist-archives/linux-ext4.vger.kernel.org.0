Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C271BAB61
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Apr 2020 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgD0ReC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Apr 2020 13:34:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46410 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgD0ReB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Apr 2020 13:34:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RHTDF0049093;
        Mon, 27 Apr 2020 17:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=QvMv0Re9xa1Ef7ZfEzauQZHM1sqNdGU2J0I1j9wYNqI=;
 b=g1YLalM1nkyt67WPwldu1CjsIcj4y5cAVEAm6SmwpNmMQWLzZTlUe4r5/n4mBUFfJK/q
 Nj9QTnrKGn7yziTUWmtnsudoQCRao88PrA+XQsRBJvN+ntiokIDM0rAZ3Am8wlrjl6yu
 yfjgXKAwMOd1B+yeVxn+T83izpCS3tICYeRdrqe9E9X0gPZAG8hTOZuC4nP3GS033kr7
 aQIPXrfxWVH0n6+hipjmVFCqa7b9dQSKr6RKkEgLsfC+Kctl1lYbTCoCITZmE++Ml44y
 CstIyJTJd7w1MPE+BF6wSxxwFN4lXRdrJ7bGmHyisjaiTrIdwIxgD4WB7qgTEmf9lu8E tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30p2p00evk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 17:33:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RHVpw5086183;
        Mon, 27 Apr 2020 17:33:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30mxwwmwhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 17:33:56 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03RHXt5t023099;
        Mon, 27 Apr 2020 17:33:55 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 10:33:55 -0700
Date:   Mon, 27 Apr 2020 10:33:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH RFC 2/2] xfstests: common/rc: add cluster size support
 for ext4
Message-ID: <20200427173354.GM6740@magnolia>
References: <1587720830-11955-1-git-send-email-jefflexu@linux.alibaba.com>
 <1587720830-11955-3-git-send-email-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587720830-11955-3-git-send-email-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270143
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 24, 2020 at 05:33:50PM +0800, Jeffle Xu wrote:
> Inserting and collapsing range on ext4 with 'bigalloc' feature will
> fail due to the offset and size should be alligned with the cluster
> size.
> 
> The previous patch has add support for cluster size in fsx. Detect and
> pass the cluster size parameter to fsx if the underlying filesystem
> is ext4 with bigalloc.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  common/rc | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 2000bd9..71dde5f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3908,6 +3908,15 @@ run_fsx()
>  {
>  	echo fsx $@
>  	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
> +
> +	if [ "$FSTYP" == "ext4" ]; then
> +		local cluster_size=$(tune2fs -l $TEST_DEV | grep 'Cluster size' | awk '{print $3}')
> +		if [ -n $cluster_size ]; then
> +			echo "cluster size: $cluster_size"
> +			args="$args -u $cluster_size"
> +		fi
> +	fi

Computing the file allocation block size ought to be a separate helper.

I wonder if there's a standard way to report cluster sizes, seeing as
fat, ext4, ocfs2, and xfs can all have minimum space allocation units
that are larger than the base fs block size.

--D

> +
>  	set -- $here/ltp/fsx $args $FSX_AVOID $TEST_DIR/junk
>  	echo "$@" >>$seqres.full
>  	rm -f $TEST_DIR/junk
> -- 
> 1.8.3.1
> 
