Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327EE30B230
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 22:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhBAVjQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 16:39:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58674 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229608AbhBAVjO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 16:39:14 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 111LcKLj027550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Feb 2021 16:38:20 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F0DAD15C39E2; Mon,  1 Feb 2021 16:38:19 -0500 (EST)
Date:   Mon, 1 Feb 2021 16:38:19 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vinicius Tinti <viniciustinti@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
Message-ID: <YBh0ywVzkUIR3fXg@mit.edu>
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com>
 <20210201124924.GA3284018@infradead.org>
 <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
 <YBg20AuSC3/9w2zz@mit.edu>
 <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
 <YBhuHJgZ3QPqHheV@mit.edu>
 <CAKwvOd=ny2TeYV8SGZMD+aj8Yb6OSYGKAzSb-45r-HKk6WTUCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=ny2TeYV8SGZMD+aj8Yb6OSYGKAzSb-45r-HKk6WTUCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 01, 2021 at 01:16:19PM -0800, Nick Desaulniers wrote:
> I agree; Vinicius, my recommendation for -Wunreachable-* with Clang
> was to see whether dead code identified by this more aggressive
> diagnostic (than -Wunused-function) was to ask maintainers whether
> code identified by it was intentionally dead and if they would
> consider removing it.  If they say "no," that's fine, and doesn't need
> to be pushed.  It's not clear to maintainers that:
> 1. this warning is not on by default
> 2. we're not looking to pursue turning this on by default
> 
> If maintainers want to keep the dead code, that's fine, let them and
> move on to the next instance to see if that's interesting (or not).

It should be noted that in Documenting/process/coding-style.rst, there
is an expicit recommendation to code in a way that will result in dead
code warnings:

   Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
   symbol into a C boolean expression, and use it in a normal C conditional:

   .. code-block:: c

   	if (IS_ENABLED(CONFIG_SOMETHING)) {
   		...
   	}

   The compiler will constant-fold the conditional away, and include or exclude
   the block of code just as with an #ifdef, so this will not add any runtime
   overhead.  However, this approach still allows the C compiler to see the code
   inside the block, and check it for correctness (syntax, types, symbol
   references, etc).  Thus, you still have to use an #ifdef if the code inside the
   block references symbols that will not exist if the condition is not met.

So our process documentation *explicitly* recommends against using
#ifdef CONFIG_XXX ... #endif, and instead use something that will
-Wunreachable-code-aggressive to cause the compiler to complain.  

Hence, this is not a warning that we will *ever* be able to enable
unconditionally --- so why work hard to remove such warnings from the
code?  If the goal is to see if we can detect real bugs using this
technique, well and good.  If the data shows that this warning
actually is useful in finding bugs, then manybe we can figure out a
way that we can explicitly hint to the compiler that in *this* case,
the maintainer actually knew what they were doing.

But if an examination of the warnings shows that
-Wunreachable-code-aggressive isn't actually finding any real bugs,
then perhaps it's not worth it.

Cheers,


						- Ted
