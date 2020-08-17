Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD955246E65
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Aug 2020 19:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389719AbgHQR2r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Aug 2020 13:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:50030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389370AbgHQRIz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 17 Aug 2020 13:08:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6BD24AC5E;
        Mon, 17 Aug 2020 17:09:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F19311E12CB; Mon, 17 Aug 2020 19:08:53 +0200 (CEST)
Date:   Mon, 17 Aug 2020 19:08:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ext4: use kmemdup_nul() instead of kstrndup()
Message-ID: <20200817170853.GC22500@quack2.suse.cz>
References: <1596894336-49052-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596894336-49052-1-git-send-email-xianting_tian@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 08-08-20 09:45:36, Xianting Tian wrote:
> kmemdup_nul() is more efficient than kmemdup_nul() if
> the size is known exactly.
> 
> The description of kstrndup() already suggested:
> Note: Use kmemdup_nul() instead if the size is known exactly.
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>

Thanks for the patch but I think it is not ideal. The thing is that
s_mount_opt is actually a NUL terminated string (we are just careful and
don't rely on that to avoid problems when the fs is corrupted). So it is
possibly shorter than those 64 bytes reserved for it in the superblock and
using kmemdup_nul() will allocate and copy more memory than strictly
necessary.

								Honza

> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957e..be37556 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4016,7 +4016,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	}
>  
>  	if (sbi->s_es->s_mount_opts[0]) {
> -		char *s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
> +		char *s_mount_opts = kmemdup_nul(sbi->s_es->s_mount_opts,
>  					      sizeof(sbi->s_es->s_mount_opts),
>  					      GFP_KERNEL);
>  		if (!s_mount_opts)
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
