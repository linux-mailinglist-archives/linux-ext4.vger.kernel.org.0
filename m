Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF53A90D5
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 06:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFPE6t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 00:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhFPE6r (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Jun 2021 00:58:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D43CC61351
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 04:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623819401;
        bh=WV1ww3dgoBXIHQTOcTVXxkQDaDNYP9G7s3ivR1Yn+bc=;
        h=From:To:Subject:Date:From;
        b=ctG3xWrDpEsC27hF1suD+DmGBYS6NWN0a0MW/cRK2vibU4PQEsDCFNHCPrkljOSXN
         j5h8VkEQUHexHbdxrdTo81gHlVldgHbQZHtawPfP/VNWtt1BtVp8PiH5by7onDhHv6
         OJFRrD7QWExglbBut9saQms5+WoXPCUR1uzgPJdiC0RbTcOzfgr3IppEjcgYxwAFCs
         Zzj8lXGNbvJokvemdJweYjHR730E8+d0jKWq0gsllBLFySUatOKopId5dT/FrOYd2B
         0xZx9YiaA8x2VLcA06wN4hP57bbI+Ea4Ve7XQH1vXpyBJR8nQ/lYu/1Mm9oUPd+o1a
         wdzSwOCFr9kkA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 0/6] e2fsprogs: fix compiler warnings introduced since v1.45.4
Date:   Tue, 15 Jun 2021 21:53:28 -0700
Message-Id: <20210616045334.1655288-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix various compiler warnings that were introduced since e2fsprogs
v1.45.4, including the following types of warnings:

  -Wunused-variable  (enabled by -Wall)
  -Wunused-label     (enabled by -Wall)
  -Wunused-parameter

Note, there were also -Wpointer-arith (arithmetic on a void pointer is a
GNU extension) warnings introduced, but I don't find those to be very
useful.  But I can send out a patch for those too if people want it.

Also fix a -Wincompatible-pointer-types warning in the Windows build.

Eric Biggers (6):
  libext2fs: improve jbd_debug() implementation
  e2fsck: sync fc_do_one_pass() changes from kernel
  mke2fs: use ext2fs_get_device_size2() on all platforms
  Fix -Wunused-parameter warnings
  Fix -Wunused-variable warnings
  libext2fs: fix a -Wunused-label warning

 debugfs/journal.c       |  7 ++-----
 e2fsck/extents.c        |  2 +-
 e2fsck/jfs_user.h       |  3 ++-
 e2fsck/journal.c        | 18 +++++-------------
 e2fsck/pass1b.c         |  3 ++-
 e2fsck/pass2.c          |  3 ++-
 e2fsck/recovery.c       |  5 ++---
 e2fsck/rehash.c         |  2 +-
 lib/e2p/errcode.c       |  1 -
 lib/e2p/fgetflags.c     |  2 +-
 lib/e2p/fsetflags.c     |  1 -
 lib/ext2fs/kernel-jbd.h | 26 +++++---------------------
 lib/ext2fs/mkjournal.c  |  1 -
 lib/ext2fs/unix_io.c    |  1 -
 lib/support/mkquota.c   |  3 ++-
 misc/mke2fs.c           |  8 ++------
 16 files changed, 27 insertions(+), 59 deletions(-)


base-commit: 32fda1e5a338ff676ae7f7e3e2bc256e7a7e2855
-- 
2.32.0.272.g935e593368-goog

