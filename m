Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8452958F8
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 09:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508400AbgJVHVL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Oct 2020 03:21:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41814 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506202AbgJVHVL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Oct 2020 03:21:11 -0400
Received: by mail-oi1-f195.google.com with SMTP id q136so726083oic.8;
        Thu, 22 Oct 2020 00:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/52oDG9QeL4C2Vex7JQFOahpk7n/lU/SANjLOmaHdQg=;
        b=lkYlnfnz+FuiUt0xzy85qzySBW66Y3NKMOeffAQp3AQW1cdXpLe0TuuaIaHNBZw79o
         A0It/AnIOit1DUx3Sn6As+DQasoMCE7swf3CSICi/c/ZUlMqSPQSkXne00iWEvjUWmZ6
         eH2Dd1XJ7ntdnGwijqedntNVKhse08r9ed1gCyVW2drERmoC10/IM3E/UkZyjLQ3ARDT
         G3LsKe2qAXZDugh7LhabC82G8WQy0MKeyGMw+wvvDsuohF7ZeO1uLpAkAFED7GqgV7/d
         W6Ws2u/aBYj0nqEvcsPMd+GVEh7rvlj3SfzL6wyg4igKDJCkd26Z2iGk2yYRMl54jNwh
         wj1g==
X-Gm-Message-State: AOAM5334orXiH/9GhtOfRqKCPPFqkG4+zM1qFVYFZZFEFDg1zod3FprI
        P+PFj87mMt2b7tLe4F7e7TIgRlzaus42gWmS8JE=
X-Google-Smtp-Source: ABdhPJzV+AwHffHagpsRwFah+uC67Zw1o6BP2luFWfYcxXO4sECKRbSAMN78l4/A/WO8flXhjlxDSJFdngj0mRGrNkE=
X-Received: by 2002:a05:6808:8f5:: with SMTP id d21mr589989oic.153.1603351270141;
 Thu, 22 Oct 2020 00:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201020073740.29081-1-geert@linux-m68k.org> <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
 <fa84c31f-218f-76be-87de-aa85c3c9b621@infradead.org> <20201021223649.GP181507@mit.edu>
 <b51d57fd-061a-26f3-5ecc-8efecbc95a49@infradead.org> <20201022034343.GQ181507@mit.edu>
In-Reply-To: <20201022034343.GQ181507@mit.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Oct 2020 09:20:58 +0200
Message-ID: <CAMuHMdXxM-AM_zYGuPo0Ti2wQOK-2FEr4jrQ7KXHUxK8aGre+Q@mail.gmail.com>
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of
 selecting it
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Thu, Oct 22, 2020 at 5:43 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Wed, Oct 21, 2020 at 04:07:15PM -0700, Randy Dunlap wrote:
> > > I'm don't particularly care how this gets achieved, but please think
> > > about how to make it easy for a kernel developer to run a specific set
> > > of subsystem unit tests.  (In fact, being able to do something like
> > > "kunit.py run fs/ext4 fs/jbd2" or maybe "kunit.py run fs/..." would be
> > > *great*.  No need to fuss with hand editing the .kunitconfig file at
> > > all would be **wonderful**.
> >
> > I understand the wish for ease of use, but this is still the tail
> > wagging the dog.
> >
> > The primary documentation for 'select' is
> > Documentation/kbuild/kconfig-language.rst, which says:
> >
> >   Note:
> >       select should be used with care. select will force
> >       a symbol to a value without visiting the dependencies.
> >       By abusing select you are able to select a symbol FOO even
> >       if FOO depends on BAR that is not set.
> >       In general use select only for non-visible symbols
> >       (no prompts anywhere) and for symbols with no dependencies.
> >       That will limit the usefulness but on the other hand avoid
> >       the illegal configurations all over.
> >
>
> Well, the KUNIT configs are kinda of a special case, since normally

Please read "Why my CONFIG symbol is (not) special?"...

> they don't have a lot of huge number of dependencies, since unit tests

They still depend on the feature under test, which may not be enabled.

> in general are not integration tests.  So ideally, dependencies will
> mostly be replaced with mocking functions.  And if there are *real*
> dependencies that the Kunit Unit tests need, they can be explicitly
> pulled in with selects.

While I'm a strong supporter of testing, this select is what I object
to, as it forces the enablement of features that were not enabled in
your kernel in the first place.

> That being said, as I said, I'm not picky about *how* this gets
> achieved.  But ease of use is a key part of making people more likely
> to run the unit tests.  So another way of solving the problem might be
> to put some kind of automated dependency solver into kunit.py, or some
> way of manually adding the necessary dependencies in some kind of
> Kunitconfig file that are in directories where their are Unit tests,
> or maybe some kind of extenstion to the Kconfig file.  My main
> requirement is that the only thing that should be necessary for
> enabling the ext4 Kunit tests should be adding a single line to the
> .kunitconfig file.  It's not fair to make the human developer manually
> have to figure out the dependency chains.

If you want to test e.g. EXT4, sure you know you should enable EXT4?
If you don't enable feature FOO in your kernel. why would you be
interested in testing feature FOO? Unless you want to test everything,
and you might as well run an allmodconfig kernel.

> As far as I'm concerned, ease of use is important enough to justfy
> special casing and/or bending the rules as far as "select" is concered
> for Kunit-related CONFIG items.  But if someone else want to suggest a
> better approach, I'm all ears.

Providing .config snippets containing both the CONFIG_FOO_KUNIT_TESTS
and CONFIG_FOO symbols set (and other dependencies, if needed) could
provide this, and would also be useful in documenting CONFIG_FOO has a
corresponding tests.

As kunit can be modular, and most tests can be modular too, I can build
all tests relevant for my system as modules.  Hence they are available
when the need to run them ever arises, while there is no further impact
on my system. This use case also seems to be supported by
CONFIG_KUNIT_ALL_TESTS:

    config KUNIT_ALL_TESTS
            tristate "All KUnit tests with satisfied dependencies"
            help
              Enables all KUnit tests, if they can be enabled.

However, this no longer works if this suddenly starts enabling random
features in my kernel, which was the case for EXT4_KUNIT_TESTS
and MPTCP_KUNIT_TESTS (enables MPTCP, and IPV6!).

While ext4 is ubiquitous (I did have it enabled ;-) and may be
considered common on all systems (it is not: e.g. embedded systems with
JFFS do not need EXT4 enabled), this is surely not the case for other
features with tests, and won't be the case for all features that will
receive kunit tests in the future.

Thanks for your understanding!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
