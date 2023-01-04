Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA41F65CAB5
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 01:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjADAXs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Jan 2023 19:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjADAXr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Jan 2023 19:23:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630F7164B8;
        Tue,  3 Jan 2023 16:23:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF72961560;
        Wed,  4 Jan 2023 00:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310C8C433D2;
        Wed,  4 Jan 2023 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672791826;
        bh=Ub1O4ARA4Fg1QerVBHMPex3kBs1tuOPd9OUWy+AyaE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZwcaB7pDsRLazyUJiUCwgCbXeXHfPdPlBxzS9RGiCSHj9KgfXl7IbIbWALJzQfsQ
         XacyMUuuQrCcLhrYdplLErkyezbqno6aB4dGt9WzbC/zMfQbEjIH/jEhx0wCYhILHw
         842OZZRWeHYTnWl5/K7R7xf56w9baqfnSzZQsAQwcdfvoJ0i9b6lO7ET0WCYayim8f
         EWbh/u1kI/ghzkRHK+x970ganXbmY08478lfgqX5/6OZpuVLzqvGOdrXpsGoktvjN5
         yg0qacQjxBYYYzgnG4OXJ1qwQHYLHvlhB3osx9zyRGNN+JoawlYRvzHHIQHTH5MQnE
         ySiN15/1QoAoQ==
Date:   Wed, 4 Jan 2023 00:23:44 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix function prototype mismatch for ext4_feat_ktype
Message-ID: <Y7THENi5v2+fgUAc@gmail.com>
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

For consistency, maybe call this ext4_feat_release?  So ext4_sb_ktype would have
ext4_sb_release, and ext4_feat_ktype would have ext4_feat_release.

I'm also surprised that this wasn't found earlier.  Is it possible that CFI does
not actually distinguish between the two function prototypes here?

- Eric
