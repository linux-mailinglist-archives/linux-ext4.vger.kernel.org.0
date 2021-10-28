Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9DC43D972
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 04:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhJ1Cqx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 22:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1Cqx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 22:46:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162F1C061570;
        Wed, 27 Oct 2021 19:44:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id l203so4598191pfd.2;
        Wed, 27 Oct 2021 19:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEsLSNdVmWcSfQ9hSR87s8qtaAxlNOAAVBS6V75PalE=;
        b=GwdSfqo6VoDPBur/hKuv5nH8+7ayRCkqTexxpZ+ClfV12txPKxxY+eCT8d04vz/Gr9
         RTj4zSz327ErVCbnZSSOwb9ewPAB9BOL6A7nMEoIpoa847YfZWwpd5sscdbC66BoWjQi
         DDI1LSFOzcAsq0FusLj8jpE62c4NN+bzZM2MqFZXNjzfopdoTGkitk5KbKc8+f3s+m9j
         AXFeBdlrUHSMfD/aLqFdRD3v56vAU2Vt1/0r168GKaZMkJ69WYjBfYU4viBIzE61SGQk
         bFpOe5QA/q6VWsbsXTvfSP/WkZtThQtncVIoBiheFGdE5os6rHgMeinjW25G6UP0j/AM
         gBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEsLSNdVmWcSfQ9hSR87s8qtaAxlNOAAVBS6V75PalE=;
        b=huNAD3bgk5UlGzW3dtBUi9z59R4KQ3ZEqNVaT/Kn85nEVrA71fVi+mJbxtJp6ctSwI
         NzLqHZjLyikVAAiAOg0KyADad0shwfe3YfjBfVgXUJn0NlLzyuhiZeUGAWiIEttKFoDX
         NK0EHuHskPKSIpFaX4fGP/tiR14/PfW9GlNkSInU/iRvVstfcYbwQPOoZy2uViajU0tB
         Z69y7zq5PgIr1Q6tuA3kSttE8ZW6RjwC/DpY3HdjhWfIR68qUZbt0DSNOnj9OSOEK8Sk
         70tWv8egnKbFWOJVCKgVw0J0BDou46GCGhhj6CkC82w2Lv/HYZroIJG4x/yfNHvo8Imo
         VW0A==
X-Gm-Message-State: AOAM533rXXzTBFyFB7UyRq8UUnbVjN8EiErQtBacyYbmPaIkU2Np4AM2
        OcvCXURS2Bk+jyLIaRmJ8+s9kza1BZw=
X-Google-Smtp-Source: ABdhPJwE7wHS2rj+V0j+dlA6X7OHlApTfuaPKSmONFG23c5MVuubmYHviP1oEO6Q9gBnUDEuZTb4uA==
X-Received: by 2002:a05:6a00:2181:b0:44c:f4bc:2f74 with SMTP id h1-20020a056a00218100b0044cf4bc2f74mr1590805pfi.68.1635389066615;
        Wed, 27 Oct 2021 19:44:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id me18sm962909pjb.33.2021.10.27.19.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 19:44:26 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ext4: Remove unnecessary assignments
Date:   Thu, 28 Oct 2021 02:44:22 +0000
Message-Id: <20211028024422.10471-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The assignment at the end of the function is not necessary

The clang_analyzer complains as follows:

fs/ext4/mballoc.c:3889:3 warning:

Value stored to 'err' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 089c958..f1258a7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3886,7 +3886,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	if (err)
 		goto out_err;
 	sync_dirty_buffer(bitmap_bh);
-	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
 	sync_dirty_buffer(gdp_bh);
 
 out_err:
-- 
2.15.2


