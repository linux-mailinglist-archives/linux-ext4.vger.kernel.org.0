Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D49733CEF3
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Mar 2021 08:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhCPH42 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Mar 2021 03:56:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46580 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhCPHz7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Mar 2021 03:55:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12G7t0ow022065;
        Tue, 16 Mar 2021 07:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=uiA/ODjGWL92YnNziRYckmj2xE2ZdSIYGa2xK90ks74=;
 b=ItiNBBxjEG33Ed59TcB1kU/1/zr0UPgyGhulztjShdLCfjuhov8Y/zHsw5y+i/pv4/8M
 7kab7VDPLVbAUy5xjGPATjD4io+xNGIf/MlTnajlLfZMuU3rlGhldwxBXJRPA4yZV6BP
 lCPPQZlntq2cE4xlRpuBWz3MS1ijix45lz1HfEnpHakGXn5dHmed0pkDa9b9KPY+TrOP
 198PQSosaJQ7Dr2D6JrgtsOlUSf7ebOeK9EbaBNqBCY1Q6yURbhSb++eGAZDPtGf1xKF
 VEFDnS9DY7OxlTcD6oZdhhRbZTZ2WCPuMdDTyI3Zg0TgtKARbPpaUYU+ApcBu8cpO6/B 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 378nbm6md1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 07:55:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12G7tptV036347;
        Tue, 16 Mar 2021 07:55:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3797ayqndf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 07:55:52 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12G7tcJf006008;
        Tue, 16 Mar 2021 07:55:38 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Mar 2021 00:55:37 -0700
Date:   Tue, 16 Mar 2021 10:55:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 5/6] ext4: improve cr 0 / cr 1 group scanning
Message-ID: <20210316075530.GS21246@kadam>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
 <20210315173716.360726-6-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315173716.360726-6-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160054
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160054
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 15, 2021 at 10:37:15AM -0700, Harshad Shirwadkar wrote:
> @@ -744,6 +801,251 @@ static void ext4_mb_mark_free_simple(struct super_block *sb,
>  	}
>  }
>  
> +static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *new,
> +			int (*cmp)(struct rb_node *, struct rb_node *))
> +{
> +	struct rb_node **iter = &root->rb_node, *parent = NULL;
> +
> +	while (*iter) {
> +		parent = *iter;
> +		if (cmp(new, *iter))
> +			iter = &((*iter)->rb_left);
> +		else
> +			iter = &((*iter)->rb_right);
> +	}

This would be neater like so:

	while (*iter) {
		node = *iter;
		if (cmp(new, node))
			iter = &node->rb_left;
		else
			iter = &node->rb_right;
	}

It's unexpected that the cmp() function returns bool instead of -1, 0
1 like other cmp() functions.

> +
> +	rb_link_node(new, parent, iter);
> +	rb_insert_color(new, root);
> +}
> +

[ snip ]

> @@ -2909,6 +3240,22 @@ int ext4_mb_init(struct super_block *sb)
>  		i++;
>  	} while (i < MB_NUM_ORDERS(sb));
>  
> +	sbi->s_mb_avg_fragment_size_root = RB_ROOT;
> +	sbi->s_mb_largest_free_orders =
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(struct list_head),
> +			GFP_KERNEL);
> +	if (!sbi->s_mb_largest_free_orders)
> +		goto out;

Missing error code.  ret = -ENOMEM;

> +	sbi->s_mb_largest_free_orders_locks =
> +		kmalloc_array(MB_NUM_ORDERS(sb), sizeof(rwlock_t),
> +			GFP_KERNEL);
> +	if (!sbi->s_mb_largest_free_orders_locks)
> +		goto out;

ret = -ENOMEM;

> +	for (i = 0; i < MB_NUM_ORDERS(sb); i++) {
> +		INIT_LIST_HEAD(&sbi->s_mb_largest_free_orders[i]);
> +		rwlock_init(&sbi->s_mb_largest_free_orders_locks[i]);
> +	}
> +	rwlock_init(&sbi->s_mb_rb_lock);
>  
>  	spin_lock_init(&sbi->s_md_lock);
>  	sbi->s_mb_free_pending = 0;
> @@ -2961,6 +3308,10 @@ int ext4_mb_init(struct super_block *sb)
>  		spin_lock_init(&lg->lg_prealloc_lock);
>  	}
>  
> +	if (blk_queue_nonrot(bdev_get_queue(sb->s_bdev)))
> +		sbi->s_mb_linear_limit = 0;
> +	else
> +		sbi->s_mb_linear_limit = MB_DEFAULT_LINEAR_LIMIT;
>  	/* init file for buddy data */
>  	ret = ext4_mb_init_backend(sb);
>  	if (ret != 0)
> @@ -2972,6 +3323,8 @@ int ext4_mb_init(struct super_block *sb)
>  	free_percpu(sbi->s_locality_groups);
>  	sbi->s_locality_groups = NULL;
>  out:
> +	kfree(sbi->s_mb_largest_free_orders);
> +	kfree(sbi->s_mb_largest_free_orders_locks);
>  	kfree(sbi->s_mb_offsets);
>  	sbi->s_mb_offsets = NULL;
>  	kfree(sbi->s_mb_maxs);
> @@ -3028,6 +3381,7 @@ int ext4_mb_release(struct super_block *sb)
>  		kvfree(group_info);
>  		rcu_read_unlock();
>  	}
> +	kfree(sbi->s_mb_largest_free_orders);


Add kfree(sbi->s_mb_largest_free_orders_locks);

>  	kfree(sbi->s_mb_offsets);
>  	kfree(sbi->s_mb_maxs);
>  	iput(sbi->s_buddy_cache);

regards,
dan carpenter
