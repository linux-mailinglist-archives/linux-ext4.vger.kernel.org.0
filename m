Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7470147A
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 07:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjEMFMT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 01:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjEMFMS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 01:12:18 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9722715
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 22:12:17 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34D5CDBZ031880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 01:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683954734; bh=uqIKSjRFrI+pgqi4RSK1fUj09thg8GlQb0skDlD1b0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mKoQ9E84GS4bfX6gVwev7Qf63U3eq0dBpDxteiy6Rda7RLHnf0soJe69VAzMAfl4K
         DyPxiWsE/FAT0XERszIPT95l75G+sMRxvPMeSplFfSnedzNlsJ46NAVrtbQ26/s3Tk
         eYYMBAC8Ri7gM8E+K1kcrcfTZDt+U85ieHTNaJ+zwggyrY12MdluMD3GtvQMWmvLSG
         ZuzU8mCj1c+kKzq+dr+06dkM/mLmN0NE1uxuqK9vd6OYBShN0526d+5MirwDq5zuW9
         JHP2/94lfiEnUEWH17lZUxIljWXr8kBbxukqbx5BVyejPskGwAr5qmpYH/3BmRN7u4
         skSEFIp17bEig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 414FB15C02E7; Sat, 13 May 2023 01:12:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2 2/2] ext4: bail out of ext4_xattr_ibody_get() fails for any reason
Date:   Sat, 13 May 2023 01:12:10 -0400
Message-Id: <20230513051210.1446682-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230513051210.1446682-1-tytso@mit.edu>
References: <20230513051210.1446682-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If ext4_update_inline_data() fails for any reason, it's best if we
just fail as opposed to stumbling on, especially if the failure is
EFSCORRUPTED.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

Changes from -v1: fixed error check to be for negative values

 fs/ext4/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index f47adb284e90..5854bd5a3352 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -360,7 +360,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 
 	error = ext4_xattr_ibody_get(inode, i.name_index, i.name,
 				     value, len);
-	if (error == -ENODATA)
+	if (error < 0)
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
-- 
2.31.0

