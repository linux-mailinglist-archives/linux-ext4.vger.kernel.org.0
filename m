Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80FC810E04E
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Dec 2019 04:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfLADvT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Nov 2019 22:51:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39082 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfLADvT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Nov 2019 22:51:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so14230525pga.6;
        Sat, 30 Nov 2019 19:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxgA6dJnA/dGvMRrEelT9MYN+n9ka+vhMkWWG7BgB2M=;
        b=FaXUxc/ieqHGSyxG54PAJ2Nps9gjPrpA0ofS4jtugNSYRbBvJ3I3XutMBnhsUCI6Iw
         Vqjxja0IfCnhW1ZQairkzedaSQhySx0ML8uycnBl1Hf/IYCTPDFkxx0xyvad9Bp+HXlt
         iW1ElX+TIxM1lU3SE0ijXzKbJQkst9KZFJwpotBYNUd6HFO1wDo9q6Khal9ChsuyEgnK
         FIqI3DFEVis5IOmhK10+k5qjP0+ohsRuLre2WltR00n/NpX51E7qWDhvS2OXI3uLJ3B6
         HzRe3eQJgJcnRN+iS7+i5yQXK9QbXvRlZmliFGL//uqWn2jVfqCxLEhBHXIW4GX2liZJ
         mraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxgA6dJnA/dGvMRrEelT9MYN+n9ka+vhMkWWG7BgB2M=;
        b=czuTFVG94r82Pqn4RgWxFQWyyq2mSthn535y6JIY84zUanLl5sP+dJbLNrazChtxCM
         7BY8F2T9TIc00WJQXoJADEBehMqLuTRvZS0h4Y8/MayQyHLOuulPls+AszfKqbIiwTXI
         ZRnv9x+knyB7mQDWhY2DcyKrjeGhndQJPoRRDIWWHlWIA3/5NliW6axP57GmVnm3Brll
         tCWqhrM9dpjQlWy5S0TH2BFrNheZJO6j/UMyLJs9jcb5+YyicwqAu21qa9C8tZ7pmqoN
         mTqGAlMKfraoRUOh7TMZps7zElnrDDvxoLf61xJtv5LZISq5WTmjFLi3SzWavO8GgWcK
         US7g==
X-Gm-Message-State: APjAAAW4uUuQqiMDOlX3dbhHlV6NSPPF/g5YssEV1pjYE8SvFD0LfbXg
        5e4RkxzWj5dQPwYU57Hu/IROEFUM
X-Google-Smtp-Source: APXvYqyCNUMu2NoyX7GVHrnhdhm32U9ViQxb/MYUOONemByuBlp/v9EEuWquWNP9hRCR7JCJbGObQg==
X-Received: by 2002:a65:6209:: with SMTP id d9mr24775834pgv.22.1575172278134;
        Sat, 30 Nov 2019 19:51:18 -0800 (PST)
Received: from debian.net.fpt ([2405:4800:58f7:32f8:99ed:5ecf:a28d:555e])
        by smtp.gmail.com with ESMTPSA id c12sm3208096pfo.92.2019.11.30.19.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 19:51:17 -0800 (PST)
From:   Phong Tran <tranmanphong@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, paulmck@kernel.org,
        joel@joelfernandes.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] ext4: use rcu API in debug_print_tree
Date:   Sun,  1 Dec 2019 10:51:07 +0700
Message-Id: <20191201035107.24355-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

struct ext4_sb_info.system_blks was marked __rcu.
But access the pointer without using RCU lock and dereference.
Sparse warning with __rcu notation:

block_validity.c:139:29: warning: incorrect type in argument 1 (different address spaces)
block_validity.c:139:29:    expected struct rb_root const *
block_validity.c:139:29:    got struct rb_root [noderef] <asn:4> *

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 fs/ext4/block_validity.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index d4d4fdfac1a6..1ee04e76bbe0 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -133,10 +133,13 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
 {
 	struct rb_node *node;
 	struct ext4_system_zone *entry;
+	struct ext4_system_blocks *system_blks;
 	int first = 1;
 
 	printk(KERN_INFO "System zones: ");
-	node = rb_first(&sbi->system_blks->root);
+	rcu_read_lock();
+	system_blks = rcu_dereference(sbi->system_blks);
+	node = rb_first(&system_blks->root);
 	while (node) {
 		entry = rb_entry(node, struct ext4_system_zone, node);
 		printk(KERN_CONT "%s%llu-%llu", first ? "" : ", ",
@@ -144,6 +147,7 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
 		first = 0;
 		node = rb_next(node);
 	}
+	rcu_read_unlock();
 	printk(KERN_CONT "\n");
 }
 
-- 
2.20.1

