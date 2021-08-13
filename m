Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A63EBC92
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 21:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhHMTdV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 15:33:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41903 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230440AbhHMTdV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 15:33:21 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17DJWnOk017205
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 15:32:49 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 02EE315C37C1; Fri, 13 Aug 2021 15:32:48 -0400 (EDT)
Date:   Fri, 13 Aug 2021 15:32:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] mke2fs: warn about missing y2038 support when
 formatting fresh ext4 fs
Message-ID: <YRbI4E3b42X3otJv@mit.edu>
References: <20210812232222.GE3601392@magnolia>
 <YRaxQBRnB3vtRieP@mit.edu>
 <20210813181436.GZ3601466@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210813181436.GZ3601466@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 13, 2021 at 11:14:36AM -0700, Darrick J. Wong wrote:
> > There were only two cases where we created file systems with 128 byte
> > inodes --- "small" and "floppy" sized file systems, and for the GNU
> > Hurd, which only supports the original 128 byte inode.  What will GNU
> > Hurd do in 16.5 years?  ¯\_(ツ)_/¯
> 
> Perhaps in that time someone can donate a disused Opteron 140 system?
> Assuming the motherboard capacitors haven't since lost their mojo.

Apparently GNU Hurd uses a unsigned 32-bit int for time_t, so they
have a 2106 problem.  They "have no plans for a 64-bit userspace, but
they have plans for a 64-bit kernel that can run 32-bit user space".
Comments from the the GNU Hurd folks on an IRC chat from 2013:

    <braunr> which overflows in 2106
    <braunr> and we already include funny comments that predict our successors,
      if any, will probably fail to deal with the problem until short before
      the overflow :>
    <azeem> luckily, no nuclear reactors are running the Hurd sofar

    https://www.gnu.org/software/hurd/open_issues/versioning.html

> > +	/*
> > +	 * Warn the user that filesystems with 128-byte inodes will
> > +	 * not work properly beyond 2038.  This can be suppressed via
> > +	 * a boolean in the mke2fs.conf file, and we will disable this
> > +	 * warning for ext2, ext3, and hurd file systems.
> 
> Um... the conffile changes only disable the warning for Hurd?

Oops, good catch, I'll fix up the comment.

> > +This boolean relation specifies wheather mke2fs will issue a warning
> > +when creating a file system with 128 byte inodes (and so therefore will
> > +not support dates after January 19th, 2038.  The default value is true,
> 
> Nit: need a closing parentheses after '2038' or no opening paren.

Thanks, fixed.

> > +except for file systems created for the GNU Hurd, which does not support
> > +inodes larger than 128 bytes.
> 
> I wonder if this statementt about Hurd this belongs in the conffile as a
> comment in the hurd section?

We currently don't have a Hurd section.  We probably could document
more about the magic that mke2fs does when you specify "-o hurd",
which probably should go in the mke2fs man page but I can't quite
bring myself to care.  Maybe some GNU Hurd folks can get interested to
do this?  :-)

						- Ted
