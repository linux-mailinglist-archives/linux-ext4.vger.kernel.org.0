Return-Path: <linux-ext4+bounces-13973-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNLND55unWk9QAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13973-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 10:25:50 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F2B184891
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 10:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66E67303EB69
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F89236AB79;
	Tue, 24 Feb 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="oF2TP5yZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4C36A025;
	Tue, 24 Feb 2026 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925129; cv=pass; b=VU9JVtqh/NpqC98hQDDwKkb02QV5Km/RDaBrxShxnAbwCUsvi/7COkdlYdHqAsIFLT/7FKdpOD6QSttiAB9jB15sNv7ONgFweG9745kJmWHaranNxn9GgldETGLjLJi4FwUeXzaM5sAzdvhs2aEmIlNQbgGQHKd6FINOqNnIvxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925129; c=relaxed/simple;
	bh=nYee31V4R+ye21Tb469w3CGk1W/ZmOK/8or+xQNTE8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlfbVTlVvtUrY50rcN3TuCx1NwSNTZzLGkRr9JQ1pdIPiOUVs2rnDaCfu5Y3lIiHQ/UeWD8nI84zv9KfNLNZNQ0oC4Aps/WIjAqIozlvsUDFmTCpTWB9O7xxB1gzEbL5N8pJ+0SbK9f/jWG4rBrKgHY8oM58sbexGgZTUqkCfoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=oF2TP5yZ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1771925095; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hkEbIFt4DttIgv1CMozsmY98EMfKwCuLpSWdiZdlW4ggDVwTVziNNdp4OKV0W0iH5iOvW1OYsPT7FX+28b44rGIGG2YKIMSMxHPZ/YnHXlWkbO1ocfOM5fxzVzzb1R2DRN8wZqoZcQMl34q5Qv6ZNNZormcMNNaADyrmRIwxE/U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771925095; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cmlJ31saADhV9cIVXgk18qWI8zfxtzNj8Oj1whESdKg=; 
	b=VHQvhdXUwjjWNBNjlzoFZ6287O1DsmkYRR72xwYPjnxU9CqPK7BzRlag8mvIBaxgquSJCob5bgmF8+11uAwNYERXJiJoYKxmNsjxVDoh6caaRKj1t7aAvjpFxKJFVaK2j91X3Tf/rv3bDibT1cHVP/B9oQrm2jPpHzLTmMcyPts=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771925095;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cmlJ31saADhV9cIVXgk18qWI8zfxtzNj8Oj1whESdKg=;
	b=oF2TP5yZH4wa7aDLhycqy8eVRVHofHSb8jZ22zOkEyr3iZ86/Dbe7W6UEwAtY5zx
	yujTcVbXiQnL1b7nZJOBHtzMcIpuRxtqHM66qhEjTi6AxOpGkzlAjGnb5V0r6Di48AV
	eUWv2xRYOIAkOiFySob8PIggU6aNspwvqcZTjvkc=
Received: by mx.zohomail.com with SMTPS id 1771925093993179.92546983539432;
	Tue, 24 Feb 2026 01:24:53 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Mark Fasheh <mark@fasheh.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org
Cc: Andreas Dilger <adilger@dilger.ca>,
	Li Chen <me@linux.beauty>
Subject: [PATCH v3 1/4] jbd2: add jinode dirty range accessors
Date: Tue, 24 Feb 2026 17:24:30 +0800
Message-ID: <20260224092434.202122-2-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224092434.202122-1-me@linux.beauty>
References: <20260224092434.202122-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13973-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.beauty:mid,linux.beauty:dkim,linux.beauty:email]
X-Rspamd-Queue-Id: D6F2B184891
X-Rspamd-Action: no action

Provide a helper to fetch jinode dirty ranges in bytes. This lets
filesystem callbacks avoid depending on the internal representation,
preparing for a later conversion to page units.

Suggested-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Li Chen <me@linux.beauty>
---
Changes since v2:
- New patch: add jbd2_jinode_get_dirty_range() helper.

 include/linux/jbd2.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index a53a00d36228c..64392baf5f4b4 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -445,6 +445,20 @@ struct jbd2_inode {
 	loff_t i_dirty_end;
 };
 
+static inline bool jbd2_jinode_get_dirty_range(const struct jbd2_inode *jinode,
+					       loff_t *start, loff_t *end)
+{
+	loff_t start_byte = jinode->i_dirty_start;
+	loff_t end_byte = jinode->i_dirty_end;
+
+	if (!end_byte)
+		return false;
+
+	*start = start_byte;
+	*end = end_byte;
+	return true;
+}
+
 struct jbd2_revoke_table_s;
 
 /**
-- 
2.52.0

