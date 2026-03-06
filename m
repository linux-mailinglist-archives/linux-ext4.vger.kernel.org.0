Return-Path: <linux-ext4+bounces-14677-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPMlCfmXqmmIUAEAu9opvQ
	(envelope-from <linux-ext4+bounces-14677-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 10:01:45 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B0D21D8F5
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 10:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53A9C300EF80
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057B37418B;
	Fri,  6 Mar 2026 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="WtpwxM+a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB79347FC3;
	Fri,  6 Mar 2026 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787569; cv=pass; b=KBZk6bgjbOp0VGELM7c9r5Zx0wuxMdDm5jCKatkhZIUttK3xapG+zvez63XQnh7YB336RRby5oZ4DtkIUlHhVL9NC3KhUQ/treFz7cyq0+Z74xinJ/Y/9rmvHiDd6vL3LvIi3cNcBvA8Tu4avbUvHWfHBB8NwmKlIxRkAbpcwws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787569; c=relaxed/simple;
	bh=03GwYGQ/9pwWzkElUJhb2wFBf91k1Ll8AbV5LnnjnZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFTJDxet4zWfUJngPLTzIqEAreMHZYA2KhjIgV/A6fBWbwWWYVYVCzU21B49ge/FsdLzBkpwiopnd3+CWt/EgJ/15br20LBZ4LZamdKojTVi5dlaf6l1u8UHDbQuni1YdqsLYINVn3Tc8GZbUP2JexylboehuCZYNVIArh9/cWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=WtpwxM+a; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1772787476; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XTCfXYrogpIYFboOZvqMXWzP3ihWXx9MW+6XJMrszXbW6RbIrO1T5SbJLZ0rocVNSuQzqMfWG2hPS2fVcKNnH5j5d+auuTK+1zlC7Ek8XRpAn2m5Uum+BCE8llgIqHN4M8it/C5tf506yn1qTk3mHvCNCRznZL7/Y+mAPSeuPf0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772787476; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2wxG85bxqISg5fGprH47ae5+SBTwx33p+Jlf56ZhTaA=; 
	b=WpGVPZJz2Zuv8BFviPPlfpbei240/hRpAtlvLVyior3CZH+vUfGWTux9dtMybVw1MuTZ9VaC0ZrAFvWvTtQFxRXX/koqZYMVAV5uNtyyqFXm9xFEEkKpHvWoplRvAE5IHLxInnWVaMH6HJ4yG/aDeNvWKsmMd2mk8ciZA+WJTm4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772787475;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2wxG85bxqISg5fGprH47ae5+SBTwx33p+Jlf56ZhTaA=;
	b=WtpwxM+aXzNYhzRuX1IS5yE+f3Vc2uPZa7vU2Nl34HkMa770dY0LCJ5h3sE56ZWZ
	LixYeTcGyI2rMMHkWJxHGsDo3Kkf/jm10BFhKIXQneIA32EK4Mv33AKf/OCSV8isutH
	/+jZBKEAQeRoylRbczaNwfGGcqO6tXCPPiwBLhok=
Received: by mx.zohomail.com with SMTPS id 1772787472814905.8825615197546;
	Fri, 6 Mar 2026 00:57:52 -0800 (PST)
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
Subject: [PATCH v4 0/4] jbd2/ext4/ocfs2: lockless jinode dirty range
Date: Fri,  6 Mar 2026 16:56:38 +0800
Message-ID: <20260306085643.465275-1-me@linux.beauty>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 70B0D21D8F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14677-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.beauty:dkim,linux.beauty:mid]
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

Changes since v3:
- Store i_dirty_end_page as an exclusive end page and drop the sentinel.
- Publish end_page before start_page and treat start_page >= end_page as
  empty.

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

v3: https://lore.kernel.org/all/20260224092434.202122-1-me@linux.beauty/
v2: https://lore.kernel.org/all/20260219114645.778338-1-me@linux.beauty/
v1: https://lore.kernel.org/all/20260130031232.60780-1-me@linux.beauty/

Li Chen (4):
  jbd2: add jinode dirty range accessors
  ext4: use jbd2 jinode dirty range accessor
  ocfs2: use jbd2 jinode dirty range accessor
  jbd2: store jinode dirty range in PAGE_SIZE units

 fs/ext4/inode.c       | 10 ++++++--
 fs/ext4/super.c       | 16 +++++++++----
 fs/jbd2/commit.c      | 55 +++++++++++++++++++++++++++++++++----------
 fs/jbd2/journal.c     |  5 ++--
 fs/jbd2/transaction.c | 21 +++++++++++------
 fs/ocfs2/journal.c    |  9 +++++--
 include/linux/jbd2.h  | 38 ++++++++++++++++++++++++------
 7 files changed, 115 insertions(+), 39 deletions(-)

-- 
2.53.0

