Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7B0476C4
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Jun 2019 22:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfFPUkb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Jun 2019 16:40:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34788 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfFPUkb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Jun 2019 16:40:31 -0400
X-Greylist: delayed 13981 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jun 2019 16:40:30 EDT
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5GGioCo153666;
        Sun, 16 Jun 2019 16:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qukdqfmNSk79RZod8Tg0Eg7bhULnpBRMWfxmlI6TPvI=;
 b=Eu5ObC2rZtrziFSEmrWqq5ji48llXqQ4VaywcH78N1VNZ/2yKlbIJfm9Ebh8WH8sICJk
 GpMakvlDmln3LzU70wlhDh8SNs4H92sgZwZStGkPwXG52UfUzZbE7U+Ji7R/hY479uJk
 QjXi8cFZwzfZ3/R4p+i3qsUUmo2+Ou8ymANswI1pwAhI5tbMBsEOF6O/ZqhFFZ0Cpna2
 TawDqQPF/s7ZAvjTAqU55cNqeJzbTg347wLBLBwZbdWYQsTf6swqNBG+B3xQ4Uw5Jnho
 hsf00aXIBbQxZzg6JXyZ4th3gRurZ5tNM2ozPW9Q9DfwaG6LT5hgo3Yw/eYYWTktcNg1 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t4rmnu6ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jun 2019 16:47:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5GGj2Vu182074;
        Sun, 16 Jun 2019 16:45:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t5h5sts9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jun 2019 16:45:24 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5GGjNlv031729;
        Sun, 16 Jun 2019 16:45:23 GMT
Received: from localhost (/70.95.137.242)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Jun 2019 09:45:22 -0700
Date:   Sun, 16 Jun 2019 09:45:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: add missing brelse() in ext2_iget()
Message-ID: <20190616164521.GB1872750@magnolia>
References: <20190616150801.2652-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616150801.2652-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906160161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906160161
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 16, 2019 at 11:08:01PM +0800, Chengguang Xu wrote:
> Add missing brelse() on error path of ext2_iget().
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

/me wonders if the brelse ought to be moved down to bad_inode so that
each error branch only has to set @ret and then jump (thereby
eliminating the possibility of making this mistake again), but for a
oneliner quick fix I guess it's fine:

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ext2/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index e474127dd255..fb3611f02051 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1473,6 +1473,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
>  	else
>  		ei->i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
>  	if (i_size_read(inode) < 0) {
> +		brelse(bh);
>  		ret = -EFSCORRUPTED;
>  		goto bad_inode;
>  	}
> -- 
> 2.21.0
> 
> 
> 
