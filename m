Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6970C501
	for <lists+linux-ext4@lfdr.de>; Mon, 22 May 2023 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjEVSPd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 May 2023 14:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEVSPd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 May 2023 14:15:33 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D78E0
        for <linux-ext4@vger.kernel.org>; Mon, 22 May 2023 11:15:31 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75b0df7b225so75105285a.1
        for <linux-ext4@vger.kernel.org>; Mon, 22 May 2023 11:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684779330; x=1687371330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8YMN7GS0/Sa3jrWJNg5D8Y/9968Xsswf2R2G4U+G7c=;
        b=PDDvpkWXgxLCvzOfmfvTSrXoZ1IGlOIHUQOSNsOCEpIQwsxjwhOXdzpjgGoYAo4qjj
         SdHiyJW8I6OJosHevURgB5aU4Apf7vKiXM95RYbl3V1iATUks0nDF28ts/+KeeWc2uh+
         I9M2FDBTieIEpY0cDok8SpAPhgFEWfJXKnHE+vCT0d3IZAt+wASlwugTTcbBTEb9JJY6
         UQ774TGw3LRiQaKDuYf8Q2Mxgzg/vZvxakGfHXnAatg/nLR/639HbCl0ckHymK8LXohr
         4PTfnLqtoPZSaYAGuRQjmFw2BAImb2pzGatBAmPNkTfdWnBW/ZAyf4SDK/KxqMLZuNFH
         wuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684779330; x=1687371330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8YMN7GS0/Sa3jrWJNg5D8Y/9968Xsswf2R2G4U+G7c=;
        b=hhQqS5AiiqFMqiU9GA4u8nHVYBtRun9w7KHdtNr0tznoLquZ1Z6GBzrqkWJN41piSH
         a0DUggJo1sR/vs21HuOVe+7Zn6irPPpjnoAZ5sOIYQ2tEJLRxWA7eHW2G3PHY9arDZp9
         C7dsCCn2vRO8vyCqJx22CGi2nfQma/C9wRkw/+hnDVDGhewT8mDP9+VEVrQ+ZaDTJybx
         xSxHbvUHUqghwHD+1QalgkDJS4rIOE+nteVlUlxWlhEhqaxKbg0lyrIvcx+N1SzSJHV8
         JW4EPX3WpB6lk5/D2X+g3rHleqScneLzQB2M0a3x2zufXJII2siiQ959d6jEoH65Dowe
         1B7w==
X-Gm-Message-State: AC+VfDzQeVDXPhFfSel33wgsJSPErgUdhd1aBle020CtFQztaz5HSrr/
        5NxlPyd7AIdrNH5Z+bRzytPYoD9u8Vs=
X-Google-Smtp-Source: ACHHUZ7r5059cL5YUJF1KUVCrypS47Yw2rociM4+VtFSnqNhcBa13aTTpXnQ8qilVhsvC47PcOTvjA==
X-Received: by 2002:a05:620a:2b2f:b0:75b:23a0:d9ed with SMTP id do47-20020a05620a2b2f00b0075b23a0d9edmr1737660qkb.67.1684779330261;
        Mon, 22 May 2023 11:15:30 -0700 (PDT)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id t4-20020a05620a004400b007593d311c02sm1893604qkt.27.2023.05.22.11.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:15:29 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: correct inline offset when handling xattrs in inode body
Date:   Mon, 22 May 2023 14:15:20 -0400
Message-Id: <20230522181520.1570360-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When run on a file system where the inline_data feature has been
enabled, xfstests generic/269, generic/270, and generic/476 cause ext4
to emit error messages indicating that inline directory entries are
corrupted.  This occurs because the inline offset used to locate
inline directory entries in the inode body is not updated when an
xattr in that shared region is deleted and the region is shifted in
memory to recover the space it occupied.  If the deleted xattr precedes
the system.data attribute, which points to the inline directory entries,
that attribute will be moved further up in the region.  The inline
offset continues to point to whatever is located in system.data's former
location, with unfortunate effects when used to access directory entries
or (presumably) inline data in the inode body.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/xattr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index dfc2e223bd10..e1c7b65d8d52 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1799,6 +1799,20 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		memmove(here, (void *)here + size,
 			(void *)last - (void *)here + sizeof(__u32));
 		memset(last, 0, size);
+
+		/*
+		 * Update i_inline_off - moved ibody region might contain
+		 * system.data attribute.  Handling a failure here won't
+		 * cause other complications for setting an xattr.
+		 */
+		if (!is_block && ext4_has_inline_data(inode)) {
+			ret = ext4_find_inline_data_nolock(inode);
+			if (ret) {
+				ext4_warning_inode(inode,
+					"unable to update i_inline_off");
+				goto out;
+			}
+		}
 	} else if (s->not_found) {
 		/* Insert new name. */
 		size_t size = EXT4_XATTR_LEN(name_len);
-- 
2.30.2

