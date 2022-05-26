Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F4A535428
	for <lists+linux-ext4@lfdr.de>; Thu, 26 May 2022 21:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbiEZTz5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 May 2022 15:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbiEZTz4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 May 2022 15:55:56 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C43D880E5;
        Thu, 26 May 2022 12:55:55 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id bl14so1747054qtb.1;
        Thu, 26 May 2022 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K1mkUeLDGXh6H+DdAZ/Z/GNiMsZS+xgfwmRGEkBJOOM=;
        b=qREScIhnqP8gtHRLCmwMFZmomqKsVOUsin0bvlBK09yl3E40kv996OFMeNlun3GRiz
         czz47XNoc3qzDuZVjfb8shSgZs9X6hdB86El6JqCY4i7gTzsydtVJFQVQOuoFPq40lyz
         ThdWMXCXib6nhbTUIYaU48r8tKRdDL7uHLLK9G3iV2jU9tjIL2sxmLwSJ0vXaQv6zD6g
         arHF+yqExmQhT0RRb8pefTMczTdgUIu2RkuQGgNeycDSbfDkHBulfR3905xtxQ1m9zof
         IXXS/28Fs+8rJDF2JFjS8yMLFQ+ljg+hG507/R0LAyJp2+286i+gIVYw7LJRGheeHBuM
         ttqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K1mkUeLDGXh6H+DdAZ/Z/GNiMsZS+xgfwmRGEkBJOOM=;
        b=xEz7GFBApIGwZ0pJ6qyAQVBYtpQ1eFuItUBqzdSvU8+4lkemogKEtcmvgLXMMZhZNs
         uQnexGekbNF9x9kipvifmo0zv/ngBY+Jk6D6gxJVmAkk049ZjwqDjei4XiigAMkG53Nl
         gKgOvCsH3AGnT9CUpaRGNYvbKA+xlUaMH6UXDIoEcuqk0SPrQ3ZREv65SQ8hjj4wkTZX
         gPNoG1rXPzQqO5qXpWlcHXpIuoQuGejasEVrJZlx6Kbwi6uXHScLBisx/QbLxkwV8Oob
         /OkrSShg2Sv2tyeQyJAflh/eoV9NOjgVm/D8VeP5/C5LqBOmGAQpLIKaYXuX0ImbMlLw
         sxcA==
X-Gm-Message-State: AOAM53172pYn25FA02kPakdtQc9qo15qVwP4WPg9wodussOrfk4FDQE0
        cc8oVjUGbg2MXL8qq0GnIxw=
X-Google-Smtp-Source: ABdhPJxIK2WGJAOGsiK2eeVsCS0VF76lh5sWWj2clMWEp+eUQvy4YNwumx+5jzuSiNkODEb6S37Mzw==
X-Received: by 2002:a05:622a:1450:b0:2fb:6b97:2e10 with SMTP id v16-20020a05622a145000b002fb6b972e10mr6777937qtx.96.1653594954322;
        Thu, 26 May 2022 12:55:54 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id u126-20020ae9d884000000b006a35ac236c4sm1682359qkf.113.2022.05.26.12.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 12:55:53 -0700 (PDT)
Date:   Thu, 26 May 2022 15:55:51 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: Fix warning in ext4_da_release_space
Message-ID: <Yo/bRxbM8OBP0JlI@debian-BULLSEYE-live-builder-AMD64>
References: <20220520025540.3189247-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520025540.3189247-1-yebin10@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Ye Bin <yebin10@huawei.com>:
> We got issue as follows:
> WARNING: CPU: 2 PID: 1936 at fs/ext4/inode.c:1511 ext4_da_release_space+0x1b9/0x266
> Modules linked in:
> CPU: 2 PID: 1936 Comm: dd Not tainted 5.10.0+ #344
> RIP: 0010:ext4_da_release_space+0x1b9/0x266
> RSP: 0018:ffff888127307848 EFLAGS: 00010292
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff843f67cc
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffed1024e60ed9
> RBP: ffff888124dc8140 R08: 0000000000000083 R09: ffffed1075da6d23
> R10: ffff8883aed36917 R11: ffffed1075da6d22 R12: ffff888124dc83f0
> R13: ffff888124dc844c R14: ffff888124dc8168 R15: 000000000000000c
> FS:  00007f6b7247d740(0000) GS:ffff8883aed00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc1a0b7dd8 CR3: 00000001065ce000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ext4_es_remove_extent+0x187/0x230
>  mpage_release_unused_pages+0x3af/0x470
>  ext4_writepages+0xb9b/0x1160
>  do_writepages+0xbb/0x1e0
>  __filemap_fdatawrite_range+0x1b1/0x1f0
>  file_write_and_wait_range+0x80/0xe0
>  ext4_sync_file+0x13d/0x800
>  vfs_fsync_range+0x75/0x140
>  do_fsync+0x4d/0x90
>  __x64_sys_fsync+0x1d/0x30
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Above issue may happens as follows:
> 	process1                        process2
> ext4_da_write_begin
>   ext4_da_reserve_space
>     ext4_es_insert_delayed_block[1/1]
>                                     ext4_da_write_begin
> 				      ext4_es_insert_delayed_block[0/1]
> ext4_writepages
>   ****Delayed block allocation failed****
>   mpage_release_unused_pages
>     ext4_es_remove_extent[1/1]
>       ext4_da_release_space [reserved 0]
> 
> ext4_da_write_begin
>   ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)
>    ->As there exist [0, 1] extent, so will return true
>                                    ext4_writepages
> 				   ****Delayed block allocation failed****
>                                      mpage_release_unused_pages
> 				       ext4_es_remove_extent[0/1]
> 				         ext4_da_release_space [reserved 1]
> 					   ei->i_reserved_data_blocks [1->0]
> 
>   ext4_es_insert_delayed_block[1/1]
> 
> ext4_writepages
>   ****Delayed block allocation failed****
>   mpage_release_unused_pages
>   ext4_es_remove_extent[1/1]
>    ext4_da_release_space [reserved 1]
>     ei->i_reserved_data_blocks[0, -1]
>     ->As ei->i_reserved_data_blocks already is zero but to_free is 1,
>     will trigger warning.
> 

Hi:

Do you have a reproducer for this warning?  I'd like to understand the sequence
of events that led to the initial block allocation failure in process 1.

A question about your notation - what does "[1/1]" in
"ext4_es_insert_delayed_block[1/1]" mean?

I'm assuming this failure was seen on a bigalloc filesystem with a 4k block
size and 64K cluster size?

Thanks,
Eric

> To solve above issue, introduce i_clu_lock to protect insert delayed
> block and remove block under cluster delay allocate mode.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/ext4.h           |  3 +++
>  fs/ext4/extents_status.c |  5 +++++
>  fs/ext4/inode.c          | 11 +++++++++--
>  fs/ext4/super.c          |  1 +
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index bcd3b9bf8069..47c88ac4d4a8 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1169,6 +1169,9 @@ struct ext4_inode_info {
>  	__u32 i_csum_seed;
>  
>  	kprojid_t i_projid;
> +
> +	/* Protect concurrent add cluster delayed block and remove block */
> +	struct mutex i_clu_lock;
>  };
>  
>  /*
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 9a3a8996aacf..dd679014db98 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1433,6 +1433,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  			  ext4_lblk_t len)
>  {
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	ext4_lblk_t end;
>  	int err = 0;
>  	int reserved = 0;
> @@ -1455,9 +1456,13 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	 * so that we are sure __es_shrink() is done with the inode before it
>  	 * is reclaimed.
>  	 */
> +	if (sbi->s_cluster_ratio != 1)
> +		mutex_lock(&EXT4_I(inode)->i_clu_lock);
>  	write_lock(&EXT4_I(inode)->i_es_lock);
>  	err = __es_remove_extent(inode, lblk, end, &reserved);
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> +	if (sbi->s_cluster_ratio != 1)
> +		mutex_unlock(&EXT4_I(inode)->i_clu_lock);
>  	ext4_es_print_tree(inode);
>  	ext4_da_release_space(inode, reserved);
>  	return err;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 01c9e4f743ba..1109d77ad60b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1649,17 +1649,22 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  			goto errout;
>  		reserved = true;
>  	} else {   /* bigalloc */
> +		mutex_lock(&EXT4_I(inode)->i_clu_lock);
>  		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
>  			if (!ext4_es_scan_clu(inode,
>  					      &ext4_es_is_mapped, lblk)) {
>  				ret = ext4_clu_mapped(inode,
>  						      EXT4_B2C(sbi, lblk));
> -				if (ret < 0)
> +				if (ret < 0) {
> +					mutex_unlock(&EXT4_I(inode)->i_clu_lock);
>  					goto errout;
> +				}
>  				if (ret == 0) {
>  					ret = ext4_da_reserve_space(inode);
> -					if (ret != 0)   /* ENOSPC */
> +					if (ret != 0) {   /* ENOSPC */
> +						mutex_unlock(&EXT4_I(inode)->i_clu_lock);
>  						goto errout;
> +					}
>  					reserved = true;
>  				} else {
>  					allocated = true;
> @@ -1671,6 +1676,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  	}
>  
>  	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
> +	if (sbi->s_cluster_ratio != 1)
> +		mutex_unlock(&EXT4_I(inode)->i_clu_lock);
>  	if (ret && reserved)
>  		ext4_da_release_space(inode, 1);
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c5021ca0a28a..aa6f2a68bf41 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1347,6 +1347,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
>  	ext4_fc_init_inode(&ei->vfs_inode);
>  	mutex_init(&ei->i_fc_lock);
> +	mutex_init(&ei->i_clu_lock);
>  	return &ei->vfs_inode;
>  }
>  
> -- 
> 2.31.1
> 
