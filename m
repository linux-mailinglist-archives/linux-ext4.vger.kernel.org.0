Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1268123C2D8
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 03:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgHEBCX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Aug 2020 21:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgHEBCW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Aug 2020 21:02:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6963AC06174A;
        Tue,  4 Aug 2020 18:02:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so1354037pfw.9;
        Tue, 04 Aug 2020 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=v+E7HQYcKD4Tu8V8lX10hoR/DUAtzqd7abuNaI0iTM4=;
        b=l64pSHHOe4/wFDDoijdiAxBHBnGmUyhsXlXiVfhFaXTwu6Sq6fW8lDbnPczAeV1/aa
         Jr+oT2ZFAvWz0ZS8Z4JB1hTLfSrOqi5qoYLEAB+T3bXR4dlliGY8HrqTik3qC9QN0rzZ
         XFRsCGKac6ZFwCYv/d6+/Nie2nEgkqIN7VETg94COkDQ7ApCO4kXVMqSxXyj7gV0PJd4
         X8uWx0fKh/3ql7HKgdOJ4Ql963yMFkLSzJ0C5ax286SyP7NdubaJXqtZQMeDrUbAVeJb
         sISSGT7IeAOC4eu3esmb4TnIvZRYywoUIUAwZQ540mc9vwtOCRBi333PGWwtunkieeoy
         ZqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=v+E7HQYcKD4Tu8V8lX10hoR/DUAtzqd7abuNaI0iTM4=;
        b=nRK0HVXwoOoHagWI9z/r4O3cCrJwMvgn8xFBjGkkw4LGhrlYZjH2KYwnlQqAj51CBd
         kITD0sWXzxQx1FValHYvjBiirfwtXT/alEVLZb8KIsj4cyLda9Q40SrokxZFuZEmbLvq
         VXKWXQNxzB6EkZJ6bAoLbvFQzpF79HFFO/Ultjsr1gzLn+/7Z2V5jPJnRSAk1RDfQcgu
         mNjAuUzre/u8pUK8Tp9XG653OHmn86IO24Bc8k8J3eOCMo9bBoNKfA5W/ClBfGiVc40W
         xDjZvDZCXLxhbhMssmfobGOnQ+VhFFkFcI/HmSuvQssZGcyVEFCCGjcEYa+we8r+kHGp
         QH2Q==
X-Gm-Message-State: AOAM533dtQVww3qldX7DAaczJsvneA1dVUWiYopCfkrqzGEVeaDUb9dy
        N503kRMTBba8dLr1J0BeOlhjbHZ5yB4=
X-Google-Smtp-Source: ABdhPJzhIp0kcMzAJ8ORkwlLD08pIUsbegJlfQWIrF8l603GbyTVkpteW1lpRWkVX7nuHcTFtvpHIQ==
X-Received: by 2002:aa7:92d7:: with SMTP id k23mr873629pfa.295.1596589340431;
        Tue, 04 Aug 2020 18:02:20 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.45])
        by smtp.gmail.com with ESMTPSA id a13sm470792pfo.49.2020.08.04.18.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 18:02:20 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v2 3/3] ext4: add needed paramter to
 ext4_mb_discard_preallocations trace
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org
Message-ID: <34718b7d-9e0c-e8a9-cdef-9150fc5edab8@gmail.com>
Date:   Wed, 5 Aug 2020 09:02:18 +0800
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

