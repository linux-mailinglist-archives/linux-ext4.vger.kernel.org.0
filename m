Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8424EA5BB
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Mar 2022 05:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiC2DKJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 23:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiC2DKI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 23:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1BC29C96
        for <linux-ext4@vger.kernel.org>; Mon, 28 Mar 2022 20:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCB6861359
        for <linux-ext4@vger.kernel.org>; Tue, 29 Mar 2022 03:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9E8C340F0;
        Tue, 29 Mar 2022 03:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648523305;
        bh=S0soBTIrSO427euo8QPzg5Yx10nO7y+iWWOGggN19Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XC2VLfoeE2pcTQq6N+yoO/qio7LRuk0k1uxC5myuCHxvD0Ejztmd+1jWPJb2XkS7S
         P61WwAozYF+1vDXynTHLWTlphUXa9WoqCdfQ4e3VZQXXmj4iJZdU/7P4iR4OLq4NEA
         FuMNLnka6/Y9CNgw6qVa4IXnPJRPBKlf7M2j9VzocKMlgob5ECJtOIzWgFFNkk9VYx
         loBXVPVP+KrF9ZRLZYXyeElYXuyAPhiMXKUPjK2TG9ZaXcfl6gYI+FPSe+ho1Ob5Pe
         8DYguJWAM0YBg8oXrdqGpW89ajXrdf7ZOXloN3p9DWeQg1ac2MUS03vr7tvEjmMmBx
         mzLPpayiNeuBA==
Date:   Mon, 28 Mar 2022 20:08:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 3/5] ext4: Implement ci comparison using fscrypt_name
Message-ID: <YkJ4J0XNSkSSf2Xo@sol.localdomain>
References: <20220322030004.148560-1-krisman@collabora.com>
 <20220322030004.148560-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322030004.148560-4-krisman@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 21, 2022 at 11:00:02PM -0400, Gabriel Krisman Bertazi wrote:
> By using fscrypt_name here, we can hide most of the caching casefold
> logic from ext4.  The condition in ext4_match is now quite redundant,
> but this is addressed in the next patch.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/ext4/namei.c         | 26 ++++++++++++--------------
>  include/linux/fscrypt.h |  4 ++++
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 8976e5a28c73..71b4b05fae89 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1321,10 +1321,9 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
>  /**
>   * ext4_ci_compare() - Match (case-insensitive) a name with a dirent.
>   * @parent: Inode of the parent of the dentry.
> - * @name: name under lookup.
> + * @fname: name under lookup.
>   * @de_name: Dirent name.
>   * @de_name_len: dirent name length.
> - * @quick: whether @name is already casefolded.
>   *
>   * Test whether a case-insensitive directory entry matches the filename
>   * being searched.  If quick is set, the @name being looked up is
> @@ -1333,8 +1332,9 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
>   * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
>   * < 0 on error.
>   */
> -static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
> -			   u8 *de_name, size_t de_name_len, bool quick)
> +static int ext4_ci_compare(const struct inode *parent,
> +			   const struct fscrypt_name *fname,
> +			   u8 *de_name, size_t de_name_len)
>  {
>  	const struct super_block *sb = parent->i_sb;
>  	const struct unicode_map *um = sb->s_encoding;
> @@ -1357,10 +1357,10 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
>  		entry.len = decrypted_name.len;
>  	}
>  
> -	if (quick)
> -		ret = utf8_strncasecmp_folded(um, name, &entry);
> +	if (fname->cf_name.name)
> +		ret = utf8_strncasecmp_folded(um, &fname->cf_name, &entry);
>  	else
> -		ret = utf8_strncasecmp(um, name, &entry);
> +		ret = utf8_strncasecmp(um, fname->usr_fname, &entry);
>  
>  	if (!ret)
>  		match = true;
> @@ -1370,8 +1370,8 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
>  		 * the names have invalid characters.
>  		 */
>  		ret = 0;
> -		match = ((name->len == entry.len) &&
> -			 !memcmp(name->name, entry.name, entry.len));
> +		match = ((fname->usr_fname->len == entry.len) &&
> +			 !memcmp(fname->usr_fname->name, entry.name, entry.len));
>  	}
>  
>  out:
> @@ -1440,6 +1440,8 @@ static bool ext4_match(struct inode *parent,
>  #endif
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
> +	f.cf_name = fname->cf_name;
> +
>  	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
>  	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
>  		if (fname->cf_name.name) {
> @@ -1451,13 +1453,9 @@ static bool ext4_match(struct inode *parent,
>  					return false;
>  				}
>  			}
> -			ret = ext4_ci_compare(parent, &fname->cf_name, de->name,
> -					      de->name_len, true);
> -		} else {
> -			ret = ext4_ci_compare(parent, fname->usr_fname,
> -					      de->name, de->name_len, false);
>  		}
>  
> +		ret = ext4_ci_compare(parent, &f, de->name, de->name_len);
>  		if (ret < 0) {
>  			/*
>  			 * Treat comparison errors as not a match.  The
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 91ea9477e9bd..5dc4b3c805e4 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -36,6 +36,10 @@ struct fscrypt_name {
>  	u32 minor_hash;
>  	struct fscrypt_str crypto_buf;
>  	bool is_nokey_name;
> +
> +#ifdef CONFIG_UNICODE
> +	struct qstr cf_name;
> +#endif
>  };
>  

This seems like the wrong approach.  struct fscrypt_name shouldn't have fields
that aren't used by the fs/crypto/ layer.

Did you check what f2fs does?  It has a struct f2fs_filename to represent
everything f2fs needs to know about a filename, and it only uses
struct fscrypt_name when communicating with the fs/crypto/ layer.

struct ext4_filename already exists.  Couldn't you use that here?

- Eric
