Return-Path: <linux-ext4+bounces-10207-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB7AB59892
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E55F4E3A39
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D446346A1D;
	Tue, 16 Sep 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLBo2LB5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219E5341655
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031188; cv=none; b=kwQXsFyuseaE6weKKR7qfu1B1f+DzaiB8t6udHrH4cMfKIfQ3OCD1wmVPiHQiXt1DBKiD53/hvRm/fnUkXFcck2MJ/USnlhcuI+hfrY1zI4y8078zAy2mvWvvFwKWDZz4C5rlUQaAe7Kkz1dG440oydZcptNd+3MNiZGXgM7tBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031188; c=relaxed/simple;
	bh=zBN9BldLXuQYafbepgbsRKYJCNw2ZdSE8TIiThiLfW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVB0NU0bTTvhWKco3PhT+1pGR5/nGhcC8+wx+rSPgK4d5u4Vy3ZR7NF/PP0B9J/hOwWYeO1+DeLMuTSn/xN1FIiZ5shNDmns/BzkuH7XxEZUJbD8sR28Wf0JLAQMJiJ6yrl6/EzV2/29tJ/yWJm5fyYmq9Txz3fBTKD3I+jfRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLBo2LB5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so2174799f8f.0
        for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031182; x=1758635982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbghKwI6RgQqtHuzp8YIKipmqQLga/vSj80h86fMMYM=;
        b=BLBo2LB5PHvFexWoLIYT5WrIPilki61efSEs5c0jKV5SbQmSndN00mauMoB88EsbHy
         EbW3RDHt6qEcAhbdRfU/nR0p3s4ponYl6Od3MsYa3toqlYwc4dPCmvXQinYcjsWKkpoY
         1OgiiIhCNypynnEVbf6HaKtZAZIkbWWGkbYJOw9CwmaKGdEyGmqorR3wDJtsmNIg8YRE
         BKy9Gtsw/o9jXEw+WYSZBaiWgv7q56SpVfUBc0goRKHiTm6Drm8X62FsntD6u0YWyDak
         Ksngv81i03MZ/WRkd+u6vWvTeo51lmVGNs53sBwSK6FgmtujqQgh7j1VFNMk147g/McU
         8Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031182; x=1758635982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbghKwI6RgQqtHuzp8YIKipmqQLga/vSj80h86fMMYM=;
        b=lU9YuqHsx3jGr9jIAyWzreoUwbTkw/L4xnW3ROi7F9/gITlNpbto9N5KoKueDeTZDB
         wtyVAYyRH/x5dX6/TsRIenXIc5ZMmNrojB4F9NDFbl2kNSGVhSt2ILBcLXctaTLAdmTp
         /4/ad9V/ltwQUOUECIYE0yHizqv6vxkkjcVMZBGL6N4T2CzhTqkozgKXiuTJ44ycfdGd
         abQLStuZBVO/dn+jOGdJikkN0Q2Fg6urGdj0YS5C9e64HzZAAsUd+FzdcobEjbf5fvSb
         E1ZSezXUl0DN+iD8O3uAFN3tHetxGW/OFL70ML4QT5thpCHBvBPMSH/zaoSUHUoeNtLC
         AO/A==
X-Forwarded-Encrypted: i=1; AJvYcCXAL2g6A0Li3qwhdA4paJkLrIC7Cnu6bq+K8ffcuAgiatO0MQzQhJ/cq1BsdTVU7R+8nzxl6I7TWLLH@vger.kernel.org
X-Gm-Message-State: AOJu0YzWnhTC3SweO6x9wdjhF+SYFSOanPFYt1cH22MbJ+d1vNtHLEcb
	eiZQ4aKROJjpIeJlcclmlfoa5SWiM1XmA0UAyi4VDxJ9czhe9XHMidpZ
X-Gm-Gg: ASbGncs5oRw1wzcAeyjjeLT0vyrDqcw9dmMil2p1u40xcK8kKl3wUHOdUauGASmKIDL
	V/b7Br3OOcPTI1eb3grAlJ6TiVVoyQp6grw6oyq2Phf2PNQWQ6/vNFX9pvBq6Q9Uh23Aeh0Mu4v
	psDTFJYOxFRoA+BsF6Xx5TRM8vhk3YjrWs3zNIpuf9E/wwBiqvl078TXvBvmZ5r4kSeLhxkk93Q
	CI69lL6eqGwLnpiiE52HLr9O0gxjnfzbrX2xM/j5p/iaPXRClqDgsj6dczJ3Do/4UicWvYn661k
	7OD1o8DbsErEiEx8uN2MFE1kBn7Zy1KDfDda6q4RdXt4LbZ3ljEH+nogGyTRxgD3RnKGgdGuytf
	ykCSLPK59wqCxswFafYNMC52PN+DRVybM6OF+tELGhCESdYCaoWnTRp2ATeV3+kYNYE2cOYMY
X-Google-Smtp-Source: AGHT+IE5shqQIUKbOw6hlw6cRTrcBtFVXG2OEPPmead9j/NTizmYAzcuhQc64qnxQ9XZRhrVFrM2rw==
X-Received: by 2002:a05:6000:310f:b0:3ec:d7c4:25a5 with SMTP id ffacd0b85a97d-3ecd7c4282emr1856689f8f.42.1758031181954;
        Tue, 16 Sep 2025 06:59:41 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:41 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 05/12] netfs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:53 +0200
Message-ID: <20250916135900.2170346-6-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

cheat sheet:
Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set_raw(inode, I_A | I_B)

 fs/netfs/misc.c        | 8 ++++----
 fs/netfs/read_single.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 20748bcfbf59..f0f23887d350 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -147,10 +147,10 @@ bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (!fscache_cookie_valid(cookie))
 		return true;
 
-	if (!(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (!(inode_state_read_once(inode) & I_PINNING_NETFS_WB)) {
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
@@ -192,7 +192,7 @@ void netfs_clear_inode_writeback(struct inode *inode, const void *aux)
 {
 	struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
 
-	if (inode->i_state & I_PINNING_NETFS_WB) {
+	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB) {
 		loff_t i_size = i_size_read(inode);
 		fscache_unuse_cookie(cookie, aux, &i_size);
 	}
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..f728aae9bde9 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -36,12 +36,12 @@ void netfs_single_mark_inode_dirty(struct inode *inode)
 
 	mark_inode_dirty(inode);
 
-	if (caching && !(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (caching && !(inode_state_read_once(inode) & I_PINNING_NETFS_WB)) {
 		bool need_use = false;
 
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
-- 
2.43.0


