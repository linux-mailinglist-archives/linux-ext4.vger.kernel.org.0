Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9B63207F
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 12:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKUL0r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 06:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKUL0Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 06:26:16 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E81DC0517
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 03:21:50 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id v14-20020adf8b4e000000b0024174021277so3112278wra.13
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 03:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5wrCbW2TNaYb01/tuYYFENHET5JL1U7hc5fWA+Xdi0=;
        b=sNA18t3VIhj8s/MCrsotPK65Vcuz2YR1Xj8oe9nNH5vPzwm6iPZt2X0Fc7s0yeYNzk
         kcVq/GLKNy4xCjOiN3dPQ1eu2GOqYtIQk02hkZfOuEd7mV/pW1ZKoMoAKwdk/WlkUczu
         VEFwbOMmBucZuvB4dVzjoZKobIlVhdSdhk1gHj3NlcrOxfhykMBq02Ddpx/UAcenV2d9
         H6fFjTIDn+cvMsYeIEIrhjMZZ74aEv343aMnLSTE4WGvBXcbncZGKe/wfws0QqQql7yX
         hbiDel8fgY1EKqDLgmq6zrkoNXrs0hkyg/paKn/mCux/h6gYGaXO8Q9fqkElW74W+eCO
         HxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5wrCbW2TNaYb01/tuYYFENHET5JL1U7hc5fWA+Xdi0=;
        b=q9jBjuZF18UVotSbPtAGNNBEqJ7zVYotOBI+TEDQEyF5bNvW0KCuErujL9E8FQgvb6
         zs5sHFtgF2bKMuAY1RTlEm8ZApLiCBonrtHilsXPHjMrCMtkl3T1u8VKHRMBA1GokRem
         nEY/StNFX+RxXaK8y7pZqXHuXxG+F66k4R8/1ScXfbMBRoNtDePWIyt0uiq2LutnUwYf
         yOVAQSJC/mnLGg0ANDvSkomdbkYGTmTLczJmYm2chne2Ipgqkw1kWc3s9seUrv/EcXis
         jzus6dgEi0uobaNS1ZNH/A+aF9h75tP8ZupkPfTQMkopqR64kCajQW8Z+21sOgQjLYew
         KTcw==
X-Gm-Message-State: ANoB5pl0UhXcdXqZThVDJe8OfwguTlaTFfexQ8wkGaTIhk3n5QcAs9Wf
        upEls86BJz2ehTF7+kDmGsNxjwTbuao=
X-Google-Smtp-Source: AA0mqf7tPtGLz7FEjQT7OGHJ9yECs4p6OOzEpzUaOwIMlT2AhoWLN//j7QCBOd2xE5n98DwvX6ZF8x49BCU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:db68:962:2bf6:6c7])
 (user=glider job=sendgmr) by 2002:adf:f086:0:b0:22e:3725:8acc with SMTP id
 n6-20020adff086000000b0022e37258accmr2585059wro.330.1669029709011; Mon, 21
 Nov 2022 03:21:49 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:21:34 +0100
In-Reply-To: <20221121112134.407362-1-glider@google.com>
Mime-Version: 1.0
References: <20221121112134.407362-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121112134.407362-5-glider@google.com>
Subject: [PATCH 5/5] fs: hfsplus: initialize fsdata in hfsplus_file_truncate()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When aops->write_begin() does not initialize fsdata, KMSAN may report
an error passing the latter to aops->write_end().

Fix this by unconditionally initializing fsdata.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/hfsplus/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 721f779b4ec3e..7a542f3dbe502 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -554,7 +554,7 @@ void hfsplus_file_truncate(struct inode *inode)
 	if (inode->i_size > hip->phys_size) {
 		struct address_space *mapping = inode->i_mapping;
 		struct page *page;
-		void *fsdata;
+		void *fsdata = NULL;
 		loff_t size = inode->i_size;
 
 		res = hfsplus_write_begin(NULL, mapping, size, 0,
-- 
2.38.1.584.g0f3c55d4c2-goog

