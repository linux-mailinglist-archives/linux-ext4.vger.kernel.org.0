Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D00444EF1
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Nov 2021 07:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhKDGgw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Nov 2021 02:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhKDGgv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Nov 2021 02:36:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AADDC061714;
        Wed,  3 Nov 2021 23:34:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t7so4578792pgl.9;
        Wed, 03 Nov 2021 23:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVs7hCNESgtkJ7TW5K8/Az50gsR4i8jkMKjnlhtlNV8=;
        b=gcvDCi40sf7uqwerM6sDKKBs1tb6aD8/m3Tl+EFRLFFpwwUIsfIM8ePKDXH3wM5vPs
         wQnGABoB58Yj9m8EH7caHmat+O1R+/jeOfjbvccxC1osEDn8OtN7pchfrA2CiQyGh1ec
         PcvkD9OzU1D+WCoX0uTqKnqRQMB6w7izBWdjV+9aIXt84nuEH8KlZz297vUtoSz/maek
         xr4hTbZmCxO/sVvohKSUffy1G72gjFI/LtqPlxYy6QI2abTU/GNUDgDAvX+Z6mfi7UZN
         hudk7NhumjPZ6A3OnGATcEnO1ZU69VB/BILV6Byv9iLKgGIUY6DJkdPquCRrbQvIJCdY
         65OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVs7hCNESgtkJ7TW5K8/Az50gsR4i8jkMKjnlhtlNV8=;
        b=d6E1+jobd+DePMfNXcfccpHWOjcTn/N2T5SgYpfmT0eaKTTy/2L2+GfIoTieryRUY8
         feHE7jQZu+7oYzYAVLytP1svyJhE/wvwV/sAbCSbmnRrgk6u3qEi9aH5xGpx6NVTCAei
         6c+0cEhuR0lOHerBooIEejCExTzuJMDHa+Uy0JC3Z8G1qNhIYfkI+RKupaWq59kzf5Ve
         LE12ip9PI7zEF8o3pQ3yl+yld6CHZr2uPqa9DX3xUYiecuHbV56HKa/DOzxdv2PliEfw
         XevrOl34xe+7y7sgUNUx1cbeYvA8gTsikwkgMuH6DC6jInu8AwENINSwfmQxrB6vW3EK
         xAtQ==
X-Gm-Message-State: AOAM531U5Ap5qNdHRiONK7oUptP/mzBO3a5lH6rF6tShyKmcDiz/BIkM
        PgRduOmuS5mM/hkMW8Dmec0=
X-Google-Smtp-Source: ABdhPJxh6lMN/lXFGH2WKKCSwQp0DVvZUCazN1xQskScoyl99C7HsaeCJtVFlONM/oxwft+PA9y4BA==
X-Received: by 2002:a63:e906:: with SMTP id i6mr10844391pgh.223.1636007653720;
        Wed, 03 Nov 2021 23:34:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a2sm3366304pgn.20.2021.11.03.23.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:34:13 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] ext4: Remove redundant statement
Date:   Thu,  4 Nov 2021 06:34:06 +0000
Message-Id: <20211104063406.2747-1-luo.penghao@zte.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The local variable assignment at the end of the function is meaningless.

The clang_analyzer complains as follows:

fs/ext4/fast_commit.c:779:2 warning:

Value stored to 'dst' is never read

change in v2:

Repair the sending email box

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/ext4/fast_commit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 782d05a..9e5bfa0 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -797,7 +797,6 @@ static  bool ext4_fc_add_dentry_tlv(struct super_block *sb, u16 tag,
 	ext4_fc_memcpy(sb, dst, &fcd, sizeof(fcd), crc);
 	dst += sizeof(fcd);
 	ext4_fc_memcpy(sb, dst, dname, dlen, crc);
-	dst += dlen;
 
 	return true;
 }
-- 
2.15.2


