Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338D33D22D2
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jul 2021 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhGVKzM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Jul 2021 06:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhGVKzM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Jul 2021 06:55:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704C6C061575
        for <linux-ext4@vger.kernel.org>; Thu, 22 Jul 2021 04:35:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n1so5552281wri.10
        for <linux-ext4@vger.kernel.org>; Thu, 22 Jul 2021 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qlzkM3F5fvit9VhnlC77Sop/s7euLd9Um8Su21feghE=;
        b=U0vbvrxL0htJ+vraY35fcWe6WD1WXfJ7atdJ0FdoTh6FGRbVyu0IXKroO1gNEW8UfL
         3RYvuAhFYISejYoe9aOImfwyp9uGMS5vp9vO7VzbGa1BJBssHBVeGM3NiS5LTgNjTi8c
         Kw1kJUXL3NVhilHPDbIquwt0e3vjkpRZqpv+naxKV/S9s9IeBsSZ8InxIBpr1NgLIM6n
         Av9dCoM06ACNzh4/JfyNLXEswn/DIrSsmAaAXpKzHKLxUEali6bZtt9DvAaK0Vs4Ewre
         1AiK2R5p5L+mC2KgAEtwwmcwrVjAXu5TCbbHqB25j2jyHErf+NPMz/X5pqqzQPJjO/+S
         B0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qlzkM3F5fvit9VhnlC77Sop/s7euLd9Um8Su21feghE=;
        b=LKE1c5KgJCdBFUjRqxTC71Wii9PLnOXSGvAknBH15S9CeY3iJ1apzf8eIHCpni+gAN
         nX1Fbg5irjyY8xzZnoA93E1Fqd1LTKy49IPczFbNuqMKQZRcpnEM/NKMFitQFPalUCbE
         yzhLUkspynPy1xbggsrWloauLmsbgjUTmVG1Tk2IzsJFvquPFR5m/o4K5RgowYTa/OKz
         IwLvF2RcHUgAu59M+VtqmFS9rpA9AgCiU5pjOuUIgEJ169uWH64svZ5OQKoIuh6lIcs7
         2iJAJyeN9nv2XWmhM9zCYJj/XyvALWX9pAhKkFDe8Jk8s/ICrMvYZwVp12aSm7RGtc5Y
         aGEg==
X-Gm-Message-State: AOAM532q39OlIKRPqZ5tJVHq6+eZpurH/hNMa/O80Vt3Fc6XnJ313age
        eYkaNYlKrvKZUy4pMzqdg8RvRw==
X-Google-Smtp-Source: ABdhPJwNQdVmn8wmJMdhELUyS6EUU70oGebBvmvEO/uGWjWpu+I+sCJNxBYjaJWZOlMmi+o7MnqDEQ==
X-Received: by 2002:a05:6000:231:: with SMTP id l17mr49006652wrz.40.1626953745983;
        Thu, 22 Jul 2021 04:35:45 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id j4sm15884491wrt.24.2021.07.22.04.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 04:35:45 -0700 (PDT)
Date:   Thu, 22 Jul 2021 12:35:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Remy Card <card@masi.ibp.fr>,
        "David S. Miller" <davem@caip.rutgers.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] fs: ext4: namei: trivial: Fix a couple of small
 whitespace issues
Message-ID: <YPlYD1BXyjIgh++K@google.com>
References: <20210520125558.3476318-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520125558.3476318-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 20 May 2021, Lee Jones wrote:

> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Remy Card <card@masi.ibp.fr>
> Cc: "David S. Miller" <davem@caip.rutgers.edu>
> Cc: linux-ext4@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  fs/ext4/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Any news on this please?

Would you like me to submit a [RESEND]?

> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index afb9d05a99bae..7e780cf311c5a 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1899,7 +1899,7 @@ static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
>   * Returns pointer to de in block into which the new entry will be inserted.
>   */
>  static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
> -			struct buffer_head **bh,struct dx_frame *frame,
> +			struct buffer_head **bh, struct dx_frame *frame,
>  			struct dx_hash_info *hinfo)
>  {
>  	unsigned blocksize = dir->i_sb->s_blocksize;
> @@ -2246,7 +2246,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
>  	if (retval)
>  		goto out_frames;
>  
> -	de = do_split(handle,dir, &bh2, frame, &fname->hinfo);
> +	de = do_split(handle, dir, &bh2, frame, &fname->hinfo);
>  	if (IS_ERR(de)) {
>  		retval = PTR_ERR(de);
>  		goto out_frames;

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
