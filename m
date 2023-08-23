Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD36785B38
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Aug 2023 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjHWO4g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Aug 2023 10:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjHWO4f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Aug 2023 10:56:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CADBE6D
        for <linux-ext4@vger.kernel.org>; Wed, 23 Aug 2023 07:56:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37NEuRlc007365
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 10:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692802588; bh=UOpmbglH2LEctOnd9QSb6wnhrNfVFRFPSm9asme4gu8=;
        h=From:Subject:Date:Message-Id:MIME-Version;
        b=UMdBDAdcyxxdpevfVbflDhVb5lGAGHj8OP9WT+aQy4LUppcQYy85WXpwVW6oJHN7h
         444jz3Jq6ixMYiAuV7Cb6lpRLuhuYF5oyCF7bJ7C9d49yHwGr5CE6ojrEdcMKtiKNb
         xcwf8WvMlPYQfB6xZAR5Se4KQYp2WWTrTD/riq3lWxOrkl5ur6PkiYpuPFutwkIzMm
         VWCHqujkH2pW6gXGLN8BV/xD6iXXbdcAhNMs2TrmyasCCbjx92gJczwRYDazHG3GUw
         0/xJBvI08cpBLEgDKsmCF6SxcUb5yJofKUOQtsJkEBf6Mt/cDwnUzJYqmyC3BclMHU
         mZB/k50vyaRoQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2E40515C027F; Wed, 23 Aug 2023 10:56:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-fstests@mit.edu
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4/059: disable block_validity checks when mounting a corrupted file system
Date:   Wed, 23 Aug 2023 10:56:21 -0400
Message-Id: <20230823145621.3680601-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kernels with the commit "ext4: add correct group descriptors and
reserved GDT blocks to system zone" will refuse to mount the corrupted
file system constructed by this test.  So in order to perform the
test, we need to disable the block_validity checks.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/059 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/ext4/059 b/tests/ext4/059
index 4230bde92..e4af77f1e 100755
--- a/tests/ext4/059
+++ b/tests/ext4/059
@@ -31,6 +31,11 @@ $DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
 $DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
 	grep "Reserved GDT blocks"
 
+# Kernels with the commit "ext4: add correct group descriptors and
+# reserved GDT blocks to system zone" will refuse to mount the file
+# system due to block_validity checks; so disable block_validity.
+MOUNT_OPTIONS="$MOUNT_OPTIONS -o noblock_validity"
+
 _scratch_mount
 
 # Expect no crash from this resize operation
-- 
2.31.0

