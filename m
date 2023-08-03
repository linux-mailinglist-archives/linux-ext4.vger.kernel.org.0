Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F976DF5E
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 06:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHCET0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 00:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjHCETW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 00:19:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C3930CF;
        Wed,  2 Aug 2023 21:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A7B461BD4;
        Thu,  3 Aug 2023 04:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB582C433C9;
        Thu,  3 Aug 2023 04:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691036359;
        bh=VLs+scbvQ34KjbdAmierHUVPhapWUU91JYmANc8PqKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duU3ggpHzuB9R4XKQvBCRY2IFmay6LVBqGVtJKWp+VRJTgdIjz7s1nVGPrK1ihuZj
         1n5YuwnRFusSr1JAuYeuCpN+6YjGMpSpLkcyIawIkJ7TGCFjkRGQ0UsCgQwKqb08fP
         ArWBoiC6mrP5MQhqo+Jv2NV0kx0RHc5jBPDKE6bOBs2ot+6nv96DGS6KHw66LoQNrD
         FH2Vk9LPwv71GB1ZrfPFJbOVezN8M/71Z0mk9Ew+S2j1K9A4oecuWtXa8C/yy3zrvj
         Dtu4gEVuXUDvyq41AjjmU2F0YOjq0qjWFmXMUumg6FWn6nRMyOUsuyY6KrOFnVDk9w
         CGcy7miwB3CmQ==
Date:   Wed, 2 Aug 2023 21:19:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniel Rosenberg <drosen@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix memory leaks in
 ext4_fname_{setup_filename,prepare_lookup}
Message-ID: <20230803041918.GA1218@sol.localdomain>
References: <20230802094931.18215-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802094931.18215-1-lhenriques@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 02, 2023 at 10:49:31AM +0100, Luís Henriques wrote:
> If casefolding the filename fails, we'll be leaking fscrypt_buf name.

fscrypt_buf => fscrypt_name

> diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
> index e20ac0654b3f..3c05c7f3415b 100644
> --- a/fs/ext4/crypto.c
> +++ b/fs/ext4/crypto.c
> @@ -33,6 +33,8 @@ int ext4_fname_setup_filename(struct inode *dir, const struct qstr *iname,
>	struct fscrypt_name name;
>	int err;
>
>	err = fscrypt_setup_filename(dir, iname, lookup, &name);
>	if (err)
>		return err;
>
>	ext4_fname_from_fscrypt_name(fname, &name);
>
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	err = ext4_fname_setup_ci_filename(dir, iname, fname);
> +	if (err)
> +		fscrypt_free_filename(&name);
>  #endif
>  	return err;
>  }
> @@ -51,6 +53,8 @@ int ext4_fname_prepare_lookup(struct inode *dir, struct dentry *dentry,
>	struct fscrypt_name name;
>	int err;
>
>	err = fscrypt_prepare_lookup(dir, dentry, &name);
>	if (err)
>		return err;
>
>	ext4_fname_from_fscrypt_name(fname, &name);
>
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
> +	if (err)
> +		fscrypt_free_filename(&name);
>  #endif
>  	return err;
>  }

This works, but it's a bit weird that the freeing happens on the original struct
fscrypt_name after it has already been "moved" to the struct ext4_filename by
ext4_fname_from_fscrypt_name().  That leaves a dangling pointer in the struct
ext4_filename.  Maybe you should call ext4_fname_free_filename() instead, even
though it would do some unnecessary work?

- Eric
