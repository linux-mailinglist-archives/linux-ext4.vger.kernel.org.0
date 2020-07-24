Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF40222BC3B
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jul 2020 04:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgGXC6W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jul 2020 22:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgGXC6V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Jul 2020 22:58:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98134C0619D3;
        Thu, 23 Jul 2020 19:58:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so4399867pgc.8;
        Thu, 23 Jul 2020 19:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=JVe/Nr8YVppEXojByslf4v7Nsfmxy2s/PHY7BapPd8s=;
        b=ssa7v1drwV0tDj57qR2Nipq/Evi0GvUJQKdWXieVozMShJERcdCRXMCvXMOqcE14PJ
         2TBdcFzIGjMMgFUg0Yxz3Kt/lRQuMigNWqA7OKJTu3fkRZcf9iJ4WxITX5CqTltcze6y
         AwBXmDDSKA9Gmxy7/pgKSZ2Srfc3dVZdA/UgTefQjzBPOAShCP1FQtOVK8+9h8u7cc2Z
         0qilR6pQD77nfl3lUIL7HiDwWfDUBUGVOsgUiRen4wL8ReUOfp/1ldwpHhA2tOCGrF7G
         MObSfwUztcDtcT14zBBBJ934n4qNbm3eMujT+kth+UH/BTxurUZaQHhvgrnhqjJTZTo8
         v5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=JVe/Nr8YVppEXojByslf4v7Nsfmxy2s/PHY7BapPd8s=;
        b=VokOkyPoE63ZtXS37Ntnlvu5i8CX+gfylbYdkhShgJKcyCcAGvsDUpnkH+a1CxNXT7
         hQUcMEWIAU6K/xJkR54SDijrxsY0hP+WMqpcJODTOEgSyie3yau9WDvjdH29sE3aWXI0
         gNq4NujCyZOyNNueebBKCZJgmmot0WliA7/aW0Xn+iXqS6szygCRpEg6H/P7veGOUIKF
         DmTs2W90oenY4m+Zx7LP6kQr7Trz/+kw+PMkyKSwOJbcNdVjO7lQjTRSmbdyLmdJZwUE
         et/sAPsCLAySYkho9OLSROJRtZCPujW5q0k0U2UO7C+Oe604RXlJZh+4K5MiR4Ffa7Jb
         Ecfw==
X-Gm-Message-State: AOAM532d90o2z/op0cBeHis/lksey2OvcrS/slH6ELUQR0wKSgf21NiE
        znrvN8nzuJDC8Qu6DvYUuf26WKbaVv0=
X-Google-Smtp-Source: ABdhPJzGhS7XSjC3UY42FAhDyqufoLak70mWTv89HjYZBN1rrj6ZV5idEsaCKe/QOWk0Wh//FKEtxw==
X-Received: by 2002:a62:f206:: with SMTP id m6mr6786978pfh.260.1595559500881;
        Thu, 23 Jul 2020 19:58:20 -0700 (PDT)
Received: from [10.8.0.10] ([203.205.141.54])
        by smtp.gmail.com with ESMTPSA id g4sm4552680pgn.64.2020.07.23.19.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 19:58:20 -0700 (PDT)
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH 3/3] ext4: add needed paramter to,
 ext4_mb_discard_preallocations trace
Message-ID: <0afd7706-aee2-cc23-7558-a60e39ac96a8@gmail.com>
Date:   Fri, 24 Jul 2020 10:58:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add the needed value to ext4_mb_discard_preallocations trace, so
we can more easily observe the requested number of trim.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/trace/events/ext4.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index cc41d69..61736d8 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -746,24 +746,26 @@
 );
 
 TRACE_EVENT(ext4_discard_preallocations,
-    TP_PROTO(struct inode *inode),
+    TP_PROTO(struct inode *inode, unsigned int needed),
 
-    TP_ARGS(inode),
+    TP_ARGS(inode, needed),
 
     TP_STRUCT__entry(
-        __field(    dev_t,    dev            )
-        __field(    ino_t,    ino            )
+        __field(    dev_t,        dev        )
+        __field(    ino_t,        ino        )
+        __field(    unsigned int,    needed        )
 
     ),
 
     TP_fast_assign(
         __entry->dev    = inode->i_sb->s_dev;
         __entry->ino    = inode->i_ino;
+        __entry->needed    = needed;
     ),
 
-    TP_printk("dev %d,%d ino %lu",
+    TP_printk("dev %d,%d ino %lu needed %u",
           MAJOR(__entry->dev), MINOR(__entry->dev),
-          (unsigned long) __entry->ino)
+          (unsigned long) __entry->ino, __entry->needed)
 );
 
 TRACE_EVENT(ext4_mb_discard_preallocations,
-- 
1.8.3.1

