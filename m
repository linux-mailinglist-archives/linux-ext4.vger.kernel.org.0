Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAE1B1C08
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 04:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDUCkT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 22:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbgDUCkS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 22:40:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F752C061A0E
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 19:40:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x3so5933929pfp.7
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 19:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dq61HoLnOPSROkKBqCl4+vaegWhGe0NiAlwkg5Ornuw=;
        b=vBc3YFotLxGzKfZMq9VF+gnB0vBE2NLLpA8wy6hVquflCWD5d1y0Li7lghaJ+7aNXF
         NN/7sEXvJTiHatazuQgCR0JpXeVXxAoyS7nzc0jlx8KL26KT7qIZftjZPj9QRtlzZcj5
         QXZayPqlmvbLJZNdAwU/VxzyEG//ec/aHL2zO95feTnqejiLPdYJuYJu26Y3fIsf8F/J
         qhhRt89RVJppuAW98++L/ZGwtmBq80o81cSqPmDydqyxkw9KVpbRFEHtAxvaM0PKj/1R
         8bxz9zwCTnBIF6ez22HNVgwcad5bi2ttM6w5lkT35XghScyWIMu0BlYkRgh8qRqPgn1s
         sihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dq61HoLnOPSROkKBqCl4+vaegWhGe0NiAlwkg5Ornuw=;
        b=e5b+zTMKQ4Bvgo4Lm81DoFR3W/QcdYntW4v5zpueGx78v1LFwbbVbGngSml7quQnuw
         GQTX+wF+Tnl/jJ26GCZIhbqc4djlJMipwgI+dmITyqvkL++K7t3P8XH/Byb6Mtwv5FNJ
         jfBXhPH/ERngRYX2l/bkw5mfXqIYlKVG/B7w+PzWJ/jHj6PmLq9KYQoC7P3VtQw8LOZw
         ETaDLyIlpkmGmAgeIuF8iaq/+KYg7uqRVprAaOUJz95Ddw5gYkxAqLRRH80312doCZDl
         PQoegM0V2AIyepHWRVT4wBURl3IEG2i3bG37nfeYjc3N3Mn70j5qT2q/I5DQVg4uRbZq
         pb2g==
X-Gm-Message-State: AGi0PuZF9nSSp1wyhoqC8+u6lgmtF+m/UXK8crNli4anozRIjKGyi5SA
        kle6rJQbxIulg7gVefAm+U4omNwH
X-Google-Smtp-Source: APiQypJ9B31ywTfu3Dy7ZEV6AbExGwlv1VeeO2jBlGL9CjmcHzQtdpwd32nnfU4L5oLkw8K4UaeT8g==
X-Received: by 2002:a63:f707:: with SMTP id x7mr20429398pgh.374.1587436816887;
        Mon, 20 Apr 2020 19:40:16 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id x128sm879168pfd.109.2020.04.20.19.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 19:40:16 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: don't ignore return values from ext4_ext_dirty()
Date:   Mon, 20 Apr 2020 19:39:58 -0700
Message-Id: <20200421023959.20879-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Don't ignore return values from ext4_ext_dirty, since the errors
indicate valid failures below Ext4.  In all of the other instances of
ext4_ext_dirty calls, the error return value is handled in some
way. This patch makes those remaining couple of places to handle
ext4_ext_dirty errors as well. In the longer run, we probably should
make sure that errors from other mark_dirty routines are handled as
well.

Ran gce-xfstests smoke tests and verified that there were no
regressions.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/extents.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2b577b315a0..f62f55a16fe3 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3244,8 +3244,7 @@ static int ext4_split_extent_at(handle_t *handle,
 
 fix_extent_len:
 	ex->ee_len = orig_ex.ee_len;
-	ext4_ext_dirty(handle, inode, path + path->p_depth);
-	return err;
+	return ext4_ext_dirty(handle, inode, path + path->p_depth);
 }
 
 /*
@@ -3503,7 +3502,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	}
 	if (allocated) {
 		/* Mark the block containing both extents as dirty */
-		ext4_ext_dirty(handle, inode, path + depth);
+		err = ext4_ext_dirty(handle, inode, path + depth);
 
 		/* Update path to point to the right extent */
 		path[depth].p_ext = abut_ex;
-- 
2.26.1.301.g55bc3eb7cb9-goog

