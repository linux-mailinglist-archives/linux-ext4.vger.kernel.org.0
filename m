Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19296373196
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 22:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhEDUqA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 16:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhEDUp7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 4 May 2021 16:45:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5B88613DB;
        Tue,  4 May 2021 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620161104;
        bh=pbSrdO/B5X894C3OVXBWS0zY4oyVTzGKAWPd+Ov+c6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=py7+QL4axfAZdsmrqOHpJsKYLIhj5xcmGHz/yQxYZvx/WEO3AJXG4z2LBpI5LO97i
         +W5XszKbnxSJ0IlVmBmExOYwexyAVNf9dJeBtfRhJefrFV1ThGDppVkCcmdHJG2PnR
         sblSIKKOyw00KjCq1JekW4l4FVJFwbvyLwgz+Tf0KGS5/obzG96Pk23RS32SNwqGj8
         Yww002mP8xRXccGWqf4dtEriZJHnONzhSAqWsnOMNZxqK6Q3toZG+HMk36OCuw7Ep+
         cqaGtM8LRWcNKb7SyFL4KgBBAUWFXJtVK/BiWcV+qKSNXsWE3u+/fOEe/Zbc8v4rno
         Li7sNAALvW8zg==
Date:   Tue, 4 May 2021 13:45:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJGyTjYKcEkx+fQq@gmail.com>
References: <20210504031024.3888676-1-tytso@mit.edu>
 <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
 <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
 <YJFQ20rLK16rise2@mit.edu>
 <YJF6W7WHZBcVZexU@gmail.com>
 <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
 <YJGdDHLcYuRajhsb@gmail.com>
 <YJGmTNIHixCLiKok@mit.edu>
 <CAD+ocbwS9h4knUbhiXFUicvi-PwKSnPdF7hrZUhbg1MkzbDmrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbwS9h4knUbhiXFUicvi-PwKSnPdF7hrZUhbg1MkzbDmrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 04, 2021 at 01:14:22PM -0700, harshad shirwadkar wrote:
> I see thanks for the explanation. I quickly tried it too and saw that
> UBSAN warnings went away but I got compiler warnings
> "recovery.c:413:27: warning: taking address of packed member
> 't_blocknr_high' of class or structure 'journal_block_tag_s' may
> result in an unaligned pointer value [-Waddress-of-packed-member]".
> These compiler warnings seem to be added in [1].
> 
> These warnings make me think that de-referencing a member of a packed
> struct is still not safe. My concern is this - If we define
> journal_block_tag_t as a packed struct AND if we have following unsafe
> code, then we won't see UBSAN warnings and the following unaligned
> accesses would go unnoticed. That may not go well on certain
> architectures.
> 
> j_block_tag_t *unaligned_ptr;
> 
> flags = unaligned_ptr->t_flags;
> 
> It looks like if the compiler doesn't support
> -Waddress-of-packed-member [1], we may not even see these warnings, we
> won't see UBSAN warnings and the unaligned accesses may cause problems
> on the architectures that you mentioned.
> 
> In other words, what I'm trying to say is that while
> __atribute__((packed)) would silence UBSAN warnings (and we should do
> it), it's still not sufficient to ensure that our code doesn't do
> unaligned accesses to the struct in question. Does that make sense?
> 
> - Harshad

No, 'flags = unaligned_ptr->t_flags' is fine, provided that unaligned_ptr is a
pointer to a struct with the packed attribute.  What -Waddress-of-packed-member
will warn about is if you do something like &unaligned_ptr->t_flags to get a
pointer directly to the t_flags field, as such pointers can then be incorrectly
used for misaligned accesses.

If we really don't want to use __attribute__((packed)) that is fine, but then
we'll need to remember to use an unaligned accessor *every* field access (except
for bytes), which seems harder to me -- and the compiler won't warn when one of
these is missing.  (They can only be detected at runtime using UBSAN.)

- Eric
