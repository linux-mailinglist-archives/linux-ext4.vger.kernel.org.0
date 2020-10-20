Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9CE2933BE
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Oct 2020 05:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391345AbgJTD7w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 23:59:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45954 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391343AbgJTD7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 23:59:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09K3jXkI166799;
        Tue, 20 Oct 2020 03:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=HX4zBsYuHO4KBRPsyGJISysUZcA7hdqN6lO81DrU1Jw=;
 b=A+/fHc4N6j1ZiHYf4qSLSHzBC40HfLyi8GekhM2OWcsdIQ5n73Ziu/tAhgAPPQMrLPVM
 fuaWGyvjLIpYt94ujwkJltUTxIby7Glg+wwzoly5orhQZskF2fKRNAlXX6sqZ+AW9sIk
 OiHXa9KlHorKz1aha/kA10BGd/Pf5n4aupnLG++tMAibQCIhxGosVglAy/QsQmwweuko
 WHZUm+ChksYsin7nn0kCw+I4KwrtXx5ENB+hmKxn3lyN5Q9+WLw9mBY89KiKJtHQFqOb
 xO/CjZnEfdYsKhoLiX+1tEsIiQSDKEl2QZ1CfA1fCRNuSKPYZeCi34w/ukc7lYm2ZqDx PQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 347p4artpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 03:59:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09K3jrST130870;
        Tue, 20 Oct 2020 03:59:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 348acq8p43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 03:59:36 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09K3xVEC011293;
        Tue, 20 Oct 2020 03:59:31 GMT
Received: from localhost (/10.159.227.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Oct 2020 20:59:31 -0700
Date:   Mon, 19 Oct 2020 20:59:30 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Luo Meng <luomeng12@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] ext4: fix invalid inode checksum
Message-ID: <20201020035930.GA489993@magnolia>
References: <20201020013631.3796673-1-luomeng12@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020013631.3796673-1-luomeng12@huawei.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=1 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 20, 2020 at 09:36:31AM +0800, Luo Meng wrote:
> During the stability test, there are some errors:
>   ext4_lookup:1590: inode #6967: comm fsstress: iget: checksum invalid.
> 
> If the inode->i_iblocks too big and doesn't set huge file flag, checksum
> will not be recalculated when update the inode information to it's buffer.
> If other inode marks the buffer dirty, then the inconsistent inode will
> be flushed to disk.
> 
> Fix this problem by checking i_blocks in advance.
> 
> Signed-off-by: Luo Meng <luomeng12@huawei.com>

Fun!  Yikes!
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ext4/inode.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf596467c234..fe53774b8b6c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4971,6 +4971,12 @@ static int ext4_do_update_inode(handle_t *handle,
>  	if (ext4_test_inode_state(inode, EXT4_STATE_NEW))
>  		memset(raw_inode, 0, EXT4_SB(inode->i_sb)->s_inode_size);
>  
> +	err = ext4_inode_blocks_set(handle, raw_inode, ei);
> +	if (err) {
> +		spin_unlock(&ei->i_raw_lock);
> +		goto out_brelse;
> +	}
> +
>  	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
>  	i_uid = i_uid_read(inode);
>  	i_gid = i_gid_read(inode);
> @@ -5004,11 +5010,6 @@ static int ext4_do_update_inode(handle_t *handle,
>  	EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
>  	EXT4_EINODE_SET_XTIME(i_crtime, ei, raw_inode);
>  
> -	err = ext4_inode_blocks_set(handle, raw_inode, ei);
> -	if (err) {
> -		spin_unlock(&ei->i_raw_lock);
> -		goto out_brelse;
> -	}
>  	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
>  	raw_inode->i_flags = cpu_to_le32(ei->i_flags & 0xFFFFFFFF);
>  	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT)))
> -- 
> 2.25.4
> 
