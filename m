Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0001934B62E
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Mar 2021 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhC0Kc5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Mar 2021 06:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhC0Kcy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Mar 2021 06:32:54 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE47C0613B1;
        Sat, 27 Mar 2021 03:32:54 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id t5so4244741qvs.5;
        Sat, 27 Mar 2021 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mjv+zakOwbbnocJ0k9WErnssHuC7YZn+i/AYazbA17A=;
        b=hGxizoVJ/WGJAJs1Kw9AWFrW8n3NNQ01KawH/RjFu8qxBlWHLp2aC1SoE5BufRpZRF
         0GqtJfIe6ACXfSxl10ep4rTE/uZO+L88PNayqCfYfpoRNJZwKpz4vZ/uxCuVVZebAt/t
         bT0sBxdVrkuAyIVaNe1N+GbyelpXNIaj2iPoZYIHeHChTwpdCKtlnLipkas0irn4A2lD
         Y3Iu3ObDIeGlUKq9kwh6VMB4nt0sk50P/TXkMwMdPrmR45xo8EC5Z4xgkHjcYcmiZCJ0
         EqKyfG/2oj/FKvyq+80BkC3rKbQ5Vx7tNIfyEgJdHN6Cx7L8dCi0Xhthrp2h69QuvkeI
         EwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mjv+zakOwbbnocJ0k9WErnssHuC7YZn+i/AYazbA17A=;
        b=rg9NJngQgd7ybCKNbCkR68jorZn39N0gDXJwGYUGERMytmQq7XlHcEHjShp8jtg58g
         eoDEsuElajmYRJ/CdoTtq/qF2be4twR6Po2Oc/nchPZS/TtaakmQf77HOei5dLmFwZ+t
         L3EqA9znWvPm76ZvxlRuBfhkpRCvyTtsljBOzoCvtidJb0kwfO+SSe60qNbTvfuDfpQY
         wf8r6vQ/N69VFwO166cucDTkEI1n/5sYaj2YJIZN5zW9RqUsUjbBXw176jUg4L64NGjh
         ioXQnjRf+QXlu6BlLQ5HcqReAvFRCX61In3Q/rQoYF/ANfJ7rCIzLPY2hpCQ6gRXODjy
         gDgQ==
X-Gm-Message-State: AOAM532NCW4J7BWGl5T3JxR5JQDgPbQk2aUGqF83f0HAfBXir6cVLudc
        pWiCD5beKqhDrsMLSvi92S0=
X-Google-Smtp-Source: ABdhPJy4b/ihxeCHPfKCAIrAyt1ZGrCf4frO3FKoDOBQTzu8ShyrfMDgdfPu1U/m0HdtVFfHF1FTmg==
X-Received: by 2002:a0c:ed4d:: with SMTP id v13mr17328632qvq.32.1616841173848;
        Sat, 27 Mar 2021 03:32:53 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.35])
        by smtp.gmail.com with ESMTPSA id a14sm7292364qtw.80.2021.03.27.03.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 03:32:53 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ext4@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] EXT4: inline.c: A typo fixed
Date:   Sat, 27 Mar 2021 16:00:07 +0530
Message-Id: <4585cbb0b855149079728a6fbc83d7d7f8e37298.1616840203.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616840203.git.unixbhaskar@gmail.com>
References: <cover.1616840203.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

s/metatdata/metadata/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/ext4/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index b41512d1badc..fbc5086461e1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -795,7 +795,7 @@ ext4_journalled_write_inline_data(struct inode *inode,
  *    clear the inode state safely.
  * 2. The inode has inline data, then we need to read the data, make it
  *    update and dirty so that ext4_da_writepages can handle it. We don't
- *    need to start the journal since the file's metatdata isn't changed now.
+ *    need to start the journal since the file's metadata isn't changed now.
  */
 static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 						 struct inode *inode,
--
2.26.2

