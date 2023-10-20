Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3247D14D1
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Oct 2023 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjJTRYX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Oct 2023 13:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjJTRYW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Oct 2023 13:24:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C201DD73
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 10:24:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso2317499a12.1
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697822656; x=1698427456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdhkfPsGi9gy/YeBNgsDbPiV4gQ/kZVT9dE/yOFv4Jk=;
        b=dRV6fBr7qaM9ZRb+nSrwxEMoad+qE9kk1IWtQSGVH1vDatvVD8w1F0BFCYh65KOl82
         JHSDXQWRrrlu0qX5Y7EpcoLaTKUTKYMaUXuvteArPHrjKJ0L5tzia8vm54r3FEK+5VuC
         w/nk3quiypHUlJsSGchaTS/KOtKz9V9HwCNd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822656; x=1698427456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdhkfPsGi9gy/YeBNgsDbPiV4gQ/kZVT9dE/yOFv4Jk=;
        b=dH31QmFQrz29nFYYHsWQNSnvnPUE+TlTDceKr0wohilYptdgz6ZFFYRoT/YWZ/Ut5E
         +ClOPGIXW1DC505XKOvoCP/Y8p+IWopTIa9657FPJ+z2GTj25fbxgL24hPdcNrrZDe8Z
         vpFeuA0O2leDPyv2RaUCn/riTJvdNLq50OhxhjUKGJUBfuhEtNtvkucdgnPE4BZZAkC5
         AWtU/DBqsIwRBACv0WX5/wkE/Xzz81djgzDp1bpzUI1LKdmrqNe1QReKOcpqWb0rRU9Y
         TDve3jFN0tQ2CpMNyGMY2uIfdfI8EXTC3jjFvgFFHrCgqrVKHXaV1DxOXGPEaFjgH+Qy
         RGQA==
X-Gm-Message-State: AOJu0YxJy1HifNAjvpVxf9pGJJtzlD70mgGECaUTB2lnpqBRr35GStk5
        p+s5CzMm8VvUU1C3x1LfhaNqOn3u4aHOYkmJjIFpnqtq
X-Google-Smtp-Source: AGHT+IHEESXWZnsOzshfR3A7jYJzxIm2X85BNpwZ/3QH+vAVdfZTJikuyA1PjCtL0m8QRKsajmyX/A==
X-Received: by 2002:a50:ed0f:0:b0:530:8fdb:39c8 with SMTP id j15-20020a50ed0f000000b005308fdb39c8mr4836581eds.15.1697822656079;
        Fri, 20 Oct 2023 10:24:16 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id m9-20020aa7d349000000b0053dff5568acsm1789724edr.58.2023.10.20.10.24.15
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:24:15 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9becde9ea7bso468091866b.0
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 10:24:15 -0700 (PDT)
X-Received: by 2002:a17:906:7308:b0:9a2:295a:9bbc with SMTP id
 di8-20020a170906730800b009a2295a9bbcmr1923815ejc.37.1697822654738; Fri, 20
 Oct 2023 10:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231019101854.yb5gurasxgbdtui5@quack3> <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com> <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
In-Reply-To: <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Oct 2023 10:23:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
Message-ID: <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Baokun Li <libaokun1@huawei.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 20 Oct 2023 at 07:52, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> # first bad commit: [e64db1c50eb5d3be2187b56d32ec39e56b739845] quota: factor out dquot_write_dquot()

Ok, so commit 024128477809 ("quota: factor out dquot_write_dquot()") pre-rebase.

Which honestly seems entirely innocuous, and the only change seems to
be a slight massaging of the return value checking, in that it did a
"if (err)" ine one place before, now it does "if (err < 0)".

And the whole "now it always warns about errors", which used to happen
only in dqput() before.

Neither seems to be very relevant, which just reinforces that yes,
this looks like a timing thing.

> On top of the above I have tried the following:
> 1) dropping inline, replacing it to __always_inline -- no help;
> 2) commenting out the error message -- helps!
>
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -632,8 +632,10 @@ static inline int dquot_write_dquot(struct dquot *dquot)
>  {
>         int ret = dquot->dq_sb->dq_op->write_dquot(dquot);
>         if (ret < 0) {
> +#if 0
>                 quota_error(dquot->dq_sb, "Can't write quota structure "
>                             "(error %d). Quota may get out of sync!", ret);
> +#endif
>                 /* Clear dirty bit anyway to avoid infinite loop. */
>                 clear_dquot_dirty(dquot);
>         }

The only thing quota_error() does is the varags handling and a printk,
so yeah, all that #if 0" would do even if the error triggers (and it
presumably doesn't) is to change code generation around that point,
and change timing.

But what *is* interesting is that that commit that triggers it is
before all the other list-handling changes, so the fact that this was
triggered by that merge and that one commit, *all* that really
happened to trigger your boot failure is literally this:

   git log 1500e7e0726e^..024128477809

(that "1500e7e0726e^" is the pre-merge state). So it's not that the
problem was introduced by one of the other list-handling changes and
then 024128477809 just happened to change the timing. No, it's
literally that one commit that moves code around, and that one
quota_error() printout that makes the problem show for you.

So it really looks like the bug is pre-existing. Or actually a
compiler problem that is introduced by the added call that changes
code generation, but honestly, that is a very unlikely thing.

That said - while unlikely, mind just sending me the *failing* copy of
the fs/quota/dquot.o object file, and I'll take a look at the code
around that call. I've looked at enough code generation issues that
it's worth trying..

                 Linus
