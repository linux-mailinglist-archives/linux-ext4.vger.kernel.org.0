Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5809524490
	for <lists+linux-ext4@lfdr.de>; Thu, 12 May 2022 06:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiELEt6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 00:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243630AbiELEt4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 00:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1023237A07
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 21:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82DEC61BA6
        for <linux-ext4@vger.kernel.org>; Thu, 12 May 2022 04:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F54BC385B8;
        Thu, 12 May 2022 04:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652330987;
        bh=z5xJvbJLg59ozEttNGP0Krcnr/2NB7zY+KOPdFEubAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBgtivz89dyaoNiKj0AZQhqwNaicoQKTRCRTU3GN5cjfTn/A2RlHzrkGl/syGnrWi
         sx2M170zd+seUOZJYWgfgixDth8PCL6fXgixux+HP6t0jaRCrVV2S0kJKnYTafdPGj
         67eixDmVrmktKdswK9higqgDPAUbgf1umNwn3sw5XDGFmlEOghO/59sIzxXI41Oxzr
         J1jPXj1oTBDnJl7WJQNLraATvElZngLaK525gA3/UAQ30slVP1MRDW5N69yVx+DSIQ
         MTDjLs9PZiAiL6dhp2nMMK5Altrz3N2BKpugbhOUYUCGQwuU48fhTgF8fkQhxlj6UP
         GBvbd6LRZWPBw==
Date:   Wed, 11 May 2022 21:49:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v4 03/10] f2fs: Simplify the handling of cached
 insensitive names
Message-ID: <YnyR6Z/IdLtTkejE@sol.localdomain>
References: <20220511193146.27526-1-krisman@collabora.com>
 <20220511193146.27526-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511193146.27526-4-krisman@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 11, 2022 at 03:31:39PM -0400, Gabriel Krisman Bertazi wrote:
> Keeping it as qstr avoids the unnecessary conversion in f2fs_match
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/f2fs/dir.c      | 52 ++++++++++++++++++++++++++++------------------
>  fs/f2fs/f2fs.h     |  3 ++-
>  fs/f2fs/recovery.c |  5 +----
>  3 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 166f08623362..c2a02003c5b9 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -81,28 +81,47 @@ int f2fs_init_casefolded_name(const struct inode *dir,
>  {
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	struct super_block *sb = dir->i_sb;
> +	unsigned char *buf;
> +	int len;
>  
>  	if (IS_CASEFOLDED(dir)) {
> -		fname->cf_name.name = f2fs_kmem_cache_alloc(f2fs_cf_name_slab,
> +		buf = f2fs_kmem_cache_alloc(f2fs_cf_name_slab,
>  					GFP_NOFS, false, F2FS_SB(sb));
> -		if (!fname->cf_name.name)
> -			return -ENOMEM;
> -		fname->cf_name.len = utf8_casefold(sb->s_encoding,
> -						   fname->usr_fname,
> -						   fname->cf_name.name,
> -						   F2FS_NAME_LEN);
> -		if ((int)fname->cf_name.len <= 0) {
> -			kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
> +		if (!buf) {
>  			fname->cf_name.name = NULL;
> +			return -ENOMEM;
> +		}
> +
> +		len = utf8_casefold(sb->s_encoding, fname->usr_fname,
> +				    buf, F2FS_NAME_LEN);
> +
> +		if (len <= 0) {
> +			kmem_cache_free(f2fs_cf_name_slab, buf);
> +			buf = NULL;
>  			if (sb_has_strict_encoding(sb))
>  				return -EINVAL;
>  			/* fall back to treating name as opaque byte sequence */
>  		}
> +		fname->cf_name.name = buf;
> +		fname->cf_name.len = (unsigned int) len;
>  	}
>  #endif

There's some inconsistent behavior above; now sometimes fname->cf_name.name is
set to NULL on failure and sometime it's not.  Also now fname->cf_name.len can
be set to a negative value.

Since struct f2fs_filename is always zero-initialized, how about only setting
the fname->cf_name fields if we actually have a valid value to assign?  I.e.

		buf = f2fs_kmem_cache_alloc(f2fs_cf_name_slab,
					GFP_NOFS, false, F2FS_SB(sb));
		if (!buf)
			return -ENOMEM;

		len = utf8_casefold(sb->s_encoding, fname->usr_fname,
				    buf, F2FS_NAME_LEN);
		if (len <= 0) {
			kmem_cache_free(f2fs_cf_name_slab, buf);
			if (sb_has_strict_encoding(sb))
				return -EINVAL;
			/* fall back to treating name as opaque byte sequence */
			return 0;
		}
		fname->cf_name.name = buf;
		fname->cf_name.len = len;

> +void f2fs_free_casefolded_name(struct f2fs_filename *fname)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	unsigned char *buf = (unsigned char *)fname->cf_name.name;
> +
> +	if (buf) {
> +		kmem_cache_free(f2fs_cf_name_slab, buf);
> +		fname->cf_name.name = NULL;
> +	}
> +
> +#endif
> +}

Kernel code usually uses static inline stubs for the !CONFIG_$FOO case in cases
like this, as that causes the function calls to be compiled away to nothing when
they're unneeded.

- Eric
