Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420D72DB6EF
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 00:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgLOXKp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Dec 2020 18:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbgLOXHB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Dec 2020 18:07:01 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171BBC061794
        for <linux-ext4@vger.kernel.org>; Tue, 15 Dec 2020 15:06:19 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4CwYlr3p8zzQlPP;
        Wed, 16 Dec 2020 00:06:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1608073574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PdBu5/dS0A5FMYLL7n5/QECaLJXqewcylpkvhK7v3hc=;
        b=1NsITmRLNdHN0W14UnH64azRVB07il84+QHv48YJntgGii9nQOGkXL9ao4kbxsOAqKMZOY
        OBvkkIIrjg9KoIAj98/Nkxvvq3zEKSWl8whzerm1vPCUg9+b1v9/RgnEc6vjQDAEhL/2gA
        tWo3REoPKDSuMDsRFjXCxR4hCOejoFDAuwJruOjDmQx9WLuaYyy/0FOQNdlY8xXlYsgBpz
        WjD/kd0SN3jWH6baXvRAU1pZNghK1ScO50ZvGMT8mec4jJrWVQ5nK7GJApzTFEEv5R8hMu
        i94EJdIb1VFaVqep1QJRLacAEoq0rzen04yVmqS1D74wq4tENYDML/5NwI7GYA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id SRVRdS2jEZhF; Wed, 16 Dec 2020 00:06:13 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH e2fsprogs] build: Add SYSLIBS to e4crypt linking
Date:   Wed, 16 Dec 2020 00:05:57 +0100
Message-Id: <20201215230557.17211-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.00 / 15.00 / 15.00
X-Rspamd-Queue-Id: A9246185D
X-Rspamd-UID: 611443
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The $(SYSLIBS) was missing when linking the e4crypt application. This is
available in the e4crypt.profiled variant, so I assume this was just
missing in the normal variant and is not left out intentionally.

This fixes building e2fsprogrs with -fsanitize=undefined in the global
CFLAGS nad LDFLAGS.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 misc/Makefile.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/Makefile.in b/misc/Makefile.in
index fde01775..ae1fc42e 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -248,7 +248,7 @@ e4defrag: $(E4DEFRAG_OBJS) $(DEPLIBS)
 e4crypt: $(E4CRYPT_OBJS) $(DEPLIBS) $(DEPSTATIC_LIBUUID)
 	$(E) "	LD $@"
 	$(Q) $(CC) $(ALL_LDFLAGS) -o e4crypt $(E4CRYPT_OBJS) \
-		$(LIBUUID) $(LIBS)
+		$(LIBUUID) $(LIBS) $(SYSLIBS)
 
 e4defrag.profiled: $(E4DEFRAG_OBJS) $(PROFILED_DEPLIBS)
 	$(E) "	LD $@"
-- 
2.20.1

