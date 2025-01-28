Return-Path: <linux-ext4+bounces-6256-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E2A20635
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 09:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73613A7B2A
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 08:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE21DEFE1;
	Tue, 28 Jan 2025 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="npppoSwm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A916C854;
	Tue, 28 Jan 2025 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052889; cv=none; b=GBAIP5ANgfVer9eJxncKsP10pVI/ymAYovqrLB+mZ8M4abHyHVuZn6CtOj3twtT08YlhUHVpt9wkxWwU/U8yTvaq6jxWFDxnagDkh7dbaWRDF9mHXc4XPv4fGMgB6moXqKTiBMI5n5/BQoiXKPe8g4mmz+aAV+jVjqbSQ/2Whl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052889; c=relaxed/simple;
	bh=o9SHb0fU8GJDseV5H5/uKUJC/iQzaLB2ThoztaOJ9+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UE/cjPQShpRkVtY5nAaYdJxsdRTQ55VYatMSF3DuckYHJVoCnU8dnN8WGv8ZzNRR80oYHacmVXvBKWNJFfJHXiiGoaWF8flB8pN+cl//NjrBbppY/H9jU/pR7wAhG/ebk5HULJmdmngwZh+cFd1rq3LXAqEvEiiSHJ4aO3nnWrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=npppoSwm; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UaLc4s9MOMT+Lgz23hU+OivNtdclltcYDm/8rzdp4Vc=; b=npppoSwmRkopfcuxpPHgHRTTJ/
	CXn8R22laPAb43LFVLgh2506lvroncW8kpgDeCZLBPgwnz6kFT4BejKKzBc1iWUusNzY5ZAo3qSQV
	qnjIkyAGoYCWxGydE14RHN9SxoCgSsLABRHAg+xbazLCGEoovB+/JgIv3CEkJ3YpBZKihQdediMAb
	cngqBIhQ09q3ysr4zPAheXWmJCZkHWb+OTDtn8Q4zovX5pzt/E0nH5UwT4LUDy3m24UhYEkY7suqy
	KiYbdihjaeiuThqJnZlMLtp98VWuX/owGsh05qFn5KBb77pNbdcb4bEKpCQDlqhNMf7ae5YHmpsR2
	qQYyPRyg==;
Received: from [223.233.66.58] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tcgx0-003dn0-0O; Tue, 28 Jan 2025 09:28:02 +0100
From: Bhupesh <bhupesh@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: bhupesh@igalia.com,
	tytso@mit.edu,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	revest@google.com,
	adilger.kernel@dilger.ca,
	cascardo@igalia.com
Subject: [PATCH v2 0/2] fs/ext4/xattr: Fix issues seen while deleting xattr inode(s)
Date: Tue, 28 Jan 2025 13:57:49 +0530
Message-Id: <20250128082751.124948-1-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
----------------
- v1 can be seen here: https://lore.kernel.org/lkml/1dddb237-1460-8122-7caf-f0acd7c91b5c@igalia.com/T/
- As suggested by Cascardo while reviewing v1, there are two
  patches in v2:
  [PATCH 1/2] Ignores xattr entries past the end entry.
  [PATCH 2/2] Hold 'EXT4_I(inode)->xattr_sem' semaphore while deleting the inode.

Bhupesh (2):
  fs/ext4/xattr: Ignore xattrs past end
  fs/ext4/xattr: Check for 'xattr_sem' inside 'ext4_xattr_delete_inode'

 fs/ext4/xattr.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
2.38.1


