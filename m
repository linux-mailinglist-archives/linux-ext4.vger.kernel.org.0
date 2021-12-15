Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE80474F87
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 01:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbhLOAtt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Dec 2021 19:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbhLOAtt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Dec 2021 19:49:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56E4C06173E;
        Tue, 14 Dec 2021 16:49:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95C14B81DFD;
        Wed, 15 Dec 2021 00:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E64C34601;
        Wed, 15 Dec 2021 00:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639529386;
        bh=FZKl3tGfrowl5Ti7tX7JSdDJMVveBK63MZ1TCe4VWaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jj3b3SgFhHnCFW1lJXQRXxR67BMC9ieccEdiaFUqH2GO8+TEokXFiBAmqk6+D561L
         y/pyo4mFtnWvKRkcNH9EVuwyF5oUSLSDJDmfAt+YgFZqWw4GVljKicJlpA6q8x/Nd1
         qIkSgECnpTv06qHJ+qa2OTyBhjeYYg5FnaiHpWMewF9s/WMaShUkuubZttE6n/Qxpc
         vgjglmKasHoaAf22Js0hTbb1vI2eKdfR3PeIwjMgOeRv8H2jH8b3NykbJEa5OJk4P1
         vkdi5xKzYqmb2E/jOtibYoiEOd2S8ZST9EK7kzb2E58yVslGABW+1Xo9/3D4DNqgaY
         GGtxSjADmAqew==
Date:   Tue, 14 Dec 2021 16:49:45 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <20211215004945.GD69182@magnolia>
References: <20211214175058.19511-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211214175058.19511-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 14, 2021 at 05:50:58PM +0000, Luís Henriques wrote:
> When migrating to extents, the temporary inode will have it's own checksum
> seed.  This means that, when swapping the inodes data, the inode checksums
> will be incorrect.
> 
> This can be fixed by recalculating the extents checksums again.  Or simply
> by copying the seed into the temporary inode.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=213357
> Reported-by: Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ext4/migrate.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> changes since v1:
> 
> * Dropped tmp_ei variable
> * ->i_csum_seed is now initialised immediately after tmp_inode is created
> * New comment about the seed initialization and stating that recovery
>   needs to be fixed.
> 
> Cheers,
> --
> Luís
> 
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index 7e0b4f81c6c0..36dfc88ce05b 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -459,6 +459,17 @@ int ext4_ext_migrate(struct inode *inode)
>  		ext4_journal_stop(handle);
>  		goto out_unlock;
>  	}
> +	/*
> +	 * Use the correct seed for checksum (i.e. the seed from 'inode').  This
> +	 * is so that the metadata blocks will have the correct checksum after
> +	 * the migration.
> +	 *
> +	 * Note however that, if a crash occurs during the migration process,
> +	 * the recovery process is broken because the tmp_inode checksums will
> +	 * be wrong and the orphans cleanup will fail.

...and then what does the user do?

--D

> +	 */
> +	ei = EXT4_I(inode);
> +	EXT4_I(tmp_inode)->i_csum_seed = ei->i_csum_seed;
>  	i_size_write(tmp_inode, i_size_read(inode));
>  	/*
>  	 * Set the i_nlink to zero so it will be deleted later
> @@ -502,7 +513,6 @@ int ext4_ext_migrate(struct inode *inode)
>  		goto out_tmp_inode;
>  	}
>  
> -	ei = EXT4_I(inode);
>  	i_data = ei->i_data;
>  	memset(&lb, 0, sizeof(lb));
>  
