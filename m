Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFBC43D976
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 04:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhJ1CsV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 22:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1CsU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 22:48:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB5BC061570;
        Wed, 27 Oct 2021 19:45:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y1so3366479plk.10;
        Wed, 27 Oct 2021 19:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k671jy55aAjTwOUFEu6Ybl7LDuykLg505zNZ5vzETDE=;
        b=b1gADUShXKoQv+I8r67Qn+dQQsPFZHfWIz+UlquQidqrjT2rCXEF2Xoa5ukWLGG7sJ
         3VsEuy/ohf3bZlsfo0ZOpghtM/eTH6szVNJyzjz9d5PwtWz/9OsVuU2defylgowsGa3p
         D/Vt2fmS+9M4K9JNKx8PnDdOFAraOFN2zdMXYJtjE6kd5+SLs9r7qLB8AnMLiQYOo48d
         4XxFGifPHpwuHupkYpuwaOn30APOqf+6c+VwzBSdvv42tzqU6n2n3VPHpHGLZTi+LhMC
         +bd1TfZbslhunklSxMBjKYT9lB2NVDPHlZeISIcUg54Dh9oRVxvBK14j6zOyGFyPaYFE
         GVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k671jy55aAjTwOUFEu6Ybl7LDuykLg505zNZ5vzETDE=;
        b=Va6lHUpX8Zhj4evJCpCJI8D0ioQ9xpdvuZTjlYTjcDEbDSyHcYCVTLeqF3Gb4RD89Y
         +tsYAo5zErdUQVGpRceak/eYWr0Hj1CbAeRngVenPgYXOklUjlyGH5ORw6SvSUGihXq1
         eJz+w1N8IR7Mf0z1dGhK8Zm0/2yrbvaLGea672atgMgCGlgC2pJNtjvVt+ZHblWksur+
         lT3ZPqYeEb8+70vY6aJ3sSMAHFlym9icu7loTC1Gsc8hGwUqYJQjYQSDesK8dpcPlJDQ
         t3QtxS5YEjLIYekHvReu8eT796paMBbijVDDZbNcHOHCA6jvVGAU/p2B9CgF+wXO5bnr
         V4Cg==
X-Gm-Message-State: AOAM530aFskbcbsd6yk1hMxJtv6ibRYJZ4yRglMAr/8nV0/wGSmuUrzO
        WF/nSAAouQ9MRkpV1tWMJcI=
X-Google-Smtp-Source: ABdhPJwKdGEockc5VUCpIVYx3Bhlb1VTKggvXNnqyN6pau4ZIITZzXgUrB3IgGw5Qf55d/iWwYXnZw==
X-Received: by 2002:a17:902:8ec5:b0:13a:2789:cbb0 with SMTP id x5-20020a1709028ec500b0013a2789cbb0mr1274658plo.60.1635389154237;
        Wed, 27 Oct 2021 19:45:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j8sm1233912pfe.105.2021.10.27.19.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 19:45:54 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ext4: Remove unused assignments
Date:   Thu, 28 Oct 2021 02:45:45 +0000
Message-Id: <20211028024545.10540-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The eh assignment in these two places is meaningless, because the
function will goto to merge, which will not use eh.

The clang_analyzer complains as follows:

fs/ext4/extents.c:1988:4 warning:
fs/ext4/extents.c:2016:4 warning:

Value stored to 'eh' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/ext4/extents.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b1933e3..9ed8a15 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1986,7 +1986,6 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 					+ ext4_ext_get_actual_len(newext));
 			if (unwritten)
 				ext4_ext_mark_unwritten(ex);
-			eh = path[depth].p_hdr;
 			nearex = ex;
 			goto merge;
 		}
@@ -2015,7 +2014,6 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 					+ ext4_ext_get_actual_len(newext));
 			if (unwritten)
 				ext4_ext_mark_unwritten(ex);
-			eh = path[depth].p_hdr;
 			nearex = ex;
 			goto merge;
 		}
-- 
2.15.2


