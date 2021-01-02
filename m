Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFB52E86E8
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Jan 2021 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbhABKT2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 2 Jan 2021 05:19:28 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25364 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbhABKT1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 2 Jan 2021 05:19:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1609582723; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Ha0ZKwGH6eJCa7nwcZ627WsOVwbqO2z7P1oFjRypBjwDEkspq52h3aBvHUOdTGi6fDWgb63YdZU5ZVBu44wXbl/IasKtbgGXfDWw6dN7pU7wdAIW/L8NbxuvoIbdLI73volldcpo0LmX/eYAcUd6dQ+g1lIJyz3T27MvBWe4TxQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1609582723; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=vBQ8Ol2bVfFyBZ+Z7YjllAF9Pv7KoufdmTTzSUVOt78=; 
        b=hQJBXZWTJTP24EVV1lQ3Ynp8sKXF3XY/WBoQyKrfaAx7AIfG6BkbWUqFtR4m5IdGJtbEvcC+8Da3asy/dJMvF2iIqbx6CbzeOk/LOW/j4jcO0hNnMW1xHRsEqYHyBhlg8O7yKvNa8BbC5Xg9UqmRiItxTaTbU7MQkepY6n1Kusg=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1609582723;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=vBQ8Ol2bVfFyBZ+Z7YjllAF9Pv7KoufdmTTzSUVOt78=;
        b=Pu50XBELpzY1AIqmhTF+OFgVJJhbq9DQBoRG53cv4kcjPtuadGHYimC6FQOLpcul
        a94/woOO5KOBuC74oeJj/G9xEz0VNKWu3pAP6nsvA8uAMsrucR68hJ2XBrZEFuTaj35
        tbKJOYrDaK61Byv/piF99JDJ9TRtzPrnQSvaYIQI=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1609582721210914.4696080792448; Sat, 2 Jan 2021 18:18:41 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Subject: [PATCH] ext2: discard block reservation on last writable file release
Date:   Sat,  2 Jan 2021 18:18:05 +0800
Message-Id: <20210102101805.355106-1-cgxu519@mykernel.net>
X-Mailer: git-send-email 2.18.4
X-ZohoCNMailClient: External
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently reserved blocks are discarded on every writable
file release, it's not efficient for multiple writer case.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 96044f5dbc0e..9a19d8fe7ffd 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -141,7 +141,7 @@ static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
  */
 static int ext2_release_file (struct inode * inode, struct file * filp)
 {
-	if (filp->f_mode & FMODE_WRITE) {
+	if (filp->f_mode & FMODE_WRITE && (atomic_read(&inode->i_writecount) == 1)) {
 		mutex_lock(&EXT2_I(inode)->truncate_mutex);
 		ext2_discard_reservation(inode);
 		mutex_unlock(&EXT2_I(inode)->truncate_mutex);
-- 
2.18.4

