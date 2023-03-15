Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F6C6BAF1E
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 12:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjCOLVX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 07:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjCOLUl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 07:20:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDD25956
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:20:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id by8so19035050ljb.7
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678879218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcQzXxRlB4R8bjUx2JPwloCJknWzyZI/8Ri1y7i2H+0=;
        b=SUZ73EPhQzBmnB9wlCxQPgnzUTUs98qCj9QX1OTzyNmQB3KpC1WGqlH/YZKJLWaLiU
         9WQCPY7lrAKNmhFm/7qhhWUGl+8oH1lucjZAjDQ7jMrb5h7QiGoi2Ja6/aXs/fTa/udo
         sTBwcnlxvAT0cj+EWa4lxtYsnlzQNpZ0ZW7CpFySnpgtls6hTiMfa2TRP3rxosD0nCAx
         mjxd+kSK5IGKGjfbF7wRFHYTW95XDjaUr3MtBKMlVrcNcl75LPoo5Mmyo35/2NVVU5JV
         /Mz3k+GOJPyysu2JMBKHukfAIjX9KWcKlDOHyHKnTZu1eU2+9lh+KKDfDpuelM+xkpFc
         iDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678879218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcQzXxRlB4R8bjUx2JPwloCJknWzyZI/8Ri1y7i2H+0=;
        b=dKlQ8V5fqLWDjhnjObbOg7zuy3Uh4ZhPS8dIiqJU6HFC+PMM1bPMUQTmLhPIbn1Vj/
         kv6LtRrc0oLSjxgWoliAfVyQlQlRRB9q/xCc2ZK8UXC7X11Ly46AnCcSUbstoy2J0ncP
         GfLs2cSzxG42cHhMWnp9/IUdKQHscLFNrPh2h5G2ac8Ad71UNSjZWr9d87d0wJeQSKIJ
         1nA70PFiyWyrCN0pVgnCx9z7Bst37TOpFLnTxGrl/cInOLGx6GyLucCAQ60Oh8BvhG1u
         zl7AVIVNZqq/ZWHIMuoY0cUAZ28vvLtobjaRXAiH6F2jw4fQHWuRfQ71i1Ss01aCwhx4
         oKAw==
X-Gm-Message-State: AO0yUKWv9zvCG8GwZ4fljBa19DxIAsc3ekV45MzdHWzKCIF+ROqnoWEZ
        TKxpkIuFRo/EXfClcVnrY1s0IQ==
X-Google-Smtp-Source: AK7set+dSPQUBEC2PZNxPjdDMKR1xAxJO7NIAsPa4q7mhxsTIDizU4SC6Lvmt+PVU4YiiEgYm/J5wA==
X-Received: by 2002:a05:651c:504:b0:295:ac00:2f2d with SMTP id o4-20020a05651c050400b00295ac002f2dmr974108ljp.10.1678879218731;
        Wed, 15 Mar 2023 04:20:18 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id k2-20020a2e92c2000000b00295da33c42dsm817410ljh.15.2023.03.15.04.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:20:18 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        djwong@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        leejones@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 4/5] ext4: fsmap: Do the validation checks on constified fsmap data
Date:   Wed, 15 Mar 2023 11:20:10 +0000
Message-Id: <20230315112011.927091-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315112011.927091-1-tudor.ambarus@linaro.org>
References: <20230315112011.927091-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now that we do the sanity checks directly on the data copied from user,
we can also constify the fsmap data while the checks are in progress.
Do the validation checks on constified data, it imposes that the fsmap
data is not updated during validation and assures readers that nothing
strange happens during the validation sequence of calls.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2: new patch

 fs/ext4/fsmap.c | 8 ++++----
 fs/ext4/fsmap.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 463e8165b1e9..655379c96fcf 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -572,7 +572,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 
 /* Do we recognize the device? */
 static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
-					  struct fsmap *fm)
+					  const struct fsmap *fm)
 {
 	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
 	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
@@ -584,8 +584,8 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
 }
 
 /* Ensure that the low key is less than the high key. */
-static bool ext4_getfsmap_check_keys(struct fsmap *low_key,
-				     struct fsmap *high_key)
+static bool ext4_getfsmap_check_keys(const struct fsmap *low_key,
+				     const struct fsmap *high_key)
 {
 	u64 l_fmr_phys = low_key->fmr_physical + low_key->fmr_length;
 
@@ -607,7 +607,7 @@ static bool ext4_getfsmap_check_keys(struct fsmap *low_key,
 	return false;
 }
 
-int ext4_fsmap_check_head(struct super_block *sb, struct fsmap_head *head)
+int ext4_fsmap_check_head(struct super_block *sb, const struct fsmap_head *head)
 {
 	const struct fsmap *l = &head->fmh_keys[0];
 	const struct fsmap *h = &head->fmh_keys[1];
diff --git a/fs/ext4/fsmap.h b/fs/ext4/fsmap.h
index e7c510afd672..8325258def7b 100644
--- a/fs/ext4/fsmap.h
+++ b/fs/ext4/fsmap.h
@@ -33,7 +33,8 @@ void ext4_fsmap_from_internal(struct super_block *sb, struct fsmap *dest,
 		struct ext4_fsmap *src);
 void ext4_fsmap_to_internal(struct super_block *sb, struct ext4_fsmap *dest,
 		struct fsmap *src);
-int ext4_fsmap_check_head(struct super_block *sb, struct fsmap_head *head);
+int ext4_fsmap_check_head(struct super_block *sb,
+			  const struct fsmap_head *head);
 
 /* fsmap to userspace formatter - copy to user & advance pointer */
 typedef int (*ext4_fsmap_format_t)(struct ext4_fsmap *, void *);
-- 
2.40.0.rc1.284.g88254d51c5-goog

