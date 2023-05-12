Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793607011FF
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 00:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbjELWDU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 18:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjELWDT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 18:03:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4309B1FC7
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 15:03:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34CM3DEe013044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 18:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683928995; bh=UyIr4ZJlGIYfObe1plNxJVlRxu0FwPIdTl+oJDz15l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eQ25J06h4ogv/hIWicCWXvtcMuFiKZ45cUPRuTewjjHr7ydkRZM7LD8KQDrqGqc6L
         tKhueAGv8bCsIPVTcRV28+WewKBSP8+jkOJCo5btbu1PEf4g3wiOnar/IqZRUxYniQ
         rNEBCg+Cjph05RspwEpjwX9X1OE4BXyeMZgOnC/DCb/QlA1FgnkUgA21deLV7WwM0r
         1x+HKkFzKtrPWa8vbBUCtdhvPA6MvYjbWXNxsRqxU31rKWKAmnt1D1abHG9/qvBMeJ
         Wj2TXS5LHBL212Kvciw06juU71XMTWEQxeLbrgRoGWq+19yjpwHpGAGRtHvMmuiR9O
         i8rYmJpGQrkaA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C24FE15C02E6; Fri, 12 May 2023 18:03:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] ext4: bail out of ext4_xattr_ibody_get() fails for any reason
Date:   Fri, 12 May 2023 18:03:07 -0400
Message-Id: <20230512220307.1412989-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230512220307.1412989-1-tytso@mit.edu>
References: <ZF6vgw+DUP7/orzj@mit.edu>
 <20230512220307.1412989-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If ext4_update_inline_data() fails for any reason, it's best if we
just fail as opposed to stumbling on, especially if the failure is
EFSCORRUPTED.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index f47adb284e90..4c82f7dc75a6 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -360,7 +360,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 
 	error = ext4_xattr_ibody_get(inode, i.name_index, i.name,
 				     value, len);
-	if (error == -ENODATA)
+	if (error)
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
-- 
2.31.0

