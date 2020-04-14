Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC41AA941
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636349AbgDON6L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633783AbgDON6I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 09:58:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542B2C061A0C;
        Wed, 15 Apr 2020 06:58:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g12so11354973wmh.3;
        Wed, 15 Apr 2020 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYcapwzeMColCF8KnFlRv/qYBOctw6ROjcF5rd7fgio=;
        b=BIt+S2KEHsJrN+2c/rX9t0sOuPITtIttaQUX75Y/fkAHbIiDffpG5iIYLP9bDrlR9s
         AzDFJkC1m9YTrni0GQjXHE1k3TgziQ8wxetjO0ToSUZoT9tFoycIkxNBL0ozicaZmGzu
         2Mv5UG0V0MAjsPkCJrJvhiJT9oFVmThFZrmSjJ8UK8+qX5pEb2DpP0DSfAt+Hq3GKmLo
         AR0k6NM2aodFiPLuw8X146A9Bbw4OwrmCvikA+guFD7asFNyA+Ngev6GXzorE2t1Qh6Y
         yKVzUiO8UysDxpZi8GODv84vGgv4pZnc1Tn2r2jCT6xByTf+TeLHE8oKo6RcKCDhxXDb
         7VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYcapwzeMColCF8KnFlRv/qYBOctw6ROjcF5rd7fgio=;
        b=P3De8fdfJ4H0UCmlMruj5z7WaOt9wbX9WPkyLmxeDJjFkFNchi4nb6Em7maZusszaL
         sPxXbZktXajZ919D/ozFQRi+qa1/nVTxkwX8B8CmOjvdWUHlUNtHwAuEJEzV0OKafIfS
         EgRc8IyNni1qJ0gzoEVdKzBt3TadjJH3NgvuXeutJNtyajkSgFzlH1o/RbO2Y0J6yzq5
         /P6ClxEFu3Qse6UKVZtw4sK0mybK8sN1XzUq6auSf0riWa6FbxvKVN3+fz4C187obfZp
         5SlasYxXmwKcFgntKNJ2OR5kYFfPBejeRiKMQ2ZfODZOypCoLUcOrAa6G4J7SHVY5/WC
         I/Dw==
X-Gm-Message-State: AGi0PuaRfFCWiuEcM1TXev7giw12VanhgN3gfqY6h0r+XWLwptejRFu3
        NUKGYNBL7DLnGzr6+zJRm8k=
X-Google-Smtp-Source: APiQypJhlZ6btS19pDdt1lNNHSlFGGLyu5Zv/UQ9xrb4s2/qeAcuFoN8i+UqcT8dwvZgZ+r7Le2zZg==
X-Received: by 2002:a05:600c:210c:: with SMTP id u12mr5579723wml.135.1586959086949;
        Wed, 15 Apr 2020 06:58:06 -0700 (PDT)
Received: from localhost.localdomain ([31.4.236.56])
        by smtp.gmail.com with ESMTPSA id t8sm23355590wrq.88.2020.04.15.06.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 06:58:06 -0700 (PDT)
From:   root <carlosteniswarrior@gmail.com>
X-Google-Original-From: root <root@localhost.localdomain>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Carlos=20Guerrero=20=C3=81lvarez?= 
        <carlosteniswarrior@gmail.com>
Subject: [PATCH] EXT4: acl: Fix a style issue
Date:   Wed, 15 Apr 2020 00:54:14 +0200
Message-Id: <20200414225414.70014-1-root@localhost.localdomain>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>

Fixed an if statement where braces were not needed.

Signed-off-by: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>
---
 fs/ext4/acl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 8c7bbf3e566d..b3eba92f38f5 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -215,9 +215,8 @@ __ext4_set_acl(handle_t *handle, struct inode *inode, int type,
 				      value, size, xattr_flags);
 
 	kfree(value);
-	if (!error) {
+	if (!error)
 		set_cached_acl(inode, type, acl);
-	}
 
 	return error;
 }
-- 
2.25.2

