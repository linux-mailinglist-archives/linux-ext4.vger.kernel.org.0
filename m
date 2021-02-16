Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFC231D0DB
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Feb 2021 20:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhBPTTq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Feb 2021 14:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhBPTTj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Feb 2021 14:19:39 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE0BC061574
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 11:18:58 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id c3so9867166qkj.11
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 11:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qb9rD4UIk4ycLyAKWs4OWuYoiIyYIH1t5twEFaScC7k=;
        b=slFU67q9mu8ePJvJe3ik0pmA4csmBaAyBqFMNm8AMLQFeiyC2HKKbvLidzFYhCFKVf
         ToftQfuujTepq8l1KfYXyegrus3NvgVd+u3qbG97NGY4aKGgxjsSnnLCg4t7ZdXZlrdC
         uPulYucVcNdNlsiHrdyggEz7W112ckYmox6vrldOrKB9CnEOZ16rBXB3Sq3NmJzPT8Mg
         Q4yVkKPxd9gyFjza+fngIkw0F5eESPxCnBoYdSHR9+PKyOCKDgIAjqLLWkVf9Ik59gJc
         46YTmkn/nSZ2mLW9SKVXr4KnzXedEJWA0sCrU7pKwNj3ttvd0HQYxzWMtn6xk4Ks/WOk
         pSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qb9rD4UIk4ycLyAKWs4OWuYoiIyYIH1t5twEFaScC7k=;
        b=XkK/8LMuLboKtMV858kUx3K1vmRtaOuDrBv5abPBYyvXWZ5FR/WR9qCFrMb5nDHVzX
         sBv5sFYmfrpEVLwQYdneoOXCcA2ICokP0Pc2cuYltNkhx+SZtd5EpMWNb2YgX2M7Zl5s
         DlQNPUy8T23l2OK3kJxwdJrYnSglObnXWRoLGPJBkrqOicDlTeAdUF8ThQCxuvdXmk2D
         SgfEBFIYOt8Iq9y5HupV/I28A6QGWB5ErSDyRkMEY0ap5RTnl7gHWLOFOuRK5MbrOM5R
         oATkn+9qkJEcHivy3HkHWEWqnJuorrPtbWQLsyZML6R4h8z/rK+7QWVmPwvVPNO1/OFf
         GTmQ==
X-Gm-Message-State: AOAM531o8wq8skciJhzYLkUwT5fglAKt19uye2FTjR/MjXjpNLDp4Q+4
        ng4iARQnXjTu/kcJLnVBtC4=
X-Google-Smtp-Source: ABdhPJzuxK1tug58tRDmqCL34aMKTqvHqFLqD0zBUDykz9OJC51C6UJQjyps/vjPXU0HEoKFxcRI5A==
X-Received: by 2002:a05:620a:24c7:: with SMTP id m7mr22043526qkn.219.1613503137829;
        Tue, 16 Feb 2021 11:18:57 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id m190sm15003176qkc.66.2021.02.16.11.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 11:18:57 -0800 (PST)
Date:   Tue, 16 Feb 2021 14:18:55 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4: delete some unused tracepoint definitions
Message-ID: <20210216191855.GA21006@localhost.localdomain>
References: <20210209221959.23883-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209221959.23883-1-enwlinux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Eric Whitney <enwlinux@gmail.com>:
> A number of tracepoint instances have been removed from ext4 by past
> patches but the definitions of those tracepoints have not.
> 
> All instances of ext4_ext_in_cache and ext4_ext_put_in_cache were
> removed by "ext4: remove single extent cache" (69eb33dc24dc).
> ext4_get_reserved_cluster_alloc was removed by
> "ext4: reduce reserved cluster count by number of allocated clusters"
> (b6bf9171ef5c).
> ext4_find_delalloc_range was removed by
> "ext4: reimplement ext4_find_delay_alloc_range on extent status tree"
> (7d1b1fbc95eb).
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> ---
>  include/trace/events/ext4.h | 118 ------------------------------------
>  1 file changed, 118 deletions(-)
> 
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 70ae5497b73a..3c3f40605391 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -1962,124 +1962,6 @@ TRACE_EVENT(ext4_get_implied_cluster_alloc_exit,
>  		  __entry->len, show_mflags(__entry->flags), __entry->ret)
>  );
>  
> -TRACE_EVENT(ext4_ext_put_in_cache,
> -	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, unsigned int len,
> -		 ext4_fsblk_t start),
> -
> -	TP_ARGS(inode, lblk, len, start),
> -
> -	TP_STRUCT__entry(
> -		__field(	dev_t,		dev	)
> -		__field(	ino_t,		ino	)
> -		__field(	ext4_lblk_t,	lblk	)
> -		__field(	unsigned int,	len	)
> -		__field(	ext4_fsblk_t,	start	)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->dev	= inode->i_sb->s_dev;
> -		__entry->ino	= inode->i_ino;
> -		__entry->lblk	= lblk;
> -		__entry->len	= len;
> -		__entry->start	= start;
> -	),
> -
> -	TP_printk("dev %d,%d ino %lu lblk %u len %u start %llu",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  (unsigned long) __entry->ino,
> -		  (unsigned) __entry->lblk,
> -		  __entry->len,
> -		  (unsigned long long) __entry->start)
> -);
> -
> -TRACE_EVENT(ext4_ext_in_cache,
> -	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, int ret),
> -
> -	TP_ARGS(inode, lblk, ret),
> -
> -	TP_STRUCT__entry(
> -		__field(	dev_t,		dev	)
> -		__field(	ino_t,		ino	)
> -		__field(	ext4_lblk_t,	lblk	)
> -		__field(	int,		ret	)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->dev	= inode->i_sb->s_dev;
> -		__entry->ino	= inode->i_ino;
> -		__entry->lblk	= lblk;
> -		__entry->ret	= ret;
> -	),
> -
> -	TP_printk("dev %d,%d ino %lu lblk %u ret %d",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  (unsigned long) __entry->ino,
> -		  (unsigned) __entry->lblk,
> -		  __entry->ret)
> -
> -);
> -
> -TRACE_EVENT(ext4_find_delalloc_range,
> -	TP_PROTO(struct inode *inode, ext4_lblk_t from, ext4_lblk_t to,
> -		int reverse, int found, ext4_lblk_t found_blk),
> -
> -	TP_ARGS(inode, from, to, reverse, found, found_blk),
> -
> -	TP_STRUCT__entry(
> -		__field(	dev_t,		dev		)
> -		__field(	ino_t,		ino		)
> -		__field(	ext4_lblk_t,	from		)
> -		__field(	ext4_lblk_t,	to		)
> -		__field(	int,		reverse		)
> -		__field(	int,		found		)
> -		__field(	ext4_lblk_t,	found_blk	)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->dev		= inode->i_sb->s_dev;
> -		__entry->ino		= inode->i_ino;
> -		__entry->from		= from;
> -		__entry->to		= to;
> -		__entry->reverse	= reverse;
> -		__entry->found		= found;
> -		__entry->found_blk	= found_blk;
> -	),
> -
> -	TP_printk("dev %d,%d ino %lu from %u to %u reverse %d found %d "
> -		  "(blk = %u)",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  (unsigned long) __entry->ino,
> -		  (unsigned) __entry->from, (unsigned) __entry->to,
> -		  __entry->reverse, __entry->found,
> -		  (unsigned) __entry->found_blk)
> -);
> -
> -TRACE_EVENT(ext4_get_reserved_cluster_alloc,
> -	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, unsigned int len),
> -
> -	TP_ARGS(inode, lblk, len),
> -
> -	TP_STRUCT__entry(
> -		__field(	dev_t,		dev	)
> -		__field(	ino_t,		ino	)
> -		__field(	ext4_lblk_t,	lblk	)
> -		__field(	unsigned int,	len	)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->dev	= inode->i_sb->s_dev;
> -		__entry->ino	= inode->i_ino;
> -		__entry->lblk	= lblk;
> -		__entry->len	= len;
> -	),
> -
> -	TP_printk("dev %d,%d ino %lu lblk %u len %u",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  (unsigned long) __entry->ino,
> -		  (unsigned) __entry->lblk,
> -		  __entry->len)
> -);
> -
>  TRACE_EVENT(ext4_ext_show_extent,
>  	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
>  		 unsigned short len),
> -- 
> 2.20.1
>

Please ignore this patch - I've posted an updated v2.

Thanks,
Eric

