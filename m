Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028AD4741F4
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Dec 2021 13:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhLNMDT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Dec 2021 07:03:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60560 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhLNMDS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Dec 2021 07:03:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7606C2113A;
        Tue, 14 Dec 2021 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639483397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhNZ4PkSqALinQKCIgirA+fLFqcYFioHowV7Dcqr5SQ=;
        b=SgYEfw1vZAVshCeFRZaQyui4/FWkqGBKpapCXf4NXTLdOaTdf4Gv2PeAaaoDNZInpGD3kP
        ceWcYvsM9K/FPZpswZL3TPLyeA9wbYcbJzEf9HKUlelLCe9B1Q6yfH7pDWYle0kx80TamR
        cLIzcT1HhYmvrcJpSS9cALfQ4KykDj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639483397;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhNZ4PkSqALinQKCIgirA+fLFqcYFioHowV7Dcqr5SQ=;
        b=mkOlqs2zYVn1/oN/Ib9wSDQ/jMNfT0/qma43fMTtuA0z9tgwNeb4VsxPDuy/eXyCnwLoLg
        pnMziqlNCM2yEFDQ==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 60313A3B83;
        Tue, 14 Dec 2021 12:03:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1B00C1F2C7E; Tue, 14 Dec 2021 13:03:17 +0100 (CET)
Date:   Tue, 14 Dec 2021 13:03:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <20211214120317.GA5503@quack2.suse.cz>
References: <bug-213357-13602@https.bugzilla.kernel.org>
 <20211206143733.18918-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211206143733.18918-1-lhenriques@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 06-12-21 14:37:33, Luís Henriques wrote:
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

Thanks for debugging this! Two comments below:

> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index 7e0b4f81c6c0..dd4ece38fc83 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -413,7 +413,7 @@ int ext4_ext_migrate(struct inode *inode)
>  	handle_t *handle;
>  	int retval = 0, i;
>  	__le32 *i_data;
> -	struct ext4_inode_info *ei;
> +	struct ext4_inode_info *ei, *tmp_ei;

Probably no need for the new tmp_ei variable when you use it only once...

> @@ -503,6 +503,10 @@ int ext4_ext_migrate(struct inode *inode)
>  	}
>  
>  	ei = EXT4_I(inode);
> +	tmp_ei = EXT4_I(tmp_inode);
> +	/* Use the right seed for checksumming */
> +	tmp_ei->i_csum_seed = ei->i_csum_seed;
> +

I think this is subtly broken in another way: If we crash in the middle of
migration, tmp_inode (and possibly attached extent tree blocks) will have
wrong checksums (remember that i_csum_seed is computed from inode number)
and so orphan cleanup will fail. On the other hand in that case the orphan
cleanup will free blocks we have already managed to attach to the tmp_inode
although they are still properly attached to the old 'inode'. So the
recovery from a crash in the middle of the migration seems to be broken
anyway. So I guess what you do is an improvement. But can you perhaps:

1) Move i_csum_seed initialization to a bit earlier in ext4_ext_migrate()
just after we have got the tmp_inode from  ext4_new_inode()? That way all
inode writes will at least happen with the same csum.

2) Add a comment you are updating the csum seed so that metadata blocks get
proper checksum for 'inode' and that recovery from a crash in the middle of
migration is currently broken.

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
