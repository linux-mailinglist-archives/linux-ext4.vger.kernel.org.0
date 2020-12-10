Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9B2D6186
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbgLJQSy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 11:18:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:35552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbgLJQSt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 10 Dec 2020 11:18:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4EE6AE95;
        Thu, 10 Dec 2020 16:18:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 348D31E1354; Thu, 10 Dec 2020 17:18:06 +0100 (CET)
Date:   Thu, 10 Dec 2020 17:18:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     xiakaixu1987@gmail.com
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] ext4: remove the unused EXT4_CURRENT_REV macro
Message-ID: <20201210161806.GB31725@quack2.suse.cz>
References: <1605164202-31120-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605164202-31120-1-git-send-email-kaixuxia@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 12-11-20 14:56:42, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> There are no callers of the EXT4_CURRENT_REV macro, so remove it.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

I guess this has fallen through the cracks? The cleanup looks good to me.
You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index bf9429484462..cf1c01139f26 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1858,7 +1858,6 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
>  #define EXT4_GOOD_OLD_REV	0	/* The good old (original) format */
>  #define EXT4_DYNAMIC_REV	1	/* V2 format w/ dynamic inode sizes */
>  
> -#define EXT4_CURRENT_REV	EXT4_GOOD_OLD_REV
>  #define EXT4_MAX_SUPP_REV	EXT4_DYNAMIC_REV
>  
>  #define EXT4_GOOD_OLD_INODE_SIZE 128
> -- 
> 2.20.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
