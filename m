Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC013E1879
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbhHEPon (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 11:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242515AbhHEPnn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 5 Aug 2021 11:43:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45B116113B;
        Thu,  5 Aug 2021 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628178209;
        bh=OkygAFFi/GK9Glt34GCM3YsoR5yh6ZE4tf0BX8UKxfw=;
        h=Date:From:To:Cc:Subject:From;
        b=R3tYKHavpvD5n2rzXQS5NXFC7unRhsEkmO+ziRI8lkX9lNKwd7fTPqvBETFYHk6P4
         ZxvPPp/AxKA/hmXer70EH1cqrqhHob0+eIucr7kIBXa4jtsVlX/WDa7SAixUJrkehy
         i303dvtPPblEILzITd4eLCq73Rn6NUrOqNjW0vyuQ0FUa+v5c+lG7u4xn38jk7iBO3
         gWbZlLJuG4bWWPbEDezvmyJbtM9Yfh8Az0HhSOf3Ei/EA5jz3ebQfH5mlgccqbQCpq
         T4t9q5fvjo5U6ykY3dqLdDt5JH75utS0e1h+m/OcQ8PshZxRvZujcammAj5T9zrTX9
         z0CWFu2yRHZRw==
Date:   Thu, 5 Aug 2021 08:43:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH RESEND] tests: skip u_direct_io if losetup fails
Message-ID: <20210805154328.GB3601392@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

This new test requires a loop device to run testing.  While it checks
for some "obvious" parameters that might cause the test to fail such as
not being root and no losetup executable, it doesn't actually check that
the losetup -a call succeeds.  This causes a test regression in my
package building container (where there is only a minimal /dev with no
loop devices available) so I can't build debian packages.

Fix the test to skip out if we can't create a loop device.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/u_direct_io/script |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/u_direct_io/script b/tests/u_direct_io/script
index 0b5d7083..b4f07752 100644
--- a/tests/u_direct_io/script
+++ b/tests/u_direct_io/script
@@ -9,6 +9,11 @@ elif test ! -x $DEBUGFS_EXE; then
 else
     dd if=/dev/zero of=$TMPFILE bs=1M count=128 > /dev/null 2>&1
     LOOP=$(losetup --show --sector-size 4096 -f $TMPFILE)
+    if [ ! -b "$LOOP" ]; then
+        echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
+        rm -f $TMPFILE
+        exit 0
+    fi
     echo mke2fs -F -o Linux -t ext4 -O ^metadata_csum,^uninit_bg -D \$LOOP > $OUT
     $MKE2FS -F -o Linux -t ext4 -O ^metadata_csum,^uninit_bg -D $LOOP 2>&1 | \
 	sed -f $cmd_dir/filter.sed >> $OUT
