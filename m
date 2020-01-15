Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02ECC13BD3B
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2020 11:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbgAOKRL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jan 2020 05:17:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:53868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgAOKRL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Jan 2020 05:17:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13B11ABC7;
        Wed, 15 Jan 2020 10:17:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 26E6B1E0CBC; Wed, 15 Jan 2020 11:12:04 +0100 (CET)
Date:   Wed, 15 Jan 2020 11:12:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ext4: remove MPAGE_DA_EXTENT_TAIL
Message-ID: <20200115101204.GD31450@quack2.suse.cz>
References: <1579081888-6244-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579081888-6244-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-01-20 17:51:28, Alex Shi wrote:
> After commit 4e7ea81db534 ("ext4: restructure writeback path"), this
> macro isn't used anymore. so better to remove it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca> 
> Cc: linux-ext4@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 

Thanks for the patch but I think Ted already merged a very similar cleanup
into his tree.

								Honza

> ---
>  fs/ext4/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 629a25d999f0..bb2d8c9205b7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -48,8 +48,6 @@
>  
>  #include <trace/events/ext4.h>
>  
> -#define MPAGE_DA_EXTENT_TAIL 0x01
> -
>  static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
>  			      struct ext4_inode_info *ei)
>  {
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
