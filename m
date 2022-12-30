Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D278765994F
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Dec 2022 15:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiL3OTk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Dec 2022 09:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiL3OTj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Dec 2022 09:19:39 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4976401;
        Fri, 30 Dec 2022 06:19:38 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z11so14783203ede.1;
        Fri, 30 Dec 2022 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iLe5hI6rAFptnQatd+p/UsPp74eRBCWLNH7+u58O7iU=;
        b=ejL0YhBBizJ7paKECVPuhp3FiidTvvAuyJdEzpsrkzGQnJ6mw5Krzc9SINfayMjmZZ
         NFacdOuhR0qwQlsoeaRZ2lqOaAWm9uUpyr5AwEXFB4BHsqIWryKyUMhbU2wthP0pToOg
         2w5pATWCJQTW0YWj6FMx6/vHvQhnMZFAPqEVWVBUtzU0PnuI60TntixHkB6aTl3XJJQm
         EnnVIXeOwk/KPRKqJ02j6Cma8KaMes5zVCs1ON2Jrv2MSUpXKVacY8EYB3AOhGJfT7rC
         0M05N8XbqGKJsxpovQoToyZZjdGRd6k8oyeRCcql54vq5nXn6ImIjRzcuvIibFLA+OsZ
         qBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLe5hI6rAFptnQatd+p/UsPp74eRBCWLNH7+u58O7iU=;
        b=7ba43jK4CWig7AkNVo3naiw1k+raVzpONAfGu5tHtdqot6YofYG0KKNRAnMNyatJco
         BgqZzy8LDejAMQFnApgF5El02B9dEjJRUdSufm3KTBGQZc3n+L7gaqZjzIdZopKHlsmt
         IlQveGIJkV/ekcesJjT1FRAYy89/Sn7lMg/t9T7D3PAiZsTJLSXKOyeSxVrW3qa89oTm
         5ckZR/ivpJSO6FhZNZBqfYEVzpBaRiTMXWrmN6ilm0OpTN9j4yUZHz30rJ6adOMPXlE6
         IappbhfzU+PerIi6O/g31sNVirdrGSKZpXr9+ajtQhE6lSs2Vz31uYF90S8LXhbNixwt
         Bxcg==
X-Gm-Message-State: AFqh2krcKdGz4wxQPXAiE0qUQQJzbQ27tjcEAJC3eaLY1XqkqauxVfiQ
        bD+RLLQIvEnHuL/gv21zK5s=
X-Google-Smtp-Source: AMrXdXtfjy+TCGR0pIBrVyb80uNciXKPDUgEjRntlUTAMLX/DsqoPgB/LoCelUFsuBdNejLDW8FG7A==
X-Received: by 2002:a05:6402:5d2:b0:477:f0d8:9e8b with SMTP id n18-20020a05640205d200b00477f0d89e8bmr26056811edx.33.1672409976518;
        Fri, 30 Dec 2022 06:19:36 -0800 (PST)
Received: from Tanmay.. (ip5f5ad5e2.dynamic.kabel-deutschland.de. [95.90.213.226])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7c147000000b0046cbcc86bdesm9486785edp.7.2022.12.30.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 06:19:35 -0800 (PST)
From:   Tanmay Bhushan <007047221b@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tanmay Bhushan <007047221b@gmail.com>
Subject: [PATCH] ext4: remove dead code in updating backup sb
Date:   Fri, 30 Dec 2022 15:18:58 +0100
Message-Id: <20221230141858.3828-1-007047221b@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_update_backup_sb checks for err having some value
after unlocking buffer. But err has not been updated
till that point in any code which will lead execution
of the code in question.

Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
---
 fs/ext4/ioctl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 8067ccda34e4..2e8c34036313 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -155,9 +155,6 @@ static int ext4_update_backup_sb(struct super_block *sb,
 	set_buffer_uptodate(bh);
 	unlock_buffer(bh);
 
-	if (err)
-		goto out_bh;
-
 	if (handle) {
 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
 		if (err)
-- 
2.34.1

