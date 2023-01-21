Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C1676946
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjAUUgs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjAUUgn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3755829144
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CE65B80185
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B36C4339B
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333398;
        bh=1zct4TbQQE9m3b0jqsaQYaBRq3iWO85mL0+UuikiIp4=;
        h=From:To:Subject:Date:From;
        b=tPZzWICaUpBQtBEpO6IdyIUUWTZmFLkumwtd5wcbwtfFbGW4C8CoqF2MFhUGafYv5
         pvgTh7581T7DAExrKu0DJ3JG2Jw82U2+UzRNnazAj/ur/4Up95eOXSBDbKQe5sJAPv
         MUjkxbLfMYvetlfdRAuK9ZqZmRo8cwBUPiKcli3Ql/7vGC5tLTeo9q2iWTSvCuQhgI
         SGCIESrKruKtygpKsAX5R5z6txY0lIn8oEJ2pG68jC3/qvutGIf64c1cwJl21IbHMt
         A5RV5uBpp6J6qLBzD40cdKhEJiJK4UmVnGeyo0hUkRS+P1BGAyAthQbxiTESUq5Cqx
         C1OXZyIRLloOA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 00/38] e2fsprogs: misc fixes, and add a GitHub Actions file
Date:   Sat, 21 Jan 2023 12:31:52 -0800
Message-Id: <20230121203230.27624-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The last patch of this series adds a workflow file for GitHub Actions
that builds and tests e2fsprogs on Ubuntu, macOS, and Windows.  It's
enforced that the build does not produce warnings with -Wall.

(For now, the Windows build is much more basic than the others; only
mke2fs is built, and the unit tests are not run.)

The workflow will run on pushes to any fork of e2fsprogs that has GitHub
Actions enabled.  I'm hoping that Ted will enable it for the "official"
fork at https://github.com/tytso/e2fsprogs, but anyone can use it in
their own fork too.  The results for this patch series are at
https://github.com/ebiggers/e2fsprogs/actions/runs/3976382057

As a prerequisite to actually getting everything to pass, patches 1-37
of this series fix a large number of miscellaneous issues, mainly
pertaining to warnings with -Wall or to the Windows build.

Some patches in this series I've already sent out individually.  This
series supersedes all my previous patches.

Eric Biggers (38):
  configure.ac: only use Windows I/O manager on native Windows
  configure.ac: disable tdb by default on Windows
  configure.ac: automatically add include/mingw/ headers
  configure: regenerate
  config/install-sh: update to latest version
  lib, misc: eliminate dependency on Winsock
  lib/blkid: remove 32-bit x86 byteswap assembly
  lib/blkid: fix unaligned access to hfs_mdb
  lib/blkid: fix -Wunused-variable warning in blkid_get_dev_size()
  lib/blkid: suppress -Wunused-result warning in blkid_flush_cache()
  lib/blkid: suppress -Wstringop-truncation warning in blkid_strndup()
  lib/e2p: fix a -Wunused-variable warning in getflags()
  lib/{e2p,ss}: remove manual declarations of errno
  lib/et: fix "unused variable" warnings when !HAVE_FCNTL
  lib/ext2fs: remove 32-bit x86 bitops assembly
  lib/ext2fs: consistently use #ifdefs in ext2fs_print_bmap_statistics()
  lib/ext2fs: remove unused variable in ext2fs_xattrs_read_inode()
  lib/ext2fs: fix a printf format specifier in file_test()
  lib/ext2fs: fix two compiler warnings in windows_io.c
  lib/ext2fs: fix a -Wpointer-sign warning in ext2fs_mmp_start()
  lib/{ext2fs,support}: fix 32-bit Windows build
  lib/ss: fix 'make install' by creating man1dir
  lib/support: remove unused label in get_devname()
  lib/support: clean up definition of flags_array
  lib/uuid: remove conflicting Windows implementation of gettimeofday()
  e2fsck: use real functions for kernel slab functions
  misc/create_inode: fix -Wunused-variable warnings in __populate_fs()
  misc/create_inode: simplify logic in scandir()
  misc/e4defrag: fix -Wstringop-truncation warnings
  misc/fuse2fs: avoid error-prone strncpy() pattern
  misc/mk_hugefiles: simplify get_partition_start()
  misc/mke2fs: fix Windows build
  misc/mke2fs: fix a -Wunused-variable warning in PRS()
  misc/tune2fs: fix setting fsuuid::fsu_len
  misc/tune2fs: fix -Wunused-variable warnings in handle_fslabel()
  misc/util.c: enable MinGW alarm() when building for Windows
  resize2fs: remove unused variable from adjust_superblock()
  Add a configuration file for GitHub Actions

 .github/workflows/ci.yml      | 116 ++++++
 aclocal.m4                    | 180 +++++----
 config/install-sh             | 683 ++++++++++++++++++++++++----------
 configure                     | 105 ++++--
 configure.ac                  |  50 ++-
 e2fsck/jfs_user.h             |  62 ++-
 include/mingw/arpa/inet.h     |   5 +
 include/mingw/sys/sysmacros.h |   8 +-
 lib/blkid/Android.bp          |   1 -
 lib/blkid/devno.c             |  10 +
 lib/blkid/getsize.c           |   2 +-
 lib/blkid/probe.c             |  10 +-
 lib/blkid/probe.h             |  43 ---
 lib/blkid/save.c              |   8 +
 lib/config.h.in               | 100 ++++-
 lib/e2p/Android.bp            |   4 -
 lib/e2p/fgetversion.c         |   2 -
 lib/e2p/fsetversion.c         |   1 -
 lib/e2p/getflags.c            |   3 +-
 lib/e2p/getversion.c          |   1 -
 lib/e2p/setversion.c          |   1 -
 lib/et/Android.bp             |   3 -
 lib/et/error_message.c        |  10 +-
 lib/ext2fs/Android.bp         |   2 -
 lib/ext2fs/bitops.c           |  14 +-
 lib/ext2fs/bitops.h           |  97 -----
 lib/ext2fs/ext2_io.h          |   2 +
 lib/ext2fs/ext_attr.c         |   2 -
 lib/ext2fs/gen_bitmap64.c     |   6 +-
 lib/ext2fs/getsectsize.c      |  12 +-
 lib/ext2fs/inline_data.c      |   2 +-
 lib/ext2fs/jfs_compat.h       |   4 -
 lib/ext2fs/mmp.c              |   2 +-
 lib/ext2fs/windows_io.c       |  12 +-
 lib/ss/Makefile.in            |   5 +-
 lib/ss/execute_cmd.c          |   2 -
 lib/ss/help.c                 |   2 -
 lib/ss/pager.c                |   2 -
 lib/support/devname.c         |   1 -
 lib/support/plausible.c       |   7 +-
 lib/support/print_fs_flags.c  |  60 +--
 lib/uuid/gen_uuid.c           |  21 --
 misc/Android.bp               |   3 -
 misc/create_inode.c           |  36 +-
 misc/e4defrag.c               |  30 +-
 misc/fuse2fs.c                |   5 +-
 misc/mk_hugefiles.c           | 134 +------
 misc/mke2fs.c                 |  22 +-
 misc/tune2fs.c                |   7 +-
 misc/util.c                   |   5 +
 resize/resize2fs.c            |   4 -
 util/android_config.h         |   1 -
 util/subst.c                  |   4 +-
 53 files changed, 1102 insertions(+), 812 deletions(-)
 create mode 100644 .github/workflows/ci.yml
 create mode 100644 include/mingw/arpa/inet.h


base-commit: aad34909b6648579f42dade5af5b46821aa4d845
-- 
2.39.0

