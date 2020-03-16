Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B54186DEB
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Mar 2020 15:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgCPO5i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Mar 2020 10:57:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:33618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731539AbgCPO5h (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Mar 2020 10:57:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA7BDB213;
        Mon, 16 Mar 2020 14:57:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3156D1E10DA; Mon, 16 Mar 2020 15:57:35 +0100 (CET)
Date:   Mon, 16 Mar 2020 15:57:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ext2: xattr.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200316145735.GA22684@quack2.suse.cz>
References: <20200309180441.GA2992@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309180441.GA2992@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 09-03-20 13:04:41, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/ext2/xattr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/xattr.h b/fs/ext2/xattr.h
> index cee888cdc235..16272e6ddcf4 100644
> --- a/fs/ext2/xattr.h
> +++ b/fs/ext2/xattr.h
> @@ -39,7 +39,7 @@ struct ext2_xattr_entry {
>  	__le32	e_value_block;	/* disk block attribute is stored on (n/i) */
>  	__le32	e_value_size;	/* size of attribute value */
>  	__le32	e_hash;		/* hash value of name and value */
> -	char	e_name[0];	/* attribute name */
> +	char	e_name[];	/* attribute name */
>  };
>  
>  #define EXT2_XATTR_PAD_BITS		2
> -- 
> 2.25.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
