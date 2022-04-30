Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A624515FB6
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Apr 2022 19:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbiD3SBj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Apr 2022 14:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243938AbiD3SBi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Apr 2022 14:01:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AE7939ED;
        Sat, 30 Apr 2022 10:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B3461022;
        Sat, 30 Apr 2022 17:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D855C385AA;
        Sat, 30 Apr 2022 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651341494;
        bh=RuvtmLXYu7k3oxdQeuy8TIHBtPj7lj1z/+j84m4s41I=;
        h=From:To:Cc:Subject:Date:From;
        b=jzaK44e/VDrPECBTBVUKIEpLxbI50b4YxKrd9z8/HdBsEAB+sp57ZfrertI7eW3By
         ISfo3iD/A09JamCO9VMMpD4OIccpvxVxr2iVYWTIlyvDuh+0ShC3b3U1T+uxzonPh2
         BFJ6XmrEbqzMHlyEZTpip8YwfP2I9yiFxeATEUFj8IM1lWbFJBrGwijXH6ns8TqIC1
         UEXquTL2YO2QGus2psCl4O4AozPeK2NIUqtIURuNhV5VZPrmUyIkEVCNU/nqU7AUdw
         DUmNY/0oZhG7Hju7hD0Cy0f3T4P05xxZIS5/yWmc8mBeZBwiWcPKdzg3p13fxsb97H
         BgkMLMYG1Qpvw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [xfstests-bld PATCH] test-appliance: remove convenience fstab entries
Date:   Sat, 30 Apr 2022 10:57:33 -0700
Message-Id: <20220430175733.110401-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fstab entries for the xfstests filesystems interfere with xfstests
because they change the behavior of 'mount -o remount MOUNTPOINT' to
remount relative to the mount options from the fstab rather than the
actual mount options.  For example:

With fstab:
	$ mount -o lazytime /dev/vdc /vdc
	$ mount -o remount /vdc
	$ findmnt /vdc
	TARGET SOURCE   FSTYPE OPTIONS
	/vdc   /dev/vdc ext4   rw,relatime

Without fstab:
	$ rm /etc/fstab
	$ mount -o lazytime /dev/vdc /vdc
	$ mount -o remount /vdc
	$ findmnt /vdc
	TARGET SOURCE   FSTYPE OPTIONS
	/vdc   /dev/vdc ext4   rw,relatime,lazytime

So the lazytime option was lost on remount due to the fstab.  This
happens with other mount options too; lazytime is just an example.

This breaks xfstest ext4/053.

Remove the fstab entries, as they were only needed to make it slightly
easier to manually mount filesystems in an interactive shell.  So 'mount
/vdc' will no longer work, but 'mount /dev/vdc /vdc' will still work.

Alternatively we could make xfstests always use
'mount --options-source=mtab' instead of just 'mount', but xfstests
calls 'mount' in a bunch of different places.  We could still do it
anyway, though; let me know if that would be preferred.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/etc/fstab | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kvm-xfstests/test-appliance/files/etc/fstab b/kvm-xfstests/test-appliance/files/etc/fstab
index fbd0c69..4a6395d 100644
--- a/kvm-xfstests/test-appliance/files/etc/fstab
+++ b/kvm-xfstests/test-appliance/files/etc/fstab
@@ -7,18 +7,7 @@ debugfs		/sys/kernel/debug debugfs defaults	0	0
 v_tmp		/vtmp	9p	trans=virtio,version=9p2000.L,msize=262144,nofail,x-systemd.device-timeout=1	0	0
 /dev/rootfs	/	ext4    noatime 0 1
 
-# Convenience entries for interactive mounting (e.g. 'mount /vdb')
-/dev/vdb	/vdb	auto	defaults,noauto		0	0
-/dev/vdc	/vdc	auto	defaults,noauto		0	0
-/dev/vdd	/vdd	auto	defaults,noauto		0	0
-/dev/vde	/vde	auto	defaults,noauto		0	0
-/dev/vdf	/vdf	auto	defaults,noauto		0	0
 /dev/vdg	/results auto	defaults		0	2
-/dev/vdi	/vdi	auto	defaults,noauto		0	0
-/dev/vdj	/vdj	auto	defaults,noauto		0	0
 
-localhost:/test	/mnt/test nfs 	defaults,noauto		0	0
-localhost:/scratch /mnt/scratch nfs defaults,noauto	0	0
-
-/vdc/scratch	/scratch none	defaults,noauto,bind	0	0
-/vdc/test	/test	 none	defaults,noauto,bind	0	0
+# Don't include entries for the xfstests filesystems (/vdb, /vdc, etc.) here, as
+# they interfere with xfstests by changing the behavior of 'mount -o remount'.
-- 
2.36.0

