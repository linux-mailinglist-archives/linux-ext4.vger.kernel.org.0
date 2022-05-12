Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9738524496
	for <lists+linux-ext4@lfdr.de>; Thu, 12 May 2022 06:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbiELEz0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 00:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiELEz0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 00:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7CF7485B
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 21:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE0DE61B9A
        for <linux-ext4@vger.kernel.org>; Thu, 12 May 2022 04:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F5FC385B8;
        Thu, 12 May 2022 04:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652331324;
        bh=LjJkrm4cL0YKX8d0K1tDmCRcU9xobTmXP7lqKvNMgzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CUbZiuT2sGtwfXmUDmNN0ngEkt+xo7xEuqs3rQTzLZuKRuxIxqou1ZKgZgjwoDTZB
         vYtty0AoC7G1D9gz3Z0p57cott30zT19BGmpbcfYG1qMisR6fCuk+nl3vjPtGZvTFn
         CtiLqgNdAJ0xhcHMVNRYWDLDdeXDKXfziS+ptf3JEif5NtnOyochFV/vBD4V6CurW5
         Wn0AvFcM4rqhkfa1k+pC2FfdGA6UDeHw+sU1iSxv3uPsPtYEBzTwRhAolUs9LeWeWb
         USLZqrMTSFzCOOon2I4ouQhthRK3eW8oY/4TFLixzJdoImZot/wkSJf93yNJn4FuvR
         eMbosi09CDTTQ==
Date:   Wed, 11 May 2022 21:55:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v4 10/10] f2fs: Move CONFIG_UNICODE defguards into the
 code flow
Message-ID: <YnyTOlV5p498bvPg@sol.localdomain>
References: <20220511193146.27526-1-krisman@collabora.com>
 <20220511193146.27526-11-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511193146.27526-11-krisman@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 11, 2022 at 03:31:46PM -0400, Gabriel Krisman Bertazi wrote:
> @@ -293,10 +294,6 @@ static void f2fs_destroy_casefold_cache(void)
>  {
>  	kmem_cache_destroy(f2fs_cf_name_slab);
>  }
> -#else
> -static int __init f2fs_create_casefold_cache(void) { return 0; }
> -static void f2fs_destroy_casefold_cache(void) { }
> -#endif
[...]
> @@ -4611,7 +4608,10 @@ static int __init init_f2fs_fs(void)
>  	err = f2fs_init_compress_cache();
>  	if (err)
>  		goto free_compress_mempool;
> -	err = f2fs_create_casefold_cache();
> +
> +	if (IS_ENABLED(CONFIG_UNICODE))
> +		err = f2fs_create_casefold_cache();
> +
>  	if (err)
>  		goto free_compress_cache;
>  	return 0;
> @@ -4654,7 +4654,9 @@ static int __init init_f2fs_fs(void)
>  
>  static void __exit exit_f2fs_fs(void)
>  {
> -	f2fs_destroy_casefold_cache();
> +	if (IS_ENABLED(CONFIG_UNICODE))
> +		f2fs_destroy_casefold_cache();
> +

I don't think the above two changes are actually an improvement.  It's cleaner
to use stub functions to keep the callers simpler, as the original code did.

- Eric
