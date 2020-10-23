Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902AD297111
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 16:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750281AbgJWOIN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 10:08:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36609 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750250AbgJWOIN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 10:08:13 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09NE7ipV024993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 10:07:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9B7A2420107; Fri, 23 Oct 2020 10:07:44 -0400 (EDT)
Date:   Fri, 23 Oct 2020 10:07:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Brendan Higgins <brendanhiggins@google.com>
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
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead
 of selecting it
Message-ID: <20201023140744.GS181507@mit.edu>
References: <20201020073740.29081-1-geert@linux-m68k.org>
 <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
 <fa84c31f-218f-76be-87de-aa85c3c9b621@infradead.org>
 <20201021223649.GP181507@mit.edu>
 <CAFd5g44ymt3h6=_h3muHb9A6pPXaTnfhnixYrSny_sEUKGnzzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g44ymt3h6=_h3muHb9A6pPXaTnfhnixYrSny_sEUKGnzzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 22, 2020 at 04:52:52PM -0700, Brendan Higgins wrote:
> So you, me, Luis, David, and a whole bunch of other people have been
> thinking about this problem for a while. What if we just put
> kunitconfig fragments in directories along side the test files they
> enable?
> 
> For example, we could add a file to fs/ext4/kunitconfig which contains:
> 
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_KUNIT_TESTS=y
> 
> We could do something similar in fs/jdb2, etc.
> 
> Obviously some logically separate KUnit tests (different maintainers,
> different Kconfig symbols, etc) reside in the same directory, for
> these we could name the kunitconfig file something like
> lib/list-test.kunitconfig (not a great example because lists are
> always built into Linux), but you get the idea.
> 
> Then like Ted suggested, if you call kunit.py run foo/bar, then
> 
> if bar is a directory, then kunit.py will look for foo/bar/kunitconfig
> 
> if bar is a file ending with .kunitconfig like foo/bar.kunitconfig,
> then it will use that kunitconfig
> 
> if bar is '...' (foo/...) then kunit.py will look for all kunitconfigs
> underneath foo.
> 
> Once all the kunitconfigs have been resolved, they will be merged into
> the .kunitconfig. If they can be successfully merged together, the new
> .kunitconfig will then continue to function as it currently does.

I was thinking along a similar set of lines this morning.  One thing
I'd add in addition to your suggestion to that is to change how
.kunitconfig is interpreted such that

CONFIG_KUNIT=y

is always implied, so it doesn't have to be specified explicitly, and
that if a line like:

fs/ext4

or

mm

etc. occurs, that will cause a include of the Kunitconfig (I'd using a
capitalized version of the filename like Kconfig, so that it's easier
to see in a directory listing) in the named directory.

That way, .kunitconfig is backwards compatible, but it also allows
people to put a one-liner into .kunitconfig to enable the unit tests
for that particular directory.

What do folks think?

Cheers,

						- Ted
