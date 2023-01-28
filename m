Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B5967FB6E
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jan 2023 23:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjA1W6t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Jan 2023 17:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjA1W6p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Jan 2023 17:58:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911E2386F
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 14:58:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35F44B80B8F
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 22:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2557C4339B
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674946721;
        bh=lUK/hRgoHyT21Z5owuFxULqAhlQAm54k6aJI34U/HSA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=t8N2UgSxlfz/fsOKJx3SfeEBYL46WCqKv3dnrzbrSHGb+60QLrEy6QQnghBj5JcLT
         QTfQBPkNGM5Xhlkt9ieEMTvGmUqoQmvk9oaqPWa0bitYwRq+aIVD/z2BkUaoQcWEEO
         pRRih+u+k8MpmmZRuBAcMvemW3e3aAxM65fwAipAZt5sXX610aOATALx3jx6YHX3Jx
         aXZE0QvURWd+fVjmGR5IWi84fUXjWyoE1XtlG1c+ztNkfkdi5uzYn6ahL2Wr3wEFbd
         VEkWDuuwkoUHFAu9QSd1LvC6B4GG+acgnbR0dLnua6EOvtZj1qjI5XMimlGYWzBKfY
         +/1LrCwlRHqrg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/4] debugfs: fix a -Wformat warning in dump_journal()
Date:   Sat, 28 Jan 2023 14:46:49 -0800
Message-Id: <20230128224651.59593-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128224651.59593-1-ebiggers@kernel.org>
References: <20230128224651.59593-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This really should just use PRIi64, but e2fsprogs doesn't use the
inttypes.h format specifiers elsewhere, so just be consistent for now.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 debugfs/logdump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index 036b50baf..938b48907 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -479,7 +479,8 @@ static void dump_journal(char *cmdname, FILE *out_file,
 
 		if ((blocknr == first_transaction_blocknr) &&
 		    (cur_counts != 0) && dump_old && (dump_counts != -1)) {
-			fprintf(out_file, "Dump all %lld journal records.\n", cur_counts);
+			fprintf(out_file, "Dump all %lld journal records.\n",
+				(long long)cur_counts);
 			break;
 		}
 
-- 
2.39.1

