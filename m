Return-Path: <linux-ext4+bounces-13751-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CtpHmErl2nmvQIAu9opvQ
	(envelope-from <linux-ext4+bounces-13751-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 16:25:21 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A01CD160181
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 16:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85795300D0F1
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 15:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B0B341062;
	Thu, 19 Feb 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GButqqAY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524983033FD
	for <linux-ext4@vger.kernel.org>; Thu, 19 Feb 2026 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514697; cv=none; b=BNTEfUZFJF7ax54P8Djkp2kkhs+4uhhc0iQkkS7q5fAe6KbKiI8YdzdvSh9I7Sn5bXWylzRqqRqk3GCqz9FCna4T5PdDH/ztoxP9l1YW7vj//3k/xbrZ3rilY3tUngTF2QW+arMaAvjeAcIJiaX7bEz+TljsslZuljAheZRcyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514697; c=relaxed/simple;
	bh=4yVc6qW/EeWN3b6LS53DwwK6QYlpO8YscAuWGtticqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myhDLqlPApWWSgh6lNeDVNway9WpaGGOeg9wUI9X7um+CFazcjWkYkbGfd0lP1AU8TiLmrLXcsp88eOzRfAYiOqIsgbUTmdOtaJk/Zyy+jwHMRDbOlZMUzU+NeqOSh5Z2yEAk4gUN3cgG1e+AuLhLLdpoPYu8wbrhdQVAPmT0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GButqqAY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-47.bstnma.fios.verizon.net [173.48.113.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61JFOqep016354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 10:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771514693; bh=s2Mj2TUQZqnZ0xlhxckqgfmGV2f8xPtqPxJOjaQGuQQ=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=GButqqAYm0wkmJry9b8x/n0GKjIPuPRRwlOHdu218l9hwicNLwHpBuDzrEejnEhaa
	 lvLKYz/7hHmIGLQ9/e4NEFvJLw9JATUFFV7i0JclBK6UwJpTo/AQMPiGauU0xHlLZf
	 PGOsRfCSiFCB8o4HhWGry8sHtgdrvXOYKGVdMfltQWQYJd25Vn3RIzU9OQfeHzTnpk
	 Mn4KqiDn6Ig/bk728jE4pSh8GVUf9I4xKxEoHl1WUP67n8x9iBeE9IxbfJLeqqsnUz
	 D8Y65ztQswcG/xDF49LDVYSYTOhFeEZ7OsRmHmsnfWzrf541xe9btXltKxXSO7Cfy1
	 LQo5pBvU7+vhw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 483102E00D6; Thu, 19 Feb 2026 10:24:52 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH RFC] Update MAINTAINERS file to add reviewers for ext4
Date: Thu, 19 Feb 2026 10:24:50 -0500
Message-ID: <20260219152450.66769-1-tytso@mit.edu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-13751-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dilger.ca:email]
X-Rspamd-Queue-Id: A01CD160181
X-Rspamd-Action: no action

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eaf55e463bb4..481dceb6c122 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9581,7 +9581,12 @@ F:	include/linux/ext2*
 
 EXT4 FILE SYSTEM
 M:	"Theodore Ts'o" <tytso@mit.edu>
-M:	Andreas Dilger <adilger.kernel@dilger.ca>
+R:	Andreas Dilger <adilger.kernel@dilger.ca>
+R:	Baokun Li <libaokun1@huawei.com>
+R:	Jan Kara <jack@suse.cz>
+R:	Ojaswin Mujoo <ojaswin@linux.ibm.com>
+R:	Ritesh Harjani (IBM) <ritesh.list@gmail.com>
+R:	Zhang Yi <yi.zhang@huawei.com>
 L:	linux-ext4@vger.kernel.org
 S:	Maintained
 W:	http://ext4.wiki.kernel.org
-- 
2.51.0


