Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781B13BA60A
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Jul 2021 00:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhGBWsZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jul 2021 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhGBWsY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jul 2021 18:48:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C1C061762
        for <linux-ext4@vger.kernel.org>; Fri,  2 Jul 2021 15:45:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w15so11199678pgk.13
        for <linux-ext4@vger.kernel.org>; Fri, 02 Jul 2021 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DHGJzaO2okYK4q0pTyQH6k3SJA9HXiRQm8Gztd2X1pQ=;
        b=T38grMs1AxOiINcstgg1ZMFrGyhr++JErmZenVtokcx+D9DFnTqCfqCaltFGrEvjqh
         1/vjDa5uQUF12yJ9PuA9fxR00Gsv3keEZflC6w4iciVEFdrnkSTzbMCxoHSJlWUvEso7
         e/wr89t4O99hAXRBJPymVZuRgA8fVlzdGMaPlDFEjNwzXfGMycVKxzHJpYxUAFLktk86
         +axQB57dSVaSJTl3vNg/1qhtRXgwYOdblpejsANoZAAyxz3Qrh4KlKyLZVfkS7J6Atca
         0FFfxBK+IRYoBWZJp+TlexWj03ALRImUMFLFehaqUfEQvruH/WG1KGcQMl/bN3fEt7wl
         RCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DHGJzaO2okYK4q0pTyQH6k3SJA9HXiRQm8Gztd2X1pQ=;
        b=LJ6rZuJET539GaAE9c71rMepEfEyMcvQzesgz6qL/G0mFT4H0pkrDmNzv0Kv5ZPnVE
         wwwawjnQcvHTVoZ4tPpWW6Zy3mZz7l2gx6oH09X5NNzyJefLJMQZM5ER1kWtyBkMGR0R
         ymkqp8CC6nVbvEYZs1oP3caifM35/xjbQiACRvew70WwIY+tSupfuAoWGiNgGMeBAq3w
         AO/+7NaEsyFPhjCOKy6bbP+2tZwHIldMsZLiWFOB4IWlnsEk3nPM/3zN/iRipyYT6qPn
         O4HtdlswYZbWX/JWE222DXrOavYAFpdhMg1GQHyp3x+I5VZLFzbC8rZixISyITFmnIdm
         hKsQ==
X-Gm-Message-State: AOAM530JHYRFq1ybnmH5UoZmBt5ENo/J6CCX1riFeGEPWtQGWWlwVV0O
        yjIIVmw8WHzc/oBbVR/U5Aw=
X-Google-Smtp-Source: ABdhPJwuxSX0J2+pcbjjAyx88c9N5vVcYmNrB+Q2zmEcEQ9LGrGDXvp8Jjwqa/8YmQrfLyedRRHmvw==
X-Received: by 2002:a62:b616:0:b029:303:aa7b:b2e0 with SMTP id j22-20020a62b6160000b0290303aa7bb2e0mr1948209pff.21.1625265949647;
        Fri, 02 Jul 2021 15:45:49 -0700 (PDT)
Received: from google.com ([2601:647:4701:18d0:6f31:f492:36f:743b])
        by smtp.gmail.com with ESMTPSA id u36sm4510640pfg.216.2021.07.02.15.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:45:49 -0700 (PDT)
Date:   Fri, 2 Jul 2021 15:45:46 -0700
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: fix flags validity checking for EXT4_IOC_CHECKPOINT
Message-ID: <YN+XGsHSnu+SerWU@google.com>
References: <20210702173425.1276158-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702173425.1276158-1-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 02, 2021 at 01:34:25PM -0400, Theodore Ts'o wrote:
> Use the correct bitmask when checking for any not-yet-supported flags.
> 
> Fixes: 351a0a3fbc35 ("ext4: add ioctl EXT4_IOC_CHECKPOINT")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  fs/ext4/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 5730aeca563c..6eed6170aded 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -823,7 +823,7 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
>  	if (!EXT4_SB(sb)->s_journal)
>  		return -ENODEV;
>  
> -	if (flags & ~JBD2_JOURNAL_FLUSH_VALID)
> +	if (flags & ~EXT4_IOC_CHECKPOINT_FLAG_VALID)
>  		return -EINVAL;
>  
>  	q = bdev_get_queue(EXT4_SB(sb)->s_journal->j_dev);
> -- 
> 2.31.0
> 

Thanks for the fix.

Reviewed-by: Leah Rumancik <leah.rumancik@gmail.com>

-Leah
