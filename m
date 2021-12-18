Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6BE47988A
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Dec 2021 05:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhLREIW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Dec 2021 23:08:22 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53885 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229885AbhLREIV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Dec 2021 23:08:21 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BI48Ikn020230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Dec 2021 23:08:18 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EDD5815C00C8; Fri, 17 Dec 2021 23:08:17 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] test-appliance: add ext4/050 to encrypt.exclude
Date:   Fri, 17 Dec 2021 23:08:14 -0500
Message-Id: <20211218040814.632571-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The ext4/050 test can't handle encrypted directories, so skip it for
now.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 .../test-appliance/files/root/fs/ext4/cfg/encrypt.exclude    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
index f3c7a959..21a8b45f 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
@@ -12,6 +12,11 @@ ext4/028
 # file systems with encryption enabled can't be mounted with ext3
 ext4/044
 
+# This test to make sure ext4 directory entries are appropriately
+# wiped after a file is deleted, or after htree operations is
+# incompatible with an encrypted directory.
+ext4/048
+
 # These tests use the old-style quota support where the quota files are user
 # files instead of hidden inodes.  This isn't compatible with
 # test_dummy_encryption, as it causes the quota files to be encrypted.
-- 
2.31.0

