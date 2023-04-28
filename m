Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9AC6F12CD
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 09:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbjD1Hsx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 28 Apr 2023 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjD1Hsb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 03:48:31 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237F95BB7;
        Fri, 28 Apr 2023 00:46:59 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-b8f5121503eso14244255276.1;
        Fri, 28 Apr 2023 00:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667926; x=1685259926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdN7yUMsEb9SRRaPfrGFjLVhAZ7RTAGPL/BpXP1R+Wg=;
        b=gobP4zwSiLvFHz5wEXo6Oc7ucMuYcxiK8c55oY+0JkC7HDK3W+s52vbXlfdkfWhVYf
         JH9w87C9RX7Fc8Lpa28S0V/yxiIoLDirBfmnAemm6rA8KQPOTdHAstgAlGKcS6bA2BeV
         n7Z2vWZhY7YTFB3QyWPQRhMeJIRI7T+Cohp9kvPjWJVxGIchJJsJt+gtHESS065aqxrn
         uQf/rnAr8w8y1SKlVsbQLPXZ9T1jVT/M34kbRQbEAaw30rORT/Dkz1xawmlwtW/sSpRJ
         fSYrrW5PqNhPtUbPUZp6VprqrH4xefEtEOUMaYthSSS0AhtWoE846rhTA0UY1RF6QrF6
         eZMg==
X-Gm-Message-State: AC+VfDxbc9/RzYl3ZC4oZLfWzSilx4LVN/Qs5Z1zVwjb7mFs3iFaUz6q
        UZKiyBkD0fPalGiMkniuzxyH3NYIBdllnA==
X-Google-Smtp-Source: ACHHUZ7iYUVWcK+iwE0EM1fIY5DN22/DNz+1WmP39IZP3fjqSLYff4NQh91qtkYMsXangwJiKIXC3w==
X-Received: by 2002:a25:244e:0:b0:b96:1cea:3ba9 with SMTP id k75-20020a25244e000000b00b961cea3ba9mr3029351ybk.32.1682667926542;
        Fri, 28 Apr 2023 00:45:26 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id o3-20020a5b0643000000b00b8f13ff2a8esm4991881ybq.61.2023.04.28.00.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 00:45:26 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-54fc1824f0bso110096737b3.0;
        Fri, 28 Apr 2023 00:45:25 -0700 (PDT)
X-Received: by 2002:a0d:cbd3:0:b0:54f:df78:e1a2 with SMTP id
 n202-20020a0dcbd3000000b0054fdf78e1a2mr3208645ywd.34.1682667925383; Fri, 28
 Apr 2023 00:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
 <CAMuHMdU0V=b1FLiT4UbNVTa42+5hFx3WJQD6gETwNYioSaSoag@mail.gmail.com> <20230427182956.GA2970@dev-arch.thelio-3990X>
In-Reply-To: <20230427182956.GA2970@dev-arch.thelio-3990X>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Apr 2023 09:45:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmK=XOgLWqYH0r3WTFtw2ZETckV=v=9QNVSM49Xh9zjw@mail.gmail.com>
Message-ID: <CAMuHMdXmK=XOgLWqYH0r3WTFtw2ZETckV=v=9QNVSM49Xh9zjw@mail.gmail.com>
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

Hi Nathan,

On Thu, Apr 27, 2023 at 8:30 PM Nathan Chancellor <nathan@kernel.org> wrote:
> On Thu, Apr 27, 2023 at 02:36:10PM +0200, Geert Uytterhoeven wrote:
> > On Thu, Apr 20, 2023 at 6:56 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > When CONFIG_QUOTA is disabled, there are warnings around unused iterator
> > > variables:
> > >
> > >   fs/ext4/super.c: In function 'ext4_put_super':
> > >   fs/ext4/super.c:1262:13: error: unused variable 'i' [-Werror=unused-variable]
> > >    1262 |         int i, err;
> > >         |             ^
> > >   fs/ext4/super.c: In function '__ext4_fill_super':
> > >   fs/ext4/super.c:5200:22: error: unused variable 'i' [-Werror=unused-variable]
> > >    5200 |         unsigned int i;
> > >         |                      ^
> > >   cc1: all warnings being treated as errors
> > >
> > > The kernel has updated to gnu11, allowing the variables to be declared
> > > within the for loop. Do so to clear up the warnings.
> > >
> > > Fixes: dcbf87589d90 ("ext4: factor out ext4_flex_groups_free()")
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>

> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> >
> > > @@ -1311,7 +1311,7 @@ static void ext4_put_super(struct super_block *sb)
> > >         ext4_flex_groups_free(sbi);
> > >         ext4_percpu_param_destroy(sbi);
> > >  #ifdef CONFIG_QUOTA
> > > -       for (i = 0; i < EXT4_MAXQUOTAS; i++)
> > > +       for (int i = 0; i < EXT4_MAXQUOTAS; i++)
> >
> > int
> >
> > >                 kfree(get_qf_name(sb, sbi, i));
> > >  #endif
> > >
> >
> > > @@ -5628,7 +5627,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> > >  #endif
> > >
> > >  #ifdef CONFIG_QUOTA
> > > -       for (i = 0; i < EXT4_MAXQUOTAS; i++)
> > > +       for (unsigned int i = 0; i < EXT4_MAXQUOTAS; i++)
> >
> > unsigned int
> >
> > >                 kfree(get_qf_name(sb, sbi, i));
> > >  #endif
> > >         fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
> >
> > I do see an opportunity to make this more consistent.
> > get_qf_name() takes an int for the last parameter, but that should probably
> > become unsigned int?
>
> Yes, or I could have just changed the type of this variable to 'int', as
> Arnd did in his version; I just chose to keep the existing type so this
> was basically a "no functional change" patch.
>
> https://lore.kernel.org/20230421070815.2260326-1-arnd@kernel.org/
>
> I do not think it fundamentally matters, EXT4_MAXQUOTAS is defined as 3
> so I do not think unsigned versus signed semantics matter much here :) I
> can make that change in a v2 or separate change or we can just take
> Arnd's patch, but this is now in mainline and there is another patch
> trying to fix this warning so it would be good to get this dealt with
> sooner rather than later...
>
> https://lore.kernel.org/7ca8f790-c14e-6449-f3b5-4214d3fb1e61@googlemail.com/

I definitely don't want to delay fixing this, we already have too many
fixes (and the first ones arrived before the opening of the merge window).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
