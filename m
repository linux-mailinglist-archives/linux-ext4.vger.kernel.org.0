Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C437D1EA30F
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jun 2020 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgFALrL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Jun 2020 07:47:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:32902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgFALrK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 1 Jun 2020 07:47:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8FF8DAD5F;
        Mon,  1 Jun 2020 11:47:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F12771E0948; Mon,  1 Jun 2020 13:47:08 +0200 (CEST)
Date:   Mon, 1 Jun 2020 13:47:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jaegeuk@kernel.org, jack@suse.cz,
        linux-ext4@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: stop overwrite the errcode in ext4_setup_super
Message-ID: <20200601114708.GG3960@quack2.suse.cz>
References: <20200601073404.3712492-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601073404.3712492-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 01-06-20 15:34:04, yangerkun wrote:
> Now the errcode from ext4_commit_super will overwrite EROFS exists in
> ext4_setup_super. Actually, no need to call ext4_commit_super since we
> will return EROFS. Fix it by goto done directly.
> 
> Fixes: c89128a00838 ("ext4: handle errors on ext4_commit_super")
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Yeah, makes sense. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index bf5fcb477f66..87c5611a4c67 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2344,6 +2344,7 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
>  		ext4_msg(sb, KERN_ERR, "revision level too high, "
>  			 "forcing read-only mode");
>  		err = -EROFS;
> +		goto done;
>  	}
>  	if (read_only)
>  		goto done;
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
