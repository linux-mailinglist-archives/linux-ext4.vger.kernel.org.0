Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99C53812D1
	for <lists+linux-ext4@lfdr.de>; Fri, 14 May 2021 23:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhENV1d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 May 2021 17:27:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39508 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229504AbhENV1d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 May 2021 17:27:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14ELQHuZ017764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 17:26:18 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4E25E15C0098; Fri, 14 May 2021 17:26:17 -0400 (EDT)
Date:   Fri, 14 May 2021 17:26:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 1/3] ext4: add discard/zeroout flags to journal flush
Message-ID: <YJ7q+QA/YX3Q1s+q@mit.edu>
References: <20210511180428.3358267-1-leah.rumancik@gmail.com>
 <YJ1rVr7Sf7Az+MQm@mit.edu>
 <YJ2Lq4rTCv7RciL1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ2Lq4rTCv7RciL1@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 13, 2021 at 04:27:23PM -0400, Leah Rumancik wrote:
> 
> Just to make sure I understand correctly, the explicit __u32 is critical
> due to the size being read in by the ioctl, specifically through
> copy_from_user? When do you switch from __u32 to unsigned long? I don't
> see the __* types being carried throughout.

What I was thinking was something like this:

static int ext4_foo_ioctl(struct super_block *sb, unsigned long arg)
{
	__u32 flags;
	unsigned int f = 0;

	if (get_user(flags, (__u32 __user *) arg))
		return -EFAULT;

	if (flags & EXT4_IOC_FOO_AAA)
		f |= JBD2_FLAGS_FOO_AAA;
		
	if (flags & EXT4_IOC_FOO_BBB)
		f |= JBD2_FLAGS_FOO_BBB;
	...

	jbd_foo(sb, f);
}

So there are two separate flag namespaces, one exported to userspace
which is __u32, and which are the EXT4_IOC_FOO_*, defined in
fs/ext4/ext4.h.  (Actually, we should move the ext4 ioctls to a header
file like under include/uapi/..., maybe include/uapi/linux/ext4.h, or
include/uapi/fs/ext4.h, but that's a different patch series.)


And then there is a second flag namespace, JBD2_FLAGS_FOO_*, which is
defined in include/linux/jbd2.h, which is an unsigned int, and which
is a kernel-internal interface.

> (Also, just got Darrick's reply about the 32 vs. 64. Yes, originally
> went with 64 because there was an argument for it. I believe the 32
> is likely sufficient, but I don't feel that strongly about this matter)

Sure, but for EXT4_IOC_SHUTDOWN?  We have 3 flags defined today, and
I'm not convinced we'll have 12 more flags defined, let alone enough
that we really need a 64-bit flags.

> > What you probably want is something like:
> > 
> > #define JBD2_JOURNAL_FLUSH_DISCARD	0x0001
> > #define JBD2_JOURNAL_FLUSH_ZEROOUT	0x0002
> > #define JBD2_JOURNAL_FLUSH_VALID	0x0003
> > 
> 
> Why call them JBD2_JOURNAL_FLUSH* instead of JBD2_JOURNAL_ERASE* since
> they get passed directly through to the erase function? I feel like it
> would be weird if someone wanted to use the erase function directly but
> had to use JBD2_JOURNAL_FLUSH* flags.

The erase function is a static function that's not exported outside of
fs/jbd2.  The interface which is exposed to kernel callers outside of
fs/jbd2 is jbd2_journal_flush().  Since that's the public interface,
the flags should be similarly defined that way.

Cheers,

					- Ted
