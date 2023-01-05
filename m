Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23265F413
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jan 2023 20:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjAETEQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Jan 2023 14:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjAETEL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Jan 2023 14:04:11 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0D55F4A4
        for <linux-ext4@vger.kernel.org>; Thu,  5 Jan 2023 11:04:10 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id tz12so92210942ejc.9
        for <linux-ext4@vger.kernel.org>; Thu, 05 Jan 2023 11:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kDfzt8q4vMIPvH3hYtPbFGyOhTFs8fKmSul5DvtT0oY=;
        b=nnHCFC66h8enslZuyamV6H6V/N04fqP8nNG4fuvd0b/DmvY0k1no0IJyq9agykK78u
         /+1hq8Ieohc5J7o4oPzDLogJv2oreMTj3j4YTcgj/pIZEjeX7FGTM9VY98TTmD65TZi/
         XM91KS7jBkwVI3T8AThwJUTwaj4J4jYELsiCuZTtLRwPW0+DV8EBTrvuC8rny2Nu2DDt
         ns5PxeBCkepMXbk8OG6kjYCNbjg/jAbNS4gUKT9OAbacuJNh3mGIR9WgQaP5F1imKnhU
         X2eNzKDFwlLWWJvp5L9SIR+7686Q/Lco6Ok9Z3ncF5BEiE6ThAOyLRbQKXvMaRWnEs2u
         9BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDfzt8q4vMIPvH3hYtPbFGyOhTFs8fKmSul5DvtT0oY=;
        b=LNidKHdZYYv0HJZN5nY04m9+XrH+Ytf6BQr0y7nbTdtCTCZ9SIhtxNDjZAhdMtBN8a
         f0HKVJrDOuwu8RNgY0N3br2MAfkHExmvI51ipq6/yo+0hWaygQ94YQXhymnm34hyNzD1
         ACcJCXf6t8yhSMUi3ZGV3AAlNQX+eug9rnba0w8QPttqrfjmX6jm5ncj+1pGNV5vuP+x
         z+n/2oBi+iSBAjWtKKGbUDn3SbCMwkUS27P3CIu9P/BnVB3xC196svq7yM5D+XRNph7h
         EKp4rTb5sIKsSrRuY/VVixD5K1bVvpFh1+lTyW46G+UmsMORPvsZKja4TeH2qKFWRmEa
         JTXA==
X-Gm-Message-State: AFqh2koPyGwmgwODIIH7KAo0JRjbey6soZFhaUmshAzTx9mDYO+nc8id
        wNgagmDwbUAX7H2wF071xy2DToBXoprygx89+lqZy8Fi2aE=
X-Google-Smtp-Source: AMrXdXuMmBeG+izqzY9Y09KXeOeo0oCczMqSz0o02/MKWXGbe48vDrCeHY5LCDMRB6/KCsNMBlFuUVJyYJUN7Dzfujc=
X-Received: by 2002:a17:906:b084:b0:7c1:98e:b910 with SMTP id
 x4-20020a170906b08400b007c1098eb910mr3941883ejy.81.1672945449078; Thu, 05 Jan
 2023 11:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20230104090401.276188-1-ebiggers@kernel.org>
In-Reply-To: <20230104090401.276188-1-ebiggers@kernel.org>
From:   Jeremy Bongio <bongiojp@gmail.com>
Date:   Thu, 5 Jan 2023 11:03:57 -0800
Message-ID: <CANfQU3x3yB7OYPerwun3VTz89QJaFobdudj_8vCpwfNjjSRicQ@mail.gmail.com>
Subject: Re: [e2fsprogs PATCH] tune2fs: fix setting fsuuid::fsu_len
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for catching that!

Reviewed-by: Jeremy Bongio <bongiojp@gmail.com>

On Wed, Jan 4, 2023 at 1:04 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Minus does not mean equals.
>
> Besides fixing an obvious bug, this avoids the following compiler
> warning with clang -Wall:
>
> tune2fs.c:3625:20: warning: expression result unused [-Wunused-value]
>                         fsuuid->fsu_len - UUID_SIZE;
>                         ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~
>
> Fixes: a83e199da0ca ("tune2fs: Add support for get/set UUID ioctls.")
> Cc: Jeremy Bongio <bongiojp@gmail.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  misc/tune2fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 088f87e5..7937b8b5 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -3622,7 +3622,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
>                 ret = -1;
>  #ifdef __linux__
>                 if (fsuuid) {
> -                       fsuuid->fsu_len - UUID_SIZE;
> +                       fsuuid->fsu_len = UUID_SIZE;
>                         fsuuid->fsu_flags = 0;
>                         memcpy(&fsuuid->fsu_uuid, new_uuid, UUID_SIZE);
>                         ret = ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid);
> --
> 2.39.0
>
