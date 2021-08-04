Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C4F3E03FC
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 17:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbhHDPPw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 11:15:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35018 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhHDPPv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 11:15:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6D4722016C;
        Wed,  4 Aug 2021 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628090138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHv8XYd+IZ+5DH86o+EXCxB9q3v5RswnAg0sBp/Dqec=;
        b=m2ImgcNRX69adJLfiCQFkcy6AvSUqIFXMV4MsOT+8yiymHQK41oQ0gNUr0cghoSYOV6n60
        eEnVygAkw0oWzzZ/jtxJFScOlxVqR6mike+aXwfJ7A6GYttACf0zSqmPfavxti3XJkFm9K
        XQkGcidpVxHe6tLeiIQgYOjNX3kxDPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628090138;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHv8XYd+IZ+5DH86o+EXCxB9q3v5RswnAg0sBp/Dqec=;
        b=EwbFfBfdTnphokiRQDf0fjT8bJQUNrO0rC1wmQetb6Gfs8En89q02UipaESK+ddCJz+RHg
        9eLXNWHTgYnGeCAA==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 3EB78A3B89;
        Wed,  4 Aug 2021 15:15:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A6B951E62D6; Wed,  4 Aug 2021 17:15:35 +0200 (CEST)
Date:   Wed, 4 Aug 2021 17:15:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Denis Lukianov <denis@voxelsoft.com>
Subject: Re: [PATCH] ext4: fix directory index node split corruption
Message-ID: <20210804151535.GG4578@quack2.suse.cz>
References: <20210730182403.3254365-1-artem.blagodarenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730182403.3254365-1-artem.blagodarenko@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 30-07-21 14:24:03, Artem Blagodarenko wrote:
> I send patch whose author is Denis Lukianov <denis@voxelsoft.com>
> His messages can't reach this list somehow.
> I only rebased it ontop of master's HEAD and tested that it fixes
> the problem and reviewed.
> 
> ----
> 
> Following commit b5776e7, a trivial sequential write of empty files to
> an empty ext4 file system (with large_dir enabled) fails after just
> over 26 million files. Depending on luck, file creation will give error
> EEXIST or EUCLEAN.
> 
> Commit b5776e7 fixed the no-restart condition so that
> ext4_handle_dirty_dx_node is always called, but it also broke the
> restart condition. This is because when restart=1, the original
> implementation correctly skipped do_split() but b5776e7 clobbered the
> "if(restart)goto journal_error;" logic.
> 
> This complementary change protects do_split() from restart condition,
> making it safe from both current and future ordering of goto statements
> in earlier sections of the code.
> 
> Tested on 5.11.20 with handy testing script:
> 
> i = 0
> while i <= 32000000:
>     print (i)
>     with open('tmpmnt/%d' % i, 'wb') as fout:
>         i += 1
> 
> Google-Bug-Id: 176345532
> Fixes: b5776e7 ("ext4: fix potential htree index checksum corruption")

Please use 12 characters from git commit when identifying it (7 characters 
is likely to become non-unique). Otherwise the fix looks good so feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Also I think you should include Ted in 'To' or 'CC' to make it more likely
he sees the patch.

								Honza


> Signed-off-by: Denis Lukianov <denis@voxelsoft.com>
> Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
> ---
>  fs/ext4/namei.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 5fd56f616cf0..0bbff03d4167 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2542,13 +2542,16 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  			goto journal_error;
>  		}
>  	}
> -	de = do_split(handle, dir, &bh, frame, &fname->hinfo);
> -	if (IS_ERR(de)) {
> -		err = PTR_ERR(de);
> +	if (!restart) {
> +		de = do_split(handle, dir, &bh, frame, &fname->hinfo);
> +		if (IS_ERR(de)) {
> +			err = PTR_ERR(de);
> +			goto cleanup;
> +		}
> +		err = add_dirent_to_buf(handle, fname, dir, inode, de,
> +bh);
>  		goto cleanup;
>  	}
> -	err = add_dirent_to_buf(handle, fname, dir, inode, de, bh);
> -	goto cleanup;
>  
>  journal_error:
>  	ext4_std_error(dir->i_sb, err); /* this is a no-op if err == 0 */
> -- 
> 2.18.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
