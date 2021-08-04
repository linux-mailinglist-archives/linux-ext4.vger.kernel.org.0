Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469143E0439
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhHDPco (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 11:32:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42306 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbhHDPci (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 11:32:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B39D821DC1;
        Wed,  4 Aug 2021 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628091144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZTQVflxg1xumcXv2psH1AudaLak+V/X7QqKx6v8ICaY=;
        b=1tuFAG8bkoM5RyFnk2N2HqUcLjlJncPzGLLg0zi2D60zrAn1edKYURkw2aQ46BCs+w7Q+b
        aYZBMFHb7Q9Ch2ZVOqHlJWGdS9On95zDkARLfnMgwljMNZNPtss2T4UBjEGXRGj2WU9DXF
        rml1CsuzDYCt2vcs2ke8AbAf1zW/q+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628091144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZTQVflxg1xumcXv2psH1AudaLak+V/X7QqKx6v8ICaY=;
        b=LMtZ0EgX+Tu3S2OCFERJ4qeqJZf8eKLm5pdwoZxNv7Q3HJRrLuP6ZAPL0WNWycp9f6m1TV
        gaGN72Dqtodb4SDw==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id A2B82A3B95;
        Wed,  4 Aug 2021 15:32:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F1E6D1F2B83; Wed,  4 Aug 2021 17:32:21 +0200 (CEST)
Date:   Wed, 4 Aug 2021 17:32:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca
Subject: Re: [PATCH V3 5/5] ext4: make fallocate retry when err is ENOSPC
Message-ID: <20210804153221.GK4578@quack2.suse.cz>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-6-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724074124.25731-6-jianchao.wan9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 24-07-21 15:41:24, Wang Jianchao wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> The blocks may be waiting for journal commit to be freed back to
> mb buddy. Let fallocate wait and retry in that case.
> 
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

Did you really observe this? Because the retry is already handled in
ext4_alloc_file_blocks() that's used by ext4_fallocate(). So no retry
should be needed there.

								Honza

> ---
>  fs/ext4/extents.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 92ad64b89d9b..ad0b874d3448 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4635,7 +4635,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	struct inode *inode = file_inode(file);
>  	loff_t new_size = 0;
>  	unsigned int max_blocks;
> -	int ret = 0;
> +	int ret = 0, retries = 0;
>  	int flags;
>  	ext4_lblk_t lblk;
>  	unsigned int blkbits = inode->i_blkbits;
> @@ -4656,6 +4656,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		     FALLOC_FL_INSERT_RANGE))
>  		return -EOPNOTSUPP;
>  
> +retry:
>  	ext4_fc_start_update(inode);
>  
>  	if (mode & FALLOC_FL_PUNCH_HOLE) {
> @@ -4722,6 +4723,9 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
>  exit:
>  	ext4_fc_stop_update(inode);
> +	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
> +		goto retry;
> +
>  	return ret;
>  }
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
