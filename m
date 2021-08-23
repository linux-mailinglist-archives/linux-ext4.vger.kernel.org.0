Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD393F5241
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 22:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhHWUbU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 16:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhHWUaz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 16:30:55 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5528C061760
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 13:30:12 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id q6so10449352qvs.12
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tf5+lfDHGKNSo05boxExiLBPvRZkXk21DEeX4G89asM=;
        b=feTLf4slaXW1YXQqR/wDPL/3F+HmYTtVIlDE51NbE38g8qBcDJRPFotGYKIie7aDWu
         g/tKxpss5dsLljaswmpQ/G5hfCv1rmRXnNu3a++GjvNIVfSlZaiaMiuLQuWtDOaHXuTL
         5wsIE0uWqVAqP+NaexiQ3mCEdT/2AZvkjkgexmIbslH0mHw8IYNH5UHRiSGRUEnmo7qa
         sPBRJxOWBuZzQ9P8ZxqvOHI1U9mdWdJ3k8X11iblO5i1CTMbCRZK0GxCVK1tbOACx0j4
         icnAPDt3wr44wNTXchWlbC85NXhAgRWzUIOv+deJz1cdmgL/cMouxOZ8jj9w/nif3Hsh
         P6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tf5+lfDHGKNSo05boxExiLBPvRZkXk21DEeX4G89asM=;
        b=RgYi7kn2VeqRKustF3UBfF7q7siZke1I2/suXeYCQq/bN1W3/eWWPYbzdHhw8pbiuw
         OWGT5J9TWI8Y1ccyVWdKqRBKW6pN/oEB1fVtHnzV77xuRn3nPHehTEOV7VrtZtmbNjat
         kqnid/tznEHCE0r2vhtUB7KMFB7wYStWjIlo/uT6bErR/aOtWIdEauYUMvE+H9ZLCTuD
         p9RB+6dzQ9UrJAQNmjGdJhYtOL0L50muQvfrYC5uk/I98dV50vC3iocAHC3PZsjN0Hbt
         vaLW7mz6Cdy+I90nL0tQkC7+54xprv237RqpX7R7lUqLoSqaxQZZPgkSRxr8rOSwnmDQ
         mNMA==
X-Gm-Message-State: AOAM533m4pTA16kwmb8nhbn8ca7F+dnp7J1jO/ktJ/SJHCZIB/Dn0eB6
        aMRoV61krDc3m8T6hwWtJyU=
X-Google-Smtp-Source: ABdhPJzj/VQkEp6Pi32lTx/yrIKDx9FYaf1I7lmoKX7LqpqiZ1N8OIwm4Yuz0Bsv7TJS2+mJY0eO+w==
X-Received: by 2002:a0c:fa06:: with SMTP id q6mr11058786qvn.50.1629750611900;
        Mon, 23 Aug 2021 13:30:11 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id q192sm2616390qka.93.2021.08.23.13.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:30:11 -0700 (PDT)
Date:   Mon, 23 Aug 2021 16:30:09 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com,
        enwlinux@gmail.com, hsiangkao@linux.alibaba.com
Subject: Re: [PATCH v2] ext4: fix reserved space counter leakage
Message-ID: <20210823203009.GA10429@localhost.localdomain>
References: <20210823061358.84473-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823061358.84473-1-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Jeffle Xu <jefflexu@linux.alibaba.com>:
> When ext4_insert_delayed block receives and recovers from an error from
> ext4_es_insert_delayed_block(), e.g., ENOMEM, it does not release the
> space it has reserved for that block insertion as it should. One effect
> of this bug is that s_dirtyclusters_counter is not decremented and
> remains incorrectly elevated until the file system has been unmounted.
> This can result in premature ENOSPC returns and apparent loss of free
> space.
> 
> Another effect of this bug is that
> /sys/fs/ext4/<dev>/delayed_allocation_blocks can remain non-zero even
> after syncfs has been executed on the filesystem.
> 
> Besides, add check for s_dirtyclusters_counter when inode is going to be
> evicted and freed. s_dirtyclusters_counter can still keep non-zero until
> inode is written back in .evict_inode(), and thus the check is delayed
> to .destroy_inode().
> 
> Fixes: 51865fda28e5 ("ext4: let ext4 maintain extent status tree")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
> changes since v1:
> - improve commit log suggested by Eric Whitney
> - update "Suggested-by" title for Gao Xian, who actually found this bug
>   code
> - add check for s_dirtyclusters_counter in .destroy_inode()
> ---
>  fs/ext4/inode.c | 5 +++++
>  fs/ext4/super.c | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d8de607849df..73daf9443e5e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1640,6 +1640,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	int ret;
>  	bool allocated = false;
> +	bool reserved = false;
>  
>  	/*
>  	 * If the cluster containing lblk is shared with a delayed,
> @@ -1656,6 +1657,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  		ret = ext4_da_reserve_space(inode);
>  		if (ret != 0)   /* ENOSPC */
>  			goto errout;
> +		reserved = true;
>  	} else {   /* bigalloc */
>  		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
>  			if (!ext4_es_scan_clu(inode,
> @@ -1668,6 +1670,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  					ret = ext4_da_reserve_space(inode);
>  					if (ret != 0)   /* ENOSPC */
>  						goto errout;
> +					reserved = true;
>  				} else {
>  					allocated = true;
>  				}
> @@ -1678,6 +1681,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  	}
>  
>  	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
> +	if (ret && reserved)
> +		ext4_da_release_space(inode, 1);
>  
>  errout:
>  	return ret;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dfa09a277b56..61bf52b58fca 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1351,6 +1351,12 @@ static void ext4_destroy_inode(struct inode *inode)
>  				true);
>  		dump_stack();
>  	}
> +
> +	if (EXT4_I(inode)->i_reserved_data_blocks)
> +		ext4_msg(inode->i_sb, KERN_ERR,
> +			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
> +			 inode->i_ino, EXT4_I(inode),
> +			 EXT4_I(inode)->i_reserved_data_blocks);
>  }
>  
>  static void init_once(void *foo)
> -- 
> 2.27.0
> 

Looks good, passed 4k xfstests-bld regression.  Feel free to add:

Reviewed-by: Eric Whitney <enwlinux@gmail.com>

Eric
