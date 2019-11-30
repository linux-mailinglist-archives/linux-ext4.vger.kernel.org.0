Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6676310DBF7
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Nov 2019 01:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfK3At6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Nov 2019 19:49:58 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42986 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727130AbfK3At6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Nov 2019 19:49:58 -0500
Received: from callcc.thunk.org (97-71-153.205.biz.bhn.net [97.71.153.205] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAU0npNE004390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 19:49:52 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D3A07421A48; Fri, 29 Nov 2019 19:49:50 -0500 (EST)
Date:   Fri, 29 Nov 2019 19:49:50 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: Unnecessarily bad cache behavior for ext4_getattr()
Message-ID: <20191130004950.GB16443@mit.edu>
References: <CAHk-=wivmk_j6KbTX+Er64mLrG8abXZo0M10PNdAnHc8fWXfsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wivmk_j6KbTX+Er64mLrG8abXZo0M10PNdAnHc8fWXfsQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Nov 24, 2019 at 04:19:16PM -0800, Linus Torvalds wrote:
> It looks from profiles like ext4_getattr() is fairly expensive,
> because it unnecessarily accesses the extended inode information and
> causes extra cache misses.
> 
> On an empty kernel allmodconfig build (which is a lot of "stat()"
> calls by Make, and a lot of silly string stuff in user space due to
> all the make variable games we play), ext4_getattr() was something
> like 1% of the time according to the profile I gathered. It might be
> bogus - maybe the cacheline ends up being accessed later anyway, but
> it _looked_ like it was the whole "i_extra_isize" access that missed
> in the cache.
> 
> That's all for gathering the STATX_BTIME information, that the caller
> doesn't even *want*.
> 
> How about a patch like the attached?

Looks good, thanks, I've applied it to the ext4 tree.

I'm a bit surprised a cache line miss rated that high on a kernel
build, but that probably says a lot about how efficient the rest of
the kernel was (and I assume Make didn't need to rebuild most of the
object files).

					- Ted

P.S.  Did you see the ext4 pull request?  I wasn't sure if you haven't
gotten to it yet due to being distracted by Turkey day or not...

