Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C45046CE86
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Dec 2021 08:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbhLHHzd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Dec 2021 02:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLHHzc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Dec 2021 02:55:32 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEB5C061574;
        Tue,  7 Dec 2021 23:52:00 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p18so985766plf.13;
        Tue, 07 Dec 2021 23:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OugZMT2M5ZDnSu+JcYein3ciyAIl9s8J2Fw+G4vDbaE=;
        b=WZG72vIse6pieieXJfgtY6m3c4REzAHoko54lnE2THEZl3iNBw4kGeFiRZYCOoDrTA
         QGLv24VrIsj+yBHpN6gtQx23CMKoVFVVqXZIyo3saHjMdSvlSk1OX7b+bHqMpyhUga8Z
         IOEe8BEvgMQSipzbSEpxMgOHYLhPM4DBqGNG7YdBkky7MjBZamXDMJ2eLAE1OhIF/8IL
         KipdDAuLRNvxl1wR0YMl4hHsKSdwkxIldRT/ZBpjPDZVnmqab+u8SHxtqs1UEKmwnsk+
         lET3UQi4C4cMEEvO6e0fsLtaj7R0AirpEw25OmLgDfBg7ckYq6ujJOxG2S85iQbsrDpv
         DKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OugZMT2M5ZDnSu+JcYein3ciyAIl9s8J2Fw+G4vDbaE=;
        b=M+5BiVTAOXc5JYp/3/4IDwriYyTbcVloOAsiV9bl+o/e/WOJlUs4PXhbNAEktebYHf
         Amy/Qb4sYdBKZ/GtiuBJicHGxaxYqBWWUr1w+T06cb6V/YOdHWy08orDqI4/9IjI1oYP
         DYcwYe0KCvLAej+ruqEPXLh2Y7IoIWuHlVB/EdWRkRDbIO8CfWwT1UGGdVccYRjxl1tp
         ulfQkTShQ21ihKusW0PuGx9w98qavepV0jDGz8mX+oo2m6ndHMB/r3SwnD1pjpLwkgZT
         WC4Bdv6dpBDgKzMxQQc3mCJDlpmtHdSpJszF5l0iyjWGEikXj7k2TO4GXg8crAuv3Bol
         B3/A==
X-Gm-Message-State: AOAM530MbrIUxfGWTdRhNBu1sjHK8YS16k9DzslLb0Uy3o2mRsoS7Qte
        +UYKNYiuOzrx1w70TbHr0ZM=
X-Google-Smtp-Source: ABdhPJwqjN0muZvKsgEQ8OaB0heymV0D93JX4akDCaURb1Tm5etVnUPT15Mo3hPhSG1NbqNELWShnw==
X-Received: by 2002:a17:90b:1b03:: with SMTP id nu3mr5418749pjb.240.1638949920380;
        Tue, 07 Dec 2021 23:52:00 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h26sm1634548pgm.68.2021.12.07.23.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 23:52:00 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ext4: Remove redundant o_start statements
Date:   Wed,  8 Dec 2021 07:51:57 +0000
Message-Id: <20211208075157.404535-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The if will goto out of the loop, and until the end of the
function execution, o_start will not be used again.

The clang_analyzer complains as follows:

fs/ext4/move_extent.c:635:5 warning:

Value stored to 'o_start' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/ext4/move_extent.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 64a5797..95aa212 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -632,7 +632,6 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		/* Check hole before the start pos */
 		if (cur_blk + cur_len - 1 < o_start) {
 			if (next_blk == EXT_MAX_BLOCKS) {
-				o_start = o_end;
 				ret = -ENODATA;
 				goto out;
 			}
-- 
2.15.2


