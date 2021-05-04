Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFABC3731C5
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 23:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhEDVLi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 17:11:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56283 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232169AbhEDVLh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 17:11:37 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 144LAY74001543
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 May 2021 17:10:35 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B5BD315C3C43; Tue,  4 May 2021 17:10:34 -0400 (EDT)
Date:   Tue, 4 May 2021 17:10:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJG4SrJ/ZEjv3Ha0@mit.edu>
References: <20210504031024.3888676-1-tytso@mit.edu>
 <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
 <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
 <YJFQ20rLK16rise2@mit.edu>
 <YJF6W7WHZBcVZexU@gmail.com>
 <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
 <YJGdDHLcYuRajhsb@gmail.com>
 <YJGmTNIHixCLiKok@mit.edu>
 <CAD+ocbwS9h4knUbhiXFUicvi-PwKSnPdF7hrZUhbg1MkzbDmrw@mail.gmail.com>
 <YJGyTjYKcEkx+fQq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJGyTjYKcEkx+fQq@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 04, 2021 at 01:45:02PM -0700, Eric Biggers wrote:
> 
> No, 'flags = unaligned_ptr->t_flags' is fine, provided that unaligned_ptr is a
> pointer to a struct with the packed attribute.  What -Waddress-of-packed-member
> will warn about is if you do something like &unaligned_ptr->t_flags to get a
> pointer directly to the t_flags field, as such pointers can then be incorrectly
> used for misaligned accesses.

Yeah, the warnings appear if you apply my patch, and then *also* add
the __attribute__((__packed__)) annotation.  If you revert my patch,
and then only add the __packed__ annotation, there are no warnings,
because we're no longer taking the address of the field with a packed
attribute.

Basically, what gcc (and presumably clang) is doing is it is special
casing packed_ptr->field so that the compiled code will work
regardless of the alignment of packed_ptr.  This isn't documented
anywhere, but it apparently is the case.  (I had assumed that it would
only generate unaligned access for those fields that are not aligned
if the structure started on an aligned boundary.)

However, if you take an address of a packed memory,

	short *p = &packed_ptr->field;

.. and then later derference that pointer, the C compiler can't know
that it needs to generate the magic unaligned derferencing code when
it dereferences that pointer.  So that's why that warning is there.

But if you just add __packed__ attribute, without my proposed patch,
we aren't taking the &packed_ptr->field anywhere in e2fsprogs, so
we're fine.

> If we really don't want to use __attribute__((packed)) that is fine, but then
> we'll need to remember to use an unaligned accessor *every* field access (except
> for bytes), which seems harder to me -- and the compiler won't warn when one of
> these is missing.  (They can only be detected at runtime using UBSAN.)

One reason not to use the __packed__ attribute is that there are cases
where people attempt to build e2fsprogs on non-gcc/non-clang binaries.
At one point FreeBSD was trying to use pcc to build e2fsprogs IIRC.
And certainly there are people who try to build e2fsprogs on MSVC on
Windows.

So maybe the memcpy to a local copy is the better way to go, and
hopefully the C compiler will optimize away the local copy on
architectures where it is safe to do so.  And in the unlikely case
that it is a performance bottleneck, we could add a -DUBSAN when
configure --enable-ubsan is in force, which switches in the memcpy
when only when ubsan is enabled.

					- Ted
