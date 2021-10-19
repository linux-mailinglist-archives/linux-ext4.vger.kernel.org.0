Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D024331E7
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 11:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhJSJOb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 05:14:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38420 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhJSJOa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 05:14:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 59BA421976;
        Tue, 19 Oct 2021 09:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634634737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNviG73W5CXxu7k+Hr5pl6wFnyxtJHN8JrkqiiHK7LA=;
        b=XrPg5jT+DCKoaG2k5ocQTEfHGkSppHT1XVgCQNLxJhXX+T9JbVG+nr0+BMbX5+Hlp4c2ic
        nAlcRclPn7O2+VB/BCfj7dEl/XNA89DzSyzoDvwNccFk6hKGIUUvdhiuOICEnApyvz1LX1
        f0PQXTnBp2zF/y+eFqFdiCiisycfQo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634634737;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNviG73W5CXxu7k+Hr5pl6wFnyxtJHN8JrkqiiHK7LA=;
        b=jIx8pGNL+vHQm7rncO/9sNPXnIpk/ya0K95ryK6YnHjP/cwwDtHvsCfEJLySgzI4b8IPPi
        /Cxj+PTxEGefy2DQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 3F203A3B8B;
        Tue, 19 Oct 2021 09:12:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 001101E0BE5; Tue, 19 Oct 2021 11:12:16 +0200 (CEST)
Date:   Tue, 19 Oct 2021 11:12:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v3 3/5] ext4: get buffer head before read_mmp_block
Message-ID: <20211019091216.GD3255@quack2.suse.cz>
References: <20211019064959.625557-1-yebin10@huawei.com>
 <20211019064959.625557-4-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019064959.625557-4-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 19-10-21 14:49:57, Ye Bin wrote:
> There is only pass NULL 'bh' in ext4_multi_mount_protect,
> So just call sb_getblk get buffer head fisrt, and we will
> simplify read_mmp_block function.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

I don't think there's a need to separate this into a special patch. Just
fold this change into patch 4. With that feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

The combined change looks good to me.

								Honza

> ---
>  fs/ext4/mmp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 4af8b99ade84..6ac6aacd8fa5 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -295,6 +295,10 @@ int ext4_multi_mount_protect(struct super_block *sb,
>  		goto failed;
>  	}
>  
> +	bh = sb_getblk(sb, mmp_block);
> +	if (bh)
> +		goto failed;
> +
>  	retval = read_mmp_block(sb, &bh, mmp_block);
>  	if (retval)
>  		goto failed;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
