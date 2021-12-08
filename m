Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4446CE88
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Dec 2021 08:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbhLHH4n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Dec 2021 02:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLHH4n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Dec 2021 02:56:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D3DC061574;
        Tue,  7 Dec 2021 23:53:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id np3so1338003pjb.4;
        Tue, 07 Dec 2021 23:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oAFn4ZU/tN30ZIjWJYSaUJFfhy2a59S4XTvupTyIOnI=;
        b=D+2Lt7IOPNCEAfJ/FViK7kKNChlN80hg9kKpYhzlFH8SDHSY3p4IGYx9oF+En8Xc3G
         iV1k6A5eg+yJtFsU2bf9pba8TvR+bJgXrDGKKMQwaDfp9uvEmrEoqSnV8FRJ/PHoo0wM
         c37B1arWspl4Ey5Gv2dV8i/k0VOSkJ9Obis8fSzqAXcXDR/bD/ZN3IG9KvcAWUAEerkq
         2qLIJLkL+/0my7aCpzfvAfpsXXf9N36CESTuPIvMQp1CGSiIr61LjgjPf/sZBf8M3/Nt
         4wr/pvKu8a2sxTGjhoW+a6jymH0wj7XUqmBMfXFqKkkJD+Arp9FP/oaxdHvwm71WNtU+
         KP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oAFn4ZU/tN30ZIjWJYSaUJFfhy2a59S4XTvupTyIOnI=;
        b=gx5jx49Ppfojrvzzxu1LKxPcHRwyWFfpM1novURZyj5Yv2dPMVzzUHtEriABNU0IDo
         kmPv3al+Nf85yI1DwBcNgxYVX5GrokA8oTyJysBS37+z7x8JHPbCVdC1jTYLbsKpnDV5
         4FA/dYg/BpfFBgAVJTn0VYIipFSfcEiRzq9EtHwYUehjBHxgOJTyy2ItPZbFZ9qvNCNC
         sRJEm4afwWKWapbHalb9uxC/yYjnzNaAd4q3RN729+rGr1Y9tE/jCbOrB64DlDhliswn
         4Q6s75dm5a6sGbCZWHHaLgZVDHpnkHDmwCF2xJ7Fj4nABPYH5k1SiMhcSTZRawE0W01J
         /6/w==
X-Gm-Message-State: AOAM530+zab/9xZSHaWJEMoX6Bzc+5U0sl88mtSJk+Ajrs2RPhLmlD8g
        EfVgB5V2dR8YAUTqNMJ898o=
X-Google-Smtp-Source: ABdhPJwXvaAcu0l1envtE4nsAn2aH7hn+58DNt6+dug/e/75jHtMM9rG8lqXoD/0IN98cQ0enZtAtg==
X-Received: by 2002:a17:902:cb8f:b0:141:fa0d:1717 with SMTP id d15-20020a170902cb8f00b00141fa0d1717mr57546059ply.45.1638949990318;
        Tue, 07 Dec 2021 23:53:10 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t3sm2313773pfj.207.2021.12.07.23.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 23:53:10 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ext4: Remove redundant 'offset' assignment
Date:   Wed,  8 Dec 2021 07:53:07 +0000
Message-Id: <20211208075307.404703-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

Although it is in the loop, offset is reassigned at the beginning of the
while loop. And know that the function ends, the value will not be used

The clang_analyzer complains as follows:

fs/ext4/dir.c:306:3 warning:

Value stored to 'offset' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/ext4/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 74b172a..a6bb86f 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -303,7 +303,6 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 			goto done;
 		brelse(bh);
 		bh = NULL;
-		offset = 0;
 	}
 done:
 	err = 0;
-- 
2.15.2


