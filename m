Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992AE1A054B
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 05:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDGDai (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 23:30:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58844 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbgDGDai (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Apr 2020 23:30:38 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0373UVaZ024091
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Apr 2020 23:30:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 777E142013D; Mon,  6 Apr 2020 23:30:31 -0400 (EDT)
Date:   Mon, 6 Apr 2020 23:30:31 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Use case for EXT4_INODE_HUGE_FILE / EXT4_HUGE_FILE_FL?
Message-ID: <20200407033031.GT45598@mit.edu>
References: <20200406224534.GA668050@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406224534.GA668050@localhost>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 06, 2020 at 03:45:34PM -0700, Josh Triplett wrote:
> Under what circumstances can an inode ever end up with EXT4_HUGE_FILE_FL
> set? (Other than in an artificially constructed filesystem.)
> 
> Was EXT4_HUGE_FILE_FL just added for future extensibility, in case a
> future file storage mechanism allows storing files bigger than 2**32
> blocks?

Yes. basically.  When we added the huge_file feature, which introduced
the i_blocks_hi field, the thinking was to add EXT4_HUGE_FILE_FL so
that we could painlessly upgrade a file system from ext3 (w/o the huge
file feature) to enabling the feature without having to rewrite all of
the inodes.  However, we also didn't want to artificially limit
ourselves to 2**57 file sizes, so we also added the EXT4_HUGE_FILE_FL
flag.

It hasn't gotten a huge amount of testing in a while, but it would be
relatively easy to add debugging code (triggered via a mount option or
a sysfs file) which forces the use of EXT4_HUGE_FILE_FL all the time.

> (Related: are there any plans or discussions regarding a future extent
> format? Not necessarily just for that reason, but there are other limits
> in the existing extent format, such as the limit of 32768 contiguous
> blocks in one extent.)

We've talked about it, and when I implemented the e2fsprogs support
for extents, I deliberately implemented it so we could more easily
support multiple extent tree formats.  Unfortunately, the kernel code
wasn't written to do this easily.  So we would either need to fork a
large portion of fs/ext4/extents.c, or we would have to refactor the
code to allow supporting multiple extent formats at the same titme.

A related project would be to create a more general btree library
which understands supports journalled changes using jbd2, but which
was general enough it could support the extent tree code, but also
might be usable to support an tree-based extent allocation tree with
refcounts to replace the block allocation bitmaps, to enable ext4 to
support copy-on-write reflinks and snapshots.

It just hasn't been high enough priority for any one to get their
company to fund that kind of work --- and it's complex enough that it
would be hard to make it fit within an intern project or a Google
Summer of Code project.  Maybe if we assumed that the intern already
was familiar with Kernel programming, but that's in general not a safe
assumption that we can make.

Cheers,

						- Ted

