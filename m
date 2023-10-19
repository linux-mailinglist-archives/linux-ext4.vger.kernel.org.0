Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176487D0079
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjJSR0v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 13:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjJSR0u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 13:26:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657EC121
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 10:26:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9adb9fa7200so230176266b.0
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697736406; x=1698341206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TmTGqTn965x8Iqb+7zVicGdJQKijTkj69SBYkbhW+y4=;
        b=KUpVFCOjr+oWHEdOZjhesNgbajk6TmAZd1jP2/ObpbisALPwfMTT/NRB1XjrJQ0i/3
         CdVjF1Iqeq3IrpbZBFpDl2v+pmDycByBplN3zfL/qc/TrVUAe/fJTOWpvV2ewYm0BYH4
         4oUrGEO/3RRZp5qRgqrh6P0dHpGyqM/lce3hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736406; x=1698341206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmTGqTn965x8Iqb+7zVicGdJQKijTkj69SBYkbhW+y4=;
        b=G7csgofrELlVOPHmXcFCY27av/FSf3fKEJiwnuzt6Strv9yWBUfLPhFnQAIRjWG7qt
         GJLXNpjvC8nZitwer4lRq1DxCp7jKvV4oEVkK53ugHU1dnbfgmg7FuaJSrfQaHC7j3Y8
         IFYQoJvaueoS+MBOulNBLj0oS5TH3+rST4rVUOy0g2tjPOy61FKcFZPGfmMB8w3TU3+s
         gDRUBEqEWRGHLDSazyNjT3khjGtCRqU35rRuIW3gtHJxZoJhpfY2bvzEiff9JWpyxV1d
         7d2mHJ6z24OsINr8xIucmJigvp9wK+opdBr+BaonXAnfCHuINNwJhcIBJeMYacPQr3wg
         0/oQ==
X-Gm-Message-State: AOJu0YwHLeA4CDlE49XiUVqz8flA1F1c0Vkf+lbRMdEJJPGOYEQ9Joab
        PLfJK3Q4iSQR9QBO/qnSxD8W7cOXBQGXoHC62tzsEpyM
X-Google-Smtp-Source: AGHT+IHtI2GJHYNxsRw+RhaLiLXWpO79MnUqDB+lE3WPmVfhJoAk9ws4+uslTqGe417AodGTir1/7g==
X-Received: by 2002:a17:907:988:b0:9a2:295a:9bbc with SMTP id bf8-20020a170907098800b009a2295a9bbcmr1998866ejc.37.1697736406586;
        Thu, 19 Oct 2023 10:26:46 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id og22-20020a1709071dd600b0099290e2c163sm3810343ejc.204.2023.10.19.10.26.45
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 10:26:45 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9c3aec5f326so226776666b.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 10:26:45 -0700 (PDT)
X-Received: by 2002:a17:907:7f86:b0:9bd:a029:1a10 with SMTP id
 qk6-20020a1709077f8600b009bda0291a10mr2213396ejc.32.1697736405493; Thu, 19
 Oct 2023 10:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <ZS6fIkTVtIs-UhFI@smile.fi.intel.com> <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com> <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3> <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3> <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
In-Reply-To: <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 10:26:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
Message-ID: <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 19 Oct 2023 at 10:05, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Hmm... Then what's the difference between clang and GCC on the very same source
> code? One of them has a bug in my opinion.

Compiler bugs do happen, but they are quite rare (happily).

It's almost certainly just ambiguous code that happens to work with
one code generation, and not another.

It might be as simple as just hitting a timing bug, but considering
how consistent it is for you (with a particular config), it's more
likely to be something like an optimization that just happens to
trigger some subtle ordering requirement or other.

So then the "different compiler" is really just largely equivalent to
"different optimization options", and sometimes that causes problems.

That said, the quota dependency is quite odd, since normally I
wouldn't expect the quota code to really even trigger much during
boot. When it triggers that consistently, and that early during boot,
I would expect others to have reported more of this.

Strange.

                Linus
