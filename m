Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C002AF7F2
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Nov 2020 19:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgKKSc1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Nov 2020 13:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgKKSc0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Nov 2020 13:32:26 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5718CC0613D1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Nov 2020 10:32:25 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i13so1931102pgm.9
        for <linux-ext4@vger.kernel.org>; Wed, 11 Nov 2020 10:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksm0dlXE6a3r9UilOZq678vKklKk9c1Z0/2p35CWduI=;
        b=eMazT8BrcPKOAw9TyNjP1m5paqZcZ27NVH5KFXRezf/S+TzgWDENOl8NKTUmG31TOW
         doOXukQBXTUoZZ3j6fbTyPNFTQFVFQyX6SRQ/hM25aXw3PYT7lxsCZVowkbbS7l/Uek8
         TVatVzXbt4dOktd63M3V5l/GUXw/jbAIxO2Hb1JpDWkRADP6J7C+T/lN5i2HHrG6KSyY
         mYVdfjsKKXmDIiPyV3AtyjtrLywae1ltRrAJooQY9Ze9BYMBzJwo29as57cdci+eZI0i
         SnrVZuct/AikyHe+SomP+r3boRohmRp9ACzrm/NW56K4p90tB/F7iFcMcgE1ISyTFIgU
         Vc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksm0dlXE6a3r9UilOZq678vKklKk9c1Z0/2p35CWduI=;
        b=a0kTeOA4z/34VaXk7BRCq+FR8sYVjropBZyIs4yBW/bDPwzW+EWy7iWQY0kAZAGO/0
         LybwRAUcNkVsxxF4ljDWQ1ytxjcvA2TQBYE7c5hr2DUcMpZq3xZ1TYfZVxGf8k/GpxE4
         mIHaDFeYvFUOLGCU0+1Vb+ElQv5tKtjO6P3zz0+mWXGdXZH3uWqwSxRktK2kV6Rwk/1P
         ysau+vicfmo2MA0V4rxNXdyeKOZRrz9ogzlTPlgKcrD3sLgIfu6CYBIFqeJ5Z3m+YKyj
         z0OAeQ2lx+pvkw4aqt+C760lvgjyDPpMwMZVZ7uDxVYb1vycrQdO3ZFuAGJ10ZJF4oFF
         ky6g==
X-Gm-Message-State: AOAM532HsE0s0fwKZKLc5myTbLaoVaWhSKhiYRkdC2DfAgEAqxE55cEY
        EGbqIlkghKY99UwiirUFe9AgfkDifZc=
X-Google-Smtp-Source: ABdhPJw2rCnEdjQePQsiuerxw4izQMdUmch2T2jS63BRUFtuKDi3lX1nU0wpbPMbiXrifs1CiWpZ7Q==
X-Received: by 2002:a65:5383:: with SMTP id x3mr22610968pgq.341.1605119544479;
        Wed, 11 Nov 2020 10:32:24 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id w196sm3242092pfd.177.2020.11.11.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:32:23 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshads@google.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: handle dax mount option collision
Date:   Wed, 11 Nov 2020 10:32:09 -0800
Message-Id: <20201111183209.447175-1-harshads@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Mount options dax=inode and dax=never collided with fast_commit and
journal checksum. Redefine the mount flags to remove the collision.

Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Fixes: 9cb20f94afcd2 ("fs/ext4: Make DAX mount option a tri-state")
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1b399cafb15a..bf9429484462 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1231,13 +1231,13 @@ struct ext4_inode_info {
 						      blocks */
 #define EXT4_MOUNT2_HURD_COMPAT		0x00000004 /* Support HURD-castrated
 						      file systems */
-#define EXT4_MOUNT2_DAX_NEVER		0x00000008 /* Do not allow Direct Access */
-#define EXT4_MOUNT2_DAX_INODE		0x00000010 /* For printing options only */
-
 #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
 						specified journal checksum */
 
 #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
+#define EXT4_MOUNT2_DAX_NEVER		0x00000020 /* Do not allow Direct Access */
+#define EXT4_MOUNT2_DAX_INODE		0x00000040 /* For printing options only */
+
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
-- 
2.29.2.222.g5d2a92d10f8-goog

