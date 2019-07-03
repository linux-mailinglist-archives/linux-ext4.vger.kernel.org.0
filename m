Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED48B5DF8D
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 10:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfGCIRB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jul 2019 04:17:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43724 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCIRB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Jul 2019 04:17:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so807581pgv.10;
        Wed, 03 Jul 2019 01:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jOWLuTX5Ou8xPNstVGBSyqvjX18CMNLeXqk+tck3OIc=;
        b=klhHxOiWT4KNUKOQ9Oah2yuZNp6k2xIklSiHE+F67MTiMu/ynw9r2L/him13p+b+/f
         P97oWgXmZCWvTpR6u/Ej+LywOxjwdboL5BCnLlUqq/vv/Unp4CvcGS6n0+z9PAzwyecu
         cMsSGBNxTJOZM2aI0nPS65T4Bw6N/RxRXoC7RggW98XmMWoVpwin4KWlhWwuYDTVx/Io
         /112NVeXq+fbzE44KVYGiDu7ZJMGC285olVGI2ciYVGTubUgSPV4gpO6SfczfTx+/ASg
         48IKedZigT7QFrChtFh04cCl2CAreZUABDv+yi7dSSO7KmwpUiSyy+aQ+H/A17QSO8vL
         ideg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jOWLuTX5Ou8xPNstVGBSyqvjX18CMNLeXqk+tck3OIc=;
        b=ilNNGvaIotOPneNAO/PMuz5G71Riut8B+tcpQjGrvNaoz69m8fWdjSDBSZbU94RSZ7
         7sH/r0xoNn6c9GEic6Qp7bTzckD4sMLcRW/7+TigvXJEPIFo38eL/yztmXkkSZPEny+F
         mPQUuv5sNowF0MSsOM8KBndfofWLTZAX9VD9Ke0FPAHFFKvpLWR5+Lr2qfb6XFjndvtS
         Z/qY8cVR7wOajgIZBjuq4XLq6rJ8Qa77c8qAR5SF/TMS7BzKhdBiAMlnPk/Uf7otk0AD
         bBU5gzPR/q29ELS0PlY833lJzW2WNUyvPzSrL/NyQPCRL9BeEhu/zSi2+VJqN6GZnOZp
         gYWQ==
X-Gm-Message-State: APjAAAULiW+xD0zBWes0cZLAyl2nEBTspH7qBD1VyJyqPnJCf2r7ZsxD
        bpYM9sfS2praxj11PgICEWQ=
X-Google-Smtp-Source: APXvYqwknUlps8fIQe2uk4KehVaWwmgexJShPq/GwnwXiBJWbDYAEj9go2VxxJTNdFaFbeiKh9JI3w==
X-Received: by 2002:a17:90a:20c6:: with SMTP id f64mr11315789pjg.57.1562141820942;
        Wed, 03 Jul 2019 01:17:00 -0700 (PDT)
Received: from ssy-OptiPlex-7050.mioffice.cn ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id a4sm1431539pff.9.2019.07.03.01.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jul 2019 01:17:00 -0700 (PDT)
From:   Shi Siyuan <shisiyuan19870131@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shisiyuan <shisiyuan@xiaomi.com>
Subject: [PATCH] ext4: remove unnecessary error check
Date:   Wed,  3 Jul 2019 16:16:54 +0800
Message-Id: <f4c9a68280d23b43f8949265d33244012e2b40e4.1562138716.git.shisiyuan@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1562138716.git.shisiyuan@xiaomi.com>
References: <cover.1562138716.git.shisiyuan@xiaomi.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: shisiyuan <shisiyuan@xiaomi.com>

Remove unnecessary error check in ext4_file_write_iter(),
because this check will be done in upcoming later function --
ext4_write_checks() -> generic_write_checks()

Change-Id: I7b0ab27f693a50765c15b5eaa3f4e7c38f42e01e
Signed-off-by: shisiyuan <shisiyuan@xiaomi.com>
---
 fs/ext4/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 5cb9aa3..9e4c39e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -224,8 +224,6 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_DAX(inode))
 		return ext4_dax_write_iter(iocb, from);
 #endif
-	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
-		return -EOPNOTSUPP;
 
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
-- 
2.7.4

