Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C80D615BC81
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 11:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgBMKQI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 05:16:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:51206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMKQH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Feb 2020 05:16:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86A2CAD63;
        Thu, 13 Feb 2020 10:16:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 260CE1E0E01; Thu, 13 Feb 2020 11:16:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/7 v2] e2fsprogs: Better handling of indexed directories
Date:   Thu, 13 Feb 2020 11:15:55 +0100
Message-Id: <20200213101602.29096-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Currently, libext2fs does not implement adding entry into htree directory. It
just bluntly clears EXT2_INDEX_FL and then treats the directory as non-indexed.
This breaks when metadata checksums are enabled and although ext2fs_link()
tries to fixup the directory, it doesn't always fixup all the checksums and
I have some doubts about practicality of just discarding htree information for
really large directories. This patch series implements full support for adding
entry into htree directory and some tests to test the functionality.

The first patch in the series is somewhat unrelated, it just clarifies handling
of overflown directory i_nlink handling in e2fsck which confused me initially
when analyzing the issue.

The second patch fixes a bug in e2fsck when rehashing indexed directories which
I've found during testing my series.

The third patch prepares ext2fs_mkdir() and ext2fs_symlink() to safely work
with ext2fs_link() - this demonstrates there's a breakage potential in the
following changes to ext2fs_link() for external applications using
ext2fs_link() because it can now modify the directory inode and allocate
blocks. If people are concerned about this, we could create ext2fs_link2()
with the new behavior and just restrict ext2fs_link() to bail with error
when called on indexed directory with metadata_csum enabled.

Next three patches implement the support for linking into indexed directories
and tests.

The last patch then fixes tune2fs to properly recompute directory checksums
when disabling dir_index feature.

Changes since v1:
* Fixed growing of h-tree to 3-levels
* Added e2fsck fix
* Added tune2fs fix
* Fixed ext2fs_mkdir() and ext2fs_symlink() to work with new ext2fs_link()
* Reworked tests

								Honza
