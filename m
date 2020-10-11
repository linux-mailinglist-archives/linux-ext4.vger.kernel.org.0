Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E711F28A895
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Oct 2020 19:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbgJKRxw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Oct 2020 13:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388331AbgJKRxw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 11 Oct 2020 13:53:52 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F28B72222A;
        Sun, 11 Oct 2020 17:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602438832;
        bh=2dTBriDU0I8XyJqpjEF8p3SVk0vHdPj67U21+Au32ZE=;
        h=From:To:Cc:Subject:Date:From;
        b=w3pL2zV32zk1GZTeSmir8xgT1tfTkZLrqAZQeYuPco1PBCrvZrePJs8aS/V7rnfoM
         x2gAJl0h6ooEQzcRPhgTxyrLkD7xpt4Jb4ANpDJO4gKqzYJWo28ZAYoqyczxXnAyoH
         IAderasJ/jklM7IMMPpPIvNw5bIc72OYHnccv6dg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [xfstests-bld PATCH] test-appliance: add lz4 package
Date:   Sun, 11 Oct 2020 10:53:25 -0700
Message-Id: <20201011175325.3419-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This is needed for the test f2fs/002, which tests f2fs compression in
combination with encryption.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/xfstests-packages | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kvm-xfstests/test-appliance/xfstests-packages b/kvm-xfstests/test-appliance/xfstests-packages
index 45eea9a..8bb854f 100644
--- a/kvm-xfstests/test-appliance/xfstests-packages
+++ b/kvm-xfstests/test-appliance/xfstests-packages
@@ -25,6 +25,7 @@ liblzo2-2
 libbsd0
 libkeyutils1
 lvm2
+lz4
 makedev
 mtd-utils
 multipath-tools
-- 
2.28.0

