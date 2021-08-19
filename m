Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C783F1BE7
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbhHSOuU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbhHSOuS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Aug 2021 10:50:18 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265A2C061757
        for <linux-ext4@vger.kernel.org>; Thu, 19 Aug 2021 07:49:42 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id bl13so3731088qvb.5
        for <linux-ext4@vger.kernel.org>; Thu, 19 Aug 2021 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/R+Y9ePoCEJzeGoqYlwN2k3Ux6yFtVnQItvv7scrCJ0=;
        b=YcGEqGzTTKPiOVmyV6+WG+ObyrqD6vUvaDwAUG+8SYzQmer+M7l4lVMpNhIAEbfqLJ
         zsYyMfxWFNGaRE0SyT3gjx8qeGzzVH/HJIlU8RmocvTIqqkU2WhcF6jcf8EcdZUuOkeV
         nyJMJO7JbC4vdUx2X4Yse9TJXfo2TB+dQgDtrWEWlsJ7a2UvJu69JnfaxO1rEyuQXsZM
         1uJ0EJlUI90oSYBrF/1rUJZcfcdft5SoIgr/adQJTi9HjGKHM2EhnTQq0naNYL0UL/wb
         CBDR3r7xzyzyEMTZaX8vZTZ5o62Ngs03mRhlPHMjQyLIg1BgXQ7UBncAFGf/ppaT1FoL
         BQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/R+Y9ePoCEJzeGoqYlwN2k3Ux6yFtVnQItvv7scrCJ0=;
        b=Oh0YAXppaU9EHk/aiiMJFS0dKiqV31gt45ll8+uPVbKmlVSV8qe0zCELl17gvZRzzo
         zo83QYOubPQjHqs86UudQUJCAD8uFjzQT+5U8qd6LhbXi1TSJNqN5Ao15MLPSaGBDscp
         NjlsDKW2dm6uR24VeHXwoH2wi894Y5p7O3esDIAVRz1wZToFPt1RgCzDIuXdIAjE/Ktb
         wIXfOo2HaQVfUvlviAgexuetcPoxq/JY83N1iXCbkqOufLPT6S/tLt2DHoksp3EqRqjq
         OOKUur99mb8pdzBoFbf9idappDDV20ENcce7TjpWiGYEWvdtwXCmdOa47XsDtP7vI0RZ
         U1oQ==
X-Gm-Message-State: AOAM530XWmLmVZtHB+NCu0iAHc554Yi55zunF/IKLB4yEnaCL4ub5cvM
        k/Ye4APHZdCGkTFOUflYB8TIy6jUd8Y=
X-Google-Smtp-Source: ABdhPJz7GpwWeKJwYBDxmFeEBsWE98Ji75xZZhZg7e0OYuONFJIAIIyXsGVhqD/w3XiT2ZI5d+OiUA==
X-Received: by 2002:ad4:51c7:: with SMTP id p7mr14903791qvq.15.1629384581356;
        Thu, 19 Aug 2021 07:49:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id x21sm1684292qkf.76.2021.08.19.07.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 07:49:41 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 2/2] ext4: enforce buffer head state assertion in ext4_da_map_blocks
Date:   Thu, 19 Aug 2021 10:49:27 -0400
Message-Id: <20210819144927.25163-3-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210819144927.25163-1-enwlinux@gmail.com>
References: <20210819144927.25163-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove the code that re-initializes a buffer head with an invalid block
number and BH_New and BH_Delay bits when a matching delayed and
unwritten block has been found in the extent status cache. Replace it
with assertions that verify the buffer head already has this state
correctly set.  The current code masked an inline data truncation bug
that left stale entries in the extent status cache.  With this change,
generic/130 can be used to reproduce and detect that bug.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/inode.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d8de607849df..c795184153d8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1718,13 +1718,16 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		}
 
 		/*
-		 * Delayed extent could be allocated by fallocate.
-		 * So we need to check it.
+		 * the buffer head associated with a delayed and not unwritten
+		 * block found in the extent status cache must contain an
+		 * invalid block number and have its BH_New and BH_Delay bits
+		 * set, reflecting the state assigned when the block was
+		 * initially delayed allocated
 		 */
-		if (ext4_es_is_delayed(&es) && !ext4_es_is_unwritten(&es)) {
-			map_bh(bh, inode->i_sb, invalid_block);
-			set_buffer_new(bh);
-			set_buffer_delay(bh);
+		if (ext4_es_is_delonly(&es)) {
+			BUG_ON(bh->b_blocknr != invalid_block);
+			BUG_ON(!buffer_new(bh));
+			BUG_ON(!buffer_delay(bh));
 			return 0;
 		}
 
-- 
2.20.1

