Return-Path: <linux-ext4+bounces-12420-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 867ADCCAA75
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B52693015979
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D722DA75F;
	Thu, 18 Dec 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mY+/oQpA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932E2D9EED;
	Thu, 18 Dec 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043031; cv=none; b=pb/JnlaR29Q/mpwWarkwZtiWxEzJKZgcDTlRtOo4H8WVarweLh5xmFtZLHir0LzoCjn/N/u7IffnOiXouMm/kBybBtljmhVOyUjX8H64kHvN0lHp12fV6E4osVPxI40fJzPoUD1wgmBACjAcyAoXf9433NwVHIdHMOsqFxpOJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043031; c=relaxed/simple;
	bh=1L7szd7F9zQGCRUSHN4QruGfcE+0rCo2qZ0+kJzMhQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAjpUcus81d1QcJYLCpehHf6Trlx5DCIEUMAQYoGlad9eyDFs0gtVdVetvwKu3a+rADWoWv+YGhQb1ve1Fok37Nw+QrQYU/SfZ0zpeqEiZFp2UYncIwDNvb5z7xF1q+M34FtX48Kwoxdd9rLr80uQs1gmReWpGJBf/84Dz0qGwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mY+/oQpA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bxwTn/7Zvok0/+ywZsS0GLmxuz4BBzavmdmKvUakBX0=; b=mY+/oQpAUGSlbQ5e0XKfeGjKsD
	6PfNSWpWqZJ/fYfrXdIL/Dm4/TiW3BFfKO9K9fKorIHM9RCdQs8UF5psg8vN/GVxNoMH0ADlwy+HT
	sgO4/i6bZCgP2RcUD0kkt8l2V2iPmgjSEH9jt9ctdn77STVz3GNEy4kaUNhZ2MZAltq993z95kX22
	YRA2QIpxwExvogypE6a4c2w+QrwDwY4yCsNMGBh49swkrDJJgc5RQdKA/9eyhbhx+8UrxFcywz+yn
	tQnRPGV+ZMpKLmpTbK3LLWTBpo9jvkpE0kYBdsG09lZIg6e/w5Vf25knjKyvhcIy2O0bEvfxWeAFs
	jak9fi8w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8Sy-00000007xYQ-0PUj;
	Thu, 18 Dec 2025 07:30:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: stop overriding SCRATCH_{,LOG,RT}DEV v3
Date: Thu, 18 Dec 2025 08:29:58 +0100
Message-ID: <20251218073023.1547648-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series cleans up various tests to get out of the business of
overriding the scratch devices setup.  This is not only generally a
little ugly, but breaks when mkfs options are incompatible with the
synthesized setups.

My prime example right now are two zoned XFS options:  -r rtreserved,
which only works for zoned RT devices, and breaks as soon as we're
running on non-RT or non-Zoned setups, and -r rtstart which only works
for internal RT zoned RT devices, and breaks as soon as an actual
SCRATCH_RTDEV was used.  There's probably more that we've been
papering over with the try_ options and by scratch_mkfs dropping
options when they conflict.  I plan to remove the need for the latter
in a follow-on series as it leads to hard to debug bugs.

Changes since v2:
 - fix the error table override in xfs/438
 - fix spelling in a commit log

Changes since v1:
 - pass a device to e2fsck in ext4/006
 - add a _require_scratch_size to xfs/521
 - ensure the file system is still mounted when checking it in xfs/528

