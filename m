Return-Path: <linux-ext4+bounces-4521-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 494F6992816
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Oct 2024 11:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1301F234E7
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Oct 2024 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B9218E059;
	Mon,  7 Oct 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PGqSyBcb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2E1741E0
	for <linux-ext4@vger.kernel.org>; Mon,  7 Oct 2024 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293307; cv=none; b=rwsGqICR1VJgodn+MwUeuf7cCC/kInYZcTaO6iFtpns8hbKSjDoMvI0z5zrK+7dX4i4FvpPWU+wwcD6g2s46KrzNbWzu8WUMSIrsl36tPkSJeR7PrNK+IohGAMMLo3SnVms92H8Z9Vcm/rRg2haUjMPfixS+QgM4uxc9DYcXeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293307; c=relaxed/simple;
	bh=xwxOXNQDdG5K10egox0O/MdReACVFRWs4FU1c46jVcQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F5JA4lDq4v0BzBAL4fj2PVaSi8NF5vUSAtN4BfBUFEMDA/HRJr2YBHGXBqHhYkJp4wkYwTXI+cyfKkN6xI92Z8tZcvdcR22gqnqL1ApDdpYaetay36JybMlxFp8BpNlprDBYst37YB5MRKdV4DVJejaIY7K3fPDvukQOpjkDnoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PGqSyBcb; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728293297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KhBPqv0HMgy+V3l1ZeOmzP6ci5enJC1cEdRgXVzEEQo=;
	b=PGqSyBcbcSeop5dUkizYp76JQC+QyTt/hStSIzoPgRqmpi7w8z9y9j/2Q1G543FMjoVd5c
	nqYWiuu/vbe42gTDd41+kcLNoba0hlqYXKvD4uq7++SS4d5Fn1cIQ15MIuzLnkSfrWcO4p
	A+nJMJ6zipMcNJc0KG/tAd2ugjfkRxM=
From: Luis Henriques <luis.henriques@linux.dev>
To: linux-ext4@vger.kernel.org
Subject: Old inline-data bug with small block sizes
Date: Mon, 07 Oct 2024 10:28:02 +0100
Message-ID: <87h69oclel.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Hi!

I have a local branch where, some time ago, I tried to fix an old
inline_data bug[1].  The reproducer is easy to run, it just requires a
filesystem with a small block size (I've used 1024).

Looking at it again with fresh eyes I believe the bug could be easily
fixed with the patch below.

My understanding is that, when we are doing a ->read_folio() and there's
inlined data, that inlined data has to be in the first page.  However, if
we get a different page (i.e. not the first one), then we are zero'ing it
and marking it up-to-date.  And that doesn't sound right to me.

The patch bellow fixes things by reverting back to do a regular read in
those cases, because it's not inlined data.  Does it make sense?  Or am I
missing something and not seeing the real bug here?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D200681

Cheers,
--=20
Lu=C3=ADs

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..ec96038dd75f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -516,7 +516,8 @@ int ext4_readpage_inline(struct inode *inode, struct fo=
lio *folio)
 	int ret =3D 0;
=20
 	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
+	if (!ext4_has_inline_data(inode) ||
+	    ((folio->index > 0) && !folio_test_uptodate(folio))) {
 		up_read(&EXT4_I(inode)->xattr_sem);
 		return -EAGAIN;
 	}
@@ -527,10 +528,6 @@ int ext4_readpage_inline(struct inode *inode, struct f=
olio *folio)
 	 */
 	if (!folio->index)
 		ret =3D ext4_read_inline_folio(inode, folio);
-	else if (!folio_test_uptodate(folio)) {
-		folio_zero_segment(folio, 0, folio_size(folio));
-		folio_mark_uptodate(folio);
-	}
=20
 	up_read(&EXT4_I(inode)->xattr_sem);
=20

