Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F287830AD8A
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhBAROs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 12:14:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57567 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229612AbhBAROp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 12:14:45 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 111HDqQK007142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Feb 2021 12:13:52 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2C3B615C39D9; Mon,  1 Feb 2021 12:13:52 -0500 (EST)
Date:   Mon, 1 Feb 2021 12:13:52 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Vinicius Tinti <viniciustinti@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
Message-ID: <YBg20AuSC3/9w2zz@mit.edu>
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com>
 <20210201124924.GA3284018@infradead.org>
 <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 01, 2021 at 01:15:29PM -0300, Vinicius Tinti wrote:
> On Mon, Feb 1, 2021 at 9:49 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > DX_DEBUG is completely dead code, so either kill it off or make it an
> > actual CONFIG_* symbol through Kconfig if it seems useful.
> 
> About the unreachable code in "if (0)" I think it could be removed.
> It seems to be doing an extra check.
> 
> About the DX_DEBUG I think I can do another patch adding it to Kconfig
> as you and Nathan suggested.

Yes, it's doing another check which is useful in terms of early
detection of bugs when a developer has the code open for
modifications.  It slows down performance under normal circumstances,
and assuming the code is bug-free(tm), it's entirely unnecessary ---
which is why it's under an "if (0)".

However, if there *is* a bug, having an early detection that the
representation invariant of the data structure has been violated can
be useful in root causing a bug.  This would probably be clearer if
the code was pulled out into a separate function with comments
explaining that this is a rep invariant check.

The main thing about DX_DEBUG right now is that it is **super**
verbose.  Unwary users who enable it.... will be sorry.  If we want to
make it to be a first-class feature enabled via CONFIG_EXT4_DEBUG, we
should convert all of the dx_trace calls to use pr_debug so they are
enabled only if dynamic debug enables those pr_debug() statements.
And this should absolutely be a separate patch.

Cheers,

						- Ted
