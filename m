Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123377717CB
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Aug 2023 03:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHGB1H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Aug 2023 21:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGB1G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Aug 2023 21:27:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C5E6A;
        Sun,  6 Aug 2023 18:27:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso20578795e9.1;
        Sun, 06 Aug 2023 18:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691371623; x=1691976423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTU1GDTT6JTWuajDRM7B273o8a1B91B56Q8gGUC8/Hg=;
        b=rTKuVWFu5oheb7WuRc/V69yjK5woup6O82sH57tIutxy8fAsq+WPyoGhtAbAxc5f+E
         5rLiLX8g97yeZgpPIqfVxI3uc9aJMlMu1xrKS7yXlEJoUMF0Bpp9S0olEY9a9aEZsQKW
         5IX/xVWaTpthIJqiDqkptfrYY36/pyIco9pw/0EuLsOLqzu7KiSqdqgGwwig3ZnaGZEv
         I4ktwDNQLO5SD3wic6gq0IU40DxA7VD1uHe8aI1QSOONMyvyUbh6gFhROVOAjzkZZNVh
         fmEEcbIFGsud19/KMpeX4MnkBykvkDxKQMsXYFHQMqC2i8mNOdNkw4KJkTVgdNP32gkv
         /XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691371623; x=1691976423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTU1GDTT6JTWuajDRM7B273o8a1B91B56Q8gGUC8/Hg=;
        b=knX+dP8xpg7gE64WJ2wYaBBiO8w/tM76Tqhd5LbZkErJMm6nYShZ5Tfbk5afW7cRUX
         UTMBBakAn/9YJ0ItqK5sBV7RL1OI9LjTSOi0FhXj8ttvkg3Jv24lmC/QwdeP1sCb2uIP
         gyzx7x675Q6PqzJFCBhJuE6eEotECxr/WIcdW63nej3oGglVaWi9ssaw3m8jbNHV5YHZ
         YPIPHZKlE3bxAGhJyiWwClhfVhClWVtcL7rEaIu0UdNVOEWWEO+Hj8Kn9RCj8PcPCb/5
         R7O5aXuc2vn0BXvmfQZxXtr7Ibna6Dlg8/V78AmHOXX0DdmYImhNP+Nr/3RU6Oqx7vPt
         s20g==
X-Gm-Message-State: AOJu0YyWfs89WR7SXxLbJQ4dHQbcTjKxIL+m3pZuYo8fHQFp56jbuSnl
        4k8riw9LxIixDFy9npF9kxs=
X-Google-Smtp-Source: AGHT+IGzieKTvBRh5j6RN6lP7vs1Y3AJx30fgDJ+FpM49/9beGTnPOLfx2rZGZfeGdthiWS9fExD+g==
X-Received: by 2002:a05:600c:2159:b0:3fe:1967:447c with SMTP id v25-20020a05600c215900b003fe1967447cmr6290213wml.9.1691371622860;
        Sun, 06 Aug 2023 18:27:02 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c231500b003fe21c7386esm13393485wmo.45.2023.08.06.18.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 18:27:02 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] ext4: Modify the rec_len helpers to accommodate future cases
Date:   Mon,  7 Aug 2023 09:26:54 +0800
Message-Id: <20230807012654.55951-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

Following Andreas' suggestion, it is time to adapt these helpers
to handle larger records during runtime, especially in preparation
for the eventual support of ext4 with a block size greater than
PAGE_SIZE.

Suggested-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
Link: https://lore.kernel.org/lkml/A9ECDF14-95A1-4B1E-A815-4B6ABF4916C6@dilger.ca/
---
 fs/ext4/ext4.h | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0a2d55faa095..87cdf4d56da1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2386,39 +2386,41 @@ static inline unsigned int ext4_dir_rec_len(__u8 name_len,
 }
 
 /*
- * If we ever get support for fs block sizes > page_size, we'll need
- * to remove the #if statements in the next two functions...
+ * The next two helpers facilitate the conversion between the encoded
+ * and plain forms of rec_len. Try to access rec_len through these helpers
+ * rather than accessing it directly.
  */
-static inline unsigned int
-ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
+static inline
+unsigned int ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
 {
 	unsigned len = le16_to_cpu(dlen);
 
-#if (PAGE_SIZE >= 65536)
+	if (blocksize < 65536)
+		return len;
+
 	if (len == EXT4_MAX_REC_LEN || len == 0)
 		return blocksize;
+
 	return (len & 65532) | ((len & 3) << 16);
-#else
-	return len;
-#endif
 }
 
 static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 {
-	BUG_ON((len > blocksize) || (blocksize > (1 << 18)) || (len & 3));
-#if (PAGE_SIZE >= 65536)
-	if (len < 65536)
+	BUG_ON(len > blocksize);
+	BUG_ON(blocksize > (1 << 18));
+	BUG_ON(len & 3);
+
+	if (len < 65536) /* always true for blocksize < 65536 */
 		return cpu_to_le16(len);
+
 	if (len == blocksize) {
 		if (blocksize == 65536)
 			return cpu_to_le16(EXT4_MAX_REC_LEN);
-		else
-			return cpu_to_le16(0);
+
+		return cpu_to_le16(0);
 	}
+
 	return cpu_to_le16((len & 65532) | ((len >> 16) & 3));
-#else
-	return cpu_to_le16(len);
-#endif
 }
 
 /*
-- 
2.27.0

