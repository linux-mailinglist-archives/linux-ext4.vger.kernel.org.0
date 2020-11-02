Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA722A2B26
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Nov 2020 14:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgKBNDZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Nov 2020 08:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgKBNDY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Nov 2020 08:03:24 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DAC0617A6
        for <linux-ext4@vger.kernel.org>; Mon,  2 Nov 2020 05:03:24 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b3so8592381wrx.11
        for <linux-ext4@vger.kernel.org>; Mon, 02 Nov 2020 05:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tTqlvFP6ysaA/OlzcYgmvudkb3F+FN7UhwQGlj3J0I=;
        b=fiFsxmdbdhOXhP2pC3kTP7yB3mATcdgBgEyeloBkrmUxzZCbFNxPWx4mtHNLK7oSFq
         rqBH9NtLJ0cmEiA6n8Jel8YjW0+YlbvaSW+F7WZKjdtmfMCwP+5SYp5DtFgN6yU4H4cf
         P+IG3ltYtxYz2ENARBSe2YGYL/2WSe2qKpgWuaL40ONAHC/mD337RCER6Ogu2U4RONfQ
         ixfNZ0Z78+EbjgVge75f0TnJy+z5TnzNW1Ov07JrzXxiecr+d7x1KIRtZTV4pqarPDZP
         u9zXBoWR34v5b6FcMRsuG+ENIM/gImVkfhV5EyQx9BHJJ097DeBI9wvi3ku5U6jj/vYD
         5Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tTqlvFP6ysaA/OlzcYgmvudkb3F+FN7UhwQGlj3J0I=;
        b=dvETz+Qx4FxdS3+zu03/zaj5A4ivJH24rgnRNgQaTMpaddpv83WERfe3BqNFGlCVFY
         PMjUNSE/QToSFvR3TsoCY4ZslNmc7knRCNaCYCYimB+2ItcKRqcZDBOdZ7UdbYzw4C8n
         lH2SH9Ck/Eyn/8XkkByzevzbEMz7a4lcwKuKnsulypCD0zOoZ7qVrd+fyquEPlrsSkJh
         xfrfVQNh5PS9KQbac6wgK8BJpEVuoxH0CEFhzxUm9vN4MXUHL62fb6vQQNbfoHWA57+2
         /lrwlRQOTXfNktQCKYEGobyNdH+PeS275uV02jy0uOoRJKLObrXbED33AePOT/Ggc5X+
         6BNg==
X-Gm-Message-State: AOAM531xgv0ZbSiyKbCw2aqXNV25wtlRfXQjBUg2Qn3jWYkMjcX4ilGl
        OM/L7hiO/JRmCZ6/hoK388IGz9kjmZE=
X-Google-Smtp-Source: ABdhPJyrIHjIhbRgqS2w8OGxAVcekBmr9JgejoOokiFZnwirWhrAm/bNGyBDPmXPT7UItMzKwcg/iA==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr19928702wrq.129.1604322202715;
        Mon, 02 Nov 2020 05:03:22 -0800 (PST)
Received: from localhost.localdomain (2a01cb058f8a18003dbee9eed79eb521.ipv6.abo.wanadoo.fr. [2a01:cb05:8f8a:1800:3dbe:e9ee:d79e:b521])
        by smtp.gmail.com with ESMTPSA id o186sm15854361wmb.12.2020.11.02.05.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 05:03:22 -0800 (PST)
From:   Romain Naour <romain.naour@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Romain Naour <romain.naour@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] libext2fs: add gnu.translator support
Date:   Mon,  2 Nov 2020 14:03:19 +0100
Message-Id: <20201102130319.1434330-1-romain.naour@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The support of setting (and reading) of passive translators from
GNU/Linux has been added to the Linux kernel by the commit [1].
The name index '10' has been reserved for GNU/Hurd.

Hurd passive translators are stored as a xattr value with name
"gnu.translator" [2].

If "gnu.translator" xattr value has been set before calling
mkfs.ext2, it will segfault since "gnu." is not present in
ea_names[].

$ setfattr -n gnu.translator -v "/hurd/exec\0" ${TARGET_DIR}/servers/exec
$ mkfs.ext2 -d ${TARGET_DIR} -o hurd -O ext_attr rootfs.ext2 "1G"

Adding "gnu." to ea_names[], allow to create ext2 filesystem
for GNU/Hurd with passive translator already set.

[1] https://git.savannah.gnu.org/cgit/hurd/hurd.git/commit/?id=a04c7bf83172faa7cb080fbe3b6c04a8415ca645
[2] https://lists.gnu.org/archive/html/bug-hurd/2016-08/msg00075.html

Signed-off-by: Romain Naour <romain.naour@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/ext_attr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/ext2fs/ext_attr.c b/lib/ext2fs/ext_attr.c
index 871319a5..4580d2e1 100644
--- a/lib/ext2fs/ext_attr.c
+++ b/lib/ext2fs/ext_attr.c
@@ -336,6 +336,7 @@ struct ea_name_index {
 
 /* Keep these names sorted in order of decreasing specificity. */
 static struct ea_name_index ea_names[] = {
+	{10, "gnu."},
 	{3, "system.posix_acl_default"},
 	{2, "system.posix_acl_access"},
 	{8, "system.richacl"},
-- 
2.25.4

