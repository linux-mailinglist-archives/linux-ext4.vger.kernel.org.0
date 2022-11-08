Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661A621761
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiKHOvo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 09:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiKHOvo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 09:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83620DA7
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 06:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667919046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WW9ip7vP455y17IMaZ67QgkpYH1grc81drTLUrxR98M=;
        b=J6YN2lxxEj9CpJUSYEe7RNSD/SW22rbZBDU9E1tBP+x7iSJNE4ZwNYUF464jLhhYwxMDtE
        p9738By9rB4yqqC6/e7lZ5LFGrw4RC5RPYdftN3Pp5fnuX+CoA3QurvUVAC88ghgoD2tQ8
        Gny+v2WL2BHri2sDm+ckFKHC/5ocob4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-Y4T0rYRPM76P5BBjODACQQ-1; Tue, 08 Nov 2022 09:50:45 -0500
X-MC-Unique: Y4T0rYRPM76P5BBjODACQQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1EEA88B7A6;
        Tue,  8 Nov 2022 14:50:43 +0000 (UTC)
Received: from ovpn-194-7.brq.redhat.com (ovpn-194-7.brq.redhat.com [10.40.194.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 200F3492B05;
        Tue,  8 Nov 2022 14:50:42 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH] ext4: print file system UUID on mount, remount and unmount
Date:   Tue,  8 Nov 2022 15:50:42 +0100
Message-Id: <20221108145042.85770-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The device names are not necessarily consistent across reboots which can
make it more difficult to identify the right file system when tracking
down issues using system logs.

Print file system UUID string on every mount, remount and unmount to
make this task easier.

This is similar to the functionality recently propsed for XFS.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Cc: Lukas Herbolt <lukas@herbolt.com>
---
 fs/ext4/super.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7cdd2138c897..4028bfc8206c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1206,7 +1206,8 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_unregister_sysfs(sb);
 
 	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs unmount"))
-		ext4_msg(sb, KERN_INFO, "unmounting filesystem.");
+		ext4_msg(sb, KERN_INFO, "unmounting filesystem %pU.",
+			 &sb->s_uuid);
 
 	ext4_unregister_li_request(sb);
 	ext4_quota_off_umount(sb);
@@ -5655,8 +5656,9 @@ static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
 		descr = "out journal";
 
 	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
-		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
-			 "Quota mode: %s.", descr, ext4_quota_mode(sb));
+		ext4_msg(sb, KERN_INFO, "mounted filesystem %pU with%s. "
+			 "Quota mode: %s.", &sb->s_uuid, descr,
+			 ext4_quota_mode(sb));
 
 	/* Update the s_overhead_clusters if necessary */
 	ext4_update_overhead(sb, false);
@@ -6611,8 +6613,8 @@ static int ext4_reconfigure(struct fs_context *fc)
 	if (ret < 0)
 		return ret;
 
-	ext4_msg(sb, KERN_INFO, "re-mounted. Quota mode: %s.",
-		 ext4_quota_mode(sb));
+	ext4_msg(sb, KERN_INFO, "re-mounted %pU. Quota mode: %s.",
+		 &sb->s_uuid, ext4_quota_mode(sb));
 
 	return 0;
 }
-- 
2.38.1

