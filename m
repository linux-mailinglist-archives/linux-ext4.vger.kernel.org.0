Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7128820B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 08:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgJIGUH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 02:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgJIGUH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Oct 2020 02:20:07 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFAA022245;
        Fri,  9 Oct 2020 06:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602224406;
        bh=K9OjghJCtH+H4WoQ4DXwG51JkAORh5NnLkihJJvdds0=;
        h=From:To:Cc:Subject:Date:From;
        b=cCPDFLoKB5/QacYbSNvilTKEFdVSpHzmp0AMe3K4fzUnGRI8Suit7dAiGMtnjgpR7
         dmjLjBxz9EoK85JXvfm4UWVV7Y6okMI5rTWXz7AkXUZVrXvjpgXONUrL6hiilPUuDg
         iT4JMe80v4N744kN+5T60k6rR2eVrfAaoPYjsByg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [xfstests-bld PATCH] test-appliance: exclude two more quota tests from encrypt configs
Date:   Thu,  8 Oct 2020 23:19:08 -0700
Message-Id: <20201009061908.393826-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Exclude two recently added quota tests, and improve the comment.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .../test-appliance/files/root/fs/ext4/cfg/encrypt.exclude   | 6 +++++-
 .../files/root/fs/ext4/cfg/encrypt_1k.exclude               | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
index 07111c2..b7f6ea3 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
@@ -12,7 +12,9 @@ ext4/028
 # file systems with encryption enabled can't be mounted with ext3
 ext4/044
 
-# encryption doesn't play well with quota
+# These tests use the old-style quota support where the quota files are user
+# files instead of hidden inodes.  This isn't compatible with
+# test_dummy_encryption, as it causes the quota files to be encrypted.
 generic/082
 generic/219
 generic/230
@@ -25,6 +27,8 @@ generic/381
 generic/382
 generic/566
 generic/587
+generic/600
+generic/601
 
 # encryption doesn't play well with casefold (at least not yet)
 generic/556
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt_1k.exclude b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt_1k.exclude
index 1f5a7e5..bf5df66 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt_1k.exclude
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt_1k.exclude
@@ -21,6 +21,8 @@ generic/270
 generic/382
 generic/204
 generic/587
+generic/600
+generic/601
 
 # These tests are also excluded in 1k.exclude.
 # See there for the reasons.
-- 
2.28.0

