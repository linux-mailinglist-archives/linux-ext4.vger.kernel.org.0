Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B77C61AE
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Oct 2023 02:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjJLA00 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Oct 2023 20:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJLA0Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Oct 2023 20:26:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01C49E
        for <linux-ext4@vger.kernel.org>; Wed, 11 Oct 2023 17:26:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27ceb58f7e7so308212a91.0
        for <linux-ext4@vger.kernel.org>; Wed, 11 Oct 2023 17:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1697070378; x=1697675178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PC8X7y+hdUDhjEkdJNEa0sfWqzi1ayjAHCHVFeZ8H0c=;
        b=VJRAAO6OotNatAvA5z4GKPMxrlxkwUXOl/4BIOps3s01UjkrCSdOg1K2mx88egq2tS
         j2RGB0yD20cVL16hJ+p2xr8jcHKmFku/skYjbEi0U0RUrFhp4iqWHvFmBqO8zsemZjap
         T/7f0fF7TRsg1QVkj2pIWg7WmO4xLAgLC0ZlY9vUm95tqU7zFfUsWEyx4W2U+AwfeOJF
         mq5fCebJPCf5bLtNcaTRoPl/MWWaCTNmY6ykYGw284C8OwRu2oAG98XWdb8lw7ZVNGzh
         F5Ncyxd7qD1+vI8a7WWW8n9XAoeavbtq3zTvWXerCKpnOv7dMit7GY419LN87gtl1MGb
         Rhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070378; x=1697675178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC8X7y+hdUDhjEkdJNEa0sfWqzi1ayjAHCHVFeZ8H0c=;
        b=Ce/KTlE21TJfDMMgZsbiYdar8I8IIwgE/WcFVTE9AYkEchiIcJBtqXz6BSCLUEf8Ek
         haBksnYUNV5eKMf/sa18aECAQiky0U4lmQMi9tRlrjS23HIQQ2WykDK4OkDRqINKRXMM
         DWlGtYVCJYGPT39mj5KKQ3aQsXqUKyxu4nB8kBFGe/zLfi33lbIV+rkVmnqTTkNz088K
         7K2l9d771Ojk0zhkzpkhUpdWkS8H63nr8ElTbIK77Ry9gZFYpO/ri2K6WZBwnbC7+7vF
         0dwLl0oBZXM9QW8dUmpW++QvDxL9RZu1wmj3x4MYlyret3nox7MuOk7hnBdsoG9/+OKF
         PBJA==
X-Gm-Message-State: AOJu0YyfZB6+s+HNGIH5zHTECXQIjwAOAbnAEJbbwi/xn0QbRBwlY5xT
        EYtYq2k4dYGlhO4QjNXtxJweRcUn31x6ttj1Q8I=
X-Google-Smtp-Source: AGHT+IE7pUEwzipDeOHC0Ve4QWkBCU4HjkCRY+nQddtjta+CWTScgmHpc6qNClB0nKc08R5uXCfbvw==
X-Received: by 2002:a17:90a:343:b0:27d:1379:6271 with SMTP id 3-20020a17090a034300b0027d13796271mr1855909pjf.46.1697070378363;
        Wed, 11 Oct 2023 17:26:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id f64-20020a17090a704600b0027ce7ee8859sm596571pjk.13.2023.10.11.17.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 17:26:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qqjWp-00Cchk-1U;
        Thu, 12 Oct 2023 11:26:15 +1100
Date:   Thu, 12 Oct 2023 11:26:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] ext4: Properly sync file size update after O_SYNC direct
 IO
Message-ID: <ZSc9J9zFChyxl1U2@dread.disaster.area>
References: <20231011142155.19328-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011142155.19328-1-jack@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 11, 2023 at 04:21:55PM +0200, Jan Kara wrote:
> Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
> sync file size update and thus if we crash at unfortunate moment, the
> file can have smaller size although O_SYNC IO has reported successful
> completion. The problem happens because update of on-disk inode size is
> handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
> dio_complete() in particular) has returned and generic_file_sync() gets
> called by dio_complete(). Fix the problem by handling on-disk inode size
> update directly in our ->end_io completion handler.
> 
> References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/file.c | 139 ++++++++++++++++++-------------------------------
>  1 file changed, 52 insertions(+), 87 deletions(-)
.....
> @@ -388,9 +342,28 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
>  		 */
>  		if (inode->i_nlink)
>  			ext4_orphan_del(NULL, inode);
> +		return;
>  	}
> +	/*
> +	 * If i_disksize got extended due to writeback of delalloc blocks while
> +	 * the DIO was running we could fail to cleanup the orphan list in
> +	 * ext4_handle_inode_extension(). Do it now.
> +	 */
> +	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> +		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);

So this has to be called after the DIO write completes and calls
ext4_handle_inode_extension()?

....

> @@ -606,9 +570,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			   dio_flags, NULL, 0);
>  	if (ret == -ENOTBLK)
>  		ret = 0;
> -
>  	if (extend)
> -		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> +		ext4_inode_extension_cleanup(inode, ret);

Because this doesn't wait for AIO DIO to complete and actually
extend the file before running the cleanup code...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
