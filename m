Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79F942D600
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJNJ3B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 05:29:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42212 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhJNJ3B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Oct 2021 05:29:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B7F171FD32;
        Thu, 14 Oct 2021 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634203615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLQfy3ZoLS8x7LVZfGiK17ZJGdZMf8tJTi8CNsmBbGc=;
        b=HC2eecZaTsxlqi59jaw4MBqyE8yDAIIyAvt+ycvez0HJBKnwN6ry/3xkQ3Ck7QUeQLefJn
        LHhnJr6wWPtHtC+sqFzfSAjuAwOsd+oh+YkVOqh3AIVPwyTHVg5N5mWeB2PnF1Yj1Phbd5
        ukvL03vskvIBOSnQG4ICLDf1+jfhVjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634203615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLQfy3ZoLS8x7LVZfGiK17ZJGdZMf8tJTi8CNsmBbGc=;
        b=U6iw6WWGTBX585/HJKi6+urU9ZKc7GZJ1qBO+EETg9xNw5bfa7YQtjTIn8P5saBBxIC0Cb
        o5Bz/YWVkTETjrBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 74F67A3B87;
        Thu, 14 Oct 2021 09:26:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5EF411E0C03; Thu, 14 Oct 2021 11:26:55 +0200 (CEST)
Date:   Thu, 14 Oct 2021 11:26:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     CGEL <cgel.zte@gmail.com>
Cc:     tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] ext4:namei: fix boolreturn.cocci warnings
Message-ID: <20211014092655.GD15931@quack2.suse.cz>
References: <20210824055543.58718-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824055543.58718-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 23-08-21 22:55:43, CGEL wrote:
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.
> 
> ./fs/ext4/namei.c:1441:12-13:WARNING:return of 0/1 in function
> 'ext4_match' with return type bool
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>

This seems to have fallen through the cracks. The fix looks good to me.
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index f3bbcd4..b5cb32d 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1438,7 +1438,7 @@ static bool ext4_match(struct inode *parent,
>  					fname->hinfo.minor_hash !=
>  						EXT4_DIRENT_MINOR_HASH(de)) {
>  
> -					return 0;
> +					return false;
>  				}
>  			}
>  			return !ext4_ci_compare(parent, &cf, de->name,
> -- 
> 1.8.3.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
