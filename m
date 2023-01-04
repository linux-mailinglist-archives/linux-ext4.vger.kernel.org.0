Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0591365CB20
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 01:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjADAzC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Jan 2023 19:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjADAzB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Jan 2023 19:55:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F114817070;
        Tue,  3 Jan 2023 16:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2345B81151;
        Wed,  4 Jan 2023 00:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2880FC433EF;
        Wed,  4 Jan 2023 00:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672793697;
        bh=D6kfiVE9mOojgtBjsTsllPEN/tZ8Ks/6aaCN32Ve4Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCCVcy5Fg8yE5P4F1SSVrZau28sxHVJfMQmJm5uNuMn/euAdc62ttf8L99nhGl3Hr
         iYfz3N/vZW+pLgKR2GEt+em3gmFkUTDCtFCAcgeo0iH5ZLYVF3OW1pbxUg75MuI1uS
         PrZkTO6NXSz94VPxNC3E7Jc0rGW4MRPb4E6d4H5ReZrW+sGjZ3MwwbVLZDAFWSl7az
         ux9pKObnTpv5WmqH/qNVHjm+nQ0QLPU58CQ1UoME7IIDSTKZlTvj5soX7TSuqUmZZK
         yqtkR/Q+VXo0kwutDlKWcKn7qboODjjJWSmifteSat3rxTFdyKwosfOP3APthscdqS
         wMtIttSbc2kvA==
Date:   Tue, 3 Jan 2023 18:55:01 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix function prototype mismatch for ext4_feat_ktype
Message-ID: <Y7TOZRnz9sH6C2ey@work>
References: <20230103234616.never.915-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103234616.never.915-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 03, 2023 at 03:46:20PM -0800, Kees Cook wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed.
> 
> ext4_feat_ktype was setting the "release" handler to "kfree", which
> doesn't have a matching function prototype. Add a simple wrapper
> with the correct prototype.
> 
> This was found as a result of Clang's new -Wcast-function-type-strict
> flag, which is more sensitive than the simpler -Wcast-function-type,
> which only checks for type width mismatches.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Build-tested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Just for the record, this is the warning Clang reports without this
patch:

fs/ext4/sysfs.c:508:13: warning: cast from 'void (*)(const void *)' to 'void (*)(struct kobject *)' converts to incompatible function type [-Wcast-function-type-strict]

Thanks
--
Gustavo

> ---
>  fs/ext4/sysfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index d233c24ea342..83cf8b5afb54 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -491,6 +491,11 @@ static void ext4_sb_release(struct kobject *kobj)
>  	complete(&sbi->s_kobj_unregister);
>  }
>  
> +static void ext4_kobject_release(struct kobject *kobj)
> +{
> +	kfree(kobj);
> +}
> +
>  static const struct sysfs_ops ext4_attr_ops = {
>  	.show	= ext4_attr_show,
>  	.store	= ext4_attr_store,
> @@ -505,7 +510,7 @@ static struct kobj_type ext4_sb_ktype = {
>  static struct kobj_type ext4_feat_ktype = {
>  	.default_groups = ext4_feat_groups,
>  	.sysfs_ops	= &ext4_attr_ops,
> -	.release	= (void (*)(struct kobject *))kfree,
> +	.release	= ext4_kobject_release,
>  };
>  
>  void ext4_notify_error_sysfs(struct ext4_sb_info *sbi)
> -- 
> 2.34.1
> 
