Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935773731EE
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhEDVbs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 17:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232684AbhEDVbs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 4 May 2021 17:31:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CBBB61106;
        Tue,  4 May 2021 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620163852;
        bh=GzuA2VdQODBiMuxV+QB96CKaJY3mhfJcXcOM9EdM5d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHvNFRceON0YxFtA7eoKZudyK4dJfdyFt/3c8s9TcmUEa0MK5MoR2WL+YUkjODQT9
         v1Fx7ioB1MKuiZLLozbAZztBQFYHeW2G93RnzmX3gZbuTZ7qxvFpu8LC7mDZ6SGvqW
         1qMHdwqT4+XzIupcJPpOHSEZ6R/M5O9kWURzSK0OksHBToo+qhPCpXE2Ba7gC1oeZj
         Ua995u2P3B5CwRe4ZS6mcZO/yFv+ZhTShSrxjLcoHEKcD6VsV5gx75Z6sQvXGMnnbi
         UgfCsVoC41nPbgivzyMSwCJYk7WH6Ij4nHBwXHNDMeUfI5dwBecnzYus8DF/YjDtwb
         UArJHF4XBosMA==
Date:   Tue, 4 May 2021 14:30:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJG9CjVXKkha57RU@gmail.com>
References: <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
 <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
 <YJFQ20rLK16rise2@mit.edu>
 <YJF6W7WHZBcVZexU@gmail.com>
 <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
 <YJGdDHLcYuRajhsb@gmail.com>
 <YJGmTNIHixCLiKok@mit.edu>
 <CAD+ocbwS9h4knUbhiXFUicvi-PwKSnPdF7hrZUhbg1MkzbDmrw@mail.gmail.com>
 <YJGyTjYKcEkx+fQq@gmail.com>
 <YJG4SrJ/ZEjv3Ha0@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJG4SrJ/ZEjv3Ha0@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 04, 2021 at 05:10:34PM -0400, Theodore Ts'o wrote:
> 
> Basically, what gcc (and presumably clang) is doing is it is special
> casing packed_ptr->field so that the compiled code will work
> regardless of the alignment of packed_ptr.  This isn't documented
> anywhere, but it apparently is the case.  (I had assumed that it would
> only generate unaligned access for those fields that are not aligned
> if the structure started on an aligned boundary.)

I don't think it's related to the pointer dereference per se, but rather the
compiler assigns an alignment of 1 to all fields in a packed struct (even the
field at the beginning of the struct).  If you had a packed struct as a global
variable and did 'packed_struct.field', the behavior would be the same.

> > If we really don't want to use __attribute__((packed)) that is fine, but then
> > we'll need to remember to use an unaligned accessor *every* field access (except
> > for bytes), which seems harder to me -- and the compiler won't warn when one of
> > these is missing.  (They can only be detected at runtime using UBSAN.)
> 
> One reason not to use the __packed__ attribute is that there are cases
> where people attempt to build e2fsprogs on non-gcc/non-clang binaries.
> At one point FreeBSD was trying to use pcc to build e2fsprogs IIRC.
> And certainly there are people who try to build e2fsprogs on MSVC on
> Windows.

Is that really true, given that e2fsprogs already uses a lot of gcc/clang
extensions, including __attribute((packed))__ already?

> So maybe the memcpy to a local copy is the better way to go, and
> hopefully the C compiler will optimize away the local copy on
> architectures where it is safe to do so.  And in the unlikely case
> that it is a performance bottleneck, we could add a -DUBSAN when
> configure --enable-ubsan is in force, which switches in the memcpy
> when only when ubsan is enabled.

These days the memcpy() approach does get optimized properly.  armv6 and armv7
with gcc used to be a notable exception, but it got fixed in gcc 6
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67366).

- Eric
