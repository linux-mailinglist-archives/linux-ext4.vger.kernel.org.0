Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B253576E0
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Apr 2021 23:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhDGVdb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 17:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhDGVd2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 7 Apr 2021 17:33:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37951610D0;
        Wed,  7 Apr 2021 21:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617831197;
        bh=VI6iD780zCgN/ZDvvpg1jRnEHaJYUZSN/nf/L3j9r6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnJh4tacE7Gy/+Hv6bu5QOOE9PpZWMGE3odqTaYyl2mWsEYLi8vYvJKHoL1waA4Iy
         8ekdEifzEXc7wT9Ioeo40uESRyA+V+2gjqOsiQ1oh+u0ulm2ht9CWuYC6mtunLaxDV
         UEkdhAKHgXi20X1xjLdz5WwERCsTv2b3ahVJ6+PnmkFi6zXZ3Ryn9pKR20ra18t64S
         abxUXWlnCz33EFXvcxc5sMGNAWEWlRuZnl0b4GySdnI+OOWSajCbgOCj9LX7w/uYpf
         L2ILCzcIvKk6lCw1jEjZDC0ZmC+A07TMz/qLvZxjFvN5oxSYu544UNUPS/blVOo0EM
         6o0Gzsz1hQ2TQ==
Date:   Wed, 7 Apr 2021 14:33:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: wipe filename upon file deletion
Message-ID: <YG4lG2B9Wf4t6IfA@gmail.com>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-2-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407154202.1527941-2-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 07, 2021 at 03:42:01PM +0000, Leah Rumancik wrote:
> Zero out filename and file type fields when file is deleted.

Why?

Also what about when a dir_entry is moved?  Wouldn't you want to make sure that
any copies don't get left around?

> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  fs/ext4/namei.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 883e2a7cd4ab..0147c86de99e 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2492,6 +2492,10 @@ int ext4_generic_delete_entry(struct inode *dir,
>  			else
>  				de->inode = 0;
>  			inode_inc_iversion(dir);
> +
> +			memset(de_del->name, 0, de_del->name_len);
> +			memset(&de_del->file_type, 0, sizeof(__u8));

The second line could be written as simply 'de_del->file_type = 0'.

Also why zero these two fields in particular and not the whole dir_entry?

- Eric
