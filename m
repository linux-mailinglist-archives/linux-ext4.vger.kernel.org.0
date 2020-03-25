Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B873B193275
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 22:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgCYVSV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 17:18:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39542 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVSV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 17:18:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 234BA28666B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH e2fsprogs 00/11] Improvements for Case-insensitive handling
Date:   Wed, 25 Mar 2020 17:18:00 -0400
Message-Id: <20200325211812.2971787-1-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

This patchset introduces my lastest improvements to handling casefolded
directories in e2fsprogs.  It is split in 3 parts:

Patch 1 and 2 provide tune2fs with the capability to enable the CASEFOLD
feature on existing filesystems.  The reasoning why this was not the
default since ever, and why it is safe to do so now, is on the commit
message.

Patch 3 and 4 implement some NLS/UTF-8 methods important to the fsck
validations done after.

Patch 5 and higher, improve e2fsck to fix the following issues in
case-insensitive directories: badly encoded filenames, duplicated
filenames, differing only by case.

The final patches also introduce documentation to the new
functionalities and tests for the new fsck features.

This series was tested agains the e2fsprogs testsuite and didn't trigger
any regressions.

Gabriel Krisman Bertazi (11):
  tune2fs: Allow enabling casefold feature after fs creation
  tune2fs: Fix casefold+encrypt error message
  ext2fs: Add method to validate casefolded strings
  ext2fs: Implement faster CI comparison of strings
  e2fsck: Fix entries with invalid encoded characters
  e2fsck: Support casefold directories when rehashing
  dict: Support comparison with context
  e2fsck: Detect duplicated casefolded direntries for rehash
  e2fsck: Add option to force encoded filename verification
  e2fsck.8.in: Document check_encoding extended option
  tests: f_bad_fname: Validate fix of invalid  filenames and duplicates

 e2fsck/e2fsck.8.in         |   4 ++
 e2fsck/e2fsck.c            |   4 ++
 e2fsck/e2fsck.h            |   2 +
 e2fsck/pass1.c             |  17 +++++++
 e2fsck/pass1b.c            |   2 +-
 e2fsck/pass2.c             |  68 ++++++++++++++++++++++++++--
 e2fsck/rehash.c            |  88 ++++++++++++++++++++++++++++++-------
 e2fsck/unix.c              |   4 ++
 lib/ext2fs/ext2fs.h        |   6 +++
 lib/ext2fs/ext2fsP.h       |   6 +++
 lib/ext2fs/nls_utf8.c      |  69 +++++++++++++++++++++++++++++
 lib/support/dict.c         |  22 +++++++---
 lib/support/dict.h         |   4 +-
 lib/support/mkquota.c      |   2 +-
 misc/tune2fs.c             |  18 +++++++-
 tests/f_bad_fname/expect.1 |  22 ++++++++++
 tests/f_bad_fname/expect.2 |   7 +++
 tests/f_bad_fname/image.gz | Bin 0 -> 802 bytes
 tests/f_bad_fname/name     |   1 +
 19 files changed, 316 insertions(+), 30 deletions(-)
 create mode 100644 tests/f_bad_fname/expect.1
 create mode 100644 tests/f_bad_fname/expect.2
 create mode 100644 tests/f_bad_fname/image.gz
 create mode 100644 tests/f_bad_fname/name

-- 
2.25.0

