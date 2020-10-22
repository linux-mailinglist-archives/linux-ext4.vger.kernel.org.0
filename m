Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCAE2956EB
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 05:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443605AbgJVDoA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 23:44:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49335 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2443118AbgJVDn7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 23:43:59 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09M3hhpx012820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 23:43:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2C055420107; Wed, 21 Oct 2020 23:43:43 -0400 (EDT)
Date:   Wed, 21 Oct 2020 23:43:43 -0400
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
Message-ID: <20201022034343.GQ181507@mit.edu>
References: <20201020073740.29081-1-geert@linux-m68k.org>
 <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
 <fa84c31f-218f-76be-87de-aa85c3c9b621@infradead.org>
 <20201021223649.GP181507@mit.edu>
 <b51d57fd-061a-26f3-5ecc-8efecbc95a49@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51d57fd-061a-26f3-5ecc-8efecbc95a49@infradead.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 21, 2020 at 04:07:15PM -0700, Randy Dunlap wrote:
> > I'm don't particularly care how this gets achieved, but please think
> > about how to make it easy for a kernel developer to run a specific set
> > of subsystem unit tests.  (In fact, being able to do something like
> > "kunit.py run fs/ext4 fs/jbd2" or maybe "kunit.py run fs/..." would be
> > *great*.  No need to fuss with hand editing the .kunitconfig file at
> > all would be **wonderful**.
> 
> I understand the wish for ease of use, but this is still the tail
> wagging the dog.
> 
> The primary documentation for 'select' is
> Documentation/kbuild/kconfig-language.rst, which says:
> 
>   Note:
> 	select should be used with care. select will force
> 	a symbol to a value without visiting the dependencies.
> 	By abusing select you are able to select a symbol FOO even
> 	if FOO depends on BAR that is not set.
> 	In general use select only for non-visible symbols
> 	(no prompts anywhere) and for symbols with no dependencies.
> 	That will limit the usefulness but on the other hand avoid
> 	the illegal configurations all over.
> 

Well, the KUNIT configs are kinda of a special case, since normally
they don't have a lot of huge number of dependencies, since unit tests
in general are not integration tests.  So ideally, dependencies will
mostly be replaced with mocking functions.  And if there are *real*
dependencies that the Kunit Unit tests need, they can be explicitly
pulled in with selects.

That being said, as I said, I'm not picky about *how* this gets
achieved.  But ease of use is a key part of making people more likely
to run the unit tests.  So another way of solving the problem might be
to put some kind of automated dependency solver into kunit.py, or some
way of manually adding the necessary dependencies in some kind of
Kunitconfig file that are in directories where their are Unit tests,
or maybe some kind of extenstion to the Kconfig file.  My main
requirement is that the only thing that should be necessary for
enabling the ext4 Kunit tests should be adding a single line to the
.kunitconfig file.  It's not fair to make the human developer manually
have to figure out the dependency chains.

As far as I'm concerned, ease of use is important enough to justfy
special casing and/or bending the rules as far as "select" is concered
for Kunit-related CONFIG items.  But if someone else want to suggest a
better approach, I'm all ears.

Cheers,

							- Ted
