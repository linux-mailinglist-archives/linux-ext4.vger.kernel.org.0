Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7DE6589FC
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Dec 2022 08:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiL2HgQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Dec 2022 02:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiL2HgO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Dec 2022 02:36:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E0A1B3
        for <linux-ext4@vger.kernel.org>; Wed, 28 Dec 2022 23:36:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id u19so43232017ejm.8
        for <linux-ext4@vger.kernel.org>; Wed, 28 Dec 2022 23:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOPQSS6Hsn3cL89atHIpW7kEuDl/3t9vergh9VYT+sc=;
        b=S+ps5CmLqwr/Xz4rE5u/2pIaW/ZZvxedP5p+R+NbE+18KQpDfKdxgMr3jr7LeSPbGe
         rp2dXhXiQcCpQaCA0tlSvycZfnFZY6iO3xfE3pVxHCNov36d9IrrEIRTFZlK/8+MBT/3
         ZiibsNsBTY8b/kFOosBBdALAhitdpkJlsbj7AymQ5r2sdabE2QG44Y6TrSJJputmBsj8
         3ZCeHWmo9b476JEId40a9aowmCgxrSVFlpfT8cmrcV+R6myayn0TpTEpzXumWZXXNJgc
         BVn71Yx05oe24euts+WqqZtcDTXDoGZ0xeDBoe1lArRKZTGgn/yaE6hRC77LssYNoMlV
         dtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOPQSS6Hsn3cL89atHIpW7kEuDl/3t9vergh9VYT+sc=;
        b=k9AbKel22ZY/ELaE4RVZKGerlGEztkgDRsVkXU0I6Hdd7zhLWuanGKPiEl0SjBWWJe
         Ec9la/BrQO/XswUVVQr5ZqkEwYqfTjXmnBexaFbOqgxqdKNMdZ02O2xWb9cWObj0w6i9
         bTL1yWmM2Rd0CAj55G98uo305hedJl8iOMuM64gTTFiN4nbp+keF7HfM/erlxMCG5X/V
         uHqSJiqek8b7X3O810KOaqnk7pINzy2TdlzOW+P2L8L6kWblsQZxiajgPczXwDGfSExh
         zxLfgmOQSE3yO9AAaRhi6Tey+YpbJ5ELRg7KDqwoeJ0pwUZLrqC/keLae+nn+0gX/uId
         6KCA==
X-Gm-Message-State: AFqh2krIOOJ5coe6AiJEgYO81Mf4Au+vMAwfbEqyx1HVx7yA6FTEWIzk
        B0GrxYarvafjb2zzQ1mWA031zg==
X-Google-Smtp-Source: AMrXdXtO1Kw8WEPKqZHakTcOZMESiMhUhyy2kWsmYy5d7WJCcPSEVwB3N8EsDIv0moeRPY7PcHfmww==
X-Received: by 2002:a17:907:a641:b0:7c0:f7b0:95d3 with SMTP id vu1-20020a170907a64100b007c0f7b095d3mr24201413ejc.36.1672299371836;
        Wed, 28 Dec 2022 23:36:11 -0800 (PST)
Received: from alba.. ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906375700b007bfacaea851sm8257227ejc.88.2022.12.28.23.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 23:36:11 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>,
        syzbot+0827b4b52b5ebf65f219@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH] ext4: Fix possible use-after-free in ext4_find_extent
Date:   Thu, 29 Dec 2022 09:36:06 +0200
Message-Id: <20221229073606.1711522-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; h=from:subject; bh=ozn4/3c6BH3tEwopzFLFiUT4O3mCv0whIEyzGO8SD54=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBjrUNm+UbZUz/4yX3T0+kWROON1EnY75LtseUXq2Px bLA/ZeSJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCY61DZgAKCRBLVU9HpY0U6Vv1CA CrhpwnnraHxvBpPGvLmTDq6IFCKLcCtWG8pyhMp/20EsZWd15qez4497beNIc6t7l4nS8kycqWaHuI hUaeAUZZn8TZ7uzrAmshCs0nXWRDRPn26/fPDE2n92EVfwoiKjZP93Ebt2ENGFT0Qptn+KMV85mPXt inxcxO9wJwDcRpA8+JxjpZ2qZudc5to5VEUK/KHkkFai7mCatuWtQ+FPtY9SRVzwAYU8gZ39DCBb4z bgwclTxhC/rE2uy8bgHpeuyIrqM5dj7iI1mtEiNQTtvSy67kjpqXyzKVo4LH1EaUXFog8rWE1XmRM8 oNMu5jt7Pb/R9NvnmQCmn+OKgGWThg
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot reported a use-after-free Read in ext4_find_extent that is hit when
using a corrupted file system. The bug was reported on Android 5.15, but
using the same reproducer triggers the bug on v6.2-rc1 as well.

Fix the use-after-free by checking the extent header magic. An alternative
would be to check the values of EXT4_{FIRST,LAST}_{EXTENT,INDEX} used in
ext4_ext_binsearch() and ext4_ext_binsearch_idx(), so that we make sure
that pointers returned by EXT4_{FIRST,LAST}_{EXTENT,INDEX} don't exceed the
bounds of the extent tree node. But this alternative will not squash
the bug for the cases where eh->eh_entries fit into eh->eh_max. We could
also try to check the sanity of the path, but costs more than checking just
the header magic, so stick to the header magic sanity check.

Link: https://syzkaller.appspot.com/bug?id=be6e90ce70987950e6deb3bac8418344ca8b96cd
Reported-by: syzbot+0827b4b52b5ebf65f219@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/extents.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9de1c9d1a13d..18367767afd7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -894,6 +894,12 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 		gfp_flags |= __GFP_NOFAIL;
 
 	eh = ext_inode_hdr(inode);
+	if (le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC) {
+		EXT4_ERROR_INODE(inode, "Extent header has invalid magic.");
+		ret = -EFSCORRUPTED;
+		goto err;
+	}
+
 	depth = ext_depth(inode);
 	if (depth < 0 || depth > EXT4_MAX_EXTENT_DEPTH) {
 		EXT4_ERROR_INODE(inode, "inode has invalid extent depth: %d",
-- 
2.34.1

