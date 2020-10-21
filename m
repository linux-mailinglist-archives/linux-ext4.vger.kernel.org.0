Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11162954DD
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 00:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506826AbgJUWhL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 18:37:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33909 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387512AbgJUWhL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 18:37:11 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09LManT3021470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 18:36:50 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 46CA5420107; Wed, 21 Oct 2020 18:36:49 -0400 (EDT)
Date:   Wed, 21 Oct 2020 18:36:49 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead
 of selecting it
Message-ID: <20201021223649.GP181507@mit.edu>
References: <20201020073740.29081-1-geert@linux-m68k.org>
 <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
 <fa84c31f-218f-76be-87de-aa85c3c9b621@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa84c31f-218f-76be-87de-aa85c3c9b621@infradead.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 21, 2020 at 02:16:56PM -0700, Randy Dunlap wrote:
> On 10/21/20 2:15 PM, Brendan Higgins wrote:
> > On Tue, Oct 20, 2020 at 12:37 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >>
> >> EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
> >> user may not want to enable.  Fix this by making the test depend on
> >> EXT4_FS instead.
> >>
> >> Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > 
> > If I remember correctly, having EXT4_KUNIT_TESTS select EXT4_FS was
> > something that Ted specifically requested, but I don't have any strong
> > feelings on it either way.
> 
> omg, please No. depends on is the right fix here.

So my requirement which led to that particular request is to keep what
needs to be placed in .kunitconfig to a small and reasonable set.

Per Documentation/dev-tools/kunit, we start by:

    cd $PATH_TO_LINUX_REPO
    cp arch/um/configs/kunit_defconfig .kunitconfig

we're then supposed to add whatever Kunit tests we want to enable, to wit:

CONFIG_EXT4_KUNIT_TESTS=y

so that .kunitconfig would look like this:

CONFIG_KUNIT=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_EXT4_KUNIT_TESTS=y

... and then you should be able to run:

./tools/testing/kunit/kunit.py run

... and have the kunit tests run.  I would *not* like to have to put a
huge long list of CONFIG_* dependencies into the .kunitconfig file.

I'm don't particularly care how this gets achieved, but please think
about how to make it easy for a kernel developer to run a specific set
of subsystem unit tests.  (In fact, being able to do something like
"kunit.py run fs/ext4 fs/jbd2" or maybe "kunit.py run fs/..." would be
*great*.  No need to fuss with hand editing the .kunitconfig file at
all would be **wonderful**.

Cheers,

					- Ted

