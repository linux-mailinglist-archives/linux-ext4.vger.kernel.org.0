Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C7B50C3AD
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Apr 2022 01:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiDVXA2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Apr 2022 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiDVXAQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Apr 2022 19:00:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD671C6EE8;
        Fri, 22 Apr 2022 15:31:43 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23MMVdnm003125
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 18:31:39 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 06F6B15C3EA1; Fri, 22 Apr 2022 18:31:39 -0400 (EDT)
Date:   Fri, 22 Apr 2022 18:31:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 5.18-rc4
Message-ID: <YmMsywgKkOpa6dlR@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 919adbfec29d5b89b3e45620653cbeeb0d42e6fd:

  ext4: fix kernel doc warnings (2022-03-15 17:45:36 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 23e3d7f7061f8682c751c46512718f47580ad8f0:

  jbd2: fix a potential race while discarding reserved buffers after an abort (2022-04-21 14:21:30 -0400)

----------------------------------------------------------------
Fix some syzbot-detected bugs, as well as other bugs found by I/O
injection testing.  Change ext4's fallocate to update consistently
drop set[ug]id bits when an fallocate operation might possibly change
the user-visible contents of a file.  Also, improve handling of
potentially invalid values in the the s_overhead_cluster superblock
field to avoid ext4 returning a negative number of free blocks.

----------------------------------------------------------------
Darrick J. Wong (1):
      ext4: fix fallocate to use file_modified to update permissions consistently

Tadeusz Struk (1):
      ext4: limit length to bitmap_maxbytes - blocksize in punch_hole

Theodore Ts'o (3):
      ext4: fix overhead calculation to account for the reserved gdt blocks
      ext4: force overhead calculation if the s_overhead_cluster makes no sense
      ext4: update the cached overhead value in the superblock

Ye Bin (4):
      ext4: fix symlink file size not match to file content
      ext4: fix bug_on in start_this_handle during umount filesystem
      ext4: fix use-after-free in ext4_search_dir
      jbd2: fix a potential race while discarding reserved buffers after an abort

wangjianjian (C) (1):
      ext4, doc: fix incorrect h_reserved size

 Documentation/filesystems/ext4/attributes.rst |  2 +-
 fs/ext4/ext4.h                                |  7 ++++++-
 fs/ext4/extents.c                             | 32 +++++++++++++++++++++++++-------
 fs/ext4/inode.c                               | 18 ++++++++++++++++--
 fs/ext4/ioctl.c                               | 16 ++++++++++++++++
 fs/ext4/namei.c                               |  4 ++--
 fs/ext4/page-io.c                             |  4 +++-
 fs/ext4/super.c                               | 40 +++++++++++++++++++++++++++++-----------
 fs/jbd2/commit.c                              |  4 +++-
 9 files changed, 101 insertions(+), 26 deletions(-)
