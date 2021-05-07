Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB5E3760A9
	for <lists+linux-ext4@lfdr.de>; Fri,  7 May 2021 08:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhEGGqS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 May 2021 02:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234440AbhEGGqK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 7 May 2021 02:46:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2F27613C2;
        Fri,  7 May 2021 06:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620369910;
        bh=gHWn/2CypksruX+9u4NsTLoAPNN4ST6Jzm0kFyW+gQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYzdlVIFBAo7T95NQsGXHCs+YyGzUnvftVCw0kTC15ihhyIwEXoRRz+lU0jEmVhHl
         E+1OsMTnRCH25YfUykxDC5anQLrVrni3mVMkyt5GC18wvD845MyXShkQL1qSXK7lOV
         DV16k1Dxi/0lvksOYs0pxvapeJL/3zVS94XX+8yZnwGbYJ4SnOsuFWc98F8w4P7BTZ
         9E6BE1r34tRr2AU9GZUhG9rt5t+OJ683r6nbxSP1JP9ijrDn8tyqi8UXhrMkyoqAWL
         wxX6rhVWZUn9NSLGQcIKND9MhHxXT9hav/bp5X6VoC9VEaKsOVMeJaanN8MP7FuGAP
         6s0CV2wfuZ7KQ==
Date:   Thu, 6 May 2021 23:45:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJTh9T3sgdFFE7fM@sol.localdomain>
References: <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
 <YJFQ20rLK16rise2@mit.edu>
 <YJF6W7WHZBcVZexU@gmail.com>
 <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
 <YJGdDHLcYuRajhsb@gmail.com>
 <YJGmTNIHixCLiKok@mit.edu>
 <CAD+ocbwS9h4knUbhiXFUicvi-PwKSnPdF7hrZUhbg1MkzbDmrw@mail.gmail.com>
 <YJGyTjYKcEkx+fQq@gmail.com>
 <YJG4SrJ/ZEjv3Ha0@mit.edu>
 <YJG9CjVXKkha57RU@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJG9CjVXKkha57RU@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 04, 2021 at 02:30:50PM -0700, Eric Biggers wrote:
> > So maybe the memcpy to a local copy is the better way to go, and
> > hopefully the C compiler will optimize away the local copy on
> > architectures where it is safe to do so.  And in the unlikely case
> > that it is a performance bottleneck, we could add a -DUBSAN when
> > configure --enable-ubsan is in force, which switches in the memcpy
> > when only when ubsan is enabled.
> 
> These days the memcpy() approach does get optimized properly.  armv6 and armv7
> with gcc used to be a notable exception, but it got fixed in gcc 6
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67366).
> 

Just to be clear (looking at the latest patches on the list which are copying
whole structs), by "the memcpy() approach does get optimized properly", I meant
that it gets optimized properly in implementations of get_unaligned_le16(),
get_unaligned_le32(), put_unaligned_le32(), etc., where a single word (or less
than a word) is loaded or stored.  I don't know how reliably the compilers will
optimize out the copy if you memcpy() a whole struct instead of a single word.

Even if they don't optimize it out, I don't expect that it would be a
performance problem in this context, so it's probably still fine to solve the
problem.  But I just wanted to clarify what I meant here.

- Eric
