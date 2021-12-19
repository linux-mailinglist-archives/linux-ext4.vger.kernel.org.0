Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE14647A08F
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Dec 2021 14:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhLSNG4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Dec 2021 08:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbhLSNG4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Dec 2021 08:06:56 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4891C061574;
        Sun, 19 Dec 2021 05:06:55 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t83so6926879qke.8;
        Sun, 19 Dec 2021 05:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9QXmoUKACc7ZSq/o6LT4XnEmMfhBC1mDucmF5H9RcU=;
        b=aup8adwJS6Fw+ol0oWiW4dUyRghu7xgSPBDmWHn8znWYtqZsOc+bQeqsx2JpVYP8Ev
         1yev6Kd7qWF/zEbexnXFsmojm50doesYr62lv9gb2s38n9i6g3nGQN5nIgvB8ppNYKMZ
         /pAp4GUeVpteX865/HXmtzMU98VuvFGqtz0YEaYuwl5LRw7hIVoAPWE7PADLb+uMhPtL
         F1b2ZUlhfFfqA0SsZAQp6EC0dQWeTCikpvmblNFksKL0qLnrsb+flNQgdx43ERdNTtyG
         frZ7Wo5edgfKPDNJGx08tqdV46insR0qi2bHnS0BvapVLTFuyaTrXVRgyhgZNhCQfEj4
         3zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9QXmoUKACc7ZSq/o6LT4XnEmMfhBC1mDucmF5H9RcU=;
        b=vMZFq3foL8GfiqRYzkMtTg5V2deBlfW+jxAacZEyzn+WOg3OE/k/MLWk2FgKJhQaGF
         qoUyLepK7Zgg2imlmIwBfZ56S6GuXAJe9EVWxU8/wgkOtZ/44q2VDcF1mAX+bGtBItJM
         QfB1IcYKihZQLwCuxWjXiSa1iu6pdnzEOYAaKgN+tRcUyJ40mYe14IC65xaa2z3MDScY
         EzN3KJQG6aR/Tizbx1O2WIdoXxGu5W5zfH2CRXSszQomhhrwH5dKNcchGy+zGm+OTeGb
         pGeJ2nv7KVhabcATL+MBkZE96D5I7KYvHQxaTUPsE1NS8ksKG99VaPWYH6WyD9G4URVX
         //8A==
X-Gm-Message-State: AOAM531T/KIso/YOy2nGAsf1/JhAbJPzJ8ga8u86/MeloE/VMIhib1Uy
        ILKC8ou1xOjR/rbDSjm6aDg=
X-Google-Smtp-Source: ABdhPJzTqMGCN7CnRzV52ioKHx4tvy/48O3vQbsg2JZ1LCp1gQ5kLg5zFzeF36jf82naQHxvb7MKiA==
X-Received: by 2002:a05:620a:306:: with SMTP id s6mr4406808qkm.368.1639919214861;
        Sun, 19 Dec 2021 05:06:54 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v1sm12152482qtw.65.2021.12.19.05.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 05:06:54 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>, Zeal robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] fs/ext4: use BUG_ON instead of if condition followed by BUG
Date:   Sun, 19 Dec 2021 13:06:43 +0000
Message-Id: <20211219130643.462943-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

BUG_ON would be better.

This issue was detected with the help of Coccinelle.

Reported-by: Zeal robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 fs/ext4/ext4.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9cc55bcda6ba..00bc3f67d37f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2400,8 +2400,7 @@ ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
 
 static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 {
-	if ((len > blocksize) || (blocksize > (1 << 18)) || (len & 3))
-		BUG();
+	BUG_ON((len > blocksize) || (blocksize > (1 << 18)) || (len & 3));
 #if (PAGE_SIZE >= 65536)
 	if (len < 65536)
 		return cpu_to_le16(len);
-- 
2.25.1

