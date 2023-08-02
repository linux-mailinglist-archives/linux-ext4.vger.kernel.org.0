Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36D976C414
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 06:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjHBEXK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 00:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHBEXJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 00:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A384AC;
        Tue,  1 Aug 2023 21:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 180C9617A4;
        Wed,  2 Aug 2023 04:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F69C433C8;
        Wed,  2 Aug 2023 04:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690950187;
        bh=mHOlubQuduaY+CSZBFzy3ucDx4u6oKY3tnkmhd0qwJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8yy87I5DKbj6SP2MfJCqjnNE3iMgkHjJ3hXVTTin8Gj5XmdkKqukK9/u+o7FbYIp
         E8RI9KUKUKcH4x6oY0IXyUSw76eGqGrW6d7QkE3rtsEgdYAv+rIE9reWF1jZjfNX5S
         7p43JsPDBJgpakq0RmGgDjtHh1ak+KV6W47MkaRi1Tt3/75bucQN/IDDyXdr2fHuOo
         ep4PKL1B87xVzR2yN4IeRO8u969qeXqfNIFUG24P6h5EqqbAB76aDwJGnUQ8ahvE6O
         y3ZapN6GDWlBmuHF0N9UY50SgMkLxiBaKuErS2aA02YFWlAfg8q1hJcKa1dde1j7Cz
         pNXyqEp9VHn5g==
Date:   Tue, 1 Aug 2023 21:23:05 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fname_setup_filename()
 error path
Message-ID: <20230802042305.GB1543@sol.localdomain>
References: <20230801144136.23565-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801144136.23565-1-lhenriques@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 01, 2023 at 03:41:36PM +0100, Luís Henriques wrote:
> If casefolding the filename fails, we'll be leaking fscrypt_buf name.
> Make sure we free it in the error path.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ext4/crypto.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
> index e20ac0654b3f..9e4503b051c4 100644
> --- a/fs/ext4/crypto.c
> +++ b/fs/ext4/crypto.c
> @@ -33,6 +33,8 @@ int ext4_fname_setup_filename(struct inode *dir, const struct qstr *iname,
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	err = ext4_fname_setup_ci_filename(dir, iname, fname);
> +	if (err)
> +		fscrypt_free_filename(&name);
>  #endif
>  	return err;
>  }

Doesn't ext4_fname_prepare_lookup() have the same bug?

Also, please include a Fixes tag.

- Eric
