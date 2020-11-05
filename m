Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5DC2A8346
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Nov 2020 17:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgKEQR7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 11:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEQR7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 11:17:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F84C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 08:17:59 -0800 (PST)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:4a7e:bc14:686e:75db])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E2E6C1F460D7;
        Thu,  5 Nov 2020 16:17:57 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH 00/11] e2fsprogs: improve case-insensitive fs support
Date:   Thu,  5 Nov 2020 17:16:32 +0100
Message-Id: <20201105161642.87488-1-arnaud.ferraris@collabora.com>
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
 e2fsck/pass1.c             |  17 +++++++
 e2fsck/pass1b.c            |   2 +-
 e2fsck/pass2.c             |  68 ++++++++++++++++++++++++++--
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
 19 files changed, 309 insertions(+), 30 deletions(-)
 create mode 100644 tests/f_bad_fname/expect.1
 create mode 100644 tests/f_bad_fname/expect.2
 create mode 100644 tests/f_bad_fname/image.gz
 create mode 100644 tests/f_bad_fname/name

-- 
2.28.0

