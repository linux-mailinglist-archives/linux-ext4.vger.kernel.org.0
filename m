Return-Path: <linux-ext4+bounces-12320-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F50CB83F9
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 09:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D805308182F
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFE930FC21;
	Fri, 12 Dec 2025 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0cORuJdp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E4030F7E3;
	Fri, 12 Dec 2025 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527758; cv=none; b=u2E4MV+ZXG38vpnBgij4OuKQz2WoRRrtajw7OfSh6ZrtMqsekawxkclEpiLlp2lmJq8n3FDQZyPnF4WMPSCuYdVxBpNgx8wOX3BSCZ3Xou773lA/APoFsM+5WBeA6YaJVO8qUnPNcEWg7VxNdHOgr1fx6c4TvpeUZqXRMR7op3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527758; c=relaxed/simple;
	bh=hz6DsYmmKw5qooqxEJZD7kxXlSky4cpXQDk93h9BRIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udAg0Sw9EMDNqeCCo9BJ/TCRcIXwrueNgKpJrOwZm999GMXABky8z6XElz389iqpVlC/ci875dUuxq3KRonQfAZpsAIGM9XHjHqlMzuLI6fy+N9Z/mxmCedPvOS8MfVccjNwNNV/uOIFVLZgVkj6KP1CgA883lMQ2ayOqaSxTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0cORuJdp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=H+yofAzEycGDLtWvX0SATI5Kno5s69wRu3yKRKrkdhs=; b=0cORuJdpKOMlO/vppb+vdTZQ0x
	oVbz60XEGPF6MsqJSmuvydvz3fuxs9FbvzME1ka4rp/ldHP4w4KiUQKGcFckxUBPmZKAI4YA1/btF
	zt7dRw9oILvadGHwXpqSe1yJBQNFOPu+MNrF1ZDUTHgJmRxscZpFFO9N1SiwitGR/RUj9puQBObOm
	XuRsle0knU5qv7h12DYith/EAukTTJIpGQBGbJsstVXo8hospNuCrHHlqbzTfws9DgSDjkICKMgfC
	Nl/xKoEsdWHzKKoEEEgHLCLP4YHpTW0krSpyQ/unbTpzYwDqMqpe0V2DGgQILjV426eodq0bLzEKh
	ZfaVw6kw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTyQ6-00000000G7a-18nh;
	Fri, 12 Dec 2025 08:22:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 04/13] ext4/032: use _check_dev_fs
Date: Fri, 12 Dec 2025 09:21:52 +0100
Message-ID: <20251212082210.23401-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251212082210.23401-1-hch@lst.de>
References: <20251212082210.23401-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

_check_dev_fs is the new designated helper to check file systems on
arbitrary devices, use that instead of _check_generic_filesystem, which
is just an implementation detail.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/ext4/032 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/032 b/tests/ext4/032
index 690fcf066c11..043ae4f53505 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -66,7 +66,7 @@ ext4_online_resize()
 	$UMOUNT_PROG ${IMG_MNT}
 
 	echo "+++ check fs" | tee -a $seqres.full
-	_check_generic_filesystem $LOOP_DEVICE >> $seqres.full 2>&1 || \
+	_check_dev_fs $LOOP_DEVICE >> $seqres.full 2>&1 || \
 		_fail "fsck should not fail"
 	_destroy_loop_device $LOOP_DEVICE && LOOP_DEVICE=
 }
-- 
2.47.3


