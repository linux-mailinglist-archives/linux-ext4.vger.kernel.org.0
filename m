Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8813D139BE3
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 22:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgAMVwS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 16:52:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43898 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgAMVwS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jan 2020 16:52:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DLhrNl131209;
        Mon, 13 Jan 2020 21:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=8OFklpwMX2/C6RJSwi+fm6fYp/IFQq/XiSxcQChY2wM=;
 b=j6eMW51UMTwX2ljCfQdhee9fKu/Vp8P03c55D8NXqX09RE4eJJ5M1pUJjuJBtXOVzOvA
 k18MFaqQQ39drAqe1yV1vP+K8RLtueA/ol2O0YxJlcEqWIglvVgVUrGc2v8hJluDCUiZ
 LQBz20yK5wcyARmN2zs8ldLvNF3srACHaQoLZtHgWPk82LeKArsxj9P2X4yqCW4PAUCw
 9qwM8skZKz7UZNg9O75dwLwFXX0isxDLYgNxWv19UdrbVHJmxrBq3KvpQfD6qHGYjka9
 AqfL/qJ476yV1EEa+ICLQpF7XkvpX3/J4dyM/7NRPQlrRkL6OZ51xBZUJPr9YkXC98Az yA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xf73thuky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 21:52:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DLmPVR083023;
        Mon, 13 Jan 2020 21:52:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xfrgjebsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 21:52:02 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00DLq0vJ023482;
        Mon, 13 Jan 2020 21:52:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 13:52:00 -0800
Date:   Mon, 13 Jan 2020 13:51:59 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before
 filemap_write_and_wait_range
Message-ID: <20200113215159.GA8235@magnolia>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130177
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 13, 2020 at 04:34:21PM +0530, Ritesh Harjani wrote:
> Some filesystems (e.g. ext4) need to know in it's writeback path, that
> whether DIO is in progress or not. This info may be needed to avoid the
> stale data exposure race with DIO reads.

Does XFS have this problem too?

Admittedly dio read during mmap write is probably not well supported. ;)

> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/iomap/direct-io.c | 17 +++++++++++++----

Might want to cc fsdevel and the iomap maintainers...

--D

>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 23837926c0c5..d1c159bd3854 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -468,9 +468,18 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		flags |= IOMAP_NOWAIT;
>  	}
>  
> +	/*
> +	 * Call inode_dio_begin() before we write out and wait for writeback to
> +	 * complete. This may be needed by some filesystems to prevent race
> +	 * like stale data exposure by DIO reads.
> +	 */
> +	inode_dio_begin(inode);
> +	/* So that i_dio_count is incremented before below operation */
> +	smp_mb__after_atomic();
> +
>  	ret = filemap_write_and_wait_range(mapping, pos, end);
>  	if (ret)
> -		goto out_free_dio;
> +		goto out_end_dio;
>  
>  	/*
>  	 * Try to invalidate cache pages for the range we're direct
> @@ -488,11 +497,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	    !inode->i_sb->s_dio_done_wq) {
>  		ret = sb_init_dio_done_wq(inode->i_sb);
>  		if (ret < 0)
> -			goto out_free_dio;
> +			goto out_end_dio;
>  	}
>  
> -	inode_dio_begin(inode);
> -
>  	blk_start_plug(&plug);
>  	do {
>  		ret = iomap_apply(inode, pos, count, flags, ops, dio,
> @@ -568,6 +575,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	return iomap_dio_complete(dio);
>  
> +out_end_dio:
> +	inode_dio_end(inode);
>  out_free_dio:
>  	kfree(dio);
>  	return ret;
> -- 
> 2.21.0
> 
