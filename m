Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412EF1409AA
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2020 13:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgAQMY0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jan 2020 07:24:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:48788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgAQMY0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 17 Jan 2020 07:24:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5FB4C06F;
        Fri, 17 Jan 2020 12:24:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 596761E0D53; Fri, 17 Jan 2020 13:24:20 +0100 (CET)
Date:   Fri, 17 Jan 2020 13:24:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     linux-ext4@vger.kernel.org
Cc:     Ted Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: ext2fs_link() corrupting a directory
Message-ID: <20200117122420.GJ17141@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I was tracking down a filesystem corruption issue with one proposed
xfstests testcase. After some debugging I've found out that the problem
actually is not in the kernel but rather in e2fsck (libext2fs
respectively). The testcase deletes lost+found, e2fsck recreates it. But
after the testcase / is h-tree directory. So ext2fs_link() creates
lost+found in / and clears EXT4_INODE_INDEX flag. Now because the
filesystem has metadata checksums, clearing the index flag needs to also
rewrite all directory blocks with h-tree index blocks because the layout
now needs to be different.  ext2fs_link() actually tries to do this in its
link_proc() but if the space for new directory entry is found before we
walk all the h-tree index blocks, we terminate the iteration and some index
blocks remain unconverted resulting in checksum errors and other weirdness
later on.

The question is how to best fix this. The easiest fix is to just make
link_proc() iterate through all directory blocks when it needs to do the
index blocks conversion. But this seems somewhat stupid. Also there's
another problem with clearing EXT4_INODE_INDEX in ext2fs_link() - if the
directory has more than 65000 subdirectories, clearing EXT4_INODE_INDEX is
not allowed because large directory link count handling is supported only
for EXT4_INODE_INDEX directories.

So what do we do with this? For e2fsck, we could just link the new entry
into the directory and force rehashing later. But ext2fs_link() can be
called also from other tools and it should be a self-contained API... Any
ideas? Should we just bite the bullet and implement ext2fs_link() for
h-tree dirs properly?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
