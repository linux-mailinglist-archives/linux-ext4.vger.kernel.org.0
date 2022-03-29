Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA74EA5A8
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Mar 2022 05:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiC2DDi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 23:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiC2DDh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 23:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F240624372C
        for <linux-ext4@vger.kernel.org>; Mon, 28 Mar 2022 20:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E02B61345
        for <linux-ext4@vger.kernel.org>; Tue, 29 Mar 2022 03:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF293C340ED;
        Tue, 29 Mar 2022 03:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648522914;
        bh=5Wwdzziakk84dm81LfSkIvf2qUNRL44JOF6FiABS2Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIdTZ3LBJJ6McaC3c/rsFTaCSm5bowFApSt6SGedOTpLuHW5/IpKr8VtUHJSQY6OE
         1ol6WbdNVy7z9e7e9edIwY5XX6Wu9qxxaQPyyuJa4HlKcl3WrrYIblhDALY8pMGm39
         8tCgIR4lIv6c8F9QrDFIm/flu3AIZ+/hKxrjwJZ3I3vqJHVJFyyJwfaKq7E7xaUk8R
         DQ4hRP67WW2/CgEZcUc+FlQEFTUKAZGNZla//yMKRwrW0u6KYedwnMKlzZ/TRjSgde
         581/ZbMDSP/P/gaaAMZqck/P7ObumPbYkx59zJa+yu4vGyl9DUqYGGG8a/oejP1WQ1
         e5f+NwXVnhRZw==
Date:   Mon, 28 Mar 2022 20:01:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 2/5] ext4: Simplify the handling of chached insensitive
 names
Message-ID: <YkJ2oFqrYf80PHcm@sol.localdomain>
References: <20220322030004.148560-1-krisman@collabora.com>
 <20220322030004.148560-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322030004.148560-3-krisman@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 21, 2022 at 11:00:01PM -0400, Gabriel Krisman Bertazi wrote:
> Keeping it as qstr avoids the unnecessary conversion in ext4_match
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/ext4/ext4.h  |  2 +-
>  fs/ext4/namei.c | 23 +++++++++++------------
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index bcd3b9bf8069..46e729ce7b35 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2484,7 +2484,7 @@ struct ext4_filename {
>  	struct fscrypt_str crypto_buf;
>  #endif
>  #if IS_ENABLED(CONFIG_UNICODE)
> -	struct fscrypt_str cf_name;
> +	struct qstr cf_name;
>  #endif
>  };
>  
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 24ea3bb446d0..8976e5a28c73 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1382,28 +1382,29 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
>  int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
>  				  struct ext4_filename *name)
>  {
> -	struct fscrypt_str *cf_name = &name->cf_name;
> +	struct qstr *cf_name = &name->cf_name;
> +	unsigned char *buf;
>  	struct dx_hash_info *hinfo = &name->hinfo;
>  	int len;
>  
>  	if (!IS_CASEFOLDED(dir) || !dir->i_sb->s_encoding ||
>  	    (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir))) {
> -		cf_name->name = NULL;
> +		name->cf_name.name = NULL;
>  		return 0;
>  	}

Why not keep "cf_name->name = NULL;" above?

- Eric
