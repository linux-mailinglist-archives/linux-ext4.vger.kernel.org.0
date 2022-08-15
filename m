Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0448C592860
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Aug 2022 06:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiHOEHy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Aug 2022 00:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiHOEHx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Aug 2022 00:07:53 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EED6F13F7F;
        Sun, 14 Aug 2022 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6zMcU
        q3aNN1e5DWK/SAx9aLSIPLQiwubTjRXD0ldzkk=; b=jz+wx6VLfEESCl5iN+inb
        +3G+Vfqh70UTwRORbz9AA3gfNhPBE+4MIxcCO9kewWAmFOaEL66beAQJCQoVJknw
        BX+svH9V6gARGA1S68SvwghVnYIExaBCgMNrLZ9m8rT6qFZ+0CHZ76gH3FWIg9Ao
        AR5amgNF8Jw82VLNlTD3/M=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp4 (Coremail) with SMTP id HNxpCgAXu+WIxvliCDARVQ--.18743S2;
        Mon, 15 Aug 2022 12:07:38 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH v2] fs/ext4: replace ternary operator with min() and max()
Date:   Mon, 15 Aug 2022 12:07:33 +0800
Message-Id: <20220815040733.2022863-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgAXu+WIxvliCDARVQ--.18743S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZFyDtFWftF4UuF18XFW3GFg_yoW8Jr45p3
        ZxCF1kCrWruw1Uuay7WF48A3W3GayDGw47XrW5Xr17WFWvqF97Jrn8Kw1UZF1FvF48Wa4a
        vFWjk3WUJwnIva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um0PDUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivgpe+1ZceYnPBQAAsh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

fs/ext4/extents.c:2631: WARNING opportunity for max().
fs/ext4/extents.c:2632: WARNING opportunity for min().

min() and max() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Suggested-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/extents.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c148bb97b527..fabace690318 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2628,9 +2628,8 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 			  unwritten, ex_ee_len);
 		path[depth].p_ext = ex;
 
-		a = ex_ee_block > start ? ex_ee_block : start;
-		b = ex_ee_block+ex_ee_len - 1 < end ?
-			ex_ee_block+ex_ee_len - 1 : end;
+		a = max(ex_ee_block, start);
+		b = min(ex_ee_block + ex_ee_len - 1, end);
 
 		ext_debug(inode, "  border %u:%u\n", a, b);
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

