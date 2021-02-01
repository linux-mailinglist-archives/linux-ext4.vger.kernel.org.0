Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48A130B1E6
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 22:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhBAVKo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 16:10:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53180 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229831AbhBAVKo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 16:10:44 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 111L9m86014210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Feb 2021 16:09:49 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B1BCD15C39E2; Mon,  1 Feb 2021 16:09:48 -0500 (EST)
Date:   Mon, 1 Feb 2021 16:09:48 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Vinicius Tinti <viniciustinti@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
Message-ID: <YBhuHJgZ3QPqHheV@mit.edu>
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com>
 <20210201124924.GA3284018@infradead.org>
 <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
 <YBg20AuSC3/9w2zz@mit.edu>
 <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 01, 2021 at 03:41:50PM -0300, Vinicius Tinti wrote:
> 
> My goal is to avoid having a dead code. Three options come to mind.
> 
> The first would be to add another #ifdef SOMETHING (suggest a name).
> But this doesn't remove the code and someone could enable it by accident.

I *really* don't see the point of having the compiler whine about
"dead code", so I'm not terribly fond of
-Wunreachable-code-aggressive.  There may be times where depending on
how things are compiled, we *want* the compiler to remove code block,
and it makes the code less ugly than having #ifdef ... #endif breaking
up the code.

If turning that on requires uglifying many places in the kernel code,
maybe the right answer is... don't.

That being said, I have no problem of replacing

	if (0) {
		...
	}

with

#ifdef DX_DEBUG
	...
#endif

In this particular place.

But before we go there, I want to register my extreme skepticsm about
-Wunreachable-code-aggressive.  How much other places where it is
***obvious*** that the maintainer really knew what they are doing, and
it's just the compiler whining about a false positive?

> > However, if there *is* a bug, having an early detection that the
> > representation invariant of the data structure has been violated can
> > be useful in root causing a bug.  This would probably be clearer if
> > the code was pulled out into a separate function with comments
> > explaining that this is a rep invariant check.
> 
> Good idea. I will do that too.

If you want to do that, and do something like

#ifdef DX_DEBUG
static inline htree_rep_invariant_Check(...)
{
	...
}
#else
static inline htree_rep_invariant_check(...) { }
#endif

I'm not going to complain.  That's actually a better way to go, since
there may be other places in the code where a developer might want to
introduce a rep invariant check.  So that's actually improving the
code, as opposed to making a pointless change just to suppress a
compiler warning.

Of course, then someone will try enabling a -W flag which causes the
compiler to whine about empty function bodies....

					- Ted
