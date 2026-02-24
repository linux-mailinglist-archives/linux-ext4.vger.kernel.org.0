Return-Path: <linux-ext4+bounces-13972-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CduGyJvnWk9QAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13972-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 10:28:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B8D18492E
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 10:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE7AF304C7C2
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E736C0C8;
	Tue, 24 Feb 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="NAXkf/BR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BF036BCE3;
	Tue, 24 Feb 2026 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925119; cv=pass; b=ax9RV/MV3ZEJGeS+s6isPGzC4nW2v30LUnFtI5410gY6xDZU0IJXQwA7JqjzifD/H2R9KOth3fSAiBJxZ8gVyu/UNcDn41DCVkBPzUjajmxnXr3gWzjOdmSaRc2hhcXypaH6JL4/YFHlET9tKlQs5b6E7y0HTbaQDNDgCgANv2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925119; c=relaxed/simple;
	bh=l/+8xNhBJiAqz5eluZVYjjv0RTENPns16lQDGSJeU4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXgIY93M5hnCbw0KBzA8uvTRSUiG/FaVZctumMtvdTdhhZ49fMRpFRJjjzLHC587VAbrPCRTWgm8mMmHcMtZd/Ya57lm3HvgwXXh2Melq4Ff0s470UN/kM6LgAdVmom94nXQV4UIuoHjRvAtmYOlupO3AepAldiu017bBm8dux4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=NAXkf/BR; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1771925091; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BHqbqezsLZHhDpdi0idNEqEAIP+uVVfFKL25A5UqX74xrWs+O5yv0jdmIG4G+NCp6jUnVsJ0BwOytPHk1jMbaX8oEmovwPZLlbu0cJsCCIMMkUUmGxF51ERz+idTNSuY2cEJhIVxhMzRpqrmlYcQH9aJ0i79NSM97cAGGNci/d0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771925091; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lq/az62VqJL5U3p1nsUAG3qRG0JWKPWWQXM+kQO5te8=; 
	b=he03inaAXvfYbUFBdZQVNXtTVT28bmgI74cYnMfM30OywsqccjtTwyszdLMUELsRKqLlb4qtGtJlgb8b9zhLU1lH0huppc3idpDkEzOB/U2g38e0YfVvLVNoxG7pGncNzkcenZJWzhAvrGV30BIHEd/YBrpxdPLYBnS/CWJIYjs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771925091;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lq/az62VqJL5U3p1nsUAG3qRG0JWKPWWQXM+kQO5te8=;
	b=NAXkf/BRQ+RdIVOsE3SNsiHFygplCBLitAFxyM4354wK80Hq4uJ1STGF4eN9Q4Z2
	XCbDGzovEzd+DfEseS6EISVNVBkRVLWA6Fpr9sIbiWiFlhsczzv82gE9czP3+Mm6RZr
	rdBAXPZxm9r2y4Bi9Q7IohOWFVUAqAUH+pKzjLBQ=
Received: by mx.zohomail.com with SMTPS id 1771925089111389.9681096666558;
	Tue, 24 Feb 2026 01:24:49 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Mark Fasheh <mark@fasheh.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev
Cc: Andreas Dilger <adilger@dilger.ca>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] jbd2/ext4/ocfs2: lockless jinode dirty range
Date: Tue, 24 Feb 2026 17:24:29 +0800
Message-ID: <20260224092434.202122-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13972-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:mid,linux.beauty:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96B8D18492E
X-Rspamd-Action: no action

This series makes the jbd2_inode dirty range tracking safe for lockless
reads in jbd2 and filesystem callbacks used by ext4 and ocfs2.

Some paths access jinode fields without holding journal->j_list_lock
(e.g. fast commit helpers and ordered truncate helpers). v1 used READ_ONCE()
on i_dirty_start/end, but Matthew pointed out that loff_t can be torn on
32-bit platforms, and Jan suggested storing the dirty range in PAGE_SIZE
units as pgoff_t.

With this series, jbd2 stores the dirty range as page indexes and uses
READ_ONCE()/WRITE_ONCE() for lockless access. ext4 and ocfs2 use the new
jbd2_jinode_get_dirty_range() accessor which converts the page-based range
back to byte offsets for writeback.

This is based on Jan's suggestion in the review of the ext4 jinode
publication race fix. [1]

Changes since v2:
- Add jbd2_jinode_get_dirty_range() accessor and convert ext4/ocfs2 to use it
  before switching the underlying representation (per Andreas).
- Rename the dirty range fields to i_dirty_start_page/end_page to make the
  PAGE_SIZE units explicit and avoid silent unit mismatches when bisecting.

Changes since v1:
- Store i_dirty_start/end in PAGE_SIZE units (pgoff_t) to avoid torn loads on
  32-bit (pointed out by Matthew, suggested by Jan).
- Use WRITE_ONCE() for i_dirty_* / i_flags updates in jbd2 (per Jan).
- Drop pointless READ_ONCE() on i_vfs_inode in jbd2_wait_inode_data (per Jan).
- Convert ext4/ocfs2 callbacks to translate page range to byte offsets.

[1]: https://lore.kernel.org/all/4jxwogttddiaoqbstlgou5ox6zs27ngjjz5ukrxafm2z5ijxod@so4eqnykiegj/

v2: https://lore.kernel.org/all/20260219114645.778338-1-me@linux.beauty/
v1: https://lore.kernel.org/all/20260130031232.60780-1-me@linux.beauty/

Li Chen (4):
  jbd2: add jinode dirty range accessors
  ext4: use jbd2 jinode dirty range accessor
  ocfs2: use jbd2 jinode dirty range accessor
  jbd2: store jinode dirty range in PAGE_SIZE units

 fs/ext4/inode.c       | 10 ++++++--
 fs/ext4/super.c       | 16 +++++++++----
 fs/jbd2/commit.c      | 56 +++++++++++++++++++++++++++++++++----------
 fs/jbd2/journal.c     |  5 ++--
 fs/jbd2/transaction.c | 20 ++++++++++------
 fs/ocfs2/journal.c    |  9 +++++--
 include/linux/jbd2.h  | 35 +++++++++++++++++++++------
 7 files changed, 112 insertions(+), 39 deletions(-)

-- 
2.52.0

