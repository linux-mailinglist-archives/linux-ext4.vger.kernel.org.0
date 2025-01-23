Return-Path: <linux-ext4+bounces-6229-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F171EA1A53A
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 14:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CE63A8C59
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E3D20F081;
	Thu, 23 Jan 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeJmmA96"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B21C6F70
	for <linux-ext4@vger.kernel.org>; Thu, 23 Jan 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640204; cv=none; b=gu3p7r2HwfGoMJERGeX2P5mRUem64BqpHwyM3wEQfLFiTKTh8wq8J9a/r1vjDimNvLqQzn2Ol656HiGXApTmz01JWyceYETIzbPGCKFkwhHA/jS/wcdwZmt120wNqEDAyLsGy363TMIzPSleTZKdsxM+pfxN06KMUJmLMsfhwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640204; c=relaxed/simple;
	bh=+5cKcAdYEymBm36KVgM0f0tnhMdXX3buUlESVkoy0aM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NGsXfIQ/aljwCijNRiiEoRR1AfbF/+BTAOVjqPddaMf3EA04PKOybmyzVPVt1Ngj41pfGhs+My4Wx9Q5ebdZiXqpShLCVMsHyTv8o3079qM7WEQjeIUcm3+ENwrZFrFxfmGNZuw/hlHOI0ZolZIzEyziGxIMpUJFtfYFviPXoAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeJmmA96; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737640201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EXdx9+tl4ct70CKMIaHDW/4CTeE+FHNsT+wM1hW/rE8=;
	b=aeJmmA96CgVOaLrKuwmO8DeaVh02aVzyyXOSND1RepPm+GWs/Nbefpuj5XOMsyDCUrk9jM
	t4tYa3ia65FLeCypfo4+wfwcDa6Mi9miXydExiUuSPNZrJjZ3AlRZXEyQTYITNldidytGk
	VjeprQAz+R9ICfpWuzP0IvQ3JJz4/Rs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-MzDCUNqDOVqItjp0ks-cGw-1; Thu,
 23 Jan 2025 08:49:59 -0500
X-MC-Unique: MzDCUNqDOVqItjp0ks-cGw-1
X-Mimecast-MFC-AGG-ID: MzDCUNqDOVqItjp0ks-cGw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 870D919560A1
	for <linux-ext4@vger.kernel.org>; Thu, 23 Jan 2025 13:49:58 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 137FA19560AD
	for <linux-ext4@vger.kernel.org>; Thu, 23 Jan 2025 13:49:57 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-ext4@vger.kernel.org
Subject: [PATCH] debugfs: byteswap dirsearch dirent buf on big endian systems
Date: Thu, 23 Jan 2025 08:52:11 -0500
Message-ID: <20250123135211.575895-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

fstests test ext4/048 fails on big endian systems due to broken
debugfs dirsearch functionality. On an s390x system and 4k block
size, the dirsearch command seems to hang indefinitely. On the same
system with a 1k block size, the command fails to locate an existing
entry and causes the test to fail due to unexpected results.

The cause of the dirsearch failure is lack of byte swapping of the
on-disk (little endian) dirent buffer before attempting to iterate
entries in the given block. This leads to garbage record and name
length values, for example. To resolve this problem, byte swap the
directory buffer on big endian systems.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi all,

I'm not terribly familiar with this code, but this fixes the test and
doesn't show any regressions from fstests runs on big or little endian
systems. Thanks.

Brian

 debugfs/htree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/debugfs/htree.c b/debugfs/htree.c
index a1008150..4ea8f30b 100644
--- a/debugfs/htree.c
+++ b/debugfs/htree.c
@@ -482,6 +482,12 @@ static int search_dir_block(ext2_filsys fs, blk64_t *blocknr,
 		return BLOCK_ABORT;
 	}
 
+#ifdef WORDS_BIGENDIAN
+	errcode = ext2fs_dirent_swab_in(fs, p->buf, 0);
+	if (errcode)
+		return BLOCK_ABORT;
+#endif
+
 	while (offset < fs->blocksize) {
 		dirent = (struct ext2_dir_entry *) (p->buf + offset);
 		errcode = ext2fs_get_rec_len(fs, dirent, &rec_len);
-- 
2.47.1


