Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D54F30B2F0
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 23:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhBAWtw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 17:49:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43439 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229753AbhBAWtv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 17:49:51 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 111MmsZW027971
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Feb 2021 17:48:54 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4C73615C39E2; Mon,  1 Feb 2021 17:48:54 -0500 (EST)
Date:   Mon, 1 Feb 2021 17:48:54 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Vinicius Tinti <viniciustinti@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
Message-ID: <YBiFVgatiz+owBs9@mit.edu>
References: <20210201003125.90257-1-viniciustinti@gmail.com>
 <20210201124924.GA3284018@infradead.org>
 <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
 <YBg20AuSC3/9w2zz@mit.edu>
 <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
 <YBhuHJgZ3QPqHheV@mit.edu>
 <CAKwvOd=ny2TeYV8SGZMD+aj8Yb6OSYGKAzSb-45r-HKk6WTUCQ@mail.gmail.com>
 <YBh0ywVzkUIR3fXg@mit.edu>
 <CAKwvOdkZRdBzzW19sVAs+pX-7wWwN6AWrxUkkZwP8L4OT7SLfQ@mail.gmail.com>
 <CALD9WKx6HREQeTRXuv81v-=DTVuznXG_56YFm2dM1GOG3s4BRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALD9WKx6HREQeTRXuv81v-=DTVuznXG_56YFm2dM1GOG3s4BRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 01, 2021 at 07:05:11PM -0300, Vinicius Tinti wrote:
> 
> The goal is to try to detect real bugs. In this instance specifically I
> suggested to remove the "if (0) {...}" because it sounded like an
> unused code.
> 
> If it is useful it is fine to keep.

The trick was that it was unused code, but it was pretty obviously
deliberate, which should have implied that at some point, it was
considered useful.   :-)

It was the fact that you were so determined to find a way to suppress
the warning, suggesting multiple tactics, which made me wonder.... why
were you going through so much effort to silence the warning if the
goal was *not* to turn it on unconditionally everywhere?

I suspect the much more useful thing to consider is how can we suggest
hueristics to the Clang folks to make the warning more helpful.  For
example, Coverity will warn about the following:

void test_func(unsigned int arg)
{
	if (arg < 0) {
		printf("Hello, world\n")
	}
}

This is an example of dead code that is pretty clearly unintended ---
and it's something that "clang -Wall" or "gcc -Wall" doesn't pick up
on, but Coverity does.

So in cases where the code is explicitly doing "if (0)" or "if
(IS_ENABLED(xxx))" where IS_ENABLED resolves down to zero due to
preprocessor magic, arguably, that's not a useful compiler warning
because it almost *certainly* is intentional.  But in the case of an
unsigned int being compared to see if it is less than, or greater than
or equal to 0, that's almost certainly a bug --- and yes, Coverity has
found a real bug (tm) in my code due to that kind of static code
analysis.  So it would actually be quite nice if there was a compiler
warning (either gcc or clang, I don't really care which) which would
reliably call that out without having the maintainer submit the code
to Coverity for analysis.

Cheers,

							- Ted

P.S.  If anyone wants to file a feature request bug with the Clang
developers, feel free.  :-)
