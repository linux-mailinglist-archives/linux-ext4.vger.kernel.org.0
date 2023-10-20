Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B477D167A
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Oct 2023 21:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjJTToS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Oct 2023 15:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjJTToS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Oct 2023 15:44:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8DDD8
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 12:44:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c3c8adb27so181572966b.1
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697831055; x=1698435855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NnnjNkqgXxS0pckrv1oPel8s8uR9/bn0uOyrsj0uCGA=;
        b=alPPSER8Jb2LCXXrEsza92LYG7E6LRL6g930ClGmnEP8DJqoLHc68UjXV0cJPK5UFZ
         krj8zljdzac/fY0EJNhVlNfTuOU0CQigJYvVdMSNgv+Xra9YVDD6ruWPiAyBXIvp0L3Z
         ol2srF1cYOmr/Hbc4TX0kkK55HxsHvfeR8L9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697831055; x=1698435855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnnjNkqgXxS0pckrv1oPel8s8uR9/bn0uOyrsj0uCGA=;
        b=pti4DANWjCc69Er0JkVMcXfQWIq7/22dWQNLeHPzuKVuJUAXEPGmBS0izgyvHz0B4c
         GwpTjqAm5w70eOIXx0Z6Ut0kEDzHzlufu7ciJvxfSUHOan3JFhvZ/K4upCeXpwCLY12W
         ULLfh32SXDc4R5ClwcIRCBvXPxyYkoK3+n0bFh1FmFobjugOHfpiIr4MPua0WokEiZ64
         ViYLMYBe16laIE6+sURDwPthZD3pDGNKEhGZWZmhvgIWawHpI5XojyF4QIx4Y7BgVoH8
         Nrz7b/x2D58iAyeIrqKuB/PBvfbQjbdSCBKdrujlHMiTp6hehRXdp4zczSRK9ikzWADx
         Qk8A==
X-Gm-Message-State: AOJu0YzKKkNgZrL4MVBB3m9tzdeTGIbW2x+tt+zcSBtCknagwh97bq1L
        K+U2AmXEcplhPAzsEjc6+I1gLq9L+23+r+Z2eO/lrAYV
X-Google-Smtp-Source: AGHT+IHoAi7zP09wQTw+aH1v/omcfCCDW0avk8nEutJoXCMZiT+IUY/W35wmjXU/FSXTuEBbiZwAwA==
X-Received: by 2002:a17:907:31c1:b0:9a1:891b:6eed with SMTP id xf1-20020a17090731c100b009a1891b6eedmr1968278ejb.76.1697831054744;
        Fri, 20 Oct 2023 12:44:14 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id c25-20020a170906529900b009b947aacb4bsm2104668ejm.191.2023.10.20.12.44.14
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 12:44:14 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso183484266b.0
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 12:44:14 -0700 (PDT)
X-Received: by 2002:a17:907:2d08:b0:9bf:d65d:dc0f with SMTP id
 gs8-20020a1709072d0800b009bfd65ddc0fmr1770580ejc.4.1697831053735; Fri, 20 Oct
 2023 12:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com> <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
 <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
In-Reply-To: <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Oct 2023 12:43:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>
Message-ID: <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Baokun Li <libaokun1@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
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

On Fri, 20 Oct 2023 at 11:29, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> I'll reply to this with the attached object file, I assume it won't go to the
> mailing list, but should be available in your mailbox.

Honestly, both cases (that function gets inlined twice) look
*identical* from a quick look, apart from obviously the extra call to
__quota_error().

I might be missing something, but this most definitely is not a "gcc
ends up creating very different code when it doesn't need to
synchronize around the call" thing.

So a compiler issue looks very unlikely. No absolute guarantees - I
didn't do *that* kind of walk-through instruction by instruction - but
the results actually seem to line up perfectly.

Even register allocation didn't change, making the compare between #if
0 and without rather easy.

There's one extra spill/reload due to the call in the "non-#if0" case,
and that actually made me look twice (because it spilled %eax, and
then reloaded it as %rcx), but it turns that %eax/%ecx had the same
value at the time of the spill, so even that was not a "real"
difference.

So I will claim that no, it's not the compiler. It's some unrelated
subtle timing, or possibly just a random code layout issue (because
the code addresses do obviously change).

                    Linus
