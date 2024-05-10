Return-Path: <linux-ext4+bounces-2450-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CFD8C23DD
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2024 13:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D3528889F
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2024 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34DC1708A0;
	Fri, 10 May 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeBKAduD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B48170891
	for <linux-ext4@vger.kernel.org>; Fri, 10 May 2024 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341651; cv=none; b=QfPS9QEFxkMPQEigCi8NRZRDBpRplKbQno2ZNbGfIRV8g8GiYFqqWGV83HV5+ZqDx+r2vF+xCI6vR64/eDXT1aO1TsjpXWTeYQT+xVsasQBPv6OuRSgMsfKBElqExORsRhshlRvXNMUEqP9ayUvrNcFotgjaPRwZ2JPr6HDT+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341651; c=relaxed/simple;
	bh=JKHp4Rh5kiRcj7JDKcLq7wL0HdW0ZmOA3PpfklMf1Ns=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=VsRR61nv7JlrVu3pJiUWSRF/lA1BdqjePGJ45GvACUAHzzn29xPf683BYqlaVkgToLyPuqxu66w1sgUTG4iFA1QL6HFlmtuFoXv+2Cxg8brjL/cv24mWNbZ8AfgJdSZjIW0hokmTiLZXc8dDmpw92Beed6Dy23PQvYYFnxDRbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeBKAduD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715341649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sd8WPC6FQ4+Bcwqy340NHitlPtCAliqE6vEb39UhEp8=;
	b=VeBKAduDQiO/+QKHgXi84HRSb8vBuBQaHKSkw2rq5dUV0VBZoY0akbvwrELMRFqim/Y2Z7
	+/ZGVGO/pB9RMYBIZRdl/k0EWHNoP/E/pTuXy07yP0C0p3/mfDk/FZAwLascTzbmdySJTu
	apHEl6tFxehkhWg1dLqFtQ+qQmVUq4g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-T2OoUr2rMW2tuHOYkkqepg-1; Fri,
 10 May 2024 07:47:23 -0400
X-MC-Unique: T2OoUr2rMW2tuHOYkkqepg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E00429AC02C;
	Fri, 10 May 2024 11:47:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 574FAC54BBC;
	Fri, 10 May 2024 11:47:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>
cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
    Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ext4: Don't reduce symlink i_mode by umask if no ACL support
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1586867.1715341641.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 May 2024 12:47:21 +0100
Message-ID: <1586868.1715341641@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

    =

If CONFIG_EXT4_FS_POSIX_ACL=3Dn then the fallback version of ext4_init_acl=
()
will mask off the umask bits from the new inode's i_mode.  This should not
be done if the inode is a symlink.  If CONFIG_EXT4_FS_POSIX_ACL=3Dy, then =
we
go through posix_acl_create() instead which does the right thing with
symlinks.

However, this is actually unnecessary now as vfs_prepare_mode() has alread=
y
done this where appropriate, so fix this by making the fallback version of
ext4_init_acl() do nothing.

Fixes: 484fd6c1de13 ("ext4: apply umask if ACL support is disabled")
Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Max Kellermann <max.kellermann@ionos.com>
cc: Jan Kara <jack@suse.com>
cc: Christian Brauner <brauner@kernel.org>
cc: linux-ext4@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ext4/acl.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index ef4c19e5f570..0c5a79c3b5d4 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -68,11 +68,6 @@ extern int ext4_init_acl(handle_t *, struct inode *, st=
ruct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
-	/* usually, the umask is applied by posix_acl_create(), but if
-	   ext4 ACL support is disabled at compile time, we need to do
-	   it here, because posix_acl_create() will never be called */
-	inode->i_mode &=3D ~current_umask();
-
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */


