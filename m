Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB58E4BCD
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2019 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439593AbfJYNKK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Oct 2019 09:10:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439018AbfJYNKK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Oct 2019 09:10:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1F92B29C;
        Fri, 25 Oct 2019 13:10:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E3E811E4852; Fri, 25 Oct 2019 15:02:37 +0200 (CEST)
Date:   Fri, 25 Oct 2019 15:02:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: don't set count in the case of failure
Message-ID: <20191025130237.GA30163@quack2.suse.cz>
References: <20191022092720.24416-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022092720.24416-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 22-10-19 17:27:20, Chengguang Xu wrote:
> In the case of failure, the num is still initialized value 0
> so we should not set it to *count because it will bring
> unexpected side effect to the caller.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Looks good to me but please ellaborate a bit in the changelog what are
visible effects of this bug. Thanks!

								Honza

> ---
>  fs/ext2/balloc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 18e75adcd2f6..cc516c7b7974 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -736,7 +736,6 @@ ext2_try_to_allocate(struct super_block *sb, int group,
>  	*count = num;
>  	return grp_goal - num;
>  fail_access:
> -	*count = num;
>  	return -1;
>  }
>  
> -- 
> 2.20.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
