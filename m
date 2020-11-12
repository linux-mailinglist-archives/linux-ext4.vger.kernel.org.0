Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574A12AFE67
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Nov 2020 06:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgKLFh6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Nov 2020 00:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgKLClA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Nov 2020 21:41:00 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25529C0617A6
        for <linux-ext4@vger.kernel.org>; Wed, 11 Nov 2020 18:41:00 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id e21so2875275pgr.11
        for <linux-ext4@vger.kernel.org>; Wed, 11 Nov 2020 18:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TPVBYTjJe0hHmPnczFzGKQ6IA34dXAh8mCwAyisyNuc=;
        b=HsIKmy2mHTXPwQWLxT4t4wMTLWDqRF5L0W6i0qLwHTLP0BTicyOwRlVS/u3RGVkS3C
         RJu4DtUK8Lh1VeQ0Fs8R5cbJEOb/KIkknyTWSIlbVMHhwEeu7GDekDQ/SV18yfChQ43u
         f5vBpgZwYvIZXfftSHO6UNWQ2nO1I3Cblgwuwic4geXh3UcAEcVGpwC88AbQgivqgoih
         5Qk4grVFGf2rvo2ZlDamtz3W2G2rSwLcQNC+AHJ4Ef7IfjYB5tNvaoZKN+2kjzfT9PFn
         e5JMHTGUxFXQH+qS5+PJ/EIdj0wMijhOFFGs6yDsANBc0YNo66B2zmJuqpMIiwdoAcWL
         a3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TPVBYTjJe0hHmPnczFzGKQ6IA34dXAh8mCwAyisyNuc=;
        b=nJWY0tbjlkjWfnS94hRf1r2KE3zxlTthK3zxF2Rg2nOuYx1+IjOb5qnP5ixKczcczE
         9qsyLgTgiwljsMz2lJDf7pnVowq4YVYEmMjVUMHHXyIO8uI7c7RiIUo3uQ82JZ4TZE3g
         oDco9J8hB4M/XLDdgq2WUuT84Xet0UiG8+p5Q0/FrGPJoGAXcEuVfyotlGH9PP8jwbsB
         wks6iBoes+dKSYuE7bn4lH1wFNSWQpbJ0QIC9oXs4VdHWiWbJ9U00KPoXLs+U1zozXmH
         kEukKGB+H8NyYUjy0bWXtKgHhV6MuXrhTL4eY1pDjO2QWOP5s5fFKb7n3pDXjy4DNRIj
         /kTg==
X-Gm-Message-State: AOAM531bzgYn2omTOKej9YBQwJSAEqa6k1wBkkMRsvjd4dnSnQnWmrEn
        gmnncO0lrrFNAOvojeiXOcEUrGtPzt3IEA==
X-Google-Smtp-Source: ABdhPJxyWqEnhtC2yWsqGmtNX7PfX0PEmHE0bU42jkynWKfam4h3j/TgIeVQcJC3A4TtJNl389fptg==
X-Received: by 2002:a62:2cc1:0:b029:18c:85f5:864b with SMTP id s184-20020a622cc10000b029018c85f5864bmr502272pfs.29.1605148859471;
        Wed, 11 Nov 2020 18:40:59 -0800 (PST)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id p4sm3814925pjo.6.2020.11.11.18.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 18:40:58 -0800 (PST)
Date:   Thu, 12 Nov 2020 02:40:54 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fscrypt: fix inline encryption not used on new files
Message-ID: <20201112024054.GA4042272@google.com>
References: <20201111015224.303073-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111015224.303073-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 10, 2020 at 05:52:24PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The new helper function fscrypt_prepare_new_inode() runs before
> S_ENCRYPTED has been set on the new inode.  This accidentally made
> fscrypt_select_encryption_impl() never enable inline encryption on newly
> created files, due to its use of fscrypt_needs_contents_encryption()
> which only returns true when S_ENCRYPTED is set.
> 
> Fix this by using S_ISREG() directly instead of
> fscrypt_needs_contents_encryption(), analogous to what
> select_encryption_mode() does.
> 
> I didn't notice this earlier because by design, the user-visible
> behavior is the same (other than performance, potentially) regardless of
> whether inline encryption is used or not.
> 
> Fixes: a992b20cd4ee ("fscrypt: add fscrypt_prepare_new_inode() and fscrypt_set_context()")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/crypto/inline_crypt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index 89bffa82ed74a..c57bebfa48fea 100644
> --- a/fs/crypto/inline_crypt.c
> +++ b/fs/crypto/inline_crypt.c
> @@ -74,7 +74,7 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
>  	int i;
>  
>  	/* The file must need contents encryption, not filenames encryption */
> -	if (!fscrypt_needs_contents_encryption(inode))
> +	if (!S_ISREG(inode->i_mode))
>  		return 0;
>  
>  	/* The crypto mode must have a blk-crypto counterpart */
> 
> base-commit: 92cfcd030e4b1de11a6b1edb0840e55c26332d31
> -- 
> 2.29.2
> 
Looks good to me. Please feel free to add
Reviewed-by: Satya Tangirala <satyat@google.com>
