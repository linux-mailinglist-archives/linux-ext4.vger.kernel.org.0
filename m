Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA92F5F41E1
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Oct 2022 13:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJDLVT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Oct 2022 07:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJDLVS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Oct 2022 07:21:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AF72528C;
        Tue,  4 Oct 2022 04:21:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b4so13857833wrs.1;
        Tue, 04 Oct 2022 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1QAq0ZB7d697dN0IELqCuGwbuQ5Z9A2pkxg2ywRmtdE=;
        b=jM323eB2g5fAgVAWEO1hWaRRCadCPBnaVxmK05FjpCjF4ZfLFAC780ab8ZIuiUx+7c
         rNZSpRoGuGTJKJ9fCMtaakzI4SAT1Mrcp9+lNVf4EK2KIMrBDv2yVp+kWCo7io1q5M6I
         tFaFUFjM9ynXQMvHbsvJx+XRbNBg/1oApBVWeT29mnZZ0yqZbeCUq/3x6thVvhwE5Yjs
         m4p8LQbmACB/rd/x1hBf5bKEfsonMhKG7q/0/p0FOC5ilxIpmamPpxAkC5YpfIixThvl
         ncFLZOenIrCLL4qOlOauuM3c/JdR/WE1S+MA7e7sMU8gdtd148PT3h3sX+9FIN/njJZn
         42Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1QAq0ZB7d697dN0IELqCuGwbuQ5Z9A2pkxg2ywRmtdE=;
        b=Y1et7jsrE7xQF2REsVFhWJJRaybrXBVqJzoQsu5WwlSnXPZgTNNHCpm9X81Dh5gupW
         8dM01J9Oqrc1zZ52eJwzH81gxp9uDzVKYMKsCpabMTNGlajR1lqU5GYflshM0MMRIslZ
         1TfMseeIievl0PUe/k0UHT5nldP/jsuSiNTEXkBqrrGZ9leOUCS8efCF9MPY/0KQZ2QZ
         i5RfkOlzd0KPk2bpUrQzOnCe+J791GrYwDP52t6H1xzE6SNfETxw/8NugE6lvkaYYa8P
         od5OV9DtN+Fe9iMv6lEscMcvTluVBv5FAVAicmcA9O5XXSPJVZsHEqMbPFeXJ/BbFeYU
         rXEQ==
X-Gm-Message-State: ACrzQf0I+dEfQT3ozp4MZQbwF1Ive182IXRihy/iXyg0/oACC8I/PH8k
        rKGJKkWpePtKG4nL8O/q2JtfQVSvztVjnDtx
X-Google-Smtp-Source: AMsMyM4oBKuoBytdgFMbR9qvtjAtRFcdKPN7/YAAA6qgcfyTQrzQ/cClTaJUauazxwnYt84GNNED6g==
X-Received: by 2002:a5d:5b18:0:b0:22b:1c7:6f8 with SMTP id bx24-20020a5d5b18000000b0022b01c706f8mr15885925wrb.502.1664882475880;
        Tue, 04 Oct 2022 04:21:15 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b003b4868eb71bsm20648240wmq.25.2022.10.04.04.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:21:15 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ext4: remove unused string "deprecated_msg"
Date:   Tue,  4 Oct 2022 12:21:14 +0100
Message-Id: <20221004112114.101799-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The string deprecated_msg is no longer being used, remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ext4/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2335452efed0..981563c8245e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1740,10 +1740,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 
-static const char deprecated_msg[] =
-	"Mount option \"%s\" will be removed by %s\n"
-	"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
-
 #define MOPT_SET	0x0001
 #define MOPT_CLEAR	0x0002
 #define MOPT_NOSUPPORT	0x0004
-- 
2.37.1

