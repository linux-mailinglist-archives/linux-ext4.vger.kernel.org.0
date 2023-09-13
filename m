Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A6779EC0E
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbjIMPFL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Sep 2023 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbjIMPFK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Sep 2023 11:05:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDD5C6
        for <linux-ext4@vger.kernel.org>; Wed, 13 Sep 2023 08:05:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C063218E5;
        Wed, 13 Sep 2023 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694617505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZ73ErKfFCudA76NUgANoybnniVAPS5S8E3lXnfEKpQ=;
        b=uxLI8kbovKukDi4rufe1shjDfGGIHvTpq5PDHhu/RSHrZVHLJsE7WlOxTC1JkFhszeJ8eR
        MEzBFZkf+yOVjuIp6zjkPWXhIryCQfB/8iAqcxcDpwcjtZelRn3Ae+0bc5t6JB0hBDerih
        Ma+1CrSMUZr6pwkkKGi+0kjmsJMq3DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694617505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZ73ErKfFCudA76NUgANoybnniVAPS5S8E3lXnfEKpQ=;
        b=hZvcFXmq85wRR7AncqJhr4l+pTETKSFXqRCLbNWaXNeNA5mkW+W7p/faytjqdQqZZd0L4U
        nvUvA+V37tcn0CCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70E4913440;
        Wed, 13 Sep 2023 15:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hGsaG6HPAWUJdQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 13 Sep 2023 15:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E2DF0A07C6; Wed, 13 Sep 2023 17:05:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, todd.e.brandt@intel.com,
        lenb@kernel.org, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/2] ext4: Do not let fstrim block system suspend
Date:   Wed, 13 Sep 2023 17:04:55 +0200
Message-Id: <20230913150504.9054-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230913145649.3595-1-jack@suse.cz>
References: <20230913145649.3595-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106; i=jack@suse.cz; h=from:subject; bh=wzbr2qr/xOIYXhTC6cdxWrFNVRdnfwRURCn2vRs8oQc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlAc+WfAaguV1yLF++A3pQWHh0PT/yqwe92ypKrU6f cgPqcfWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZQHPlgAKCRCcnaoHP2RA2U08B/ 9NVlOi/FTKkfwV4s0ZvWpnxZ+POqu5X3QAmySDviXmWV7PskYNSQ2Pzl8LhVJyMWBUYvIFxyJqQCYh O0CWNDxaxjtP4JjfHWMGn4fQROvSLLFTLLt8jbpVl354lI8Y3i3xCumnnZKu5MPGMuGNcSf2SY8fSV omVCm19JIHC/F0JceW2RoUjLwQlA0N8Xt6fsbf91sMuBpRGkFIVu2/ogyon6U6/l4ykREm0ckZqJA3 EEKyv1ibXdBRQV/1O/owySZCT5FsIAntivepavOMRsGqSHCUoMrafCMOxlJ9yOO7w+6gpnl1HkWN0Z T6f575F+Sb41DU9MWmtFRMIstz0IK0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Len Brown has reported that system suspend sometimes fail due to
inability to freeze a task working in ext4_trim_fs() for one minute.
Trimming a large filesystem on a disk that slowly processes discard
requests can indeed take a long time. Since discard is just an advisory
call, it is perfectly fine to interrupt it at any time and the return
number of discarded blocks until that moment. Do that when we detect the
task is being frozen.

Reported-by: Len Brown <lenb@kernel.org>
Suggested-by: Dave Chinner <david@fromorbit.com>
References: https://bugzilla.kernel.org/show_bug.cgi?id=216322
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 09091adfde64..1e599305d85f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
+#include <linux/freezer.h>
 #include <trace/events/ext4.h>
 
 /*
@@ -6916,6 +6917,11 @@ static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
 					EXT4_CLUSTER_BITS(sb);
 }
 
+static bool ext4_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks)
@@ -6949,8 +6955,8 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		free_count += next - start;
 		start = next + 1;
 
-		if (fatal_signal_pending(current))
-			return -ERESTARTSYS;
+		if (ext4_trim_interrupted())
+			return count;
 
 		if (need_resched()) {
 			ext4_unlock_group(sb, e4b->bd_group);
@@ -7072,6 +7078,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
 	for (group = first_group; group <= last_group; group++) {
+		if (ext4_trim_interrupted())
+			break;
 		grp = ext4_get_group_info(sb, group);
 		if (!grp)
 			continue;
-- 
2.35.3

