Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BFC57C40D
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 08:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiGUGDD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 02:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiGUGC6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 02:02:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5157AB00
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:02:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d10so823672pfd.9
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnygQSSP2aOqCpGFs0AW4rqi/kwZHcwdU9jLes7G+zo=;
        b=feeVCLN7Z9AjuQFIQR/jsGFMqWc2mncPmgmhgz3N5FDwryrKSHnsD3+hUOxBqqKi0W
         wi8xi8iLpji5dl05j7Br4Ds/sSIPXIjarYBEVoamuXz8hKl2G5/hkhKu+fh+69XkkPLj
         /Q3PcbKwUps+R0Bjg5g96VIUsNsfgEJuPSF54ad/B4xH6KzvwbAuut1KvUAH+ObuzEps
         EH6WkswwIDZ5K6ZnO6AxfGQ4/a9o/7Diwhb11hBwbH3C3Qcb7PVPyE3Sb/d/KclQFrN+
         RR0yRQ+E6WdjeutHmZpjTeBG83nTnINGM2lQf/ANcumpd/OuRq58Tdkbs5mzQvPJqXle
         EfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnygQSSP2aOqCpGFs0AW4rqi/kwZHcwdU9jLes7G+zo=;
        b=a6yRbjFsVLxUb8Ve7qpYDALaXO7KPPVyHPf16f8tR+f5snao7JxK24241VO4MLdCrk
         1hIXPZj7Q/mZNTw/nN0qcWOygWfDqOiXZM9X4wVwqwA2JIDuXEswBdsE7JTP8GsK6sZg
         E46kmq3iDjxcjFJR6Sf1eSZZmxO9gH9JgQESVb+78xarWiEGmHB9N+lEhsI2KHueQYPA
         gZuTI7iapO9iaKMGxLAHW8ZNWrCuT+9tFfRSPCUNwnCdLEhBr76QSNEiLm47basx8v+s
         oAw7H80NFnSl5a3fVuul98o/eTUUbHvbkFUg7sdWuLH5BCoqIxdxgt38gGG9ezVv2CFs
         iv7g==
X-Gm-Message-State: AJIora+s1C7cDMc0Y4FjGrqJs8H67Psd01aV23SpnqLj9TdZUlv9F4DJ
        tMdMMmsa5I3KIyK3D6SZxrW95HuxEZBckA==
X-Google-Smtp-Source: AGRyM1uExJxv3C8i0jWmTZPjo1R8upvj8ijwT67rgSXvSsuExU6teEGT0yitnrtqLJ1C/9AUGtZqJw==
X-Received: by 2002:a05:6a00:10ca:b0:4f7:5af4:47b6 with SMTP id d10-20020a056a0010ca00b004f75af447b6mr42869771pfu.6.1658383376526;
        Wed, 20 Jul 2022 23:02:56 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.googlemail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm9105377pjb.2.2022.07.20.23.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:02:55 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v4 3/8] ext4: use extent status tree in fast commit path
Date:   Thu, 21 Jul 2022 06:02:41 +0000
Message-Id: <20220721060246.1696852-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
References: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch moves fc commit path to use extent status tree to lookup
logical to physical mappings. In order to preserve the uncommitted
entries in the es cache, this patch makes all the inodes on fast
commit list as shrinker ineligible. Making the uncommitted entries in
es cache to stick around is left as a future enhancement.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/extents_status.c | 3 ++-
 fs/ext4/fast_commit.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9a3a8996aacf..07fb86746534 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1500,7 +1500,8 @@ static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
 			continue;
 		}
 
-		if (ei == locked_ei || !write_trylock(&ei->i_es_lock)) {
+		if (!list_empty(&ei->i_fc_list) || ei == locked_ei ||
+			!write_trylock(&ei->i_es_lock)) {
 			nr_skipped++;
 			continue;
 		}
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 4d2384adcbb0..916f62cfa7f7 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -951,7 +951,8 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	while (cur_lblk_off <= new_blk_size) {
 		map.m_lblk = cur_lblk_off;
 		map.m_len = new_blk_size - cur_lblk_off + 1;
-		ret = ext4_map_blocks(NULL, inode, &map, 0);
+		ret = ext4_map_blocks(NULL, inode, &map,
+			EXT4_GET_BLOCKS_CACHED_NOWAIT);
 		if (ret < 0)
 			return -ECANCELED;
 
-- 
2.37.0.170.g444d1eabd0-goog

