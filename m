Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB01EFC62
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgFEPUI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 11:20:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:55716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgFEPUI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jun 2020 11:20:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F7C4AE68;
        Fri,  5 Jun 2020 15:20:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A20B31E1281; Fri,  5 Jun 2020 17:20:05 +0200 (CEST)
Date:   Fri, 5 Jun 2020 17:20:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: fix improper assignment for e_value_offs
Message-ID: <20200605152005.GE13248@quack2.suse.cz>
References: <20200603084429.25344-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603084429.25344-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 03-06-20 16:44:29, Chengguang Xu wrote:
> In the process of changing value for existing EA,
> there is an improper assignment of e_value_offs(setting to 0),
> because it will be reset to incorrect value in the following
> loop(shifting EA values before target). Delayed assignment
> can avoid this issue.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/ext2/xattr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 943cc469f42f..c802ea682e7f 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -588,7 +588,6 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  			/* Remove the old value. */
>  			memmove(first_val + size, first_val, val - first_val);
>  			memset(first_val, 0, size);
> -			here->e_value_offs = 0;
>  			min_offs += size;
>  
>  			/* Adjust all value offsets. */
> @@ -600,6 +599,8 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  						cpu_to_le16(o + size);
>  				last = EXT2_XATTR_NEXT(last);
>  			}
> +
> +			here->e_value_offs = 0;
>  		}
>  		if (value == NULL) {
>  			/* Remove the old name. */
> -- 
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
