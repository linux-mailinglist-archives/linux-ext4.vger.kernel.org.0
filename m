Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9523658B256
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Aug 2022 00:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbiHEWHF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Aug 2022 18:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241779AbiHEWHC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Aug 2022 18:07:02 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A50E1263D
        for <linux-ext4@vger.kernel.org>; Fri,  5 Aug 2022 15:07:00 -0700 (PDT)
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id K0X7oYX5VSp39K5TAoM3Yt; Fri, 05 Aug 2022 22:07:00 +0000
Received: from webber.adilger.int ([174.0.67.248])
        by cmsmtp with ESMTP
        id K5T9okyXUC3uhK5T9oFxTi; Fri, 05 Aug 2022 22:07:00 +0000
X-Authority-Analysis: v=2.4 cv=a6MjSGeF c=1 sm=1 tr=0 ts=62ed9484
 a=5skvQWjG3xExD1Ft+FuDHA==:117 a=5skvQWjG3xExD1Ft+FuDHA==:17 a=RPJ6JBhKAAAA:8
 a=lB0dNpNiAAAA:8 a=3-nrOBMCGvy0Alq09_cA:9 a=fa_un-3J20JGBB2Tu-mn:22
 a=c-ZiYqmG3AbHTdtsH08C:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>,
        Dongyang Li <dongyang@ddn.com>
Subject: [PATCH] debugfs: quiet debugfs 'catastrophic' message
Date:   Fri,  5 Aug 2022 16:06:07 -0600
Message-Id: <20220805220606.11994-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFZbv4t6dnrvukfs30rdBQwXSzwqqGB3rMJy1yZH07Elwf0LAt1HFWueOT+a6S48uxGu3//U2RJ7jHFFD/RgxWm9esiP3pWM0i/3adKV2QEMzO0Pp+Wu
 jnY0zl+oR06wH17V/3H/BAR6kHig8z2on/BJu+Iqh7FwSeJULSzI3z9oEjRHelSwHWNpl05U+4BWSZDKxdjVB61Lr2UjIDrnsDyElVdZzY1sTrwjIrlBqKoi
 qe1qPW/18MGe1hv48wB9Y6AGnLabQXT/uruo7xcI+Z4=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When debugfs runs with "-c", it prints a scary-looking message:

    catastrophic mode - not reading inode or group bitmaps

that is often misunderstood by users to mean that there is something
wrong with the filesystem, when there is no problem at all.

Not reading the bitmaps is totally normal and expected behavior for
the "-c" option, which is used to significantly shorten the debugfs
command execution time by not reading metadata that isn't needed for
commands run against very large filesystems.

Since there is often confusion about what this message means, it
would be better to just avoid printing anything at all, since the
use of "-c" is expressly requesting this behavior, and there are
no messages printed out for other options.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Dongyang Li <dongyang@ddn.com>
Change-Id: I59b26a601780544ab995aa4ca7ab0c2123c70118
---
 debugfs/debugfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index b67a88bc..78b93eda 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -195,9 +195,7 @@ try_open_again:
 	}
 	current_fs->default_bitmap_type = EXT2FS_BMAP64_RBTREE;
 
-	if (catastrophic)
-		com_err(device, 0, "catastrophic mode - not reading inode or group bitmaps");
-	else {
+	if (!catastrophic) {
 		retval = ext2fs_read_bitmaps(current_fs);
 		if (retval) {
 			com_err(device, retval,
-- 
2.25.1

