Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989F7D00F7
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 19:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjJSRvl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjJSRvk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 13:51:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A757114
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 10:51:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad8a822508so1351014666b.0
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697737897; x=1698342697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxyRz0yQqVJRY3zmZ6nwicjRS4ksR0Rz7BgzZVO3P6w=;
        b=QsZMDPwaK9757OCMA6CxKXTGBXJ0OpZ++/Eawo173gLhGaLZKF2GFLvh2OZfkzX/nd
         RkgNjIEo5BTaFVETMjVcvZZhOjbmTiGshre5AC/cyvGrtm5Dtuo0nK/5NoJPVfGVLI6D
         Qo/fC085fMKpBO4zSVWVcXYOvvHLMnVK88coA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737897; x=1698342697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxyRz0yQqVJRY3zmZ6nwicjRS4ksR0Rz7BgzZVO3P6w=;
        b=YeK+O7JmOUMaaxidwuPO5Bzzbpn+3JMxBq4EL2IqPQrOEy75Zg7pTtuyaLFASHT5aG
         K5sTDO60PKQBn7kFBOIG8b6tAj88nQMYNQgmgUaYq7I8c2VZO55u5iL/R57Ll8zj5N5X
         ZM7N+ukRIQA5efsGYFShuLD/Fa/Q+hgIL6ULssot7r3p2KYEue0vtn6mk3nWQX+Fy9bg
         7TXjX8oPHLoH20rwMhZlPl+lE/6UlzmPqMhpLXQ+1pO/+EQE9Mn1kj8+pDN8gYXkJ0lh
         UGATZVywDy424jjyzB36m8DT4S946pwO8RDT7GaFh1V3X8e7oVDVZbBjTb3yAETaq1QA
         3Y8Q==
X-Gm-Message-State: AOJu0Yyb0Yc5961ekG55l8c5S3xj14PF/c8pkFHnK+BczlylNmlMky0m
        C4tQTyNZOp6gsRLkKXxtGhV6H6g8H4WAtQgbGvP+xVm0
X-Google-Smtp-Source: AGHT+IH7Wmx1Iw0yOj6XCgGQidjk0fpu3WoAlFcBx9k9zfRqDWRB07DqEBVwEMXgiYgXXWzHZl3mKQ==
X-Received: by 2002:a17:907:7f29:b0:9bd:ac0f:83dc with SMTP id qf41-20020a1709077f2900b009bdac0f83dcmr2697437ejc.54.1697737897312;
        Thu, 19 Oct 2023 10:51:37 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906075700b009b947f81c4asm3929159ejb.155.2023.10.19.10.51.36
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 10:51:36 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9ad8a822508so1351011766b.0
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 10:51:36 -0700 (PDT)
X-Received: by 2002:a17:907:31c5:b0:9be:ef46:6b9c with SMTP id
 xf5-20020a17090731c500b009beef466b9cmr2784575ejb.70.1697737896286; Thu, 19
 Oct 2023 10:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZS6fIkTVtIs-UhFI@smile.fi.intel.com> <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com> <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3> <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3> <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
In-Reply-To: <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 10:51:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
Message-ID: <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
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

On Thu, 19 Oct 2023 at 10:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, the quota dependency is quite odd, since normally I
> wouldn't expect the quota code to really even trigger much during
> boot. When it triggers that consistently, and that early during boot,
> I would expect others to have reported more of this.
>
> Strange.

Hmm. I do think the quota list handling has some odd things going on.
And it did change with the whole ->dq_free thing.

Some of it is just bad:

  #ifdef CONFIG_QUOTA_DEBUG
          /* sanity check */
          BUG_ON(!list_empty(&dquot->dq_free));
  #endif

is done under a spinlock, and if it ever triggers, the machine is
dead. Dammit, I *hate* how people use BUG_ON() for assertions. It's a
disgrace. That should be a WARN_ON_ONCE().

And it does have quite a bit of list-related changes, with the whole
series from Baokun Li changing how the ->dq_free list works.

The fact that it consistently bisects to the merge is still odd.

                 Linus
