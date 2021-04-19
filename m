Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721DB364DDE
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Apr 2021 00:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhDSWyY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Apr 2021 18:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhDSWyY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Apr 2021 18:54:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D58B60FF1;
        Mon, 19 Apr 2021 22:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618872834;
        bh=vmca3TN6y61NV3O1qxeh+me1eGIPDrZgpmPtfmFcpjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhQY2ji42qmejsWXGF3GxQEZqDO3iTOZwUkWOHtDtjGa7tGac6UG/J+MUj4zlTexM
         ixwDjqJ7sT3bdG8BKRQzKM4OqzuolLEWelwGwwpX5xOHqK5J/dF/xQZsJgCzxlLiNQ
         QdgRoSsMq4lAcL82NJ5G/exCFrS7T/JlGZre8jMAXKtRf/6/3AYZuBsDbNkAkCRBVP
         nxmLouZak7WLe/4gq4oOfM1FXn5SFUGd6+LXAamRNO5Xu882lw0/9KS34xiC7hrU1h
         xojQtuHMgDZxqyn2bcYPOXWmLAbcTrS1efgWR9kevdXFuq2UCokf9Fmv+JkRSstxHx
         0XA2bZjT2W3wg==
Date:   Mon, 19 Apr 2021 15:53:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v3] ext4: wipe filename upon file deletion
Message-ID: <YH4KAHWphO+0xubA@gmail.com>
References: <20210419162100.1284475-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419162100.1284475-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 19, 2021 at 04:21:00PM +0000, Leah Rumancik wrote:
> Upon file deletion, zero out all fields in ext4_dir_entry2 besides inode
> and rec_len. In case sensitive data is stored in filenames, this ensures
> no potentially sensitive data is left in the directory entry upon deletion.
> Also, wipe these fields upon moving a directory entry during the conversion
> to an htree and when splitting htree nodes.

This should include more explanation about why this is useful, and what its
limitations are (e.g. how do the properties of the storage device affect whether
the filename is *really* deleted)...

> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 883e2a7cd4ab..df7809a4821f 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1778,6 +1778,11 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
>  		((struct ext4_dir_entry_2 *) to)->rec_len =
>  				ext4_rec_len_to_disk(rec_len, blocksize);
>  		de->inode = 0;
> +
> +		/* wipe name_len through and name field */
> +		memset(&de->name_len, 0, ext4_rec_len_from_disk(de->rec_len,
> +						blocksize) - 6);
> +

The comment is confusing.  IMO it would make more sense to mention what is *not*
being zeroed:

	/* wipe the dir_entry excluding the rec_len field */
	de->inode = 0;
	memset(&de->name_len, 0, ext4_rec_len_from_disk(de->rec_len,
						blocksize) - 6);

> @@ -2492,6 +2498,11 @@ int ext4_generic_delete_entry(struct inode *dir,
>  			else
>  				de->inode = 0;
>  			inode_inc_iversion(dir);
> +
> +			/* wipe name_len through name field */
> +			memset(&de->name_len, 0,
> +				ext4_rec_len_from_disk(de->rec_len, blocksize) - 6);
> +
>  			return 0;

And maybe here too, although here why is the condition for setting the inode to
0 not the same as the condition for zeroing the other fields?

Also, maybe use offsetof(struct ext4_dir_entry_2, name_len) instead of '6'...

- Eric
