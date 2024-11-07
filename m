Return-Path: <linux-ext4+bounces-4984-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D799C092F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 15:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C201C229CC
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A8212160;
	Thu,  7 Nov 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="r8KVhDGI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55ED26D;
	Thu,  7 Nov 2024 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990863; cv=none; b=XUWn6gIeRzyVixk3oxtq5C3muhRQqsqxiJ0ERg09NnJAtqS/m0vnC6geKUFDnbOPpWzsA5AawXVufI9e6qAtfxxeTiSzb1pvsgyqigFKsc1KpxVZGND5cKoETK2SG1ippBNl52vavaORtusH1bIquaJI1IYeSeRvNMxbFG8Ytxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990863; c=relaxed/simple;
	bh=LsWGaxUhQIDl8XF7MhRdqRUSVd1iaNtFGpmijx6gn2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gCd4J2CiQuZuv08napb6MxG+HA/5NE5SybsiOZPyhyLJZ0ZCR//BjY0Hq8sUKXCV34RXyHRYIlMYIWX/sx2nQqesMR+ivdBReC1VCPrtSwSElxlP8BJ6gcIWzPAiA7ZRQMKzXOqSbF/TrOw+MueBKCpdW6P3Dfkx11MCIgew/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=r8KVhDGI; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4XklKl0p6Sz9wwr;
	Thu,  7 Nov 2024 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1730990859; bh=LsWGaxUhQIDl8XF7MhRdqRUSVd1iaNtFGpmijx6gn2g=;
	h=From:To:Cc:Subject:Date:From;
	b=r8KVhDGIqnLtHrwIHfMTM1WAVSKrIC1BAa42xehxbkT9lLLLeIith9rx2xfYuYVVj
	 atIrcPaedYW0a6k3ZkAgC7vLYALCcmUR6VY4Ep8I9CgBNH/MsxlD+F3acgG2f467pX
	 tJgdUYOPIH4I2zptJolQtc4zFck910ov2JAss4cg=
X-Riseup-User-ID: 642A552ADF2905C00A95B8FBB615697E0CC28B5B49DAFA3D7DA4554E16FA9B70
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XklKj36SbzJn2G;
	Thu,  7 Nov 2024 14:47:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20Mart=C3=ADn=20G=C3=B3mez?= <dalme@riseup.net>
To: 
Cc: dalme@riseup.net,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] jbd2: Fix comment describing journal_init_common()
Date: Thu,  7 Nov 2024 15:45:38 +0100
Message-Id: <20241107144538.3544-1-dalme@riseup.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The code indicates that journal_init_common() fills the journal_t object
it returns while the comment incorrectly states that only a few fields are
initialised. Also, the comment claims that journal structures could be
created from scratch which isn't possible as journal_init_common() calls
journal_load_superblock() which loads and checks journal superblock from
disk.

Signed-off-by: Daniel Martín Gómez <dalme@riseup.net>
---
 fs/jbd2/journal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 97f487c3d8fc..3c1d42133687 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1518,9 +1518,10 @@ static int journal_load_superblock(journal_t *journal)
  * destroy journal_t structures, and to initialise and read existing
  * journal blocks from disk.  */
 
-/* First: create and setup a journal_t object in memory.  We initialise
- * very few fields yet: that has to wait until we have created the
- * journal structures from from scratch, or loaded them from disk. */
+/* The journal_init_common() function creates and fills a journal_t object
+ * in memory. It calls journal_load_superblock() to load the on-disk journal
+ * superblock and initialize the journal_t object.
+ */
 
 static journal_t *journal_init_common(struct block_device *bdev,
 			struct block_device *fs_dev,
-- 
2.39.5


