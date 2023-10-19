Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132647D01FB
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 20:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjJSSoK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjJSSoK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 14:44:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B89126
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 11:44:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so4428966b.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697741046; x=1698345846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C2XVpy+BS1K4w7gayf3/1HjO0gNsFZkxXqHhB++XT2g=;
        b=KZA0xFi8n22uIkwv4S5EA2cN2KsfIlrTz4BfkjjFrkyAiekcqqu4jfYYmCxRWfyF/2
         y7zbfhRjNH/yet3T94VYBJa7HHwGv//bzk1oIgd6LFn9fZCL55jhGs3rtm0ItWLrwxMr
         g9ELMpJD3KeMi3v6FMsfadcYERZUidjX/uytM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697741046; x=1698345846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2XVpy+BS1K4w7gayf3/1HjO0gNsFZkxXqHhB++XT2g=;
        b=Lu+iP5dTSh2YUK0cPqwmyQXlDLeJewnqTPmPzMkWtOcKhDQCvT7vCm+WLu2htgOClI
         0xYAhBovPVYpjp+cE9UpG7q17k7TwZCxk+uXggziKfpCjjWeQ9DE8YEz9N3vyMsjc/Yz
         SxIm+Qjdvyh4ubylLdEobPcf5Wq+tbg+madRVWjzVB0F2iTAo5OJb0PzmzZFgf4khvoi
         3KWOEwbBw8nWdaDOemjG0FURPgQYl9lOYBL75g+b5CMchFJrUAvtne76LLlVPDH4yt3y
         PMauRXl9tw0Dyce5rtYFSCohaM8zGLabW5qCSexYKKwcdrjee//koOQH/mWByFsB5j4W
         s3KA==
X-Gm-Message-State: AOJu0YxmE+ejzn04G38qljnzeU6KGQMfBeRYu4E5tg1VbZpQpIBJeO3h
        D5mcht13/FyWKTTPjGqTql+KgUZ0KtfZ3bKElyLojG0J
X-Google-Smtp-Source: AGHT+IHnF58OnuBa+IYERKlQ/xcVIjdJTHm/PSyfT+93CHoXbEgcDlJycJD1i6bgTgZ7+3zJnift6Q==
X-Received: by 2002:a17:906:dacb:b0:9ae:614f:2023 with SMTP id xi11-20020a170906dacb00b009ae614f2023mr2428318ejb.56.1697741046215;
        Thu, 19 Oct 2023 11:44:06 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id qx17-20020a170906fcd100b00997c1d125fasm21100ejb.170.2023.10.19.11.44.05
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 11:44:05 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so4424866b.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 11:44:05 -0700 (PDT)
X-Received: by 2002:a17:907:72c9:b0:9a5:9f3c:9615 with SMTP id
 du9-20020a17090772c900b009a59f3c9615mr2626024ejc.63.1697741044936; Thu, 19
 Oct 2023 11:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231018184613.tphd3grenbxwgy2v@quack3> <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3> <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
In-Reply-To: <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 11:43:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
Message-ID: <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 19 Oct 2023 at 11:16, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Meanwhile a wild idea, can it be some git (automatic) conflict resolution that
> makes that merge affect another (not related to the main contents of the merge)
> files? Like upstream has one base, the merge has another which is older/newer
> in the history?

I already looked at any obvious case of that.

The only quota-related issue on the other side is an obvious
one-liner: commit 86be6b8bd834 ("quota: Check presence of quota
operation structures instead of ->quota_read and ->quota_write
callbacks").

It didn't affect the merge, because it was not related to  any of the
changes that came in from the quota branch (it was physically close to
the change that used lockdep_assert_held_write() instead of a
WARN_ON_ONCE(down_read_trylock()) sequence, but it is unrelated to
it).

I guess you could try reverting that one-liner after the merge, but I
_really_ don't think it is at all relevant.

What *would* probably be interesting is to start at the pre-merge
state, and rebase the code that got merged in. And then bisect *that*
series.

IOW, with the merge that triggers your bisection being commit
1500e7e0726e, do perhaps something like this:

  # Name the states before the merge
  git branch pre-merge 1500e7e0726e^
  git branch jan-state 1500e7e0726e^2

  # Now double-check that this works for you, of course.
  # Just to be safe...
  git checkout pre-merge
  .. test-build and test-boot this with the bad config ..

  # Then, let's create a new branch that is
  # the rebased version of Jan's state:
  git checkout -b jan-rebased jan-state
  git rebase pre-merge

  # Verify that the tree is the same as the merge
  git diff 1500e7e0726e

  # Ok, that was empty, so do a bisect on this
  # rebased history
  git bisect start
  git bisect bad
  git bisect good pre-merge

.. and see what commit it *now* claims is the bad commit.

Would you be willing to do this? It should be only a few bisects,
since Jan's branch only brought in 17 commits that the above rebases
into this test branch. So four or five bisections should pinpoint the
exact point where it goes bad.

Of course, since this is apparently about some "random code generation
issue", that exact point still may not be very interesting.

                Linus
