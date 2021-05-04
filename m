Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D30372E39
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 18:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhEDQrc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 12:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbhEDQrb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 4 May 2021 12:47:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5449561177;
        Tue,  4 May 2021 16:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620146796;
        bh=i0tTuwc4foqr9yTwvqzWG/APvDlsilAQ9NxZY10SsGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4EAkP4io4/Lbvw/7DmV9VOnfBGLHXtrQeapy2ZtUQ01lTRcBzFTqJ79LEixbHw+O
         3knjvTlglJ755U4Pr15LIco2noY5vpr4A/SRP4ytLghO6xC/Is0e41bxAZxcHjQuNT
         Xq82IhbIdS5bTPB96T0Pcy1aweP3SdEr9UocO9UVBI9Ckgyli7ywkLxdkId5WPSyXf
         nx+BL1sHquL3yv8lLgS9YbXDlfiUN9o/VWNwRa2T/nbM88StfUpU6zvezo+5dlmC7w
         j7F/vH3ZgNWQLKMtsqQT48P6J53K7Q49tNyM/vIn8upNYGqEAIstnbhkttn9vb7acQ
         fxy7V7NIJvt6Q==
Date:   Tue, 4 May 2021 09:46:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJF6W7WHZBcVZexU@gmail.com>
References: <20210504031024.3888676-1-tytso@mit.edu>
 <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
 <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
 <YJFQ20rLK16rise2@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJFQ20rLK16rise2@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 04, 2021 at 09:49:15AM -0400, Theodore Ts'o wrote:
> On Tue, May 04, 2021 at 02:40:08AM -0700, harshad shirwadkar wrote:
> > Hi Ted,
> > 
> > Thanks for the patch. While I now see that these accesses are safe,
> > ubsan still complains about it the dereferences not being aligned.
> > With your changes, the way we read journal_block_tag_t is now safe.
> > But IIUC, ubsan still complains mainly because we still pass the
> > pointer as "&tag->t_flags" and at which point ubsan thinks that we are
> > accessing member t_flags in an aligned way. Is there a way to silence
> > these errors?
> 
> Yeah, I had noticed that.  I was thinking perhaps of doing something
> like casting the pointer to void * or char *, and then adding offsetof
> to work around the UBSAN warning.  Or maybe asking the compiler folks
> if they can make the UBSAN warning smarter, since what we're doing
> should be perfectly safe. 

This does seem to be an UBSAN bug, although both gcc and clang report this same
error, which is odd...  Dereferencing a misaligned field would be undefined
behavior, but just taking its address isn't (AFAIK).

> 
> > 
> > I was wondering if it makes sense to do something like this for known
> > unaligned structures:
> > 
> > journal_block_tag_t local, *unaligned;
> > ...
> > memcpy(&local, unaligned, sizeof(&local));
> 
> I guess that would work too.  The extra memory copy is unfortunate,
> although I suspect the performance hit isn't measurable, and journal
> replay isn't really a hot path in either the kernel or e2fsprogs.
> (Note that want to keep recovery.c in sync between the kernel and
> e2fsprogs, so whatever we do needs to be something we're happy with in
> both places.)
> 

Modern compilers will optimize out the memcpy().

However, wouldn't it be easier to just add __attribute__((packed)) to the
definition of struct journal_block_tag_t?

- Eric
