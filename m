Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2512C6A54
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 18:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbgK0RBi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 12:01:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57086 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731703AbgK0RBi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Nov 2020 12:01:38 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:5a64:74b8:f3be:d972])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9894E1F464FB;
        Fri, 27 Nov 2020 17:01:36 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 00/12] e2fsprogs: improve case-insensitive fs support
Date:   Fri, 27 Nov 2020 18:01:04 +0100
Message-Id: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

This patch series improves e2fsprogs for case-insensitive filesystems.

First, it allows tune2fs to enable the 'casefold' feature on existing
filesystems.

Then, it improves e2fsck by allowing it to:
- fix entries containing invalid UTF-8 characters
- detect duplicated entries

By default, invalid filenames are only checked when strict mode is enabled.
A new option is therefore added to allow the user to force this verification.

This series has been tested by running xfstests, and by manually corrupting
the test filesystem using debugfs as well.

Best regards,
Arnaud

---

Changes in v2:
  - added missing comment in e2fsck/pass1.c
  - added a new problem code dedicated to bad encoded file names
  - reworked a test in e2fsck/pass2.c

Arnaud Ferraris (1):
  e2fsck: add new problem for casefolded name check

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
  tests: f_bad_fname: Test fixes of invalid filenames and duplicates

 e2fsck/e2fsck.8.in         |   4 ++
 e2fsck/e2fsck.c            |   4 ++
 e2fsck/e2fsck.h            |   2 +
 e2fsck/pass1.c             |  18 ++++++++
 e2fsck/pass1b.c            |   2 +-
 e2fsck/pass2.c             |  76 +++++++++++++++++++++++++++++---
 e2fsck/problem.c           |   5 +++
 e2fsck/problem.h           |   3 ++
 e2fsck/rehash.c            |  88 ++++++++++++++++++++++++++++++-------
 e2fsck/unix.c              |   4 ++
 lib/ext2fs/ext2fs.h        |   6 +++
 lib/ext2fs/ext2fsP.h       |   6 +++
 lib/ext2fs/nls_utf8.c      |  62 ++++++++++++++++++++++++++
 lib/support/dict.c         |  22 +++++++---
 lib/support/dict.h         |   4 +-
 lib/support/mkquota.c      |   2 +-
 misc/tune2fs.c             |  18 +++++++-
 tests/f_bad_fname/expect.1 |  22 ++++++++++
 tests/f_bad_fname/expect.2 |   7 +++
 tests/f_bad_fname/image.gz | Bin 0 -> 802 bytes
 tests/f_bad_fname/name     |   1 +
 21 files changed, 322 insertions(+), 34 deletions(-)
 create mode 100644 tests/f_bad_fname/expect.1
 create mode 100644 tests/f_bad_fname/expect.2
 create mode 100644 tests/f_bad_fname/image.gz
 create mode 100644 tests/f_bad_fname/name

-- 
2.28.0

