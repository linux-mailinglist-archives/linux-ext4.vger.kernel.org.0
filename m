Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E703574EFC
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2019 15:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbfGYNRS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Jul 2019 09:17:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36781 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYNRS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Jul 2019 09:17:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so23036486pgm.3;
        Thu, 25 Jul 2019 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ycy5o+IU0EPnxlpcClcRjsZgu0JnXAr12t4875sIpnc=;
        b=iQnu075qF1OwZs/P4HgRfemlmO0OgxUKiZWUJrKsV/ontV4eapR8XcS3jzHL6tDV8p
         W12oLCSQ/SYwOXhFidUpQwURL4n1qGOAD08XkpXZpSvgapQQoMaPfMUYIdsbA41lsv0q
         Wnck4Vm7f7U4IPCFTCVFqcOV93Xjm0XXDernUQVvFFliUlqwwL0Z3JUSq4zY4y5qmy1S
         ujbmy3aFgLfm0ToHJKPj5pYS0Mvgs102e5lll3Umeji69Dw1zzbt2vopF0bXwobvYYMD
         gxvHA60KK087gj6UQS0miEiXkIgmY+fVnHiFJbbyn8Eu60sNWrrQFSFNIBXp7bHvpWif
         1jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ycy5o+IU0EPnxlpcClcRjsZgu0JnXAr12t4875sIpnc=;
        b=edtdb7dTuEyjYPvSplW0nJoA3NpTQCu6SokPejF3x5ys0Xpuh2JXv6t/jAfhj1F2Oi
         co7RTJ8Fk3Ly1FrZHkeGrcYluZK9DwRX0mVE0lc0QXHyaP6b9h7TucVxZw/5R/fOz/JK
         gx85P3G6oTWPGdKXOC6IpsxcrKFDkskps7kgD9qcDUcsandxsayIZaQQ8Ze+GbHBCReH
         +JL25hBaZoiXVTumScRSVd937imZXOez0Ic1jGx/kvIFVMNtMESOKv04cHZneSYXY9g9
         5mh1WmFZOOsuL6P3XSgR++IpgCHK4GR6DUhuXCRHyl2jvm47yLmzVGVkoX2XxvmSD7O4
         x6Lg==
X-Gm-Message-State: APjAAAXny/0crQ0ZeZlDCp67rPhwLzFdsWxDU9Y3xei6a2cPPNjgvTlL
        6T41f6KnjkPOsXGH9ixWKIxwYnED
X-Google-Smtp-Source: APXvYqyYfnqqv+HNz5k8fZbU69PPLkId1i+OWVn9AvwhzB5pslJey7LyjNVrTiNwtDXoVVIYcR8rJA==
X-Received: by 2002:a65:62c4:: with SMTP id m4mr84421324pgv.243.1564060637503;
        Thu, 25 Jul 2019 06:17:17 -0700 (PDT)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id p23sm55101921pfn.10.2019.07.25.06.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 06:17:16 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] ext4: use rb_entry_safe() instead of open-coding it
Date:   Thu, 25 Jul 2019 21:16:58 +0800
Message-Id: <20190725131658.17187-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

use rb_entry_safe() to make it clean

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 fs/ext4/extents_status.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7521de2dcf3a..08ce5ded3538 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -228,8 +228,7 @@ static struct extent_status *__es_tree_search(struct rb_root *root,
 
 	if (es && lblk > ext4_es_end(es)) {
 		node = rb_next(&es->rb_node);
-		return node ? rb_entry(node, struct extent_status, rb_node) :
-			      NULL;
+		return rb_entry_safe(node, struct extent_status, rb_node);
 	}
 
 	return NULL;
-- 
2.18.0

