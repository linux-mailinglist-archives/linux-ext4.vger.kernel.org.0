Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099455BD63
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2019 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfGAN40 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Jul 2019 09:56:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53998 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727707AbfGAN4Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Jul 2019 09:56:25 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x61Du7fg031890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Jul 2019 09:56:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6F9CB42002E; Mon,  1 Jul 2019 09:56:07 -0400 (EDT)
Date:   Mon, 1 Jul 2019 09:56:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arthur Marsh <arthur.marsh@internode.on.net>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
Message-ID: <20190701135607.GB6549@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net>
 <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com>
 <20190511220659.GB8507@mit.edu>
 <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net>
 <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net>
 <17C30FA3-1AB3-4DAD-9B86-9FA9088F11C9@internode.on.net>
 <20190515045717.GB5394@mit.edu>
 <CAMuHMdV=63MwLdOB2kcX0=23itHg+_q22wXCycTvH3yn4zsfWw@mail.gmail.com>
 <CAMuHMdU-vfWjomDpttYTqgp4YzBu7z__p48r7rq6TSUwx7uFqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU-vfWjomDpttYTqgp4YzBu7z__p48r7rq6TSUwx7uFqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 01, 2019 at 02:43:14PM +0200, Geert Uytterhoeven wrote:
> Hi Ted,
> 
> Despite this fix having been applied upstream,  the kernel prints from
> time to time:
> 
>     EXT4-fs (sda1): error count since last fsck: 5
>     EXT4-fs (sda1): initial error at time 1557931133:
> ext4_get_branch:171: inode 1980: block 27550
>     EXT4-fs (sda1): last error at time 1558114349:
> ext4_get_branch:171: inode 1980: block 27550
> 
> This happens even after a manual run of "e2fsck -f" (while it's mounted
> RO), which reports a clean file system.

What's happening is this.  When the kernel detects a corruption, newer
kernels will set these superblock fields:

	__le32	s_error_count;		/* number of fs errors */
	__le32	s_first_error_time;	/* first time an error happened */
	__le32	s_first_error_ino;	/* inode involved in first error */
	__le64	s_first_error_block;	/* block involved of first error */
	__u8	s_first_error_func[32] __nonstring;	/* function where the error happened */
	__le32	s_first_error_line;	/* line number where error happened */
	__le32	s_last_error_time;	/* most recent time of an error */
	__le32	s_last_error_ino;	/* inode involved in last error */
	__le32	s_last_error_line;	/* line number where error happened */
	__le64	s_last_error_block;	/* block involved of last error */
	__u8	s_last_error_func[32] __nonstring;	/* function where the error happened */

When newer versions of e2fsck *fix* the corruption, it will clear
these fields.  It's basically a safety check because *way* too many
ext4 users run with errors=continue (aka, "don't worry, be happy"
mode), and so this is a poke in the system logs that the file system
is corrupted, and they, really, *REALLY* should fix it before they
lose (more) data.

> The inode and block numbers match the numbers printed due to the
> previous bug.

You can also see when the last file system error was detected via:

% date -d @1558114349
Fri 17 May 2019 01:32:29 PM EDT

> Do you have an idea what's wrong?
> Note that I run a very old version of e2fsck (from a decade ago).

... and that's the problem.  If you're going to be using newer
versions of the kernel, you really should be using newer versions of
e2fsprogs.

There have been a lot of bug fixes in the last 10 years, and some of
them can be data corruption bugs....

					- Ted
