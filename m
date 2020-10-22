Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ED02967BE
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 01:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373573AbgJVXxJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Oct 2020 19:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373561AbgJVXxF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Oct 2020 19:53:05 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B5BC0613CF
        for <linux-ext4@vger.kernel.org>; Thu, 22 Oct 2020 16:53:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t22so1810050plr.9
        for <linux-ext4@vger.kernel.org>; Thu, 22 Oct 2020 16:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aU9wHCu7G4+f6A1fcf7nrfjI4yO9Dnpm8noDBlvAP8=;
        b=ObTGTl0usd4KWyPHhbCtIUsxxD+52KyEVvUdadiEbvpogTrOQ1ugaMrE02b8gxFTHo
         7zulkYe+dvgKTeyNKSsTzzqpUoDOlI6HhaG6zZ9wXt9KkLmy+HHXYJKtbUdhI1umbf5E
         dBhq1/wBpKCco8poTethD0hxl8i9EOf7BQzGFuzKv9jcjxIOg+NAwedcp6f+Nagdv6Lp
         N53ZDhyhSUN9Mn57B0Za8aKhrfznC87vRYRt8pzfa2pXywLOoo6TmZe2Y0SoG+z+PRcT
         mfdQwnEOtX2So3/m6j1DSHlNgigx0GA6+zgSnCEJdKBxbidW9zYXA3i1IotIYu9FMhCp
         2bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7aU9wHCu7G4+f6A1fcf7nrfjI4yO9Dnpm8noDBlvAP8=;
        b=ISJqb/zUcskehn+Ouy0nXKI0bZCfNv7A/SEJrUyP+WG/FQbeAfe4DeKzwUBnk6V1j2
         2HhFlFQmqiBPNJBt2Ql8bNxXBZLNwxXx2+YYlNBOUoGQw51Wm/F8yEom8/FBBMqHB22l
         YE60T/Wt1dNh0Spt1D8ONHUQt61C/PrT8TklvwTqSxoIJwq4kF59YZ9wWkZa/EZIP9kQ
         Mskiqn0ykVst2Hp0y+zn7sy1fxZWs5b+vUhZFyaqBbiLUGMkPJA5fqmfW8OEjtwp0uuZ
         8uIbxVHm3rUeOGUjwfzgljSvfOksui01XmUnaJ+qSOPGoVVQvzbxboCqYyy6KPc/N7au
         eLLg==
X-Gm-Message-State: AOAM532u51gfrUmV5ZmDwZ38H4YLO6hFuXIJWKJmPKzvB7qXfc2httwG
        XmW2AFaCh9ZqYrs2meT4+rkI/DoOAfWsIqhARKTtlA==
X-Google-Smtp-Source: ABdhPJwQyZ4JQpQbwOCnSqrio2PiDC7Y8/MvjPDf019NOIatx0G7/TdIxKXBkTKlCOs8ORLbKWDAwaHI1lCsOIy8dnI=
X-Received: by 2002:a17:902:ba96:b029:d5:f36b:44af with SMTP id
 k22-20020a170902ba96b02900d5f36b44afmr4711316pls.51.1603410783671; Thu, 22
 Oct 2020 16:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201020073740.29081-1-geert@linux-m68k.org> <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
 <fa84c31f-218f-76be-87de-aa85c3c9b621@infradead.org> <20201021223649.GP181507@mit.edu>
In-Reply-To: <20201021223649.GP181507@mit.edu>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 22 Oct 2020 16:52:52 -0700
Message-ID: <CAFd5g44ymt3h6=_h3muHb9A6pPXaTnfhnixYrSny_sEUKGnzzQ@mail.gmail.com>
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of
 selecting it
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 21, 2020 at 3:36 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Oct 21, 2020 at 02:16:56PM -0700, Randy Dunlap wrote:
> > On 10/21/20 2:15 PM, Brendan Higgins wrote:
> > > On Tue, Oct 20, 2020 at 12:37 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > >>
> > >> EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
> > >> user may not want to enable.  Fix this by making the test depend on
> > >> EXT4_FS instead.
> > >>
> > >> Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
> > >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > >
> > > If I remember correctly, having EXT4_KUNIT_TESTS select EXT4_FS was
> > > something that Ted specifically requested, but I don't have any strong
> > > feelings on it either way.
> >
> > omg, please No. depends on is the right fix here.
>
> So my requirement which led to that particular request is to keep what
> needs to be placed in .kunitconfig to a small and reasonable set.
>
> Per Documentation/dev-tools/kunit, we start by:
>
>     cd $PATH_TO_LINUX_REPO
>     cp arch/um/configs/kunit_defconfig .kunitconfig
>
> we're then supposed to add whatever Kunit tests we want to enable, to wit:
>
> CONFIG_EXT4_KUNIT_TESTS=y
>
> so that .kunitconfig would look like this:
>
> CONFIG_KUNIT=y
> CONFIG_KUNIT_TEST=y
> CONFIG_KUNIT_EXAMPLE_TEST=y
> CONFIG_EXT4_KUNIT_TESTS=y
>
> ... and then you should be able to run:
>
> ./tools/testing/kunit/kunit.py run
>
> ... and have the kunit tests run.  I would *not* like to have to put a
> huge long list of CONFIG_* dependencies into the .kunitconfig file.
>
> I'm don't particularly care how this gets achieved, but please think
> about how to make it easy for a kernel developer to run a specific set
> of subsystem unit tests.  (In fact, being able to do something like
> "kunit.py run fs/ext4 fs/jbd2" or maybe "kunit.py run fs/..." would be
> *great*.  No need to fuss with hand editing the .kunitconfig file at
> all would be **wonderful**.

So you, me, Luis, David, and a whole bunch of other people have been
thinking about this problem for a while. What if we just put
kunitconfig fragments in directories along side the test files they
enable?

For example, we could add a file to fs/ext4/kunitconfig which contains:

CONFIG_EXT4_FS=y
CONFIG_EXT4_KUNIT_TESTS=y

We could do something similar in fs/jdb2, etc.

Obviously some logically separate KUnit tests (different maintainers,
different Kconfig symbols, etc) reside in the same directory, for
these we could name the kunitconfig file something like
lib/list-test.kunitconfig (not a great example because lists are
always built into Linux), but you get the idea.

Then like Ted suggested, if you call kunit.py run foo/bar, then

if bar is a directory, then kunit.py will look for foo/bar/kunitconfig

if bar is a file ending with .kunitconfig like foo/bar.kunitconfig,
then it will use that kunitconfig

if bar is '...' (foo/...) then kunit.py will look for all kunitconfigs
underneath foo.

Once all the kunitconfigs have been resolved, they will be merged into
the .kunitconfig. If they can be successfully merged together, the new
.kunitconfig will then continue to function as it currently does.

What do people think about this?
