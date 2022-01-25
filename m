Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F153249B49F
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jan 2022 14:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356924AbiAYNJ2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jan 2022 08:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575400AbiAYNGc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jan 2022 08:06:32 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0DEC06173D;
        Tue, 25 Jan 2022 05:06:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a8so30671707ejc.8;
        Tue, 25 Jan 2022 05:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Q9F+q0/TLyS+E8+5mcRHC2ALC+2ECyiJKhCjldFoyQ=;
        b=qeNpQryaJSZkv6oFYyyu6xECY6B+hZE02SaR6nFDy4M7zcbxGxfS0JeHLeg+o3LIIv
         h8+gu/xA29v45wEf96sOwUNQdfuJ3TKGLcOGCmQuyMBZzZw1Ld7AQhDwhjJt0Rnapb2q
         YRcPUgSyv4YIqh7/pDqfAwjabqgoHk9WGJhtJT/VF7KR0lD+3EWoULiZxpAoTZfcgqRK
         81sjnzwJu0qhXddSY1Mau67+WXPsFxvxlMczmNSGplm2mvP/R7zSpsI/UXmAYvad/PHt
         NHKT4+Z9beHi6Kqfc848dCbencguviOUHjQ8SX0gYE3w5fOhHsa4e4RiCOoT61JXliA8
         xVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Q9F+q0/TLyS+E8+5mcRHC2ALC+2ECyiJKhCjldFoyQ=;
        b=BNM6YaYJtkkDMG8NsHVVAiD2OE1Anj1KswyUYVtrkXYLmL4/vC/OmvNQ6JJqTijY7m
         967TbimfB9rX0f8Xqb2XGuHiO15WPlKZHayX0FtRHABQx73BjvyNJm0xAZOyVckOH5cS
         /NU0Vhs9cPZo18XyapqEbO6O4/+UjK8JVEF7gX2rSrGXJ3Fcn4lNeAZZBxLTLWwERv0s
         mzhhjZy31JJPY04DBe+p3/jO/N4Qdn4Ul4IWguztQJDyA3iCLLHaX/stUzcj93AbEyVZ
         MVe5gDiCxtQlobeAcYaUmP6vj36NmGE6AEktOTYd7+SMV0lB1Bt+YjQTjPWfqb8gJPDW
         e4gg==
X-Gm-Message-State: AOAM531taq6y5h/CmmnF7qIKbwSSY5yKprKY9HpMG7hLj0zipVvciPRo
        1cgL/BLvBN9oTj47Ki6D2Hk=
X-Google-Smtp-Source: ABdhPJwoRzFVTguML2rTMAY7ZgBAghOts/1lYJ8v33w3G4lY2SFooPfJDA9aOjwBTxPgK8CdA4k8FA==
X-Received: by 2002:a17:907:1c9f:: with SMTP id nb31mr9579454ejc.24.1643115987833;
        Tue, 25 Jan 2022 05:06:27 -0800 (PST)
Received: from localhost.localdomain ([39.48.168.136])
        by smtp.gmail.com with ESMTPSA id f3sm6163971eja.139.2022.01.25.05.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 05:06:27 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        amhamza.mgc@gmail.com
Subject: [PATCH] ext4: handle unsuccessful sbi allocation
Date:   Tue, 25 Jan 2022 18:06:04 +0500
Message-Id: <20220125130604.26473-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Move to common fail path in case of unsuccessful sbi allocation

Addresses-Coverity: 1497833 ("Unused value")

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
---
 fs/ext4/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 57914acc5402..0dccf1ed931b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5540,8 +5540,10 @@ static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
 	int ret;
 
 	sbi = ext4_alloc_sbi(sb);
-	if (!sbi)
+	if (!sbi) {
 		ret = -ENOMEM;
+		goto free_sbi;
+	}
 
 	fc->s_fs_info = sbi;
 
-- 
2.25.1

