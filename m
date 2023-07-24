Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8675FD04
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 19:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjGXRTP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXRTO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 13:19:14 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD53DE76
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 10:19:13 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63cf7cce5fbso13726766d6.0
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690219153; x=1690823953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHqlkjiN6F7mZHmC296PE6xQOoItN+fVKPLF3TUGTVI=;
        b=HFHY127KcwxOhKq5Bri1cro15FAkNa5SlM1FnQX3pl0u+VO3Bn11Vc+BLFKQsIh0qd
         4+3053sdoGd0VLrcSU+KtN0OCxZTjUqtSMCssDwasWUzfIoYX5+POQkWDxZt89M0kz96
         zIlQG61pCNSEKCeryktg+GDMoz9NSSszsiF2CptitKlAcDo+RlBOaSbyxGsETMFf0wLt
         qgzd9wtLBkB57uRY44bxZIabgouPeMWmBnOKge2XEc0potLBZTB7tXvdiO1T2+e+GZLy
         wBX1Mr3RKUi1mWgq8JyelZglpRXG7M2gtWKKlZ3o9x/qjhS4NRFAyo7niZCQalU1EwRC
         ch3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219153; x=1690823953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHqlkjiN6F7mZHmC296PE6xQOoItN+fVKPLF3TUGTVI=;
        b=f5boSmhQsyo0kc3DAtMLRI6fiH3MhcveD2aEPh3eKhRw7/TWF0C5gCHDs+KL4wuyJ5
         rhVA0bf11v+FQ1z7n2rKQgOqwKNNe9URhXusZ9ugRja9M6YZMITWHEv0LwGCwcBg2a4R
         C0dPGOG4gHaBrYpdJcoWRy8KfmXI4rd0ck6TYgmuiSw90A1AxIdd9SKMTKvNmq+nb8Zo
         MOC3QdU5uGRtFNrkMVKXhK92p5jK3xy0naiW4ppwUbfZC8nxbk2DcjIFGbLyF2TBUPjP
         zzr1E09xrqSML+GNP6+gKcBH+xadH0FX9Dw9NdovAUOcZLLzoJSxx3vzZ61HrTQUcq0n
         6k3A==
X-Gm-Message-State: ABy/qLZo1TlNJkRgCi6Y96NGWBfa9lmr9/9lTbT8dZ4pvy59YhH9XxGl
        HIgY6ScjSeIzewfGVM0TOelbru6gRLVKDZwf+Z121ULhKa/Reh4EV3o=
X-Google-Smtp-Source: APBJJlG0PzmZgMeYmmyxh6fQCtTCaFVli27ad8SwdfVceQNoqUOHJJbJZFe9iMSAnB6bk7i+ctom86Y91hMRQVsqDOs=
X-Received: by 2002:a0c:fe0d:0:b0:63c:a22e:ddaf with SMTP id
 x13-20020a0cfe0d000000b0063ca22eddafmr461068qvr.16.1690219152868; Mon, 24 Jul
 2023 10:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230724054538.163319-1-suhui@nfschina.com>
In-Reply-To: <20230724054538.163319-1-suhui@nfschina.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jul 2023 10:19:02 -0700
Message-ID: <CAKwvOdk-fdJr9TcgUnOhCiU0LvD2Qe_c+6YOe-c1k0Ukm+negA@mail.gmail.com>
Subject: Re: [PATCH] ext4: mballoc: avoid garbage value from err
To:     Su Hui <suhui@nfschina.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, nathan@kernel.org,
        trix@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jul 23, 2023 at 10:46=E2=80=AFPM Su Hui <suhui@nfschina.com> wrote:
>
> clang warning: fs/ext4/mballoc.c, line 4178, column 6
> Branch condition evaluates to a garbage value.

Specifically this is clang's static analysis; not the compiler itself.

>
> err is uninitialized and will be judged when it enters the
> loop first time and the condition "!ext4_sb_block_valid()"
> is true. Although this can't make problems now, it's better
> to correct it.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>

Hi Su,
Thanks for the patch!  I see what the warning is getting at;

If `len <=3D 0` then `err` is never initialized, then is used at line
4178 (that is UB).

Would you mind sending a v2 with the commit message updated to reflect
the above points?  I'd be happy to sign-off on that.

> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 21b903fe546e..769000c970b0 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4084,7 +4084,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_f=
sblk_t block,
>         struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>         ext4_group_t group;
>         ext4_grpblk_t blkoff;
> -       int i, err;
> +       int i, err =3D 0;
>         int already;
>         unsigned int clen, clen_changed, thisgrp_len;
>
> --
> 2.30.2
>
>


--=20
Thanks,
~Nick Desaulniers
