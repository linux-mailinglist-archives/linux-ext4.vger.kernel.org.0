Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DDC52451F
	for <lists+linux-ext4@lfdr.de>; Thu, 12 May 2022 07:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349938AbiELFqS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 01:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiELFqP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 01:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7343121C
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 22:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81F1C61CE5
        for <linux-ext4@vger.kernel.org>; Thu, 12 May 2022 05:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A87C34100;
        Thu, 12 May 2022 05:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652334372;
        bh=gyKsjkRqtv54mB/Owm8oe3NUBcn2Nz/5hAT4vfxUkVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRtoXiKoAN1oMcyoLY2h7ueQZgNgjPGJy9gRREAc+JzARJHx/TJ/PqfgXnij1rxa5
         Ta87yhrdgayrGKHRCUVdtPsY6Kg0qlz4VU71DWQn6NLXffSb1K/RBPt6Lnx310ieOW
         Kz+iX6xAPxj05pltbBvA88Te65W84866xGq76MmdNyDimD6dctLaSCNpQoZhIN0MID
         xC+LGsQhNJv+DKlwa3kdqX4u+wUXvTRYoK9YQ/VjBaS4FLdPHey20xlBRHqvliFs3T
         uPPyvKv5KY6ouglYS3EdxstiKs3HNJ7/qqpaIvxM4QCcIqWUk1mQ9EnkDoGK9z4EH6
         59QDyzvhoaBsQ==
Date:   Wed, 11 May 2022 22:46:10 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v4 05/10] ext4: Simplify hash check on ext4_match
Message-ID: <YnyfIn6AuDw/ImUi@sol.localdomain>
References: <20220511193146.27526-1-krisman@collabora.com>
 <20220511193146.27526-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511193146.27526-6-krisman@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 11, 2022 at 03:31:41PM -0400, Gabriel Krisman Bertazi wrote:
> The existence of fname->cf_name.name requires s_encoding & IS_CASEFOLDED,
> therefore this can be simplified.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/ext4/namei.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 5296ced2e43e..cebbcabf0ff0 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1438,25 +1438,19 @@ static bool ext4_match(struct inode *parent,
>  #endif
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
> -	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
> -	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
> +	if (IS_ENCRYPTED(parent) && fname->cf_name.name) {
> +		if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
> +		    fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de))
> +			return false;
> +	}
> +
> +	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent)) {
>  		struct unicode_name u = {
>  			.folded_name = &fname->cf_name,
>  			.usr_name = fname->usr_fname
>  		};
>  		int ret;
>  
> -		if (fname->cf_name.name) {
> -			if (IS_ENCRYPTED(parent)) {
> -				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
> -					fname->hinfo.minor_hash !=
> -						EXT4_DIRENT_MINOR_HASH(de)) {
> -
> -					return false;
> -				}
> -			}
> -		}
> -

I don't think it's correct to delete the check for the encryption key here.  If
lookup is by no-key name, then fscrypt_match_name() must be used, not
generic_ci_match().  And unlike f2fs, ext4 doesn't keep track of whether the
whole lookup is by no-key name; ext4 relies on this fscrypt_has_encryption_key()
check at the last minute when doing each individual comparison.  (Which is not
great, but that's how it works now.)

- Eric
