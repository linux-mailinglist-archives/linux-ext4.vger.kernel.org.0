Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9556F05E8
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Apr 2023 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbjD0Mga convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 27 Apr 2023 08:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243688AbjD0Mg1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Apr 2023 08:36:27 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6594C0E;
        Thu, 27 Apr 2023 05:36:25 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-b9963a72fbfso8800571276.3;
        Thu, 27 Apr 2023 05:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598985; x=1685190985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GfYLDzqUDcm88RwTWgB+qyxg4iuuLuJ42jmjtTcG+g=;
        b=HKSIjV+NnMDL7T4u3p1+zIjoiw8GE7xdcF3kn5zYCkLxHSgsOzUr58r5/tQgBdEfxj
         HuFfRm9/HHqJe3RlNybtnigOBfiyYnNBITzbDWU0vOhPhjtvtHkQ8l/0b+ax0d9hbzYc
         P6KQphO9sIWttqa3SdXhvELofDsyX2ywjfQ72fSTEj/KBooV/NjiTvEG7sUvOGLyNO1t
         XGhmwt02RTiUF0QxfMFG9H677/iMBCZ6+e7BfUXqObEO3iBL1AHMJLeVUPSo7Sj/BG0i
         yvqCJT6WmgeosOwngGIdMFh1MLwkSfGM/V1cTxd+Pk2tOKCrkEZmFsQRpG5sJGDWyAvC
         j7uw==
X-Gm-Message-State: AC+VfDyVHVUcaOicEuStJaCt9eQ/tlLtDpGtd5H8ynIgB87ncDcLy6FZ
        /qGQDpGeHcY74vctiy9n8LfX7CvFhbZ30w==
X-Google-Smtp-Source: ACHHUZ4hIzd3twPacpqPWfBBzVeaQdN4BvBLV6ot6WcGzEhUb9DY/zumwU+rsRt5/hdF63EWTS7XDA==
X-Received: by 2002:a25:6d83:0:b0:b92:5d7b:2c15 with SMTP id i125-20020a256d83000000b00b925d7b2c15mr718020ybc.25.1682598984843;
        Thu, 27 Apr 2023 05:36:24 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id z188-20020a8165c5000000b00545a08184bbsm4732949ywb.75.2023.04.27.05.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 05:36:24 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-54f8e823e47so95971627b3.2;
        Thu, 27 Apr 2023 05:36:24 -0700 (PDT)
X-Received: by 2002:a0d:d44f:0:b0:54f:dafd:a369 with SMTP id
 w76-20020a0dd44f000000b0054fdafda369mr1011695ywd.51.1682598983950; Thu, 27
 Apr 2023 05:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
In-Reply-To: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Apr 2023 14:36:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0V=b1FLiT4UbNVTa42+5hFx3WJQD6gETwNYioSaSoag@mail.gmail.com>
Message-ID: <CAMuHMdU0V=b1FLiT4UbNVTa42+5hFx3WJQD6gETwNYioSaSoag@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix unused iterator variable warnings
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, yanaijie@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 20, 2023 at 6:56 PM Nathan Chancellor <nathan@kernel.org> wrote:
> When CONFIG_QUOTA is disabled, there are warnings around unused iterator
> variables:
>
>   fs/ext4/super.c: In function 'ext4_put_super':
>   fs/ext4/super.c:1262:13: error: unused variable 'i' [-Werror=unused-variable]
>    1262 |         int i, err;
>         |             ^
>   fs/ext4/super.c: In function '__ext4_fill_super':
>   fs/ext4/super.c:5200:22: error: unused variable 'i' [-Werror=unused-variable]
>    5200 |         unsigned int i;
>         |                      ^
>   cc1: all warnings being treated as errors
>
> The kernel has updated to gnu11, allowing the variables to be declared
> within the for loop. Do so to clear up the warnings.
>
> Fixes: dcbf87589d90 ("ext4: factor out ext4_flex_groups_free()")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c

> @@ -1311,7 +1311,7 @@ static void ext4_put_super(struct super_block *sb)
>         ext4_flex_groups_free(sbi);
>         ext4_percpu_param_destroy(sbi);
>  #ifdef CONFIG_QUOTA
> -       for (i = 0; i < EXT4_MAXQUOTAS; i++)
> +       for (int i = 0; i < EXT4_MAXQUOTAS; i++)

int

>                 kfree(get_qf_name(sb, sbi, i));
>  #endif
>

> @@ -5628,7 +5627,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  #endif
>
>  #ifdef CONFIG_QUOTA
> -       for (i = 0; i < EXT4_MAXQUOTAS; i++)
> +       for (unsigned int i = 0; i < EXT4_MAXQUOTAS; i++)

unsigned int

>                 kfree(get_qf_name(sb, sbi, i));
>  #endif
>         fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);

I do see an opportunity to make this more consistent.
get_qf_name() takes an int for the last parameter, but that should probably
become unsigned int?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
