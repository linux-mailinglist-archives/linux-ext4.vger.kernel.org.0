Return-Path: <linux-ext4+bounces-12248-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20ECB2032
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 06:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27823304DEBA
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0F82EDD63;
	Wed, 10 Dec 2025 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6bOYIxm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA29277C8D;
	Wed, 10 Dec 2025 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345722; cv=none; b=t1jf/fL1qFIjDyAmA/q7HVjPOT4WzmRJK50nLeot0ynq++hkYwfzr8DcfIar0tVrlkNXlUIimq377uVGWNO4IP0eZRoicWi1Q5mD9kWr03HHDEQUD0Av//U7B70n9a2I9PxxjoOUKi00DZDErGWm+6O7E467SqmAPW7Ighh9ZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345722; c=relaxed/simple;
	bh=ScU+knU2DYhxcrArQpVSGQWCnc+9iHCa9eBJKtgt1fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYhRH0bXNezUZOnaWUYts00VSnS3ckNOFHRV0cRJxrr3F6BQVxiralT8f3Tvw9bQ4j9/XBjrm51axyvLDzhbYwagfYzG58ySIDSSBYZcKWtCxP4+LONFGX/4qAVUjeez32oOyHF0PGlr8Pz3iiBU3+shcZL4wO9uNx32AVIqIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i6bOYIxm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nKoFYaTth9To4A98PNzbKA2Q2w8kacJxcP4sUx2dxOA=; b=i6bOYIxmORIMrMJF6Do0SrNE9f
	9EXm3rIaxfR4Fk1H7hIYA6TGftA7yXxzqycjqJSO2gZjcKBsktkMEQsPeqo1NE8swZ7d9PByoTbzC
	oKEYJBTnlvaRqvawDB/FpqiOp8jRz6RitOopMLet4TmVKi0iffaNpBrU4M2JSv3iIFwS+XL/P78/+
	MieFLghT0M/5C6VIo5+EM5sJ1Y2GTQ1mwKON7Lge5ke9R+GFhfVjM+65l/C/bbj0eYQTzecOe5K9/
	MJ0ji4gb5/MijX6dH4Gy2BnLIkpXo9XV5/Wo20S1elp8iuX7g5U5sHEizv4g4VYGpzXyTtq2ORWH/
	M3fhemJg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTD40-0000000F93N-24Ub;
	Wed, 10 Dec 2025 05:48:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: stop overriding SCRATCH_{,LOG,RT}DEV
Date: Wed, 10 Dec 2025 06:46:46 +0100
Message-ID: <20251210054831.3469261-1-hch@lst.de>
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

