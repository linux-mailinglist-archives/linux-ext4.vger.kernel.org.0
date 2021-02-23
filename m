Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849FF322FC7
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 18:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhBWRnF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Feb 2021 12:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhBWRnB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Feb 2021 12:43:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F70AC06178A
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:42:21 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b15so2316920pjb.0
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJWZzEzNS5vVfW1OyrxYVwHMUBJWStcPfWCrCP2j/8o=;
        b=fb/dZpVqivMMkxDgtqWl+mPZB+jn/iE6jHXrnS19j75cdTgPBxVUGZAVz8kx9YWjJr
         i0J0I21c9rZzBuUxJpJgd9asTblD5iyj9grYc661YTXr7N4ggbpfW896S+icxe0WBxIT
         Km/2gImh+tWIk8+3CnlpWiURcrHe0TFdoaZuGhWWsbifL3Ja6E/m+Wzl83FTBK40oOmm
         LarfGxImQbosqFjJWtQI2Xa5uxAYl8282RONmkBezi76xTVW+WMWhEWE5Bai7pzRypYS
         7ujakUK8y4vcyhTRcxO1QggOWKLC9wyvh+A+CAY/rEkdFadq7p3SUPjq3GCCOptSVRNe
         P8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJWZzEzNS5vVfW1OyrxYVwHMUBJWStcPfWCrCP2j/8o=;
        b=qYwjJBu0CSl2TqiED94C9s2WSMWVwaJuTPKtrQIo1g4h1rBvP3YKuBX5F0rVV36n7+
         0PjKf8KDFmilX7hOcniILLIRIZciRbTVy0YY68s21i7YI976kTLl4FugurfZkV4cgTxh
         M5s6vhWy15STMmP1pip5NcsQB1bokKrhiC5sxBuaGJFYbFcI72xKdhv0BINl9G0TvKeE
         uhss+oUmgk4+/PhSfEddNYzQ71e0zxi7iqcatW1l8qi578/ONMpyP3g9A57tKeEH+Opt
         VmWrtbcHiVGGVcHqq0UN6ozCXFSJ3QSuvTmj5U2ZCnG9j8ihQVznr5v/oC+s+Cpx7Ijz
         e2Xw==
X-Gm-Message-State: AOAM5336fQWohQrfRY9Ueg8IzB89Bv0nfSK33O8PQAbt2bRPoDClm8Sl
        Mchr81bJ4HvvQmE+bpUzFRVAiCsm1gc=
X-Google-Smtp-Source: ABdhPJyNbpCdfV5kY3F251YkgJ7q0rh+k0G55elb3dcvdqEfn3TWB+1erila1eynJigpYZRXsgTcvA==
X-Received: by 2002:a17:902:26f:b029:e3:efab:37a8 with SMTP id 102-20020a170902026fb02900e3efab37a8mr12913750plc.62.1614102140799;
        Tue, 23 Feb 2021 09:42:20 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:9c60:903e:f56e:8b80])
        by smtp.googlemail.com with ESMTPSA id gk14sm5527408pjb.2.2021.02.23.09.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:42:19 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 2/4] ext2fs: don't ignore return value in ext2fs_count_blocks
Date:   Tue, 23 Feb 2021 09:41:54 -0800
Message-Id: <20210223174156.308507-2-harshads@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210223174156.308507-1-harshads@google.com>
References: <20210223174156.308507-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Don't ignore return value of ext2fs_get_array() in
ext2fs_count_blocks().

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 lib/ext2fs/extent.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index 1a87e68b..9e611038 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -1824,8 +1824,11 @@ errcode_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
 	if (errcode)
 		goto out;
 
-	ext2fs_get_array(handle->max_depth, sizeof(blk64_t),
-				&intermediate_nodes);
+	errcode = ext2fs_get_array(handle->max_depth, sizeof(blk64_t),
+				   &intermediate_nodes);
+	if (errcode)
+		goto out;
+
 	blkcount = handle->level;
 	while (!errcode) {
 		if (extent.e_flags & EXT2_EXTENT_FLAGS_LEAF) {
-- 
2.30.0.617.g56c4b15f3c-goog

