Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4E12C025F
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 10:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKWJhL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 04:37:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:41890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgKWJhL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Nov 2020 04:37:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6EB2AC24;
        Mon, 23 Nov 2020 09:37:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C2E041E130F; Mon, 23 Nov 2020 10:37:09 +0100 (CET)
Date:   Mon, 23 Nov 2020 10:37:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 030/141] ext2: Fix fall-through warnings for Clang
Message-ID: <20201123093709.GB27294@quack2.suse.cz>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <73d8ae2d06d639815672ee9ee4550ea4bfa08489.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d8ae2d06d639815672ee9ee4550ea4bfa08489.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 20-11-20 12:28:25, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of just letting the code
> fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks. Applied.

								Honza

> ---
>  fs/ext2/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 11c5c6fe75bb..78c417d3c898 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1256,6 +1256,7 @@ static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
>  				mark_inode_dirty(inode);
>  				ext2_free_branches(inode, &nr, &nr+1, 3);
>  			}
> +			break;
>  		case EXT2_TIND_BLOCK:
>  			;
>  	}
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
