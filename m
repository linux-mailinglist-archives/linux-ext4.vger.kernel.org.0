Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6F62CF961
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Dec 2020 06:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgLEE7w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 23:59:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50360 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726709AbgLEE7v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 23:59:51 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B54wwpH001986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Dec 2020 23:58:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7FC51420136; Fri,  4 Dec 2020 23:58:58 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH RFC 0/5] Add threading support to e2fsprogs
Date:   Fri,  4 Dec 2020 23:58:51 -0500
Message-Id: <20201205045856.895342-1-tytso@mit.edu>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch set adds the infrastructure to support threading to
libext2fs.  It makes the unix_io I/O Manager thread-aware.  Wang's
parallel bitmap code has been adapted to use the new threading
infrastructure.

The code has been tested with TSAN and ASAN built into gcc 10.2:

    configure 'CFLAGS=-g -fsanitize=thread' 'LDFLAGS=-fsanitize=thread'
    make clean ; make -j16 ; make -j16 check
    configure 'CFLAGS=-g -fsanitize=address' 'LDFLAGS=-fsanitize=address'
    make clean ; make -j16 ; make -j16 check

As I needed to excerpt out some of the changes to generated patches in
"Add configure and build support for the pthreads", the full patch
series can be found in git:

git fetch https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git pthreads


Theodore Ts'o (4):
  Add configure and build support for the pthreads library
  libext2fs: add threading support to the I/O manager abstraction
  libext2fs: allow the unix_io manager's cache to be disabled and
    re-enabled
  Enable threaded support for e2fsprogs' applications.

Wang Shilong (1):
  ext2fs: parallel bitmap loading

 MCONFIG.in              |  12 +-
 aclocal.m4              | 486 ++++++++++++++++++++++++
 configure               | 814 ++++++++++++++++++++++++++++++++++++----
 configure.ac            |  24 ++
 debugfs/debugfs.c       |   6 +-
 e2fsck/unix.c           |   2 +-
 lib/config.h.in         | 351 +----------------
 lib/ext2fs/ext2_io.h    |   3 +
 lib/ext2fs/ext2fs.h     |   9 +
 lib/ext2fs/openfs.c     |   2 +
 lib/ext2fs/rw_bitmaps.c | 323 +++++++++++++---
 lib/ext2fs/test_io.c    |   6 +-
 lib/ext2fs/undo_io.c    |   2 +
 lib/ext2fs/unix_io.c    | 156 +++++++-
 misc/dumpe2fs.c         |   2 +-
 misc/e2freefrag.c       |   2 +-
 misc/e2fuzz.c           |   4 +-
 misc/e2image.c          |   3 +-
 misc/fuse2fs.c          |   3 +-
 misc/tune2fs.c          |   3 +-
 resize/main.c           |   2 +-
 21 files changed, 1719 insertions(+), 496 deletions(-)

-- 
2.28.0

