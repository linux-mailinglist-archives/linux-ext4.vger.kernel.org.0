Return-Path: <linux-ext4+bounces-2927-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE81913A6E
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 14:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83116B210F2
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D71180A9B;
	Sun, 23 Jun 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aajew2oo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94853180A92;
	Sun, 23 Jun 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144716; cv=none; b=L1AzCVznqcwxwd4hulev3tP3gXY1eQyJKxcRumUIeq0w1jkNfGJzulK80Cx1huvSZC8Nh0QfZi+vZKSeHwfrvRhTpP1kzsDOAdSE4wqtNzODnEuwmRxBqcin3uS6gG8d1TLLHBuGk83Dx+1n+HKbgc7mWXkrFLN+fM7o9qehlNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144716; c=relaxed/simple;
	bh=Sp7SuIMS0y1Y4dNRvHyi4SeB0n6MBFQl5OxgYj+mlw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsRpY9EgLLcW1grPVpOJYw51nzoXHDi5qQrX3oneUdWeorQ9gy/OTzWnZXjzz2r3AYjadpVKebv7vr0x/q/uDTzIO2jWd5C06b4dBtz8EpTcodrbtzaGLzHTLDNPWz09s1C0LMPy+v+uCg/KhiIpDl2VsuWKSgdS86apjcbDQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aajew2oo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Qe2t5JSBNJevtSwr5tdqhU84c6CgLEh2/NReDZyqtZQ=; b=aajew2ooH1VBiAHWqWtsi/V2Ph
	thIExVv25Wfc/6BKlWaMT95q9E5RhIOaK6EnSB5bviM+v7kWhrVYJEO0oz2bN9I/7MEDQxDOnguUl
	/cwb4VBErB82O0pJILlvpIrg8rysYExWnzVop5oFqsiQVy3wwwqSPqouxYf/JeJ+7nFnIcHZZ5UhX
	IdSra8XrB99425Zt5EodD2dxatjfnKHfMZCzYmpVsy1BK0leRi7gdX/f3SXTrRQIlFIARPJU1WuQw
	w+2bTUda7p8Ug8cBSzTkoGKfP7cqq9W0dCsR+iGXBHL8z3JU9BPmUDYyJlR1BRnAxoELrcK0MMZyH
	6tL680Mg==;
Received: from 2a02-8389-2341-5b80-9456-578d-194f-dacd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9456:578d:194f:dacd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLM48-0000000Dx1H-2w2K;
	Sun, 23 Jun 2024 12:11:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 8/8] remove spurious _supported_fs calls
Date: Sun, 23 Jun 2024 14:10:37 +0200
Message-ID: <20240623121103.974270-9-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623121103.974270-1-hch@lst.de>
References: <20240623121103.974270-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Remove _supported_fs calls for generic in the generic directory
or for $FSTYP in the $FSTYP directory.

This leaves us with the negative checks, and the overloaded ext4
directory where some tests can also be run for ext2 and ext3.

While at it also remove the pointless "real QA test starts here"
usually placed right next to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 new               | 3 ---
 tests/btrfs/001   | 1 -
 tests/btrfs/002   | 1 -
 tests/btrfs/003   | 1 -
 tests/btrfs/004   | 1 -
 tests/btrfs/005   | 1 -
 tests/btrfs/006   | 1 -
 tests/btrfs/007   | 1 -
 tests/btrfs/008   | 1 -
 tests/btrfs/009   | 1 -
 tests/btrfs/010   | 1 -
 tests/btrfs/011   | 1 -
 tests/btrfs/012   | 1 -
 tests/btrfs/013   | 1 -
 tests/btrfs/014   | 1 -
 tests/btrfs/015   | 1 -
 tests/btrfs/016   | 1 -
 tests/btrfs/017   | 1 -
 tests/btrfs/018   | 1 -
 tests/btrfs/019   | 1 -
 tests/btrfs/020   | 1 -
 tests/btrfs/021   | 1 -
 tests/btrfs/022   | 1 -
 tests/btrfs/023   | 1 -
 tests/btrfs/024   | 1 -
 tests/btrfs/025   | 1 -
 tests/btrfs/026   | 1 -
 tests/btrfs/027   | 1 -
 tests/btrfs/028   | 1 -
 tests/btrfs/029   | 1 -
 tests/btrfs/030   | 1 -
 tests/btrfs/031   | 1 -
 tests/btrfs/032   | 1 -
 tests/btrfs/033   | 1 -
 tests/btrfs/034   | 1 -
 tests/btrfs/035   | 1 -
 tests/btrfs/036   | 1 -
 tests/btrfs/037   | 1 -
 tests/btrfs/038   | 1 -
 tests/btrfs/039   | 1 -
 tests/btrfs/040   | 1 -
 tests/btrfs/041   | 1 -
 tests/btrfs/042   | 1 -
 tests/btrfs/043   | 1 -
 tests/btrfs/044   | 1 -
 tests/btrfs/045   | 1 -
 tests/btrfs/046   | 1 -
 tests/btrfs/047   | 1 -
 tests/btrfs/048   | 1 -
 tests/btrfs/049   | 1 -
 tests/btrfs/050   | 1 -
 tests/btrfs/051   | 1 -
 tests/btrfs/052   | 1 -
 tests/btrfs/053   | 1 -
 tests/btrfs/054   | 1 -
 tests/btrfs/055   | 1 -
 tests/btrfs/056   | 1 -
 tests/btrfs/057   | 1 -
 tests/btrfs/058   | 1 -
 tests/btrfs/059   | 1 -
 tests/btrfs/060   | 1 -
 tests/btrfs/061   | 1 -
 tests/btrfs/062   | 1 -
 tests/btrfs/063   | 1 -
 tests/btrfs/064   | 1 -
 tests/btrfs/065   | 1 -
 tests/btrfs/066   | 1 -
 tests/btrfs/067   | 1 -
 tests/btrfs/068   | 1 -
 tests/btrfs/069   | 1 -
 tests/btrfs/070   | 1 -
 tests/btrfs/071   | 1 -
 tests/btrfs/072   | 1 -
 tests/btrfs/073   | 1 -
 tests/btrfs/074   | 1 -
 tests/btrfs/075   | 1 -
 tests/btrfs/076   | 1 -
 tests/btrfs/077   | 1 -
 tests/btrfs/078   | 1 -
 tests/btrfs/079   | 1 -
 tests/btrfs/080   | 1 -
 tests/btrfs/081   | 1 -
 tests/btrfs/082   | 1 -
 tests/btrfs/083   | 1 -
 tests/btrfs/084   | 1 -
 tests/btrfs/085   | 1 -
 tests/btrfs/086   | 1 -
 tests/btrfs/087   | 1 -
 tests/btrfs/088   | 1 -
 tests/btrfs/089   | 1 -
 tests/btrfs/090   | 1 -
 tests/btrfs/091   | 1 -
 tests/btrfs/092   | 1 -
 tests/btrfs/093   | 1 -
 tests/btrfs/094   | 1 -
 tests/btrfs/095   | 1 -
 tests/btrfs/096   | 1 -
 tests/btrfs/097   | 1 -
 tests/btrfs/098   | 1 -
 tests/btrfs/099   | 1 -
 tests/btrfs/100   | 1 -
 tests/btrfs/101   | 1 -
 tests/btrfs/102   | 1 -
 tests/btrfs/103   | 1 -
 tests/btrfs/104   | 1 -
 tests/btrfs/105   | 1 -
 tests/btrfs/106   | 1 -
 tests/btrfs/107   | 1 -
 tests/btrfs/108   | 1 -
 tests/btrfs/109   | 1 -
 tests/btrfs/110   | 1 -
 tests/btrfs/111   | 1 -
 tests/btrfs/112   | 1 -
 tests/btrfs/113   | 1 -
 tests/btrfs/114   | 1 -
 tests/btrfs/115   | 1 -
 tests/btrfs/116   | 1 -
 tests/btrfs/117   | 1 -
 tests/btrfs/118   | 1 -
 tests/btrfs/119   | 1 -
 tests/btrfs/120   | 1 -
 tests/btrfs/121   | 1 -
 tests/btrfs/122   | 1 -
 tests/btrfs/123   | 1 -
 tests/btrfs/124   | 1 -
 tests/btrfs/125   | 1 -
 tests/btrfs/126   | 1 -
 tests/btrfs/127   | 1 -
 tests/btrfs/128   | 1 -
 tests/btrfs/129   | 1 -
 tests/btrfs/130   | 1 -
 tests/btrfs/131   | 1 -
 tests/btrfs/132   | 1 -
 tests/btrfs/133   | 1 -
 tests/btrfs/134   | 1 -
 tests/btrfs/135   | 1 -
 tests/btrfs/136   | 1 -
 tests/btrfs/137   | 1 -
 tests/btrfs/138   | 1 -
 tests/btrfs/139   | 1 -
 tests/btrfs/140   | 1 -
 tests/btrfs/141   | 1 -
 tests/btrfs/142   | 1 -
 tests/btrfs/143   | 1 -
 tests/btrfs/144   | 1 -
 tests/btrfs/145   | 1 -
 tests/btrfs/146   | 1 -
 tests/btrfs/147   | 1 -
 tests/btrfs/148   | 1 -
 tests/btrfs/149   | 1 -
 tests/btrfs/150   | 1 -
 tests/btrfs/151   | 1 -
 tests/btrfs/152   | 1 -
 tests/btrfs/153   | 1 -
 tests/btrfs/154   | 1 -
 tests/btrfs/155   | 1 -
 tests/btrfs/156   | 1 -
 tests/btrfs/157   | 1 -
 tests/btrfs/158   | 1 -
 tests/btrfs/159   | 1 -
 tests/btrfs/160   | 1 -
 tests/btrfs/161   | 1 -
 tests/btrfs/162   | 1 -
 tests/btrfs/163   | 1 -
 tests/btrfs/164   | 1 -
 tests/btrfs/165   | 1 -
 tests/btrfs/166   | 1 -
 tests/btrfs/167   | 1 -
 tests/btrfs/168   | 1 -
 tests/btrfs/169   | 1 -
 tests/btrfs/170   | 1 -
 tests/btrfs/171   | 1 -
 tests/btrfs/172   | 1 -
 tests/btrfs/173   | 1 -
 tests/btrfs/174   | 1 -
 tests/btrfs/175   | 1 -
 tests/btrfs/176   | 1 -
 tests/btrfs/177   | 1 -
 tests/btrfs/178   | 1 -
 tests/btrfs/179   | 1 -
 tests/btrfs/180   | 1 -
 tests/btrfs/181   | 1 -
 tests/btrfs/182   | 1 -
 tests/btrfs/183   | 1 -
 tests/btrfs/184   | 1 -
 tests/btrfs/185   | 1 -
 tests/btrfs/186   | 1 -
 tests/btrfs/187   | 1 -
 tests/btrfs/188   | 1 -
 tests/btrfs/189   | 1 -
 tests/btrfs/190   | 1 -
 tests/btrfs/191   | 1 -
 tests/btrfs/192   | 1 -
 tests/btrfs/193   | 1 -
 tests/btrfs/194   | 1 -
 tests/btrfs/195   | 1 -
 tests/btrfs/196   | 1 -
 tests/btrfs/197   | 1 -
 tests/btrfs/198   | 1 -
 tests/btrfs/199   | 1 -
 tests/btrfs/200   | 1 -
 tests/btrfs/201   | 1 -
 tests/btrfs/202   | 1 -
 tests/btrfs/203   | 1 -
 tests/btrfs/204   | 1 -
 tests/btrfs/205   | 1 -
 tests/btrfs/206   | 1 -
 tests/btrfs/207   | 1 -
 tests/btrfs/208   | 1 -
 tests/btrfs/209   | 1 -
 tests/btrfs/210   | 1 -
 tests/btrfs/211   | 1 -
 tests/btrfs/212   | 1 -
 tests/btrfs/213   | 1 -
 tests/btrfs/214   | 1 -
 tests/btrfs/215   | 1 -
 tests/btrfs/216   | 1 -
 tests/btrfs/217   | 1 -
 tests/btrfs/218   | 1 -
 tests/btrfs/219   | 1 -
 tests/btrfs/220   | 1 -
 tests/btrfs/221   | 1 -
 tests/btrfs/222   | 1 -
 tests/btrfs/223   | 1 -
 tests/btrfs/224   | 1 -
 tests/btrfs/225   | 1 -
 tests/btrfs/226   | 1 -
 tests/btrfs/227   | 1 -
 tests/btrfs/228   | 1 -
 tests/btrfs/229   | 1 -
 tests/btrfs/230   | 1 -
 tests/btrfs/231   | 1 -
 tests/btrfs/232   | 1 -
 tests/btrfs/233   | 1 -
 tests/btrfs/234   | 1 -
 tests/btrfs/235   | 1 -
 tests/btrfs/236   | 1 -
 tests/btrfs/237   | 1 -
 tests/btrfs/238   | 1 -
 tests/btrfs/239   | 1 -
 tests/btrfs/240   | 1 -
 tests/btrfs/241   | 1 -
 tests/btrfs/242   | 1 -
 tests/btrfs/243   | 1 -
 tests/btrfs/244   | 1 -
 tests/btrfs/245   | 1 -
 tests/btrfs/246   | 1 -
 tests/btrfs/247   | 1 -
 tests/btrfs/248   | 1 -
 tests/btrfs/249   | 1 -
 tests/btrfs/250   | 1 -
 tests/btrfs/251   | 1 -
 tests/btrfs/252   | 1 -
 tests/btrfs/253   | 1 -
 tests/btrfs/254   | 1 -
 tests/btrfs/255   | 1 -
 tests/btrfs/256   | 1 -
 tests/btrfs/257   | 1 -
 tests/btrfs/258   | 1 -
 tests/btrfs/259   | 1 -
 tests/btrfs/260   | 1 -
 tests/btrfs/261   | 1 -
 tests/btrfs/262   | 1 -
 tests/btrfs/263   | 1 -
 tests/btrfs/264   | 1 -
 tests/btrfs/265   | 1 -
 tests/btrfs/266   | 1 -
 tests/btrfs/267   | 1 -
 tests/btrfs/268   | 1 -
 tests/btrfs/269   | 1 -
 tests/btrfs/270   | 1 -
 tests/btrfs/271   | 1 -
 tests/btrfs/272   | 1 -
 tests/btrfs/273   | 1 -
 tests/btrfs/274   | 1 -
 tests/btrfs/275   | 1 -
 tests/btrfs/276   | 1 -
 tests/btrfs/277   | 1 -
 tests/btrfs/278   | 1 -
 tests/btrfs/279   | 1 -
 tests/btrfs/280   | 1 -
 tests/btrfs/281   | 1 -
 tests/btrfs/282   | 1 -
 tests/btrfs/283   | 1 -
 tests/btrfs/284   | 1 -
 tests/btrfs/285   | 1 -
 tests/btrfs/286   | 1 -
 tests/btrfs/287   | 1 -
 tests/btrfs/288   | 1 -
 tests/btrfs/289   | 1 -
 tests/btrfs/290   | 1 -
 tests/btrfs/291   | 1 -
 tests/btrfs/292   | 1 -
 tests/btrfs/293   | 1 -
 tests/btrfs/294   | 1 -
 tests/btrfs/295   | 1 -
 tests/btrfs/296   | 1 -
 tests/btrfs/297   | 1 -
 tests/btrfs/298   | 1 -
 tests/btrfs/299   | 1 -
 tests/btrfs/300   | 1 -
 tests/btrfs/301   | 1 -
 tests/btrfs/302   | 1 -
 tests/btrfs/303   | 1 -
 tests/btrfs/304   | 1 -
 tests/btrfs/305   | 1 -
 tests/btrfs/306   | 1 -
 tests/btrfs/307   | 1 -
 tests/btrfs/308   | 1 -
 tests/btrfs/309   | 1 -
 tests/btrfs/310   | 1 -
 tests/btrfs/311   | 1 -
 tests/btrfs/313   | 1 -
 tests/btrfs/314   | 1 -
 tests/btrfs/315   | 1 -
 tests/btrfs/316   | 1 -
 tests/btrfs/317   | 1 -
 tests/btrfs/318   | 2 --
 tests/btrfs/320   | 1 -
 tests/btrfs/330   | 2 --
 tests/ceph/001    | 2 --
 tests/ceph/002    | 2 --
 tests/ceph/003    | 2 --
 tests/ceph/004    | 2 --
 tests/ceph/005    | 1 -
 tests/cifs/001    | 2 --
 tests/ext4/001    | 1 -
 tests/ext4/002    | 1 -
 tests/ext4/003    | 1 -
 tests/ext4/004    | 1 -
 tests/ext4/005    | 1 -
 tests/ext4/006    | 1 -
 tests/ext4/007    | 1 -
 tests/ext4/008    | 1 -
 tests/ext4/009    | 1 -
 tests/ext4/010    | 1 -
 tests/ext4/011    | 1 -
 tests/ext4/012    | 1 -
 tests/ext4/013    | 1 -
 tests/ext4/014    | 1 -
 tests/ext4/015    | 1 -
 tests/ext4/016    | 1 -
 tests/ext4/017    | 1 -
 tests/ext4/018    | 1 -
 tests/ext4/019    | 1 -
 tests/ext4/020    | 1 -
 tests/ext4/021    | 1 -
 tests/ext4/022    | 1 -
 tests/ext4/023    | 1 -
 tests/ext4/024    | 1 -
 tests/ext4/025    | 1 -
 tests/ext4/026    | 1 -
 tests/ext4/027    | 1 -
 tests/ext4/028    | 1 -
 tests/ext4/029    | 1 -
 tests/ext4/030    | 1 -
 tests/ext4/031    | 1 -
 tests/ext4/032    | 1 -
 tests/ext4/033    | 1 -
 tests/ext4/034    | 1 -
 tests/ext4/035    | 1 -
 tests/ext4/036    | 1 -
 tests/ext4/037    | 1 -
 tests/ext4/038    | 1 -
 tests/ext4/039    | 1 -
 tests/ext4/040    | 1 -
 tests/ext4/041    | 1 -
 tests/ext4/042    | 1 -
 tests/ext4/043    | 1 -
 tests/ext4/044    | 1 -
 tests/ext4/045    | 1 -
 tests/ext4/047    | 1 -
 tests/ext4/048    | 1 -
 tests/ext4/049    | 1 -
 tests/ext4/050    | 1 -
 tests/ext4/051    | 1 -
 tests/ext4/052    | 1 -
 tests/ext4/054    | 1 -
 tests/ext4/055    | 1 -
 tests/ext4/056    | 1 -
 tests/ext4/057    | 1 -
 tests/ext4/058    | 1 -
 tests/ext4/059    | 1 -
 tests/ext4/271    | 1 -
 tests/ext4/301    | 1 -
 tests/ext4/302    | 1 -
 tests/ext4/303    | 1 -
 tests/ext4/304    | 1 -
 tests/ext4/305    | 1 -
 tests/ext4/306    | 1 -
 tests/ext4/307    | 2 --
 tests/ext4/308    | 1 -
 tests/f2fs/001    | 1 -
 tests/f2fs/002    | 2 --
 tests/generic/001 | 2 --
 tests/generic/002 | 2 --
 tests/generic/003 | 2 --
 tests/generic/004 | 2 --
 tests/generic/005 | 2 --
 tests/generic/006 | 2 --
 tests/generic/007 | 2 --
 tests/generic/008 | 1 -
 tests/generic/009 | 1 -
 tests/generic/010 | 2 --
 tests/generic/011 | 2 --
 tests/generic/012 | 2 --
 tests/generic/013 | 2 --
 tests/generic/014 | 1 -
 tests/generic/015 | 2 --
 tests/generic/016 | 2 --
 tests/generic/017 | 2 --
 tests/generic/018 | 2 --
 tests/generic/019 | 2 --
 tests/generic/020 | 2 --
 tests/generic/021 | 2 --
 tests/generic/022 | 2 --
 tests/generic/023 | 2 --
 tests/generic/024 | 2 --
 tests/generic/025 | 2 --
 tests/generic/026 | 2 --
 tests/generic/027 | 2 --
 tests/generic/028 | 2 --
 tests/generic/029 | 2 --
 tests/generic/030 | 2 --
 tests/generic/031 | 2 --
 tests/generic/032 | 2 --
 tests/generic/033 | 2 --
 tests/generic/034 | 2 --
 tests/generic/035 | 2 --
 tests/generic/036 | 2 --
 tests/generic/037 | 2 --
 tests/generic/038 | 2 --
 tests/generic/039 | 2 --
 tests/generic/040 | 2 --
 tests/generic/041 | 2 --
 tests/generic/042 | 2 --
 tests/generic/043 | 2 --
 tests/generic/044 | 2 --
 tests/generic/045 | 2 --
 tests/generic/046 | 2 --
 tests/generic/047 | 2 --
 tests/generic/048 | 2 --
 tests/generic/049 | 2 --
 tests/generic/050 | 2 --
 tests/generic/051 | 2 --
 tests/generic/052 | 2 --
 tests/generic/053 | 2 --
 tests/generic/054 | 2 --
 tests/generic/055 | 2 --
 tests/generic/056 | 2 --
 tests/generic/057 | 2 --
 tests/generic/058 | 2 --
 tests/generic/059 | 2 --
 tests/generic/060 | 2 --
 tests/generic/061 | 2 --
 tests/generic/062 | 3 ---
 tests/generic/063 | 2 --
 tests/generic/064 | 2 --
 tests/generic/065 | 2 --
 tests/generic/066 | 2 --
 tests/generic/067 | 2 --
 tests/generic/068 | 2 --
 tests/generic/069 | 2 --
 tests/generic/070 | 2 --
 tests/generic/071 | 2 --
 tests/generic/072 | 2 --
 tests/generic/073 | 2 --
 tests/generic/074 | 1 -
 tests/generic/075 | 2 --
 tests/generic/076 | 2 --
 tests/generic/077 | 2 --
 tests/generic/078 | 2 --
 tests/generic/079 | 2 --
 tests/generic/080 | 2 --
 tests/generic/081 | 2 --
 tests/generic/082 | 2 --
 tests/generic/083 | 2 --
 tests/generic/084 | 2 --
 tests/generic/085 | 2 --
 tests/generic/086 | 2 --
 tests/generic/087 | 2 --
 tests/generic/088 | 2 --
 tests/generic/089 | 2 --
 tests/generic/090 | 2 --
 tests/generic/091 | 2 --
 tests/generic/092 | 2 --
 tests/generic/093 | 2 --
 tests/generic/094 | 2 --
 tests/generic/095 | 2 --
 tests/generic/096 | 2 --
 tests/generic/097 | 2 --
 tests/generic/098 | 2 --
 tests/generic/099 | 2 --
 tests/generic/100 | 2 --
 tests/generic/101 | 2 --
 tests/generic/102 | 2 --
 tests/generic/103 | 2 --
 tests/generic/104 | 2 --
 tests/generic/105 | 2 --
 tests/generic/106 | 2 --
 tests/generic/107 | 2 --
 tests/generic/108 | 2 --
 tests/generic/109 | 2 --
 tests/generic/110 | 1 -
 tests/generic/111 | 1 -
 tests/generic/112 | 2 --
 tests/generic/113 | 2 --
 tests/generic/114 | 1 -
 tests/generic/115 | 1 -
 tests/generic/116 | 1 -
 tests/generic/117 | 2 --
 tests/generic/118 | 1 -
 tests/generic/119 | 1 -
 tests/generic/120 | 2 --
 tests/generic/121 | 1 -
 tests/generic/122 | 1 -
 tests/generic/123 | 2 --
 tests/generic/124 | 2 --
 tests/generic/125 | 2 --
 tests/generic/126 | 2 --
 tests/generic/127 | 2 --
 tests/generic/128 | 2 --
 tests/generic/129 | 2 --
 tests/generic/130 | 2 --
 tests/generic/131 | 2 --
 tests/generic/132 | 2 --
 tests/generic/133 | 2 --
 tests/generic/134 | 1 -
 tests/generic/135 | 2 --
 tests/generic/136 | 1 -
 tests/generic/137 | 1 -
 tests/generic/138 | 1 -
 tests/generic/139 | 1 -
 tests/generic/140 | 1 -
 tests/generic/141 | 2 --
 tests/generic/142 | 1 -
 tests/generic/143 | 1 -
 tests/generic/144 | 1 -
 tests/generic/145 | 1 -
 tests/generic/146 | 1 -
 tests/generic/147 | 1 -
 tests/generic/148 | 1 -
 tests/generic/149 | 1 -
 tests/generic/150 | 1 -
 tests/generic/151 | 1 -
 tests/generic/152 | 1 -
 tests/generic/153 | 1 -
 tests/generic/154 | 1 -
 tests/generic/155 | 1 -
 tests/generic/156 | 1 -
 tests/generic/157 | 1 -
 tests/generic/158 | 1 -
 tests/generic/159 | 1 -
 tests/generic/160 | 1 -
 tests/generic/161 | 1 -
 tests/generic/162 | 1 -
 tests/generic/163 | 1 -
 tests/generic/164 | 1 -
 tests/generic/165 | 1 -
 tests/generic/166 | 1 -
 tests/generic/167 | 1 -
 tests/generic/168 | 1 -
 tests/generic/169 | 2 --
 tests/generic/170 | 1 -
 tests/generic/171 | 1 -
 tests/generic/172 | 1 -
 tests/generic/173 | 1 -
 tests/generic/174 | 1 -
 tests/generic/175 | 1 -
 tests/generic/176 | 1 -
 tests/generic/177 | 2 --
 tests/generic/178 | 1 -
 tests/generic/179 | 1 -
 tests/generic/180 | 1 -
 tests/generic/181 | 1 -
 tests/generic/182 | 1 -
 tests/generic/183 | 1 -
 tests/generic/184 | 2 --
 tests/generic/185 | 1 -
 tests/generic/186 | 1 -
 tests/generic/187 | 1 -
 tests/generic/188 | 1 -
 tests/generic/189 | 1 -
 tests/generic/190 | 1 -
 tests/generic/191 | 1 -
 tests/generic/192 | 2 --
 tests/generic/193 | 2 --
 tests/generic/194 | 1 -
 tests/generic/195 | 1 -
 tests/generic/196 | 1 -
 tests/generic/197 | 1 -
 tests/generic/198 | 2 --
 tests/generic/199 | 1 -
 tests/generic/200 | 1 -
 tests/generic/201 | 1 -
 tests/generic/202 | 1 -
 tests/generic/203 | 1 -
 tests/generic/204 | 2 --
 tests/generic/205 | 1 -
 tests/generic/206 | 1 -
 tests/generic/207 | 2 --
 tests/generic/208 | 2 --
 tests/generic/209 | 2 --
 tests/generic/210 | 2 --
 tests/generic/211 | 2 --
 tests/generic/212 | 2 --
 tests/generic/213 | 2 --
 tests/generic/214 | 2 --
 tests/generic/215 | 2 --
 tests/generic/216 | 1 -
 tests/generic/217 | 1 -
 tests/generic/218 | 1 -
 tests/generic/219 | 3 ---
 tests/generic/220 | 1 -
 tests/generic/221 | 2 --
 tests/generic/222 | 1 -
 tests/generic/223 | 2 --
 tests/generic/224 | 2 --
 tests/generic/225 | 2 --
 tests/generic/226 | 2 --
 tests/generic/227 | 1 -
 tests/generic/228 | 2 --
 tests/generic/229 | 1 -
 tests/generic/230 | 3 ---
 tests/generic/231 | 2 --
 tests/generic/232 | 2 --
 tests/generic/233 | 2 --
 tests/generic/234 | 3 ---
 tests/generic/235 | 3 ---
 tests/generic/236 | 2 --
 tests/generic/237 | 2 --
 tests/generic/238 | 1 -
 tests/generic/239 | 1 -
 tests/generic/240 | 2 --
 tests/generic/241 | 2 --
 tests/generic/242 | 1 -
 tests/generic/243 | 1 -
 tests/generic/244 | 2 --
 tests/generic/245 | 2 --
 tests/generic/246 | 2 --
 tests/generic/247 | 2 --
 tests/generic/248 | 2 --
 tests/generic/249 | 2 --
 tests/generic/250 | 1 -
 tests/generic/251 | 2 --
 tests/generic/252 | 1 -
 tests/generic/253 | 1 -
 tests/generic/254 | 1 -
 tests/generic/255 | 3 ---
 tests/generic/256 | 2 --
 tests/generic/257 | 2 --
 tests/generic/258 | 2 --
 tests/generic/259 | 1 -
 tests/generic/260 | 2 --
 tests/generic/261 | 1 -
 tests/generic/262 | 1 -
 tests/generic/263 | 2 --
 tests/generic/264 | 1 -
 tests/generic/265 | 1 -
 tests/generic/266 | 1 -
 tests/generic/267 | 1 -
 tests/generic/268 | 1 -
 tests/generic/269 | 2 --
 tests/generic/270 | 2 --
 tests/generic/271 | 1 -
 tests/generic/272 | 1 -
 tests/generic/273 | 2 --
 tests/generic/274 | 2 --
 tests/generic/275 | 2 --
 tests/generic/276 | 1 -
 tests/generic/277 | 2 --
 tests/generic/278 | 1 -
 tests/generic/279 | 1 -
 tests/generic/280 | 2 --
 tests/generic/281 | 1 -
 tests/generic/282 | 1 -
 tests/generic/283 | 1 -
 tests/generic/284 | 1 -
 tests/generic/285 | 1 -
 tests/generic/286 | 2 --
 tests/generic/287 | 1 -
 tests/generic/288 | 2 --
 tests/generic/289 | 1 -
 tests/generic/290 | 1 -
 tests/generic/291 | 1 -
 tests/generic/292 | 1 -
 tests/generic/293 | 1 -
 tests/generic/294 | 1 -
 tests/generic/295 | 1 -
 tests/generic/296 | 1 -
 tests/generic/297 | 1 -
 tests/generic/298 | 1 -
 tests/generic/299 | 2 --
 tests/generic/300 | 2 --
 tests/generic/301 | 1 -
 tests/generic/302 | 1 -
 tests/generic/303 | 1 -
 tests/generic/304 | 1 -
 tests/generic/305 | 1 -
 tests/generic/306 | 2 --
 tests/generic/307 | 2 --
 tests/generic/308 | 2 --
 tests/generic/309 | 2 --
 tests/generic/310 | 2 --
 tests/generic/311 | 2 --
 tests/generic/312 | 2 --
 tests/generic/313 | 2 --
 tests/generic/314 | 2 --
 tests/generic/315 | 2 --
 tests/generic/316 | 2 --
 tests/generic/317 | 2 --
 tests/generic/318 | 2 --
 tests/generic/319 | 2 --
 tests/generic/320 | 2 --
 tests/generic/321 | 2 --
 tests/generic/322 | 2 --
 tests/generic/323 | 2 --
 tests/generic/324 | 1 -
 tests/generic/325 | 2 --
 tests/generic/326 | 1 -
 tests/generic/327 | 1 -
 tests/generic/328 | 1 -
 tests/generic/329 | 1 -
 tests/generic/330 | 1 -
 tests/generic/331 | 1 -
 tests/generic/332 | 1 -
 tests/generic/333 | 1 -
 tests/generic/334 | 1 -
 tests/generic/335 | 2 --
 tests/generic/336 | 2 --
 tests/generic/337 | 2 --
 tests/generic/338 | 2 --
 tests/generic/339 | 2 --
 tests/generic/340 | 2 --
 tests/generic/341 | 2 --
 tests/generic/342 | 2 --
 tests/generic/343 | 2 --
 tests/generic/344 | 2 --
 tests/generic/345 | 2 --
 tests/generic/346 | 2 --
 tests/generic/347 | 1 -
 tests/generic/348 | 2 --
 tests/generic/349 | 1 -
 tests/generic/350 | 1 -
 tests/generic/351 | 1 -
 tests/generic/352 | 2 --
 tests/generic/353 | 2 --
 tests/generic/354 | 2 --
 tests/generic/355 | 2 --
 tests/generic/356 | 1 -
 tests/generic/357 | 1 -
 tests/generic/358 | 1 -
 tests/generic/359 | 1 -
 tests/generic/360 | 2 --
 tests/generic/361 | 2 --
 tests/generic/371 | 1 -
 tests/generic/372 | 2 --
 tests/generic/373 | 2 --
 tests/generic/374 | 2 --
 tests/generic/375 | 2 --
 tests/generic/376 | 2 --
 tests/generic/377 | 2 --
 tests/generic/378 | 2 --
 tests/generic/379 | 2 --
 tests/generic/380 | 2 --
 tests/generic/381 | 2 --
 tests/generic/382 | 2 --
 tests/generic/383 | 2 --
 tests/generic/384 | 2 --
 tests/generic/385 | 2 --
 tests/generic/386 | 2 --
 tests/generic/387 | 1 -
 tests/generic/388 | 1 -
 tests/generic/389 | 2 --
 tests/generic/390 | 2 --
 tests/generic/391 | 2 --
 tests/generic/392 | 2 --
 tests/generic/393 | 1 -
 tests/generic/394 | 2 --
 tests/generic/395 | 2 --
 tests/generic/396 | 2 --
 tests/generic/397 | 2 --
 tests/generic/398 | 2 --
 tests/generic/399 | 2 --
 tests/generic/400 | 2 --
 tests/generic/401 | 2 --
 tests/generic/402 | 1 -
 tests/generic/403 | 2 --
 tests/generic/404 | 2 --
 tests/generic/405 | 2 --
 tests/generic/406 | 2 --
 tests/generic/407 | 2 --
 tests/generic/408 | 2 --
 tests/generic/409 | 2 --
 tests/generic/410 | 2 --
 tests/generic/411 | 2 --
 tests/generic/412 | 2 --
 tests/generic/413 | 1 -
 tests/generic/414 | 2 --
 tests/generic/415 | 2 --
 tests/generic/416 | 2 --
 tests/generic/417 | 2 --
 tests/generic/418 | 2 --
 tests/generic/419 | 2 --
 tests/generic/420 | 2 --
 tests/generic/421 | 2 --
 tests/generic/422 | 2 --
 tests/generic/423 | 2 --
 tests/generic/424 | 2 --
 tests/generic/425 | 2 --
 tests/generic/426 | 2 --
 tests/generic/427 | 2 --
 tests/generic/428 | 2 --
 tests/generic/429 | 2 --
 tests/generic/430 | 2 --
 tests/generic/431 | 2 --
 tests/generic/432 | 2 --
 tests/generic/433 | 2 --
 tests/generic/434 | 2 --
 tests/generic/435 | 2 --
 tests/generic/436 | 1 -
 tests/generic/437 | 2 --
 tests/generic/438 | 2 --
 tests/generic/439 | 2 --
 tests/generic/440 | 2 --
 tests/generic/441 | 1 -
 tests/generic/442 | 1 -
 tests/generic/443 | 2 --
 tests/generic/444 | 2 --
 tests/generic/445 | 1 -
 tests/generic/446 | 1 -
 tests/generic/447 | 1 -
 tests/generic/448 | 1 -
 tests/generic/449 | 2 --
 tests/generic/450 | 2 --
 tests/generic/451 | 2 --
 tests/generic/452 | 2 --
 tests/generic/455 | 2 --
 tests/generic/456 | 2 --
 tests/generic/457 | 2 --
 tests/generic/458 | 2 --
 tests/generic/459 | 2 --
 tests/generic/460 | 2 --
 tests/generic/461 | 2 --
 tests/generic/462 | 2 --
 tests/generic/463 | 1 -
 tests/generic/464 | 2 --
 tests/generic/465 | 1 -
 tests/generic/466 | 2 --
 tests/generic/467 | 2 --
 tests/generic/468 | 2 --
 tests/generic/469 | 2 --
 tests/generic/470 | 2 --
 tests/generic/471 | 1 -
 tests/generic/472 | 2 --
 tests/generic/473 | 1 -
 tests/generic/474 | 2 --
 tests/generic/475 | 1 -
 tests/generic/476 | 1 -
 tests/generic/477 | 2 --
 tests/generic/478 | 2 --
 tests/generic/479 | 2 --
 tests/generic/480 | 2 --
 tests/generic/481 | 2 --
 tests/generic/482 | 2 --
 tests/generic/483 | 2 --
 tests/generic/484 | 1 -
 tests/generic/485 | 2 --
 tests/generic/486 | 2 --
 tests/generic/487 | 1 -
 tests/generic/488 | 1 -
 tests/generic/489 | 2 --
 tests/generic/490 | 1 -
 tests/generic/491 | 2 --
 tests/generic/492 | 2 --
 tests/generic/493 | 1 -
 tests/generic/494 | 1 -
 tests/generic/495 | 1 -
 tests/generic/496 | 2 --
 tests/generic/497 | 2 --
 tests/generic/498 | 2 --
 tests/generic/499 | 2 --
 tests/generic/500 | 1 -
 tests/generic/501 | 2 --
 tests/generic/502 | 2 --
 tests/generic/503 | 2 --
 tests/generic/504 | 2 --
 tests/generic/505 | 2 --
 tests/generic/506 | 2 --
 tests/generic/507 | 2 --
 tests/generic/508 | 2 --
 tests/generic/509 | 2 --
 tests/generic/510 | 2 --
 tests/generic/511 | 2 --
 tests/generic/512 | 2 --
 tests/generic/513 | 2 --
 tests/generic/514 | 2 --
 tests/generic/515 | 2 --
 tests/generic/516 | 1 -
 tests/generic/517 | 2 --
 tests/generic/518 | 2 --
 tests/generic/519 | 2 --
 tests/generic/520 | 2 --
 tests/generic/521 | 2 --
 tests/generic/522 | 2 --
 tests/generic/523 | 2 --
 tests/generic/524 | 2 --
 tests/generic/525 | 2 --
 tests/generic/526 | 2 --
 tests/generic/527 | 2 --
 tests/generic/528 | 2 --
 tests/generic/529 | 2 --
 tests/generic/530 | 2 --
 tests/generic/531 | 2 --
 tests/generic/532 | 2 --
 tests/generic/533 | 2 --
 tests/generic/534 | 2 --
 tests/generic/535 | 2 --
 tests/generic/536 | 2 --
 tests/generic/537 | 2 --
 tests/generic/538 | 2 --
 tests/generic/539 | 1 -
 tests/generic/540 | 2 --
 tests/generic/541 | 2 --
 tests/generic/542 | 2 --
 tests/generic/543 | 2 --
 tests/generic/544 | 2 --
 tests/generic/545 | 2 --
 tests/generic/546 | 2 --
 tests/generic/547 | 2 --
 tests/generic/548 | 2 --
 tests/generic/549 | 2 --
 tests/generic/550 | 2 --
 tests/generic/551 | 2 --
 tests/generic/552 | 2 --
 tests/generic/553 | 2 --
 tests/generic/554 | 2 --
 tests/generic/555 | 2 --
 tests/generic/556 | 1 -
 tests/generic/557 | 2 --
 tests/generic/558 | 2 --
 tests/generic/559 | 2 --
 tests/generic/560 | 2 --
 tests/generic/561 | 2 --
 tests/generic/562 | 2 --
 tests/generic/563 | 2 --
 tests/generic/564 | 2 --
 tests/generic/565 | 2 --
 tests/generic/566 | 2 --
 tests/generic/567 | 2 --
 tests/generic/568 | 2 --
 tests/generic/569 | 2 --
 tests/generic/570 | 2 --
 tests/generic/571 | 2 --
 tests/generic/572 | 2 --
 tests/generic/573 | 2 --
 tests/generic/574 | 2 --
 tests/generic/575 | 2 --
 tests/generic/576 | 2 --
 tests/generic/577 | 2 --
 tests/generic/578 | 2 --
 tests/generic/579 | 2 --
 tests/generic/580 | 2 --
 tests/generic/581 | 2 --
 tests/generic/582 | 2 --
 tests/generic/583 | 2 --
 tests/generic/584 | 2 --
 tests/generic/585 | 2 --
 tests/generic/586 | 2 --
 tests/generic/587 | 2 --
 tests/generic/588 | 2 --
 tests/generic/589 | 2 --
 tests/generic/590 | 1 -
 tests/generic/591 | 2 --
 tests/generic/592 | 2 --
 tests/generic/593 | 2 --
 tests/generic/594 | 2 --
 tests/generic/595 | 2 --
 tests/generic/596 | 2 --
 tests/generic/597 | 2 --
 tests/generic/598 | 2 --
 tests/generic/599 | 2 --
 tests/generic/600 | 2 --
 tests/generic/601 | 2 --
 tests/generic/602 | 2 --
 tests/generic/603 | 2 --
 tests/generic/604 | 2 --
 tests/generic/605 | 1 -
 tests/generic/606 | 1 -
 tests/generic/607 | 1 -
 tests/generic/608 | 1 -
 tests/generic/609 | 1 -
 tests/generic/610 | 2 --
 tests/generic/611 | 2 --
 tests/generic/612 | 2 --
 tests/generic/613 | 2 --
 tests/generic/614 | 2 --
 tests/generic/615 | 2 --
 tests/generic/616 | 2 --
 tests/generic/617 | 2 --
 tests/generic/618 | 2 --
 tests/generic/619 | 2 --
 tests/generic/620 | 1 -
 tests/generic/621 | 1 -
 tests/generic/622 | 1 -
 tests/generic/623 | 1 -
 tests/generic/624 | 1 -
 tests/generic/625 | 1 -
 tests/generic/626 | 2 --
 tests/generic/627 | 2 --
 tests/generic/628 | 2 --
 tests/generic/629 | 2 --
 tests/generic/630 | 2 --
 tests/generic/631 | 1 -
 tests/generic/632 | 1 -
 tests/generic/633 | 2 --
 tests/generic/634 | 2 --
 tests/generic/635 | 2 --
 tests/generic/636 | 1 -
 tests/generic/637 | 2 --
 tests/generic/638 | 2 --
 tests/generic/639 | 2 --
 tests/generic/640 | 2 --
 tests/generic/641 | 2 --
 tests/generic/642 | 1 -
 tests/generic/643 | 2 --
 tests/generic/644 | 2 --
 tests/generic/645 | 2 --
 tests/generic/646 | 2 --
 tests/generic/647 | 2 --
 tests/generic/648 | 1 -
 tests/generic/649 | 2 --
 tests/generic/650 | 1 -
 tests/generic/651 | 1 -
 tests/generic/652 | 1 -
 tests/generic/653 | 1 -
 tests/generic/654 | 1 -
 tests/generic/655 | 1 -
 tests/generic/656 | 2 --
 tests/generic/657 | 1 -
 tests/generic/658 | 1 -
 tests/generic/659 | 1 -
 tests/generic/660 | 1 -
 tests/generic/661 | 1 -
 tests/generic/662 | 1 -
 tests/generic/663 | 1 -
 tests/generic/664 | 1 -
 tests/generic/665 | 1 -
 tests/generic/666 | 1 -
 tests/generic/667 | 1 -
 tests/generic/668 | 1 -
 tests/generic/669 | 1 -
 tests/generic/670 | 1 -
 tests/generic/671 | 1 -
 tests/generic/672 | 1 -
 tests/generic/673 | 2 --
 tests/generic/674 | 2 --
 tests/generic/675 | 2 --
 tests/generic/676 | 2 --
 tests/generic/677 | 2 --
 tests/generic/678 | 2 --
 tests/generic/679 | 1 -
 tests/generic/680 | 2 --
 tests/generic/681 | 2 --
 tests/generic/682 | 2 --
 tests/generic/683 | 2 --
 tests/generic/684 | 2 --
 tests/generic/685 | 2 --
 tests/generic/686 | 2 --
 tests/generic/687 | 2 --
 tests/generic/688 | 2 --
 tests/generic/689 | 2 --
 tests/generic/690 | 2 --
 tests/generic/691 | 2 --
 tests/generic/692 | 2 --
 tests/generic/693 | 2 --
 tests/generic/694 | 1 -
 tests/generic/695 | 1 -
 tests/generic/696 | 2 --
 tests/generic/697 | 2 --
 tests/generic/698 | 2 --
 tests/generic/699 | 1 -
 tests/generic/700 | 2 --
 tests/generic/701 | 1 -
 tests/generic/702 | 1 -
 tests/generic/703 | 1 -
 tests/generic/704 | 2 --
 tests/generic/705 | 2 --
 tests/generic/706 | 1 -
 tests/generic/707 | 1 -
 tests/generic/708 | 2 --
 tests/generic/709 | 1 -
 tests/generic/710 | 1 -
 tests/generic/711 | 1 -
 tests/generic/712 | 1 -
 tests/generic/713 | 1 -
 tests/generic/714 | 1 -
 tests/generic/715 | 1 -
 tests/generic/716 | 1 -
 tests/generic/717 | 1 -
 tests/generic/718 | 1 -
 tests/generic/719 | 1 -
 tests/generic/720 | 1 -
 tests/generic/721 | 1 -
 tests/generic/722 | 1 -
 tests/generic/723 | 1 -
 tests/generic/724 | 1 -
 tests/generic/725 | 1 -
 tests/generic/726 | 2 --
 tests/generic/727 | 2 --
 tests/generic/728 | 2 --
 tests/generic/729 | 2 --
 tests/generic/730 | 1 -
 tests/generic/731 | 1 -
 tests/generic/732 | 1 -
 tests/generic/733 | 2 --
 tests/generic/734 | 3 ---
 tests/generic/735 | 1 -
 tests/generic/736 | 1 -
 tests/generic/737 | 2 --
 tests/generic/738 | 1 -
 tests/generic/739 | 1 -
 tests/generic/741 | 2 --
 tests/generic/742 | 2 --
 tests/generic/743 | 2 --
 tests/generic/744 | 1 -
 tests/generic/746 | 1 -
 tests/generic/747 | 2 --
 tests/generic/748 | 1 -
 tests/generic/749 | 2 --
 tests/generic/750 | 2 --
 tests/generic/751 | 2 --
 tests/generic/752 | 1 -
 tests/generic/753 | 1 -
 tests/generic/754 | 1 -
 tests/nfs/001     | 2 --
 tests/ocfs2/001   | 2 --
 tests/overlay/001 | 2 --
 tests/overlay/002 | 2 --
 tests/overlay/003 | 2 --
 tests/overlay/004 | 1 -
 tests/overlay/005 | 2 --
 tests/overlay/006 | 2 --
 tests/overlay/007 | 2 --
 tests/overlay/008 | 2 --
 tests/overlay/009 | 2 --
 tests/overlay/010 | 2 --
 tests/overlay/011 | 2 --
 tests/overlay/012 | 2 --
 tests/overlay/013 | 2 --
 tests/overlay/014 | 2 --
 tests/overlay/015 | 2 --
 tests/overlay/016 | 2 --
 tests/overlay/017 | 2 --
 tests/overlay/018 | 2 --
 tests/overlay/019 | 2 --
 tests/overlay/020 | 2 --
 tests/overlay/021 | 2 --
 tests/overlay/022 | 2 --
 tests/overlay/023 | 2 --
 tests/overlay/024 | 2 --
 tests/overlay/025 | 2 --
 tests/overlay/026 | 2 --
 tests/overlay/027 | 2 --
 tests/overlay/028 | 2 --
 tests/overlay/029 | 2 --
 tests/overlay/030 | 1 -
 tests/overlay/031 | 2 --
 tests/overlay/032 | 2 --
 tests/overlay/033 | 2 --
 tests/overlay/034 | 2 --
 tests/overlay/035 | 2 --
 tests/overlay/036 | 2 --
 tests/overlay/037 | 2 --
 tests/overlay/038 | 2 --
 tests/overlay/039 | 2 --
 tests/overlay/040 | 2 --
 tests/overlay/041 | 2 --
 tests/overlay/042 | 2 --
 tests/overlay/043 | 2 --
 tests/overlay/044 | 2 --
 tests/overlay/045 | 2 --
 tests/overlay/046 | 2 --
 tests/overlay/047 | 2 --
 tests/overlay/048 | 2 --
 tests/overlay/049 | 2 --
 tests/overlay/050 | 2 --
 tests/overlay/051 | 2 --
 tests/overlay/052 | 2 --
 tests/overlay/053 | 2 --
 tests/overlay/054 | 2 --
 tests/overlay/055 | 2 --
 tests/overlay/056 | 2 --
 tests/overlay/057 | 2 --
 tests/overlay/058 | 2 --
 tests/overlay/059 | 2 --
 tests/overlay/060 | 2 --
 tests/overlay/061 | 2 --
 tests/overlay/062 | 2 --
 tests/overlay/063 | 2 --
 tests/overlay/064 | 2 --
 tests/overlay/065 | 2 --
 tests/overlay/066 | 1 -
 tests/overlay/067 | 2 --
 tests/overlay/068 | 2 --
 tests/overlay/069 | 2 --
 tests/overlay/070 | 2 --
 tests/overlay/071 | 2 --
 tests/overlay/072 | 2 --
 tests/overlay/073 | 2 --
 tests/overlay/074 | 2 --
 tests/overlay/075 | 1 -
 tests/overlay/076 | 2 --
 tests/overlay/077 | 2 --
 tests/overlay/078 | 2 --
 tests/overlay/079 | 2 --
 tests/overlay/080 | 2 --
 tests/overlay/081 | 2 --
 tests/overlay/082 | 2 --
 tests/overlay/083 | 2 --
 tests/overlay/084 | 2 --
 tests/overlay/085 | 2 --
 tests/overlay/086 | 2 --
 tests/overlay/100 | 2 --
 tests/overlay/101 | 2 --
 tests/overlay/102 | 2 --
 tests/overlay/103 | 2 --
 tests/overlay/104 | 2 --
 tests/overlay/105 | 2 --
 tests/overlay/106 | 2 --
 tests/overlay/107 | 2 --
 tests/overlay/108 | 2 --
 tests/overlay/109 | 2 --
 tests/overlay/110 | 2 --
 tests/overlay/111 | 2 --
 tests/overlay/112 | 2 --
 tests/overlay/113 | 2 --
 tests/overlay/114 | 2 --
 tests/overlay/115 | 2 --
 tests/overlay/116 | 2 --
 tests/overlay/117 | 2 --
 tests/perf/001    | 2 --
 tests/tmpfs/001   | 2 --
 tests/udf/102     | 3 ---
 tests/xfs/001     | 2 --
 tests/xfs/002     | 1 -
 tests/xfs/003     | 3 ---
 tests/xfs/004     | 2 --
 tests/xfs/005     | 1 -
 tests/xfs/006     | 2 --
 tests/xfs/007     | 1 -
 tests/xfs/008     | 2 --
 tests/xfs/009     | 2 --
 tests/xfs/010     | 2 --
 tests/xfs/011     | 2 --
 tests/xfs/012     | 2 --
 tests/xfs/013     | 2 --
 tests/xfs/014     | 2 --
 tests/xfs/015     | 2 --
 tests/xfs/016     | 2 --
 tests/xfs/017     | 2 --
 tests/xfs/018     | 2 --
 tests/xfs/019     | 2 --
 tests/xfs/020     | 2 --
 tests/xfs/021     | 2 --
 tests/xfs/022     | 2 --
 tests/xfs/023     | 2 --
 tests/xfs/024     | 2 --
 tests/xfs/025     | 2 --
 tests/xfs/026     | 2 --
 tests/xfs/027     | 2 --
 tests/xfs/028     | 2 --
 tests/xfs/029     | 2 --
 tests/xfs/030     | 2 --
 tests/xfs/031     | 2 --
 tests/xfs/032     | 2 --
 tests/xfs/033     | 2 --
 tests/xfs/034     | 2 --
 tests/xfs/035     | 2 --
 tests/xfs/036     | 2 --
 tests/xfs/037     | 2 --
 tests/xfs/038     | 2 --
 tests/xfs/039     | 2 --
 tests/xfs/041     | 2 --
 tests/xfs/042     | 2 --
 tests/xfs/043     | 2 --
 tests/xfs/044     | 3 ---
 tests/xfs/045     | 2 --
 tests/xfs/046     | 2 --
 tests/xfs/047     | 2 --
 tests/xfs/048     | 2 --
 tests/xfs/049     | 2 --
 tests/xfs/050     | 2 --
 tests/xfs/051     | 1 -
 tests/xfs/052     | 2 --
 tests/xfs/053     | 2 --
 tests/xfs/054     | 2 --
 tests/xfs/055     | 2 --
 tests/xfs/056     | 2 --
 tests/xfs/057     | 2 --
 tests/xfs/058     | 2 --
 tests/xfs/059     | 2 --
 tests/xfs/060     | 2 --
 tests/xfs/061     | 2 --
 tests/xfs/062     | 2 --
 tests/xfs/063     | 2 --
 tests/xfs/064     | 2 --
 tests/xfs/065     | 2 --
 tests/xfs/066     | 2 --
 tests/xfs/067     | 2 --
 tests/xfs/068     | 2 --
 tests/xfs/069     | 2 --
 tests/xfs/070     | 2 --
 tests/xfs/071     | 2 --
 tests/xfs/072     | 2 --
 tests/xfs/073     | 2 --
 tests/xfs/074     | 2 --
 tests/xfs/075     | 2 --
 tests/xfs/076     | 1 -
 tests/xfs/077     | 2 --
 tests/xfs/078     | 2 --
 tests/xfs/079     | 2 --
 tests/xfs/080     | 2 --
 tests/xfs/081     | 2 --
 tests/xfs/082     | 2 --
 tests/xfs/083     | 2 --
 tests/xfs/084     | 2 --
 tests/xfs/085     | 2 --
 tests/xfs/086     | 2 --
 tests/xfs/087     | 2 --
 tests/xfs/088     | 2 --
 tests/xfs/089     | 2 --
 tests/xfs/090     | 2 --
 tests/xfs/091     | 2 --
 tests/xfs/092     | 2 --
 tests/xfs/093     | 2 --
 tests/xfs/094     | 2 --
 tests/xfs/095     | 2 --
 tests/xfs/096     | 2 --
 tests/xfs/097     | 2 --
 tests/xfs/098     | 2 --
 tests/xfs/099     | 2 --
 tests/xfs/100     | 2 --
 tests/xfs/101     | 2 --
 tests/xfs/102     | 2 --
 tests/xfs/103     | 2 --
 tests/xfs/104     | 2 --
 tests/xfs/105     | 2 --
 tests/xfs/106     | 2 --
 tests/xfs/107     | 2 --
 tests/xfs/108     | 3 ---
 tests/xfs/109     | 3 ---
 tests/xfs/110     | 3 ---
 tests/xfs/111     | 3 ---
 tests/xfs/112     | 2 --
 tests/xfs/113     | 2 --
 tests/xfs/114     | 2 --
 tests/xfs/115     | 2 --
 tests/xfs/116     | 2 --
 tests/xfs/117     | 2 --
 tests/xfs/118     | 1 -
 tests/xfs/119     | 2 --
 tests/xfs/120     | 2 --
 tests/xfs/121     | 2 --
 tests/xfs/122     | 2 --
 tests/xfs/123     | 2 --
 tests/xfs/124     | 2 --
 tests/xfs/125     | 2 --
 tests/xfs/126     | 2 --
 tests/xfs/127     | 2 --
 tests/xfs/128     | 2 --
 tests/xfs/129     | 2 --
 tests/xfs/130     | 2 --
 tests/xfs/131     | 2 --
 tests/xfs/132     | 2 --
 tests/xfs/133     | 2 --
 tests/xfs/134     | 2 --
 tests/xfs/135     | 2 --
 tests/xfs/136     | 2 --
 tests/xfs/137     | 2 --
 tests/xfs/138     | 2 --
 tests/xfs/139     | 1 -
 tests/xfs/140     | 1 -
 tests/xfs/141     | 2 --
 tests/xfs/142     | 2 --
 tests/xfs/143     | 2 --
 tests/xfs/144     | 2 --
 tests/xfs/145     | 2 --
 tests/xfs/146     | 2 --
 tests/xfs/147     | 2 --
 tests/xfs/148     | 2 --
 tests/xfs/149     | 2 --
 tests/xfs/150     | 2 --
 tests/xfs/151     | 2 --
 tests/xfs/152     | 2 --
 tests/xfs/153     | 2 --
 tests/xfs/154     | 2 --
 tests/xfs/155     | 2 --
 tests/xfs/156     | 2 --
 tests/xfs/157     | 2 --
 tests/xfs/158     | 2 --
 tests/xfs/159     | 2 --
 tests/xfs/160     | 2 --
 tests/xfs/161     | 2 --
 tests/xfs/162     | 2 --
 tests/xfs/163     | 2 --
 tests/xfs/164     | 2 --
 tests/xfs/165     | 2 --
 tests/xfs/166     | 2 --
 tests/xfs/167     | 2 --
 tests/xfs/168     | 2 --
 tests/xfs/169     | 2 --
 tests/xfs/170     | 2 --
 tests/xfs/171     | 2 --
 tests/xfs/172     | 2 --
 tests/xfs/173     | 2 --
 tests/xfs/174     | 2 --
 tests/xfs/175     | 2 --
 tests/xfs/176     | 2 --
 tests/xfs/177     | 2 --
 tests/xfs/178     | 2 --
 tests/xfs/179     | 2 --
 tests/xfs/180     | 2 --
 tests/xfs/181     | 2 --
 tests/xfs/182     | 2 --
 tests/xfs/183     | 2 --
 tests/xfs/184     | 2 --
 tests/xfs/185     | 2 --
 tests/xfs/186     | 2 --
 tests/xfs/187     | 2 --
 tests/xfs/188     | 2 --
 tests/xfs/189     | 2 --
 tests/xfs/190     | 2 --
 tests/xfs/191     | 2 --
 tests/xfs/192     | 2 --
 tests/xfs/193     | 2 --
 tests/xfs/194     | 2 --
 tests/xfs/195     | 2 --
 tests/xfs/196     | 2 --
 tests/xfs/197     | 2 --
 tests/xfs/198     | 2 --
 tests/xfs/199     | 2 --
 tests/xfs/200     | 2 --
 tests/xfs/201     | 2 --
 tests/xfs/202     | 2 --
 tests/xfs/203     | 2 --
 tests/xfs/204     | 2 --
 tests/xfs/205     | 2 --
 tests/xfs/206     | 2 --
 tests/xfs/207     | 2 --
 tests/xfs/208     | 2 --
 tests/xfs/209     | 2 --
 tests/xfs/210     | 2 --
 tests/xfs/211     | 2 --
 tests/xfs/212     | 2 --
 tests/xfs/213     | 2 --
 tests/xfs/214     | 2 --
 tests/xfs/215     | 1 -
 tests/xfs/216     | 2 --
 tests/xfs/217     | 2 --
 tests/xfs/218     | 1 -
 tests/xfs/219     | 1 -
 tests/xfs/220     | 2 --
 tests/xfs/221     | 1 -
 tests/xfs/222     | 2 --
 tests/xfs/223     | 1 -
 tests/xfs/224     | 1 -
 tests/xfs/225     | 1 -
 tests/xfs/226     | 1 -
 tests/xfs/227     | 2 --
 tests/xfs/228     | 1 -
 tests/xfs/229     | 2 --
 tests/xfs/230     | 1 -
 tests/xfs/231     | 2 --
 tests/xfs/232     | 2 --
 tests/xfs/233     | 2 --
 tests/xfs/234     | 2 --
 tests/xfs/235     | 2 --
 tests/xfs/236     | 2 --
 tests/xfs/237     | 2 --
 tests/xfs/238     | 2 --
 tests/xfs/239     | 2 --
 tests/xfs/240     | 2 --
 tests/xfs/241     | 2 --
 tests/xfs/242     | 2 --
 tests/xfs/243     | 2 --
 tests/xfs/244     | 2 --
 tests/xfs/245     | 2 --
 tests/xfs/246     | 2 --
 tests/xfs/247     | 2 --
 tests/xfs/248     | 1 -
 tests/xfs/249     | 1 -
 tests/xfs/250     | 3 ---
 tests/xfs/251     | 1 -
 tests/xfs/252     | 3 ---
 tests/xfs/253     | 2 --
 tests/xfs/254     | 1 -
 tests/xfs/255     | 1 -
 tests/xfs/256     | 1 -
 tests/xfs/257     | 1 -
 tests/xfs/258     | 1 -
 tests/xfs/259     | 2 --
 tests/xfs/260     | 1 -
 tests/xfs/261     | 2 --
 tests/xfs/262     | 2 --
 tests/xfs/263     | 2 --
 tests/xfs/264     | 2 --
 tests/xfs/265     | 2 --
 tests/xfs/266     | 2 --
 tests/xfs/267     | 2 --
 tests/xfs/268     | 2 --
 tests/xfs/269     | 1 -
 tests/xfs/270     | 2 --
 tests/xfs/271     | 2 --
 tests/xfs/272     | 2 --
 tests/xfs/273     | 2 --
 tests/xfs/274     | 2 --
 tests/xfs/275     | 2 --
 tests/xfs/276     | 2 --
 tests/xfs/277     | 2 --
 tests/xfs/278     | 2 --
 tests/xfs/279     | 2 --
 tests/xfs/280     | 2 --
 tests/xfs/281     | 2 --
 tests/xfs/282     | 2 --
 tests/xfs/283     | 2 --
 tests/xfs/284     | 2 --
 tests/xfs/285     | 2 --
 tests/xfs/286     | 2 --
 tests/xfs/287     | 2 --
 tests/xfs/288     | 1 -
 tests/xfs/289     | 2 --
 tests/xfs/290     | 2 --
 tests/xfs/291     | 2 --
 tests/xfs/292     | 2 --
 tests/xfs/293     | 2 --
 tests/xfs/294     | 2 --
 tests/xfs/295     | 2 --
 tests/xfs/296     | 2 --
 tests/xfs/297     | 2 --
 tests/xfs/298     | 2 --
 tests/xfs/299     | 2 --
 tests/xfs/300     | 2 --
 tests/xfs/301     | 2 --
 tests/xfs/302     | 2 --
 tests/xfs/303     | 2 --
 tests/xfs/304     | 1 -
 tests/xfs/305     | 1 -
 tests/xfs/306     | 1 -
 tests/xfs/307     | 2 --
 tests/xfs/308     | 2 --
 tests/xfs/309     | 2 --
 tests/xfs/310     | 2 --
 tests/xfs/311     | 1 -
 tests/xfs/312     | 2 --
 tests/xfs/313     | 2 --
 tests/xfs/314     | 2 --
 tests/xfs/315     | 2 --
 tests/xfs/316     | 2 --
 tests/xfs/317     | 2 --
 tests/xfs/318     | 2 --
 tests/xfs/319     | 2 --
 tests/xfs/320     | 2 --
 tests/xfs/321     | 2 --
 tests/xfs/322     | 2 --
 tests/xfs/323     | 2 --
 tests/xfs/324     | 2 --
 tests/xfs/325     | 2 --
 tests/xfs/326     | 2 --
 tests/xfs/327     | 2 --
 tests/xfs/328     | 2 --
 tests/xfs/329     | 2 --
 tests/xfs/330     | 2 --
 tests/xfs/331     | 2 --
 tests/xfs/332     | 2 --
 tests/xfs/333     | 2 --
 tests/xfs/334     | 2 --
 tests/xfs/335     | 2 --
 tests/xfs/336     | 2 --
 tests/xfs/337     | 2 --
 tests/xfs/338     | 2 --
 tests/xfs/339     | 2 --
 tests/xfs/340     | 2 --
 tests/xfs/341     | 2 --
 tests/xfs/342     | 2 --
 tests/xfs/343     | 2 --
 tests/xfs/344     | 2 --
 tests/xfs/345     | 2 --
 tests/xfs/346     | 2 --
 tests/xfs/347     | 2 --
 tests/xfs/348     | 2 --
 tests/xfs/349     | 2 --
 tests/xfs/350     | 2 --
 tests/xfs/351     | 2 --
 tests/xfs/352     | 2 --
 tests/xfs/353     | 2 --
 tests/xfs/354     | 2 --
 tests/xfs/355     | 2 --
 tests/xfs/356     | 2 --
 tests/xfs/357     | 2 --
 tests/xfs/358     | 2 --
 tests/xfs/359     | 2 --
 tests/xfs/360     | 2 --
 tests/xfs/361     | 2 --
 tests/xfs/362     | 2 --
 tests/xfs/363     | 2 --
 tests/xfs/364     | 2 --
 tests/xfs/365     | 2 --
 tests/xfs/366     | 2 --
 tests/xfs/367     | 2 --
 tests/xfs/368     | 2 --
 tests/xfs/369     | 2 --
 tests/xfs/370     | 2 --
 tests/xfs/371     | 2 --
 tests/xfs/372     | 2 --
 tests/xfs/373     | 2 --
 tests/xfs/374     | 2 --
 tests/xfs/375     | 2 --
 tests/xfs/376     | 2 --
 tests/xfs/377     | 2 --
 tests/xfs/378     | 2 --
 tests/xfs/379     | 2 --
 tests/xfs/380     | 2 --
 tests/xfs/381     | 2 --
 tests/xfs/382     | 2 --
 tests/xfs/383     | 2 --
 tests/xfs/384     | 2 --
 tests/xfs/385     | 2 --
 tests/xfs/386     | 2 --
 tests/xfs/387     | 2 --
 tests/xfs/388     | 2 --
 tests/xfs/389     | 2 --
 tests/xfs/390     | 2 --
 tests/xfs/391     | 2 --
 tests/xfs/392     | 2 --
 tests/xfs/393     | 2 --
 tests/xfs/394     | 2 --
 tests/xfs/395     | 2 --
 tests/xfs/396     | 2 --
 tests/xfs/397     | 2 --
 tests/xfs/398     | 2 --
 tests/xfs/399     | 2 --
 tests/xfs/400     | 2 --
 tests/xfs/401     | 2 --
 tests/xfs/402     | 2 --
 tests/xfs/403     | 2 --
 tests/xfs/404     | 2 --
 tests/xfs/405     | 2 --
 tests/xfs/406     | 2 --
 tests/xfs/407     | 2 --
 tests/xfs/408     | 2 --
 tests/xfs/409     | 2 --
 tests/xfs/410     | 2 --
 tests/xfs/411     | 2 --
 tests/xfs/412     | 2 --
 tests/xfs/413     | 2 --
 tests/xfs/414     | 2 --
 tests/xfs/415     | 2 --
 tests/xfs/416     | 2 --
 tests/xfs/417     | 2 --
 tests/xfs/418     | 2 --
 tests/xfs/419     | 2 --
 tests/xfs/420     | 2 --
 tests/xfs/421     | 2 --
 tests/xfs/422     | 2 --
 tests/xfs/423     | 2 --
 tests/xfs/424     | 2 --
 tests/xfs/425     | 2 --
 tests/xfs/426     | 2 --
 tests/xfs/427     | 2 --
 tests/xfs/428     | 2 --
 tests/xfs/429     | 2 --
 tests/xfs/430     | 2 --
 tests/xfs/431     | 2 --
 tests/xfs/432     | 2 --
 tests/xfs/433     | 2 --
 tests/xfs/434     | 2 --
 tests/xfs/435     | 2 --
 tests/xfs/436     | 2 --
 tests/xfs/438     | 1 -
 tests/xfs/439     | 2 --
 tests/xfs/440     | 1 -
 tests/xfs/441     | 1 -
 tests/xfs/442     | 1 -
 tests/xfs/443     | 2 --
 tests/xfs/444     | 2 --
 tests/xfs/445     | 2 --
 tests/xfs/446     | 2 --
 tests/xfs/447     | 2 --
 tests/xfs/448     | 2 --
 tests/xfs/449     | 2 --
 tests/xfs/450     | 2 --
 tests/xfs/451     | 2 --
 tests/xfs/452     | 1 -
 tests/xfs/453     | 2 --
 tests/xfs/454     | 2 --
 tests/xfs/455     | 2 --
 tests/xfs/456     | 2 --
 tests/xfs/457     | 2 --
 tests/xfs/458     | 2 --
 tests/xfs/459     | 2 --
 tests/xfs/460     | 2 --
 tests/xfs/461     | 2 --
 tests/xfs/462     | 2 --
 tests/xfs/463     | 2 --
 tests/xfs/464     | 2 --
 tests/xfs/465     | 2 --
 tests/xfs/466     | 2 --
 tests/xfs/467     | 2 --
 tests/xfs/468     | 2 --
 tests/xfs/469     | 2 --
 tests/xfs/470     | 2 --
 tests/xfs/471     | 2 --
 tests/xfs/472     | 2 --
 tests/xfs/473     | 2 --
 tests/xfs/474     | 2 --
 tests/xfs/475     | 2 --
 tests/xfs/476     | 2 --
 tests/xfs/477     | 2 --
 tests/xfs/478     | 2 --
 tests/xfs/479     | 2 --
 tests/xfs/480     | 2 --
 tests/xfs/481     | 2 --
 tests/xfs/482     | 2 --
 tests/xfs/483     | 2 --
 tests/xfs/484     | 2 --
 tests/xfs/485     | 2 --
 tests/xfs/486     | 2 --
 tests/xfs/487     | 2 --
 tests/xfs/488     | 2 --
 tests/xfs/489     | 2 --
 tests/xfs/490     | 2 --
 tests/xfs/491     | 2 --
 tests/xfs/492     | 2 --
 tests/xfs/493     | 2 --
 tests/xfs/494     | 2 --
 tests/xfs/495     | 2 --
 tests/xfs/496     | 2 --
 tests/xfs/497     | 2 --
 tests/xfs/498     | 2 --
 tests/xfs/499     | 2 --
 tests/xfs/500     | 2 --
 tests/xfs/501     | 2 --
 tests/xfs/502     | 2 --
 tests/xfs/503     | 2 --
 tests/xfs/504     | 1 -
 tests/xfs/505     | 2 --
 tests/xfs/506     | 2 --
 tests/xfs/507     | 2 --
 tests/xfs/508     | 2 --
 tests/xfs/509     | 1 -
 tests/xfs/510     | 2 --
 tests/xfs/511     | 2 --
 tests/xfs/512     | 2 --
 tests/xfs/513     | 2 --
 tests/xfs/514     | 2 --
 tests/xfs/515     | 2 --
 tests/xfs/516     | 2 --
 tests/xfs/517     | 2 --
 tests/xfs/518     | 2 --
 tests/xfs/519     | 2 --
 tests/xfs/520     | 2 --
 tests/xfs/521     | 2 --
 tests/xfs/522     | 2 --
 tests/xfs/523     | 2 --
 tests/xfs/524     | 2 --
 tests/xfs/525     | 2 --
 tests/xfs/526     | 2 --
 tests/xfs/527     | 2 --
 tests/xfs/528     | 2 --
 tests/xfs/529     | 2 --
 tests/xfs/530     | 2 --
 tests/xfs/531     | 2 --
 tests/xfs/532     | 2 --
 tests/xfs/533     | 2 --
 tests/xfs/534     | 2 --
 tests/xfs/535     | 2 --
 tests/xfs/536     | 2 --
 tests/xfs/537     | 2 --
 tests/xfs/538     | 2 --
 tests/xfs/539     | 1 -
 tests/xfs/540     | 2 --
 tests/xfs/541     | 2 --
 tests/xfs/542     | 2 --
 tests/xfs/543     | 2 --
 tests/xfs/544     | 2 --
 tests/xfs/545     | 1 -
 tests/xfs/546     | 2 --
 tests/xfs/547     | 2 --
 tests/xfs/548     | 2 --
 tests/xfs/549     | 2 --
 tests/xfs/550     | 1 -
 tests/xfs/551     | 1 -
 tests/xfs/552     | 1 -
 tests/xfs/553     | 2 --
 tests/xfs/554     | 1 -
 tests/xfs/555     | 2 --
 tests/xfs/556     | 2 --
 tests/xfs/557     | 1 -
 tests/xfs/558     | 2 --
 tests/xfs/559     | 2 --
 tests/xfs/560     | 2 --
 tests/xfs/561     | 2 --
 tests/xfs/562     | 2 --
 tests/xfs/563     | 2 --
 tests/xfs/564     | 2 --
 tests/xfs/565     | 2 --
 tests/xfs/566     | 2 --
 tests/xfs/567     | 1 -
 tests/xfs/568     | 2 --
 tests/xfs/569     | 2 --
 tests/xfs/570     | 2 --
 tests/xfs/571     | 2 --
 tests/xfs/572     | 2 --
 tests/xfs/573     | 2 --
 tests/xfs/574     | 2 --
 tests/xfs/575     | 2 --
 tests/xfs/576     | 2 --
 tests/xfs/577     | 2 --
 tests/xfs/578     | 2 --
 tests/xfs/579     | 2 --
 tests/xfs/580     | 2 --
 tests/xfs/581     | 2 --
 tests/xfs/582     | 2 --
 tests/xfs/583     | 2 --
 tests/xfs/584     | 2 --
 tests/xfs/585     | 2 --
 tests/xfs/586     | 2 --
 tests/xfs/587     | 2 --
 tests/xfs/588     | 2 --
 tests/xfs/589     | 2 --
 tests/xfs/590     | 2 --
 tests/xfs/591     | 2 --
 tests/xfs/592     | 2 --
 tests/xfs/593     | 2 --
 tests/xfs/594     | 2 --
 tests/xfs/595     | 2 --
 tests/xfs/596     | 2 --
 tests/xfs/597     | 1 -
 tests/xfs/598     | 1 -
 tests/xfs/599     | 1 -
 tests/xfs/600     | 1 -
 tests/xfs/601     | 2 --
 tests/xfs/602     | 2 --
 tests/xfs/603     | 2 --
 tests/xfs/604     | 1 -
 tests/xfs/605     | 2 --
 tests/xfs/606     | 2 --
 tests/xfs/607     | 2 --
 tests/xfs/612     | 2 --
 tests/xfs/613     | 2 --
 tests/xfs/614     | 2 --
 tests/xfs/615     | 2 --
 tests/xfs/616     | 2 --
 tests/xfs/617     | 2 --
 tests/xfs/618     | 2 --
 tests/xfs/619     | 2 --
 tests/xfs/620     | 2 --
 tests/xfs/621     | 2 --
 tests/xfs/622     | 2 --
 tests/xfs/623     | 2 --
 tests/xfs/624     | 2 --
 tests/xfs/625     | 2 --
 tests/xfs/626     | 2 --
 tests/xfs/627     | 2 --
 tests/xfs/628     | 2 --
 tests/xfs/708     | 2 --
 tests/xfs/709     | 2 --
 tests/xfs/710     | 2 --
 tests/xfs/711     | 2 --
 tests/xfs/712     | 2 --
 tests/xfs/713     | 2 --
 tests/xfs/714     | 2 --
 tests/xfs/715     | 2 --
 tests/xfs/716     | 2 --
 tests/xfs/717     | 2 --
 tests/xfs/718     | 2 --
 tests/xfs/719     | 2 --
 tests/xfs/720     | 2 --
 tests/xfs/721     | 2 --
 tests/xfs/722     | 2 --
 tests/xfs/723     | 2 --
 tests/xfs/724     | 2 --
 tests/xfs/725     | 2 --
 tests/xfs/726     | 2 --
 tests/xfs/727     | 2 --
 tests/xfs/728     | 2 --
 tests/xfs/729     | 2 --
 tests/xfs/730     | 2 --
 tests/xfs/731     | 2 --
 tests/xfs/732     | 2 --
 tests/xfs/733     | 2 --
 tests/xfs/734     | 2 --
 tests/xfs/735     | 2 --
 tests/xfs/736     | 2 --
 tests/xfs/737     | 2 --
 tests/xfs/738     | 2 --
 tests/xfs/739     | 2 --
 tests/xfs/740     | 2 --
 tests/xfs/741     | 2 --
 tests/xfs/742     | 2 --
 tests/xfs/743     | 2 --
 tests/xfs/744     | 2 --
 tests/xfs/745     | 2 --
 tests/xfs/746     | 2 --
 tests/xfs/747     | 2 --
 tests/xfs/748     | 2 --
 tests/xfs/749     | 2 --
 tests/xfs/750     | 2 --
 tests/xfs/751     | 2 --
 tests/xfs/752     | 2 --
 tests/xfs/753     | 2 --
 tests/xfs/754     | 2 --
 tests/xfs/755     | 2 --
 tests/xfs/756     | 2 --
 tests/xfs/757     | 2 --
 tests/xfs/758     | 2 --
 tests/xfs/759     | 2 --
 tests/xfs/760     | 2 --
 tests/xfs/761     | 2 --
 tests/xfs/762     | 2 --
 tests/xfs/763     | 2 --
 tests/xfs/764     | 2 --
 tests/xfs/765     | 2 --
 tests/xfs/766     | 2 --
 tests/xfs/767     | 2 --
 tests/xfs/768     | 2 --
 tests/xfs/769     | 2 --
 tests/xfs/770     | 2 --
 tests/xfs/771     | 2 --
 tests/xfs/772     | 2 --
 tests/xfs/773     | 2 --
 tests/xfs/774     | 2 --
 tests/xfs/775     | 2 --
 tests/xfs/776     | 2 --
 tests/xfs/777     | 2 --
 tests/xfs/778     | 2 --
 tests/xfs/779     | 2 --
 tests/xfs/780     | 2 --
 tests/xfs/781     | 2 --
 tests/xfs/782     | 2 --
 tests/xfs/783     | 2 --
 tests/xfs/784     | 2 --
 tests/xfs/785     | 2 --
 tests/xfs/786     | 2 --
 tests/xfs/787     | 2 --
 tests/xfs/788     | 2 --
 tests/xfs/789     | 2 --
 tests/xfs/790     | 2 --
 tests/xfs/791     | 2 --
 tests/xfs/792     | 2 --
 tests/xfs/793     | 2 --
 tests/xfs/794     | 2 --
 tests/xfs/795     | 2 --
 tests/xfs/796     | 2 --
 tests/xfs/797     | 2 --
 tests/xfs/798     | 2 --
 tests/xfs/799     | 2 --
 tests/xfs/800     | 2 --
 1959 files changed, 3242 deletions(-)

diff --git a/new b/new
index 9651e0e0b..6b50ffeda 100755
--- a/new
+++ b/new
@@ -162,10 +162,7 @@ _begin_fstest ${new_groups[@]}
 # Import common functions.
 # . ./common/filter
 
-# real QA test starts here
-
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 
 # if error
diff --git a/tests/btrfs/001 b/tests/btrfs/001
index 71738e884..2d073e804 100755
--- a/tests/btrfs/001
+++ b/tests/btrfs/001
@@ -12,7 +12,6 @@ _begin_fstest auto quick subvol snapshot
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/002 b/tests/btrfs/002
index e5fe88257..f223cc606 100755
--- a/tests/btrfs/002
+++ b/tests/btrfs/002
@@ -11,7 +11,6 @@ _begin_fstest auto snapshot
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
diff --git a/tests/btrfs/003 b/tests/btrfs/003
index 3ac53ef78..ecefdd14b 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -40,7 +40,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool 4
 _require_command "$WIPEFS_PROG" wipefs
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 684f5fdf5..e89697d24 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -24,7 +24,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_no_large_scratch_dev
 _require_btrfs_command inspect-internal logical-resolve
diff --git a/tests/btrfs/005 b/tests/btrfs/005
index 8d66f0be6..26721569e 100755
--- a/tests/btrfs/005
+++ b/tests/btrfs/005
@@ -102,7 +102,6 @@ _rundefrag()
 . ./common/filter
 . ./common/defrag
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >/dev/null 2>&1
diff --git a/tests/btrfs/006 b/tests/btrfs/006
index cd3a0c631..4f896f9e8 100755
--- a/tests/btrfs/006
+++ b/tests/btrfs/006
@@ -12,7 +12,6 @@ _begin_fstest auto quick volume
 
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool
 
diff --git a/tests/btrfs/007 b/tests/btrfs/007
index 5b9a887b5..a7eb62162 100755
--- a/tests/btrfs/007
+++ b/tests/btrfs/007
@@ -25,7 +25,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 _require_seek_data_hole
diff --git a/tests/btrfs/008 b/tests/btrfs/008
index bcbb72da0..69d8ab4a1 100755
--- a/tests/btrfs/008
+++ b/tests/btrfs/008
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 
diff --git a/tests/btrfs/009 b/tests/btrfs/009
index 4a151049c..74dd2cd2e 100755
--- a/tests/btrfs/009
+++ b/tests/btrfs/009
@@ -11,7 +11,6 @@ _begin_fstest auto quick subvol
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/010 b/tests/btrfs/010
index 10693901e..d27c6dd25 100755
--- a/tests/btrfs/010
+++ b/tests/btrfs/010
@@ -22,7 +22,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_btrfs_fs_sysfs
 
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 40dfb1572..c46f2cc46 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -40,7 +40,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_nocheck
 _require_scratch_dev_pool 5
 _require_scratch_dev_pool_equal_size
diff --git a/tests/btrfs/012 b/tests/btrfs/012
index 1cb2905b3..a96efeffd 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -18,7 +18,6 @@ _begin_fstest auto convert
 
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch_nocheck
 
 _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
diff --git a/tests/btrfs/013 b/tests/btrfs/013
index 623de320b..7b1e6042d 100755
--- a/tests/btrfs/013
+++ b/tests/btrfs/013
@@ -15,7 +15,6 @@ _begin_fstest auto quick balance prealloc
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
 
diff --git a/tests/btrfs/014 b/tests/btrfs/014
index af7a7aeb0..4c95276fb 100755
--- a/tests/btrfs/014
+++ b/tests/btrfs/014
@@ -28,7 +28,6 @@ _balance()
 
 . ./common/filter
 
-_supported_fs btrfs
 
 _require_scratch
 _scratch_mkfs >/dev/null 2>&1
diff --git a/tests/btrfs/015 b/tests/btrfs/015
index 346812da1..fc4277ff3 100755
--- a/tests/btrfs/015
+++ b/tests/btrfs/015
@@ -12,7 +12,6 @@ _begin_fstest auto quick snapshot remount
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/016 b/tests/btrfs/016
index 95e13854f..0fc084f54 100755
--- a/tests/btrfs/016
+++ b/tests/btrfs/016
@@ -14,7 +14,6 @@ tmp_dir=send_temp_$seq
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/017 b/tests/btrfs/017
index b512098e1..a64aa3e63 100755
--- a/tests/btrfs/017
+++ b/tests/btrfs/017
@@ -17,7 +17,6 @@ _begin_fstest auto quick qgroup
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_scratch_qgroup
 _require_cloner
diff --git a/tests/btrfs/018 b/tests/btrfs/018
index f9e9497a6..a28100844 100755
--- a/tests/btrfs/018
+++ b/tests/btrfs/018
@@ -11,7 +11,6 @@ _begin_fstest auto quick subvol
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/019 b/tests/btrfs/019
index 3ecde39fe..b618978fd 100755
--- a/tests/btrfs/019
+++ b/tests/btrfs/019
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 
diff --git a/tests/btrfs/020 b/tests/btrfs/020
index d2d9269fe..7e5c6fd7b 100755
--- a/tests/btrfs/020
+++ b/tests/btrfs/020
@@ -27,7 +27,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_loop
 
diff --git a/tests/btrfs/021 b/tests/btrfs/021
index 13f2ba325..2209b3a8f 100755
--- a/tests/btrfs/021
+++ b/tests/btrfs/021
@@ -29,7 +29,6 @@ run_test()
 	wait
 }
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/022 b/tests/btrfs/022
index dc88329cb..31b7874b1 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -11,7 +11,6 @@ _begin_fstest auto qgroup limit
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_qgroup_rescan
 _require_btrfs_qgroup_report
diff --git a/tests/btrfs/023 b/tests/btrfs/023
index 15ce7d696..f03bcbb98 100755
--- a/tests/btrfs/023
+++ b/tests/btrfs/023
@@ -13,7 +13,6 @@ _begin_fstest auto
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 4
 # Zoned btrfs only supports SINGLE profile
 _require_non_zoned_device "${SCRATCH_DEV}"
diff --git a/tests/btrfs/024 b/tests/btrfs/024
index 2eefbe62a..ccf844e02 100755
--- a/tests/btrfs/024
+++ b/tests/btrfs/024
@@ -13,7 +13,6 @@ _begin_fstest auto quick compress
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_no_nodatacow
 
diff --git a/tests/btrfs/025 b/tests/btrfs/025
index bd54d3c58..383ac494c 100755
--- a/tests/btrfs/025
+++ b/tests/btrfs/025
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
 
diff --git a/tests/btrfs/026 b/tests/btrfs/026
index 00914f10a..745b85a6d 100755
--- a/tests/btrfs/026
+++ b/tests/btrfs/026
@@ -12,7 +12,6 @@ _begin_fstest auto quick compress prealloc
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
 
diff --git a/tests/btrfs/027 b/tests/btrfs/027
index 7d3307a13..282877716 100755
--- a/tests/btrfs/027
+++ b/tests/btrfs/027
@@ -11,7 +11,6 @@ _begin_fstest auto replace volume scrub
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 5
diff --git a/tests/btrfs/028 b/tests/btrfs/028
index 831875d3e..f64fc831d 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -15,7 +15,6 @@ _begin_fstest auto qgroup balance
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
diff --git a/tests/btrfs/029 b/tests/btrfs/029
index 9b56cc73f..842b104c0 100755
--- a/tests/btrfs/029
+++ b/tests/btrfs/029
@@ -21,7 +21,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 
 _require_test
 _require_scratch
diff --git a/tests/btrfs/030 b/tests/btrfs/030
index 9dcbb5502..bedbb7288 100755
--- a/tests/btrfs/030
+++ b/tests/btrfs/030
@@ -30,7 +30,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/031 b/tests/btrfs/031
index 83a28e4cc..8ac73d3a8 100755
--- a/tests/btrfs/031
+++ b/tests/btrfs/031
@@ -17,7 +17,6 @@ _begin_fstest auto quick subvol clone
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 
 _require_test
 _require_scratch
diff --git a/tests/btrfs/032 b/tests/btrfs/032
index b7b1fcf65..5a963145b 100755
--- a/tests/btrfs/032
+++ b/tests/btrfs/032
@@ -12,7 +12,6 @@ _begin_fstest auto quick remount
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/033 b/tests/btrfs/033
index da002bcfe..072f61119 100755
--- a/tests/btrfs/033
+++ b/tests/btrfs/033
@@ -11,7 +11,6 @@ _begin_fstest auto quick send snapshot
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/034 b/tests/btrfs/034
index ce8c1bfae..73bdf1c2e 100755
--- a/tests/btrfs/034
+++ b/tests/btrfs/034
@@ -20,7 +20,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
 
diff --git a/tests/btrfs/035 b/tests/btrfs/035
index dac2fff7d..7f057091c 100755
--- a/tests/btrfs/035
+++ b/tests/btrfs/035
@@ -12,7 +12,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/036 b/tests/btrfs/036
index 32c129c3a..92ecd5609 100755
--- a/tests/btrfs/036
+++ b/tests/btrfs/036
@@ -42,7 +42,6 @@ do_snapshots()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/037 b/tests/btrfs/037
index 4e4178cdd..4d9221432 100755
--- a/tests/btrfs/037
+++ b/tests/btrfs/037
@@ -27,7 +27,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
 
diff --git a/tests/btrfs/038 b/tests/btrfs/038
index 3424e5115..bdef4f415 100755
--- a/tests/btrfs/038
+++ b/tests/btrfs/038
@@ -26,7 +26,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/039 b/tests/btrfs/039
index 2e76bdd8b..e7cea3251 100755
--- a/tests/btrfs/039
+++ b/tests/btrfs/039
@@ -29,7 +29,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/040 b/tests/btrfs/040
index 7dd907d5c..5d346be31 100755
--- a/tests/btrfs/040
+++ b/tests/btrfs/040
@@ -29,7 +29,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/041 b/tests/btrfs/041
index f69836b50..2662e2f47 100755
--- a/tests/btrfs/041
+++ b/tests/btrfs/041
@@ -26,7 +26,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 
diff --git a/tests/btrfs/042 b/tests/btrfs/042
index 63d14bccc..42719f2f7 100755
--- a/tests/btrfs/042
+++ b/tests/btrfs/042
@@ -11,7 +11,6 @@ _begin_fstest auto quick qgroup limit
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
diff --git a/tests/btrfs/043 b/tests/btrfs/043
index 9fc2c6a2d..5597316f4 100755
--- a/tests/btrfs/043
+++ b/tests/btrfs/043
@@ -25,7 +25,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/044 b/tests/btrfs/044
index 71c640512..15536131b 100755
--- a/tests/btrfs/044
+++ b/tests/btrfs/044
@@ -30,7 +30,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/045 b/tests/btrfs/045
index 90fda6e27..cc432cd58 100755
--- a/tests/btrfs/045
+++ b/tests/btrfs/045
@@ -46,7 +46,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/046 b/tests/btrfs/046
index 7f6b92a1d..d395583cd 100755
--- a/tests/btrfs/046
+++ b/tests/btrfs/046
@@ -29,7 +29,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/047 b/tests/btrfs/047
index 4b3fb3541..81f562eab 100755
--- a/tests/btrfs/047
+++ b/tests/btrfs/047
@@ -13,7 +13,6 @@ _begin_fstest auto quick snapshot attr
 . ./common/filter
 . ./common/attr
 
-_supported_fs btrfs
 _require_attrs
 _require_scratch
 
diff --git a/tests/btrfs/048 b/tests/btrfs/048
index 2b0a6258e..a38c39518 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_btrfs_command "property"
diff --git a/tests/btrfs/049 b/tests/btrfs/049
index dd07c94a1..19eec7851 100755
--- a/tests/btrfs/049
+++ b/tests/btrfs/049
@@ -11,7 +11,6 @@
 . ./common/preamble
 _begin_fstest quick balance auto
 
-_supported_fs btrfs
 _require_scratch_swapfile
 _require_scratch_dev_pool 3
 
diff --git a/tests/btrfs/050 b/tests/btrfs/050
index da268480b..effe9f157 100755
--- a/tests/btrfs/050
+++ b/tests/btrfs/050
@@ -27,7 +27,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/051 b/tests/btrfs/051
index 468fac12d..5be403a8c 100755
--- a/tests/btrfs/051
+++ b/tests/btrfs/051
@@ -24,7 +24,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/052 b/tests/btrfs/052
index 09f03f8a1..a3a828f97 100755
--- a/tests/btrfs/052
+++ b/tests/btrfs/052
@@ -19,7 +19,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/053 b/tests/btrfs/053
index abfe372a5..5e047f7b3 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/054 b/tests/btrfs/054
index e38c085a1..7d98bf8d9 100755
--- a/tests/btrfs/054
+++ b/tests/btrfs/054
@@ -34,7 +34,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 
diff --git a/tests/btrfs/055 b/tests/btrfs/055
index 900c3dba8..bd0755d26 100755
--- a/tests/btrfs/055
+++ b/tests/btrfs/055
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 _require_btrfs_fs_feature "no_holes"
diff --git a/tests/btrfs/056 b/tests/btrfs/056
index 128c261a2..f7557f4a4 100755
--- a/tests/btrfs/056
+++ b/tests/btrfs/056
@@ -27,7 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 _require_btrfs_fs_feature "no_holes"
diff --git a/tests/btrfs/057 b/tests/btrfs/057
index 56db35950..07e605572 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -11,7 +11,6 @@ _begin_fstest auto quick
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_qgroup_rescan
 
diff --git a/tests/btrfs/058 b/tests/btrfs/058
index 6df1c50d9..7bc4af5b0 100755
--- a/tests/btrfs/058
+++ b/tests/btrfs/058
@@ -27,7 +27,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "-T"
 
diff --git a/tests/btrfs/059 b/tests/btrfs/059
index 27be69472..227ebb14d 100755
--- a/tests/btrfs/059
+++ b/tests/btrfs/059
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_btrfs_command "property"
diff --git a/tests/btrfs/060 b/tests/btrfs/060
index 27c4afe87..00f57841a 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/061 b/tests/btrfs/061
index 6ed80b20f..2b3b76a7f 100755
--- a/tests/btrfs/061
+++ b/tests/btrfs/061
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/062 b/tests/btrfs/062
index 5794697c8..4ab7ca534 100755
--- a/tests/btrfs/062
+++ b/tests/btrfs/062
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/063 b/tests/btrfs/063
index 8a95756ac..ea4275d29 100755
--- a/tests/btrfs/063
+++ b/tests/btrfs/063
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/064 b/tests/btrfs/064
index a439d5856..a8aa62513 100755
--- a/tests/btrfs/064
+++ b/tests/btrfs/064
@@ -30,7 +30,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 5
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index 0ad8f9e0d..5fb635abf 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 5
diff --git a/tests/btrfs/066 b/tests/btrfs/066
index efe5195eb..30fa438a5 100755
--- a/tests/btrfs/066
+++ b/tests/btrfs/066
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index 328d1671a..899b96da4 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index 0fe541f45..48b6cdb08 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -29,7 +29,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/069 b/tests/btrfs/069
index f8b54b460..510551760 100755
--- a/tests/btrfs/069
+++ b/tests/btrfs/069
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 5
diff --git a/tests/btrfs/070 b/tests/btrfs/070
index d0bd96743..f2e9dfcb1 100755
--- a/tests/btrfs/070
+++ b/tests/btrfs/070
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 5
diff --git a/tests/btrfs/071 b/tests/btrfs/071
index 509637389..5c65bcfe0 100755
--- a/tests/btrfs/071
+++ b/tests/btrfs/071
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 5
diff --git a/tests/btrfs/072 b/tests/btrfs/072
index 8f6ebca09..0a3da5ffd 100755
--- a/tests/btrfs/072
+++ b/tests/btrfs/072
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/073 b/tests/btrfs/073
index f6497e31f..bf7e9ca7a 100755
--- a/tests/btrfs/073
+++ b/tests/btrfs/073
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/074 b/tests/btrfs/074
index d35bbe1a1..f78267159 100755
--- a/tests/btrfs/074
+++ b/tests/btrfs/074
@@ -28,7 +28,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/075 b/tests/btrfs/075
index c54239e6c..917993ca2 100755
--- a/tests/btrfs/075
+++ b/tests/btrfs/075
@@ -20,7 +20,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 # SELINUX_MOUNT_OPTIONS will be set in common/config if selinux is enabled
diff --git a/tests/btrfs/076 b/tests/btrfs/076
index 730be879e..c148406fd 100755
--- a/tests/btrfs/076
+++ b/tests/btrfs/076
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/defrag
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _fixed_by_kernel_commit 4bcbb3325513 \
diff --git a/tests/btrfs/077 b/tests/btrfs/077
index cce054f81..4110c46dc 100755
--- a/tests/btrfs/077
+++ b/tests/btrfs/077
@@ -33,7 +33,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/078 b/tests/btrfs/078
index 9ebae93b1..bbebeff39 100755
--- a/tests/btrfs/078
+++ b/tests/btrfs/078
@@ -26,7 +26,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 workout()
diff --git a/tests/btrfs/079 b/tests/btrfs/079
index d13056ae8..d55858df0 100755
--- a/tests/btrfs/079
+++ b/tests/btrfs/079
@@ -32,7 +32,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 # Since xfs_io's fiemap always use SYNC flag and can't be unset,
 # we must use filefrag to call fiemap without SYNC flag.
diff --git a/tests/btrfs/080 b/tests/btrfs/080
index d4dea6d6e..ea9d09b04 100755
--- a/tests/btrfs/080
+++ b/tests/btrfs/080
@@ -30,7 +30,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_nocheck
 
 create_snapshot()
diff --git a/tests/btrfs/081 b/tests/btrfs/081
index c3f84c778..300ace53d 100755
--- a/tests/btrfs/081
+++ b/tests/btrfs/081
@@ -21,7 +21,6 @@ _begin_fstest auto quick clone
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/082 b/tests/btrfs/082
index c20896bfc..13cd1a287 100755
--- a/tests/btrfs/082
+++ b/tests/btrfs/082
@@ -20,7 +20,6 @@ _begin_fstest auto quick remount
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >$seqres.full 2>&1
diff --git a/tests/btrfs/083 b/tests/btrfs/083
index ae8cf9d46..37e9c4e46 100755
--- a/tests/btrfs/083
+++ b/tests/btrfs/083
@@ -25,7 +25,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/084 b/tests/btrfs/084
index 98c9af5fe..2da27308f 100755
--- a/tests/btrfs/084
+++ b/tests/btrfs/084
@@ -24,7 +24,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/085 b/tests/btrfs/085
index 12ae7dfae..291bb8af0 100755
--- a/tests/btrfs/085
+++ b/tests/btrfs/085
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 _require_btrfs_command inspect-internal dump-tree
diff --git a/tests/btrfs/086 b/tests/btrfs/086
index b0f9609df..c8d3adf04 100755
--- a/tests/btrfs/086
+++ b/tests/btrfs/086
@@ -20,7 +20,6 @@ _begin_fstest auto quick clone
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/087 b/tests/btrfs/087
index 28222e585..0c787e697 100755
--- a/tests/btrfs/087
+++ b/tests/btrfs/087
@@ -30,7 +30,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/088 b/tests/btrfs/088
index 1696d02a5..32d9d3d53 100755
--- a/tests/btrfs/088
+++ b/tests/btrfs/088
@@ -19,7 +19,6 @@ _begin_fstest auto quick metadata
 . ./common/filter
 . ./common/fail_make_request
 
-_supported_fs btrfs
 _require_scratch
 _require_fail_make_request
 
diff --git a/tests/btrfs/089 b/tests/btrfs/089
index 9460d4e8b..8f8e37b6f 100755
--- a/tests/btrfs/089
+++ b/tests/btrfs/089
@@ -14,7 +14,6 @@ _begin_fstest auto quick subvol
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/btrfs/090 b/tests/btrfs/090
index 49a4f3c09..779ae7c8f 100755
--- a/tests/btrfs/090
+++ b/tests/btrfs/090
@@ -18,7 +18,6 @@ _begin_fstest auto quick metadata
 
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool
 
diff --git a/tests/btrfs/091 b/tests/btrfs/091
index 3b5489665..3b479b5d0 100755
--- a/tests/btrfs/091
+++ b/tests/btrfs/091
@@ -13,7 +13,6 @@ _begin_fstest auto quick qgroup
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_scratch
 _require_cp_reflink
 _require_scratch_qgroup
diff --git a/tests/btrfs/092 b/tests/btrfs/092
index bcb3985ac..98c7d3680 100755
--- a/tests/btrfs/092
+++ b/tests/btrfs/092
@@ -29,7 +29,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/093 b/tests/btrfs/093
index eb4bea6ca..eabc56016 100755
--- a/tests/btrfs/093
+++ b/tests/btrfs/093
@@ -17,7 +17,6 @@ _begin_fstest auto quick clone
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/094 b/tests/btrfs/094
index fe401fc0a..b52464f04 100755
--- a/tests/btrfs/094
+++ b/tests/btrfs/094
@@ -29,7 +29,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/095 b/tests/btrfs/095
index b0076f3f1..de34d64b7 100755
--- a/tests/btrfs/095
+++ b/tests/btrfs/095
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 _require_cloner
diff --git a/tests/btrfs/096 b/tests/btrfs/096
index 8e014cd24..3fb1af692 100755
--- a/tests/btrfs/096
+++ b/tests/btrfs/096
@@ -12,7 +12,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/097 b/tests/btrfs/097
index f5222ff33..53ff66c21 100755
--- a/tests/btrfs/097
+++ b/tests/btrfs/097
@@ -19,7 +19,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/098 b/tests/btrfs/098
index 092543f40..6ee0b9101 100755
--- a/tests/btrfs/098
+++ b/tests/btrfs/098
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 _require_cloner
diff --git a/tests/btrfs/099 b/tests/btrfs/099
index a7c76f354..acd49c464 100755
--- a/tests/btrfs/099
+++ b/tests/btrfs/099
@@ -12,7 +12,6 @@ _begin_fstest auto quick qgroup limit
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
diff --git a/tests/btrfs/100 b/tests/btrfs/100
index 11dcbb8da..46bfc4f74 100755
--- a/tests/btrfs/100
+++ b/tests/btrfs/100
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter.btrfs
 . ./common/dmerror
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_dm_target error
 
diff --git a/tests/btrfs/101 b/tests/btrfs/101
index cedff5c49..c65e14ea0 100755
--- a/tests/btrfs/101
+++ b/tests/btrfs/101
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter.btrfs
 . ./common/dmerror
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_btrfs_dev_del_by_devid
 _require_dm_target error
diff --git a/tests/btrfs/102 b/tests/btrfs/102
index 303904b8e..d89f37c90 100755
--- a/tests/btrfs/102
+++ b/tests/btrfs/102
@@ -12,7 +12,6 @@ _begin_fstest auto quick metadata enospc balance
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/btrfs/103 b/tests/btrfs/103
index b60527cb1..3331f7a43 100755
--- a/tests/btrfs/103
+++ b/tests/btrfs/103
@@ -12,7 +12,6 @@ _begin_fstest auto quick clone compress
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/104 b/tests/btrfs/104
index 2ba9ec9d9..9479dca1d 100755
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -21,7 +21,6 @@ _begin_fstest auto qgroup
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
diff --git a/tests/btrfs/105 b/tests/btrfs/105
index 14b19f5d6..4343cce0c 100755
--- a/tests/btrfs/105
+++ b/tests/btrfs/105
@@ -22,7 +22,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
diff --git a/tests/btrfs/106 b/tests/btrfs/106
index 2eb02be7d..4876a6004 100755
--- a/tests/btrfs/106
+++ b/tests/btrfs/106
@@ -13,7 +13,6 @@ _begin_fstest auto quick clone compress
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/107 b/tests/btrfs/107
index ae83f4d37..123906fb0 100755
--- a/tests/btrfs/107
+++ b/tests/btrfs/107
@@ -13,7 +13,6 @@ _begin_fstest auto quick prealloc
 . ./common/filter
 . ./common/defrag
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc"
 
diff --git a/tests/btrfs/108 b/tests/btrfs/108
index 7d14a22d6..fe990343e 100755
--- a/tests/btrfs/108
+++ b/tests/btrfs/108
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_scratch
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/btrfs/109 b/tests/btrfs/109
index 13d3446fc..0948c8366 100755
--- a/tests/btrfs/109
+++ b/tests/btrfs/109
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_scratch
 _require_cp_reflink
 
diff --git a/tests/btrfs/110 b/tests/btrfs/110
index e4f974fcd..76fca6f2b 100755
--- a/tests/btrfs/110
+++ b/tests/btrfs/110
@@ -20,7 +20,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
diff --git a/tests/btrfs/111 b/tests/btrfs/111
index e5dfd227f..956c956c8 100755
--- a/tests/btrfs/111
+++ b/tests/btrfs/111
@@ -20,7 +20,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
diff --git a/tests/btrfs/112 b/tests/btrfs/112
index 2e1238288..1326b824b 100755
--- a/tests/btrfs/112
+++ b/tests/btrfs/112
@@ -13,7 +13,6 @@ _begin_fstest auto quick clone prealloc compress
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 _require_btrfs_fs_feature "no_holes"
diff --git a/tests/btrfs/113 b/tests/btrfs/113
index a076a06f2..e732ea6e9 100755
--- a/tests/btrfs/113
+++ b/tests/btrfs/113
@@ -15,7 +15,6 @@ _begin_fstest auto quick compress clone
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch
 _require_cloner
 
diff --git a/tests/btrfs/114 b/tests/btrfs/114
index 35efbd771..f1327d409 100755
--- a/tests/btrfs/114
+++ b/tests/btrfs/114
@@ -12,7 +12,6 @@ _begin_fstest auto qgroup
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/btrfs/115 b/tests/btrfs/115
index 4af83b617..db74d4cb5 100755
--- a/tests/btrfs/115
+++ b/tests/btrfs/115
@@ -12,7 +12,6 @@ _begin_fstest auto qgroup
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/btrfs/116 b/tests/btrfs/116
index 99da568da..a471f137c 100755
--- a/tests/btrfs/116
+++ b/tests/btrfs/116
@@ -14,7 +14,6 @@ _begin_fstest auto quick metadata
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 # Writing non-contiguous data directly to the device
 _require_non_zoned_device $SCRATCH_DEV
diff --git a/tests/btrfs/117 b/tests/btrfs/117
index 1cc824bed..caed7c0f6 100755
--- a/tests/btrfs/117
+++ b/tests/btrfs/117
@@ -16,7 +16,6 @@ tmp=`mktemp -d`
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_scratch
 _require_cp_reflink
 
diff --git a/tests/btrfs/118 b/tests/btrfs/118
index 0bb50b101..d65398379 100755
--- a/tests/btrfs/118
+++ b/tests/btrfs/118
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/btrfs/119 b/tests/btrfs/119
index 8e7c4789c..a934ad634 100755
--- a/tests/btrfs/119
+++ b/tests/btrfs/119
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/btrfs/120 b/tests/btrfs/120
index 18cd87d4d..a9b8adecf 100755
--- a/tests/btrfs/120
+++ b/tests/btrfs/120
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/btrfs/121 b/tests/btrfs/121
index 8be9a167c..8ed52b032 100755
--- a/tests/btrfs/121
+++ b/tests/btrfs/121
@@ -16,7 +16,6 @@ _begin_fstest auto quick snapshot qgroup
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >/dev/null
diff --git a/tests/btrfs/122 b/tests/btrfs/122
index 04170d30d..9e1ee639b 100755
--- a/tests/btrfs/122
+++ b/tests/btrfs/122
@@ -12,7 +12,6 @@ _begin_fstest auto quick snapshot qgroup
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
diff --git a/tests/btrfs/123 b/tests/btrfs/123
index 282b7ce23..127bdf34c 100755
--- a/tests/btrfs/123
+++ b/tests/btrfs/123
@@ -15,7 +15,6 @@ _begin_fstest auto quick qgroup balance
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
diff --git a/tests/btrfs/124 b/tests/btrfs/124
index ba001ff8a..af079c286 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -35,7 +35,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 2
 _test_unmount
 _require_btrfs_forget_or_module_loadable
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 5d76018c0..31379d81e 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -34,7 +34,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 _test_unmount
 _require_btrfs_forget_or_module_loadable
diff --git a/tests/btrfs/126 b/tests/btrfs/126
index 637fde43b..038f274a0 100755
--- a/tests/btrfs/126
+++ b/tests/btrfs/126
@@ -11,7 +11,6 @@ _begin_fstest auto quick qgroup limit
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
diff --git a/tests/btrfs/127 b/tests/btrfs/127
index 2bdb235b3..0bd0eb48e 100755
--- a/tests/btrfs/127
+++ b/tests/btrfs/127
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/128 b/tests/btrfs/128
index e7a6e35bb..615c3e48a 100755
--- a/tests/btrfs/128
+++ b/tests/btrfs/128
@@ -20,7 +20,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/129 b/tests/btrfs/129
index 64b02109f..a9fd87e8d 100755
--- a/tests/btrfs/129
+++ b/tests/btrfs/129
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/130 b/tests/btrfs/130
index 31fe7589e..36bc2e311 100755
--- a/tests/btrfs/130
+++ b/tests/btrfs/130
@@ -17,7 +17,6 @@ _begin_fstest auto quick clone send
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_scratch
 _require_scratch_reflink
 
diff --git a/tests/btrfs/131 b/tests/btrfs/131
index ef8f49188..b4756a5fb 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -11,7 +11,6 @@ _begin_fstest auto quick
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-super
 _require_btrfs_fs_feature free_space_tree
diff --git a/tests/btrfs/132 b/tests/btrfs/132
index d0ac51e47..57d9751c0 100755
--- a/tests/btrfs/132
+++ b/tests/btrfs/132
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 # Use small filesystem to trigger the bug more easily
diff --git a/tests/btrfs/133 b/tests/btrfs/133
index 428736ef8..e3a53331b 100755
--- a/tests/btrfs/133
+++ b/tests/btrfs/133
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/134 b/tests/btrfs/134
index a48b5bbdb..fbb40631b 100755
--- a/tests/btrfs/134
+++ b/tests/btrfs/134
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/135 b/tests/btrfs/135
index f57a8ad2b..9e9e55e7c 100755
--- a/tests/btrfs/135
+++ b/tests/btrfs/135
@@ -22,7 +22,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/136 b/tests/btrfs/136
index 3cb7150f9..9b5b33311 100755
--- a/tests/btrfs/136
+++ b/tests/btrfs/136
@@ -16,7 +16,6 @@ _begin_fstest auto convert
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_nocheck
 # ext4 does not support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
diff --git a/tests/btrfs/137 b/tests/btrfs/137
index acef0b750..7710dc18d 100755
--- a/tests/btrfs/137
+++ b/tests/btrfs/137
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/punch
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_xfs_io_command "fiemap"
diff --git a/tests/btrfs/138 b/tests/btrfs/138
index c2d272d10..17bbe28e5 100755
--- a/tests/btrfs/138
+++ b/tests/btrfs/138
@@ -12,7 +12,6 @@ _begin_fstest auto compress
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_command property
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/139 b/tests/btrfs/139
index 6f5462af4..aa39eea3c 100755
--- a/tests/btrfs/139
+++ b/tests/btrfs/139
@@ -14,7 +14,6 @@ _begin_fstest auto qgroup limit
 
 . ./common/filter
 
-_supported_fs btrfs
 # We at least need 2GB of free space on $SCRATCH_DEV
 _require_scratch_size $((2 * 1024 * 1024))
 
diff --git a/tests/btrfs/140 b/tests/btrfs/140
index eb0fbc13b..b2c8451dd 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -16,7 +16,6 @@ _begin_fstest auto quick read_repair fiemap
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 2
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index d46301a52..3d48dff35 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -17,7 +17,6 @@ _begin_fstest auto quick read_repair
 
 . ./common/filter
 
-_supported_fs btrfs
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
 _require_scratch_dev_pool 2
diff --git a/tests/btrfs/142 b/tests/btrfs/142
index d9a8609e2..cf7e8daa3 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -18,7 +18,6 @@ _begin_fstest auto quick read_repair
 . ./common/filter
 . ./common/dmdust
 
-_supported_fs btrfs
 _require_scratch_dev_pool 2
 _require_dm_target dust
 
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 07ebf33c3..5da9a578f 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -25,7 +25,6 @@ _begin_fstest auto quick read_repair
 . ./common/filter
 . ./common/dmdust
 
-_supported_fs btrfs
 _require_scratch_dev_pool 2
 _require_dm_target dust
 
diff --git a/tests/btrfs/144 b/tests/btrfs/144
index daae7821c..62c81ce93 100755
--- a/tests/btrfs/144
+++ b/tests/btrfs/144
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/145 b/tests/btrfs/145
index 4e10a0e03..0f55a87b2 100755
--- a/tests/btrfs/145
+++ b/tests/btrfs/145
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/146 b/tests/btrfs/146
index f734b6106..d6d2829aa 100755
--- a/tests/btrfs/146
+++ b/tests/btrfs/146
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-_supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool
 _require_dm_target error
diff --git a/tests/btrfs/147 b/tests/btrfs/147
index 71703be32..e4f40df16 100755
--- a/tests/btrfs/147
+++ b/tests/btrfs/147
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/148 b/tests/btrfs/148
index 74d48b6e9..3f651e54a 100755
--- a/tests/btrfs/148
+++ b/tests/btrfs/148
@@ -11,7 +11,6 @@ _begin_fstest auto quick rw scrub
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool 4
 _require_odirect
diff --git a/tests/btrfs/149 b/tests/btrfs/149
index 5054a57c1..aec34969c 100755
--- a/tests/btrfs/149
+++ b/tests/btrfs/149
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_scratch_reflink
diff --git a/tests/btrfs/150 b/tests/btrfs/150
index fd386d92d..a37f252b3 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -16,7 +16,6 @@ _begin_fstest auto quick dangerous read_repair compress
 . ./common/filter
 . ./common/fail_make_request
 
-_supported_fs btrfs
 _require_debugfs
 _require_scratch
 _require_fail_make_request
diff --git a/tests/btrfs/151 b/tests/btrfs/151
index edf42a83d..f635aa250 100755
--- a/tests/btrfs/151
+++ b/tests/btrfs/151
@@ -15,7 +15,6 @@ _begin_fstest auto quick volume
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool 3
 _require_btrfs_dev_del_by_devid
diff --git a/tests/btrfs/152 b/tests/btrfs/152
index 9ea2128c7..d819d6ca4 100755
--- a/tests/btrfs/152
+++ b/tests/btrfs/152
@@ -12,7 +12,6 @@ _begin_fstest auto quick metadata qgroup send
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/btrfs/153 b/tests/btrfs/153
index 8dd3cd971..40cb15264 100755
--- a/tests/btrfs/153
+++ b/tests/btrfs/153
@@ -11,7 +11,6 @@ _begin_fstest auto quick qgroup limit preallocrw
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/154 b/tests/btrfs/154
index ccd760358..86c141428 100755
--- a/tests/btrfs/154
+++ b/tests/btrfs/154
@@ -16,7 +16,6 @@ _begin_fstest auto quick
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_command $PYTHON3_PROG python3
 
diff --git a/tests/btrfs/155 b/tests/btrfs/155
index 70cccab7c..b309a8153 100755
--- a/tests/btrfs/155
+++ b/tests/btrfs/155
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/156 b/tests/btrfs/156
index eb8fd0624..d6cd0fde8 100755
--- a/tests/btrfs/156
+++ b/tests/btrfs/156
@@ -19,7 +19,6 @@ _begin_fstest auto quick trim balance
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fstrim
 
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 05cb94d0c..c49229f0b 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -25,7 +25,6 @@ _begin_fstest auto quick raid read_repair
 
 . ./common/filter
 
-_supported_fs btrfs
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index 78a527c27..ff28defea 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -17,7 +17,6 @@ _begin_fstest auto quick raid scrub
 
 . ./common/filter
 
-_supported_fs btrfs
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/159 b/tests/btrfs/159
index 0cbf5be14..577652380 100755
--- a/tests/btrfs/159
+++ b/tests/btrfs/159
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 _require_xfs_io_command "fpunch"
diff --git a/tests/btrfs/160 b/tests/btrfs/160
index 23a2a8c42..04ed1f176 100755
--- a/tests/btrfs/160
+++ b/tests/btrfs/160
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-_supported_fs btrfs
 _require_scratch_dev_pool
 
 _require_dm_target error
diff --git a/tests/btrfs/161 b/tests/btrfs/161
index 57c54a887..896706828 100755
--- a/tests/btrfs/161
+++ b/tests/btrfs/161
@@ -13,7 +13,6 @@ _begin_fstest auto quick volume seed
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_scratch_dev_pool 2
 
diff --git a/tests/btrfs/162 b/tests/btrfs/162
index 31b794d94..bb70789bd 100755
--- a/tests/btrfs/162
+++ b/tests/btrfs/162
@@ -15,7 +15,6 @@ _begin_fstest auto quick volume seed
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_scratch_dev_pool 3
 
diff --git a/tests/btrfs/163 b/tests/btrfs/163
index d2c192c94..3050689d7 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -27,7 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_scratch_dev_pool 3
 _require_btrfs_forget_or_module_loadable
diff --git a/tests/btrfs/164 b/tests/btrfs/164
index 433a321f4..a7d7de615 100755
--- a/tests/btrfs/164
+++ b/tests/btrfs/164
@@ -20,7 +20,6 @@ _cleanup()
 	_btrfs_rescan_devices
 }
 
-_supported_fs btrfs
 _require_btrfs_forget_or_module_loadable
 _require_scratch_dev_pool 2
 
diff --git a/tests/btrfs/165 b/tests/btrfs/165
index bab40060b..a1099d88d 100755
--- a/tests/btrfs/165
+++ b/tests/btrfs/165
@@ -33,7 +33,6 @@ rm_r_subvol() {
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_fs_feature "rmdir_subvol"
 
diff --git a/tests/btrfs/166 b/tests/btrfs/166
index 4c2af53b2..719e2a3b6 100755
--- a/tests/btrfs/166
+++ b/tests/btrfs/166
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/btrfs/167 b/tests/btrfs/167
index 57c2afad7..cad949549 100755
--- a/tests/btrfs/167
+++ b/tests/btrfs/167
@@ -15,7 +15,6 @@ _begin_fstest auto quick replace volume remount compress
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 2
 _require_scratch_dev_pool_equal_size
 
diff --git a/tests/btrfs/168 b/tests/btrfs/168
index 7879ec056..85e803969 100755
--- a/tests/btrfs/168
+++ b/tests/btrfs/168
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_btrfs_command "property"
diff --git a/tests/btrfs/169 b/tests/btrfs/169
index 75a8ee8b3..44da69794 100755
--- a/tests/btrfs/169
+++ b/tests/btrfs/169
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_xfs_io_command "fpunch"
diff --git a/tests/btrfs/170 b/tests/btrfs/170
index 1beec6d7f..2134ae97d 100755
--- a/tests/btrfs/170
+++ b/tests/btrfs/170
@@ -13,7 +13,6 @@ _begin_fstest auto quick snapshot prealloc
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
 
diff --git a/tests/btrfs/171 b/tests/btrfs/171
index e820fd9d5..48dee1761 100755
--- a/tests/btrfs/171
+++ b/tests/btrfs/171
@@ -16,7 +16,6 @@ _begin_fstest auto quick qgroup
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/172 b/tests/btrfs/172
index fbb7739da..dc997c68b 100755
--- a/tests/btrfs/172
+++ b/tests/btrfs/172
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmlogwrites
 
-_supported_fs btrfs
 _require_scratch
 _require_log_writes
 _require_xfs_io_command "sync_range"
diff --git a/tests/btrfs/173 b/tests/btrfs/173
index 42af2d266..61a7cbf71 100755
--- a/tests/btrfs/173
+++ b/tests/btrfs/173
@@ -12,7 +12,6 @@ _begin_fstest auto quick swap compress
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_swapfile
 
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/btrfs/174 b/tests/btrfs/174
index 16305c187..7eb50f059 100755
--- a/tests/btrfs/174
+++ b/tests/btrfs/174
@@ -12,7 +12,6 @@ _begin_fstest auto quick swap compress
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_swapfile
 
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/btrfs/175 b/tests/btrfs/175
index de52c71ee..2208d5f1c 100755
--- a/tests/btrfs/175
+++ b/tests/btrfs/175
@@ -11,7 +11,6 @@ _begin_fstest auto quick swap volume
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 2
 _require_scratch_swapfile
 _check_minimal_fs_size $((1024 * 1024 * 1024))
diff --git a/tests/btrfs/176 b/tests/btrfs/176
index 767544108..86796c881 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -11,7 +11,6 @@ _begin_fstest auto quick swap volume
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_scratch_swapfile
 
diff --git a/tests/btrfs/177 b/tests/btrfs/177
index 38c3d41d4..7b13cd8d2 100755
--- a/tests/btrfs/177
+++ b/tests/btrfs/177
@@ -11,7 +11,6 @@ _begin_fstest auto quick swap balance
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_swapfile
 
 # Eliminate the differences between the old and new output formats
diff --git a/tests/btrfs/178 b/tests/btrfs/178
index fda287dd9..1bd6dacf5 100755
--- a/tests/btrfs/178
+++ b/tests/btrfs/178
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/179 b/tests/btrfs/179
index 7fcdbfd32..290e57966 100755
--- a/tests/btrfs/179
+++ b/tests/btrfs/179
@@ -14,7 +14,6 @@ _begin_fstest auto qgroup dangerous
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 # default sleep interval
diff --git a/tests/btrfs/180 b/tests/btrfs/180
index 59bb3c83d..dba757de2 100755
--- a/tests/btrfs/180
+++ b/tests/btrfs/180
@@ -15,7 +15,6 @@ _begin_fstest auto quick qgroup limit prealloc
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command falloc
 
diff --git a/tests/btrfs/181 b/tests/btrfs/181
index 068e6e8e4..eab3b6a86 100755
--- a/tests/btrfs/181
+++ b/tests/btrfs/181
@@ -15,7 +15,6 @@ _begin_fstest auto quick balance
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-super
 
diff --git a/tests/btrfs/182 b/tests/btrfs/182
index b5bd022b7..865cbef02 100755
--- a/tests/btrfs/182
+++ b/tests/btrfs/182
@@ -17,7 +17,6 @@ _begin_fstest auto quick balance
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 nr_files=1024
diff --git a/tests/btrfs/183 b/tests/btrfs/183
index 9d3e78cc8..acc6bbede 100755
--- a/tests/btrfs/183
+++ b/tests/btrfs/183
@@ -13,7 +13,6 @@ _begin_fstest auto quick clone compress punch
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_scratch_reflink
 _require_xfs_io_command "fpunch"
 
diff --git a/tests/btrfs/184 b/tests/btrfs/184
index ad9574578..575807b0b 100755
--- a/tests/btrfs/184
+++ b/tests/btrfs/184
@@ -12,7 +12,6 @@ _begin_fstest auto quick volume
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool 2
 _require_btrfs_command inspect-internal dump-super
diff --git a/tests/btrfs/185 b/tests/btrfs/185
index 2050672ed..8d0643450 100755
--- a/tests/btrfs/185
+++ b/tests/btrfs/185
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
 _fixed_by_kernel_commit a9261d4125c9 \
diff --git a/tests/btrfs/186 b/tests/btrfs/186
index 164e39757..a7d68c708 100755
--- a/tests/btrfs/186
+++ b/tests/btrfs/186
@@ -22,7 +22,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_btrfs_command "property"
diff --git a/tests/btrfs/187 b/tests/btrfs/187
index a7957e88a..993d14bec 100755
--- a/tests/btrfs/187
+++ b/tests/btrfs/187
@@ -19,7 +19,6 @@ _begin_fstest auto send dedupe clone balance
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_scratch_dedupe
 _require_attrs
 
diff --git a/tests/btrfs/188 b/tests/btrfs/188
index 8d0e455ee..6a3e98318 100755
--- a/tests/btrfs/188
+++ b/tests/btrfs/188
@@ -22,7 +22,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_btrfs_fs_feature "no_holes"
diff --git a/tests/btrfs/189 b/tests/btrfs/189
index 179ff0799..e120add6d 100755
--- a/tests/btrfs/189
+++ b/tests/btrfs/189
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_fssum
 _require_test
 _require_scratch_reflink
diff --git a/tests/btrfs/190 b/tests/btrfs/190
index 6d805e6be..5a91bec6b 100755
--- a/tests/btrfs/190
+++ b/tests/btrfs/190
@@ -13,7 +13,6 @@ _begin_fstest auto quick replay balance qgroup recoveryloop
 . ./common/filter
 . ./common/dmlogwrites
 
-_supported_fs btrfs
 _require_scratch
 # and we need extra device as log device
 _require_log_writes
diff --git a/tests/btrfs/191 b/tests/btrfs/191
index 8bf591b6e..e331a53bd 100755
--- a/tests/btrfs/191
+++ b/tests/btrfs/191
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_test
 _require_scratch_dedupe
 _require_fssum
diff --git a/tests/btrfs/192 b/tests/btrfs/192
index 0a35e055b..f7fb65b8d 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/attr
 . ./common/dmlogwrites
 
-_supported_fs btrfs
 
 _require_command "$KILLALL_PROG" killall
 _require_command "$BLKDISCARD_PROG" blkdiscard
diff --git a/tests/btrfs/193 b/tests/btrfs/193
index bf9e92b4a..4326e188b 100755
--- a/tests/btrfs/193
+++ b/tests/btrfs/193
@@ -14,7 +14,6 @@ _begin_fstest auto quick qgroup enospc limit prealloc
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command falloc
 
diff --git a/tests/btrfs/194 b/tests/btrfs/194
index 726f61d42..fb3687655 100755
--- a/tests/btrfs/194
+++ b/tests/btrfs/194
@@ -15,7 +15,6 @@ _begin_fstest auto volume
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
 
diff --git a/tests/btrfs/195 b/tests/btrfs/195
index 6de701211..72fc3a775 100755
--- a/tests/btrfs/195
+++ b/tests/btrfs/195
@@ -12,7 +12,6 @@ _begin_fstest auto volume balance scrub
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 4
 # Zoned btrfs only supports SINGLE profile
 _require_non_zoned_device "${SCRATCH_DEV}"
diff --git a/tests/btrfs/196 b/tests/btrfs/196
index 9602c6f44..01622aaa7 100755
--- a/tests/btrfs/196
+++ b/tests/btrfs/196
@@ -29,7 +29,6 @@ _cleanup()
 . ./common/dmthin
 . ./common/dmlogwrites
 
-_supported_fs btrfs
 
 # Use thin device as replay device, which requires $SCRATCH_DEV
 _require_scratch_nocheck
diff --git a/tests/btrfs/197 b/tests/btrfs/197
index 85f904c5f..9f1d879a4 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_scratch_dev_pool 5
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index e3c4b74a5..d17ab6dab 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -12,7 +12,6 @@ _begin_fstest auto quick volume
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_command "$WIPEFS_PROG" wipefs
 _require_scratch
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/199 b/tests/btrfs/199
index ff6877048..f161e5505 100755
--- a/tests/btrfs/199
+++ b/tests/btrfs/199
@@ -26,7 +26,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _fixed_by_kernel_commit 6b7faadd985c \
 	"btrfs: Ensure we trim ranges across block group boundary"
 
diff --git a/tests/btrfs/200 b/tests/btrfs/200
index cd3e3b83a..e62937a40 100755
--- a/tests/btrfs/200
+++ b/tests/btrfs/200
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/punch
 
-_supported_fs btrfs
 _require_fssum
 _require_test
 _require_scratch_reflink
diff --git a/tests/btrfs/201 b/tests/btrfs/201
index 007319ae4..eb727cd23 100755
--- a/tests/btrfs/201
+++ b/tests/btrfs/201
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 _require_attrs
diff --git a/tests/btrfs/202 b/tests/btrfs/202
index d6077853a..a9e32f6ef 100755
--- a/tests/btrfs/202
+++ b/tests/btrfs/202
@@ -10,7 +10,6 @@ _begin_fstest auto quick subvol snapshot
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/btrfs/203 b/tests/btrfs/203
index 45872b85a..b3a4bdd68 100755
--- a/tests/btrfs/203
+++ b/tests/btrfs/203
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_test
 _require_scratch_reflink
 
diff --git a/tests/btrfs/204 b/tests/btrfs/204
index 73511d997..e75d6aadd 100755
--- a/tests/btrfs/204
+++ b/tests/btrfs/204
@@ -12,7 +12,6 @@ _begin_fstest auto quick punch
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fpunch"
 
diff --git a/tests/btrfs/205 b/tests/btrfs/205
index 096a5dd9e..13a1df8b9 100755
--- a/tests/btrfs/205
+++ b/tests/btrfs/205
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone compress prealloc
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_scratch_reflink
 _require_xfs_io_command "falloc" "-k"
 _require_command "$CHATTR_PROG" chattr
diff --git a/tests/btrfs/206 b/tests/btrfs/206
index 39fac00da..258328a1a 100755
--- a/tests/btrfs/206
+++ b/tests/btrfs/206
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmlogwrites
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_log_writes
diff --git a/tests/btrfs/207 b/tests/btrfs/207
index fc18b17f6..e6faf6c78 100755
--- a/tests/btrfs/207
+++ b/tests/btrfs/207
@@ -12,7 +12,6 @@ _begin_fstest auto rw raid
 
 . ./common/filter
 
-_supported_fs btrfs
 # we check scratch dev after each loop
 _require_scratch_nocheck
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/208 b/tests/btrfs/208
index c104fa745..5ea732ae8 100755
--- a/tests/btrfs/208
+++ b/tests/btrfs/208
@@ -13,7 +13,6 @@ _begin_fstest auto quick subvol
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_command subvolume delete --subvolid
 
diff --git a/tests/btrfs/209 b/tests/btrfs/209
index 9f8808b60..5a5964a3e 100755
--- a/tests/btrfs/209
+++ b/tests/btrfs/209
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 _require_btrfs_fs_feature "no_holes"
diff --git a/tests/btrfs/210 b/tests/btrfs/210
index 021a4b8a5..3df2e8970 100755
--- a/tests/btrfs/210
+++ b/tests/btrfs/210
@@ -12,7 +12,6 @@ _begin_fstest auto quick qgroup snapshot
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >/dev/null
diff --git a/tests/btrfs/211 b/tests/btrfs/211
index d80dc06f1..012714910 100755
--- a/tests/btrfs/211
+++ b/tests/btrfs/211
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
 # fiemap needed by _count_extents()
diff --git a/tests/btrfs/212 b/tests/btrfs/212
index 71337722b..f356d7d0f 100755
--- a/tests/btrfs/212
+++ b/tests/btrfs/212
@@ -24,7 +24,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_command "$KILLALL_PROG" killall
 
diff --git a/tests/btrfs/213 b/tests/btrfs/213
index 33504d3da..694a277c2 100755
--- a/tests/btrfs/213
+++ b/tests/btrfs/213
@@ -19,7 +19,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command pwrite -D
 
diff --git a/tests/btrfs/214 b/tests/btrfs/214
index 24d7c9814..994ba6b31 100755
--- a/tests/btrfs/214
+++ b/tests/btrfs/214
@@ -13,7 +13,6 @@ _register_cleanup "cleanup"
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_command "$SETCAP_PROG" setcap
 _require_command "$GETCAP_PROG" getcap
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index 7054a9ba7..b63ebff67 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -20,7 +20,6 @@ get_physical()
 		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /0/) { print \$6 }"
 }
 
-_supported_fs btrfs
 _require_scratch
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/216 b/tests/btrfs/216
index e606ca33a..08062c5ef 100755
--- a/tests/btrfs/216
+++ b/tests/btrfs/216
@@ -12,7 +12,6 @@ _begin_fstest auto quick seed
 
 . ./common/filter
 
-_supported_fs btrfs
 _fixed_by_kernel_commit 4faf55b03823 \
 	"btrfs: don't traverse into the seed devices in show_devname"
 _require_scratch_dev_pool 2
diff --git a/tests/btrfs/217 b/tests/btrfs/217
index f96a6933b..6f0292aeb 100755
--- a/tests/btrfs/217
+++ b/tests/btrfs/217
@@ -14,7 +14,6 @@ _begin_fstest auto quick trim dangerous
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_size $((5 * 1024 * 1024)) #kB
 _require_fstrim
 
diff --git a/tests/btrfs/218 b/tests/btrfs/218
index 9578d4c2b..70b3b938e 100755
--- a/tests/btrfs/218
+++ b/tests/btrfs/218
@@ -13,7 +13,6 @@ _begin_fstest auto quick volume
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _fixed_by_kernel_commit 124604eb50f8 \
 	"btrfs: init device stats for seed devices"
 _require_test
diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 6f89b8aed..052f61a39 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -37,7 +37,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 
 loop_mnt1=$TEST_DIR/$seq/mnt1
 loop_mnt2=$TEST_DIR/$seq/mnt2
diff --git a/tests/btrfs/220 b/tests/btrfs/220
index 2b62c9bbe..b98d4149d 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -14,7 +14,6 @@ _register_cleanup "cleanup"
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 cleanup()
diff --git a/tests/btrfs/221 b/tests/btrfs/221
index be5d7be39..b1ff34f4b 100755
--- a/tests/btrfs/221
+++ b/tests/btrfs/221
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/222 b/tests/btrfs/222
index e73210119..36684eb3c 100755
--- a/tests/btrfs/222
+++ b/tests/btrfs/222
@@ -22,7 +22,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/223 b/tests/btrfs/223
index e69ed7062..f6c0daa64 100755
--- a/tests/btrfs/223
+++ b/tests/btrfs/223
@@ -14,7 +14,6 @@ _begin_fstest auto quick replace trim
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_command "$WIPEFS_PROG" wipefs
 
diff --git a/tests/btrfs/224 b/tests/btrfs/224
index 28b39121c..02ef80e40 100755
--- a/tests/btrfs/224
+++ b/tests/btrfs/224
@@ -12,7 +12,6 @@ _begin_fstest auto quick qgroup
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 
 _require_scratch
 _require_btrfs_qgroup_report
diff --git a/tests/btrfs/225 b/tests/btrfs/225
index d6b1cbc1f..9e2549354 100755
--- a/tests/btrfs/225
+++ b/tests/btrfs/225
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _fixed_by_kernel_commit b5ddcffa3777 \
 	"btrfs: fix put of uninitialized kobject after seed device delete"
 _require_test
diff --git a/tests/btrfs/226 b/tests/btrfs/226
index dd6743d6f..70275d0aa 100755
--- a/tests/btrfs/226
+++ b/tests/btrfs/226
@@ -13,7 +13,6 @@ _begin_fstest auto quick rw snapshot clone prealloc punch
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_scratch_reflink
 _require_chattr C
 _require_odirect
diff --git a/tests/btrfs/227 b/tests/btrfs/227
index 4663874c2..a73b125ea 100755
--- a/tests/btrfs/227
+++ b/tests/btrfs/227
@@ -22,7 +22,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/228 b/tests/btrfs/228
index c7eeade1a..9caa6a33f 100755
--- a/tests/btrfs/228
+++ b/tests/btrfs/228
@@ -11,7 +11,6 @@ _begin_fstest auto quick volume
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-tree
 
diff --git a/tests/btrfs/229 b/tests/btrfs/229
index 54ed74a10..b263aa1fd 100755
--- a/tests/btrfs/229
+++ b/tests/btrfs/229
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-_supported_fs btrfs
 _require_test
 _require_scratch_reflink
 
diff --git a/tests/btrfs/230 b/tests/btrfs/230
index 4cef062b0..79511661e 100755
--- a/tests/btrfs/230
+++ b/tests/btrfs/230
@@ -12,7 +12,6 @@ _begin_fstest auto quick qgroup limit
 
 . ./common/filter
 
-_supported_fs btrfs
 
 # This test requires specific data space usage, skip if we have compression
 # enabled.
diff --git a/tests/btrfs/231 b/tests/btrfs/231
index 698012958..d9d011500 100755
--- a/tests/btrfs/231
+++ b/tests/btrfs/231
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_fs_feature "no_holes"
 _require_btrfs_mkfs_feature "no-holes"
diff --git a/tests/btrfs/232 b/tests/btrfs/232
index 9caeee4c6..4dcc39cc4 100755
--- a/tests/btrfs/232
+++ b/tests/btrfs/232
@@ -28,7 +28,6 @@ writer()
 	done
 }
 
-_supported_fs btrfs
 
 # This test requires specific data space usage, skip if we have compression
 # enabled.
diff --git a/tests/btrfs/233 b/tests/btrfs/233
index 1a7ea6ada..6c7cdc9a7 100755
--- a/tests/btrfs/233
+++ b/tests/btrfs/233
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter.btrfs
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 _require_btrfs_command inspect-internal dump-tree
diff --git a/tests/btrfs/234 b/tests/btrfs/234
index eccfc5ca7..512a8cb55 100755
--- a/tests/btrfs/234
+++ b/tests/btrfs/234
@@ -13,7 +13,6 @@ _begin_fstest auto quick compress rw
 . ./common/filter
 . ./common/attr
 
-_supported_fs btrfs
 _require_scratch
 _require_odirect
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/235 b/tests/btrfs/235
index a1ec3aadb..dae5c7c12 100755
--- a/tests/btrfs/235
+++ b/tests/btrfs/235
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_command "$SETCAP_PROG" setcap
diff --git a/tests/btrfs/236 b/tests/btrfs/236
index ed3bddb88..a3b58f0cd 100755
--- a/tests/btrfs/236
+++ b/tests/btrfs/236
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 33b2f262c..2839f6e42 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -14,7 +14,6 @@ _begin_fstest auto quick zone balance
 
 . ./common/zoned
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_command filesystem sync
diff --git a/tests/btrfs/238 b/tests/btrfs/238
index b85eb3400..bbdce6a55 100755
--- a/tests/btrfs/238
+++ b/tests/btrfs/238
@@ -11,7 +11,6 @@ _begin_fstest auto quick seed trim
 
 . ./common/filter
 
-_supported_fs btrfs
 _fixed_by_kernel_commit 5e753a817b2d \
 	"btrfs: fix unmountable seed device after fstrim"
 _require_command "$BTRFS_TUNE_PROG" btrfstune
diff --git a/tests/btrfs/239 b/tests/btrfs/239
index 41fe438eb..3ac490273 100755
--- a/tests/btrfs/239
+++ b/tests/btrfs/239
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/btrfs/240 b/tests/btrfs/240
index f0fcf8a48..6ad7adc11 100755
--- a/tests/btrfs/240
+++ b/tests/btrfs/240
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/241 b/tests/btrfs/241
index 32f0e1093..a4d2471d4 100755
--- a/tests/btrfs/241
+++ b/tests/btrfs/241
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/btrfs/242 b/tests/btrfs/242
index 8daf0f2e0..daa2d972e 100755
--- a/tests/btrfs/242
+++ b/tests/btrfs/242
@@ -13,7 +13,6 @@ _begin_fstest auto quick volume trim
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_btrfs_forget_or_module_loadable
 _require_scratch_dev_pool 2
 
diff --git a/tests/btrfs/243 b/tests/btrfs/243
index 1ad0fa580..6e0649fbc 100755
--- a/tests/btrfs/243
+++ b/tests/btrfs/243
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-_supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/btrfs/244 b/tests/btrfs/244
index 4c5d69e71..a806685de 100755
--- a/tests/btrfs/244
+++ b/tests/btrfs/244
@@ -17,7 +17,6 @@ _begin_fstest auto quick volume dangerous
 # 	rm -r -f $tmp.*
 # }
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/btrfs/245 b/tests/btrfs/245
index c580b1fad..4d6bc5e00 100755
--- a/tests/btrfs/245
+++ b/tests/btrfs/245
@@ -12,7 +12,6 @@ _begin_fstest auto quick idmapped subvol
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_idmapped_mounts
 _require_test
 _require_scratch
diff --git a/tests/btrfs/246 b/tests/btrfs/246
index 3617d7fc3..ce58a15ae 100755
--- a/tests/btrfs/246
+++ b/tests/btrfs/246
@@ -18,7 +18,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 # If it's subpage case, we don't support inline extents creation for now.
diff --git a/tests/btrfs/247 b/tests/btrfs/247
index 341496e43..402f04006 100755
--- a/tests/btrfs/247
+++ b/tests/btrfs/247
@@ -14,7 +14,6 @@ _begin_fstest auto quick rename subvol
 
  . ./common/renameat2
 
-_supported_fs btrfs
 _require_renameat2 exchange
 _require_scratch
 
diff --git a/tests/btrfs/248 b/tests/btrfs/248
index 8e6d9211c..134de9ed8 100755
--- a/tests/btrfs/248
+++ b/tests/btrfs/248
@@ -14,7 +14,6 @@
 . ./common/preamble
 _begin_fstest auto quick seed volume
 
-_supported_fs btrfs
 _require_test
 _require_scratch_dev_pool 2
 _require_btrfs_forget_or_module_loadable
diff --git a/tests/btrfs/249 b/tests/btrfs/249
index c7f93ed46..641a3c87e 100755
--- a/tests/btrfs/249
+++ b/tests/btrfs/249
@@ -16,7 +16,6 @@
 . ./common/preamble
 _begin_fstest auto quick seed volume
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_command "$WIPEFS_PROG" wipefs
 _require_btrfs_forget_or_module_loadable
diff --git a/tests/btrfs/250 b/tests/btrfs/250
index 495a32323..c2205c08c 100755
--- a/tests/btrfs/250
+++ b/tests/btrfs/250
@@ -22,7 +22,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_chattr C
 _require_odirect
diff --git a/tests/btrfs/251 b/tests/btrfs/251
index 944f0a192..2c4a823df 100755
--- a/tests/btrfs/251
+++ b/tests/btrfs/251
@@ -12,7 +12,6 @@ _begin_fstest auto quick compress dangerous
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 pagesize=$(_get_page_size)
diff --git a/tests/btrfs/252 b/tests/btrfs/252
index defca229e..2da02ffa1 100755
--- a/tests/btrfs/252
+++ b/tests/btrfs/252
@@ -35,7 +35,6 @@ _cleanup()
 . ./common/filter
 
 
-_supported_fs btrfs
 # The size needed is variable as it depends on the specific randomized
 # operations from fsstress and on the value of $LOAD_FACTOR. But require
 # at least $LOAD_FACTOR * 6G, as we do the receive operations to the same
diff --git a/tests/btrfs/253 b/tests/btrfs/253
index 5fbce070f..adbc6bfbe 100755
--- a/tests/btrfs/253
+++ b/tests/btrfs/253
@@ -78,7 +78,6 @@ alloc_size() {
 }
 
 . ./common/filter
-_supported_fs btrfs
 _require_test
 _require_scratch
 # The chunk size on zoned mode is fixed to the zone size
diff --git a/tests/btrfs/254 b/tests/btrfs/254
index c789d8744..d9c9eea9c 100755
--- a/tests/btrfs/254
+++ b/tests/btrfs/254
@@ -28,7 +28,6 @@ _cleanup()
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_block_device $SCRATCH_DEV
 _require_dm_target linear
diff --git a/tests/btrfs/255 b/tests/btrfs/255
index ee52873fe..14c12904a 100755
--- a/tests/btrfs/255
+++ b/tests/btrfs/255
@@ -12,7 +12,6 @@
 . ./common/preamble
 _begin_fstest auto qgroup balance
 
-_supported_fs btrfs
 _require_scratch
 
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/btrfs/256 b/tests/btrfs/256
index 211a09623..78105476c 100755
--- a/tests/btrfs/256
+++ b/tests/btrfs/256
@@ -22,7 +22,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/257 b/tests/btrfs/257
index 7b4c043f1..ad6f3572c 100755
--- a/tests/btrfs/257
+++ b/tests/btrfs/257
@@ -20,7 +20,6 @@ _begin_fstest auto quick defrag prealloc fiemap
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 
 # We rely on specific extent layout, don't run on compress
diff --git a/tests/btrfs/258 b/tests/btrfs/258
index 7373a5611..5498d6acb 100755
--- a/tests/btrfs/258
+++ b/tests/btrfs/258
@@ -12,7 +12,6 @@ _begin_fstest auto defrag quick fiemap remount
 
 . ./common/filter
 
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "fiemap"
 
diff --git a/tests/btrfs/259 b/tests/btrfs/259
index 5b0bf7e0b..41c16e7a3 100755
--- a/tests/btrfs/259
+++ b/tests/btrfs/259
@@ -12,7 +12,6 @@ _begin_fstest auto quick defrag fiemap compress
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fiemap"
 
diff --git a/tests/btrfs/260 b/tests/btrfs/260
index b16e8378e..ce949b115 100755
--- a/tests/btrfs/260
+++ b/tests/btrfs/260
@@ -19,7 +19,6 @@ _begin_fstest auto quick defrag compress prealloc fiemap
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fiemap" "ranged"
 _require_xfs_io_command "falloc"
diff --git a/tests/btrfs/261 b/tests/btrfs/261
index 58fa8e758..4052baaec 100755
--- a/tests/btrfs/261
+++ b/tests/btrfs/261
@@ -10,7 +10,6 @@
 . ./common/preamble
 _begin_fstest auto volume raid scrub
 
-_supported_fs btrfs
 _require_scratch_dev_pool 4
 _btrfs_get_profile_configs replace-missing
 _require_fssum
diff --git a/tests/btrfs/262 b/tests/btrfs/262
index f50e5d237..b5f199af6 100755
--- a/tests/btrfs/262
+++ b/tests/btrfs/262
@@ -13,7 +13,6 @@ _begin_fstest auto quick qgroup
 
 . ./common/filter
 
-_supported_fs btrfs
 
 _require_scratch
 
diff --git a/tests/btrfs/263 b/tests/btrfs/263
index 919724f5e..9d18b0054 100755
--- a/tests/btrfs/263
+++ b/tests/btrfs/263
@@ -12,7 +12,6 @@ _begin_fstest auto quick defrag fiemap remount
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fiemap" "ranged"
 
diff --git a/tests/btrfs/264 b/tests/btrfs/264
index da1057bb0..e87a063d4 100755
--- a/tests/btrfs/264
+++ b/tests/btrfs/264
@@ -21,7 +21,6 @@ _begin_fstest auto quick compress attr
 . ./common/filter
 . ./common/attr
 
-_supported_fs btrfs
 _require_scratch
 _require_attrs
 _require_chattr C
diff --git a/tests/btrfs/265 b/tests/btrfs/265
index 0e72f8f2a..0fa55a7ff 100755
--- a/tests/btrfs/265
+++ b/tests/btrfs/265
@@ -13,7 +13,6 @@ _begin_fstest auto quick read_repair
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
diff --git a/tests/btrfs/266 b/tests/btrfs/266
index 7a10b92fb..0788ba946 100755
--- a/tests/btrfs/266
+++ b/tests/btrfs/266
@@ -14,7 +14,6 @@ _begin_fstest auto quick read_repair
 
 . ./common/filter
 
-_supported_fs btrfs
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
 _require_scratch_dev_pool 3
diff --git a/tests/btrfs/267 b/tests/btrfs/267
index e15a4623b..151ccdae1 100755
--- a/tests/btrfs/267
+++ b/tests/btrfs/267
@@ -14,7 +14,6 @@ _begin_fstest auto quick read_repair
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
diff --git a/tests/btrfs/268 b/tests/btrfs/268
index d122ee360..dce5cb953 100755
--- a/tests/btrfs/268
+++ b/tests/btrfs/268
@@ -13,7 +13,6 @@ _begin_fstest auto quick read_repair
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_odirect
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
diff --git a/tests/btrfs/269 b/tests/btrfs/269
index 7ffad1250..129a4a41a 100755
--- a/tests/btrfs/269
+++ b/tests/btrfs/269
@@ -17,7 +17,6 @@ _begin_fstest auto quick read_repair
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_odirect
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
diff --git a/tests/btrfs/270 b/tests/btrfs/270
index 221ef7d25..c8651fa17 100755
--- a/tests/btrfs/270
+++ b/tests/btrfs/270
@@ -11,7 +11,6 @@ _begin_fstest auto quick read_repair compress
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-tree
 _require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
diff --git a/tests/btrfs/271 b/tests/btrfs/271
index a342af3ae..2fc38e9cb 100755
--- a/tests/btrfs/271
+++ b/tests/btrfs/271
@@ -12,7 +12,6 @@ _begin_fstest auto quick raid
 . ./common/filter
 . ./common/fail_make_request
 
-_supported_fs btrfs
 _require_scratch
 _require_fail_make_request
 _require_scratch_dev_pool 2
diff --git a/tests/btrfs/272 b/tests/btrfs/272
index 4f799367c..e0f613798 100755
--- a/tests/btrfs/272
+++ b/tests/btrfs/272
@@ -15,7 +15,6 @@
 . ./common/preamble
 _begin_fstest auto quick send
 
-_supported_fs btrfs
 _fixed_by_kernel_commit 3aa5bd367fa5a3 \
 	"btrfs: send: fix sending link commands for existing file paths"
 _require_test
diff --git a/tests/btrfs/273 b/tests/btrfs/273
index d3ac5adb5..06ae5d53b 100755
--- a/tests/btrfs/273
+++ b/tests/btrfs/273
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/zoned
 
-_supported_fs btrfs
 _fixed_by_kernel_commit 2ce543f47843 \
 	"btrfs: zoned: wait until zone is finished when allocation didn't progress"
 # which is further fixed by
diff --git a/tests/btrfs/274 b/tests/btrfs/274
index ec7d66269..9a7abc746 100755
--- a/tests/btrfs/274
+++ b/tests/btrfs/274
@@ -18,7 +18,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs btrfs
 _fixed_by_kernel_commit 60021bd754c6ca \
     "btrfs: prevent subvol with swapfile from being deleted"
 _require_scratch_swapfile
diff --git a/tests/btrfs/275 b/tests/btrfs/275
index 955a0c985..9966340b3 100755
--- a/tests/btrfs/275
+++ b/tests/btrfs/275
@@ -12,7 +12,6 @@ _begin_fstest auto quick attr
 . ./common/filter
 . ./common/attr
 
-_supported_fs btrfs
 _fixed_by_kernel_commit b51111271b03 \
 	"btrfs: check if root is readonly while setting security xattr"
 _require_attrs
diff --git a/tests/btrfs/276 b/tests/btrfs/276
index 70dadd93f..1c81f47e2 100755
--- a/tests/btrfs/276
+++ b/tests/btrfs/276
@@ -15,7 +15,6 @@ _begin_fstest auto snapshot fiemap remount
 . ./common/filter.btrfs
 . ./common/attr
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fiemap" "ranged"
 _require_attrs
diff --git a/tests/btrfs/277 b/tests/btrfs/277
index 9770e1c1c..4c87be1e8 100755
--- a/tests/btrfs/277
+++ b/tests/btrfs/277
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/verity
 
-_supported_fs btrfs
 _require_scratch_verity
 _require_fsverity_builtin_signatures
 _require_command "$SETCAP_PROG" setcap
diff --git a/tests/btrfs/278 b/tests/btrfs/278
index a8b110bc5..44b194394 100755
--- a/tests/btrfs/278
+++ b/tests/btrfs/278
@@ -15,7 +15,6 @@
 . ./common/preamble
 _begin_fstest auto quick send
 
-_supported_fs btrfs
 _fixed_by_kernel_commit 9ed0a72e5b355d \
 	"btrfs: send: fix failures when processing inodes with no links"
 _require_test
diff --git a/tests/btrfs/279 b/tests/btrfs/279
index 5b5824fd0..97e29eba0 100755
--- a/tests/btrfs/279
+++ b/tests/btrfs/279
@@ -18,7 +18,6 @@ _begin_fstest auto quick subvol fiemap clone
 . ./common/reflink
 . ./common/punch # for _filter_fiemap_flags
 
-_supported_fs btrfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/btrfs/280 b/tests/btrfs/280
index 0f7f8a374..f4d6f47e6 100755
--- a/tests/btrfs/280
+++ b/tests/btrfs/280
@@ -18,7 +18,6 @@ _begin_fstest auto quick compress snapshot fiemap defrag
 . ./common/filter
 . ./common/punch # for _filter_fiemap_flags
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fiemap"
 
diff --git a/tests/btrfs/281 b/tests/btrfs/281
index 290ccaca6..855dd8249 100755
--- a/tests/btrfs/281
+++ b/tests/btrfs/281
@@ -19,7 +19,6 @@ _begin_fstest auto quick send compress clone fiemap
 . ./common/reflink
 . ./common/punch # for _filter_fiemap_flags
 
-_supported_fs btrfs
 _require_test
 _require_scratch_reflink
 _require_btrfs_send_version 2
diff --git a/tests/btrfs/282 b/tests/btrfs/282
index 2c6fc5fc7..3b4ad9ea0 100755
--- a/tests/btrfs/282
+++ b/tests/btrfs/282
@@ -11,7 +11,6 @@ _begin_fstest auto scrub
 
 . ./common/filter
 
-_supported_fs btrfs
 _wants_kernel_commit eb3b50536642 \
 	"btrfs: scrub: per-device bandwidth control"
 
diff --git a/tests/btrfs/283 b/tests/btrfs/283
index 8fa282ee4..f7a8290af 100755
--- a/tests/btrfs/283
+++ b/tests/btrfs/283
@@ -15,7 +15,6 @@ _begin_fstest auto quick send clone fiemap
 . ./common/reflink
 . ./common/punch # for _filter_fiemap_flags
 
-_supported_fs btrfs
 _require_test
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/btrfs/284 b/tests/btrfs/284
index 8c0f67951..19ffbbe6f 100755
--- a/tests/btrfs/284
+++ b/tests/btrfs/284
@@ -10,7 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick send compress snapshot
 
-_supported_fs btrfs
 _require_btrfs_send_version 2
 _require_test
 # The size needed is variable as it depends on the specific randomized
diff --git a/tests/btrfs/285 b/tests/btrfs/285
index 56cdad513..5ceb69d4f 100755
--- a/tests/btrfs/285
+++ b/tests/btrfs/285
@@ -14,7 +14,6 @@ sysfs_size_classes() {
 	cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"
 }
 
-_supported_fs btrfs
 _require_scratch
 _require_btrfs_fs_sysfs
 _require_fs_sysfs allocation/data/size_classes
diff --git a/tests/btrfs/286 b/tests/btrfs/286
index 3429a6116..b8fa27673 100755
--- a/tests/btrfs/286
+++ b/tests/btrfs/286
@@ -12,7 +12,6 @@ _begin_fstest auto replace
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_command "$WIPEFS_PROG" wipefs
 _btrfs_get_profile_configs replace-missing
 _require_fssum
diff --git a/tests/btrfs/287 b/tests/btrfs/287
index 24d8e66a7..d6c04ea8c 100755
--- a/tests/btrfs/287
+++ b/tests/btrfs/287
@@ -12,7 +12,6 @@ _begin_fstest auto quick snapshot clone punch logical_resolve
 . ./common/filter.btrfs
 . ./common/reflink
 
-_supported_fs btrfs
 _require_btrfs_scratch_logical_resolve_v2
 _require_scratch_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/btrfs/288 b/tests/btrfs/288
index 839ecc338..c0328a050 100755
--- a/tests/btrfs/288
+++ b/tests/btrfs/288
@@ -11,7 +11,6 @@ _begin_fstest auto repair quick volume scrub
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 2
 
 _require_odirect
diff --git a/tests/btrfs/289 b/tests/btrfs/289
index 148bf56a6..86e910216 100755
--- a/tests/btrfs/289
+++ b/tests/btrfs/289
@@ -11,7 +11,6 @@ _begin_fstest auto quick scrub repair
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/290 b/tests/btrfs/290
index 9ed54662f..1a5e267b4 100755
--- a/tests/btrfs/290
+++ b/tests/btrfs/290
@@ -22,7 +22,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-_supported_fs btrfs
 _require_scratch_verity
 _require_scratch_nocheck
 _require_odirect
diff --git a/tests/btrfs/291 b/tests/btrfs/291
index fc654565d..c31de3a96 100755
--- a/tests/btrfs/291
+++ b/tests/btrfs/291
@@ -31,7 +31,6 @@ _cleanup()
 . ./common/dmlogwrites
 . ./common/verity
 
-_supported_fs btrfs
 
 _require_scratch
 _require_test
diff --git a/tests/btrfs/292 b/tests/btrfs/292
index f920d9616..a09bc516f 100755
--- a/tests/btrfs/292
+++ b/tests/btrfs/292
@@ -13,7 +13,6 @@ _begin_fstest auto raid volume trim
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch_dev_pool 6
 _require_fstrim
 _fixed_by_kernel_commit a7299a18a179 \
diff --git a/tests/btrfs/293 b/tests/btrfs/293
index 09139f195..61db0beed 100755
--- a/tests/btrfs/293
+++ b/tests/btrfs/293
@@ -20,7 +20,6 @@ _cleanup()
 
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _fixed_by_kernel_commit deccae40e4b3 \
 	"btrfs: can_nocow_file_extent should pass down args->strict from callers"
 _require_scratch_swapfile
diff --git a/tests/btrfs/294 b/tests/btrfs/294
index 9d6f75664..6a3caa244 100755
--- a/tests/btrfs/294
+++ b/tests/btrfs/294
@@ -11,7 +11,6 @@ _begin_fstest auto raid volume
 
 . ./common/filter
 
-_supported_fs btrfs
 
 # No zoned support for RAID56 yet.
 _require_non_zoned_device "${SCRATCH_DEV}"
diff --git a/tests/btrfs/295 b/tests/btrfs/295
index 00a5c5680..1cd1ba91c 100755
--- a/tests/btrfs/295
+++ b/tests/btrfs/295
@@ -10,7 +10,6 @@
 _begin_fstest auto quick dangerous
 
 . ./common/filter
-_supported_fs btrfs
 _require_scratch
 # Directly writing to the device, which may not work with a zoned device
 _require_non_zoned_device "$SCRATCH_DEV"
diff --git a/tests/btrfs/296 b/tests/btrfs/296
index d44461985..f4f7cec65 100755
--- a/tests/btrfs/296
+++ b/tests/btrfs/296
@@ -10,7 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick balance
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 _fixed_by_kernel_commit b7625f461da6 \
 	"btrfs: sysfs: update fs features directory asynchronously"
diff --git a/tests/btrfs/297 b/tests/btrfs/297
index 7afe854dc..eb4f365e9 100755
--- a/tests/btrfs/297
+++ b/tests/btrfs/297
@@ -11,7 +11,6 @@ _begin_fstest auto quick raid scrub
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_odirect
 _require_non_zoned_device "${SCRATCH_DEV}"
 _require_scratch_dev_pool 3
diff --git a/tests/btrfs/298 b/tests/btrfs/298
index 0cea81d09..d4aee55e7 100755
--- a/tests/btrfs/298
+++ b/tests/btrfs/298
@@ -10,7 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick seed
 
-_supported_fs btrfs
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_command "$WIPEFS_PROG" wipefs
 _require_scratch_dev_pool 2
diff --git a/tests/btrfs/299 b/tests/btrfs/299
index fe80771a8..07f40f0b1 100755
--- a/tests/btrfs/299
+++ b/tests/btrfs/299
@@ -17,7 +17,6 @@
 . ./common/preamble
 _begin_fstest auto quick preallocrw logical_resolve
 
-_supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
 _require_btrfs_command inspect-internal logical-resolve
diff --git a/tests/btrfs/300 b/tests/btrfs/300
index 4ea22a01c..7fcb444a6 100755
--- a/tests/btrfs/300
+++ b/tests/btrfs/300
@@ -12,7 +12,6 @@
 _begin_fstest auto quick subvol snapshot
 _register_cleanup "cleanup"
 
-_supported_fs btrfs
 _fixed_by_kernel_commit 94628ad94408 \
 	"btrfs: copy dir permission and time when creating a stub subvolume"
 
diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 62854a500..6b59749d8 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -12,7 +12,6 @@ _begin_fstest auto quick qgroup clone subvol prealloc snapshot remount
 
 . ./common/reflink
 
-_supported_fs btrfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_btrfs_command inspect-internal dump-tree
diff --git a/tests/btrfs/302 b/tests/btrfs/302
index 3b52892d5..f41505ac0 100755
--- a/tests/btrfs/302
+++ b/tests/btrfs/302
@@ -17,7 +17,6 @@ _begin_fstest auto quick snapshot subvol
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_fssum
 
diff --git a/tests/btrfs/303 b/tests/btrfs/303
index ed3abcc15..501a0b49a 100755
--- a/tests/btrfs/303
+++ b/tests/btrfs/303
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/punch  # for _filter_fiemap
 
-_supported_fs btrfs
 _require_test
 _require_scratch
 _require_xfs_io_command "fiemap"
diff --git a/tests/btrfs/304 b/tests/btrfs/304
index 1ecc528d6..b7ed66af2 100755
--- a/tests/btrfs/304
+++ b/tests/btrfs/304
@@ -13,7 +13,6 @@ _begin_fstest auto quick raid remount volume raid-stripe-tree
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_mkfs_feature "raid-stripe-tree"
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/305 b/tests/btrfs/305
index 1c092482e..ad0608537 100755
--- a/tests/btrfs/305
+++ b/tests/btrfs/305
@@ -14,7 +14,6 @@ _begin_fstest auto quick raid remount volume raid-stripe-tree
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_mkfs_feature "raid-stripe-tree"
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/306 b/tests/btrfs/306
index 6e3843186..b47c446b8 100755
--- a/tests/btrfs/306
+++ b/tests/btrfs/306
@@ -14,7 +14,6 @@ _begin_fstest auto quick raid remount volume raid-stripe-tree
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_mkfs_feature "raid-stripe-tree"
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/307 b/tests/btrfs/307
index d9c39b928..02a9d4d3d 100755
--- a/tests/btrfs/307
+++ b/tests/btrfs/307
@@ -13,7 +13,6 @@ _begin_fstest auto quick raid remount volume raid-stripe-tree
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_mkfs_feature "raid-stripe-tree"
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/308 b/tests/btrfs/308
index ee9f15f00..3c8d410ae 100755
--- a/tests/btrfs/308
+++ b/tests/btrfs/308
@@ -14,7 +14,6 @@ _begin_fstest auto quick raid remount volume raid-stripe-tree
 . ./common/filter
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_mkfs_feature "raid-stripe-tree"
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/309 b/tests/btrfs/309
index d1eb953f6..e803a59d4 100755
--- a/tests/btrfs/309
+++ b/tests/btrfs/309
@@ -9,7 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick snapshot subvol
 
-_supported_fs btrfs
 _require_scratch
 _require_test_program t_snapshot_deleted_subvolume
 _fixed_by_kernel_commit 7081929ab257 \
diff --git a/tests/btrfs/310 b/tests/btrfs/310
index c83b6c296..2912b83c9 100755
--- a/tests/btrfs/310
+++ b/tests/btrfs/310
@@ -9,7 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick compress
 
-_supported_fs btrfs
 _require_scratch
 
 # This test require inlined compressed extents creation, and all the writes
diff --git a/tests/btrfs/311 b/tests/btrfs/311
index 989939652..51147c59f 100755
--- a/tests/btrfs/311
+++ b/tests/btrfs/311
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter.btrfs
 . ./common/reflink
 
-_supported_fs btrfs
 _require_cp_reflink
 _require_scratch
 _require_btrfs_fs_feature temp_fsid
diff --git a/tests/btrfs/313 b/tests/btrfs/313
index 5b8062f4f..5a9e98dea 100755
--- a/tests/btrfs/313
+++ b/tests/btrfs/313
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter.btrfs
 . ./common/reflink
 
-_supported_fs btrfs
 _require_cp_reflink
 _require_scratch_dev_pool 2
 _require_btrfs_fs_feature temp_fsid
diff --git a/tests/btrfs/314 b/tests/btrfs/314
index da594d396..76dccc41f 100755
--- a/tests/btrfs/314
+++ b/tests/btrfs/314
@@ -21,7 +21,6 @@ _cleanup()
 
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch_dev_pool 2
 _require_btrfs_fs_feature temp_fsid
 
diff --git a/tests/btrfs/315 b/tests/btrfs/315
index 7e5c74df4..5852afadd 100755
--- a/tests/btrfs/315
+++ b/tests/btrfs/315
@@ -20,7 +20,6 @@ _cleanup()
 
 . ./common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_btrfs_fs_feature temp_fsid
 
diff --git a/tests/btrfs/316 b/tests/btrfs/316
index 63e9a7d98..80eaaccaf 100755
--- a/tests/btrfs/316
+++ b/tests/btrfs/316
@@ -14,7 +14,6 @@
 . ./common/preamble
 _begin_fstest auto quick qgroup
 
-_supported_fs btrfs
 _require_scratch
 _require_qgroup_rescan
 
diff --git a/tests/btrfs/317 b/tests/btrfs/317
index b17ba584b..f55e444b7 100755
--- a/tests/btrfs/317
+++ b/tests/btrfs/317
@@ -15,7 +15,6 @@ _fixed_by_kernel_commit 5906333cc4af \
 
 . common/filter.btrfs
 
-_supported_fs btrfs
 _require_scratch_dev_pool 4
 _require_zoned_device "$SCRATCH_DEV"
 
diff --git a/tests/btrfs/318 b/tests/btrfs/318
index 1eb726256..799772767 100755
--- a/tests/btrfs/318
+++ b/tests/btrfs/318
@@ -15,8 +15,6 @@ _begin_fstest auto quick volume scrub tempfsid
 _fixed_by_kernel_commit 9f7eb8405dcb \
 	"btrfs: validate device maj:min during open"
 
-# real QA test starts here
-_supported_fs btrfs
 _require_test
 _require_command "$PARTED_PROG" parted
 _require_batched_discard "$TEST_DIR"
diff --git a/tests/btrfs/320 b/tests/btrfs/320
index afed43b50..15549165e 100755
--- a/tests/btrfs/320
+++ b/tests/btrfs/320
@@ -12,7 +12,6 @@ _begin_fstest auto qgroup limit
 
 . ./common/filter
 
-_supported_fs btrfs
 _require_scratch
 _require_qgroup_rescan
 _require_btrfs_qgroup_report
diff --git a/tests/btrfs/330 b/tests/btrfs/330
index 095f6b36a..3545a116e 100755
--- a/tests/btrfs/330
+++ b/tests/btrfs/330
@@ -17,8 +17,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter.btrfs
 
-# real QA test starts here
-_supported_fs btrfs
 _require_scratch
 
 $MOUNT_PROG -V | grep -q 'fd-based-mount'
diff --git a/tests/ceph/001 b/tests/ceph/001
index 79a5f58ac..0d470624a 100755
--- a/tests/ceph/001
+++ b/tests/ceph/001
@@ -18,8 +18,6 @@ _begin_fstest auto quick copy_range
 . common/attr
 . common/reflink
 
-# real QA test starts here
-_supported_fs ceph
 _require_debugfs
 _require_xfs_io_command "copy_range"
 _exclude_test_mount_option "test_dummy_encryption"
diff --git a/tests/ceph/002 b/tests/ceph/002
index 02f668426..20f2e887a 100755
--- a/tests/ceph/002
+++ b/tests/ceph/002
@@ -26,8 +26,6 @@ _begin_fstest auto quick copy_range
 . common/filter
 . common/attr
 
-# real QA test starts here
-_supported_fs ceph
 
 _require_xfs_io_command "copy_range"
 _exclude_test_mount_option "test_dummy_encryption"
diff --git a/tests/ceph/003 b/tests/ceph/003
index 2d6cb393b..4f11fb841 100755
--- a/tests/ceph/003
+++ b/tests/ceph/003
@@ -14,8 +14,6 @@ _begin_fstest auto quick copy_range
 . common/attr
 . common/reflink
 
-# real QA test starts here
-_supported_fs ceph
 
 _require_xfs_io_command "copy_range"
 _exclude_test_mount_option "test_dummy_encryption"
diff --git a/tests/ceph/004 b/tests/ceph/004
index 124ed1bca..5653586a0 100755
--- a/tests/ceph/004
+++ b/tests/ceph/004
@@ -34,9 +34,7 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
-_supported_fs ceph
 _require_attrs
 _require_test
 _require_test_program "rename"
diff --git a/tests/ceph/005 b/tests/ceph/005
index 015f6571b..4db2df01c 100755
--- a/tests/ceph/005
+++ b/tests/ceph/005
@@ -11,7 +11,6 @@
 . ./common/preamble
 _begin_fstest auto quick quota
 
-_supported_fs ceph
 _require_scratch
 _exclude_test_mount_option "test_dummy_encryption"
 
diff --git a/tests/cifs/001 b/tests/cifs/001
index e20108cb4..547315a3b 100755
--- a/tests/cifs/001
+++ b/tests/cifs/001
@@ -19,8 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs cifs
 _require_cloner
 _require_test
 
diff --git a/tests/ext4/001 b/tests/ext4/001
index f86503652..4575cf697 100755
--- a/tests/ext4/001
+++ b/tests/ext4/001
@@ -14,7 +14,6 @@ _begin_fstest auto prealloc quick zero fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
 _supported_fs ext4
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fzero"
diff --git a/tests/ext4/002 b/tests/ext4/002
index f09e9c1ae..9c6eb5a04 100755
--- a/tests/ext4/002
+++ b/tests/ext4/002
@@ -29,7 +29,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4 ext3
 
 _require_scratch_nocheck
diff --git a/tests/ext4/003 b/tests/ext4/003
index a70ad97a9..e2b588d88 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -20,7 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/004 b/tests/ext4/004
index 0c2ad8979..20cfdb444 100755
--- a/tests/ext4/004
+++ b/tests/ext4/004
@@ -43,7 +43,6 @@ workout()
 	rm -rf restoresymtable
 }
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_test
diff --git a/tests/ext4/005 b/tests/ext4/005
index 794caa170..a271fbbf6 100755
--- a/tests/ext4/005
+++ b/tests/ext4/005
@@ -17,7 +17,6 @@ _begin_fstest auto quick metadata ioctl rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_command "$CHATTR_PROG" chattr
diff --git a/tests/ext4/006 b/tests/ext4/006
index b73692aa5..d78620731 100755
--- a/tests/ext4/006
+++ b/tests/ext4/006
@@ -28,7 +28,6 @@ if [ ! -x "$(type -P e2fuzz)" ]; then
 	_notrun "Couldn't find e2fuzz"
 fi
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/007 b/tests/ext4/007
index 2e8b4d19f..deedbd9e8 100755
--- a/tests/ext4/007
+++ b/tests/ext4/007
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/008 b/tests/ext4/008
index 9509ed920..b4b20ac10 100755
--- a/tests/ext4/008
+++ b/tests/ext4/008
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/009 b/tests/ext4/009
index 4258c486c..06a42fd77 100755
--- a/tests/ext4/009
+++ b/tests/ext4/009
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_xfs_io_command "falloc"
diff --git a/tests/ext4/010 b/tests/ext4/010
index e2cc5489f..1139c79e8 100755
--- a/tests/ext4/010
+++ b/tests/ext4/010
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/011 b/tests/ext4/011
index 15703f61a..cae4fb6b8 100755
--- a/tests/ext4/011
+++ b/tests/ext4/011
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/012 b/tests/ext4/012
index 358874a1c..f7f2b0fb4 100755
--- a/tests/ext4/012
+++ b/tests/ext4/012
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/013 b/tests/ext4/013
index 1d33e5645..7d2a9154a 100755
--- a/tests/ext4/013
+++ b/tests/ext4/013
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/014 b/tests/ext4/014
index ad87c7816..ffed795ad 100755
--- a/tests/ext4/014
+++ b/tests/ext4/014
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/015 b/tests/ext4/015
index 3c07b5e5c..81feda5c9 100755
--- a/tests/ext4/015
+++ b/tests/ext4/015
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_xfs_io_command "falloc"
diff --git a/tests/ext4/016 b/tests/ext4/016
index cee7eadf0..b7db4cfda 100755
--- a/tests/ext4/016
+++ b/tests/ext4/016
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/017 b/tests/ext4/017
index b07964ecf..fc867442c 100755
--- a/tests/ext4/017
+++ b/tests/ext4/017
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/018 b/tests/ext4/018
index 92df4cf52..f7377f059 100755
--- a/tests/ext4/018
+++ b/tests/ext4/018
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/019 b/tests/ext4/019
index f05140939..987972a80 100755
--- a/tests/ext4/019
+++ b/tests/ext4/019
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/020 b/tests/ext4/020
index 110a0fd03..a2fb60fa8 100755
--- a/tests/ext4/020
+++ b/tests/ext4/020
@@ -17,7 +17,6 @@ _begin_fstest auto quick ioctl rw defrag
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_defrag
diff --git a/tests/ext4/021 b/tests/ext4/021
index 62768c60b..d69dc584d 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -12,7 +12,6 @@ _begin_fstest auto quick
 
 # Import common functions.
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_dumpe2fs
diff --git a/tests/ext4/022 b/tests/ext4/022
index 96929cb8a..6b74ff892 100755
--- a/tests/ext4/022
+++ b/tests/ext4/022
@@ -18,7 +18,6 @@ do_setfattr()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_dumpe2fs
diff --git a/tests/ext4/023 b/tests/ext4/023
index ebc5ffe34..b5217da33 100755
--- a/tests/ext4/023
+++ b/tests/ext4/023
@@ -18,7 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 
diff --git a/tests/ext4/024 b/tests/ext4/024
index 11b335f0b..e58cb9918 100755
--- a/tests/ext4/024
+++ b/tests/ext4/024
@@ -13,7 +13,6 @@ _begin_fstest auto quick encrypt dangerous
 # get standard environment and checks
 . ./common/encrypt
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch_encryption
 _require_command "$KEYCTL_PROG" keyctl
diff --git a/tests/ext4/025 b/tests/ext4/025
index 4299e4b2d..ce3a3d219 100755
--- a/tests/ext4/025
+++ b/tests/ext4/025
@@ -13,7 +13,6 @@ _begin_fstest auto quick fuzzers dangerous
 # get standard environment and checks
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch_nocheck
 _require_command "$DEBUGFS_PROG" debugfs
diff --git a/tests/ext4/026 b/tests/ext4/026
index 782fdca65..5bb2add23 100755
--- a/tests/ext4/026
+++ b/tests/ext4/026
@@ -16,7 +16,6 @@ _begin_fstest auto quick attr
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_attrs
diff --git a/tests/ext4/027 b/tests/ext4/027
index 5bcb2d55f..93de00f29 100755
--- a/tests/ext4/027
+++ b/tests/ext4/027
@@ -19,7 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_xfs_io_command "fsmap"
diff --git a/tests/ext4/028 b/tests/ext4/028
index 3e18baf94..30f3c4480 100755
--- a/tests/ext4/028
+++ b/tests/ext4/028
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/populate
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_populate_commands
diff --git a/tests/ext4/029 b/tests/ext4/029
index 9d6c45040..8a6969d2a 100755
--- a/tests/ext4/029
+++ b/tests/ext4/029
@@ -19,7 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_logdev
 _require_scratch
diff --git a/tests/ext4/030 b/tests/ext4/030
index 4b51edd27..80f34ccf3 100755
--- a/tests/ext4/030
+++ b/tests/ext4/030
@@ -20,7 +20,6 @@ _require_scratch_dax_mountopt "dax"
 _require_test_program "t_ext4_dax_journal_corruption"
 _require_command "$CHATTR_PROG" chattr
 
-# real QA test starts here
 _scratch_mkfs > $seqres.full 2>&1
 
 # In order to get our failure condition consistently we need to turn off
diff --git a/tests/ext4/031 b/tests/ext4/031
index ac16786ff..b583f8251 100755
--- a/tests/ext4/031
+++ b/tests/ext4/031
@@ -24,7 +24,6 @@ _require_scratch_dax_mountopt "dax"
 _require_test_program "t_ext4_dax_inline_corruption"
 _require_scratch_ext4_feature "inline_data"
 
-# real QA test starts here
 _scratch_mkfs_ext4 -O inline_data > $seqres.full 2>&1
 
 TESTFILE=$SCRATCH_MNT/testfile
diff --git a/tests/ext4/032 b/tests/ext4/032
index 3d91db22c..6bc3b61b3 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -80,7 +80,6 @@ _cleanup()
 
 # get standard environment and checks
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_loop
diff --git a/tests/ext4/033 b/tests/ext4/033
index 22041a171..53f7106e2 100755
--- a/tests/ext4/033
+++ b/tests/ext4/033
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmhugedisk
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch_nocheck
 _require_dmhugedisk
diff --git a/tests/ext4/034 b/tests/ext4/034
index b656e54d8..cdd2e553f 100755
--- a/tests/ext4/034
+++ b/tests/ext4/034
@@ -17,7 +17,6 @@ _begin_fstest auto quick quota fiemap prealloc
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 
 # Modify as appropriate.
 _supported_fs ext4
diff --git a/tests/ext4/035 b/tests/ext4/035
index a8278b0ee..cf221c5ad 100755
--- a/tests/ext4/035
+++ b/tests/ext4/035
@@ -19,7 +19,6 @@ _begin_fstest auto quick resize
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _exclude_scratch_mount_option dax
diff --git a/tests/ext4/036 b/tests/ext4/036
index 60ab0b902..045fe82ff 100755
--- a/tests/ext4/036
+++ b/tests/ext4/036
@@ -15,7 +15,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext3 ext4
 _require_scratch
 
diff --git a/tests/ext4/037 b/tests/ext4/037
index 5ecb9f83b..ac309d67a 100755
--- a/tests/ext4/037
+++ b/tests/ext4/037
@@ -15,7 +15,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext3 ext4
 
 # nofsck as we modify sb via debugfs
diff --git a/tests/ext4/038 b/tests/ext4/038
index 596de65bf..b594bd9cb 100755
--- a/tests/ext4/038
+++ b/tests/ext4/038
@@ -12,7 +12,6 @@ _begin_fstest auto quick
 
 # Import common functions.
 
-# real QA test starts here
 _supported_fs ext3 ext4
 _require_scratch
 _require_command "$DEBUGFS_PROG" debugfs
diff --git a/tests/ext4/039 b/tests/ext4/039
index 4ca4058a7..2830740eb 100755
--- a/tests/ext4/039
+++ b/tests/ext4/039
@@ -56,7 +56,6 @@ chattr_opt: $chattr_opt" >>$seqres.full
 	done
 }
 
-# real QA test starts here
 _supported_fs ext3 ext4
 _require_scratch
 _exclude_scratch_mount_option dax
diff --git a/tests/ext4/040 b/tests/ext4/040
index a20d58971..5760058ad 100755
--- a/tests/ext4/040
+++ b/tests/ext4/040
@@ -21,7 +21,6 @@ PIDS=""
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext2 ext3 ext4
 _require_scratch_nocheck
 _disable_dmesg_check
diff --git a/tests/ext4/041 b/tests/ext4/041
index 941cd26bd..76513db3f 100755
--- a/tests/ext4/041
+++ b/tests/ext4/041
@@ -21,7 +21,6 @@ PIDS=""
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext2 ext3 ext4
 _require_scratch_nocheck
 _disable_dmesg_check
diff --git a/tests/ext4/042 b/tests/ext4/042
index 9e5ef22d7..0d97f6de4 100755
--- a/tests/ext4/042
+++ b/tests/ext4/042
@@ -12,7 +12,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
 _supported_fs ext2 ext3 ext4
diff --git a/tests/ext4/043 b/tests/ext4/043
index de0ddf7fa..0bbbb42ac 100755
--- a/tests/ext4/043
+++ b/tests/ext4/043
@@ -12,7 +12,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext3 ext4
 
 _require_scratch
diff --git a/tests/ext4/044 b/tests/ext4/044
index 96fa70cc0..53006514d 100755
--- a/tests/ext4/044
+++ b/tests/ext4/044
@@ -12,7 +12,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_test_program "t_get_file_time"
diff --git a/tests/ext4/045 b/tests/ext4/045
index a90ae1ba3..587bedece 100755
--- a/tests/ext4/045
+++ b/tests/ext4/045
@@ -16,7 +16,6 @@ LONG_DIR=2
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/047 b/tests/ext4/047
index 7e0c84384..f67b615ab 100755
--- a/tests/ext4/047
+++ b/tests/ext4/047
@@ -13,7 +13,6 @@ _begin_fstest auto quick dax
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch_dax_mountopt "dax=always"
 _require_dax_iflag
diff --git a/tests/ext4/048 b/tests/ext4/048
index c23c0ea36..99a2c7b8f 100755
--- a/tests/ext4/048
+++ b/tests/ext4/048
@@ -13,7 +13,6 @@ _begin_fstest auto quick dir
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/049 b/tests/ext4/049
index f6ec1d6df..5b24e632a 100755
--- a/tests/ext4/049
+++ b/tests/ext4/049
@@ -13,7 +13,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 
diff --git a/tests/ext4/050 b/tests/ext4/050
index 6f93b86d3..6ba0038e7 100755
--- a/tests/ext4/050
+++ b/tests/ext4/050
@@ -13,7 +13,6 @@ _begin_fstest auto ioctl quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/051 b/tests/ext4/051
index e4b63a326..a1e35fa32 100755
--- a/tests/ext4/051
+++ b/tests/ext4/051
@@ -12,7 +12,6 @@
 . ./common/preamble
 _begin_fstest auto rw quick
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/ext4/052 b/tests/ext4/052
index dc40e6701..edcdc0251 100755
--- a/tests/ext4/052
+++ b/tests/ext4/052
@@ -27,7 +27,6 @@ _cleanup()
 # Import common functions.
 # . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
 _supported_fs ext4
diff --git a/tests/ext4/054 b/tests/ext4/054
index 215f564a4..0dbe83640 100755
--- a/tests/ext4/054
+++ b/tests/ext4/054
@@ -17,7 +17,6 @@ _begin_fstest auto quick dangerous_fuzzers prealloc punch
 # Import common functions
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch_nocheck
 _require_xfs_io_command "falloc"
diff --git a/tests/ext4/055 b/tests/ext4/055
index aa15cfe98..e1815c237 100755
--- a/tests/ext4/055
+++ b/tests/ext4/055
@@ -16,7 +16,6 @@
 . ./common/preamble
 _begin_fstest auto quota
 
-# real QA test starts here
 _require_scratch_nocheck
 _supported_fs ext4
 _require_user fsgqa
diff --git a/tests/ext4/056 b/tests/ext4/056
index 9e3f97c33..8a290b11d 100755
--- a/tests/ext4/056
+++ b/tests/ext4/056
@@ -19,7 +19,6 @@
 . ./common/preamble
 _begin_fstest auto ioctl resize quick
 
-# real QA test starts here
 
 INITIAL_FS_SIZE=1G
 RESIZED_FS_SIZE=$((2*1024*1024*1024))  # 2G
diff --git a/tests/ext4/057 b/tests/ext4/057
index 6babedb27..529f0c298 100755
--- a/tests/ext4/057
+++ b/tests/ext4/057
@@ -20,7 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_test_program uuid_ioctl
diff --git a/tests/ext4/058 b/tests/ext4/058
index 4704daa78..a7fc5e6c6 100755
--- a/tests/ext4/058
+++ b/tests/ext4/058
@@ -13,7 +13,6 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-# real QA test starts here
 
 _supported_fs ext4
 _fixed_by_kernel_commit a08f789d2ab5 \
diff --git a/tests/ext4/059 b/tests/ext4/059
index 66bac6085..50e788f0a 100755
--- a/tests/ext4/059
+++ b/tests/ext4/059
@@ -11,7 +11,6 @@
 . ./common/preamble
 _begin_fstest auto resize quick
 
-# real QA test starts here
 _supported_fs ext4
 _fixed_by_kernel_commit b55c3cd102a6 \
 	"ext4: add reserved GDT blocks check"
diff --git a/tests/ext4/271 b/tests/ext4/271
index 8d9bd7dc9..6d60f40d3 100755
--- a/tests/ext4/271
+++ b/tests/ext4/271
@@ -12,7 +12,6 @@ _begin_fstest auto rw quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 # this test needs no journal to be loaded, skip on journal related mount
diff --git a/tests/ext4/301 b/tests/ext4/301
index 7c3dc720c..dd0c7d483 100755
--- a/tests/ext4/301
+++ b/tests/ext4/301
@@ -15,7 +15,6 @@ fio_config=$tmp.fio
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_defrag
diff --git a/tests/ext4/302 b/tests/ext4/302
index e2f4b4e45..d73cf9bf8 100755
--- a/tests/ext4/302
+++ b/tests/ext4/302
@@ -16,7 +16,6 @@ fio_config=$tmp.fio
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_defrag
diff --git a/tests/ext4/303 b/tests/ext4/303
index db25ea1ff..d9be45674 100755
--- a/tests/ext4/303
+++ b/tests/ext4/303
@@ -16,7 +16,6 @@ fio_config=$tmp.fio
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_defrag
diff --git a/tests/ext4/304 b/tests/ext4/304
index ce5c53aa2..208b8a2ac 100755
--- a/tests/ext4/304
+++ b/tests/ext4/304
@@ -17,7 +17,6 @@ fio_config=$tmp.fio
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
 _supported_fs ext4
 _require_scratch
 _require_defrag
diff --git a/tests/ext4/305 b/tests/ext4/305
index 2c89a5830..acada44bc 100755
--- a/tests/ext4/305
+++ b/tests/ext4/305
@@ -22,7 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/306 b/tests/ext4/306
index 715732a76..b5147caf5 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -22,7 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ext4
 
 _require_scratch
diff --git a/tests/ext4/307 b/tests/ext4/307
index 8b1cfc9e4..f7c95c51b 100755
--- a/tests/ext4/307
+++ b/tests/ext4/307
@@ -34,8 +34,6 @@ _workout()
 	run_check md5sum -c $out.md5sum
 }
 
-# real QA test starts here
-_supported_fs generic
 _supported_fs ext4
 _require_scratch
 _require_defrag
diff --git a/tests/ext4/308 b/tests/ext4/308
index 849ebdf89..9712c6f4e 100755
--- a/tests/ext4/308
+++ b/tests/ext4/308
@@ -17,7 +17,6 @@ PIDS=""
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
 _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
diff --git a/tests/f2fs/001 b/tests/f2fs/001
index 2bf39d8c6..caf2bf7f5 100755
--- a/tests/f2fs/001
+++ b/tests/f2fs/001
@@ -21,7 +21,6 @@ _begin_fstest auto quick rw prealloc
 # Import common functions.
 . ./common/filter
 
-_supported_fs f2fs
 _require_scratch
 _require_xfs_io_command "falloc"
 
diff --git a/tests/f2fs/002 b/tests/f2fs/002
index c0bf440b4..741462178 100755
--- a/tests/f2fs/002
+++ b/tests/f2fs/002
@@ -46,8 +46,6 @@ _begin_fstest auto quick rw encrypt compress fiemap
 . ./common/f2fs
 . ./common/encrypt
 
-_supported_fs f2fs
-
 # Prerequisites to create a file that is both encrypted and LZ4-compressed
 _require_scratch_encryption -v 2
 _require_scratch_f2fs_compression lz4
diff --git a/tests/generic/001 b/tests/generic/001
index c59344e47..d7491efd0 100755
--- a/tests/generic/001
+++ b/tests/generic/001
@@ -25,8 +25,6 @@ status=1
 done_cleanup=false
 _register_cleanup "_cleanup; rm -f $tmp.*"
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 verbose=true
diff --git a/tests/generic/002 b/tests/generic/002
index 3974ef0e2..b202492b4 100755
--- a/tests/generic/002
+++ b/tests/generic/002
@@ -14,8 +14,6 @@ _begin_fstest metadata udf auto quick
 
 status=0	# success is the default!
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_hardlinks
 
diff --git a/tests/generic/003 b/tests/generic/003
index 999aed142..44dc7d48d 100755
--- a/tests/generic/003
+++ b/tests/generic/003
@@ -15,9 +15,7 @@ _begin_fstest atime auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_scratch
 _require_atime
 _require_relatime
diff --git a/tests/generic/004 b/tests/generic/004
index a575c2ef0..70e8f7cce 100755
--- a/tests/generic/004
+++ b/tests/generic/004
@@ -19,8 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_xfs_io_command "-T"
diff --git a/tests/generic/005 b/tests/generic/005
index e497b33c6..8b64884b0 100755
--- a/tests/generic/005
+++ b/tests/generic/005
@@ -41,8 +41,6 @@ _touch()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_symlinks
 
diff --git a/tests/generic/006 b/tests/generic/006
index bc5329205..acd358f51 100755
--- a/tests/generic/006
+++ b/tests/generic/006
@@ -31,8 +31,6 @@ _count()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 mkdir $TEST_DIR/permname.$$
diff --git a/tests/generic/007 b/tests/generic/007
index 5183816ba..45d1c9769 100755
--- a/tests/generic/007
+++ b/tests/generic/007
@@ -25,8 +25,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 sourcefile=$tmp.nametest
diff --git a/tests/generic/008 b/tests/generic/008
index 7ddb2c651..b8ec456b7 100755
--- a/tests/generic/008
+++ b/tests/generic/008
@@ -16,7 +16,6 @@ _begin_fstest auto quick prealloc zero
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
 
 # Modify as appropriate.
 
diff --git a/tests/generic/009 b/tests/generic/009
index 7c9b137f6..05c5e408a 100755
--- a/tests/generic/009
+++ b/tests/generic/009
@@ -13,7 +13,6 @@ _begin_fstest auto quick prealloc zero fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
 _require_xfs_io_command "fzero"
 _require_xfs_io_command "fiemap"
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/010 b/tests/generic/010
index ac9689afc..cef984438 100755
--- a/tests/generic/010
+++ b/tests/generic/010
@@ -33,8 +33,6 @@ _filter_dbtest()
 
 _require_test_program "dbtest"
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 cd $TEST_DIR
diff --git a/tests/generic/011 b/tests/generic/011
index f4c795ae3..c78929616 100755
--- a/tests/generic/011
+++ b/tests/generic/011
@@ -23,8 +23,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 out=$TEST_DIR/dirstress.$$
diff --git a/tests/generic/012 b/tests/generic/012
index 74e7a02bf..c1dfb472f 100755
--- a/tests/generic/012
+++ b/tests/generic/012
@@ -18,8 +18,6 @@ _begin_fstest auto quick prealloc punch collapse fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/013 b/tests/generic/013
index 24b695173..3a000b97f 100755
--- a/tests/generic/013
+++ b/tests/generic/013
@@ -59,8 +59,6 @@ _do_test()
     _check_test_fs
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 echo "brevity is wit..."
diff --git a/tests/generic/014 b/tests/generic/014
index cff3622b6..541d65690 100755
--- a/tests/generic/014
+++ b/tests/generic/014
@@ -22,7 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 
 _require_test
 _require_sparse_files
diff --git a/tests/generic/015 b/tests/generic/015
index 716a7b1f9..d4f81c7f6 100755
--- a/tests/generic/015
+++ b/tests/generic/015
@@ -23,8 +23,6 @@ _free()
     _df_dir $SCRATCH_MNT | $AWK_PROG '{ print $5 }'
 }
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_no_large_scratch_dev
diff --git a/tests/generic/016 b/tests/generic/016
index 833e91618..2d0261704 100755
--- a/tests/generic/016
+++ b/tests/generic/016
@@ -18,8 +18,6 @@ _begin_fstest auto quick prealloc punch collapse fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/017 b/tests/generic/017
index 5f0d85139..960e00965 100755
--- a/tests/generic/017
+++ b/tests/generic/017
@@ -15,8 +15,6 @@ _begin_fstest auto prealloc collapse fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/018 b/tests/generic/018
index 4ffc91d57..501960d7f 100755
--- a/tests/generic/018
+++ b/tests/generic/018
@@ -13,8 +13,6 @@ _begin_fstest auto fsr quick defrag
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
-_supported_fs generic
 
 # We require scratch so that we'll have free contiguous space
 _require_scratch
diff --git a/tests/generic/019 b/tests/generic/019
index b81c1d17b..26108be41 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -15,7 +15,6 @@ fio_config=$tmp.fio
 # Import common functions.
 . ./common/filter
 . ./common/fail_make_request
-_supported_fs generic
 _require_scratch
 _require_block_device $SCRATCH_DEV
 _require_fail_make_request
@@ -126,7 +125,6 @@ _workout()
 	run_check _scratch_unmount
 }
 
-# real QA test starts here
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/generic/020 b/tests/generic/020
index 4951b9e37..8b77d5ca7 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -176,8 +176,6 @@ _attr_get_maxval_size()
 	esac
 }
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_attrs
diff --git a/tests/generic/021 b/tests/generic/021
index 532feeeb7..0fb2719a9 100755
--- a/tests/generic/021
+++ b/tests/generic/021
@@ -18,8 +18,6 @@ _begin_fstest auto quick prealloc punch collapse fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/022 b/tests/generic/022
index 62577b810..a50f19e8e 100755
--- a/tests/generic/022
+++ b/tests/generic/022
@@ -18,8 +18,6 @@ _begin_fstest auto quick prealloc punch collapse fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/023 b/tests/generic/023
index 2b1973c33..db00762bc 100755
--- a/tests/generic/023
+++ b/tests/generic/023
@@ -12,13 +12,11 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/renameat2
 
-_supported_fs generic
 
 _require_test
 _require_renameat2
 _require_symlinks
 
-# real QA test starts here
 
 rename_dir=$TEST_DIR/$$
 mkdir -p $rename_dir
diff --git a/tests/generic/024 b/tests/generic/024
index 84eecb9b3..d170c3164 100755
--- a/tests/generic/024
+++ b/tests/generic/024
@@ -12,13 +12,11 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/renameat2
 
-_supported_fs generic
 
 _require_test
 _require_renameat2 noreplace
 _require_symlinks
 
-# real QA test starts here
 
 rename_dir=$TEST_DIR/$$
 mkdir $rename_dir
diff --git a/tests/generic/025 b/tests/generic/025
index d3c793702..fab6d937d 100755
--- a/tests/generic/025
+++ b/tests/generic/025
@@ -12,13 +12,11 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/renameat2
 
-_supported_fs generic
 
 _require_test
 _require_renameat2 exchange
 _require_symlinks
 
-# real QA test starts here
 
 rename_dir=$TEST_DIR/$$
 mkdir $rename_dir
diff --git a/tests/generic/026 b/tests/generic/026
index 43b7b0b73..0944ead5e 100755
--- a/tests/generic/026
+++ b/tests/generic/026
@@ -22,8 +22,6 @@ _cleanup()
     [ -n "$TEST_DIR" ] && rm -rf $TEST_DIR/$seq.dir1
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _acl_setup_ids
 _require_acls
diff --git a/tests/generic/027 b/tests/generic/027
index eace1b358..b7721dfba 100755
--- a/tests/generic/027
+++ b/tests/generic/027
@@ -28,8 +28,6 @@ create_file()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 
diff --git a/tests/generic/028 b/tests/generic/028
index 9d646c552..1257a3aba 100755
--- a/tests/generic/028
+++ b/tests/generic/028
@@ -19,8 +19,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 echo "Silence is golden"
diff --git a/tests/generic/029 b/tests/generic/029
index 8b75c02a6..0af46e892 100755
--- a/tests/generic/029
+++ b/tests/generic/029
@@ -14,10 +14,8 @@ _begin_fstest auto quick rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 
 testfile=$SCRATCH_MNT/testfile
diff --git a/tests/generic/030 b/tests/generic/030
index c467bb746..3f0e5b993 100755
--- a/tests/generic/030
+++ b/tests/generic/030
@@ -14,10 +14,8 @@ _begin_fstest auto quick rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "mremap"
 
diff --git a/tests/generic/031 b/tests/generic/031
index 0d2e82681..4d6a54d12 100755
--- a/tests/generic/031
+++ b/tests/generic/031
@@ -14,10 +14,8 @@ _begin_fstest auto quick prealloc rw collapse
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "fcollapse"
 
diff --git a/tests/generic/032 b/tests/generic/032
index c006a5917..63abd62a8 100755
--- a/tests/generic/032
+++ b/tests/generic/032
@@ -25,7 +25,6 @@ _cleanup()
 # Import common functions.
 . ./common/punch
 
-# real QA test starts here
 
 _syncloop()
 {
@@ -35,7 +34,6 @@ _syncloop()
 }
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/033 b/tests/generic/033
index d3b926e69..a9a9ff5a3 100755
--- a/tests/generic/033
+++ b/tests/generic/033
@@ -17,10 +17,8 @@ _begin_fstest auto quick rw zero
 
 # Import common functions.
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "fzero"
 
diff --git a/tests/generic/034 b/tests/generic/034
index 3f422993d..71aae2a01 100755
--- a/tests/generic/034
+++ b/tests/generic/034
@@ -26,8 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/035 b/tests/generic/035
index a2135d7f4..2c8e8d310 100755
--- a/tests/generic/035
+++ b/tests/generic/035
@@ -12,14 +12,12 @@ _begin_fstest auto quick
 
 # Import common functions.
 
-_supported_fs generic
 
 _require_test
 
 # Select appropriate golden output based on fstype
 _link_out_file
 
-# real QA test starts here
 
 rename_dir=$TEST_DIR/$$
 mkdir -p $rename_dir
diff --git a/tests/generic/036 b/tests/generic/036
index 1bc762dde..b88b17067 100755
--- a/tests/generic/036
+++ b/tests/generic/036
@@ -13,9 +13,7 @@ _begin_fstest auto aio rw stress
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 
 _run_aiodio aio-dio-fcntl-race
diff --git a/tests/generic/037 b/tests/generic/037
index 55beddb49..7d387e256 100755
--- a/tests/generic/037
+++ b/tests/generic/037
@@ -29,8 +29,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_attrs
 
diff --git a/tests/generic/038 b/tests/generic/038
index e1176292f..22ea8d36e 100755
--- a/tests/generic/038
+++ b/tests/generic/038
@@ -46,8 +46,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/039 b/tests/generic/039
index 72eb6fa77..5162e85b0 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -29,8 +29,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/040 b/tests/generic/040
index 62e3468bd..eb88e9eed 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -34,8 +34,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/041 b/tests/generic/041
index ccf002c0c..447013689 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -38,8 +38,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/042 b/tests/generic/042
index 63a46d6b2..fd0ef705a 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -19,7 +19,6 @@ _begin_fstest shutdown rw punch zero prealloc auto quick
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
 
 _crashtest()
 {
@@ -59,7 +58,6 @@ _crashtest()
 }
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_scratch_shutdown
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/043 b/tests/generic/043
index d5ca438a8..4110aa2a3 100755
--- a/tests/generic/043
+++ b/tests/generic/043
@@ -12,8 +12,6 @@ _begin_fstest shutdown metadata log auto fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/044 b/tests/generic/044
index a5d3e9edc..5d21875cf 100755
--- a/tests/generic/044
+++ b/tests/generic/044
@@ -12,8 +12,6 @@ _begin_fstest shutdown metadata log auto fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/045 b/tests/generic/045
index dfbcaeb42..9904142f8 100755
--- a/tests/generic/045
+++ b/tests/generic/045
@@ -12,8 +12,6 @@ _begin_fstest shutdown metadata log auto fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/046 b/tests/generic/046
index 29165e450..5ed60c762 100755
--- a/tests/generic/046
+++ b/tests/generic/046
@@ -12,8 +12,6 @@ _begin_fstest shutdown metadata log auto fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/047 b/tests/generic/047
index 61590e9b5..f5ba0d19e 100755
--- a/tests/generic/047
+++ b/tests/generic/047
@@ -13,8 +13,6 @@ _begin_fstest shutdown metadata rw auto fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/048 b/tests/generic/048
index ebe9132e5..7b28cb053 100755
--- a/tests/generic/048
+++ b/tests/generic/048
@@ -13,8 +13,6 @@ _begin_fstest shutdown metadata rw auto fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/049 b/tests/generic/049
index e5c5a0e30..8e4b99565 100755
--- a/tests/generic/049
+++ b/tests/generic/049
@@ -13,8 +13,6 @@ _begin_fstest shutdown metadata rw auto fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/050 b/tests/generic/050
index 0664f8c0e..ca02d3092 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch_nocheck
 _require_scratch_shutdown
diff --git a/tests/generic/051 b/tests/generic/051
index afde8e26e..65571fdd0 100755
--- a/tests/generic/051
+++ b/tests/generic/051
@@ -22,8 +22,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/052 b/tests/generic/052
index 9771575cb..ec9de6788 100755
--- a/tests/generic/052
+++ b/tests/generic/052
@@ -16,8 +16,6 @@ _begin_fstest shutdown log auto quick
 . ./common/filter
 . ./common/log
 
-# real QA test starts here
-_supported_fs generic
 
 rm -f $tmp.log
 
diff --git a/tests/generic/053 b/tests/generic/053
index d7a2ffbdd..b308d233e 100755
--- a/tests/generic/053
+++ b/tests/generic/053
@@ -13,8 +13,6 @@ _begin_fstest acl repair auto quick
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_acls
diff --git a/tests/generic/054 b/tests/generic/054
index 806117d6c..20e9a1e96 100755
--- a/tests/generic/054
+++ b/tests/generic/054
@@ -15,8 +15,6 @@ _begin_fstest shutdown log v2log auto
 . ./common/filter
 . ./common/log
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/055 b/tests/generic/055
index 935691e15..b1126c901 100755
--- a/tests/generic/055
+++ b/tests/generic/055
@@ -42,8 +42,6 @@ _get_quota_option()
     esac
 }
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/056 b/tests/generic/056
index 99d5e3256..3e139e1ea 100755
--- a/tests/generic/056
+++ b/tests/generic/056
@@ -27,8 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/057 b/tests/generic/057
index 7e4e305e9..c92af5ddb 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -27,8 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/058 b/tests/generic/058
index dddadbe08..2b8c8047f 100755
--- a/tests/generic/058
+++ b/tests/generic/058
@@ -18,8 +18,6 @@ _begin_fstest auto quick prealloc punch insert fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/059 b/tests/generic/059
index 00c0f7b0a..0d3270787 100755
--- a/tests/generic/059
+++ b/tests/generic/059
@@ -35,8 +35,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/060 b/tests/generic/060
index 3a890ed03..794a1c997 100755
--- a/tests/generic/060
+++ b/tests/generic/060
@@ -18,8 +18,6 @@ _begin_fstest auto quick prealloc punch insert fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/061 b/tests/generic/061
index e370ffdfb..2de6407e5 100755
--- a/tests/generic/061
+++ b/tests/generic/061
@@ -18,8 +18,6 @@ _begin_fstest auto quick prealloc punch insert fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/062 b/tests/generic/062
index 6e5ad049b..8f4dfcbf5 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -47,8 +47,6 @@ _create_test_bed()
 	find $SCRATCH_MNT | LC_COLLATE=POSIX sort | _filter_scratch | grep -v "lost+found"
 }
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_attrs
@@ -57,7 +55,6 @@ _require_mknod
 
 rm -f $tmp.backup1 $tmp.backup2 $seqres.full
 
-# real QA test starts here
 _scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
 _scratch_mount
 _create_test_bed
diff --git a/tests/generic/063 b/tests/generic/063
index 3974647b9..b41cf53b7 100755
--- a/tests/generic/063
+++ b/tests/generic/063
@@ -18,8 +18,6 @@ _begin_fstest auto quick prealloc punch insert fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/064 b/tests/generic/064
index b50c55e7e..aed139705 100755
--- a/tests/generic/064
+++ b/tests/generic/064
@@ -15,8 +15,6 @@ _begin_fstest auto quick prealloc collapse insert fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/065 b/tests/generic/065
index 7f974feae..adf55b750 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -28,8 +28,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/066 b/tests/generic/066
index d8a38655d..e32e9658b 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -32,8 +32,6 @@ _cleanup()
 . ./common/dmflakey
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 _require_attrs
diff --git a/tests/generic/067 b/tests/generic/067
index cb466e0c1..b561b7bc5 100755
--- a/tests/generic/067
+++ b/tests/generic/067
@@ -19,10 +19,8 @@ _begin_fstest auto quick mount
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_symlinks
 _require_test
 _require_scratch
diff --git a/tests/generic/068 b/tests/generic/068
index af527fee2..1e8248b9d 100755
--- a/tests/generic/068
+++ b/tests/generic/068
@@ -28,8 +28,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_freeze
diff --git a/tests/generic/069 b/tests/generic/069
index 5579bff29..390a340be 100755
--- a/tests/generic/069
+++ b/tests/generic/069
@@ -15,8 +15,6 @@ _register_cleanup "rm -rf $tmp.*"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 
diff --git a/tests/generic/070 b/tests/generic/070
index 8a134f80f..a8e84effd 100755
--- a/tests/generic/070
+++ b/tests/generic/070
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_attrs
diff --git a/tests/generic/071 b/tests/generic/071
index 205d83154..7eb9662b7 100755
--- a/tests/generic/071
+++ b/tests/generic/071
@@ -14,8 +14,6 @@ _begin_fstest auto quick prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
 
diff --git a/tests/generic/072 b/tests/generic/072
index 59b49fac1..001f980ae 100755
--- a/tests/generic/072
+++ b/tests/generic/072
@@ -15,8 +15,6 @@ _begin_fstest auto metadata stress collapse
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_xfs_io_command "fcollapse"
 
diff --git a/tests/generic/073 b/tests/generic/073
index f28a08389..5ebf634fa 100755
--- a/tests/generic/073
+++ b/tests/generic/073
@@ -28,8 +28,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/074 b/tests/generic/074
index ec63c50f9..923bf36b1 100755
--- a/tests/generic/074
+++ b/tests/generic/074
@@ -21,7 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_test
 
 _do_test()
diff --git a/tests/generic/075 b/tests/generic/075
index 9f24ad418..8db58e866 100755
--- a/tests/generic/075
+++ b/tests/generic/075
@@ -101,8 +101,6 @@ _process_args()
     done
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 size10=`expr 10 \* 1024 \* 1024`	# 10 megabytes
diff --git a/tests/generic/076 b/tests/generic/076
index c024fadd9..b50c2df5e 100755
--- a/tests/generic/076
+++ b/tests/generic/076
@@ -30,8 +30,6 @@ _register_cleanup "_cleanup; rm -f $tmp.*"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_local_device $SCRATCH_DEV
diff --git a/tests/generic/077 b/tests/generic/077
index 4d66f1055..9323f3278 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -34,8 +34,6 @@ _register_cleanup "_cleanup; rm -f $tmp.*"
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 
 [ ! -d $filler ] && _notrun "No directory at least 256MB to source files from"
 
diff --git a/tests/generic/078 b/tests/generic/078
index fe0fb44a3..f7ae72687 100755
--- a/tests/generic/078
+++ b/tests/generic/078
@@ -12,13 +12,11 @@ _begin_fstest auto quick metadata
 # Import common functions.
 . ./common/renameat2
 
-_supported_fs generic
 
 _require_test
 _require_renameat2 whiteout
 _require_symlinks
 
-# real QA test starts here
 
 rename_dir=$TEST_DIR/$$
 mkdir $rename_dir
diff --git a/tests/generic/079 b/tests/generic/079
index 9e7ccd31c..df9ae52cd 100755
--- a/tests/generic/079
+++ b/tests/generic/079
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs generic
 
 _require_chattr ia
 _require_user_exists "nobody"
@@ -31,7 +30,6 @@ _require_user_exists "daemon"
 _require_test_program "t_immutable"
 _require_scratch
 
-# real QA test starts here
 _scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
 _scratch_mount
 
diff --git a/tests/generic/080 b/tests/generic/080
index 1bfc6d723..5c38cc205 100755
--- a/tests/generic/080
+++ b/tests/generic/080
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 echo "Silence is golden."
diff --git a/tests/generic/081 b/tests/generic/081
index 0996f221d..468c87ac9 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -47,8 +47,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch_nolvm
 _require_dm_target snapshot
diff --git a/tests/generic/082 b/tests/generic/082
index ddf48f634..f078ef2ff 100755
--- a/tests/generic/082
+++ b/tests/generic/082
@@ -18,8 +18,6 @@ filter_project_quota_line()
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_quota
diff --git a/tests/generic/083 b/tests/generic/083
index 4cd1c3997..10db5f080 100755
--- a/tests/generic/083
+++ b/tests/generic/083
@@ -29,8 +29,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_no_large_scratch_dev
diff --git a/tests/generic/084 b/tests/generic/084
index 942ee400d..137ba23cf 100755
--- a/tests/generic/084
+++ b/tests/generic/084
@@ -15,8 +15,6 @@ _begin_fstest auto metadata quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 
 link_unlink_storm()
diff --git a/tests/generic/085 b/tests/generic/085
index 786d8e6fa..cfe6112d6 100755
--- a/tests/generic/085
+++ b/tests/generic/085
@@ -34,8 +34,6 @@ cleanup_dmdev()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_block_device $SCRATCH_DEV
 _require_dm_target linear
diff --git a/tests/generic/086 b/tests/generic/086
index 509c4f38d..4ae79b81f 100755
--- a/tests/generic/086
+++ b/tests/generic/086
@@ -19,10 +19,8 @@ _begin_fstest auto prealloc preallocrw quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/087 b/tests/generic/087
index 160b32def..fe66b00ba 100755
--- a/tests/generic/087
+++ b/tests/generic/087
@@ -28,8 +28,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_chown
 
diff --git a/tests/generic/088 b/tests/generic/088
index 1c17b82f3..5228ffe5a 100755
--- a/tests/generic/088
+++ b/tests/generic/088
@@ -19,8 +19,6 @@ _filter()
     _filter_test_dir | sed -e '/----------/d'
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_chown
 
diff --git a/tests/generic/089 b/tests/generic/089
index 1bbd1507d..89c19484f 100755
--- a/tests/generic/089
+++ b/tests/generic/089
@@ -26,8 +26,6 @@ addentries()
 	done
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_hardlinks
 
diff --git a/tests/generic/090 b/tests/generic/090
index c0fdd2b28..36a9ee865 100755
--- a/tests/generic/090
+++ b/tests/generic/090
@@ -26,8 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/091 b/tests/generic/091
index 9c02e36d8..8f7c13da8 100755
--- a/tests/generic/091
+++ b/tests/generic/091
@@ -12,8 +12,6 @@ _begin_fstest rw auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_odirect
 
diff --git a/tests/generic/092 b/tests/generic/092
index bdd8feddf..d8c223270 100755
--- a/tests/generic/092
+++ b/tests/generic/092
@@ -20,10 +20,8 @@ status=0	# success is the default!
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/093 b/tests/generic/093
index d7ddfd1ba..c4e866da1 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -25,8 +25,6 @@ filefilter()
     sed -e "s#$file#file#"
 }
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_attrs security
diff --git a/tests/generic/094 b/tests/generic/094
index 0d9ce8b6e..c82efced5 100755
--- a/tests/generic/094
+++ b/tests/generic/094
@@ -12,8 +12,6 @@ _begin_fstest auto quick prealloc fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_odirect
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/095 b/tests/generic/095
index 9d0446e98..7a0adf880 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -12,8 +12,6 @@ _begin_fstest auto quick rw stress
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_odirect
 _require_aio
diff --git a/tests/generic/096 b/tests/generic/096
index 41b646c05..70eae0143 100755
--- a/tests/generic/096
+++ b/tests/generic/096
@@ -15,8 +15,6 @@ _begin_fstest auto prealloc quick zero
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "fzero"
 
diff --git a/tests/generic/097 b/tests/generic/097
index 613aabaae..7f53b69da 100755
--- a/tests/generic/097
+++ b/tests/generic/097
@@ -37,8 +37,6 @@ setfattr()
 . ./common/attr
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_attrs user trusted
diff --git a/tests/generic/098 b/tests/generic/098
index b947fb256..57de42e9c 100755
--- a/tests/generic/098
+++ b/tests/generic/098
@@ -18,8 +18,6 @@ _begin_fstest auto quick metadata
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 
 # This test was motivated by an issue found in btrfs when the btrfs no-holes
diff --git a/tests/generic/099 b/tests/generic/099
index eab6f4723..c7d5932b6 100755
--- a/tests/generic/099
+++ b/tests/generic/099
@@ -46,8 +46,6 @@ _cleanup()
 #   -> interesting if it allows user to specify ACEs in any order
 #
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_runas
 
diff --git a/tests/generic/100 b/tests/generic/100
index cec47a0c9..fd33e1f14 100755
--- a/tests/generic/100
+++ b/tests/generic/100
@@ -19,8 +19,6 @@ _cleanup()
      rm -f $tmp.* $TEMP_DIR/$TAR_FILE
 }
  
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 # Use _populate_fs() in common/rc to create a directory structure.
diff --git a/tests/generic/101 b/tests/generic/101
index 76750c335..2e9543579 100755
--- a/tests/generic/101
+++ b/tests/generic/101
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/102 b/tests/generic/102
index 3536ebf75..daa5061bd 100755
--- a/tests/generic/102
+++ b/tests/generic/102
@@ -18,8 +18,6 @@ _begin_fstest auto rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 
 dev_size=$((1024 * 1024 * 1024))     # 1GB filesystem
diff --git a/tests/generic/103 b/tests/generic/103
index fd650ec90..6ef251ecb 100755
--- a/tests/generic/103
+++ b/tests/generic/103
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" 25
 # Import common functions.
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_attrs
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/104 b/tests/generic/104
index 955185fad..7f294e1b6 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/105 b/tests/generic/105
index a05219df0..a74dc726a 100755
--- a/tests/generic/105
+++ b/tests/generic/105
@@ -23,9 +23,7 @@ _cleanup()
 . ./common/attr
 
 # Modify as appropriate.
-_supported_fs generic
 
-# real QA test starts here
 
 _require_scratch
 _require_acls
diff --git a/tests/generic/106 b/tests/generic/106
index b8869236d..2b89ae69a 100755
--- a/tests/generic/106
+++ b/tests/generic/106
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/107 b/tests/generic/107
index 623c30a95..177ca59c5 100755
--- a/tests/generic/107
+++ b/tests/generic/107
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/108 b/tests/generic/108
index 07703fc8f..da13715f2 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -30,8 +30,6 @@ _cleanup()
 . ./common/filter
 . ./common/scsi_debug
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_nolvm
 _require_block_device $SCRATCH_DEV
 _require_scsi_debug
diff --git a/tests/generic/109 b/tests/generic/109
index b0bc17093..2b0b438cf 100755
--- a/tests/generic/109
+++ b/tests/generic/109
@@ -12,8 +12,6 @@ _begin_fstest auto metadata dir
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_symlinks
 
diff --git a/tests/generic/110 b/tests/generic/110
index ef5ac5f6d..12d8d4083 100755
--- a/tests/generic/110
+++ b/tests/generic/110
@@ -24,7 +24,6 @@ _cleanup()
 . common/filter
 . common/reflink
 
-# real QA test starts here
 _require_test_reflink
 
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/111 b/tests/generic/111
index 5df0fa80c..7d4080806 100755
--- a/tests/generic/111
+++ b/tests/generic/111
@@ -25,7 +25,6 @@ _cleanup()
 . common/filter
 . common/reflink
 
-# real QA test starts here
 _require_test_reflink
 
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/112 b/tests/generic/112
index 971d04675..0084b555a 100755
--- a/tests/generic/112
+++ b/tests/generic/112
@@ -97,8 +97,6 @@ _process_args()
     done
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_aio
 
diff --git a/tests/generic/113 b/tests/generic/113
index cacb2425e..2b7140b98 100755
--- a/tests/generic/113
+++ b/tests/generic/113
@@ -53,8 +53,6 @@ _do_test()
     rm -f $_files
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_aio
 _require_odirect
diff --git a/tests/generic/114 b/tests/generic/114
index a5ad4fab9..068ed9e26 100755
--- a/tests/generic/114
+++ b/tests/generic/114
@@ -19,7 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 
 _require_test
 _require_sparse_files
diff --git a/tests/generic/115 b/tests/generic/115
index 13d4b5373..ddbb7b896 100755
--- a/tests/generic/115
+++ b/tests/generic/115
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/116 b/tests/generic/116
index 88b64f4c3..702a24876 100755
--- a/tests/generic/116
+++ b/tests/generic/116
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 
 testdir=$TEST_DIR/test-$seq
diff --git a/tests/generic/117 b/tests/generic/117
index e23c05085..f9769be94 100755
--- a/tests/generic/117
+++ b/tests/generic/117
@@ -45,8 +45,6 @@ ITERATIONS=10
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_attrs
diff --git a/tests/generic/118 b/tests/generic/118
index 35d933ffd..cc8f1b442 100755
--- a/tests/generic/118
+++ b/tests/generic/118
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 
 testdir=$TEST_DIR/test-$seq
diff --git a/tests/generic/119 b/tests/generic/119
index 481d12d2b..55bb6013c 100755
--- a/tests/generic/119
+++ b/tests/generic/119
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_arbitrary_fileset_reflink
 
diff --git a/tests/generic/120 b/tests/generic/120
index 5a67ed0dc..7527bd4a0 100755
--- a/tests/generic/120
+++ b/tests/generic/120
@@ -12,8 +12,6 @@ _begin_fstest other atime auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_atime
diff --git a/tests/generic/121 b/tests/generic/121
index e9038240a..2cec559fa 100755
--- a/tests/generic/121
+++ b/tests/generic/121
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_dedupe
 
 testdir=$TEST_DIR/test-$seq
diff --git a/tests/generic/122 b/tests/generic/122
index 89309c22a..a007e1079 100755
--- a/tests/generic/122
+++ b/tests/generic/122
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_dedupe
 
 testdir=$TEST_DIR/test-$seq
diff --git a/tests/generic/123 b/tests/generic/123
index 43f90b46e..46188f0fb 100755
--- a/tests/generic/123
+++ b/tests/generic/123
@@ -23,8 +23,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_user
diff --git a/tests/generic/124 b/tests/generic/124
index 2d5671605..ad56aea3f 100755
--- a/tests/generic/124
+++ b/tests/generic/124
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_scratch
diff --git a/tests/generic/125 b/tests/generic/125
index 0d8e61a11..e2bc5fa12 100755
--- a/tests/generic/125
+++ b/tests/generic/125
@@ -12,8 +12,6 @@ _begin_fstest other pnfs auto
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_user
diff --git a/tests/generic/126 b/tests/generic/126
index 04fbd4c6d..142d2bb97 100755
--- a/tests/generic/126
+++ b/tests/generic/126
@@ -18,8 +18,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_chown
 
diff --git a/tests/generic/127 b/tests/generic/127
index f931badd5..c8984f273 100755
--- a/tests/generic/127
+++ b/tests/generic/127
@@ -79,8 +79,6 @@ _fsx_std_mmap()
     return 0
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 _fsx_lite_nommap || exit
diff --git a/tests/generic/128 b/tests/generic/128
index 924d6aa83..f931ca063 100755
--- a/tests/generic/128
+++ b/tests/generic/128
@@ -12,8 +12,6 @@ _begin_fstest perms auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_user
diff --git a/tests/generic/129 b/tests/generic/129
index 3d3a42a2e..fd311d77a 100755
--- a/tests/generic/129
+++ b/tests/generic/129
@@ -18,8 +18,6 @@ echo_and_run()
     $1
 }
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_sparse_files
diff --git a/tests/generic/130 b/tests/generic/130
index 39a848c2f..e8a7f33c5 100755
--- a/tests/generic/130
+++ b/tests/generic/130
@@ -21,8 +21,6 @@ _begin_fstest pattern auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_sparse_files
diff --git a/tests/generic/131 b/tests/generic/131
index 5472ffe41..e5860c706 100755
--- a/tests/generic/131
+++ b/tests/generic/131
@@ -13,8 +13,6 @@ _begin_fstest perms auto quick
 . ./common/filter
 . ./common/locktest
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_test_fcntl_advisory_locks
 
diff --git a/tests/generic/132 b/tests/generic/132
index db7a1bf7f..fdfbab2a6 100755
--- a/tests/generic/132
+++ b/tests/generic/132
@@ -13,8 +13,6 @@ _begin_fstest pattern auto
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 
diff --git a/tests/generic/133 b/tests/generic/133
index c1c7c34aa..3ed1bfc65 100755
--- a/tests/generic/133
+++ b/tests/generic/133
@@ -12,8 +12,6 @@ _begin_fstest rw auto
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_odirect
 
diff --git a/tests/generic/134 b/tests/generic/134
index 58b81872b..1d5627af4 100755
--- a/tests/generic/134
+++ b/tests/generic/134
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 
 testdir=$TEST_DIR/test-$seq
diff --git a/tests/generic/135 b/tests/generic/135
index dc7593d58..30c52af72 100755
--- a/tests/generic/135
+++ b/tests/generic/135
@@ -12,8 +12,6 @@ _begin_fstest metadata auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_odirect
 _require_scratch
diff --git a/tests/generic/136 b/tests/generic/136
index c5b80074f..d88fb1dde 100755
--- a/tests/generic/136
+++ b/tests/generic/136
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_dedupe
 
 testdir=$TEST_DIR/test-$seq
diff --git a/tests/generic/137 b/tests/generic/137
index 18644d9d7..6d87ce339 100755
--- a/tests/generic/137
+++ b/tests/generic/137
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_test_dedupe
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/138 b/tests/generic/138
index d061ac349..f51257d7e 100755
--- a/tests/generic/138
+++ b/tests/generic/138
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/139 b/tests/generic/139
index 3eb1519d8..ea9517059 100755
--- a/tests/generic/139
+++ b/tests/generic/139
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_odirect 512
diff --git a/tests/generic/140 b/tests/generic/140
index 52cf07dcf..8cbc23bb0 100755
--- a/tests/generic/140
+++ b/tests/generic/140
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/141 b/tests/generic/141
index 206ccca94..d6fab33f7 100755
--- a/tests/generic/141
+++ b/tests/generic/141
@@ -12,8 +12,6 @@ _begin_fstest rw auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _scratch_mkfs >/dev/null 2>&1
diff --git a/tests/generic/142 b/tests/generic/142
index 17d6b792a..4846c8222 100755
--- a/tests/generic/142
+++ b/tests/generic/142
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/143 b/tests/generic/143
index f9be9afe9..ce4e22dcc 100755
--- a/tests/generic/143
+++ b/tests/generic/143
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/144 b/tests/generic/144
index 4daaeae01..158c6b0f4 100755
--- a/tests/generic/144
+++ b/tests/generic/144
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/145 b/tests/generic/145
index f213f53be..f9f179ef8 100755
--- a/tests/generic/145
+++ b/tests/generic/145
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/146 b/tests/generic/146
index d0953fdab..5fbb011da 100755
--- a/tests/generic/146
+++ b/tests/generic/146
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/147 b/tests/generic/147
index 113800944..e1ac96217 100755
--- a/tests/generic/147
+++ b/tests/generic/147
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "finsert"
diff --git a/tests/generic/148 b/tests/generic/148
index 1b321821c..c0a523d51 100755
--- a/tests/generic/148
+++ b/tests/generic/148
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "truncate"
diff --git a/tests/generic/149 b/tests/generic/149
index 108f1368b..594f72a83 100755
--- a/tests/generic/149
+++ b/tests/generic/149
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fzero"
diff --git a/tests/generic/150 b/tests/generic/150
index 2830dd266..159a53c4d 100755
--- a/tests/generic/150
+++ b/tests/generic/150
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/151 b/tests/generic/151
index dd5bd64ec..a335b9273 100755
--- a/tests/generic/151
+++ b/tests/generic/151
@@ -27,7 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/152 b/tests/generic/152
index 8ee353c57..8d87dbac7 100755
--- a/tests/generic/152
+++ b/tests/generic/152
@@ -27,7 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/153 b/tests/generic/153
index 342959fd3..2945dfc69 100755
--- a/tests/generic/153
+++ b/tests/generic/153
@@ -27,7 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fcollapse"
diff --git a/tests/generic/154 b/tests/generic/154
index 41d63863f..ae5e56e01 100755
--- a/tests/generic/154
+++ b/tests/generic/154
@@ -27,7 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/155 b/tests/generic/155
index 1ee04c675..09ea8ed26 100755
--- a/tests/generic/155
+++ b/tests/generic/155
@@ -29,7 +29,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fzero"
diff --git a/tests/generic/156 b/tests/generic/156
index df0d0a74a..fc29df36b 100755
--- a/tests/generic/156
+++ b/tests/generic/156
@@ -34,7 +34,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "funshare"
diff --git a/tests/generic/157 b/tests/generic/157
index 4d5e3cfe3..cb9143673 100755
--- a/tests/generic/157
+++ b/tests/generic/157
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_scratch_reflink
 _require_mknod
diff --git a/tests/generic/158 b/tests/generic/158
index b9955265e..171d3c0dc 100755
--- a/tests/generic/158
+++ b/tests/generic/158
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_test_dedupe
 _require_scratch_dedupe
 _require_mknod
diff --git a/tests/generic/159 b/tests/generic/159
index 725671ffc..c4dec17ca 100755
--- a/tests/generic/159
+++ b/tests/generic/159
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_chattr i
 _require_test_reflink
 
diff --git a/tests/generic/160 b/tests/generic/160
index f83c815db..fc7a161e1 100755
--- a/tests/generic/160
+++ b/tests/generic/160
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_chattr i
 _require_test_dedupe
 
diff --git a/tests/generic/161 b/tests/generic/161
index 44d3d8f0c..4be8ffac6 100755
--- a/tests/generic/161
+++ b/tests/generic/161
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/162 b/tests/generic/162
index 7b625e86e..e23014f03 100755
--- a/tests/generic/162
+++ b/tests/generic/162
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_dedupe
 
 echo "Format and mount"
diff --git a/tests/generic/163 b/tests/generic/163
index 91da69d32..51a00e4b7 100755
--- a/tests/generic/163
+++ b/tests/generic/163
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_dedupe
 
 echo "Format and mount"
diff --git a/tests/generic/164 b/tests/generic/164
index 8ab71c72b..e5c8acd02 100755
--- a/tests/generic/164
+++ b/tests/generic/164
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/165 b/tests/generic/165
index 6deb66235..0e565eb1d 100755
--- a/tests/generic/165
+++ b/tests/generic/165
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/166 b/tests/generic/166
index 0eb2ec9c3..16157571f 100755
--- a/tests/generic/166
+++ b/tests/generic/166
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/167 b/tests/generic/167
index ae5fa5eb1..0c3e20fe2 100755
--- a/tests/generic/167
+++ b/tests/generic/167
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/168 b/tests/generic/168
index bdc8f7a05..bd9859f73 100755
--- a/tests/generic/168
+++ b/tests/generic/168
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 
 echo "Format and mount"
diff --git a/tests/generic/169 b/tests/generic/169
index ea4c4d096..47bfa08ae 100755
--- a/tests/generic/169
+++ b/tests/generic/169
@@ -21,8 +21,6 @@ _show_wrote_and_stat_only()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 
diff --git a/tests/generic/170 b/tests/generic/170
index 593cfbb73..35b278b9f 100755
--- a/tests/generic/170
+++ b/tests/generic/170
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_odirect
 
diff --git a/tests/generic/171 b/tests/generic/171
index fb2a6f145..dd56aa792 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/172 b/tests/generic/172
index ab5122fa4..c23a12284 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/173 b/tests/generic/173
index 0eb313e27..8df3c6df2 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/174 b/tests/generic/174
index 1505453e1..b9c292071 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/175 b/tests/generic/175
index f827beb67..01d9d6d16 100755
--- a/tests/generic/175
+++ b/tests/generic/175
@@ -14,7 +14,6 @@ _begin_fstest auto clone
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/176 b/tests/generic/176
index 8d02c875b..cb46213a5 100755
--- a/tests/generic/176
+++ b/tests/generic/176
@@ -14,7 +14,6 @@ _begin_fstest auto clone punch
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/177 b/tests/generic/177
index ff55a79f9..7a4fc7762 100755
--- a/tests/generic/177
+++ b/tests/generic/177
@@ -26,8 +26,6 @@ _cleanup()
 . ./common/punch
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/178 b/tests/generic/178
index 9efb79aa4..46c015a3f 100755
--- a/tests/generic/178
+++ b/tests/generic/178
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/179 b/tests/generic/179
index d22eb714b..e5527e27a 100755
--- a/tests/generic/179
+++ b/tests/generic/179
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/180 b/tests/generic/180
index b271ef3e5..ecbee826f 100755
--- a/tests/generic/180
+++ b/tests/generic/180
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "fzero"
diff --git a/tests/generic/181 b/tests/generic/181
index 5e5883dfe..7b4575854 100755
--- a/tests/generic/181
+++ b/tests/generic/181
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/182 b/tests/generic/182
index 172f644a7..cabc9ddce 100755
--- a/tests/generic/182
+++ b/tests/generic/182
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_dedupe
 
 testdir=$TEST_DIR/test-$seq
diff --git a/tests/generic/183 b/tests/generic/183
index c86145141..02d23d834 100755
--- a/tests/generic/183
+++ b/tests/generic/183
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_odirect
 
diff --git a/tests/generic/184 b/tests/generic/184
index 9e8263e8d..c82876d9b 100755
--- a/tests/generic/184
+++ b/tests/generic/184
@@ -12,8 +12,6 @@ _begin_fstest metadata auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_mknod
 
diff --git a/tests/generic/185 b/tests/generic/185
index 75dbc6b84..42dd6fd83 100755
--- a/tests/generic/185
+++ b/tests/generic/185
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 
 echo "Format and mount"
diff --git a/tests/generic/186 b/tests/generic/186
index 5f6959a7e..1edab8957 100755
--- a/tests/generic/186
+++ b/tests/generic/186
@@ -28,7 +28,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/187 b/tests/generic/187
index e9b373995..2a06aff35 100755
--- a/tests/generic/187
+++ b/tests/generic/187
@@ -28,7 +28,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 
 # btrfs can't fragment free space. This test is unreliable on NFS, as it
 # depends on the exported filesystem.
diff --git a/tests/generic/188 b/tests/generic/188
index 4a6346a75..53fde3838 100755
--- a/tests/generic/188
+++ b/tests/generic/188
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/189 b/tests/generic/189
index 262ae671f..f8e1e0931 100755
--- a/tests/generic/189
+++ b/tests/generic/189
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/190 b/tests/generic/190
index d95f071aa..8369fb797 100755
--- a/tests/generic/190
+++ b/tests/generic/190
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/191 b/tests/generic/191
index 49d31dbc9..6a67e6a25 100755
--- a/tests/generic/191
+++ b/tests/generic/191
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/192 b/tests/generic/192
index 282548663..82e529fd1 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -19,9 +19,7 @@ _access_time()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 _require_atime
 delay=5
diff --git a/tests/generic/193 b/tests/generic/193
index e2710b07d..d251d3a5c 100755
--- a/tests/generic/193
+++ b/tests/generic/193
@@ -46,8 +46,6 @@ _filter_files()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_user
diff --git a/tests/generic/194 b/tests/generic/194
index 93dc4778b..ea3a248c1 100755
--- a/tests/generic/194
+++ b/tests/generic/194
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/195 b/tests/generic/195
index 1262b1852..fe944a7cc 100755
--- a/tests/generic/195
+++ b/tests/generic/195
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/196 b/tests/generic/196
index e02ee24ab..249202aef 100755
--- a/tests/generic/196
+++ b/tests/generic/196
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/197 b/tests/generic/197
index a057cac46..13469af7c 100755
--- a/tests/generic/197
+++ b/tests/generic/197
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/198 b/tests/generic/198
index 3c216c5d5..6b4577063 100755
--- a/tests/generic/198
+++ b/tests/generic/198
@@ -13,13 +13,11 @@ _begin_fstest auto aio quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_aiodio aiodio_sparse2
 _require_test
 
 echo "Silence is golden."
 
-# real QA test starts here
 
 rm -f "$TEST_DIR/aiodio_sparse*"
 $AIO_TEST "$TEST_DIR/aiodio_sparse"
diff --git a/tests/generic/199 b/tests/generic/199
index e20a2e281..859ed94a7 100755
--- a/tests/generic/199
+++ b/tests/generic/199
@@ -29,7 +29,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/200 b/tests/generic/200
index 3cd90aa43..565dc4c46 100755
--- a/tests/generic/200
+++ b/tests/generic/200
@@ -29,7 +29,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/201 b/tests/generic/201
index faf168b2a..24e6f68dc 100755
--- a/tests/generic/201
+++ b/tests/generic/201
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/202 b/tests/generic/202
index 05354450c..841fabf83 100755
--- a/tests/generic/202
+++ b/tests/generic/202
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/203 b/tests/generic/203
index b51969c82..0b61d7771 100755
--- a/tests/generic/203
+++ b/tests/generic/203
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/204 b/tests/generic/204
index a33a090f9..9ef54e239 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -19,8 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 
diff --git a/tests/generic/205 b/tests/generic/205
index 0412110c0..0c385a984 100755
--- a/tests/generic/205
+++ b/tests/generic/205
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 
 pagesz=$(getconf PAGE_SIZE)
diff --git a/tests/generic/206 b/tests/generic/206
index 073fe48ed..5e305d19a 100755
--- a/tests/generic/206
+++ b/tests/generic/206
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_odirect
 
diff --git a/tests/generic/207 b/tests/generic/207
index a939d0be3..7274ef1d1 100755
--- a/tests/generic/207
+++ b/tests/generic/207
@@ -12,9 +12,7 @@ _begin_fstest auto aio quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 
 _run_aiodio aio-dio-extend-stat
diff --git a/tests/generic/208 b/tests/generic/208
index c5c171fae..dfddf66a4 100755
--- a/tests/generic/208
+++ b/tests/generic/208
@@ -12,9 +12,7 @@ _begin_fstest auto aio
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 
 _run_aiodio aio-dio-invalidate-failure
diff --git a/tests/generic/209 b/tests/generic/209
index 6625a28c8..0a64bd3a9 100755
--- a/tests/generic/209
+++ b/tests/generic/209
@@ -12,9 +12,7 @@ _begin_fstest auto aio
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 
 _run_aiodio aio-dio-invalidate-readahead
diff --git a/tests/generic/210 b/tests/generic/210
index 1504809d0..c5e86071f 100755
--- a/tests/generic/210
+++ b/tests/generic/210
@@ -12,9 +12,7 @@ _begin_fstest auto aio quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 
 _run_aiodio aio-dio-subblock-eof-read
diff --git a/tests/generic/211 b/tests/generic/211
index 02edd22e4..9868c6007 100755
--- a/tests/generic/211
+++ b/tests/generic/211
@@ -12,9 +12,7 @@ _begin_fstest auto aio quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 
 _run_aiodio aio-free-ring-with-bogus-nr-pages
diff --git a/tests/generic/212 b/tests/generic/212
index 71e2724e9..70900cc42 100755
--- a/tests/generic/212
+++ b/tests/generic/212
@@ -13,9 +13,7 @@ _begin_fstest auto aio quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 
 _run_aiodio aio-io-setup-with-nonwritable-context-pointer
diff --git a/tests/generic/213 b/tests/generic/213
index ad52fbb17..7744d3463 100755
--- a/tests/generic/213
+++ b/tests/generic/213
@@ -17,9 +17,7 @@ tmp=$TEST_DIR/$$
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 # generic, but xfs_io's fallocate must work
-_supported_fs generic
 # only Linux supports fallocate
 
 [ -n "$XFS_IO_PROG" ] || _notrun "xfs_io executable not found"
diff --git a/tests/generic/214 b/tests/generic/214
index 34aa3a495..2543002ca 100755
--- a/tests/generic/214
+++ b/tests/generic/214
@@ -22,9 +22,7 @@ tmp=$TEST_DIR/$$
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 # generic, but xfs_io's fallocate must work
-_supported_fs generic
 # only Linux supports fallocate
 _require_test
 
diff --git a/tests/generic/215 b/tests/generic/215
index fc3b8cef7..6f51b26a0 100755
--- a/tests/generic/215
+++ b/tests/generic/215
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 testfile=$TEST_DIR/tst.mmap
diff --git a/tests/generic/216 b/tests/generic/216
index 2e40173de..7bfcdba92 100755
--- a/tests/generic/216
+++ b/tests/generic/216
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/217 b/tests/generic/217
index a5a8b35f7..359aa2eb6 100755
--- a/tests/generic/217
+++ b/tests/generic/217
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/218 b/tests/generic/218
index 3e6bd18a6..6a187f28d 100755
--- a/tests/generic/218
+++ b/tests/generic/218
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/219 b/tests/generic/219
index 71da25e35..940b902e8 100755
--- a/tests/generic/219
+++ b/tests/generic/219
@@ -14,8 +14,6 @@ _begin_fstest auto quota quick
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_user
@@ -78,7 +76,6 @@ test_accounting()
 	repquota -$type $SCRATCH_MNT | grep "^$id" | check_usage 144 3
 }
 
-# real QA test starts here
 
 _scratch_unmount 2>/dev/null
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/generic/220 b/tests/generic/220
index f3a53565a..a263bebf0 100755
--- a/tests/generic/220
+++ b/tests/generic/220
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/221 b/tests/generic/221
index 1fb442734..7425f85f1 100755
--- a/tests/generic/221
+++ b/tests/generic/221
@@ -14,8 +14,6 @@ _begin_fstest auto metadata quick
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 echo "Silence is golden."
diff --git a/tests/generic/222 b/tests/generic/222
index bdb5bb1e5..3a4d5aa43 100755
--- a/tests/generic/222
+++ b/tests/generic/222
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/223 b/tests/generic/223
index 0fb07e12a..ccb175921 100755
--- a/tests/generic/223
+++ b/tests/generic/223
@@ -12,8 +12,6 @@ _begin_fstest auto quick prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/224 b/tests/generic/224
index 26055ea25..46ff512cb 100755
--- a/tests/generic/224
+++ b/tests/generic/224
@@ -24,8 +24,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 
diff --git a/tests/generic/225 b/tests/generic/225
index a996889ec..4f4f1353d 100755
--- a/tests/generic/225
+++ b/tests/generic/225
@@ -12,8 +12,6 @@ _begin_fstest auto quick fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_odirect
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/226 b/tests/generic/226
index 344347307..5553b8984 100755
--- a/tests/generic/226
+++ b/tests/generic/226
@@ -11,11 +11,9 @@ _begin_fstest auto enospc
 
 # Import common functions.
 
-_supported_fs generic
 _require_scratch
 _require_odirect
 
-# real QA test starts here
 
 _scratch_unmount 2>/dev/null
 echo "--> mkfs 256m filesystem"
diff --git a/tests/generic/227 b/tests/generic/227
index e7708db9d..ec6943170 100755
--- a/tests/generic/227
+++ b/tests/generic/227
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/228 b/tests/generic/228
index 92338982c..f1881f847 100755
--- a/tests/generic/228
+++ b/tests/generic/228
@@ -25,9 +25,7 @@ _register_cleanup "_cleanup" 25
 
 # Import common functions.
 
-# real QA test starts here
 # generic, but xfs_io's fallocate must work
-_supported_fs generic
 # only Linux supports fallocate
 _require_test
 
diff --git a/tests/generic/229 b/tests/generic/229
index c5c941848..120f031b6 100755
--- a/tests/generic/229
+++ b/tests/generic/229
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/230 b/tests/generic/230
index e49e0da25..ba95fbe72 100755
--- a/tests/generic/230
+++ b/tests/generic/230
@@ -14,8 +14,6 @@ _begin_fstest auto quota quick
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_user
@@ -94,7 +92,6 @@ cleanup_files()
 	rm -f $SCRATCH_MNT/file{1,2,3,4,5,6}
 }
 
-# real QA test starts here
 
 grace=2
 
diff --git a/tests/generic/231 b/tests/generic/231
index c2216659b..ef3ea45d4 100755
--- a/tests/generic/231
+++ b/tests/generic/231
@@ -40,8 +40,6 @@ _fsx()
 	return 0
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_user
diff --git a/tests/generic/232 b/tests/generic/232
index 4789de1e9..35934cc18 100755
--- a/tests/generic/232
+++ b/tests/generic/232
@@ -41,8 +41,6 @@ _fsstress()
 	fi
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 
diff --git a/tests/generic/233 b/tests/generic/233
index 358439d0a..b4c804ff2 100755
--- a/tests/generic/233
+++ b/tests/generic/233
@@ -51,8 +51,6 @@ _fsstress()
 	fi
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_user
diff --git a/tests/generic/234 b/tests/generic/234
index 8f127bb56..4b25fc650 100755
--- a/tests/generic/234
+++ b/tests/generic/234
@@ -61,12 +61,9 @@ test_setting()
 	echo "### done with testing"
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 
-# real QA test starts here
 
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
diff --git a/tests/generic/235 b/tests/generic/235
index 813f268a0..037c29e80 100755
--- a/tests/generic/235
+++ b/tests/generic/235
@@ -14,8 +14,6 @@ _begin_fstest auto quota quick
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_user
@@ -25,7 +23,6 @@ do_repquota()
 	repquota -u -g $SCRATCH_MNT  | grep -v -E '^root|^$' | _filter_scratch
 }
 
-# real QA test starts here
 
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
diff --git a/tests/generic/236 b/tests/generic/236
index 76e2810c3..f96f6bc42 100755
--- a/tests/generic/236
+++ b/tests/generic/236
@@ -18,8 +18,6 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_hardlinks
 _require_test
 
diff --git a/tests/generic/237 b/tests/generic/237
index a12a42590..266b3d690 100755
--- a/tests/generic/237
+++ b/tests/generic/237
@@ -22,8 +22,6 @@ _cleanup()
 	[ -n "$TEST_DIR" ] && rm -rf $TEST_DIR/$seq.dir1
 }
 
-# real QA test starts here
-_supported_fs generic
 # only Linux supports fallocate
 _require_test
 _require_runas
diff --git a/tests/generic/238 b/tests/generic/238
index c8d12c19d..4401a78ae 100755
--- a/tests/generic/238
+++ b/tests/generic/238
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/239 b/tests/generic/239
index dca2e16ac..82b31e7ea 100755
--- a/tests/generic/239
+++ b/tests/generic/239
@@ -20,7 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 
 _require_test
 _require_sparse_files
diff --git a/tests/generic/240 b/tests/generic/240
index 27b5119ec..a333873ec 100755
--- a/tests/generic/240
+++ b/tests/generic/240
@@ -19,7 +19,6 @@ _begin_fstest auto aio quick rw
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 
 _require_test
 _require_sparse_files
@@ -27,7 +26,6 @@ _require_aiodio aiodio_sparse2
 
 echo "Silence is golden."
 
-# real QA test starts here
 
 rm -f $TEST_DIR/aiodio_sparse
 
diff --git a/tests/generic/241 b/tests/generic/241
index 8abb525ee..d4bb5600e 100755
--- a/tests/generic/241
+++ b/tests/generic/241
@@ -14,14 +14,12 @@ _begin_fstest auto
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_test
 
 [ "$DBENCH_PROG" = "" ] && _notrun "dbench not found"
 
 echo "Silence is golden."
 
-# real QA test starts here
 
 rm -rf $TEST_DIR/dbench
 mkdir $TEST_DIR/dbench
diff --git a/tests/generic/242 b/tests/generic/242
index b6fd24902..b736763f4 100755
--- a/tests/generic/242
+++ b/tests/generic/242
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/243 b/tests/generic/243
index ca548e404..da4e22f59 100755
--- a/tests/generic/243
+++ b/tests/generic/243
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/244 b/tests/generic/244
index 504150777..b68035129 100755
--- a/tests/generic/244
+++ b/tests/generic/244
@@ -23,9 +23,7 @@ _cleanup()
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 
-_supported_fs generic
 _require_quota
 _require_scratch
 
diff --git a/tests/generic/245 b/tests/generic/245
index 81ce4d4e2..0bb2da05e 100755
--- a/tests/generic/245
+++ b/tests/generic/245
@@ -14,8 +14,6 @@ _begin_fstest auto quick dir
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 dir=$TEST_DIR/test-mv
diff --git a/tests/generic/246 b/tests/generic/246
index 4d474cd24..ee5afac60 100755
--- a/tests/generic/246
+++ b/tests/generic/246
@@ -15,8 +15,6 @@ _begin_fstest auto quick rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 file=$TEST_DIR/mmap-writev
diff --git a/tests/generic/247 b/tests/generic/247
index becc89e7b..47ff5c343 100755
--- a/tests/generic/247
+++ b/tests/generic/247
@@ -22,10 +22,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 
 # this test leaves a 512MB file around if we abort the test during the run via a
diff --git a/tests/generic/248 b/tests/generic/248
index 3c127a879..490895349 100755
--- a/tests/generic/248
+++ b/tests/generic/248
@@ -19,10 +19,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 
 TESTFILE=$TEST_DIR/test_file
diff --git a/tests/generic/249 b/tests/generic/249
index 61fcaf90e..560fdf71b 100755
--- a/tests/generic/249
+++ b/tests/generic/249
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 echo "Feel the serenity."
diff --git a/tests/generic/250 b/tests/generic/250
index 97e9522f6..196a34bb0 100755
--- a/tests/generic/250
+++ b/tests/generic/250
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch
 _require_dm_target error
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/251 b/tests/generic/251
index b7a15f918..b432fb119 100755
--- a/tests/generic/251
+++ b/tests/generic/251
@@ -21,8 +21,6 @@ mypid=$$
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
diff --git a/tests/generic/252 b/tests/generic/252
index 8c5adb534..39fa5531f 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch
 _require_dm_target error
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/253 b/tests/generic/253
index 7d09dd067..d1a79a3ee 100755
--- a/tests/generic/253
+++ b/tests/generic/253
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "truncate"
diff --git a/tests/generic/254 b/tests/generic/254
index e0e29da6f..5f50b9885 100755
--- a/tests/generic/254
+++ b/tests/generic/254
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone punch
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/255 b/tests/generic/255
index 39efb6b2a..902ca2ef6 100755
--- a/tests/generic/255
+++ b/tests/generic/255
@@ -13,9 +13,6 @@ _begin_fstest auto quick prealloc punch fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic 
-
 _require_test
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/256 b/tests/generic/256
index ea6cc2938..fe8be022a 100755
--- a/tests/generic/256
+++ b/tests/generic/256
@@ -14,8 +14,6 @@ _begin_fstest auto quick punch
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_xfs_io_command "fpunch"
 _require_scratch
diff --git a/tests/generic/257 b/tests/generic/257
index 4faa25948..93055cb8c 100755
--- a/tests/generic/257
+++ b/tests/generic/257
@@ -18,8 +18,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 mkdir $TEST_DIR/ttt
diff --git a/tests/generic/258 b/tests/generic/258
index 979889e2d..9e08efb77 100755
--- a/tests/generic/258
+++ b/tests/generic/258
@@ -13,8 +13,6 @@ _begin_fstest auto quick bigtime
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_negative_timestamps
 
diff --git a/tests/generic/259 b/tests/generic/259
index 46746c9f3..7d202c5f8 100755
--- a/tests/generic/259
+++ b/tests/generic/259
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone zero
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fzero"
diff --git a/tests/generic/260 b/tests/generic/260
index 08fde4687..b8597778e 100755
--- a/tests/generic/260
+++ b/tests/generic/260
@@ -17,8 +17,6 @@ mypid=$$
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_math
 
 _require_scratch
diff --git a/tests/generic/261 b/tests/generic/261
index 93c1c349b..1762e24d3 100755
--- a/tests/generic/261
+++ b/tests/generic/261
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone collapse
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fcollapse"
diff --git a/tests/generic/262 b/tests/generic/262
index 46e88f873..dfac679ba 100755
--- a/tests/generic/262
+++ b/tests/generic/262
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone insert
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "finsert"
diff --git a/tests/generic/263 b/tests/generic/263
index f4d290555..62eaec1d7 100755
--- a/tests/generic/263
+++ b/tests/generic/263
@@ -12,8 +12,6 @@ _begin_fstest rw auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_odirect
 
diff --git a/tests/generic/264 b/tests/generic/264
index 1a7ccc84c..593fbf50f 100755
--- a/tests/generic/264
+++ b/tests/generic/264
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone unshare
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "funshare"
diff --git a/tests/generic/265 b/tests/generic/265
index 8d0aab9a4..3c84e2a84 100755
--- a/tests/generic/265
+++ b/tests/generic/265
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/266 b/tests/generic/266
index 5438f0d44..d5675afbc 100755
--- a/tests/generic/266
+++ b/tests/generic/266
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/267 b/tests/generic/267
index 5a03957d4..ddaf1064c 100755
--- a/tests/generic/267
+++ b/tests/generic/267
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/268 b/tests/generic/268
index 659fb80a0..c6068cf4e 100755
--- a/tests/generic/268
+++ b/tests/generic/268
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/269 b/tests/generic/269
index 29f453735..341fcd22f 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -38,8 +38,6 @@ _workout()
 	wait $pid
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
diff --git a/tests/generic/270 b/tests/generic/270
index e7329c2f3..cf523f4ea 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -52,8 +52,6 @@ _workout()
 	$KILLALL_PROG -w $tmp.fsstress.bin
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_quota
 _require_user
 _require_scratch
diff --git a/tests/generic/271 b/tests/generic/271
index b77eed911..ce647d155 100755
--- a/tests/generic/271
+++ b/tests/generic/271
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/272 b/tests/generic/272
index 3b817cd8e..3d2cace9f 100755
--- a/tests/generic/272
+++ b/tests/generic/272
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/273 b/tests/generic/273
index 54c199962..e0ee0483a 100755
--- a/tests/generic/273
+++ b/tests/generic/273
@@ -116,8 +116,6 @@ _do_workload()
 	wait $_pids
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 
 echo "------------------------------"
diff --git a/tests/generic/274 b/tests/generic/274
index 8c0e420e8..d526a9b71 100755
--- a/tests/generic/274
+++ b/tests/generic/274
@@ -25,8 +25,6 @@ _cleanup()
 
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
 
diff --git a/tests/generic/275 b/tests/generic/275
index f3b054090..57de69b80 100755
--- a/tests/generic/275
+++ b/tests/generic/275
@@ -21,8 +21,6 @@ _cleanup()
 
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 
 # This test requires specific data space usage, skip if we have compression
diff --git a/tests/generic/276 b/tests/generic/276
index e304b3f18..3c3e75df6 100755
--- a/tests/generic/276
+++ b/tests/generic/276
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/277 b/tests/generic/277
index 792033273..1bf11fd7b 100755
--- a/tests/generic/277
+++ b/tests/generic/277
@@ -19,8 +19,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_chattr A
 
diff --git a/tests/generic/278 b/tests/generic/278
index 8de74bf7f..5d9778f9f 100755
--- a/tests/generic/278
+++ b/tests/generic/278
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/279 b/tests/generic/279
index 6d1ab0f22..f4dac950c 100755
--- a/tests/generic/279
+++ b/tests/generic/279
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/280 b/tests/generic/280
index 8e1ae4d29..3108fd23f 100755
--- a/tests/generic/280
+++ b/tests/generic/280
@@ -29,10 +29,8 @@ _require_scratch
 _require_quota
 _require_freeze
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 
 _scratch_unmount 2>/dev/null
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/generic/281 b/tests/generic/281
index f5a00de68..6d48c4b14 100755
--- a/tests/generic/281
+++ b/tests/generic/281
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/282 b/tests/generic/282
index f085a97e1..b3eb48063 100755
--- a/tests/generic/282
+++ b/tests/generic/282
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/283 b/tests/generic/283
index ed41c31b6..b9104fe64 100755
--- a/tests/generic/283
+++ b/tests/generic/283
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/284 b/tests/generic/284
index dc9b8a9d9..7a58b015a 100755
--- a/tests/generic/284
+++ b/tests/generic/284
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/285 b/tests/generic/285
index d18500212..d53bcfd72 100755
--- a/tests/generic/285
+++ b/tests/generic/285
@@ -16,7 +16,6 @@ _begin_fstest auto rw seek
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 
 _require_test
 _require_seek_data_hole
diff --git a/tests/generic/286 b/tests/generic/286
index 629cb55b2..fe3382f94 100755
--- a/tests/generic/286
+++ b/tests/generic/286
@@ -12,8 +12,6 @@ _begin_fstest auto quick other seek prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/287 b/tests/generic/287
index 14aea37ca..78d55434d 100755
--- a/tests/generic/287
+++ b/tests/generic/287
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/288 b/tests/generic/288
index 41eeb216f..193608d62 100755
--- a/tests/generic/288
+++ b/tests/generic/288
@@ -15,8 +15,6 @@ status=0
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 
diff --git a/tests/generic/289 b/tests/generic/289
index 3ce234c3d..549a7ec5d 100755
--- a/tests/generic/289
+++ b/tests/generic/289
@@ -21,7 +21,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/290 b/tests/generic/290
index 13e098788..841fcb8af 100755
--- a/tests/generic/290
+++ b/tests/generic/290
@@ -21,7 +21,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/291 b/tests/generic/291
index f61ae5a30..a47bfbabc 100755
--- a/tests/generic/291
+++ b/tests/generic/291
@@ -21,7 +21,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/292 b/tests/generic/292
index 40566ceca..d646d1e55 100755
--- a/tests/generic/292
+++ b/tests/generic/292
@@ -21,7 +21,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_odirect
diff --git a/tests/generic/293 b/tests/generic/293
index 99500b41e..3e66de161 100755
--- a/tests/generic/293
+++ b/tests/generic/293
@@ -22,7 +22,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/294 b/tests/generic/294
index 408cbd395..54b89a262 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -13,7 +13,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # NFS will optimize away the on-the-wire lookup before attempting to
 # create a new file (since that means an extra round trip).
diff --git a/tests/generic/295 b/tests/generic/295
index 7ab958036..3182ec47f 100755
--- a/tests/generic/295
+++ b/tests/generic/295
@@ -22,7 +22,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/296 b/tests/generic/296
index ab348acf3..431d2db52 100755
--- a/tests/generic/296
+++ b/tests/generic/296
@@ -14,7 +14,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/297 b/tests/generic/297
index 54c2ac214..317f34f6d 100755
--- a/tests/generic/297
+++ b/tests/generic/297
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_command "$TIMEOUT_PROG" "timeout"
diff --git a/tests/generic/298 b/tests/generic/298
index 115a9bf74..ba548a2a6 100755
--- a/tests/generic/298
+++ b/tests/generic/298
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_command "$TIMEOUT_PROG" "timeout"
diff --git a/tests/generic/299 b/tests/generic/299
index 0cd122029..63306681c 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -17,8 +17,6 @@ fio_out=$tmp.fio.out
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_odirect
diff --git a/tests/generic/300 b/tests/generic/300
index 5ff141d3d..2698cf035 100755
--- a/tests/generic/300
+++ b/tests/generic/300
@@ -17,8 +17,6 @@ fio_out=$tmp.fio.out
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_odirect
 _require_aio
diff --git a/tests/generic/301 b/tests/generic/301
index 3f895ff8e..0303f25d9 100755
--- a/tests/generic/301
+++ b/tests/generic/301
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/302 b/tests/generic/302
index 9c305abed..e6b463f09 100755
--- a/tests/generic/302
+++ b/tests/generic/302
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/303 b/tests/generic/303
index 95679569e..908b4a878 100755
--- a/tests/generic/303
+++ b/tests/generic/303
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_test_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/304 b/tests/generic/304
index 2261f2141..f742b4021 100755
--- a/tests/generic/304
+++ b/tests/generic/304
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_test_dedupe
 _require_cp_reflink
 
diff --git a/tests/generic/305 b/tests/generic/305
index b46d51274..c89bd821f 100755
--- a/tests/generic/305
+++ b/tests/generic/305
@@ -15,7 +15,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/reflink
 . ./common/quota
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/306 b/tests/generic/306
index d67185e89..a6ea654b6 100755
--- a/tests/generic/306
+++ b/tests/generic/306
@@ -20,10 +20,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_test
 _require_symlinks
diff --git a/tests/generic/307 b/tests/generic/307
index c4e213e10..1f00f797d 100755
--- a/tests/generic/307
+++ b/tests/generic/307
@@ -29,8 +29,6 @@ _cleanup()
 
 testfile=$SCRATCH_MNT/testfile.$seq
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_acls
 
diff --git a/tests/generic/308 b/tests/generic/308
index 6466d3327..8e6cadfb1 100755
--- a/tests/generic/308
+++ b/tests/generic/308
@@ -22,8 +22,6 @@ _cleanup()
 
 testfile=$TEST_DIR/testfile.$seq
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 echo "Silence is golden"
diff --git a/tests/generic/309 b/tests/generic/309
index bfd3e04f8..2701d7067 100755
--- a/tests/generic/309
+++ b/tests/generic/309
@@ -26,8 +26,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 echo "Silence is golden"
diff --git a/tests/generic/310 b/tests/generic/310
index a71d0ba7f..15e87aece 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -35,8 +35,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_command "$KILLALL_PROG" killall
 
diff --git a/tests/generic/311 b/tests/generic/311
index d83da5a4f..5d21752fe 100755
--- a/tests/generic/311
+++ b/tests/generic/311
@@ -30,8 +30,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_nocheck
 _require_odirect
 _require_dm_target flakey
diff --git a/tests/generic/312 b/tests/generic/312
index 1926deb83..bbf9031eb 100755
--- a/tests/generic/312
+++ b/tests/generic/312
@@ -15,8 +15,6 @@ _begin_fstest auto quick prealloc enospc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_xfs_io_command "falloc"
 _require_scratch
 
diff --git a/tests/generic/313 b/tests/generic/313
index d4b1256d6..d76b768fb 100755
--- a/tests/generic/313
+++ b/tests/generic/313
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 testfile=$TEST_DIR/testfile.$seq
diff --git a/tests/generic/314 b/tests/generic/314
index dd617089a..5fbc6424d 100755
--- a/tests/generic/314
+++ b/tests/generic/314
@@ -12,8 +12,6 @@ _begin_fstest auto quick perms
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_user
 _require_chown
diff --git a/tests/generic/315 b/tests/generic/315
index 3a87d330d..83f46655f 100755
--- a/tests/generic/315
+++ b/tests/generic/315
@@ -17,10 +17,8 @@ status=0	# success is the default!
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_xfs_io_command "falloc" "-k"
 
diff --git a/tests/generic/316 b/tests/generic/316
index 5b8901260..5f1d58a45 100755
--- a/tests/generic/316
+++ b/tests/generic/316
@@ -13,8 +13,6 @@ _begin_fstest auto quick punch fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/317 b/tests/generic/317
index 39cccc8bc..177d88525 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -27,8 +27,6 @@ _cleanup()
 
 file=$SCRATCH_MNT/file1
 
-# real QA test starts here
-_supported_fs generic
 # only Linux supports user namespace
 
 [ -x $lstat64 ] || _notrun "$lstat64 executable not found"
diff --git a/tests/generic/318 b/tests/generic/318
index 71ee76666..d31ad2b13 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -29,8 +29,6 @@ _cleanup()
 nsexec=$here/src/nsexec
 file=$SCRATCH_MNT/file1
 
-# real QA test starts here
-_supported_fs generic
 # only Linux supports user namespace
 
 _require_scratch
diff --git a/tests/generic/319 b/tests/generic/319
index 0efb46bed..1b3f93568 100755
--- a/tests/generic/319
+++ b/tests/generic/319
@@ -18,8 +18,6 @@ _begin_fstest acl auto quick perms
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_acls
 _require_scratch
 
diff --git a/tests/generic/320 b/tests/generic/320
index ea65537f3..33f0b8aef 100755
--- a/tests/generic/320
+++ b/tests/generic/320
@@ -18,8 +18,6 @@ _begin_fstest auto rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 
 threads=100
diff --git a/tests/generic/321 b/tests/generic/321
index e9fc6483d..73a892334 100755
--- a/tests/generic/321
+++ b/tests/generic/321
@@ -19,8 +19,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_nocheck
 _require_dm_target flakey
 
diff --git a/tests/generic/322 b/tests/generic/322
index bcdb48822..5cb77cbfa 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -19,8 +19,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_nocheck
 _require_dm_target flakey
 
diff --git a/tests/generic/323 b/tests/generic/323
index ffeeae40c..457253fee 100755
--- a/tests/generic/323
+++ b/tests/generic/323
@@ -15,9 +15,7 @@ _begin_fstest auto aio stress
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 
 _require_aiodio aio-last-ref-held-by-io
diff --git a/tests/generic/324 b/tests/generic/324
index 523d1f042..e3fa8fba0 100755
--- a/tests/generic/324
+++ b/tests/generic/324
@@ -15,7 +15,6 @@ PIDS=""
 . ./common/filter
 . ./common/defrag
 
-# real QA test starts here
 _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/325 b/tests/generic/325
index 0b2d5c6fd..8fbd0d1d9 100755
--- a/tests/generic/325
+++ b/tests/generic/325
@@ -28,8 +28,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/326 b/tests/generic/326
index f5c557b3a..1783fbf23 100755
--- a/tests/generic/326
+++ b/tests/generic/326
@@ -15,7 +15,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/reflink
 . ./common/quota
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/327 b/tests/generic/327
index 92540b19d..2323e1e6a 100755
--- a/tests/generic/327
+++ b/tests/generic/327
@@ -14,7 +14,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/reflink
 . ./common/quota
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/328 b/tests/generic/328
index db7fd3db4..0c8e19866 100755
--- a/tests/generic/328
+++ b/tests/generic/328
@@ -14,7 +14,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/reflink
 . ./common/quota
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/329 b/tests/generic/329
index c2ba3108f..e29a8ca4c 100755
--- a/tests/generic/329
+++ b/tests/generic/329
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/330 b/tests/generic/330
index 9cd7b8b19..83e1459fa 100755
--- a/tests/generic/330
+++ b/tests/generic/330
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_aiodio "aiocp"
diff --git a/tests/generic/331 b/tests/generic/331
index 492abedf7..c1949e1b9 100755
--- a/tests/generic/331
+++ b/tests/generic/331
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/generic/332 b/tests/generic/332
index 61147590e..4a61e4a02 100755
--- a/tests/generic/332
+++ b/tests/generic/332
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_aiodio "aiocp"
diff --git a/tests/generic/333 b/tests/generic/333
index bf1967ce2..03a7bcd0e 100755
--- a/tests/generic/333
+++ b/tests/generic/333
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_odirect
diff --git a/tests/generic/334 b/tests/generic/334
index b9c14b87a..3f9718476 100755
--- a/tests/generic/334
+++ b/tests/generic/334
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/335 b/tests/generic/335
index 196ada641..280cf8538 100755
--- a/tests/generic/335
+++ b/tests/generic/335
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/336 b/tests/generic/336
index ec9629ecf..478081978 100755
--- a/tests/generic/336
+++ b/tests/generic/336
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/337 b/tests/generic/337
index d0dffcb9b..a666cf921 100755
--- a/tests/generic/337
+++ b/tests/generic/337
@@ -14,8 +14,6 @@ _begin_fstest auto quick attr metadata
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_attrs
 
diff --git a/tests/generic/338 b/tests/generic/338
index a75577f22..d138c0239 100755
--- a/tests/generic/338
+++ b/tests/generic/338
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_nocheck # fs went down with a dirty log, don't check it
 _require_dm_target error
 # If SCRATCH_DEV is not a valid block device, FSTYP cannot be mkfs'ed either
diff --git a/tests/generic/339 b/tests/generic/339
index 4da10c55f..bf8f7729a 100755
--- a/tests/generic/339
+++ b/tests/generic/339
@@ -14,8 +14,6 @@ _begin_fstest auto dir
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_test_program "dirhash_collide"
 
diff --git a/tests/generic/340 b/tests/generic/340
index e4e3b5de6..631324f15 100755
--- a/tests/generic/340
+++ b/tests/generic/340
@@ -11,8 +11,6 @@ _begin_fstest auto
 
 # get standard environment and checks
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_test_program "holetest"
 
diff --git a/tests/generic/341 b/tests/generic/341
index a25835ec4..bea36e265 100755
--- a/tests/generic/341
+++ b/tests/generic/341
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/342 b/tests/generic/342
index cdffaaf3f..3f5aca673 100755
--- a/tests/generic/342
+++ b/tests/generic/342
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/343 b/tests/generic/343
index 9e21763aa..6659f1988 100755
--- a/tests/generic/343
+++ b/tests/generic/343
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/344 b/tests/generic/344
index 7a8aa8525..e6a3a5fe0 100755
--- a/tests/generic/344
+++ b/tests/generic/344
@@ -12,8 +12,6 @@ _begin_fstest auto
 
 # get standard environment and checks
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_test_program "holetest"
 
diff --git a/tests/generic/345 b/tests/generic/345
index def399980..cc1080f3f 100755
--- a/tests/generic/345
+++ b/tests/generic/345
@@ -11,8 +11,6 @@ _begin_fstest auto
 
 # get standard environment and checks
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_test_program "holetest"
 
diff --git a/tests/generic/346 b/tests/generic/346
index 009db54f1..89652ea56 100755
--- a/tests/generic/346
+++ b/tests/generic/346
@@ -11,8 +11,6 @@ _begin_fstest auto quick rw
 
 # get standard environment and checks
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_test_program "holetest"
 
diff --git a/tests/generic/347 b/tests/generic/347
index 6799b8dad..7e1ea5d90 100755
--- a/tests/generic/347
+++ b/tests/generic/347
@@ -49,7 +49,6 @@ _workout()
 # Import common functions.
 . ./common/dmthin
 
-_supported_fs generic
 _require_scratch_nocheck
 _require_dm_target thin-pool
 
diff --git a/tests/generic/348 b/tests/generic/348
index e938f8173..eb0587d20 100755
--- a/tests/generic/348
+++ b/tests/generic/348
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_symlinks
 _require_dm_target flakey
diff --git a/tests/generic/349 b/tests/generic/349
index da331b95f..72fbda412 100755
--- a/tests/generic/349
+++ b/tests/generic/349
@@ -16,7 +16,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/filter
 . ./common/scsi_debug
 
-# real QA test starts here
 _require_scsi_debug
 _require_xfs_io_command "fzero"
 
diff --git a/tests/generic/350 b/tests/generic/350
index d8b2f272b..6079a8d50 100755
--- a/tests/generic/350
+++ b/tests/generic/350
@@ -16,7 +16,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/filter
 . ./common/scsi_debug
 
-# real QA test starts here
 _require_scsi_debug
 _require_xfs_io_command "fpunch"
 
diff --git a/tests/generic/351 b/tests/generic/351
index c4e876752..e73b70e4d 100755
--- a/tests/generic/351
+++ b/tests/generic/351
@@ -19,7 +19,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/filter
 . ./common/scsi_debug
 
-# real QA test starts here
 _require_scsi_debug
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "finsert"
diff --git a/tests/generic/352 b/tests/generic/352
index 3a18f0760..838803ebd 100755
--- a/tests/generic/352
+++ b/tests/generic/352
@@ -18,10 +18,8 @@ _begin_fstest auto clone fiemap
 . ./common/reflink
 . ./common/punch
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "fiemap"
 
diff --git a/tests/generic/353 b/tests/generic/353
index c56397251..ac5b97880 100755
--- a/tests/generic/353
+++ b/tests/generic/353
@@ -19,10 +19,8 @@ _begin_fstest auto quick clone fiemap
 . ./common/reflink
 . ./common/punch
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "fiemap"
 
diff --git a/tests/generic/354 b/tests/generic/354
index 425a2f9d8..43d4705c5 100755
--- a/tests/generic/354
+++ b/tests/generic/354
@@ -12,8 +12,6 @@ _begin_fstest auto
 
 # get standard environment and checks
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_test_program "holetest"
 
diff --git a/tests/generic/355 b/tests/generic/355
index 7c108d1b8..b0f8fc45d 100755
--- a/tests/generic/355
+++ b/tests/generic/355
@@ -12,8 +12,6 @@ _begin_fstest auto quick perms
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_user
 _require_odirect
diff --git a/tests/generic/356 b/tests/generic/356
index ffc7bed53..c03414e5a 100755
--- a/tests/generic/356
+++ b/tests/generic/356
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_swapfile
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/generic/357 b/tests/generic/357
index 0f3e02d5b..8db31f8b0 100755
--- a/tests/generic/357
+++ b/tests/generic/357
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 
 # For NFS, a reflink is just a CLONE operation, and after that
 # point it's dealt with by the server.
diff --git a/tests/generic/358 b/tests/generic/358
index 91fe5e2b4..e4e0849d9 100755
--- a/tests/generic/358
+++ b/tests/generic/358
@@ -27,7 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 
 echo "Format and mount"
diff --git a/tests/generic/359 b/tests/generic/359
index 8ef4f846b..4b6bfa2de 100755
--- a/tests/generic/359
+++ b/tests/generic/359
@@ -29,7 +29,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 
 echo "Format and mount"
diff --git a/tests/generic/360 b/tests/generic/360
index 5fb227fff..e259bb616 100755
--- a/tests/generic/360
+++ b/tests/generic/360
@@ -12,8 +12,6 @@ _begin_fstest auto quick metadata
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_symlinks
 
diff --git a/tests/generic/361 b/tests/generic/361
index d76d2635b..c56157391 100755
--- a/tests/generic/361
+++ b/tests/generic/361
@@ -25,8 +25,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_block_device $SCRATCH_DEV
 _require_loop
diff --git a/tests/generic/371 b/tests/generic/371
index a2fdaf7bb..b312c4501 100755
--- a/tests/generic/371
+++ b/tests/generic/371
@@ -15,7 +15,6 @@ _begin_fstest auto quick enospc prealloc
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc"
 test "$FSTYP" = "xfs" && _require_xfs_io_command "extsize"
diff --git a/tests/generic/372 b/tests/generic/372
index dac51dec1..2b88c1518 100755
--- a/tests/generic/372
+++ b/tests/generic/372
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/373 b/tests/generic/373
index e85308c7f..3bd46963a 100755
--- a/tests/generic/373
+++ b/tests/generic/373
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/374 b/tests/generic/374
index f66d13970..acb23d172 100755
--- a/tests/generic/374
+++ b/tests/generic/374
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_dedupe
 
 echo "Format and mount"
diff --git a/tests/generic/375 b/tests/generic/375
index 438184b30..eb6751442 100755
--- a/tests/generic/375
+++ b/tests/generic/375
@@ -14,8 +14,6 @@ _begin_fstest auto quick acl perms
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_runas
 _require_acls
diff --git a/tests/generic/376 b/tests/generic/376
index 70491d2f8..cecd4e0d7 100755
--- a/tests/generic/376
+++ b/tests/generic/376
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/377 b/tests/generic/377
index 720ecf73c..add0b7bb9 100755
--- a/tests/generic/377
+++ b/tests/generic/377
@@ -13,8 +13,6 @@ _begin_fstest attr auto quick metadata
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_attrs
 _require_test_program "listxattr"
diff --git a/tests/generic/378 b/tests/generic/378
index 2caff94f3..5a6bd2b08 100755
--- a/tests/generic/378
+++ b/tests/generic/378
@@ -18,8 +18,6 @@ _begin_fstest auto quick metadata
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_user
 _require_hardlinks
diff --git a/tests/generic/379 b/tests/generic/379
index 007fc0d9e..4c7fc9393 100755
--- a/tests/generic/379
+++ b/tests/generic/379
@@ -21,8 +21,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs generic
 
 cp /dev/null $seqres.full
 chmod ugo+rwx $seqres.full
diff --git a/tests/generic/380 b/tests/generic/380
index 21b789dd2..8d772a96d 100755
--- a/tests/generic/380
+++ b/tests/generic/380
@@ -15,10 +15,8 @@ _begin_fstest quota auto quick
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 
 _require_scratch
 _require_quota
diff --git a/tests/generic/381 b/tests/generic/381
index 7519491ca..411c9c7d0 100755
--- a/tests/generic/381
+++ b/tests/generic/381
@@ -15,8 +15,6 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_xfs_quota_foreign
diff --git a/tests/generic/382 b/tests/generic/382
index 49775917b..162da41d4 100755
--- a/tests/generic/382
+++ b/tests/generic/382
@@ -20,8 +20,6 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_xfs_quota_foreign
diff --git a/tests/generic/383 b/tests/generic/383
index 91e27840c..21f084bde 100755
--- a/tests/generic/383
+++ b/tests/generic/383
@@ -15,8 +15,6 @@ qa_user=""
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_xfs_quota_foreign
diff --git a/tests/generic/384 b/tests/generic/384
index 8d93b781a..f23443802 100755
--- a/tests/generic/384
+++ b/tests/generic/384
@@ -22,8 +22,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_quota
diff --git a/tests/generic/385 b/tests/generic/385
index bbbf88163..ae10b285d 100755
--- a/tests/generic/385
+++ b/tests/generic/385
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_quota
diff --git a/tests/generic/386 b/tests/generic/386
index 0d902702f..f8e804cbb 100755
--- a/tests/generic/386
+++ b/tests/generic/386
@@ -27,12 +27,10 @@ qlimit_meg=500	# 500M limit imposed = 500 * 1024 * 1024 bytes
 
 echo "Silence is golden."
 
-# real QA test starts here
 
 proj_dir="$SCRATCH_MNT/test"
 
 # Modify as appropriate.
-_supported_fs generic
 
 _require_quota
 _require_xfs_quota_foreign
diff --git a/tests/generic/387 b/tests/generic/387
index 25ca86bbc..544e7552a 100755
--- a/tests/generic/387
+++ b/tests/generic/387
@@ -15,7 +15,6 @@ _begin_fstest auto clone
 . ./common/reflink
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch_reflink
 
 #btrfs needs 256mb to create default blockgroup fs
diff --git a/tests/generic/388 b/tests/generic/388
index 4a5be6698..89ddda31d 100755
--- a/tests/generic/388
+++ b/tests/generic/388
@@ -29,7 +29,6 @@ _cleanup()
 # Import common functions.
 
 # Modify as appropriate.
-_supported_fs generic
 
 _require_scratch
 _require_local_device $SCRATCH_DEV
diff --git a/tests/generic/389 b/tests/generic/389
index e59446f3a..949d5a1c8 100755
--- a/tests/generic/389
+++ b/tests/generic/389
@@ -14,8 +14,6 @@ _begin_fstest auto quick acl
 . ./common/attr
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_xfs_io_command "-T"
diff --git a/tests/generic/390 b/tests/generic/390
index 9a5feeb1c..02f6c5eef 100755
--- a/tests/generic/390
+++ b/tests/generic/390
@@ -26,11 +26,9 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 echo "Silence is golden"
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_freeze
 _require_test_program "feature"
diff --git a/tests/generic/391 b/tests/generic/391
index cd99ee2e3..d19c48262 100755
--- a/tests/generic/391
+++ b/tests/generic/391
@@ -22,9 +22,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 _require_xfs_io_command "falloc"
 _require_test_program "dio-interleaved"
diff --git a/tests/generic/392 b/tests/generic/392
index 0c9efb6df..da5ca260b 100755
--- a/tests/generic/392
+++ b/tests/generic/392
@@ -17,8 +17,6 @@ status=0	# failure will be detected in runtime!
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/393 b/tests/generic/393
index 206dee00e..ec91af188 100755
--- a/tests/generic/393
+++ b/tests/generic/393
@@ -22,7 +22,6 @@ _begin_fstest auto quick rw
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_scratch
 
 testfile=$SCRATCH_MNT/testfile
diff --git a/tests/generic/394 b/tests/generic/394
index cbc2ce130..39931de3f 100755
--- a/tests/generic/394
+++ b/tests/generic/394
@@ -26,8 +26,6 @@ do_truncate()
 	$XFS_IO_PROG -fc "truncate $1" $2
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 # set max file size to 1G (in block number of 1k blocks), so it should be big
diff --git a/tests/generic/395 b/tests/generic/395
index ab2ad6125..45787fff0 100755
--- a/tests/generic/395
+++ b/tests/generic/395
@@ -13,8 +13,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption
 _require_xfs_io_command "get_encpolicy"
 _require_user
diff --git a/tests/generic/396 b/tests/generic/396
index caa1d677a..2c5ee6f2c 100755
--- a/tests/generic/396
+++ b/tests/generic/396
@@ -14,8 +14,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption
 
 _scratch_mkfs_encrypted &>> $seqres.full
diff --git a/tests/generic/397 b/tests/generic/397
index 6c03f274d..f1306d451 100755
--- a/tests/generic/397
+++ b/tests/generic/397
@@ -17,8 +17,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_symlinks
 _require_scratch_encryption
 _require_command "$KEYCTL_PROG" keyctl
diff --git a/tests/generic/398 b/tests/generic/398
index e2cbad544..40d7b6e31 100755
--- a/tests/generic/398
+++ b/tests/generic/398
@@ -19,8 +19,6 @@ _begin_fstest auto quick encrypt
 . ./common/encrypt
 . ./common/renameat2
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption
 _require_renameat2 exchange
 
diff --git a/tests/generic/399 b/tests/generic/399
index a5aa7107d..f0a455915 100755
--- a/tests/generic/399
+++ b/tests/generic/399
@@ -23,8 +23,6 @@ _begin_fstest auto encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption
 _require_symlinks
 _require_command "$XZ_PROG" xz
diff --git a/tests/generic/400 b/tests/generic/400
index f9ec84cd4..77970da69 100755
--- a/tests/generic/400
+++ b/tests/generic/400
@@ -16,9 +16,7 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 
-_supported_fs generic
 _require_quota
 _require_scratch
 
diff --git a/tests/generic/401 b/tests/generic/401
index dc8e9fa68..672de2866 100755
--- a/tests/generic/401
+++ b/tests/generic/401
@@ -21,8 +21,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_symlinks
 _require_mknod
diff --git a/tests/generic/402 b/tests/generic/402
index 89afb9594..5feca4aa4 100755
--- a/tests/generic/402
+++ b/tests/generic/402
@@ -17,7 +17,6 @@ _begin_fstest auto quick rw bigtime
 . ./common/attr
 
 # Prerequisites for the test run.
-_supported_fs generic
 _require_scratch
 _require_check_dmesg
 _require_xfs_io_command utimes
diff --git a/tests/generic/403 b/tests/generic/403
index 6b07ccb0e..12159fa0e 100755
--- a/tests/generic/403
+++ b/tests/generic/403
@@ -14,10 +14,8 @@ _begin_fstest auto quick attr
 # Import common functions.
 . ./common/attr
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_attrs trusted
 
diff --git a/tests/generic/404 b/tests/generic/404
index ddbc04d59..f0ea1136e 100755
--- a/tests/generic/404
+++ b/tests/generic/404
@@ -61,10 +61,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "finsert"
diff --git a/tests/generic/405 b/tests/generic/405
index ab5a5523b..c90190c8d 100755
--- a/tests/generic/405
+++ b/tests/generic/405
@@ -27,8 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmthin
 
-# real QA test starts here
-_supported_fs generic
 # $SCRATCH_DEV won't be directly created filesystem on, so fsck isn't required
 _require_scratch_nocheck
 _require_dm_target thin-pool
diff --git a/tests/generic/406 b/tests/generic/406
index 49279a009..d36e833f5 100755
--- a/tests/generic/406
+++ b/tests/generic/406
@@ -16,10 +16,8 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_odirect
 
diff --git a/tests/generic/407 b/tests/generic/407
index 90ccaef0e..48b3e65ab 100755
--- a/tests/generic/407
+++ b/tests/generic/407
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_test_reflink
diff --git a/tests/generic/408 b/tests/generic/408
index c5e6e4137..010f44d99 100755
--- a/tests/generic/408
+++ b/tests/generic/408
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_test_dedupe
diff --git a/tests/generic/409 b/tests/generic/409
index 432befaca..b7edc2ac6 100755
--- a/tests/generic/409
+++ b/tests/generic/409
@@ -35,8 +35,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_local_device $SCRATCH_DEV
diff --git a/tests/generic/410 b/tests/generic/410
index 5fb5441a0..902f27144 100755
--- a/tests/generic/410
+++ b/tests/generic/410
@@ -43,8 +43,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_local_device $SCRATCH_DEV
diff --git a/tests/generic/411 b/tests/generic/411
index b2b8d550e..c35436c82 100755
--- a/tests/generic/411
+++ b/tests/generic/411
@@ -24,8 +24,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_local_device $SCRATCH_DEV
diff --git a/tests/generic/412 b/tests/generic/412
index f1778cf88..1c330f9dc 100755
--- a/tests/generic/412
+++ b/tests/generic/412
@@ -15,8 +15,6 @@ _begin_fstest auto quick metadata
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_odirect
 
diff --git a/tests/generic/413 b/tests/generic/413
index bd1b04a62..c9274e448 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -12,7 +12,6 @@ _begin_fstest auto quick dax prealloc
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_hugepages
 _require_test
 _require_scratch_dax_mountopt "dax"
diff --git a/tests/generic/414 b/tests/generic/414
index 684b2bf2e..a37e5b474 100755
--- a/tests/generic/414
+++ b/tests/generic/414
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/415 b/tests/generic/415
index c435e6263..119234503 100755
--- a/tests/generic/415
+++ b/tests/generic/415
@@ -15,8 +15,6 @@ status=0    # success is the default!
 # Import common functions.
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/416 b/tests/generic/416
index 0f6e3bc9a..31a85c83f 100755
--- a/tests/generic/416
+++ b/tests/generic/416
@@ -15,10 +15,8 @@ _begin_fstest auto enospc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 
 fs_size=$((128 * 1024 * 1024))
diff --git a/tests/generic/417 b/tests/generic/417
index 8923a6954..ed99c97f3 100755
--- a/tests/generic/417
+++ b/tests/generic/417
@@ -15,8 +15,6 @@ _begin_fstest auto quick shutdown log
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_scratch_shutdown
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/418 b/tests/generic/418
index 501b29120..4321e2984 100755
--- a/tests/generic/418
+++ b/tests/generic/418
@@ -20,8 +20,6 @@ _begin_fstest auto rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_odirect
 _require_block_device $TEST_DEV
diff --git a/tests/generic/419 b/tests/generic/419
index 5d56d64fc..ffc173fae 100755
--- a/tests/generic/419
+++ b/tests/generic/419
@@ -18,8 +18,6 @@ _begin_fstest auto quick encrypt
 . ./common/encrypt
 . ./common/renameat2
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption
 _require_command "$KEYCTL_PROG" keyctl
 _require_renameat2 exchange
diff --git a/tests/generic/420 b/tests/generic/420
index 5c67490db..edd9655fd 100755
--- a/tests/generic/420
+++ b/tests/generic/420
@@ -13,10 +13,8 @@ _begin_fstest auto quick punch
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_xfs_io_command fpunch
 
diff --git a/tests/generic/421 b/tests/generic/421
index 0c4fa8e3e..6eeae6075 100755
--- a/tests/generic/421
+++ b/tests/generic/421
@@ -15,8 +15,6 @@ _begin_fstest auto quick encrypt dangerous
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption
 _require_command "$KEYCTL_PROG" keyctl
 
diff --git a/tests/generic/422 b/tests/generic/422
index 455d7aeb6..71a0e5a86 100755
--- a/tests/generic/422
+++ b/tests/generic/422
@@ -14,8 +14,6 @@ _begin_fstest auto quick prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
diff --git a/tests/generic/423 b/tests/generic/423
index 69c1c3bce..9d41f7a8f 100755
--- a/tests/generic/423
+++ b/tests/generic/423
@@ -20,10 +20,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_test_program "stat_test"
 _require_test_program "af_unix"
diff --git a/tests/generic/424 b/tests/generic/424
index 0ed0e4aaa..e54babf50 100755
--- a/tests/generic/424
+++ b/tests/generic/424
@@ -21,10 +21,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_test_program stat_test
 _require_statx
diff --git a/tests/generic/425 b/tests/generic/425
index b43294f92..3367a9567 100755
--- a/tests/generic/425
+++ b/tests/generic/425
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 
 [ $FSTYP = bcachefs ] && _notrun "bcachefs does not store xattrs in blocks"
 
diff --git a/tests/generic/426 b/tests/generic/426
index 45e4a6d83..25909f220 100755
--- a/tests/generic/426
+++ b/tests/generic/426
@@ -13,10 +13,8 @@ _begin_fstest auto quick exportfs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 # _require_exportfs already requires open_by_handle, but let's not count on it
 _require_test_program "open_by_handle"
diff --git a/tests/generic/427 b/tests/generic/427
index 26385d36e..bddfdb871 100755
--- a/tests/generic/427
+++ b/tests/generic/427
@@ -14,10 +14,8 @@ _begin_fstest auto quick aio rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_test_program "feature"
 _require_aiodio aio-dio-eof-race
diff --git a/tests/generic/428 b/tests/generic/428
index 4073afc4a..c2c787783 100755
--- a/tests/generic/428
+++ b/tests/generic/428
@@ -15,11 +15,9 @@ _begin_fstest auto quick dax
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_test_program "t_mmap_stale_pmd"
 
-# real QA test starts here
 $here/src/t_mmap_stale_pmd $TEST_DIR/testfile
 
 # success, all done
diff --git a/tests/generic/429 b/tests/generic/429
index 2cf12316d..345d5caaf 100755
--- a/tests/generic/429
+++ b/tests/generic/429
@@ -26,8 +26,6 @@ _begin_fstest auto encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption
 _require_command "$KEYCTL_PROG" keyctl
 _require_test_program "t_encrypted_d_revalidate"
diff --git a/tests/generic/430 b/tests/generic/430
index 697c83cec..4411e5449 100755
--- a/tests/generic/430
+++ b/tests/generic/430
@@ -16,8 +16,6 @@ _begin_fstest auto quick copy_range
 # get standard environment
 . common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_xfs_io_command "copy_range"
 _require_test
diff --git a/tests/generic/431 b/tests/generic/431
index 0ec398c79..876e49f59 100755
--- a/tests/generic/431
+++ b/tests/generic/431
@@ -13,8 +13,6 @@ _begin_fstest auto quick copy_range
 # get standard environment
 . common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_xfs_io_command "copy_range"
 _require_test
diff --git a/tests/generic/432 b/tests/generic/432
index 402c5f231..2b0b4dce6 100755
--- a/tests/generic/432
+++ b/tests/generic/432
@@ -15,8 +15,6 @@ _begin_fstest auto quick copy_range
 # get standard environment
 . common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_xfs_io_command "copy_range"
 _require_test
diff --git a/tests/generic/433 b/tests/generic/433
index 0d26a64c6..6f0a0c5a6 100755
--- a/tests/generic/433
+++ b/tests/generic/433
@@ -15,8 +15,6 @@ _begin_fstest auto quick copy_range
 # get standard environment
 . common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_xfs_io_command "copy_range"
 _require_test
diff --git a/tests/generic/434 b/tests/generic/434
index fbd9e4088..5404eedb2 100755
--- a/tests/generic/434
+++ b/tests/generic/434
@@ -11,8 +11,6 @@ _begin_fstest auto quick copy_range
 # get standard environment
 . common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_xfs_io_command "copy_range"
 _require_test
diff --git a/tests/generic/435 b/tests/generic/435
index bb1cbb62b..05a4590f2 100755
--- a/tests/generic/435
+++ b/tests/generic/435
@@ -22,8 +22,6 @@ _begin_fstest auto encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption
 _require_command "$KEYCTL_PROG" keyctl
 
diff --git a/tests/generic/436 b/tests/generic/436
index d54af436e..0d13e0909 100755
--- a/tests/generic/436
+++ b/tests/generic/436
@@ -22,7 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 
 _require_test
 _require_seek_data_hole
diff --git a/tests/generic/437 b/tests/generic/437
index 1bfc6dbcf..afba47311 100755
--- a/tests/generic/437
+++ b/tests/generic/437
@@ -16,11 +16,9 @@ _begin_fstest auto quick dax
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_test_program "t_mmap_cow_race"
 
-# real QA test starts here
 $here/src/t_mmap_cow_race $TEST_DIR/testfile
 
 # success, all done
diff --git a/tests/generic/438 b/tests/generic/438
index 60a76eaef..df9c23d26 100755
--- a/tests/generic/438
+++ b/tests/generic/438
@@ -28,11 +28,9 @@ _cleanup()
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_test_program "t_mmap_fallocate"
 
-# real QA test starts here
 FILE=$TEST_DIR/testfile_fallocate
 # Make sure file exists
 echo >$FILE
diff --git a/tests/generic/439 b/tests/generic/439
index 4a4f821f7..5c502359e 100755
--- a/tests/generic/439
+++ b/tests/generic/439
@@ -16,8 +16,6 @@ _begin_fstest auto quick punch
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/440 b/tests/generic/440
index 5850a8fef..1c8e3e8f3 100755
--- a/tests/generic/440
+++ b/tests/generic/440
@@ -18,8 +18,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption
 _require_symlinks
 _require_command "$KEYCTL_PROG" keyctl
diff --git a/tests/generic/441 b/tests/generic/441
index 85f29a3a8..9851ac219 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch
 
 # Generally, we want to avoid journal errors on the extended testcase. Only
diff --git a/tests/generic/442 b/tests/generic/442
index c57a05672..c1182b5ad 100755
--- a/tests/generic/442
+++ b/tests/generic/442
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch
 _require_dm_target error
 _require_test_program fsync-err
diff --git a/tests/generic/443 b/tests/generic/443
index 16baf14da..0667f69cf 100755
--- a/tests/generic/443
+++ b/tests/generic/443
@@ -12,8 +12,6 @@ _begin_fstest auto quick rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_test_program "writev_on_pagefault"
 
diff --git a/tests/generic/444 b/tests/generic/444
index 71d2f6af0..31e0e43eb 100755
--- a/tests/generic/444
+++ b/tests/generic/444
@@ -14,8 +14,6 @@ _begin_fstest auto quick acl perms
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_runas
 _require_acls
diff --git a/tests/generic/445 b/tests/generic/445
index d9e9f84b0..5784bee12 100755
--- a/tests/generic/445
+++ b/tests/generic/445
@@ -22,7 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 
 _require_test
 _require_seek_data_hole
diff --git a/tests/generic/446 b/tests/generic/446
index b69502cbf..c0d32e4ea 100755
--- a/tests/generic/446
+++ b/tests/generic/446
@@ -17,7 +17,6 @@ _begin_fstest auto quick rw punch
 # get standard environment and checks
 . ./common/filter
 
-# real QA test starts here
 _require_scratch
 _require_xfs_io_command "truncate"
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/447 b/tests/generic/447
index 16b814ee7..6a1d486d6 100755
--- a/tests/generic/447
+++ b/tests/generic/447
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 _require_test_program "punch-alternating"
diff --git a/tests/generic/448 b/tests/generic/448
index 11945549b..ba540a261 100755
--- a/tests/generic/448
+++ b/tests/generic/448
@@ -21,7 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 
 _require_test
 _require_seek_data_hole
diff --git a/tests/generic/449 b/tests/generic/449
index 2b77a6a49..9cf814ad3 100755
--- a/tests/generic/449
+++ b/tests/generic/449
@@ -15,10 +15,8 @@ _begin_fstest auto quick acl attr enospc
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_test
 _require_acls
diff --git a/tests/generic/450 b/tests/generic/450
index 160097cff..96e559da6 100755
--- a/tests/generic/450
+++ b/tests/generic/450
@@ -27,8 +27,6 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_odirect
 
diff --git a/tests/generic/451 b/tests/generic/451
index 1792383ab..f45d1ba70 100755
--- a/tests/generic/451
+++ b/tests/generic/451
@@ -12,8 +12,6 @@ _begin_fstest auto quick rw aio
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_test_program "feature"
 _require_aiodio aio-dio-cycle-write
diff --git a/tests/generic/452 b/tests/generic/452
index 6e14a1c4e..a19a79623 100755
--- a/tests/generic/452
+++ b/tests/generic/452
@@ -15,13 +15,11 @@ _begin_fstest auto quick dax
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 
 # we need to be able to execute binaries on scratch
 _exclude_scratch_mount_option "noexec"
 
-# real QA test starts here
 # format and mount
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
diff --git a/tests/generic/455 b/tests/generic/455
index 6dce8a659..31f84346d 100755
--- a/tests/generic/455
+++ b/tests/generic/455
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/dmthin
 . ./common/dmlogwrites
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch_nocheck
 _require_no_logdev
diff --git a/tests/generic/456 b/tests/generic/456
index a77ff4e8b..0123508ce 100755
--- a/tests/generic/456
+++ b/tests/generic/456
@@ -29,8 +29,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc"
 _require_dm_target flakey
diff --git a/tests/generic/457 b/tests/generic/457
index 03aeb8147..defa73cfb 100755
--- a/tests/generic/457
+++ b/tests/generic/457
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/dmthin
 . ./common/dmlogwrites
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch_reflink
 _require_no_logdev
diff --git a/tests/generic/458 b/tests/generic/458
index 5a6a7e103..8acec6878 100755
--- a/tests/generic/458
+++ b/tests/generic/458
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone collapse insert zero
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fzero"
diff --git a/tests/generic/459 b/tests/generic/459
index c3f0b2b06..98177f6b5 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -36,11 +36,9 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
 
 # This tests for filesystem lockup not consistency, so don't check for fs
 # consistency after test
-_supported_fs generic
 _require_scratch_nolvm
 _require_dm_target thin-pool
 _require_dm_target snapshot
diff --git a/tests/generic/460 b/tests/generic/460
index 68720d3a9..5e855f9ba 100755
--- a/tests/generic/460
+++ b/tests/generic/460
@@ -56,8 +56,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 # test with scratch device, because test is known to corrupt fs, we don't want
 # the corruption affect subsequent tests
 _require_scratch
diff --git a/tests/generic/461 b/tests/generic/461
index 24d4ae2ef..468ce46f0 100755
--- a/tests/generic/461
+++ b/tests/generic/461
@@ -22,8 +22,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch_nocheck
 _require_scratch_shutdown
diff --git a/tests/generic/462 b/tests/generic/462
index eb44553b4..42f18ad2f 100755
--- a/tests/generic/462
+++ b/tests/generic/462
@@ -18,7 +18,6 @@ _begin_fstest auto quick dax
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_scratch_dax_mountopt "dax"
 _require_test_program "t_mmap_write_ro"
@@ -26,7 +25,6 @@ _require_test_program "t_mmap_write_ro"
 # this bug, just trying to test more.
 _require_user
 
-# real QA test starts here
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount "-o dax"
diff --git a/tests/generic/463 b/tests/generic/463
index 719e98c5f..2e9306ceb 100755
--- a/tests/generic/463
+++ b/tests/generic/463
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-_supported_fs generic
 
 _require_test
 _require_test_reflink
diff --git a/tests/generic/464 b/tests/generic/464
index cf9caac23..f114208f9 100755
--- a/tests/generic/464
+++ b/tests/generic/464
@@ -55,8 +55,6 @@ do_writeback()
 	$XFS_IO_PROG -c "sync_range -w 0 0" `getfile` >/dev/null 2>&1
 }
 
-# real QA test starts here
-_supported_fs generic
 # do fsck after each iteration in test
 _require_scratch_nocheck
 _require_xfs_io_command "sync_range"
diff --git a/tests/generic/465 b/tests/generic/465
index 0745d6a1d..eba3629ab 100755
--- a/tests/generic/465
+++ b/tests/generic/465
@@ -20,7 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _supported_fs ^nfs
 
 _require_aiodio aio-dio-append-write-read-race
diff --git a/tests/generic/466 b/tests/generic/466
index 05bfd5012..640832906 100755
--- a/tests/generic/466
+++ b/tests/generic/466
@@ -12,8 +12,6 @@ _begin_fstest auto quick rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_nocheck
 _require_block_device $SCRATCH_DEV
 
diff --git a/tests/generic/467 b/tests/generic/467
index 2a86ea76c..c48f9d554 100755
--- a/tests/generic/467
+++ b/tests/generic/467
@@ -18,10 +18,8 @@ _begin_fstest auto quick exportfs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 # _require_exportfs already requires open_by_handle, but let's not count on it
 _require_test_program "open_by_handle"
diff --git a/tests/generic/468 b/tests/generic/468
index f8d537f94..5471b7df2 100755
--- a/tests/generic/468
+++ b/tests/generic/468
@@ -23,8 +23,6 @@ _begin_fstest shutdown auto quick metadata prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/469 b/tests/generic/469
index 81573972e..1352c3243 100755
--- a/tests/generic/469
+++ b/tests/generic/469
@@ -28,8 +28,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_xfs_io_command "falloc" "-k"
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/470 b/tests/generic/470
index 6da2ec22b..aef262c87 100755
--- a/tests/generic/470
+++ b/tests/generic/470
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmlogwrites
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_no_logdev
 _require_log_writes_dax_mountopt "dax"
diff --git a/tests/generic/471 b/tests/generic/471
index 6d40d0e23..e98e3f00c 100755
--- a/tests/generic/471
+++ b/tests/generic/471
@@ -20,7 +20,6 @@ _cleanup()
 	rm -fr $target_dir
 }
 
-_supported_fs generic
 _require_test
 _require_test_program rewinddir-test
 
diff --git a/tests/generic/472 b/tests/generic/472
index 7d11ba370..70b580a84 100755
--- a/tests/generic/472
+++ b/tests/generic/472
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_swapfile
 _require_test_program mkswap
 _require_test_program swapon
diff --git a/tests/generic/473 b/tests/generic/473
index 125b95183..92cb7e2a2 100755
--- a/tests/generic/473
+++ b/tests/generic/473
@@ -14,7 +14,6 @@ _begin_fstest broken fiemap
 # Import common functions.
 . ./common/punch
 
-# real QA test starts here
 
 # Modify as appropriate.
 _require_test
diff --git a/tests/generic/474 b/tests/generic/474
index 69fb49b5c..2fa087a87 100755
--- a/tests/generic/474
+++ b/tests/generic/474
@@ -21,9 +21,7 @@ status=0
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_fssum
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/475 b/tests/generic/475
index ce7fe013b..4b854f9ab 100755
--- a/tests/generic/475
+++ b/tests/generic/475
@@ -28,7 +28,6 @@ _cleanup()
 . ./common/dmerror
 
 # Modify as appropriate.
-_supported_fs generic
 
 _require_scratch
 _require_dm_target error
diff --git a/tests/generic/476 b/tests/generic/476
index b1ae4df4d..cf7402a12 100755
--- a/tests/generic/476
+++ b/tests/generic/476
@@ -21,7 +21,6 @@ _cleanup()
 # Import common functions.
 
 # Modify as appropriate.
-_supported_fs generic
 
 _require_scratch
 _require_command "$KILLALL_PROG" "killall"
diff --git a/tests/generic/477 b/tests/generic/477
index d1fce7ed9..42e7bf9c9 100755
--- a/tests/generic/477
+++ b/tests/generic/477
@@ -15,10 +15,8 @@ _begin_fstest auto quick exportfs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 # _require_exportfs already requires open_by_handle, but let's not count on it
 _require_test_program "open_by_handle"
diff --git a/tests/generic/478 b/tests/generic/478
index 419acc945..42b4bb933 100755
--- a/tests/generic/478
+++ b/tests/generic/478
@@ -90,11 +90,9 @@ _begin_fstest auto quick
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_ofd_locks
 
-# real QA test starts here
 # prepare a 4k testfile in TEST_DIR
 $XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
 	$TEST_DIR/testfile >> $seqres.full 2>&1
diff --git a/tests/generic/479 b/tests/generic/479
index 9322a33a7..7f4aab4e7 100755
--- a/tests/generic/479
+++ b/tests/generic/479
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_symlinks
 _require_mknod
diff --git a/tests/generic/480 b/tests/generic/480
index 2805a3ac1..975c990ff 100755
--- a/tests/generic/480
+++ b/tests/generic/480
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/481 b/tests/generic/481
index 11d4da6e1..5c980cf01 100755
--- a/tests/generic/481
+++ b/tests/generic/481
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/482 b/tests/generic/482
index c647d24c2..04026c4c0 100755
--- a/tests/generic/482
+++ b/tests/generic/482
@@ -44,10 +44,8 @@ _cleanup()
 . ./common/dmthin
 . ./common/dmlogwrites
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 
 _require_no_logdev
 _require_command "$KILLALL_PROG" killall
diff --git a/tests/generic/483 b/tests/generic/483
index 2b35f2856..60f9b1097 100755
--- a/tests/generic/483
+++ b/tests/generic/483
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/dmflakey
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 _require_xfs_io_command "falloc" "-k"
diff --git a/tests/generic/484 b/tests/generic/484
index 4f413352b..09c2c5598 100755
--- a/tests/generic/484
+++ b/tests/generic/484
@@ -29,7 +29,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_nocheck
 _require_dm_target error
 _require_xfs_io_command "syncfs"
diff --git a/tests/generic/485 b/tests/generic/485
index 8bab450ba..36b13a7ae 100755
--- a/tests/generic/485
+++ b/tests/generic/485
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_math
 _require_xfs_io_command "falloc" "-k"
diff --git a/tests/generic/486 b/tests/generic/486
index 7dbfcb983..cb9b9783c 100755
--- a/tests/generic/486
+++ b/tests/generic/486
@@ -27,8 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_test_program "attr_replace_test"
 _require_attrs
 _require_scratch
diff --git a/tests/generic/487 b/tests/generic/487
index 3c9b22332..364f7eb4c 100755
--- a/tests/generic/487
+++ b/tests/generic/487
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
 _require_scratch_nocheck
 
 sflag='-s'
diff --git a/tests/generic/488 b/tests/generic/488
index 7b9dcc18f..0a7e3a4b0 100755
--- a/tests/generic/488
+++ b/tests/generic/488
@@ -12,7 +12,6 @@ _begin_fstest auto quick
 
 . ./common/filter
 
-_supported_fs generic
 _require_scratch
 _require_test_program "multi_open_unlink"
 
diff --git a/tests/generic/489 b/tests/generic/489
index ec42950c7..62aa45a86 100755
--- a/tests/generic/489
+++ b/tests/generic/489
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/dmflakey
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 _require_attrs
diff --git a/tests/generic/490 b/tests/generic/490
index f4fb67be2..56eafd7b4 100755
--- a/tests/generic/490
+++ b/tests/generic/490
@@ -15,7 +15,6 @@ _begin_fstest auto quick rw seek
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 
 _require_test
 _require_seek_data_hole
diff --git a/tests/generic/491 b/tests/generic/491
index 5a586c122..f5030a183 100755
--- a/tests/generic/491
+++ b/tests/generic/491
@@ -24,8 +24,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_freeze
 _require_command "$TIMEOUT_PROG" "timeout"
diff --git a/tests/generic/492 b/tests/generic/492
index c488c8bab..51a46b510 100755
--- a/tests/generic/492
+++ b/tests/generic/492
@@ -12,9 +12,7 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "label"
 _require_label_get_max
diff --git a/tests/generic/493 b/tests/generic/493
index c2fd72f64..bf977b183 100755
--- a/tests/generic/493
+++ b/tests/generic/493
@@ -12,7 +12,6 @@ _begin_fstest auto quick swap dedupe
 . ./common/filter
 . ./common/reflink
 
-_supported_fs generic
 _require_scratch_swapfile
 _require_scratch_dedupe
 
diff --git a/tests/generic/494 b/tests/generic/494
index b41c938d1..f1731e51a 100755
--- a/tests/generic/494
+++ b/tests/generic/494
@@ -11,7 +11,6 @@ _begin_fstest auto quick swap punch
 
 . ./common/filter
 
-_supported_fs generic
 _require_scratch_swapfile
 _require_xfs_io_command "fpunch"
 
diff --git a/tests/generic/495 b/tests/generic/495
index 84547f182..dd18693b2 100755
--- a/tests/generic/495
+++ b/tests/generic/495
@@ -12,7 +12,6 @@ _begin_fstest auto quick swap
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_scratch_swapfile
 _require_test_program mkswap
 _require_test_program swapon
diff --git a/tests/generic/496 b/tests/generic/496
index 12f1bc4f9..344a4f5b0 100755
--- a/tests/generic/496
+++ b/tests/generic/496
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_swapfile
 _require_test_program mkswap
 _require_test_program swapon
diff --git a/tests/generic/497 b/tests/generic/497
index 05e368ab6..53ae0424e 100755
--- a/tests/generic/497
+++ b/tests/generic/497
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_swapfile
 _require_test_program mkswap
 _require_test_program swapon
diff --git a/tests/generic/498 b/tests/generic/498
index 5ba213999..f58c9ed51 100755
--- a/tests/generic/498
+++ b/tests/generic/498
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/499 b/tests/generic/499
index 4b39c48b7..9145c1c5d 100755
--- a/tests/generic/499
+++ b/tests/generic/499
@@ -13,8 +13,6 @@ _begin_fstest auto quick rw collapse zero prealloc
 # Import common functions.
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
 _require_xfs_io_command "fcollapse"
diff --git a/tests/generic/500 b/tests/generic/500
index 1151c8f23..ba6e902ec 100755
--- a/tests/generic/500
+++ b/tests/generic/500
@@ -34,7 +34,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmthin
 
-# real QA test starts here
 _require_scratch_nocheck
 _require_dm_target thin-pool
 
diff --git a/tests/generic/501 b/tests/generic/501
index cb158ba56..4444016bc 100755
--- a/tests/generic/501
+++ b/tests/generic/501
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_dm_target flakey
 
diff --git a/tests/generic/502 b/tests/generic/502
index b5589b813..f6374f677 100755
--- a/tests/generic/502
+++ b/tests/generic/502
@@ -26,8 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/503 b/tests/generic/503
index a01d33272..f9796e694 100755
--- a/tests/generic/503
+++ b/tests/generic/503
@@ -20,7 +20,6 @@ _begin_fstest auto quick dax punch collapse zero prealloc
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_scratch
 _require_test_program "t_mmap_collision"
@@ -42,7 +41,6 @@ blksize=$(_get_file_block_size $SCRATCH_MNT)
 test $blksize -eq $(getconf PAGE_SIZE) || \
 	_notrun "file block size must match page size"
 
-# real QA test starts here
 $here/src/t_mmap_collision $TEST_DIR/testfile $SCRATCH_MNT/testfile
 
 # success, all done
diff --git a/tests/generic/504 b/tests/generic/504
index 038ab0f2c..271c040e7 100755
--- a/tests/generic/504
+++ b/tests/generic/504
@@ -24,8 +24,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_command "$FLOCK_PROG" "flock"
 
diff --git a/tests/generic/505 b/tests/generic/505
index 5b6a9b905..a25967352 100755
--- a/tests/generic/505
+++ b/tests/generic/505
@@ -23,8 +23,6 @@ _begin_fstest shutdown auto quick metadata
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/506 b/tests/generic/506
index d4aac68ba..9a41e5634 100755
--- a/tests/generic/506
+++ b/tests/generic/506
@@ -23,8 +23,6 @@ _begin_fstest shutdown auto quick metadata quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_quota
diff --git a/tests/generic/507 b/tests/generic/507
index 6a4a38336..6678e50f7 100755
--- a/tests/generic/507
+++ b/tests/generic/507
@@ -36,8 +36,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_command "$LSATTR_PROG" lasttr
 _require_command "$CHATTR_PROG" chattr
diff --git a/tests/generic/508 b/tests/generic/508
index 46649340a..4e234160d 100755
--- a/tests/generic/508
+++ b/tests/generic/508
@@ -23,8 +23,6 @@ _begin_fstest shutdown auto quick metadata
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test_lsattr
 _require_statx
diff --git a/tests/generic/509 b/tests/generic/509
index 26010de35..5025c0d74 100755
--- a/tests/generic/509
+++ b/tests/generic/509
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "-T"
 _require_dm_target flakey
diff --git a/tests/generic/510 b/tests/generic/510
index 20bd87ee1..5ea0e0677 100755
--- a/tests/generic/510
+++ b/tests/generic/510
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/511 b/tests/generic/511
index 61c21e42c..7c903fb02 100755
--- a/tests/generic/511
+++ b/tests/generic/511
@@ -13,8 +13,6 @@ _begin_fstest auto quick rw zero prealloc
 # Import common functions.
 . ./common/punch
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
 _require_xfs_io_command "fzero"
diff --git a/tests/generic/512 b/tests/generic/512
index ec367405f..8965d9d63 100755
--- a/tests/generic/512
+++ b/tests/generic/512
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc"
 _require_dm_target flakey
diff --git a/tests/generic/513 b/tests/generic/513
index 7ff845cea..7f870b5dd 100755
--- a/tests/generic/513
+++ b/tests/generic/513
@@ -14,8 +14,6 @@ _begin_fstest auto quick clone
 . ./common/reflink
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
diff --git a/tests/generic/514 b/tests/generic/514
index 5b8377181..7f3d9c16c 100755
--- a/tests/generic/514
+++ b/tests/generic/514
@@ -13,8 +13,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_user
 
diff --git a/tests/generic/515 b/tests/generic/515
index 1d537dec7..370339551 100755
--- a/tests/generic/515
+++ b/tests/generic/515
@@ -16,8 +16,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/516 b/tests/generic/516
index 47af6237e..b8d1753aa 100755
--- a/tests/generic/516
+++ b/tests/generic/516
@@ -22,7 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_dedupe
 
 testdir=$TEST_DIR/test-$seq
diff --git a/tests/generic/517 b/tests/generic/517
index cf3031ed2..3f7027a85 100755
--- a/tests/generic/517
+++ b/tests/generic/517
@@ -15,8 +15,6 @@ _begin_fstest auto quick dedupe clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_dedupe
 
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/generic/518 b/tests/generic/518
index f3cb5868c..20773bae8 100755
--- a/tests/generic/518
+++ b/tests/generic/518
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/generic/519 b/tests/generic/519
index 0839c6b85..3539b19bf 100755
--- a/tests/generic/519
+++ b/tests/generic/519
@@ -13,8 +13,6 @@ _begin_fstest auto quick fiemap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_fibmap
 _require_filefrag_options "es"
diff --git a/tests/generic/520 b/tests/generic/520
index ad6764c73..00fa050e2 100755
--- a/tests/generic/520
+++ b/tests/generic/520
@@ -27,8 +27,6 @@ _cleanup()
 # 256MB in byte
 fssize=$((2**20 * 256))
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_nocheck
 _require_dm_target flakey
 
diff --git a/tests/generic/521 b/tests/generic/521
index 0956e5017..24eab8342 100755
--- a/tests/generic/521
+++ b/tests/generic/521
@@ -12,10 +12,8 @@ _begin_fstest soak long_rw smoketest
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_odirect
 
diff --git a/tests/generic/522 b/tests/generic/522
index 0e4e6009e..bdc77cbf2 100755
--- a/tests/generic/522
+++ b/tests/generic/522
@@ -12,10 +12,8 @@ _begin_fstest soak long_rw smoketest
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 
 # Run fsx for a million ops or more
diff --git a/tests/generic/523 b/tests/generic/523
index 0792a39ff..c1e91205a 100755
--- a/tests/generic/523
+++ b/tests/generic/523
@@ -13,8 +13,6 @@ _begin_fstest auto quick attr
 . ./common/attr
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_attrs
 
diff --git a/tests/generic/524 b/tests/generic/524
index 80907a4c7..abe4fbfe3 100755
--- a/tests/generic/524
+++ b/tests/generic/524
@@ -18,10 +18,8 @@ _begin_fstest auto quick
 
 # Import common functions.
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_test_program "feature"
 _require_xfs_io_command "sync_range"
diff --git a/tests/generic/525 b/tests/generic/525
index 431ba2cd0..0107bacd2 100755
--- a/tests/generic/525
+++ b/tests/generic/525
@@ -17,8 +17,6 @@ _begin_fstest auto quick rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/generic/526 b/tests/generic/526
index ada4dbeeb..7d47cf111 100755
--- a/tests/generic/526
+++ b/tests/generic/526
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/527 b/tests/generic/527
index de09d1718..2ba1f319b 100755
--- a/tests/generic/527
+++ b/tests/generic/527
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_hardlinks
 _require_dm_target flakey
diff --git a/tests/generic/528 b/tests/generic/528
index a63827b11..14c4f8567 100755
--- a/tests/generic/528
+++ b/tests/generic/528
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/attr
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_xfs_io_command "statx" "-r"
 _require_btime
diff --git a/tests/generic/529 b/tests/generic/529
index 05be2c4ff..1fd3418b9 100755
--- a/tests/generic/529
+++ b/tests/generic/529
@@ -13,8 +13,6 @@ _begin_fstest auto quick acl attr
 # Import common functions.
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_acls
 _require_scratch
 _require_test_program "t_attr_corruption"
diff --git a/tests/generic/530 b/tests/generic/530
index 692a813ef..2e47c3e0c 100755
--- a/tests/generic/530
+++ b/tests/generic/530
@@ -17,8 +17,6 @@ testfile=$TEST_DIR/$seq.txt
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_scratch_shutdown
 _require_metadata_journaling
diff --git a/tests/generic/531 b/tests/generic/531
index e5f3ddddd..0e3564fd4 100755
--- a/tests/generic/531
+++ b/tests/generic/531
@@ -17,8 +17,6 @@ testfile=$TEST_DIR/$seq.txt
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "-T"
 _require_test_program "t_open_tmpfiles"
diff --git a/tests/generic/532 b/tests/generic/532
index d356b0da2..9b4b217cc 100755
--- a/tests/generic/532
+++ b/tests/generic/532
@@ -20,8 +20,6 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 get_attributes() {
diff --git a/tests/generic/533 b/tests/generic/533
index 85b39fb15..4a59a0df5 100755
--- a/tests/generic/533
+++ b/tests/generic/533
@@ -27,8 +27,6 @@ setfattr()
 . ./common/attr
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_attrs
diff --git a/tests/generic/534 b/tests/generic/534
index 1e569419e..f1cd90c0e 100755
--- a/tests/generic/534
+++ b/tests/generic/534
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/535 b/tests/generic/535
index 3b7347425..c2338da6b 100755
--- a/tests/generic/535
+++ b/tests/generic/535
@@ -32,8 +32,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/generic/536 b/tests/generic/536
index 986ea1ee6..726120e67 100755
--- a/tests/generic/536
+++ b/tests/generic/536
@@ -13,10 +13,8 @@ _begin_fstest auto quick rw shutdown
 
 # Import common functions.
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_scratch_shutdown
 
diff --git a/tests/generic/537 b/tests/generic/537
index f90a2a344..f57bc1561 100755
--- a/tests/generic/537
+++ b/tests/generic/537
@@ -19,8 +19,6 @@ _begin_fstest auto quick trim
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_fstrim
 
diff --git a/tests/generic/538 b/tests/generic/538
index f6f5496b4..d6933cbb9 100755
--- a/tests/generic/538
+++ b/tests/generic/538
@@ -24,8 +24,6 @@ _begin_fstest auto quick aio
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_aiodio aio-dio-write-verify
 
diff --git a/tests/generic/539 b/tests/generic/539
index f6feda113..521a16a09 100755
--- a/tests/generic/539
+++ b/tests/generic/539
@@ -11,7 +11,6 @@ _begin_fstest auto quick punch seek
 
 # Import common functions.
 
-_supported_fs generic
 
 _require_test
 _require_seek_data_hole
diff --git a/tests/generic/540 b/tests/generic/540
index 290e05d0d..7e797a2f3 100755
--- a/tests/generic/540
+++ b/tests/generic/540
@@ -23,8 +23,6 @@ _begin_fstest auto quick clone fiemap prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/541 b/tests/generic/541
index e6f0fa3c7..aef8b4660 100755
--- a/tests/generic/541
+++ b/tests/generic/541
@@ -23,8 +23,6 @@ _begin_fstest auto quick clone fiemap prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/542 b/tests/generic/542
index 4d907d8a4..c8bab86af 100755
--- a/tests/generic/542
+++ b/tests/generic/542
@@ -23,8 +23,6 @@ _begin_fstest auto quick clone fiemap prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/543 b/tests/generic/543
index 928b761f9..7fe8eca40 100755
--- a/tests/generic/543
+++ b/tests/generic/543
@@ -23,8 +23,6 @@ _begin_fstest auto quick clone fiemap prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/544 b/tests/generic/544
index a4f654afb..8fd7ffaf0 100755
--- a/tests/generic/544
+++ b/tests/generic/544
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/545 b/tests/generic/545
index 6f6dcd262..2005165db 100755
--- a/tests/generic/545
+++ b/tests/generic/545
@@ -26,8 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_chattr i
diff --git a/tests/generic/546 b/tests/generic/546
index 2eb99543e..972886858 100755
--- a/tests/generic/546
+++ b/tests/generic/546
@@ -27,10 +27,8 @@ _cleanup()
 . ./common/reflink
 . ./common/dmflakey
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_xfs_io_command "falloc"
 _require_scratch_reflink
 _require_dm_target flakey
diff --git a/tests/generic/547 b/tests/generic/547
index e8ccab521..1e3881db9 100755
--- a/tests/generic/547
+++ b/tests/generic/547
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_fssum
diff --git a/tests/generic/548 b/tests/generic/548
index 638c5c764..7800a4745 100755
--- a/tests/generic/548
+++ b/tests/generic/548
@@ -14,8 +14,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 
 _verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-CTS-CBC
 
diff --git a/tests/generic/549 b/tests/generic/549
index f8faf11bc..0aa4be82c 100755
--- a/tests/generic/549
+++ b/tests/generic/549
@@ -14,8 +14,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 
 _verify_ciphertext_for_encryption_policy AES-128-CBC-ESSIV AES-128-CTS-CBC
 
diff --git a/tests/generic/550 b/tests/generic/550
index aa792089a..053cedc0b 100755
--- a/tests/generic/550
+++ b/tests/generic/550
@@ -14,8 +14,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 
 # Test both with and without the DIRECT_KEY flag.
 _verify_ciphertext_for_encryption_policy Adiantum Adiantum
diff --git a/tests/generic/551 b/tests/generic/551
index 58c7f9a51..f2907ac23 100755
--- a/tests/generic/551
+++ b/tests/generic/551
@@ -12,8 +12,6 @@ _begin_fstest auto stress aio
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_aiodio aio-dio-write-verify
 
diff --git a/tests/generic/552 b/tests/generic/552
index 727bec859..9f3d7fdeb 100755
--- a/tests/generic/552
+++ b/tests/generic/552
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_odirect
 _require_dm_target flakey
diff --git a/tests/generic/553 b/tests/generic/553
index 4a3d39536..919f5be9f 100755
--- a/tests/generic/553
+++ b/tests/generic/553
@@ -26,8 +26,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_xfs_io_command "copy_range"
diff --git a/tests/generic/554 b/tests/generic/554
index b9efee0d2..e0a14745d 100755
--- a/tests/generic/554
+++ b/tests/generic/554
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_scratch
 _require_xfs_io_command "copy_range"
diff --git a/tests/generic/555 b/tests/generic/555
index d243dccf0..8ee5faec2 100755
--- a/tests/generic/555
+++ b/tests/generic/555
@@ -29,8 +29,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_xfs_io_command "chattr" "ia"
diff --git a/tests/generic/556 b/tests/generic/556
index 404a3243a..51d2d4820 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -12,7 +12,6 @@ _begin_fstest auto quick casefold
 . ./common/casefold
 . ./common/attr
 
-_supported_fs generic
 _require_scratch_nocheck
 _require_scratch_casefold
 _require_symlinks
diff --git a/tests/generic/557 b/tests/generic/557
index c547d5375..742180e2b 100755
--- a/tests/generic/557
+++ b/tests/generic/557
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/558 b/tests/generic/558
index 510b06f28..a8e3f7ff2 100755
--- a/tests/generic/558
+++ b/tests/generic/558
@@ -27,8 +27,6 @@ create_file()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_inode_limits
 _require_scratch
 
diff --git a/tests/generic/559 b/tests/generic/559
index 98ab44742..28cf2e1a3 100755
--- a/tests/generic/559
+++ b/tests/generic/559
@@ -13,8 +13,6 @@ _begin_fstest auto stress dedupe
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_duperemove
 
 fssize=$((2 * 1024 * 1024 * 1024))
diff --git a/tests/generic/560 b/tests/generic/560
index e3f28667a..62983d69b 100755
--- a/tests/generic/560
+++ b/tests/generic/560
@@ -15,8 +15,6 @@ _begin_fstest auto stress dedupe
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_duperemove
 
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/561 b/tests/generic/561
index 44f078022..39e5977a3 100755
--- a/tests/generic/561
+++ b/tests/generic/561
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_duperemove
 _require_command "$KILLALL_PROG" killall
 
diff --git a/tests/generic/562 b/tests/generic/562
index 7d98e5690..91360c415 100755
--- a/tests/generic/562
+++ b/tests/generic/562
@@ -15,8 +15,6 @@ _begin_fstest auto clone punch
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_test_program "punch-alternating"
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/563 b/tests/generic/563
index f98c6e42b..0a8129a60 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -29,10 +29,8 @@ _cleanup()
 . ./common/filter
 . ./common/cgroup2
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch_nocheck
 _require_cgroup2 io
 _require_loop
diff --git a/tests/generic/564 b/tests/generic/564
index 7ed5ccc1b..647472d78 100755
--- a/tests/generic/564
+++ b/tests/generic/564
@@ -25,8 +25,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_loop
diff --git a/tests/generic/565 b/tests/generic/565
index fd71d1e39..3c65493f5 100755
--- a/tests/generic/565
+++ b/tests/generic/565
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 
 _require_test
 _require_scratch
diff --git a/tests/generic/566 b/tests/generic/566
index 52b01f6d9..a41e04852 100755
--- a/tests/generic/566
+++ b/tests/generic/566
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/quota
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_xfs_quota_foreign
diff --git a/tests/generic/567 b/tests/generic/567
index 40a97d2d9..fc109d0d4 100755
--- a/tests/generic/567
+++ b/tests/generic/567
@@ -16,8 +16,6 @@ _begin_fstest auto quick rw punch
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "fpunch"
 
diff --git a/tests/generic/568 b/tests/generic/568
index 958e5e944..03dee60bc 100755
--- a/tests/generic/568
+++ b/tests/generic/568
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_xfs_io_command "falloc"
 
 testfile="$TEST_DIR/falloctest-$seq"
diff --git a/tests/generic/569 b/tests/generic/569
index eeaf3f163..345e47440 100755
--- a/tests/generic/569
+++ b/tests/generic/569
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_xfs_io_command "falloc"
 _require_test_program swapon
 _require_scratch_swapfile
diff --git a/tests/generic/570 b/tests/generic/570
index 2143c742c..6b50303cd 100755
--- a/tests/generic/570
+++ b/tests/generic/570
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test_program swapon
 _require_scratch_nocheck
 _require_block_device $SCRATCH_DEV
diff --git a/tests/generic/571 b/tests/generic/571
index bd5737fae..10d1622c4 100755
--- a/tests/generic/571
+++ b/tests/generic/571
@@ -13,8 +13,6 @@ _begin_fstest auto quick
 . ./common/filter
 . ./common/locktest
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_test_fcntl_advisory_locks
 _require_test_fcntl_setlease
diff --git a/tests/generic/572 b/tests/generic/572
index d8071a348..80356760e 100755
--- a/tests/generic/572
+++ b/tests/generic/572
@@ -26,8 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/verity
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_verity
 _disable_fsverity_signatures
 
diff --git a/tests/generic/573 b/tests/generic/573
index ca0f27f98..b310fccbd 100755
--- a/tests/generic/573
+++ b/tests/generic/573
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/verity
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_verity
 _require_user
 _require_chattr ia
diff --git a/tests/generic/574 b/tests/generic/574
index bc0b17a0c..cf287d2bb 100755
--- a/tests/generic/574
+++ b/tests/generic/574
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/verity
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_verity
 _disable_fsverity_signatures
 _require_fsverity_corruption
diff --git a/tests/generic/575 b/tests/generic/575
index 344fd2b91..ce0c17320 100755
--- a/tests/generic/575
+++ b/tests/generic/575
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/verity
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_verity
 _disable_fsverity_signatures
 
diff --git a/tests/generic/576 b/tests/generic/576
index c8862de2d..c9979c750 100755
--- a/tests/generic/576
+++ b/tests/generic/576
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/verity
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_verity
 _require_scratch_encryption
 _require_command "$KEYCTL_PROG" keyctl
diff --git a/tests/generic/577 b/tests/generic/577
index bbbfdb0aa..a32ef3760 100755
--- a/tests/generic/577
+++ b/tests/generic/577
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/verity
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_verity
 _require_fsverity_builtin_signatures
 
diff --git a/tests/generic/578 b/tests/generic/578
index e8bb97f7b..347f6f979 100755
--- a/tests/generic/578
+++ b/tests/generic/578
@@ -20,8 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_test_program "mmap-write-concurrent"
 _require_command "$FILEFRAG_PROG" filefrag
 _require_xfs_io_command "fiemap"
diff --git a/tests/generic/579 b/tests/generic/579
index 2667585ca..3191342b3 100755
--- a/tests/generic/579
+++ b/tests/generic/579
@@ -28,8 +28,6 @@ _cleanup()
 . ./common/filter
 . ./common/verity
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_verity
 _require_command "$KILLALL_PROG" killall
 _disable_fsverity_signatures
diff --git a/tests/generic/580 b/tests/generic/580
index 73f32ff9a..eff3f2104 100755
--- a/tests/generic/580
+++ b/tests/generic/580
@@ -16,8 +16,6 @@ echo
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption -v 2
 
 _scratch_mkfs_encrypted &>> $seqres.full
diff --git a/tests/generic/581 b/tests/generic/581
index cabc7e1c6..2773c9108 100755
--- a/tests/generic/581
+++ b/tests/generic/581
@@ -28,8 +28,6 @@ _cleanup()
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_user
 _require_scratch_encryption -v 2
 
diff --git a/tests/generic/582 b/tests/generic/582
index bd7d2ea61..294ecbcd5 100755
--- a/tests/generic/582
+++ b/tests/generic/582
@@ -16,8 +16,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 
 _verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-CTS-CBC v2
 
diff --git a/tests/generic/583 b/tests/generic/583
index 771ecd1ec..ac0a538c0 100755
--- a/tests/generic/583
+++ b/tests/generic/583
@@ -16,8 +16,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 
 _verify_ciphertext_for_encryption_policy AES-128-CBC-ESSIV AES-128-CTS-CBC v2
 
diff --git a/tests/generic/584 b/tests/generic/584
index adafec6ad..601dddc9f 100755
--- a/tests/generic/584
+++ b/tests/generic/584
@@ -16,8 +16,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 
 # Test both with and without the DIRECT_KEY flag.
 _verify_ciphertext_for_encryption_policy Adiantum Adiantum v2
diff --git a/tests/generic/585 b/tests/generic/585
index 05762b238..fb675c8d5 100755
--- a/tests/generic/585
+++ b/tests/generic/585
@@ -14,8 +14,6 @@ _begin_fstest auto rename
 . ./common/filter
 . ./common/renameat2
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_renameat2 whiteout
 
diff --git a/tests/generic/586 b/tests/generic/586
index 8fe6567fc..22c3ad9c5 100755
--- a/tests/generic/586
+++ b/tests/generic/586
@@ -20,8 +20,6 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_aiodio "aio-dio-append-write-fallocate-race"
 _require_test
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/587 b/tests/generic/587
index ebfeea1d1..466596799 100755
--- a/tests/generic/587
+++ b/tests/generic/587
@@ -19,8 +19,6 @@ _begin_fstest auto quick rw prealloc quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_user
 _require_quota
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/588 b/tests/generic/588
index a915a73e4..0ee9f001c 100755
--- a/tests/generic/588
+++ b/tests/generic/588
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_dm_target flakey
 
diff --git a/tests/generic/589 b/tests/generic/589
index bfc7407a1..0ce16556a 100755
--- a/tests/generic/589
+++ b/tests/generic/589
@@ -38,8 +38,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_local_device $SCRATCH_DEV
diff --git a/tests/generic/590 b/tests/generic/590
index 5f84d0040..2b7ccfb53 100755
--- a/tests/generic/590
+++ b/tests/generic/590
@@ -23,7 +23,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs generic
 _require_scratch_nocheck
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/591 b/tests/generic/591
index 4de50e2a4..c22dc701b 100755
--- a/tests/generic/591
+++ b/tests/generic/591
@@ -18,8 +18,6 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_odirect
 _require_test_program "splice-test"
diff --git a/tests/generic/592 b/tests/generic/592
index e74d2e12c..6c207f298 100755
--- a/tests/generic/592
+++ b/tests/generic/592
@@ -15,8 +15,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 
 _verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-CTS-CBC \
 	v2 iv_ino_lblk_64
diff --git a/tests/generic/593 b/tests/generic/593
index 2dda5d765..05f868f92 100755
--- a/tests/generic/593
+++ b/tests/generic/593
@@ -15,8 +15,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption -v 2
 _require_command "$KEYCTL_PROG" keyctl
 
diff --git a/tests/generic/594 b/tests/generic/594
index 88f9a0dcc..2c9be806d 100755
--- a/tests/generic/594
+++ b/tests/generic/594
@@ -14,8 +14,6 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_setquota_project
 # V4 XFS doesn't support to mount project and group quota together
diff --git a/tests/generic/595 b/tests/generic/595
index d559e3bbd..afdbe0d3e 100755
--- a/tests/generic/595
+++ b/tests/generic/595
@@ -27,8 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption -v 2
 _require_command "$KEYCTL_PROG" keyctl
 
diff --git a/tests/generic/596 b/tests/generic/596
index 2113d7f10..e6bca8837 100755
--- a/tests/generic/596
+++ b/tests/generic/596
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_bsd_process_accounting
 _require_chattr S
 _require_test
diff --git a/tests/generic/597 b/tests/generic/597
index a3035489a..b97265fb8 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -24,10 +24,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_sysctl_variable fs.protected_symlinks
 _require_sysctl_variable fs.protected_hardlinks
diff --git a/tests/generic/598 b/tests/generic/598
index 31b7fde48..5b9db69e2 100755
--- a/tests/generic/598
+++ b/tests/generic/598
@@ -24,10 +24,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_sysctl_variable fs.protected_regular
 _require_sysctl_variable fs.protected_fifos
diff --git a/tests/generic/599 b/tests/generic/599
index 3fc860564..e1454584f 100755
--- a/tests/generic/599
+++ b/tests/generic/599
@@ -15,8 +15,6 @@ status=0
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_fssum
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/generic/600 b/tests/generic/600
index a4233ecc5..43f75376a 100755
--- a/tests/generic/600
+++ b/tests/generic/600
@@ -17,8 +17,6 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_user
diff --git a/tests/generic/601 b/tests/generic/601
index f3f3ec9e1..9860505ba 100755
--- a/tests/generic/601
+++ b/tests/generic/601
@@ -17,8 +17,6 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_user
diff --git a/tests/generic/602 b/tests/generic/602
index c5072fab0..6b21c948d 100755
--- a/tests/generic/602
+++ b/tests/generic/602
@@ -15,8 +15,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 
 _verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-CTS-CBC \
 	v2 iv_ino_lblk_32
diff --git a/tests/generic/603 b/tests/generic/603
index 08ddcbf2e..32dcaeb94 100755
--- a/tests/generic/603
+++ b/tests/generic/603
@@ -104,8 +104,6 @@ test_grace()
 	cleanup_files $dir
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 # xfs requires v5 format to support all three quota types at the same time
 if [ "$FSTYP" = "xfs" ]; then
diff --git a/tests/generic/604 b/tests/generic/604
index 1109a52c6..c2e03c2ea 100755
--- a/tests/generic/604
+++ b/tests/generic/604
@@ -13,10 +13,8 @@ _begin_fstest auto quick mount
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/generic/605 b/tests/generic/605
index 7e814d5ba..2c372db7c 100755
--- a/tests/generic/605
+++ b/tests/generic/605
@@ -12,7 +12,6 @@ _begin_fstest auto attr quick dax prealloc
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_hugepages
 _require_scratch_dax_mountopt "dax=always"
 _require_test_program "feature"
diff --git a/tests/generic/606 b/tests/generic/606
index e066d93ac..8fdf07a0c 100755
--- a/tests/generic/606
+++ b/tests/generic/606
@@ -19,7 +19,6 @@ _begin_fstest auto attr quick dax
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_scratch_dax_mountopt "dax=always"
 _require_dax_iflag
 _require_xfs_io_command "statx" "-r"
diff --git a/tests/generic/607 b/tests/generic/607
index 2cfe0773d..d746d9dd9 100755
--- a/tests/generic/607
+++ b/tests/generic/607
@@ -16,7 +16,6 @@ _begin_fstest auto attr quick dax
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_scratch
 _require_dax_iflag
 _require_xfs_io_command "lsattr" "-v"
diff --git a/tests/generic/608 b/tests/generic/608
index e36829c3f..809f39870 100755
--- a/tests/generic/608
+++ b/tests/generic/608
@@ -20,7 +20,6 @@ _begin_fstest auto attr quick dax
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_scratch_dax_mountopt "dax=always"
 _require_dax_iflag
 _require_xfs_io_command "lsattr" "-v"
diff --git a/tests/generic/609 b/tests/generic/609
index f955e986e..5cb6210ae 100755
--- a/tests/generic/609
+++ b/tests/generic/609
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_xfs_io_command "pwrite"
 _require_odirect
diff --git a/tests/generic/610 b/tests/generic/610
index 18cfcfff5..22f28c6df 100755
--- a/tests/generic/610
+++ b/tests/generic/610
@@ -14,8 +14,6 @@ _begin_fstest auto quick prealloc zero punch
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "fzero"
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/611 b/tests/generic/611
index 3dfeb02b5..cefc3942e 100755
--- a/tests/generic/611
+++ b/tests/generic/611
@@ -17,9 +17,7 @@ _begin_fstest auto quick attr
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
-_supported_fs generic
 _require_scratch
 _require_attrs
 
diff --git a/tests/generic/612 b/tests/generic/612
index 9c023a65e..3c7209a0f 100755
--- a/tests/generic/612
+++ b/tests/generic/612
@@ -18,10 +18,8 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_test_reflink
 
diff --git a/tests/generic/613 b/tests/generic/613
index 4cf5ccc60..499af18ef 100755
--- a/tests/generic/613
+++ b/tests/generic/613
@@ -20,8 +20,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_encryption -v 2
 _require_get_encryption_nonce_support
 _require_command "$XZ_PROG" xz
diff --git a/tests/generic/614 b/tests/generic/614
index 3e2a587c8..2299c1338 100755
--- a/tests/generic/614
+++ b/tests/generic/614
@@ -13,8 +13,6 @@ _begin_fstest auto quick rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_scratch_delalloc
 
diff --git a/tests/generic/615 b/tests/generic/615
index 941122987..71cdb9ac8 100755
--- a/tests/generic/615
+++ b/tests/generic/615
@@ -14,8 +14,6 @@ _begin_fstest auto rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_odirect
 
diff --git a/tests/generic/616 b/tests/generic/616
index 5b0b02c5e..0fe63c95c 100755
--- a/tests/generic/616
+++ b/tests/generic/616
@@ -13,10 +13,8 @@ _begin_fstest auto rw io_uring stress soak
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_io_uring
 
diff --git a/tests/generic/617 b/tests/generic/617
index a97787002..eb50a2da3 100755
--- a/tests/generic/617
+++ b/tests/generic/617
@@ -13,10 +13,8 @@ _begin_fstest auto rw io_uring stress soak
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_odirect
 _require_io_uring
diff --git a/tests/generic/618 b/tests/generic/618
index 992b8457c..9af5b37bd 100755
--- a/tests/generic/618
+++ b/tests/generic/618
@@ -18,9 +18,7 @@ _begin_fstest auto quick attr
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
-_supported_fs generic
 _require_scratch
 _require_attrs user
 
diff --git a/tests/generic/619 b/tests/generic/619
index c4bdfbced..c2446d9d4 100755
--- a/tests/generic/619
+++ b/tests/generic/619
@@ -43,7 +43,6 @@ MIX_FILE_SIZE=$((2048 * 1024))  # (BIG + SMALL small file size)
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_test_program "t_enospc"
 _require_xfs_io_command "falloc"
@@ -181,7 +180,6 @@ declare -a TEST_VECTORS=(
 "Mix-file-ftruncate-test:$MIX_FILE_SIZE:0.75,0.25:$FACT:$FTRUNCATE:3"
 )
 
-# real QA test starts here
 for i in "${TEST_VECTORS[@]}"; do
 	run_testcase $i
 done
diff --git a/tests/generic/620 b/tests/generic/620
index b052376f0..bf97328d1 100755
--- a/tests/generic/620
+++ b/tests/generic/620
@@ -31,7 +31,6 @@ _cleanup()
 . ./common/dmhugedisk
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch_size_nocheck $((4 * 1024 * 1024)) #kB
 _require_scratch_16T_support
 _require_dmhugedisk
diff --git a/tests/generic/621 b/tests/generic/621
index 8c204eb80..e5f92894c 100755
--- a/tests/generic/621
+++ b/tests/generic/621
@@ -50,7 +50,6 @@ _cleanup()
 . ./common/encrypt
 . ./common/renameat2
 
-_supported_fs generic
 _require_scratch_encryption -v 2
 _require_renameat2 noreplace
 
diff --git a/tests/generic/622 b/tests/generic/622
index e03fdd714..0c744fdea 100755
--- a/tests/generic/622
+++ b/tests/generic/622
@@ -74,7 +74,6 @@ _cleanup()
 
 . ./common/filter
 
-_supported_fs generic
 # This test uses the shutdown command, so it has to use the scratch filesystem
 # rather than the test filesystem.
 _require_scratch
diff --git a/tests/generic/623 b/tests/generic/623
index ea016d91a..6487ccb81 100755
--- a/tests/generic/623
+++ b/tests/generic/623
@@ -11,7 +11,6 @@ _begin_fstest auto quick shutdown
 
 . ./common/filter
 
-_supported_fs generic
 _fixed_by_kernel_commit e4826691cc7e \
 	"xfs: restore shutdown check in mapped write fault path"
 
diff --git a/tests/generic/624 b/tests/generic/624
index db4b67310..da383f461 100755
--- a/tests/generic/624
+++ b/tests/generic/624
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/verity
 
-_supported_fs generic
 _require_scratch_verity
 _disable_fsverity_signatures
 fsv_orig_file=$SCRATCH_MNT/file
diff --git a/tests/generic/625 b/tests/generic/625
index 8903b9b58..0a99def06 100755
--- a/tests/generic/625
+++ b/tests/generic/625
@@ -16,7 +16,6 @@ _begin_fstest auto quick verity
 . ./common/filter
 . ./common/verity
 
-_supported_fs generic
 _require_scratch_verity
 _require_fsverity_builtin_signatures
 
diff --git a/tests/generic/626 b/tests/generic/626
index 7e577798a..71db44763 100755
--- a/tests/generic/626
+++ b/tests/generic/626
@@ -17,8 +17,6 @@ _begin_fstest auto quick rename enospc
 . ./common/populate
 . ./common/renameat2
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_renameat2 whiteout
 
diff --git a/tests/generic/627 b/tests/generic/627
index 9a7359e6e..527ec6bb9 100755
--- a/tests/generic/627
+++ b/tests/generic/627
@@ -25,8 +25,6 @@ fio_out=$tmp.fio.out
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_odirect
diff --git a/tests/generic/628 b/tests/generic/628
index 380a7f0b3..8fd44364c 100755
--- a/tests/generic/628
+++ b/tests/generic/628
@@ -27,8 +27,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_dm_target error
 _require_xfs_io_command "chattr" "s"
diff --git a/tests/generic/629 b/tests/generic/629
index dbd7ada84..92b7839a0 100755
--- a/tests/generic/629
+++ b/tests/generic/629
@@ -26,8 +26,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target error
 _require_xfs_io_command "chattr" "s"
diff --git a/tests/generic/630 b/tests/generic/630
index f1ea6b17d..b2cbdcf05 100755
--- a/tests/generic/630
+++ b/tests/generic/630
@@ -14,8 +14,6 @@ _begin_fstest auto quick rw dedupe clone
 # Import common functions.
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_dedupe
 _require_test_program "deduperace"
 
diff --git a/tests/generic/631 b/tests/generic/631
index ff1bb1130..c7c95e560 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -35,7 +35,6 @@ _cleanup()
 # Import common functions.
 . ./common/attr
 
-# real QA test starts here
 _require_scratch
 _require_attrs trusted
 _supported_fs ^overlay
diff --git a/tests/generic/632 b/tests/generic/632
index 4d6928a6e..c7a1f1fad 100755
--- a/tests/generic/632
+++ b/tests/generic/632
@@ -19,7 +19,6 @@
 . ./common/preamble
 _begin_fstest auto quick mount
 
-_supported_fs generic
 _require_test
 _require_test_program "detached_mounts_propagation"
 
diff --git a/tests/generic/633 b/tests/generic/633
index 9b29dbf1c..3bd18df68 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -12,9 +12,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 
 echo "Silence is golden"
diff --git a/tests/generic/634 b/tests/generic/634
index 5cdae584c..8a4210a3f 100755
--- a/tests/generic/634
+++ b/tests/generic/634
@@ -23,8 +23,6 @@ _begin_fstest auto quick atime bigtime
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 
 _scratch_mkfs > $seqres.full
diff --git a/tests/generic/635 b/tests/generic/635
index 198278c43..4a811630a 100755
--- a/tests/generic/635
+++ b/tests/generic/635
@@ -24,8 +24,6 @@ _begin_fstest auto quick atime bigtime shutdown
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_scratch_shutdown
 
diff --git a/tests/generic/636 b/tests/generic/636
index afb9df986..2ae74310e 100755
--- a/tests/generic/636
+++ b/tests/generic/636
@@ -13,7 +13,6 @@ _begin_fstest auto quick swap
 # Import common functions.
 . ./common/filter
 
-_supported_fs generic
 _require_scratch_swapfile
 _require_test_program mkswap
 _require_test_program swapon
diff --git a/tests/generic/637 b/tests/generic/637
index 8805a171a..e63fc0ba4 100755
--- a/tests/generic/637
+++ b/tests/generic/637
@@ -11,8 +11,6 @@ _begin_fstest auto quick dir
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 testdir=$TEST_DIR/test-$seq
diff --git a/tests/generic/638 b/tests/generic/638
index fff25e664..3de9801c5 100755
--- a/tests/generic/638
+++ b/tests/generic/638
@@ -25,8 +25,6 @@ _begin_fstest auto quick rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_test_program "t_mmap_writev_overlap"
 
diff --git a/tests/generic/639 b/tests/generic/639
index abb91c802..9ef67bc55 100755
--- a/tests/generic/639
+++ b/tests/generic/639
@@ -16,8 +16,6 @@ _begin_fstest auto quick rw
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 
 testfile="$TEST_DIR/test_write_begin.$$"
diff --git a/tests/generic/640 b/tests/generic/640
index a9346d5b3..038dde975 100755
--- a/tests/generic/640
+++ b/tests/generic/640
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 
diff --git a/tests/generic/641 b/tests/generic/641
index 124f2e1da..a6efcd4cf 100755
--- a/tests/generic/641
+++ b/tests/generic/641
@@ -14,8 +14,6 @@ _begin_fstest auto quick swap collapse
 # Import common functions
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_scratch_swapfile
 _require_test_program mkswap
diff --git a/tests/generic/642 b/tests/generic/642
index 4d0c41fd5..a7112a08f 100755
--- a/tests/generic/642
+++ b/tests/generic/642
@@ -18,7 +18,6 @@ _cleanup()
 }
 
 # Modify as appropriate.
-_supported_fs generic
 
 _require_scratch
 _require_command "$KILLALL_PROG" "killall"
diff --git a/tests/generic/643 b/tests/generic/643
index 9a0ec2c38..e407ae3ec 100755
--- a/tests/generic/643
+++ b/tests/generic/643
@@ -26,8 +26,6 @@ _cleanup()
 
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_swapfile
 
 _scratch_mkfs >> $seqres.full
diff --git a/tests/generic/644 b/tests/generic/644
index c48338d80..e273ffc89 100755
--- a/tests/generic/644
+++ b/tests/generic/644
@@ -12,9 +12,7 @@ _begin_fstest auto quick cap idmapped mount
 # get standard environment, filters and checks
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_idmapped_mounts
 _require_test
 
diff --git a/tests/generic/645 b/tests/generic/645
index 249e9cc07..068a46a95 100755
--- a/tests/generic/645
+++ b/tests/generic/645
@@ -12,9 +12,7 @@ _begin_fstest auto quick idmapped mount
 # get standard environment, filters and checks
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_idmapped_mounts
 _require_test
 _wants_kernel_commit dacfd001eaf2 \
diff --git a/tests/generic/646 b/tests/generic/646
index 027df5570..dc73aeb32 100755
--- a/tests/generic/646
+++ b/tests/generic/646
@@ -14,8 +14,6 @@
 . ./common/preamble
 _begin_fstest auto quick recoveryloop shutdown
 
-# real QA test starts here
-_supported_fs generic
 _fixed_by_kernel_commit 50d25484bebe \
 	"xfs: sync lazy sb accounting on quiesce of read-only mounts"
 
diff --git a/tests/generic/647 b/tests/generic/647
index 8484fa8d9..99b13b387 100755
--- a/tests/generic/647
+++ b/tests/generic/647
@@ -20,9 +20,7 @@ _cleanup()
 # get standard environment, filters and checks
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 _require_odirect
 _require_test_program mmap-rw-fault
diff --git a/tests/generic/648 b/tests/generic/648
index 3b3544ff4..29d1b470b 100755
--- a/tests/generic/648
+++ b/tests/generic/648
@@ -33,7 +33,6 @@ _cleanup()
 . ./common/reflink
 
 # Modify as appropriate.
-_supported_fs generic
 
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/generic/649 b/tests/generic/649
index 2e156dfef..a33b13eaa 100755
--- a/tests/generic/649
+++ b/tests/generic/649
@@ -29,10 +29,8 @@ _cleanup()
 . ./common/reflink
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _fixed_by_kernel_commit 72a048c1056a \
 	"xfs: only set IOMAP_F_SHARED when providing a srcmap to a write"
 
diff --git a/tests/generic/650 b/tests/generic/650
index e152c3985..5d2cb8977 100755
--- a/tests/generic/650
+++ b/tests/generic/650
@@ -38,7 +38,6 @@ exercise_cpu_hotplug()
 	done
 }
 
-_supported_fs generic
 _require_test
 _require_command "$KILLALL_PROG" "killall"
 
diff --git a/tests/generic/651 b/tests/generic/651
index cc239f488..0d79f3f21 100755
--- a/tests/generic/651
+++ b/tests/generic/651
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 
 pagesz=$(getconf PAGE_SIZE)
diff --git a/tests/generic/652 b/tests/generic/652
index d7b74e0e6..e45dbbd21 100755
--- a/tests/generic/652
+++ b/tests/generic/652
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/653 b/tests/generic/653
index a63c71384..bd3896cb9 100755
--- a/tests/generic/653
+++ b/tests/generic/653
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/654 b/tests/generic/654
index f73ae81be..4b2986ec7 100755
--- a/tests/generic/654
+++ b/tests/generic/654
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone fiemap prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/655 b/tests/generic/655
index a131b1d1c..e2a503b44 100755
--- a/tests/generic/655
+++ b/tests/generic/655
@@ -17,7 +17,6 @@ _begin_fstest auto quick clone fiemap prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/656 b/tests/generic/656
index 5c090cfa9..cd49c4f65 100755
--- a/tests/generic/656
+++ b/tests/generic/656
@@ -14,9 +14,7 @@ _begin_fstest auto attr cap idmapped mount perms
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_idmapped_mounts
 _require_test
 _require_user fsgqa
diff --git a/tests/generic/657 b/tests/generic/657
index e0fecd544..df45afcbe 100755
--- a/tests/generic/657
+++ b/tests/generic/657
@@ -18,7 +18,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 
 echo "Format and mount"
diff --git a/tests/generic/658 b/tests/generic/658
index a5cbadaaa..03d5a7a1c 100755
--- a/tests/generic/658
+++ b/tests/generic/658
@@ -18,7 +18,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/659 b/tests/generic/659
index ccc2d7950..cef2b2325 100755
--- a/tests/generic/659
+++ b/tests/generic/659
@@ -18,7 +18,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/660 b/tests/generic/660
index bc17dc5e5..650e5e839 100755
--- a/tests/generic/660
+++ b/tests/generic/660
@@ -18,7 +18,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/661 b/tests/generic/661
index 788dae7e3..74c080ab5 100755
--- a/tests/generic/661
+++ b/tests/generic/661
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/662 b/tests/generic/662
index 3fdfb4e00..54405b98e 100755
--- a/tests/generic/662
+++ b/tests/generic/662
@@ -23,7 +23,6 @@ _begin_fstest auto quick clone punch prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/663 b/tests/generic/663
index 658a5b700..2129805c7 100755
--- a/tests/generic/663
+++ b/tests/generic/663
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/664 b/tests/generic/664
index 3009101fd..fdedc486f 100755
--- a/tests/generic/664
+++ b/tests/generic/664
@@ -21,7 +21,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/665 b/tests/generic/665
index 86ba57872..b0676dc81 100755
--- a/tests/generic/665
+++ b/tests/generic/665
@@ -21,7 +21,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/666 b/tests/generic/666
index 5e4f30621..8575c06ca 100755
--- a/tests/generic/666
+++ b/tests/generic/666
@@ -22,7 +22,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/667 b/tests/generic/667
index 9f1cb1be6..406550987 100755
--- a/tests/generic/667
+++ b/tests/generic/667
@@ -22,7 +22,6 @@ _begin_fstest auto quick clone punch prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/668 b/tests/generic/668
index 41e03ae8e..aab395752 100755
--- a/tests/generic/668
+++ b/tests/generic/668
@@ -22,7 +22,6 @@ _begin_fstest auto quick clone punch prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/669 b/tests/generic/669
index c88160427..aa7b0d55c 100755
--- a/tests/generic/669
+++ b/tests/generic/669
@@ -22,7 +22,6 @@ _begin_fstest auto quick clone punch prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/670 b/tests/generic/670
index 67de16740..67a8f6fe2 100755
--- a/tests/generic/670
+++ b/tests/generic/670
@@ -15,7 +15,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/671 b/tests/generic/671
index b6cc0573f..f20069113 100755
--- a/tests/generic/671
+++ b/tests/generic/671
@@ -15,7 +15,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/672 b/tests/generic/672
index 9e3a97ec5..832907de3 100755
--- a/tests/generic/672
+++ b/tests/generic/672
@@ -15,7 +15,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 
 echo "Format and mount"
diff --git a/tests/generic/673 b/tests/generic/673
index ac8b8c09f..1230b51e1 100755
--- a/tests/generic/673
+++ b/tests/generic/673
@@ -13,10 +13,8 @@ _begin_fstest auto clone quick perms
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_scratch_reflink
 
diff --git a/tests/generic/674 b/tests/generic/674
index 2ed022df8..2e395290a 100755
--- a/tests/generic/674
+++ b/tests/generic/674
@@ -13,10 +13,8 @@ _begin_fstest auto clone quick perms dedupe
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_scratch_dedupe
 _require_xfs_io_command dedupe
diff --git a/tests/generic/675 b/tests/generic/675
index cc4309e45..7c062db81 100755
--- a/tests/generic/675
+++ b/tests/generic/675
@@ -14,10 +14,8 @@ _begin_fstest auto clone quick
 . ./common/reflink
 . ./common/attr
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
diff --git a/tests/generic/676 b/tests/generic/676
index 7a9d53866..45b276982 100755
--- a/tests/generic/676
+++ b/tests/generic/676
@@ -22,10 +22,8 @@ _cleanup()
 # Import common functions.
 # . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_test_program "t_readdir_3"
 
diff --git a/tests/generic/677 b/tests/generic/677
index 84146c5e0..f2081c34c 100755
--- a/tests/generic/677
+++ b/tests/generic/677
@@ -22,9 +22,7 @@ _cleanup()
 . ./common/dmflakey
 . ./common/punch
 
-# real QA test starts here
 
-_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 _require_xfs_io_command "falloc" "-k"
diff --git a/tests/generic/678 b/tests/generic/678
index 3c3c05b71..8396c49dd 100755
--- a/tests/generic/678
+++ b/tests/generic/678
@@ -24,9 +24,7 @@ _cleanup()
 # get standard environment, filters and checks
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 _require_odirect
 _require_io_uring
diff --git a/tests/generic/679 b/tests/generic/679
index ddf975a2c..4c74101c5 100755
--- a/tests/generic/679
+++ b/tests/generic/679
@@ -14,7 +14,6 @@ _begin_fstest auto quick prealloc fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
 
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/680 b/tests/generic/680
index 909f75924..07048db5c 100755
--- a/tests/generic/680
+++ b/tests/generic/680
@@ -11,8 +11,6 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_user
 _require_chmod
diff --git a/tests/generic/681 b/tests/generic/681
index f41647741..aef54205d 100755
--- a/tests/generic/681
+++ b/tests/generic/681
@@ -18,10 +18,8 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_quota
 _require_user
 _require_scratch
diff --git a/tests/generic/682 b/tests/generic/682
index 417598804..3572af173 100755
--- a/tests/generic/682
+++ b/tests/generic/682
@@ -18,10 +18,8 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_quota
 _require_user
 _require_scratch
diff --git a/tests/generic/683 b/tests/generic/683
index 304b1a486..cf1ebbc44 100755
--- a/tests/generic/683
+++ b/tests/generic/683
@@ -20,10 +20,8 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_test
 verb=falloc
diff --git a/tests/generic/684 b/tests/generic/684
index 1ebffb017..e1eb4e118 100755
--- a/tests/generic/684
+++ b/tests/generic/684
@@ -20,10 +20,8 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_test
 verb=fpunch
diff --git a/tests/generic/685 b/tests/generic/685
index e4ada8e75..bec2c5a0b 100755
--- a/tests/generic/685
+++ b/tests/generic/685
@@ -20,10 +20,8 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_test
 verb=fzero
diff --git a/tests/generic/686 b/tests/generic/686
index d56aa7ccc..efcc3f610 100755
--- a/tests/generic/686
+++ b/tests/generic/686
@@ -20,10 +20,8 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_test
 verb=finsert
diff --git a/tests/generic/687 b/tests/generic/687
index 3a7f1fd5b..e05f0fdcd 100755
--- a/tests/generic/687
+++ b/tests/generic/687
@@ -20,10 +20,8 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_test
 verb=fcollapse
diff --git a/tests/generic/688 b/tests/generic/688
index e2bf12b44..9c19356d8 100755
--- a/tests/generic/688
+++ b/tests/generic/688
@@ -20,10 +20,8 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
diff --git a/tests/generic/689 b/tests/generic/689
index 6aff9695c..36c74cd75 100755
--- a/tests/generic/689
+++ b/tests/generic/689
@@ -16,9 +16,7 @@ _begin_fstest auto quick perms idmapped
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 _require_idmapped_mounts
 _require_user fsgqa
diff --git a/tests/generic/690 b/tests/generic/690
index cef8d6e83..ba0da30d3 100755
--- a/tests/generic/690
+++ b/tests/generic/690
@@ -27,9 +27,7 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
 
-_supported_fs generic
 _require_scratch
 _require_symlinks
 _require_dm_target flakey
diff --git a/tests/generic/691 b/tests/generic/691
index 6432834f9..25ce92bc4 100755
--- a/tests/generic/691
+++ b/tests/generic/691
@@ -27,8 +27,6 @@ _cleanup()
 # Import common functions.
 . ./common/quota
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_quota
 _require_user
diff --git a/tests/generic/692 b/tests/generic/692
index 3fb8ac01a..5af89a6e3 100755
--- a/tests/generic/692
+++ b/tests/generic/692
@@ -27,8 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/verity
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_math
 _require_scratch_verity
diff --git a/tests/generic/693 b/tests/generic/693
index 1596865e5..1f3250d54 100755
--- a/tests/generic/693
+++ b/tests/generic/693
@@ -17,8 +17,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-# real QA test starts here
-_supported_fs generic
 
 _verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2 v2
 _verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2 \
diff --git a/tests/generic/694 b/tests/generic/694
index c96c2154f..02253ef75 100755
--- a/tests/generic/694
+++ b/tests/generic/694
@@ -20,7 +20,6 @@ _cleanup()
 	rm -r -f $tmp.* $junk_dir
 }
 
-_supported_fs generic
 _fixed_by_kernel_commit 0c336d6e33f4 \
 	"exfat: fix incorrect loading of i_blocks for large file"
 
diff --git a/tests/generic/695 b/tests/generic/695
index d53457dce..8179d59a0 100755
--- a/tests/generic/695
+++ b/tests/generic/695
@@ -25,7 +25,6 @@ _cleanup()
 . ./common/dmflakey
 . ./common/punch
 
-_supported_fs generic
 _fixed_by_kernel_commit e6e3dec6c3c288 \
         "btrfs: update generation of hole file extent item when merging holes"
 _require_scratch
diff --git a/tests/generic/696 b/tests/generic/696
index 55a2fd5ac..d06e86ee5 100755
--- a/tests/generic/696
+++ b/tests/generic/696
@@ -17,9 +17,7 @@ _begin_fstest auto quick cap idmapped mount perms rw unlink
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 _require_scratch
 _fixed_by_kernel_commit ac6800e279a2 \
diff --git a/tests/generic/697 b/tests/generic/697
index 8d7ad6511..355753d25 100755
--- a/tests/generic/697
+++ b/tests/generic/697
@@ -17,9 +17,7 @@ _begin_fstest auto quick cap acl idmapped mount perms rw unlink
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 _require_acls
 _fixed_by_kernel_commit 1639a49ccdce \
diff --git a/tests/generic/698 b/tests/generic/698
index 143490b20..28928b2fb 100755
--- a/tests/generic/698
+++ b/tests/generic/698
@@ -22,8 +22,6 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs generic
 _fixed_by_kernel_commit 168f91289340 \
 	"fs: account for group membership"
 _require_scratch
diff --git a/tests/generic/699 b/tests/generic/699
index 82e83644c..677307538 100755
--- a/tests/generic/699
+++ b/tests/generic/699
@@ -21,7 +21,6 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-# real QA test starts here
 _supported_fs ^overlay
 _require_extra_fs overlay
 _require_scratch
diff --git a/tests/generic/700 b/tests/generic/700
index fcf4e3fe6..052cfbd62 100755
--- a/tests/generic/700
+++ b/tests/generic/700
@@ -15,8 +15,6 @@ _begin_fstest auto quick rename attr whiteout
 . ./common/attr
 . ./common/renameat2
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_attrs
 _require_renameat2 whiteout
diff --git a/tests/generic/701 b/tests/generic/701
index 26dec4034..527bba34e 100755
--- a/tests/generic/701
+++ b/tests/generic/701
@@ -22,7 +22,6 @@ _cleanup()
 	rm -r -f $tmp.* $junk_dir
 }
 
-_supported_fs generic
 _fixed_by_kernel_commit 92fba084b79e \
 	"exfat: fix i_blocks for files truncated over 4 GiB"
 
diff --git a/tests/generic/702 b/tests/generic/702
index f93bc9469..a506e07d7 100755
--- a/tests/generic/702
+++ b/tests/generic/702
@@ -17,7 +17,6 @@ _begin_fstest auto quick clone fiemap
 _fixed_by_kernel_commit ac3c0d36a2a2f7 \
 	"btrfs: make fiemap more efficient and accurate reporting extent sharedness"
 
-_supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "fiemap"
 
diff --git a/tests/generic/703 b/tests/generic/703
index 7afb7466f..8ee1d558c 100755
--- a/tests/generic/703
+++ b/tests/generic/703
@@ -27,7 +27,6 @@ test_file="${SCRATCH_MNT}/foo"
 	_fixed_by_kernel_commit 8184620ae212 \
 	"btrfs: fix lost file sync on direct IO write with nowait and dsync iocb"
 
-_supported_fs generic
 # We allocate 256M of data for the test file, so require a higher size of 512M
 # which gives a margin of safety for a COW filesystem like btrfs (where metadata
 # is always COWed).
diff --git a/tests/generic/704 b/tests/generic/704
index 6cc4bb4af..f39d47066 100755
--- a/tests/generic/704
+++ b/tests/generic/704
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/scsi_debug
 
-# real QA test starts here
-_supported_fs generic
 _fixed_by_kernel_commit 7c71ee78031c "xfs: allow logical-sector sized O_DIRECT"
 _require_scsi_debug
 # If TEST_DEV is block device, make sure current fs is a localfs which can be
diff --git a/tests/generic/705 b/tests/generic/705
index 7b6e5570b..9c27fbbc3 100755
--- a/tests/generic/705
+++ b/tests/generic/705
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto shutdown
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_scratch_shutdown
 _require_command "$FILEFRAG_PROG" filefrag
diff --git a/tests/generic/706 b/tests/generic/706
index b3e7aa7c6..ce248814f 100755
--- a/tests/generic/706
+++ b/tests/generic/706
@@ -14,7 +14,6 @@ _begin_fstest auto quick seek
 	_fixed_by_kernel_commit 2f2e84ca6066 \
 	"btrfs: fix off-by-one in delalloc search during lseek"
 
-_supported_fs generic
 _require_test
 _require_seek_data_hole
 _require_test_program "seek_sanity_test"
diff --git a/tests/generic/707 b/tests/generic/707
index da9dc5b6d..fd02eacf9 100755
--- a/tests/generic/707
+++ b/tests/generic/707
@@ -11,7 +11,6 @@
 . ./common/preamble
 _begin_fstest auto
 
-_supported_fs generic
 _require_scratch
 
 _fixed_by_kernel_commit f950fd052913 \
diff --git a/tests/generic/708 b/tests/generic/708
index 6809a50c8..53bb0ee4b 100755
--- a/tests/generic/708
+++ b/tests/generic/708
@@ -17,8 +17,6 @@ _begin_fstest quick auto
 	_fixed_by_kernel_commit b73a6fd1b1ef \
 		"btrfs: split partial dio bios before submit"
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_odirect
 _require_test_program dio-buf-fault
diff --git a/tests/generic/709 b/tests/generic/709
index f3b827cb0..e3994d003 100755
--- a/tests/generic/709
+++ b/tests/generic/709
@@ -13,7 +13,6 @@ _begin_fstest auto quick fiexchange quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_user
 _require_nobody
diff --git a/tests/generic/710 b/tests/generic/710
index c344bd898..072cddf57 100755
--- a/tests/generic/710
+++ b/tests/generic/710
@@ -13,7 +13,6 @@ _begin_fstest auto quick fiexchange quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_user
 _require_nobody
diff --git a/tests/generic/711 b/tests/generic/711
index 792136306..9c85b745a 100755
--- a/tests/generic/711
+++ b/tests/generic/711
@@ -20,7 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _require_xfs_io_command swapext
 _require_test
 
diff --git a/tests/generic/712 b/tests/generic/712
index a5f2ac26f..fa85ef1b7 100755
--- a/tests/generic/712
+++ b/tests/generic/712
@@ -19,7 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _require_test_program punch-alternating
 _require_xfs_io_command exchangerange
 _require_test
diff --git a/tests/generic/713 b/tests/generic/713
index b0165b1d9..5541aee0c 100755
--- a/tests/generic/713
+++ b/tests/generic/713
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_xfs_io_command exchangerange ' -s 64k -l 64k'
 _require_xfs_io_command "falloc"
 _require_test
diff --git a/tests/generic/714 b/tests/generic/714
index 4d2d4a0b4..66de1fb0c 100755
--- a/tests/generic/714
+++ b/tests/generic/714
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_xfs_io_command "falloc"
 _require_test_reflink
diff --git a/tests/generic/715 b/tests/generic/715
index 60a5381ea..9713038f0 100755
--- a/tests/generic/715
+++ b/tests/generic/715
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_xfs_io_command exchangerange ' -s 64k -l 64k'
 _require_test
 
diff --git a/tests/generic/716 b/tests/generic/716
index dbfa42637..a2b86225a 100755
--- a/tests/generic/716
+++ b/tests/generic/716
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_xfs_io_command startupdate
 _require_test_reflink
diff --git a/tests/generic/717 b/tests/generic/717
index 7bc917e55..4378e964a 100755
--- a/tests/generic/717
+++ b/tests/generic/717
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_xfs_io_command startupdate
 _require_test
diff --git a/tests/generic/718 b/tests/generic/718
index ab81dbec9..ed3a1fee5 100755
--- a/tests/generic/718
+++ b/tests/generic/718
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_test
 
diff --git a/tests/generic/719 b/tests/generic/719
index 1f8da3a9f..c82cf9552 100755
--- a/tests/generic/719
+++ b/tests/generic/719
@@ -22,7 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_xfs_io_command startupdate '-e'
 _require_test
diff --git a/tests/generic/720 b/tests/generic/720
index b44498884..9f6f18899 100755
--- a/tests/generic/720
+++ b/tests/generic/720
@@ -19,7 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_test_program punch-alternating
 _require_test
diff --git a/tests/generic/721 b/tests/generic/721
index 406e2b688..98505aac9 100755
--- a/tests/generic/721
+++ b/tests/generic/721
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_xfs_io_command startupdate
 _require_test_reflink
 _require_test
diff --git a/tests/generic/722 b/tests/generic/722
index 85afa2e0c..5542c045f 100755
--- a/tests/generic/722
+++ b/tests/generic/722
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_program "punch-alternating"
 _require_xfs_io_command exchangerange
 _require_scratch
diff --git a/tests/generic/723 b/tests/generic/723
index f1df1e53e..795f8ea2c 100755
--- a/tests/generic/723
+++ b/tests/generic/723
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_test_program "punch-alternating"
 _require_xfs_io_command exchangerange
 _require_scratch
diff --git a/tests/generic/724 b/tests/generic/724
index 2d58ccb9d..da202c6e5 100755
--- a/tests/generic/724
+++ b/tests/generic/724
@@ -21,7 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_scratch
 
diff --git a/tests/generic/725 b/tests/generic/725
index e5e2139c6..e1db83b5e 100755
--- a/tests/generic/725
+++ b/tests/generic/725
@@ -21,7 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_xfs_io_command startupdate '-e'
 _require_scratch
diff --git a/tests/generic/726 b/tests/generic/726
index 3b186ab6a..00071b1d0 100755
--- a/tests/generic/726
+++ b/tests/generic/726
@@ -20,10 +20,8 @@ _begin_fstest auto fiexchange quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_xfs_io_command exchangerange
 _require_xfs_io_command startupdate
diff --git a/tests/generic/727 b/tests/generic/727
index f737d4dd3..dbed1d45c 100755
--- a/tests/generic/727
+++ b/tests/generic/727
@@ -21,10 +21,8 @@ _begin_fstest auto fiexchange quick
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_user
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
diff --git a/tests/generic/728 b/tests/generic/728
index fe3486be4..9a2042791 100755
--- a/tests/generic/728
+++ b/tests/generic/728
@@ -13,8 +13,6 @@ _begin_fstest auto quick attr
 # Import common functions
 . ./common/attr
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_attrs
 
diff --git a/tests/generic/729 b/tests/generic/729
index 66242ed25..e0cd18d8c 100755
--- a/tests/generic/729
+++ b/tests/generic/729
@@ -27,9 +27,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs generic
 _require_test
 _require_odirect
 _require_test_program mmap-rw-fault
diff --git a/tests/generic/730 b/tests/generic/730
index 988c47e18..062314ea0 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/scsi_debug
 
-_supported_fs generic
 
 # We don't actually use the test device, but we need a block based fs
 _require_test
diff --git a/tests/generic/731 b/tests/generic/731
index b279e3f7b..cd39e8b09 100755
--- a/tests/generic/731
+++ b/tests/generic/731
@@ -24,7 +24,6 @@ _cleanup()
 # We don't actually use the test device, but we need a block based fs
 _require_test
 _require_block_device $TEST_DEV
-_supported_fs generic
 _require_scsi_debug
 
 size=$(_small_fs_size_mb 256)
diff --git a/tests/generic/732 b/tests/generic/732
index 7a40f49b9..a571f0f55 100755
--- a/tests/generic/732
+++ b/tests/generic/732
@@ -21,7 +21,6 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-# real QA test starts here
 _supported_fs ^nfs ^overlay
 
 _require_test
diff --git a/tests/generic/733 b/tests/generic/733
index f6ee7f715..aa7ad9942 100755
--- a/tests/generic/733
+++ b/tests/generic/733
@@ -18,8 +18,6 @@ _begin_fstest auto clone punch
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/generic/734 b/tests/generic/734
index 93c2ad90e..6eb9eb95c 100755
--- a/tests/generic/734
+++ b/tests/generic/734
@@ -19,7 +19,6 @@ _cleanup()
 	rm -r -f $tmp.* $testdir
 }
 
-# real QA test starts here
 
 # Import common functions.
 . ./common/filter
@@ -28,8 +27,6 @@ _cleanup()
 _fixed_by_git_commit kernel 35d30c9cf127 \
 	"iomap: don't skip reading in !uptodate folios when unsharing a range"
 
-# real QA test starts here
-_supported_fs generic
 _require_test_reflink
 _require_cp_reflink
 _require_xfs_io_command "funshare"
diff --git a/tests/generic/735 b/tests/generic/735
index 89107a610..1aeeb9a42 100755
--- a/tests/generic/735
+++ b/tests/generic/735
@@ -14,7 +14,6 @@
 . ./common/populate
 _begin_fstest auto quick insert prealloc
 
-# real QA test starts here
 if [[ "$FSTYP" =~ ext[0-9]+ ]]; then
 	_fixed_by_kernel_commit bc056e7163ac "ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
 	_fixed_by_kernel_commit 2dcf5fde6dff "ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS"
diff --git a/tests/generic/736 b/tests/generic/736
index d2432a82a..2fe7ba8e5 100755
--- a/tests/generic/736
+++ b/tests/generic/736
@@ -18,7 +18,6 @@ _cleanup()
 	rm -fr $target_dir
 }
 
-_supported_fs generic
 _require_test
 _require_test_program readdir-while-renames
 
diff --git a/tests/generic/737 b/tests/generic/737
index 4563b1bd5..99ca1f395 100755
--- a/tests/generic/737
+++ b/tests/generic/737
@@ -11,8 +11,6 @@
 . ./common/preamble
 _begin_fstest auto quick shutdown aio
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_scratch_shutdown
 _require_aiodio aio-dio-write-verify
diff --git a/tests/generic/738 b/tests/generic/738
index 2b37b1e73..4da2d8879 100755
--- a/tests/generic/738
+++ b/tests/generic/738
@@ -17,7 +17,6 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-_supported_fs generic
 _require_scratch
 _require_freeze
 
diff --git a/tests/generic/739 b/tests/generic/739
index 0941dd317..a7c972ecd 100755
--- a/tests/generic/739
+++ b/tests/generic/739
@@ -15,7 +15,6 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
-_supported_fs generic
 _wants_kernel_commit 5b1188847180 \
 	"fscrypt: support crypto data unit size less than filesystem block size"
 
diff --git a/tests/generic/741 b/tests/generic/741
index ad1592a10..4b480b5a1 100755
--- a/tests/generic/741
+++ b/tests/generic/741
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/generic/742 b/tests/generic/742
index aad57f2d6..68cf20e40 100755
--- a/tests/generic/742
+++ b/tests/generic/742
@@ -24,8 +24,6 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_test_program "fiemap-fault"
 _require_test_program "punch-alternating"
diff --git a/tests/generic/743 b/tests/generic/743
index 769ce706b..228ba764e 100755
--- a/tests/generic/743
+++ b/tests/generic/743
@@ -26,10 +26,8 @@ _cleanup()
 _fixed_by_kernel_commit 631426ba1d45 \
 	"mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly"
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_xfs_io_command madvise -R
 _require_scratch
 _require_dm_target error
diff --git a/tests/generic/744 b/tests/generic/744
index ef1de82db..a31d8d7a4 100755
--- a/tests/generic/744
+++ b/tests/generic/744
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/reflink
 
 # Modify as appropriate.
-_supported_fs generic
 _require_duplicate_fsid
 _require_test
 _require_block_device $TEST_DEV
diff --git a/tests/generic/746 b/tests/generic/746
index b13fd98a1..651affe07 100755
--- a/tests/generic/746
+++ b/tests/generic/746
@@ -9,7 +9,6 @@
 . ./common/preamble
 _begin_fstest auto trim fiemap
 
-_supported_fs generic
 _require_test
 _require_loop
 _require_fstrim
diff --git a/tests/generic/747 b/tests/generic/747
index bae1c8423..b92098f9f 100755
--- a/tests/generic/747
+++ b/tests/generic/747
@@ -14,8 +14,6 @@
 . ./common/preamble
 _begin_fstest auto
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 
 # This test requires specific data space usage, skip if we have compression
diff --git a/tests/generic/748 b/tests/generic/748
index 428d4a33d..062e29aa3 100755
--- a/tests/generic/748
+++ b/tests/generic/748
@@ -12,7 +12,6 @@
 . ./common/attr
 _begin_fstest auto quick log preallocrw dangerous
 
-_supported_fs generic
 _require_scratch
 _require_attrs
 _require_odirect
diff --git a/tests/generic/749 b/tests/generic/749
index 2dcced4e3..8b2c7feff 100755
--- a/tests/generic/749
+++ b/tests/generic/749
@@ -21,8 +21,6 @@ _begin_fstest auto quick prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch_nocheck
 _require_test
 _require_xfs_io_command "truncate"
diff --git a/tests/generic/750 b/tests/generic/750
index 3057937d7..dba8021d6 100755
--- a/tests/generic/750
+++ b/tests/generic/750
@@ -22,9 +22,7 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
 
-_supported_fs generic
 
 _require_scratch
 _require_vm_compaction
diff --git a/tests/generic/751 b/tests/generic/751
index 962d8d584..eac2d230a 100755
--- a/tests/generic/751
+++ b/tests/generic/751
@@ -77,8 +77,6 @@ fio_config=$tmp.fio
 fio_out=$tmp.fio.out
 fio_err=$tmp.fio.err
 
-# real QA test starts here
-_supported_fs generic
 _require_test
 _require_scratch
 _require_split_huge_pages_knob
diff --git a/tests/generic/752 b/tests/generic/752
index 2cdb2c7e6..12e8c09fd 100755
--- a/tests/generic/752
+++ b/tests/generic/752
@@ -20,7 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 _require_xfs_io_command exchangerange
 _require_test
 
diff --git a/tests/generic/753 b/tests/generic/753
index bb547a68a..e427d62d1 100755
--- a/tests/generic/753
+++ b/tests/generic/753
@@ -27,7 +27,6 @@ _cleanup()
 . ./common/dmerror
 
 # Modify as appropriate.
-_supported_fs generic
 
 _require_scratch
 _require_dm_target error
diff --git a/tests/generic/754 b/tests/generic/754
index e0dcb8664..f73d1ed61 100755
--- a/tests/generic/754
+++ b/tests/generic/754
@@ -11,7 +11,6 @@
 . ./common/preamble
 _begin_fstest auto
 
-_supported_fs generic
 _require_scratch
 
 test $FSTYP = "xfs" && \
diff --git a/tests/nfs/001 b/tests/nfs/001
index 5b5f08288..c7dbd6165 100755
--- a/tests/nfs/001
+++ b/tests/nfs/001
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs nfs
 _require_test_nfs_version 4
 _require_command $NFS4_SETFACL_PROG "nfs4_setfacl"
 _require_command $NFS4_GETFACL_PROG "nfs4_getfacl"
diff --git a/tests/ocfs2/001 b/tests/ocfs2/001
index 76c6b9dc3..164a78905 100755
--- a/tests/ocfs2/001
+++ b/tests/ocfs2/001
@@ -13,8 +13,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs ocfs2
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/overlay/001 b/tests/overlay/001
index c24d37a98..00462f05c 100755
--- a/tests/overlay/001
+++ b/tests/overlay/001
@@ -15,8 +15,6 @@ _begin_fstest auto quick copyup
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 
 # Remove all files from previous tests
diff --git a/tests/overlay/002 b/tests/overlay/002
index 11300edf6..6d9be8527 100755
--- a/tests/overlay/002
+++ b/tests/overlay/002
@@ -17,8 +17,6 @@ _begin_fstest auto quick metadata
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 
 # Remove all files from previous tests
diff --git a/tests/overlay/003 b/tests/overlay/003
index 9ee693988..41ad99e79 100755
--- a/tests/overlay/003
+++ b/tests/overlay/003
@@ -18,10 +18,8 @@ _begin_fstest auto quick whiteout
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 _require_scratch
 
 # Remove all files from previous tests
diff --git a/tests/overlay/004 b/tests/overlay/004
index f03f628a7..bea4bb543 100755
--- a/tests/overlay/004
+++ b/tests/overlay/004
@@ -13,7 +13,6 @@ _begin_fstest attr auto copyup quick perms
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs overlay
 _require_scratch
 _require_user
 
diff --git a/tests/overlay/005 b/tests/overlay/005
index a2b9c1d3e..4c11d5e1b 100755
--- a/tests/overlay/005
+++ b/tests/overlay/005
@@ -25,10 +25,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/006 b/tests/overlay/006
index 73eb80c9e..0903f76b8 100755
--- a/tests/overlay/006
+++ b/tests/overlay/006
@@ -16,8 +16,6 @@ _begin_fstest auto quick copyup whiteout
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 
 echo "Silence is golden"
diff --git a/tests/overlay/007 b/tests/overlay/007
index 5cd97de84..1705ce455 100755
--- a/tests/overlay/007
+++ b/tests/overlay/007
@@ -23,8 +23,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_test
 
 rm -rf $TEST_DIR/$seq
diff --git a/tests/overlay/008 b/tests/overlay/008
index 7bab4fbef..8570360ad 100755
--- a/tests/overlay/008
+++ b/tests/overlay/008
@@ -16,8 +16,6 @@ _begin_fstest auto quick whiteout perms
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_user
 
diff --git a/tests/overlay/009 b/tests/overlay/009
index d85ef16e4..8e585d278 100755
--- a/tests/overlay/009
+++ b/tests/overlay/009
@@ -15,8 +15,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_by_kernel_commit a4859d75944a \
 	"ovl: fix dentry leak for default_permissions"
 
diff --git a/tests/overlay/010 b/tests/overlay/010
index af22b2b40..ecdf9e23c 100755
--- a/tests/overlay/010
+++ b/tests/overlay/010
@@ -15,8 +15,6 @@ _begin_fstest auto quick whiteout
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_by_kernel_commit 84889d493356 \
 	"ovl: check dentry positiveness in ovl_cleanup_whiteouts()"
 
diff --git a/tests/overlay/011 b/tests/overlay/011
index 09a950baf..a05568f8f 100755
--- a/tests/overlay/011
+++ b/tests/overlay/011
@@ -17,8 +17,6 @@ _begin_fstest auto quick
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 _require_test
 _require_scratch
 _require_attrs trusted
diff --git a/tests/overlay/012 b/tests/overlay/012
index ee6e1bf3a..ac25d7ca3 100755
--- a/tests/overlay/012
+++ b/tests/overlay/012
@@ -17,8 +17,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 
 # remove all files from previous runs
diff --git a/tests/overlay/013 b/tests/overlay/013
index 51fd23972..73c72c30d 100755
--- a/tests/overlay/013
+++ b/tests/overlay/013
@@ -14,8 +14,6 @@ _begin_fstest auto quick copyup
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_test_program "t_truncate_self"
 
diff --git a/tests/overlay/014 b/tests/overlay/014
index 2d6c11d99..f07fc6855 100755
--- a/tests/overlay/014
+++ b/tests/overlay/014
@@ -19,8 +19,6 @@ _begin_fstest auto quick copyup
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_by_kernel_commit 0956254a2d5b "ovl: don't copy up opaqueness"
 
 # Use non-default scratch underlying overlay dirs, we need to check
diff --git a/tests/overlay/015 b/tests/overlay/015
index f0c055797..e249ab24c 100755
--- a/tests/overlay/015
+++ b/tests/overlay/015
@@ -12,8 +12,6 @@ _begin_fstest auto quick whiteout perms
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_user
 _require_group
diff --git a/tests/overlay/016 b/tests/overlay/016
index 7b4a3dad5..26ce6fbaa 100755
--- a/tests/overlay/016
+++ b/tests/overlay/016
@@ -17,8 +17,6 @@ _begin_fstest auto quick copyup
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v4.19"
 
 _require_scratch
diff --git a/tests/overlay/017 b/tests/overlay/017
index 0bb248c25..06a93fedb 100755
--- a/tests/overlay/017
+++ b/tests/overlay/017
@@ -21,8 +21,6 @@ _begin_fstest auto quick copyup redirect
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v4.14"
 
 _require_scratch
diff --git a/tests/overlay/018 b/tests/overlay/018
index 4cccbbdc6..648f8ce90 100755
--- a/tests/overlay/018
+++ b/tests/overlay/018
@@ -17,8 +17,6 @@ _begin_fstest auto quick copyup hardlink
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v4.13"
 
 _require_scratch
diff --git a/tests/overlay/019 b/tests/overlay/019
index 72c8a5a45..ae026604d 100755
--- a/tests/overlay/019
+++ b/tests/overlay/019
@@ -12,8 +12,6 @@ _begin_fstest auto stress
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch_nocheck
 
 # Remove all files from previous tests
diff --git a/tests/overlay/020 b/tests/overlay/020
index 9f82da344..7856bc97f 100755
--- a/tests/overlay/020
+++ b/tests/overlay/020
@@ -14,10 +14,8 @@ _begin_fstest auto quick copyup perms
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 _fixed_by_kernel_commit 3fe6e52f0626 \
 	"ovl: override creds with the ones from the superblock mounter"
 
diff --git a/tests/overlay/021 b/tests/overlay/021
index 19c4b5cad..95a9ada5d 100755
--- a/tests/overlay/021
+++ b/tests/overlay/021
@@ -12,8 +12,6 @@ _begin_fstest auto quick copyup
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 
 # Remove all files from previous tests
diff --git a/tests/overlay/022 b/tests/overlay/022
index 09af6500c..d33bd2978 100755
--- a/tests/overlay/022
+++ b/tests/overlay/022
@@ -25,10 +25,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 _fixed_by_kernel_commit 76bc8e2843b6 "ovl: disallow overlayfs as upperdir"
 
 _require_scratch
diff --git a/tests/overlay/023 b/tests/overlay/023
index 740c47c1d..43ed2551a 100755
--- a/tests/overlay/023
+++ b/tests/overlay/023
@@ -20,10 +20,8 @@ _begin_fstest auto quick attr perms
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 _require_acls
 _require_scratch
 
diff --git a/tests/overlay/024 b/tests/overlay/024
index d9a3e4098..9f3a12f49 100755
--- a/tests/overlay/024
+++ b/tests/overlay/024
@@ -19,10 +19,8 @@ _begin_fstest auto quick mount
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 _require_scratch
 
 # Remove all files from previous tests
diff --git a/tests/overlay/025 b/tests/overlay/025
index 3e237910b..dc819a393 100755
--- a/tests/overlay/025
+++ b/tests/overlay/025
@@ -28,10 +28,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 _require_user
 _require_extra_fs tmpfs
 
diff --git a/tests/overlay/026 b/tests/overlay/026
index 25c70bc87..06a1c9223 100755
--- a/tests/overlay/026
+++ b/tests/overlay/026
@@ -31,10 +31,8 @@ _begin_fstest auto attr quick
 . ./common/attr
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 _require_scratch
 _require_attrs trusted
 
diff --git a/tests/overlay/027 b/tests/overlay/027
index aa47bd7a3..cc9e6789c 100755
--- a/tests/overlay/027
+++ b/tests/overlay/027
@@ -27,10 +27,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 _require_scratch
 _require_chattr i
 
diff --git a/tests/overlay/028 b/tests/overlay/028
index 2b56aa75b..26e9433fc 100755
--- a/tests/overlay/028
+++ b/tests/overlay/028
@@ -19,10 +19,8 @@ _begin_fstest auto copyup quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 _require_scratch
 _require_command "$FLOCK_PROG" flock
 
diff --git a/tests/overlay/029 b/tests/overlay/029
index c4c8eed77..4bade9a0e 100755
--- a/tests/overlay/029
+++ b/tests/overlay/029
@@ -30,10 +30,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs overlay
 _fixed_by_kernel_commit c4fcfc1619ea "ovl: fix d_real() for stacked fs"
 
 _require_scratch
diff --git a/tests/overlay/030 b/tests/overlay/030
index 6c207d2a9..af3012e71 100755
--- a/tests/overlay/030
+++ b/tests/overlay/030
@@ -30,7 +30,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs overlay
 
 _require_chattr ia
 _require_test_program "t_immutable"
diff --git a/tests/overlay/031 b/tests/overlay/031
index 8fdf482b3..dd9dfcdb9 100755
--- a/tests/overlay/031
+++ b/tests/overlay/031
@@ -34,8 +34,6 @@ create_whiteout()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch_nocheck
 
 # remove all files from previous runs
diff --git a/tests/overlay/032 b/tests/overlay/032
index 2c8221a05..6103f5ef6 100755
--- a/tests/overlay/032
+++ b/tests/overlay/032
@@ -18,8 +18,6 @@ _begin_fstest auto quick copyup hardlink
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_scratch_feature index
 
diff --git a/tests/overlay/033 b/tests/overlay/033
index 15175cdf7..0a6345609 100755
--- a/tests/overlay/033
+++ b/tests/overlay/033
@@ -15,8 +15,6 @@ _begin_fstest auto quick copyup hardlink
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_scratch_feature index
 
diff --git a/tests/overlay/034 b/tests/overlay/034
index fcecb3871..ec3a0953b 100755
--- a/tests/overlay/034
+++ b/tests/overlay/034
@@ -29,8 +29,6 @@ _begin_fstest auto quick copyup hardlink
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 # Without overlay index feature hardlinks are broken on copy up
 _require_scratch_feature index
diff --git a/tests/overlay/035 b/tests/overlay/035
index f4c981ad5..0b3257c4c 100755
--- a/tests/overlay/035
+++ b/tests/overlay/035
@@ -23,8 +23,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/036 b/tests/overlay/036
index 5a93d4805..19a181bbd 100755
--- a/tests/overlay/036
+++ b/tests/overlay/036
@@ -41,8 +41,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/037 b/tests/overlay/037
index c188088e2..834e17638 100755
--- a/tests/overlay/037
+++ b/tests/overlay/037
@@ -20,8 +20,6 @@ _begin_fstest auto quick mount
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/038 b/tests/overlay/038
index 19c000cee..3e7878e5b 100755
--- a/tests/overlay/038
+++ b/tests/overlay/038
@@ -13,8 +13,6 @@ _begin_fstest auto quick copyup
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v4.14"
 
 # Use non-default scratch underlying overlay dirs, we need to check
diff --git a/tests/overlay/039 b/tests/overlay/039
index 21efa2f2a..fd9e986b3 100755
--- a/tests/overlay/039
+++ b/tests/overlay/039
@@ -15,8 +15,6 @@ _begin_fstest auto quick atime
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_relatime
 
diff --git a/tests/overlay/040 b/tests/overlay/040
index 9f4da94b0..11c7bf129 100755
--- a/tests/overlay/040
+++ b/tests/overlay/040
@@ -28,8 +28,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_chattr i
 
diff --git a/tests/overlay/041 b/tests/overlay/041
index a326b6b0a..36491b8fa 100755
--- a/tests/overlay/041
+++ b/tests/overlay/041
@@ -15,8 +15,6 @@ _begin_fstest auto quick copyup nonsamefs
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v4.17"
 
 # Use non-default scratch underlying overlay dirs, we need to check
diff --git a/tests/overlay/042 b/tests/overlay/042
index 0715066fe..aaa10da33 100755
--- a/tests/overlay/042
+++ b/tests/overlay/042
@@ -24,8 +24,6 @@ _begin_fstest auto quick copyup hardlink
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_by_kernel_commit 6eaf011144af \
 	"ovl: fix EIO from lookup of non-indexed upper"
 
diff --git a/tests/overlay/043 b/tests/overlay/043
index 56f892140..7325c653a 100755
--- a/tests/overlay/043
+++ b/tests/overlay/043
@@ -23,8 +23,6 @@ _begin_fstest auto quick copyup nonsamefs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v4.17"
 
 # Use non-default scratch underlying overlay dirs, we need to check
diff --git a/tests/overlay/044 b/tests/overlay/044
index 3f74890fa..4d04d883e 100755
--- a/tests/overlay/044
+++ b/tests/overlay/044
@@ -18,8 +18,6 @@ _begin_fstest auto quick copyup hardlink nonsamefs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v4.17"
 
 # Use non-default scratch underlying overlay dirs, we need to check
diff --git a/tests/overlay/045 b/tests/overlay/045
index fd8264279..c5d75a691 100755
--- a/tests/overlay/045
+++ b/tests/overlay/045
@@ -13,8 +13,6 @@ _begin_fstest auto quick fsck
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch_nocheck
 _require_attrs trusted
 _require_command "$FSCK_OVERLAY_PROG" fsck.overlay
diff --git a/tests/overlay/046 b/tests/overlay/046
index b7f1b710d..31066dedf 100755
--- a/tests/overlay/046
+++ b/tests/overlay/046
@@ -13,8 +13,6 @@ _begin_fstest auto quick fsck
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch_nocheck
 _require_attrs trusted
 _require_command "$FSCK_OVERLAY_PROG" fsck.overlay
diff --git a/tests/overlay/047 b/tests/overlay/047
index fb0bac195..98c4f07c2 100755
--- a/tests/overlay/047
+++ b/tests/overlay/047
@@ -17,8 +17,6 @@ _begin_fstest auto quick copyup hardlink
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_scratch_feature index
 
diff --git a/tests/overlay/048 b/tests/overlay/048
index 7fe6e17c2..897e797e2 100755
--- a/tests/overlay/048
+++ b/tests/overlay/048
@@ -16,8 +16,6 @@ _begin_fstest auto quick copyup hardlink
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_scratch_feature index
 
diff --git a/tests/overlay/049 b/tests/overlay/049
index 8dd41bd70..3ee500c5d 100755
--- a/tests/overlay/049
+++ b/tests/overlay/049
@@ -38,8 +38,6 @@ create_redirect()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch_nocheck
 _require_scratch_feature redirect_dir
 
diff --git a/tests/overlay/050 b/tests/overlay/050
index e24338e11..ec936e2a7 100755
--- a/tests/overlay/050
+++ b/tests/overlay/050
@@ -20,9 +20,7 @@ _begin_fstest auto quick copyup hardlink exportfs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 _require_test_program "open_by_handle"
 # We need to require both features together, because nfs_export cannot
diff --git a/tests/overlay/051 b/tests/overlay/051
index 4b26dd844..9404dbbab 100755
--- a/tests/overlay/051
+++ b/tests/overlay/051
@@ -34,9 +34,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_test_program "open_by_handle"
 # Use non-default scratch underlying overlay dirs, we need to check
diff --git a/tests/overlay/052 b/tests/overlay/052
index 6abe2e018..37402067d 100755
--- a/tests/overlay/052
+++ b/tests/overlay/052
@@ -21,9 +21,7 @@ _begin_fstest auto quick copyup redirect exportfs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 _require_test_program "open_by_handle"
 # We need to require all features together, because nfs_export cannot
diff --git a/tests/overlay/053 b/tests/overlay/053
index cf94f9302..f7891aced 100755
--- a/tests/overlay/053
+++ b/tests/overlay/053
@@ -36,9 +36,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_test_program "open_by_handle"
 # Use non-default scratch underlying overlay dirs, we need to check
diff --git a/tests/overlay/054 b/tests/overlay/054
index ba20a7fc8..8d7f026a2 100755
--- a/tests/overlay/054
+++ b/tests/overlay/054
@@ -34,9 +34,7 @@ _begin_fstest auto quick copyup redirect exportfs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _fixed_by_kernel_commit 2ca3c148a062 \
 	"ovl: check lower ancestry on encode of lower dir file handle"
 
diff --git a/tests/overlay/055 b/tests/overlay/055
index 367f038b2..87a348c94 100755
--- a/tests/overlay/055
+++ b/tests/overlay/055
@@ -43,9 +43,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _fixed_by_kernel_commit 2ca3c148a062 \
 	"ovl: check lower ancestry on encode of lower dir file handle"
 
diff --git a/tests/overlay/056 b/tests/overlay/056
index 0516acbb8..158f34d05 100755
--- a/tests/overlay/056
+++ b/tests/overlay/056
@@ -13,8 +13,6 @@ _begin_fstest auto quick fsck
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch_nocheck
 _require_attrs trusted
 _require_command "$FSCK_OVERLAY_PROG" fsck.overlay
diff --git a/tests/overlay/057 b/tests/overlay/057
index 4bfc32a42..da7ffda30 100755
--- a/tests/overlay/057
+++ b/tests/overlay/057
@@ -25,8 +25,6 @@ _begin_fstest auto quick redirect
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 # We use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/058 b/tests/overlay/058
index 7352482e6..b70e06638 100755
--- a/tests/overlay/058
+++ b/tests/overlay/058
@@ -30,9 +30,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 _require_test_program "open_by_handle"
 # We need to require all features together, because nfs_export cannot
diff --git a/tests/overlay/059 b/tests/overlay/059
index 01720c5fd..c48d2a82c 100755
--- a/tests/overlay/059
+++ b/tests/overlay/059
@@ -39,8 +39,6 @@ create_origin_ref()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch_nocheck
 _require_scratch_feature redirect_dir
 
diff --git a/tests/overlay/060 b/tests/overlay/060
index f37755da1..bb61fcfa6 100755
--- a/tests/overlay/060
+++ b/tests/overlay/060
@@ -13,8 +13,6 @@ _begin_fstest auto quick metacopy redirect prealloc
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 # We use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/061 b/tests/overlay/061
index b80cf5a00..bf4ad6de6 100755
--- a/tests/overlay/061
+++ b/tests/overlay/061
@@ -20,8 +20,6 @@ _begin_fstest posix copyup
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_xfs_io_command "open"
 
diff --git a/tests/overlay/062 b/tests/overlay/062
index a4e9560a3..e44628b74 100755
--- a/tests/overlay/062
+++ b/tests/overlay/062
@@ -24,9 +24,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 _require_test_program "open_by_handle"
 # We need to require all features together, because nfs_export cannot
diff --git a/tests/overlay/063 b/tests/overlay/063
index f7bd46e49..d9f30606a 100755
--- a/tests/overlay/063
+++ b/tests/overlay/063
@@ -15,8 +15,6 @@ _begin_fstest auto quick whiteout
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_by_kernel_commit 5e1275808630 \
 	"ovl: check whiteout in ovl_create_over_whiteout()"
 
diff --git a/tests/overlay/064 b/tests/overlay/064
index 1dd6bd6cf..1f344edce 100755
--- a/tests/overlay/064
+++ b/tests/overlay/064
@@ -12,8 +12,6 @@ _begin_fstest auto quick copyup
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_command "$SETCAP_PROG" setcap
 _require_command "$GETCAP_PROG" getcap
diff --git a/tests/overlay/065 b/tests/overlay/065
index e1bed4c7b..fb6d6dd1b 100755
--- a/tests/overlay/065
+++ b/tests/overlay/065
@@ -36,8 +36,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v5.2"
 _fixed_by_kernel_commit 0be0bfd2de9d \
 	"ovl: fix regression caused by overlapping layers detection"
diff --git a/tests/overlay/066 b/tests/overlay/066
index 5b9f7b186..b6dc2f67e 100755
--- a/tests/overlay/066
+++ b/tests/overlay/066
@@ -16,7 +16,6 @@ _begin_fstest auto quick copyup fiemap
 # real QA test starts here.
 
 # Modify as appropriate.
-_supported_fs generic
 _require_test
 _require_scratch
 
diff --git a/tests/overlay/067 b/tests/overlay/067
index 3f54a418d..bb09a6042 100755
--- a/tests/overlay/067
+++ b/tests/overlay/067
@@ -18,8 +18,6 @@ _begin_fstest auto quick copyup nonsamefs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_by_kernel_commit 9c6d8f13e9da \
 	"ovl: fix corner case of non-unique st_dev;st_ino"
 
diff --git a/tests/overlay/068 b/tests/overlay/068
index bc3cd5694..0d33cf12d 100755
--- a/tests/overlay/068
+++ b/tests/overlay/068
@@ -34,9 +34,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 # _require_exportfs already requires open_by_handle, but let's not count on it
 _require_test_program "open_by_handle"
diff --git a/tests/overlay/069 b/tests/overlay/069
index b4e544322..373ab1ee3 100755
--- a/tests/overlay/069
+++ b/tests/overlay/069
@@ -34,9 +34,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_scratch_nocheck
 # _require_exportfs already requires open_by_handle, but let's not count on it
diff --git a/tests/overlay/070 b/tests/overlay/070
index a4ec2f032..36991229f 100755
--- a/tests/overlay/070
+++ b/tests/overlay/070
@@ -33,8 +33,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v4.17"
 
 _require_scratch_nocheck
diff --git a/tests/overlay/071 b/tests/overlay/071
index c22e3880d..2a6313142 100755
--- a/tests/overlay/071
+++ b/tests/overlay/071
@@ -36,8 +36,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v4.17"
 
 _require_test
diff --git a/tests/overlay/072 b/tests/overlay/072
index 6f5e77df4..aedcfb1a3 100755
--- a/tests/overlay/072
+++ b/tests/overlay/072
@@ -26,8 +26,6 @@ _begin_fstest auto quick copyup hardlink
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_by_kernel_commit 83552eacdfc0 "ovl: fix WARN_ON nlink drop to zero"
 
 _require_scratch
diff --git a/tests/overlay/073 b/tests/overlay/073
index 53ba0d6a5..9c6dd8c54 100755
--- a/tests/overlay/073
+++ b/tests/overlay/073
@@ -21,8 +21,6 @@ _begin_fstest auto quick whiteout
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 # Require index dir to test if workdir/work is not in use
 # which implies that whiteout sharing is supported
diff --git a/tests/overlay/074 b/tests/overlay/074
index d37386497..cfac9f8a5 100755
--- a/tests/overlay/074
+++ b/tests/overlay/074
@@ -19,9 +19,7 @@ _begin_fstest auto quick exportfs dangerous
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _fixed_by_kernel_commit 144da23beab8 \
 	"ovl: return required buffer size for file handles"
 _fixed_by_kernel_commit 9aafc1b01873 \
diff --git a/tests/overlay/075 b/tests/overlay/075
index 911c3d08c..670412424 100755
--- a/tests/overlay/075
+++ b/tests/overlay/075
@@ -33,7 +33,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs overlay
 
 _require_chattr ia
 _require_test_program "t_immutable"
diff --git a/tests/overlay/076 b/tests/overlay/076
index 646cfcc1f..fb94dff68 100755
--- a/tests/overlay/076
+++ b/tests/overlay/076
@@ -26,8 +26,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _require_scratch
 _require_chattr i
 
diff --git a/tests/overlay/077 b/tests/overlay/077
index 702ff54c5..00de0825a 100755
--- a/tests/overlay/077
+++ b/tests/overlay/077
@@ -16,8 +16,6 @@ _begin_fstest auto quick dir
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_by_kernel_commit 65cd913ec9d9 \
 	"ovl: invalidate readdir cache on changes to dir with origin"
 _fixed_by_kernel_commit 9011c2791e63 \
diff --git a/tests/overlay/078 b/tests/overlay/078
index 3c15f4b76..d6df11f68 100755
--- a/tests/overlay/078
+++ b/tests/overlay/078
@@ -31,8 +31,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_in_kernel_version "v5.13"
 
 _require_command "$LSATTR_PROG" lasttr
diff --git a/tests/overlay/079 b/tests/overlay/079
index f28fc3135..cfcafceea 100755
--- a/tests/overlay/079
+++ b/tests/overlay/079
@@ -14,8 +14,6 @@ _begin_fstest auto quick metacopy redirect prealloc
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 # We use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/080 b/tests/overlay/080
index 0b5dca09b..ce5c2375f 100755
--- a/tests/overlay/080
+++ b/tests/overlay/080
@@ -15,8 +15,6 @@ _begin_fstest auto quick metacopy redirect verity
 . ./common/attr
 . ./common/verity
 
-# real QA test starts here
-_supported_fs overlay
 # We use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/081 b/tests/overlay/081
index 481e99313..2270a0475 100755
--- a/tests/overlay/081
+++ b/tests/overlay/081
@@ -14,8 +14,6 @@ _begin_fstest auto quick
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 
 _scratch_mkfs >>$seqres.full 2>&1
 
diff --git a/tests/overlay/082 b/tests/overlay/082
index 7409917b4..b3262ae54 100755
--- a/tests/overlay/082
+++ b/tests/overlay/082
@@ -13,8 +13,6 @@
 . ./common/preamble
 _begin_fstest auto quick copyup symlink atime
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_by_kernel_commit ab048302026d \
 	"ovl: fix failed copyup of fileattr on a symlink"
 
diff --git a/tests/overlay/083 b/tests/overlay/083
index df82d1fd4..d037d4c85 100755
--- a/tests/overlay/083
+++ b/tests/overlay/083
@@ -17,8 +17,6 @@ _begin_fstest auto quick mount
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 _fixed_by_kernel_commit 32db51070850 \
 	"ovl: fix regression in showing lowerdir mount option"
 _fixed_by_kernel_commit c34706acf40b \
diff --git a/tests/overlay/084 b/tests/overlay/084
index 778396a10..28e9a76dc 100755
--- a/tests/overlay/084
+++ b/tests/overlay/084
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 # This test does not run on kernels prior ro v6.7 and now it will also make sure
 # that the following on-disk format change was backported to v6.7 based kernels
 _fixed_by_kernel_commit 420332b94119 \
diff --git a/tests/overlay/085 b/tests/overlay/085
index 0f4e4b06d..046d01d16 100755
--- a/tests/overlay/085
+++ b/tests/overlay/085
@@ -15,8 +15,6 @@ _begin_fstest auto quick metacopy redirect prealloc
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs overlay
 # We use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
diff --git a/tests/overlay/086 b/tests/overlay/086
index b59605173..9c8a00588 100755
--- a/tests/overlay/086
+++ b/tests/overlay/086
@@ -13,8 +13,6 @@ _begin_fstest auto quick mount
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs overlay
 
 # _overlay_check_* helpers do not handle special chars well
 _require_scratch_nocheck
diff --git a/tests/overlay/100 b/tests/overlay/100
index b958088e1..8975c6f39 100755
--- a/tests/overlay/100
+++ b/tests/overlay/100
@@ -15,9 +15,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 _require_unionmount_testsuite
 
diff --git a/tests/overlay/101 b/tests/overlay/101
index 99dd72fa0..f9b0fd400 100755
--- a/tests/overlay/101
+++ b/tests/overlay/101
@@ -15,9 +15,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_scratch
 _require_unionmount_testsuite
diff --git a/tests/overlay/102 b/tests/overlay/102
index adddab70f..0b608ecf1 100755
--- a/tests/overlay/102
+++ b/tests/overlay/102
@@ -16,9 +16,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_scratch
 _require_unionmount_testsuite
diff --git a/tests/overlay/103 b/tests/overlay/103
index 1a1b823e1..7be4912e9 100755
--- a/tests/overlay/103
+++ b/tests/overlay/103
@@ -15,9 +15,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 _require_unionmount_testsuite
 
diff --git a/tests/overlay/104 b/tests/overlay/104
index 090abbdda..101564030 100755
--- a/tests/overlay/104
+++ b/tests/overlay/104
@@ -15,9 +15,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_scratch
 _require_unionmount_testsuite
diff --git a/tests/overlay/105 b/tests/overlay/105
index 8c3b149c6..3a7112cd3 100755
--- a/tests/overlay/105
+++ b/tests/overlay/105
@@ -16,9 +16,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_scratch
 _require_unionmount_testsuite
diff --git a/tests/overlay/106 b/tests/overlay/106
index d701e49c5..9a80a526f 100755
--- a/tests/overlay/106
+++ b/tests/overlay/106
@@ -16,9 +16,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_extra_fs tmpfs
 _require_test
 _require_scratch
diff --git a/tests/overlay/107 b/tests/overlay/107
index 8ae3dc0dd..f149827c9 100755
--- a/tests/overlay/107
+++ b/tests/overlay/107
@@ -16,9 +16,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_extra_fs tmpfs
 _require_test
 _require_scratch
diff --git a/tests/overlay/108 b/tests/overlay/108
index 4e0e9c719..a5338a1ab 100755
--- a/tests/overlay/108
+++ b/tests/overlay/108
@@ -16,9 +16,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_extra_fs tmpfs
 _require_test
 _require_scratch
diff --git a/tests/overlay/109 b/tests/overlay/109
index 973381674..2ca32279f 100755
--- a/tests/overlay/109
+++ b/tests/overlay/109
@@ -16,9 +16,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_extra_fs tmpfs
 _require_test
 _require_scratch
diff --git a/tests/overlay/110 b/tests/overlay/110
index 414ebcae6..0508622bb 100755
--- a/tests/overlay/110
+++ b/tests/overlay/110
@@ -16,9 +16,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 _require_unionmount_testsuite
 
diff --git a/tests/overlay/111 b/tests/overlay/111
index 93835f40d..815d91a4d 100755
--- a/tests/overlay/111
+++ b/tests/overlay/111
@@ -17,9 +17,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 _require_unionmount_testsuite
 
diff --git a/tests/overlay/112 b/tests/overlay/112
index 33d3338bb..b29a5eed4 100755
--- a/tests/overlay/112
+++ b/tests/overlay/112
@@ -16,9 +16,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_scratch
 _require_unionmount_testsuite
diff --git a/tests/overlay/113 b/tests/overlay/113
index 548af67a2..cf996da99 100755
--- a/tests/overlay/113
+++ b/tests/overlay/113
@@ -17,9 +17,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_scratch
 _require_unionmount_testsuite
diff --git a/tests/overlay/114 b/tests/overlay/114
index 7e9ec9f7e..f6e7f7bd8 100755
--- a/tests/overlay/114
+++ b/tests/overlay/114
@@ -16,9 +16,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 _require_unionmount_testsuite
 
diff --git a/tests/overlay/115 b/tests/overlay/115
index 8f4159d2f..c515044fc 100755
--- a/tests/overlay/115
+++ b/tests/overlay/115
@@ -17,9 +17,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_scratch
 _require_unionmount_testsuite
 
diff --git a/tests/overlay/116 b/tests/overlay/116
index 084ea84c8..8615389ae 100755
--- a/tests/overlay/116
+++ b/tests/overlay/116
@@ -16,9 +16,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_scratch
 _require_unionmount_testsuite
diff --git a/tests/overlay/117 b/tests/overlay/117
index b98b79ae7..28959fb14 100755
--- a/tests/overlay/117
+++ b/tests/overlay/117
@@ -17,9 +17,7 @@ _register_cleanup "_unionmount_testsuite_cleanup"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs overlay
 _require_test
 _require_scratch
 _require_unionmount_testsuite
diff --git a/tests/perf/001 b/tests/perf/001
index 5e622b69d..a051a130d 100755
--- a/tests/perf/001
+++ b/tests/perf/001
@@ -16,8 +16,6 @@ fio_results=$tmp.json
 . ./common/filter
 . ./common/perf
 
-# real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_block_device $SCRATCH_DEV
 _require_fio_results
diff --git a/tests/tmpfs/001 b/tests/tmpfs/001
index 37ef0b183..48a57693f 100755
--- a/tests/tmpfs/001
+++ b/tests/tmpfs/001
@@ -12,9 +12,7 @@ _begin_fstest auto quick idmapped
 # get standard environment, filters and checks
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs tmpfs
 _require_idmapped_mounts
 _require_test
 
diff --git a/tests/udf/102 b/tests/udf/102
index a086ecea9..8053dd822 100755
--- a/tests/udf/102
+++ b/tests/udf/102
@@ -19,9 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs udf 
-
 _require_scratch
 _setup_udf_scratchdir
 
diff --git a/tests/xfs/001 b/tests/xfs/001
index 8e6c58353..ccba562c0 100755
--- a/tests/xfs/001
+++ b/tests/xfs/001
@@ -30,10 +30,8 @@ _do_bit_test()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch_nocheck
 
 _scratch_mkfs >/dev/null 2>&1
diff --git a/tests/xfs/002 b/tests/xfs/002
index 26d0cd6e4..c9450ff40 100755
--- a/tests/xfs/002
+++ b/tests/xfs/002
@@ -20,7 +20,6 @@ _begin_fstest auto quick growfs
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch_nocheck
 _require_no_large_scratch_dev
 _require_xfs_nocrc
diff --git a/tests/xfs/003 b/tests/xfs/003
index 431c7ce07..591c1365c 100755
--- a/tests/xfs/003
+++ b/tests/xfs/003
@@ -14,8 +14,6 @@ _begin_fstest db auto quick
 
 status=0	# success is the default!
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 
 [ -f core ] && rm -f core
@@ -29,7 +27,6 @@ test_done()
         rm -f core
 }
 
-# real QA test starts here
 
 echo "=== TEST 1 ==="
 _test_xfs_db -r -c 'pop' -c 'type sb'
diff --git a/tests/xfs/004 b/tests/xfs/004
index f18316b33..941296257 100755
--- a/tests/xfs/004
+++ b/tests/xfs/004
@@ -39,8 +39,6 @@ _populate_scratch()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_no_large_scratch_dev
diff --git a/tests/xfs/005 b/tests/xfs/005
index 019790295..0c8061b0f 100755
--- a/tests/xfs/005
+++ b/tests/xfs/005
@@ -17,7 +17,6 @@ _begin_fstest auto quick
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch_nocheck
 
diff --git a/tests/xfs/006 b/tests/xfs/006
index cecceaa3b..50b36947d 100755
--- a/tests/xfs/006
+++ b/tests/xfs/006
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_dm_target error
 _require_fs_sysfs error/fail_at_unmount
diff --git a/tests/xfs/007 b/tests/xfs/007
index 4f864100f..2535f04ca 100755
--- a/tests/xfs/007
+++ b/tests/xfs/007
@@ -14,7 +14,6 @@ _begin_fstest auto quota quick
 . ./common/quota
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_quota
diff --git a/tests/xfs/008 b/tests/xfs/008
index f42b3ac84..d90a2a249 100755
--- a/tests/xfs/008
+++ b/tests/xfs/008
@@ -63,8 +63,6 @@ _do_test()
     fi
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 
 # Note on special numbers here.
diff --git a/tests/xfs/009 b/tests/xfs/009
index 54270243f..986459036 100755
--- a/tests/xfs/009
+++ b/tests/xfs/009
@@ -37,8 +37,6 @@ _init()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/010 b/tests/xfs/010
index 16c08b852..689e370e4 100755
--- a/tests/xfs/010
+++ b/tests/xfs/010
@@ -80,8 +80,6 @@ _corrupt_finobt_root()
 		$dev | grep -v "Allowing write of corrupted"
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_mkfs_finobt
diff --git a/tests/xfs/011 b/tests/xfs/011
index ed44d074b..f9303d594 100755
--- a/tests/xfs/011
+++ b/tests/xfs/011
@@ -58,8 +58,6 @@ _check_scratch_log_state()
 	xfs_freeze -u $SCRATCH_MNT
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_freeze
diff --git a/tests/xfs/012 b/tests/xfs/012
index e0dccc4e4..e4785a770 100755
--- a/tests/xfs/012
+++ b/tests/xfs/012
@@ -81,8 +81,6 @@ _do_test()
     fi
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 
 # small & fairly dense
diff --git a/tests/xfs/013 b/tests/xfs/013
index 2d005753d..f4f406aa9 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -80,8 +80,6 @@ _cleaner()
 	done
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_mkfs_finobt
diff --git a/tests/xfs/014 b/tests/xfs/014
index be25c1764..098f64186 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -145,8 +145,6 @@ _test_edquot()
 	$XFS_IO_PROG -c "pwrite 0 $write_size" $dir/file >> $seqres.full
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/015 b/tests/xfs/015
index 3896ce1c3..acaace0ce 100755
--- a/tests/xfs/015
+++ b/tests/xfs/015
@@ -32,8 +32,6 @@ create_file()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 
diff --git a/tests/xfs/016 b/tests/xfs/016
index 6337bb1f4..6c15dbbfb 100755
--- a/tests/xfs/016
+++ b/tests/xfs/016
@@ -166,8 +166,6 @@ _check_corrupt()
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _init
diff --git a/tests/xfs/017 b/tests/xfs/017
index 8a20e5925..efe0ac119 100755
--- a/tests/xfs/017
+++ b/tests/xfs/017
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 
diff --git a/tests/xfs/018 b/tests/xfs/018
index 7d1b861d1..8b6a3e1c5 100755
--- a/tests/xfs/018
+++ b/tests/xfs/018
@@ -82,8 +82,6 @@ require_larp()
 		_notrun 'LARP not supported on this filesystem'
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_scratch_xfs_crc
diff --git a/tests/xfs/019 b/tests/xfs/019
index 790a6821a..914f0a287 100755
--- a/tests/xfs/019
+++ b/tests/xfs/019
@@ -41,8 +41,6 @@ _filter_stat()
     ' | tr -s ' '
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 
diff --git a/tests/xfs/020 b/tests/xfs/020
index d6ee3a157..b8efdb9d5 100755
--- a/tests/xfs/020
+++ b/tests/xfs/020
@@ -23,8 +23,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 
 # Writing a 60t fs requires about 2GB of space, so make sure
diff --git a/tests/xfs/021 b/tests/xfs/021
index ef307fc06..84360a8fc 100755
--- a/tests/xfs/021
+++ b/tests/xfs/021
@@ -52,8 +52,6 @@ do_getfattr()
 	return $exit
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_attrs
diff --git a/tests/xfs/022 b/tests/xfs/022
index 2f011b284..106539146 100755
--- a/tests/xfs/022
+++ b/tests/xfs/022
@@ -25,8 +25,6 @@ _cleanup()
 
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $TAPE_DEV
 _require_scratch
diff --git a/tests/xfs/023 b/tests/xfs/023
index f6f6503a2..06be85020 100755
--- a/tests/xfs/023
+++ b/tests/xfs/023
@@ -24,8 +24,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $TAPE_DEV
 _require_scratch
diff --git a/tests/xfs/024 b/tests/xfs/024
index 83a8882c4..3636e3eb8 100755
--- a/tests/xfs/024
+++ b/tests/xfs/024
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $TAPE_DEV
 _require_scratch
diff --git a/tests/xfs/025 b/tests/xfs/025
index bafe82d74..071e04e4f 100755
--- a/tests/xfs/025
+++ b/tests/xfs/025
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $TAPE_DEV
 _require_scratch
diff --git a/tests/xfs/026 b/tests/xfs/026
index fba385dc9..060bcfe02 100755
--- a/tests/xfs/026
+++ b/tests/xfs/026
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/027 b/tests/xfs/027
index 16cd203da..a1fbec9dd 100755
--- a/tests/xfs/027
+++ b/tests/xfs/027
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/028 b/tests/xfs/028
index 1ff9d7d22..bed88b113 100755
--- a/tests/xfs/028
+++ b/tests/xfs/028
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/029 b/tests/xfs/029
index 6e8aa4dbe..35d646e43 100755
--- a/tests/xfs/029
+++ b/tests/xfs/029
@@ -30,8 +30,6 @@ filter_logprint()
 	'
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 
diff --git a/tests/xfs/030 b/tests/xfs/030
index 201a90157..dbcc2822e 100755
--- a/tests/xfs/030
+++ b/tests/xfs/030
@@ -45,8 +45,6 @@ _check_ag()
 	done
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_no_large_scratch_dev
diff --git a/tests/xfs/031 b/tests/xfs/031
index 6e3813dae..040c2bec6 100755
--- a/tests/xfs/031
+++ b/tests/xfs/031
@@ -66,8 +66,6 @@ EOF
 	echo '$' >>$tmp.proto
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_no_large_scratch_dev
diff --git a/tests/xfs/032 b/tests/xfs/032
index 926de3072..75edf0e9c 100755
--- a/tests/xfs/032
+++ b/tests/xfs/032
@@ -14,8 +14,6 @@ status=0	# success is the default!
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_test_program "feature"
diff --git a/tests/xfs/033 b/tests/xfs/033
index ef5dc4fa3..d7b02a9c5 100755
--- a/tests/xfs/033
+++ b/tests/xfs/033
@@ -48,8 +48,6 @@ _filter_bad_ids()
 	grep -E -v 'bad user id 0xffffffff|bad group id 0xffffffff'
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_no_large_scratch_dev
diff --git a/tests/xfs/034 b/tests/xfs/034
index 52b0a5f72..2acf0ad44 100755
--- a/tests/xfs/034
+++ b/tests/xfs/034
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 
diff --git a/tests/xfs/035 b/tests/xfs/035
index f100bb186..81e21dc5c 100755
--- a/tests/xfs/035
+++ b/tests/xfs/035
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $TAPE_DEV
 _require_scratch
diff --git a/tests/xfs/036 b/tests/xfs/036
index 73eb7cd5d..6a03b3269 100755
--- a/tests/xfs/036
+++ b/tests/xfs/036
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $RMT_IRIXTAPE_DEV
 _require_scratch
diff --git a/tests/xfs/037 b/tests/xfs/037
index b19ba9e9e..0298f0bbd 100755
--- a/tests/xfs/037
+++ b/tests/xfs/037
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $RMT_TAPE_DEV
 _require_scratch
diff --git a/tests/xfs/038 b/tests/xfs/038
index 397c354df..fb26d9991 100755
--- a/tests/xfs/038
+++ b/tests/xfs/038
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $RMT_TAPE_DEV
 _require_scratch
diff --git a/tests/xfs/039 b/tests/xfs/039
index d54e9975b..53273d11d 100755
--- a/tests/xfs/039
+++ b/tests/xfs/039
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $RMT_IRIXTAPE_DEV
 _require_scratch
diff --git a/tests/xfs/041 b/tests/xfs/041
index 21b3afe7c..31807530f 100755
--- a/tests/xfs/041
+++ b/tests/xfs/041
@@ -23,8 +23,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_no_large_scratch_dev
diff --git a/tests/xfs/042 b/tests/xfs/042
index 4433d577e..f598c45a4 100755
--- a/tests/xfs/042
+++ b/tests/xfs/042
@@ -23,8 +23,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_io_command "falloc"
 
 _require_scratch
diff --git a/tests/xfs/043 b/tests/xfs/043
index 415ed16ed..b5583e2c5 100755
--- a/tests/xfs/043
+++ b/tests/xfs/043
@@ -23,8 +23,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $TAPE_DEV
 _require_scratch
diff --git a/tests/xfs/044 b/tests/xfs/044
index e66c0cb3f..9861c72a1 100755
--- a/tests/xfs/044
+++ b/tests/xfs/044
@@ -12,8 +12,6 @@ _begin_fstest other auto
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_logdev
 
@@ -67,7 +65,6 @@ _unexpected()
     exit
 }
 
-# real QA test starts here
 # 
 _require_scratch
 
diff --git a/tests/xfs/045 b/tests/xfs/045
index a596635ec..06faa9e31 100755
--- a/tests/xfs/045
+++ b/tests/xfs/045
@@ -17,8 +17,6 @@ _get_existing_uuid()
 	_test_xfs_db -r -c "uuid" | $AWK_PROG '/^UUID/ { print $3 }'
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_test
 _require_scratch_nocheck
diff --git a/tests/xfs/046 b/tests/xfs/046
index 48daff871..f2f9f7b38 100755
--- a/tests/xfs/046
+++ b/tests/xfs/046
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/047 b/tests/xfs/047
index 6d0dc5f75..05e62cb5a 100755
--- a/tests/xfs/047
+++ b/tests/xfs/047
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/048 b/tests/xfs/048
index 5c43dced2..2c2d9d435 100755
--- a/tests/xfs/048
+++ b/tests/xfs/048
@@ -12,8 +12,6 @@ _begin_fstest other auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 
 $here/src/fault $TEST_DIR || exit
diff --git a/tests/xfs/049 b/tests/xfs/049
index 69656a85c..668ac3745 100755
--- a/tests/xfs/049
+++ b/tests/xfs/049
@@ -27,8 +27,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _log()
 {
diff --git a/tests/xfs/050 b/tests/xfs/050
index 2220e4701..7baaaeaa3 100755
--- a/tests/xfs/050
+++ b/tests/xfs/050
@@ -22,8 +22,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 cp /dev/null $seqres.full
 chmod a+rwx $seqres.full	# arbitrary users will write here
diff --git a/tests/xfs/051 b/tests/xfs/051
index aca867c94..43fee4c45 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/dmflakey
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/xfs/052 b/tests/xfs/052
index 757610227..adeab5380 100755
--- a/tests/xfs/052
+++ b/tests/xfs/052
@@ -24,8 +24,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_quota
diff --git a/tests/xfs/053 b/tests/xfs/053
index e7e73db82..6b2af780f 100755
--- a/tests/xfs/053
+++ b/tests/xfs/053
@@ -17,9 +17,7 @@ _begin_fstest attr acl repair quick auto
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_attrs
 
diff --git a/tests/xfs/054 b/tests/xfs/054
index becb76ac0..d6b08865c 100755
--- a/tests/xfs/054
+++ b/tests/xfs/054
@@ -12,10 +12,8 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_xfs_io_command "inode"
 
diff --git a/tests/xfs/055 b/tests/xfs/055
index c6ecae3d4..8fe7d273d 100755
--- a/tests/xfs/055
+++ b/tests/xfs/055
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $RMT_TAPE_USER@$RMT_IRIXTAPE_DEV
 _require_scratch
diff --git a/tests/xfs/056 b/tests/xfs/056
index f742f419d..18ff592b9 100755
--- a/tests/xfs/056
+++ b/tests/xfs/056
@@ -23,8 +23,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/057 b/tests/xfs/057
index 0cf167012..f1c947795 100755
--- a/tests/xfs/057
+++ b/tests/xfs/057
@@ -37,10 +37,8 @@ _cleanup()
 # Import common functions.
 . ./common/inject
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_io_error_injection log_item_pin
 _require_xfs_io_error_injection log_bad_crc
 _require_scratch
diff --git a/tests/xfs/058 b/tests/xfs/058
index 8751a7acf..2dfd611cd 100755
--- a/tests/xfs/058
+++ b/tests/xfs/058
@@ -13,8 +13,6 @@ _begin_fstest auto quick fuzzers
 . ./common/filter
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 _require_command "$XFS_DB_PROG" "xfs_db"
 _require_xfs_db_command "fuzz"
diff --git a/tests/xfs/059 b/tests/xfs/059
index 515ef2a41..7086dae8f 100755
--- a/tests/xfs/059
+++ b/tests/xfs/059
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_multi_stream
 _require_scratch
diff --git a/tests/xfs/060 b/tests/xfs/060
index 0c0dc981f..0bafe69e9 100755
--- a/tests/xfs/060
+++ b/tests/xfs/060
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_multi_stream
 _require_scratch
diff --git a/tests/xfs/061 b/tests/xfs/061
index 0b20cc30e..69aaf5d9f 100755
--- a/tests/xfs/061
+++ b/tests/xfs/061
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/062 b/tests/xfs/062
index 0a1c6742a..c3da11209 100755
--- a/tests/xfs/062
+++ b/tests/xfs/062
@@ -34,9 +34,7 @@ _bstat_test()
 
 _require_scratch
 
-# real QA test starts here
 
-_supported_fs xfs
 
 DIRCOUNT=8
 INOCOUNT=$((2048 / DIRCOUNT))
diff --git a/tests/xfs/063 b/tests/xfs/063
index 660b300f7..28dadf53f 100755
--- a/tests/xfs/063
+++ b/tests/xfs/063
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/dump
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_attrs trusted user
 _require_scratch
diff --git a/tests/xfs/064 b/tests/xfs/064
index f67c29fd4..cbaee9594 100755
--- a/tests/xfs/064
+++ b/tests/xfs/064
@@ -34,8 +34,6 @@ _ls_size_filter()
     grep -E -v 'dumpdir|housekeeping|dirattr|dirextattr|namreg|state|tree'
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/065 b/tests/xfs/065
index 819d385ea..b7ba61b1f 100755
--- a/tests/xfs/065
+++ b/tests/xfs/065
@@ -42,8 +42,6 @@ _list_dir()
     LC_COLLATE=POSIX sort
 } 
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 #
diff --git a/tests/xfs/066 b/tests/xfs/066
index 2c369ad77..48183ae06 100755
--- a/tests/xfs/066
+++ b/tests/xfs/066
@@ -21,8 +21,6 @@ _cleanup()
     rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 _require_scratch
 
diff --git a/tests/xfs/067 b/tests/xfs/067
index 3dc381bba..fbf91642e 100755
--- a/tests/xfs/067
+++ b/tests/xfs/067
@@ -13,8 +13,6 @@ _begin_fstest acl attr auto quick
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_attrs
 _require_acls
diff --git a/tests/xfs/068 b/tests/xfs/068
index f80b53e5b..c6459ea77 100755
--- a/tests/xfs/068
+++ b/tests/xfs/068
@@ -26,8 +26,6 @@ _cleanup()
 
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/069 b/tests/xfs/069
index b3074e254..e1db2118b 100755
--- a/tests/xfs/069
+++ b/tests/xfs/069
@@ -14,10 +14,8 @@ _begin_fstest ioctl auto quick
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 
 _scratch_mkfs_xfs >/dev/null 2>&1
diff --git a/tests/xfs/070 b/tests/xfs/070
index 43ca7f84d..608afe688 100755
--- a/tests/xfs/070
+++ b/tests/xfs/070
@@ -69,10 +69,8 @@ _xfs_repair_noscan()
 . ./common/filter
 . ./common/repair
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch_nocheck
 _require_command "$KILLALL_PROG" killall
 
diff --git a/tests/xfs/071 b/tests/xfs/071
index 8373878a9..c4722f671 100755
--- a/tests/xfs/071
+++ b/tests/xfs/071
@@ -75,8 +75,6 @@ write_block()
     echo | tee -a $seqres.full
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 [ -n "$XFS_IO_PROG" ] || _notrun "xfs_io executable not found"
 
diff --git a/tests/xfs/072 b/tests/xfs/072
index 54c1207c7..a90938de5 100755
--- a/tests/xfs/072
+++ b/tests/xfs/072
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/073 b/tests/xfs/073
index 0f96fdb09..28f1fad08 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -103,8 +103,6 @@ _verify_copy()
 	rm -f $target
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 _require_attrs
 _require_xfs_copy
diff --git a/tests/xfs/074 b/tests/xfs/074
index f27700ee1..278f0ade6 100755
--- a/tests/xfs/074
+++ b/tests/xfs/074
@@ -33,8 +33,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_test
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/075 b/tests/xfs/075
index ec056fb34..ab1d6cae8 100755
--- a/tests/xfs/075
+++ b/tests/xfs/075
@@ -14,8 +14,6 @@ _begin_fstest auto quick mount
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 # norecovery mounts do not succeed with quotas eanbled, so shut them off
diff --git a/tests/xfs/076 b/tests/xfs/076
index a6ec0568b..840617ccb 100755
--- a/tests/xfs/076
+++ b/tests/xfs/076
@@ -53,7 +53,6 @@ _alloc_inodes()
 	done
 }
 
-# real QA test starts here
 
 if [ -n "$SCRATCH_RTDEV" ]; then
 	# ./check won't know we unset SCRATCH_RTDEV
diff --git a/tests/xfs/077 b/tests/xfs/077
index 4c597fddd..301344d7a 100755
--- a/tests/xfs/077
+++ b/tests/xfs/077
@@ -18,9 +18,7 @@ _begin_fstest auto quick copy
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_xfs_copy
 _require_scratch
 _require_no_large_scratch_dev
diff --git a/tests/xfs/078 b/tests/xfs/078
index 501551e5e..834c99a00 100755
--- a/tests/xfs/078
+++ b/tests/xfs/078
@@ -27,7 +27,6 @@ _cleanup()
 . ./common/filter
 
 # loop devices are available in Linux only
-_supported_fs xfs
 
 _require_test
 # Must have loop device
@@ -42,7 +41,6 @@ _filter_io()
 	sed -e '/.* ops; /d'
 }
 
-# real QA test starts here
 
 echo "*** create loop mount point"
 rmdir $LOOP_MNT 2>/dev/null
diff --git a/tests/xfs/079 b/tests/xfs/079
index dd5dbd35c..46a15ed78 100755
--- a/tests/xfs/079
+++ b/tests/xfs/079
@@ -29,10 +29,8 @@ _cleanup()
 # Import common functions.
 . ./common/log
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _require_v2log
 _require_command "$KILLALL_PROG" killall
diff --git a/tests/xfs/080 b/tests/xfs/080
index 2d90b6c45..f86cadcc8 100755
--- a/tests/xfs/080
+++ b/tests/xfs/080
@@ -19,7 +19,6 @@ _cleanup()
     rm -f $tmp.*
 }
 
-_supported_fs xfs
 _require_test
 _require_xfs_io_command falloc	# iogen requires falloc
 
@@ -30,7 +29,6 @@ export here
 cd $TEST_DIR
 echo
 
-# real QA test starts here
 
 $here/ltp/rwtest.sh $quiet $clean -i 2000 -f direct,buffered,sync
 status=$?
diff --git a/tests/xfs/081 b/tests/xfs/081
index 3af737784..14c0d13e5 100755
--- a/tests/xfs/081
+++ b/tests/xfs/081
@@ -20,8 +20,6 @@ _begin_fstest auto quick attr
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_kernel_commit a1de97fe296c \
        "xfs: Fix the free logic of state in xfs_attr_node_hasname"
 
diff --git a/tests/xfs/082 b/tests/xfs/082
index cc6bfa61c..c999c5854 100755
--- a/tests/xfs/082
+++ b/tests/xfs/082
@@ -16,10 +16,8 @@
 . ./common/preamble
 _begin_fstest auto copy quick
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_copy
 _require_test
 
diff --git a/tests/xfs/083 b/tests/xfs/083
index e8ce2221c..9291c8c03 100755
--- a/tests/xfs/083
+++ b/tests/xfs/083
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_attrs
diff --git a/tests/xfs/084 b/tests/xfs/084
index ab7343556..3cae2c14f 100755
--- a/tests/xfs/084
+++ b/tests/xfs/084
@@ -25,8 +25,6 @@ pgsize=`$here/src/feature -s`
 # -b == read/write block size
 # -s == preallocation size
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_io_command "falloc"
 _require_test
 
diff --git a/tests/xfs/085 b/tests/xfs/085
index dc82f28d9..d33dd199e 100755
--- a/tests/xfs/085
+++ b/tests/xfs/085
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/086 b/tests/xfs/086
index c8c6d86e6..44985f391 100755
--- a/tests/xfs/086
+++ b/tests/xfs/086
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/087 b/tests/xfs/087
index f7cae3281..3cca10568 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/088 b/tests/xfs/088
index 156c66699..b54a1ab7d 100755
--- a/tests/xfs/088
+++ b/tests/xfs/088
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/089 b/tests/xfs/089
index ae8f65647..ff3ae7193 100755
--- a/tests/xfs/089
+++ b/tests/xfs/089
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/090 b/tests/xfs/090
index 663cbcd62..0a3f13f45 100755
--- a/tests/xfs/090
+++ b/tests/xfs/090
@@ -12,8 +12,6 @@ _begin_fstest rw auto realtime
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch
 
diff --git a/tests/xfs/091 b/tests/xfs/091
index 85c881aed..3f606f884 100755
--- a/tests/xfs/091
+++ b/tests/xfs/091
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/092 b/tests/xfs/092
index 015149e2e..17b5d59ec 100755
--- a/tests/xfs/092
+++ b/tests/xfs/092
@@ -12,10 +12,8 @@ _begin_fstest other auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _require_no_large_scratch_dev
 
diff --git a/tests/xfs/093 b/tests/xfs/093
index 04b09e853..c4e800606 100755
--- a/tests/xfs/093
+++ b/tests/xfs/093
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/094 b/tests/xfs/094
index 438a3ea83..f9cea67f9 100755
--- a/tests/xfs/094
+++ b/tests/xfs/094
@@ -12,8 +12,6 @@ _begin_fstest metadata dir ioctl auto realtime
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch
 
diff --git a/tests/xfs/095 b/tests/xfs/095
index e7dc3e9f4..da0d2ae4b 100755
--- a/tests/xfs/095
+++ b/tests/xfs/095
@@ -13,10 +13,8 @@ _begin_fstest log v2log auto
 . ./common/filter
 . ./common/log
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _require_v2log
 _require_xfs_nocrc
diff --git a/tests/xfs/096 b/tests/xfs/096
index 0a1bfb3fa..57a05a8ff 100755
--- a/tests/xfs/096
+++ b/tests/xfs/096
@@ -13,10 +13,8 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_quota
diff --git a/tests/xfs/097 b/tests/xfs/097
index 1df34eedd..384c76080 100755
--- a/tests/xfs/097
+++ b/tests/xfs/097
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_mkfs_finobt
diff --git a/tests/xfs/098 b/tests/xfs/098
index 1e60271f0..a47cda67e 100755
--- a/tests/xfs/098
+++ b/tests/xfs/098
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 # We corrupt XFS on purpose, and check if assert failures would crash system.
 _require_no_xfs_bug_on_assert
diff --git a/tests/xfs/099 b/tests/xfs/099
index 82bef8ad2..f5321fe3d 100755
--- a/tests/xfs/099
+++ b/tests/xfs/099
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/100 b/tests/xfs/100
index e638b4ba1..6f465a79c 100755
--- a/tests/xfs/100
+++ b/tests/xfs/100
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/101 b/tests/xfs/101
index 11ed32911..a926acb0b 100755
--- a/tests/xfs/101
+++ b/tests/xfs/101
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/102 b/tests/xfs/102
index 43f453918..c3ddec5e4 100755
--- a/tests/xfs/102
+++ b/tests/xfs/102
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/103 b/tests/xfs/103
index a3f0ef9e6..72cb0e3ea 100755
--- a/tests/xfs/103
+++ b/tests/xfs/103
@@ -40,8 +40,6 @@ _filter_noymlinks_flag()
 	fi
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 _create_scratch
diff --git a/tests/xfs/104 b/tests/xfs/104
index d16f46d8e..7f11f89a5 100755
--- a/tests/xfs/104
+++ b/tests/xfs/104
@@ -45,8 +45,6 @@ _stress_scratch()
 	$FSSTRESS_PROG $FSSTRESS_ARGS >> $seqres.full 2>&1 &
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_io_command "falloc"
 
diff --git a/tests/xfs/105 b/tests/xfs/105
index 002a71288..132aa07f8 100755
--- a/tests/xfs/105
+++ b/tests/xfs/105
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/106 b/tests/xfs/106
index 388873bde..066efef11 100755
--- a/tests/xfs/106
+++ b/tests/xfs/106
@@ -15,8 +15,6 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_quota
 _require_user
diff --git a/tests/xfs/107 b/tests/xfs/107
index 1ea9c4926..3a37998cb 100755
--- a/tests/xfs/107
+++ b/tests/xfs/107
@@ -14,10 +14,8 @@ _begin_fstest auto quick prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_scratch
 _require_xfs_io_command allocsp		# detect presence of ALLOCSP ioctl
diff --git a/tests/xfs/108 b/tests/xfs/108
index 8593edbdd..149d76eeb 100755
--- a/tests/xfs/108
+++ b/tests/xfs/108
@@ -13,8 +13,6 @@ _begin_fstest quota auto quick
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_quota
 _require_xfs_io_command "syncfs"
@@ -67,7 +65,6 @@ _scratch_mkfs_xfs >> $seqres.full
 _qmount
 _require_prjquota $SCRATCH_DEV
 
-# real QA test starts here
 rm -f $tmp.projects $seqres.full
 _scratch_unmount 2>/dev/null
 _scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
diff --git a/tests/xfs/109 b/tests/xfs/109
index e3e491f1d..4182d79e0 100755
--- a/tests/xfs/109
+++ b/tests/xfs/109
@@ -12,8 +12,6 @@ _begin_fstest metadata auto
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 populate()
@@ -66,7 +64,6 @@ allocate()
 	echo "all done!"
 }
 
-# real QA test starts here
 _scratch_mkfs_xfs >> $seqres.full
 _scratch_mount
 
diff --git a/tests/xfs/110 b/tests/xfs/110
index 596057ef0..0c8c87ea9 100755
--- a/tests/xfs/110
+++ b/tests/xfs/110
@@ -12,11 +12,8 @@ _begin_fstest repair auto
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
-# real QA test starts here
 _scratch_unmount 2>/dev/null
 _scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
 
diff --git a/tests/xfs/111 b/tests/xfs/111
index ede28aeea..c21fbdb69 100755
--- a/tests/xfs/111
+++ b/tests/xfs/111
@@ -12,13 +12,10 @@ _begin_fstest ioctl
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 [ "$XFS_FSR_PROG" = "" ] && _notrun "xfs_fsr not found"
 
-# real QA test starts here
 _scratch_unmount 2>/dev/null
 MKFS_OPTIONS="-bsize=4096"
 MOUNT_OPTIONS="-o noatime"
diff --git a/tests/xfs/112 b/tests/xfs/112
index e2d5932da..f0e717cf2 100755
--- a/tests/xfs/112
+++ b/tests/xfs/112
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/113 b/tests/xfs/113
index 9bb2cd304..094ab71f2 100755
--- a/tests/xfs/113
+++ b/tests/xfs/113
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/114 b/tests/xfs/114
index 0e8a0529a..343730051 100755
--- a/tests/xfs/114
+++ b/tests/xfs/114
@@ -15,8 +15,6 @@ _begin_fstest auto quick clone rmap collapse insert prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_test_program "punch-alternating"
 _require_cp_reflink
 _require_scratch_reflink
diff --git a/tests/xfs/115 b/tests/xfs/115
index f06472812..9e0dc51a9 100755
--- a/tests/xfs/115
+++ b/tests/xfs/115
@@ -15,10 +15,8 @@ _begin_fstest auto quick fuzzers
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch_nocheck
 # We corrupt XFS on purpose, and check if assert failures would crash system.
 _require_no_xfs_bug_on_assert
diff --git a/tests/xfs/116 b/tests/xfs/116
index 736fb2f95..c5e7508f8 100755
--- a/tests/xfs/116
+++ b/tests/xfs/116
@@ -15,9 +15,7 @@ _begin_fstest quota auto quick
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_quota
diff --git a/tests/xfs/117 b/tests/xfs/117
index e4195d9bd..0ca8f1b96 100755
--- a/tests/xfs/117
+++ b/tests/xfs/117
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/118 b/tests/xfs/118
index 6bb81a3ab..73e429384 100755
--- a/tests/xfs/118
+++ b/tests/xfs/118
@@ -21,7 +21,6 @@ _begin_fstest auto quick fsr prealloc
 # Import common functions.
 . ./common/filter
 
-_supported_fs xfs
 
 _require_scratch
 _require_command "$XFS_FSR_PROG" "xfs_fsr"
diff --git a/tests/xfs/119 b/tests/xfs/119
index 5ffbce25c..334d06934 100755
--- a/tests/xfs/119
+++ b/tests/xfs/119
@@ -23,10 +23,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch
 _require_freeze
diff --git a/tests/xfs/120 b/tests/xfs/120
index 0a4d72a00..f1f047f53 100755
--- a/tests/xfs/120
+++ b/tests/xfs/120
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/121 b/tests/xfs/121
index 08b5143d4..0210a627c 100755
--- a/tests/xfs/121
+++ b/tests/xfs/121
@@ -17,8 +17,6 @@ _begin_fstest shutdown log auto quick
 . ./common/filter
 . ./common/log
 
-# real QA test starts here
-_supported_fs xfs
 
 rm -f $tmp.log
 
diff --git a/tests/xfs/122 b/tests/xfs/122
index 4e5ba1dfe..a96894884 100755
--- a/tests/xfs/122
+++ b/tests/xfs/122
@@ -13,8 +13,6 @@ _begin_fstest other auto quick clone realtime
 
 # get standard environment
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$INDENT_PROG" indent
 
 # Starting in Linux 6.1, the EFI log formats were adjusted away from using
diff --git a/tests/xfs/123 b/tests/xfs/123
index 81f39b960..6b5655137 100755
--- a/tests/xfs/123
+++ b/tests/xfs/123
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/124 b/tests/xfs/124
index 393072186..fe870dc96 100755
--- a/tests/xfs/124
+++ b/tests/xfs/124
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/125 b/tests/xfs/125
index fb5f56950..89e936505 100755
--- a/tests/xfs/125
+++ b/tests/xfs/125
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/126 b/tests/xfs/126
index c3a74b1c8..5614ea398 100755
--- a/tests/xfs/126
+++ b/tests/xfs/126
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/127 b/tests/xfs/127
index f39b0582f..b690ab0d5 100755
--- a/tests/xfs/127
+++ b/tests/xfs/127
@@ -13,8 +13,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_no_large_scratch_dev
 _require_cp_reflink
diff --git a/tests/xfs/128 b/tests/xfs/128
index 8c1663c6c..0f1905295 100755
--- a/tests/xfs/128
+++ b/tests/xfs/128
@@ -13,8 +13,6 @@ _begin_fstest auto quick clone fsr prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_test_lsattr
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/xfs/129 b/tests/xfs/129
index ec1a2ff3d..605fdac1b 100755
--- a/tests/xfs/129
+++ b/tests/xfs/129
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/reflink
 . ./common/metadump
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$XFS_MDRESTORE_PROG" "xfs_mdrestore"
 _require_loop
 _require_scratch_reflink
diff --git a/tests/xfs/130 b/tests/xfs/130
index 9465cbb09..3e6dd861c 100755
--- a/tests/xfs/130
+++ b/tests/xfs/130
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
diff --git a/tests/xfs/131 b/tests/xfs/131
index 879e2dc6e..c83a1d6ea 100755
--- a/tests/xfs/131
+++ b/tests/xfs/131
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/xfs/132 b/tests/xfs/132
index b46d3d28c..3bb37f2a9 100755
--- a/tests/xfs/132
+++ b/tests/xfs/132
@@ -13,9 +13,7 @@ _begin_fstest auto quick
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 
-_supported_fs xfs
 
 # we intentionally corrupt the filesystem, so don't check it after the test
 _require_scratch_nocheck
diff --git a/tests/xfs/133 b/tests/xfs/133
index 73f628c45..39f4f74ae 100755
--- a/tests/xfs/133
+++ b/tests/xfs/133
@@ -21,8 +21,6 @@ PIDS=""
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 _disable_dmesg_check
 
diff --git a/tests/xfs/134 b/tests/xfs/134
index b13615ab6..b86265211 100755
--- a/tests/xfs/134
+++ b/tests/xfs/134
@@ -21,8 +21,6 @@ PIDS=""
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 _disable_dmesg_check
 
diff --git a/tests/xfs/135 b/tests/xfs/135
index 6b96d00c2..ec0b54ab4 100755
--- a/tests/xfs/135
+++ b/tests/xfs/135
@@ -14,10 +14,8 @@ _begin_fstest auto logprint quick v2log
 # Import common functions.
 . ./common/log
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _require_v2log
 _require_xfs_db_command "logformat"
diff --git a/tests/xfs/136 b/tests/xfs/136
index 1658b7604..8673a9298 100755
--- a/tests/xfs/136
+++ b/tests/xfs/136
@@ -15,12 +15,10 @@ _begin_fstest attr2
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
 #_notrun "Need to fix up filtering before checkin" 
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch
 _require_attrs
diff --git a/tests/xfs/137 b/tests/xfs/137
index 2cc974e56..dfc653573 100755
--- a/tests/xfs/137
+++ b/tests/xfs/137
@@ -16,10 +16,8 @@ _begin_fstest auto metadata v2log
 
 # Import common functions.
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _require_scratch_xfs_crc
 _require_xfs_db_command "logformat"
diff --git a/tests/xfs/138 b/tests/xfs/138
index c49d2d9ee..4202ea9fe 100755
--- a/tests/xfs/138
+++ b/tests/xfs/138
@@ -13,8 +13,6 @@ _register_cleanup "_cleanup" BUS
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 cat > $tmp.a << ENDL
diff --git a/tests/xfs/139 b/tests/xfs/139
index 118930a5e..523d3eb6a 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 # Below agsize (16384 * $blksz) is too small for a large fs, and it's not
 # necessary to test on large fs
 _require_no_large_scratch_dev
diff --git a/tests/xfs/140 b/tests/xfs/140
index ba7694c32..2d4f94765 100755
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 # Below agsize is too small for a large fs, and it's not necessary to test on
 # large fs
 _require_no_large_scratch_dev
diff --git a/tests/xfs/141 b/tests/xfs/141
index d9b2474da..5e9067e24 100755
--- a/tests/xfs/141
+++ b/tests/xfs/141
@@ -26,10 +26,8 @@ _cleanup()
 # Import common functions.
 . ./common/inject
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_io_error_injection "log_bad_crc"
 _require_scratch
 _require_command "$KILLALL_PROG" killall
diff --git a/tests/xfs/142 b/tests/xfs/142
index 60b750eda..2ee528466 100755
--- a/tests/xfs/142
+++ b/tests/xfs/142
@@ -15,8 +15,6 @@ _begin_fstest auto quick rw attr realtime
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_realtime
 
diff --git a/tests/xfs/143 b/tests/xfs/143
index 185b63873..3eb0a57a8 100755
--- a/tests/xfs/143
+++ b/tests/xfs/143
@@ -16,8 +16,6 @@ _begin_fstest auto quick realtime mount
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_realtime
 
diff --git a/tests/xfs/144 b/tests/xfs/144
index 706aff61f..1467d5888 100755
--- a/tests/xfs/144
+++ b/tests/xfs/144
@@ -11,10 +11,8 @@
 . ./common/preamble
 _begin_fstest auto mkfs
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 
 # The last testcase creates a (sparse) fs image with a 2GB log, so we need
diff --git a/tests/xfs/145 b/tests/xfs/145
index 5fd8dcadf..392580077 100755
--- a/tests/xfs/145
+++ b/tests/xfs/145
@@ -16,8 +16,6 @@ _begin_fstest auto quick quota
 # Import common functions.
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_kernel_commit 1aecf3734a95 \
 	"xfs: fix chown leaking delalloc quota blocks when fssetxattr fails"
 
diff --git a/tests/xfs/146 b/tests/xfs/146
index 509043597..b6f4c2bd0 100755
--- a/tests/xfs/146
+++ b/tests/xfs/146
@@ -20,8 +20,6 @@ _begin_fstest auto quick rw realtime prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_realtime
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/147 b/tests/xfs/147
index 33b3c9963..4fa3cdc1b 100755
--- a/tests/xfs/147
+++ b/tests/xfs/147
@@ -14,8 +14,6 @@ _begin_fstest auto quick rw realtime collapse insert unshare zero prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_realtime
 _require_xfs_io_command "fcollapse"
diff --git a/tests/xfs/148 b/tests/xfs/148
index fde3bf476..9e6798f99 100755
--- a/tests/xfs/148
+++ b/tests/xfs/148
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 _require_attrs
 _require_xfs_nocrc
diff --git a/tests/xfs/149 b/tests/xfs/149
index 503eff65d..f1b2405e7 100755
--- a/tests/xfs/149
+++ b/tests/xfs/149
@@ -32,10 +32,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_loop
 
diff --git a/tests/xfs/150 b/tests/xfs/150
index bd0241b96..4d68092a8 100755
--- a/tests/xfs/150
+++ b/tests/xfs/150
@@ -14,8 +14,6 @@ _begin_fstest auto quick db
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_db_command "path"
 _require_scratch
 
diff --git a/tests/xfs/151 b/tests/xfs/151
index b2fe16aef..c71d23483 100755
--- a/tests/xfs/151
+++ b/tests/xfs/151
@@ -14,8 +14,6 @@ _begin_fstest auto quick db
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_db_command "path"
 _require_xfs_db_command "ls"
 _require_scratch
diff --git a/tests/xfs/152 b/tests/xfs/152
index 325a05c14..6c052cbc9 100755
--- a/tests/xfs/152
+++ b/tests/xfs/152
@@ -31,8 +31,6 @@ _cleanup()
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_idmapped_mounts
 _require_test_program "vfs/mount-idmapped"
 _require_scratch
diff --git a/tests/xfs/153 b/tests/xfs/153
index dbe26b680..897e9c786 100755
--- a/tests/xfs/153
+++ b/tests/xfs/153
@@ -24,8 +24,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 cp /dev/null $seqres.full
 chmod a+rwx $seqres.full	# arbitrary users will write here
diff --git a/tests/xfs/154 b/tests/xfs/154
index 548c94905..e8494bbd6 100755
--- a/tests/xfs/154
+++ b/tests/xfs/154
@@ -16,8 +16,6 @@ _begin_fstest auto quick repair
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 _require_scratch_xfs_crc		# needsrepair only exists for v5
 _require_libxfs_debug_flag LIBXFS_DEBUG_WRITE_CRASH
diff --git a/tests/xfs/155 b/tests/xfs/155
index 8bf1aba1f..20946b883 100755
--- a/tests/xfs/155
+++ b/tests/xfs/155
@@ -20,8 +20,6 @@ _begin_fstest auto repair
 . ./common/populate
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 _require_scratch_xfs_crc		# needsrepair only exists for v5
 _require_populate_commands
diff --git a/tests/xfs/156 b/tests/xfs/156
index 75418805d..1498d5b39 100755
--- a/tests/xfs/156
+++ b/tests/xfs/156
@@ -15,8 +15,6 @@ _begin_fstest auto quick admin
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_command "$XFS_ADMIN_PROG" "xfs_admin"
 
diff --git a/tests/xfs/157 b/tests/xfs/157
index 8222d7eee..79d45ac2b 100755
--- a/tests/xfs/157
+++ b/tests/xfs/157
@@ -30,8 +30,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 _require_scratch_nocheck
 _require_command "$XFS_ADMIN_PROG" "xfs_admin"
diff --git a/tests/xfs/158 b/tests/xfs/158
index 9f03eb528..3c4e60f0e 100755
--- a/tests/xfs/158
+++ b/tests/xfs/158
@@ -13,8 +13,6 @@ _begin_fstest auto quick inobtcount
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_inobtcount
 _require_command "$XFS_ADMIN_PROG" "xfs_admin"
 _require_xfs_repair_upgrade inobtcount
diff --git a/tests/xfs/159 b/tests/xfs/159
index eaee590eb..222b2b359 100755
--- a/tests/xfs/159
+++ b/tests/xfs/159
@@ -19,8 +19,6 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_db_command timelimit
 
diff --git a/tests/xfs/160 b/tests/xfs/160
index d11eaba3c..8cc784e7e 100755
--- a/tests/xfs/160
+++ b/tests/xfs/160
@@ -13,8 +13,6 @@ _begin_fstest auto quick bigtime
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$XFS_ADMIN_PROG" "xfs_admin"
 _require_scratch_xfs_bigtime
 _require_xfs_repair_upgrade bigtime
diff --git a/tests/xfs/161 b/tests/xfs/161
index 5bda70198..002ee7d80 100755
--- a/tests/xfs/161
+++ b/tests/xfs/161
@@ -15,8 +15,6 @@ _begin_fstest auto quick bigtime quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$XFS_ADMIN_PROG" "xfs_admin"
 _require_command "$QUOTA_PROG" "quota"
 _require_quota
diff --git a/tests/xfs/162 b/tests/xfs/162
index 16922ff62..fd0e0ac56 100755
--- a/tests/xfs/162
+++ b/tests/xfs/162
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 _require_populate_commands
 _require_xfs_db_command "fuzz"
diff --git a/tests/xfs/163 b/tests/xfs/163
index 9f6dbeb82..2bd940602 100755
--- a/tests/xfs/163
+++ b/tests/xfs/163
@@ -29,8 +29,6 @@ test_shrink()
 	[ $ret -eq 0 -a $1 -eq $dblocks ]
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_shrink
 
 echo "Format and mount"
diff --git a/tests/xfs/164 b/tests/xfs/164
index ba08982df..42c46ed8d 100755
--- a/tests/xfs/164
+++ b/tests/xfs/164
@@ -33,10 +33,8 @@ _filter_bmap()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_xfs_io_command "falloc"
 
diff --git a/tests/xfs/165 b/tests/xfs/165
index 7664b9809..a4c28cdf3 100755
--- a/tests/xfs/165
+++ b/tests/xfs/165
@@ -30,10 +30,8 @@ _filter_bmap()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_xfs_io_command "falloc"
 
diff --git a/tests/xfs/166 b/tests/xfs/166
index 45f28e773..beb050317 100755
--- a/tests/xfs/166
+++ b/tests/xfs/166
@@ -47,8 +47,6 @@ _filter_blocks()
 }'
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/167 b/tests/xfs/167
index 734c107fb..f9da261db 100755
--- a/tests/xfs/167
+++ b/tests/xfs/167
@@ -29,8 +29,6 @@ workout()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_command "$KILLALL_PROG" killall
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/168 b/tests/xfs/168
index ffcd0df85..e8e61dbfa 100755
--- a/tests/xfs/168
+++ b/tests/xfs/168
@@ -43,8 +43,6 @@ stress_scratch()
 	$FSSTRESS_PROG $FSSTRESS_ARGS >> $seqres.full 2>&1
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_shrink
 _require_xfs_io_command "falloc"
 
diff --git a/tests/xfs/169 b/tests/xfs/169
index 7ea5af998..6400fd9e6 100755
--- a/tests/xfs/169
+++ b/tests/xfs/169
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 
 _scratch_mkfs >/dev/null 2>&1
diff --git a/tests/xfs/170 b/tests/xfs/170
index b9ead341f..111b1b442 100755
--- a/tests/xfs/170
+++ b/tests/xfs/170
@@ -15,8 +15,6 @@ _begin_fstest rw filestreams auto quick
 . ./common/filter
 . ./common/filestreams
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 
diff --git a/tests/xfs/171 b/tests/xfs/171
index f93b6011d..4d4a19f3f 100755
--- a/tests/xfs/171
+++ b/tests/xfs/171
@@ -14,8 +14,6 @@ _begin_fstest rw filestreams
 . ./common/filter
 . ./common/filestreams
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 
diff --git a/tests/xfs/172 b/tests/xfs/172
index 56c2583b9..7f9defecb 100755
--- a/tests/xfs/172
+++ b/tests/xfs/172
@@ -14,8 +14,6 @@ _begin_fstest rw filestreams
 . ./common/filter
 . ./common/filestreams
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 # The first _test_streams call sets up the filestreams allocator to fail and
diff --git a/tests/xfs/173 b/tests/xfs/173
index 6b18d9194..91b4effbb 100755
--- a/tests/xfs/173
+++ b/tests/xfs/173
@@ -14,8 +14,6 @@ _begin_fstest rw filestreams
 . ./common/filter
 . ./common/filestreams
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 
diff --git a/tests/xfs/174 b/tests/xfs/174
index 1245a2179..ebdfb2cec 100755
--- a/tests/xfs/174
+++ b/tests/xfs/174
@@ -14,8 +14,6 @@ _begin_fstest rw filestreams auto
 . ./common/filter
 . ./common/filestreams
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 
diff --git a/tests/xfs/175 b/tests/xfs/175
index 22c648021..7fea6569a 100755
--- a/tests/xfs/175
+++ b/tests/xfs/175
@@ -15,8 +15,6 @@ _begin_fstest auto quick quota
 # Import common functions
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_quota
 
diff --git a/tests/xfs/176 b/tests/xfs/176
index 49f7492c0..db7001a5b 100755
--- a/tests/xfs/176
+++ b/tests/xfs/176
@@ -13,10 +13,8 @@ _begin_fstest auto quick shrinkfs prealloc punch
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_xfs_sparse_inodes
 _require_scratch_xfs_shrink
diff --git a/tests/xfs/177 b/tests/xfs/177
index 1e59bd6c5..773049524 100755
--- a/tests/xfs/177
+++ b/tests/xfs/177
@@ -35,10 +35,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _fixed_by_kernel_commit f38a032b165d "xfs: fix I_DONTCACHE"
 
 _require_xfs_io_command "bulkstat"
diff --git a/tests/xfs/178 b/tests/xfs/178
index fee1e92bf..8597177d7 100755
--- a/tests/xfs/178
+++ b/tests/xfs/178
@@ -36,10 +36,8 @@ _dd_repair_check()
 . ./common/filter
 . ./common/repair
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 
 # From the PV
 # o Summary of testing:
diff --git a/tests/xfs/179 b/tests/xfs/179
index 98b01476c..e50fa4364 100755
--- a/tests/xfs/179
+++ b/tests/xfs/179
@@ -14,8 +14,6 @@ _begin_fstest auto quick clone
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_scratch_nocheck
 _require_cp_reflink
diff --git a/tests/xfs/180 b/tests/xfs/180
index d2fac03a9..8c82140b5 100755
--- a/tests/xfs/180
+++ b/tests/xfs/180
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/181 b/tests/xfs/181
index a399ae5a7..a20f412f9 100755
--- a/tests/xfs/181
+++ b/tests/xfs/181
@@ -26,8 +26,6 @@ pid=""
 . ./common/filter
 . ./common/log
 
-# real QA test starts here
-_supported_fs xfs
 
 rm -f $tmp.log
 
diff --git a/tests/xfs/182 b/tests/xfs/182
index 511aca6f2..6c39c1951 100755
--- a/tests/xfs/182
+++ b/tests/xfs/182
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/183 b/tests/xfs/183
index 5b092acc3..7b0abdc14 100755
--- a/tests/xfs/183
+++ b/tests/xfs/183
@@ -13,10 +13,8 @@ _begin_fstest rw other auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 
 # Setup Filesystem
 _require_scratch
diff --git a/tests/xfs/184 b/tests/xfs/184
index 97f529f66..8b38444b3 100755
--- a/tests/xfs/184
+++ b/tests/xfs/184
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone fiemap unshare
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_scratch_delalloc
 _require_scratch_reflink
diff --git a/tests/xfs/185 b/tests/xfs/185
index abeb05258..b14bcb9b7 100755
--- a/tests/xfs/185
+++ b/tests/xfs/185
@@ -30,8 +30,6 @@ _cleanup()
 	test -n "$old_use_external" && USE_EXTERNAL="$old_use_external"
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 _require_loop
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/186 b/tests/xfs/186
index f44158e31..88f02585e 100755
--- a/tests/xfs/186
+++ b/tests/xfs/186
@@ -115,10 +115,8 @@ _changeto_attr1()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch
 _require_attrs
diff --git a/tests/xfs/187 b/tests/xfs/187
index 7c34d8e63..04ff9a81b 100755
--- a/tests/xfs/187
+++ b/tests/xfs/187
@@ -33,8 +33,6 @@ _begin_fstest auto quick rw realtime prealloc punch
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_realtime
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/188 b/tests/xfs/188
index d40e4123c..a72bf15d6 100755
--- a/tests/xfs/188
+++ b/tests/xfs/188
@@ -29,8 +29,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_mkfs_ciname
 
diff --git a/tests/xfs/189 b/tests/xfs/189
index bc7ccca56..d32adf084 100755
--- a/tests/xfs/189
+++ b/tests/xfs/189
@@ -245,8 +245,6 @@ _putback_scratch_fstab()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_no_realtime
 _require_scratch
diff --git a/tests/xfs/190 b/tests/xfs/190
index 860a3516b..32b6217f2 100755
--- a/tests/xfs/190
+++ b/tests/xfs/190
@@ -19,8 +19,6 @@ status=0    # success is the default!
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _scratch_mkfs_xfs >/dev/null 2>&1
diff --git a/tests/xfs/191 b/tests/xfs/191
index e2150bf79..475d81eec 100755
--- a/tests/xfs/191
+++ b/tests/xfs/191
@@ -24,9 +24,7 @@ _begin_fstest auto quick attr
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_scratch_xfs_crc # V4 is deprecated
 _fixed_by_kernel_commit 7be3bd8856fb "xfs: empty xattr leaf header blocks are not corruption"
diff --git a/tests/xfs/192 b/tests/xfs/192
index ef7da55be..3fed9e8fb 100755
--- a/tests/xfs/192
+++ b/tests/xfs/192
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone fiemap unshare
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_scratch_delalloc
 _require_scratch_reflink
diff --git a/tests/xfs/193 b/tests/xfs/193
index c71aef354..02ffdff42 100755
--- a/tests/xfs/193
+++ b/tests/xfs/193
@@ -16,8 +16,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/194 b/tests/xfs/194
index 2fcc55b3e..9abd2c321 100755
--- a/tests/xfs/194
+++ b/tests/xfs/194
@@ -25,9 +25,7 @@ _cleanup()
 . ./common/filter
 
 # only xfs supported due to use of xfs_bmap
-_supported_fs xfs
 
-# real QA test starts here
 
 _require_scratch
 
diff --git a/tests/xfs/195 b/tests/xfs/195
index 3e3881420..f965d9c38 100755
--- a/tests/xfs/195
+++ b/tests/xfs/195
@@ -38,8 +38,6 @@ _do_dump()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_test
 _require_user
diff --git a/tests/xfs/196 b/tests/xfs/196
index dc87b48aa..9535ce6be 100755
--- a/tests/xfs/196
+++ b/tests/xfs/196
@@ -19,10 +19,8 @@ _begin_fstest auto quick rw
 . ./common/punch
 . ./common/inject
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_xfs_io_error_injection "drop_writes"
 
diff --git a/tests/xfs/197 b/tests/xfs/197
index 109bf4781..7f7ce8985 100755
--- a/tests/xfs/197
+++ b/tests/xfs/197
@@ -24,8 +24,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 
 bitsperlong=`$here/src/feature -w`
diff --git a/tests/xfs/198 b/tests/xfs/198
index e5b98609d..288a4e219 100755
--- a/tests/xfs/198
+++ b/tests/xfs/198
@@ -16,8 +16,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/199 b/tests/xfs/199
index f99b04db3..7b9c8eeae 100755
--- a/tests/xfs/199
+++ b/tests/xfs/199
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_nocrc
diff --git a/tests/xfs/200 b/tests/xfs/200
index a9d6ce1bb..cab75b3c1 100755
--- a/tests/xfs/200
+++ b/tests/xfs/200
@@ -19,8 +19,6 @@ _begin_fstest auto quick clone fiemap unshare
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_scratch_delalloc
 _require_scratch_reflink
diff --git a/tests/xfs/201 b/tests/xfs/201
index b9f2aab1a..a0d2c9150 100755
--- a/tests/xfs/201
+++ b/tests/xfs/201
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 file=$SCRATCH_MNT/f
 
diff --git a/tests/xfs/202 b/tests/xfs/202
index 5075d3a17..6708a6ed7 100755
--- a/tests/xfs/202
+++ b/tests/xfs/202
@@ -13,8 +13,6 @@ _begin_fstest repair auto quick
 . ./common/filter
 . ./common/repair
 
-# real QA test starts here
-_supported_fs xfs
 
 # single AG will cause default xfs_repair to fail. This test is actually
 # testing the special corner case option needed to repair a single AG fs.
diff --git a/tests/xfs/203 b/tests/xfs/203
index 9a4a45641..ec0d500fa 100755
--- a/tests/xfs/203
+++ b/tests/xfs/203
@@ -45,8 +45,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount > /dev/null 2>&1
diff --git a/tests/xfs/204 b/tests/xfs/204
index 7dacfa2de..07d8eb798 100755
--- a/tests/xfs/204
+++ b/tests/xfs/204
@@ -19,8 +19,6 @@ _begin_fstest auto quick clone fiemap unshare
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_scratch_delalloc
 _require_scratch_reflink
diff --git a/tests/xfs/205 b/tests/xfs/205
index 104f1f45a..73d51d8d6 100755
--- a/tests/xfs/205
+++ b/tests/xfs/205
@@ -12,8 +12,6 @@ _begin_fstest metadata rw auto
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 # single AG will cause xfs_repair to fail checks.
 _require_scratch_nocheck
diff --git a/tests/xfs/206 b/tests/xfs/206
index d81fe1985..129743318 100755
--- a/tests/xfs/206
+++ b/tests/xfs/206
@@ -27,10 +27,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_loop
 
diff --git a/tests/xfs/207 b/tests/xfs/207
index 4bdafd261..bbe21307f 100755
--- a/tests/xfs/207
+++ b/tests/xfs/207
@@ -16,8 +16,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/208 b/tests/xfs/208
index 1e7734b82..cff3b7d4c 100755
--- a/tests/xfs/208
+++ b/tests/xfs/208
@@ -20,8 +20,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/209 b/tests/xfs/209
index 1ef6d33d8..6778b925a 100755
--- a/tests/xfs/209
+++ b/tests/xfs/209
@@ -13,8 +13,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/210 b/tests/xfs/210
index 5f05ab26f..5f1ffec81 100755
--- a/tests/xfs/210
+++ b/tests/xfs/210
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/211 b/tests/xfs/211
index 3ce6496af..2419107ed 100755
--- a/tests/xfs/211
+++ b/tests/xfs/211
@@ -17,8 +17,6 @@ _begin_fstest clone_stress fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/212 b/tests/xfs/212
index 6df036089..54ece22ab 100755
--- a/tests/xfs/212
+++ b/tests/xfs/212
@@ -16,8 +16,6 @@ _begin_fstest shutdown auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/213 b/tests/xfs/213
index e18496245..7b27e3c09 100755
--- a/tests/xfs/213
+++ b/tests/xfs/213
@@ -16,8 +16,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/reflink
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/214 b/tests/xfs/214
index 84ba838f3..f2f23b3fb 100755
--- a/tests/xfs/214
+++ b/tests/xfs/214
@@ -16,8 +16,6 @@ _begin_fstest auto quick clone fiemap
 . ./common/reflink
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/215 b/tests/xfs/215
index d2c0d6fc9..82bfe89dd 100755
--- a/tests/xfs/215
+++ b/tests/xfs/215
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/216 b/tests/xfs/216
index f981151ce..680239b4e 100755
--- a/tests/xfs/216
+++ b/tests/xfs/216
@@ -12,8 +12,6 @@ _begin_fstest log metadata auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _scratch_mkfs_xfs >/dev/null 2>&1
diff --git a/tests/xfs/217 b/tests/xfs/217
index bf9c5123b..41caaf738 100755
--- a/tests/xfs/217
+++ b/tests/xfs/217
@@ -12,8 +12,6 @@ _begin_fstest log metadata auto
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _scratch_mkfs_xfs >/dev/null 2>&1
diff --git a/tests/xfs/218 b/tests/xfs/218
index 1a994d795..1d6c9e439 100755
--- a/tests/xfs/218
+++ b/tests/xfs/218
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/219 b/tests/xfs/219
index 507b033b2..47115a7dc 100755
--- a/tests/xfs/219
+++ b/tests/xfs/219
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/220 b/tests/xfs/220
index 88eedf516..f89c976fb 100755
--- a/tests/xfs/220
+++ b/tests/xfs/220
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_quota
diff --git a/tests/xfs/221 b/tests/xfs/221
index 598df3f1b..13ecb8984 100755
--- a/tests/xfs/221
+++ b/tests/xfs/221
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/222 b/tests/xfs/222
index 96790313d..26bf7dccd 100755
--- a/tests/xfs/222
+++ b/tests/xfs/222
@@ -15,8 +15,6 @@ _begin_fstest auto fsr ioctl quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 
 [ "$XFS_FSR_PROG" = "" ] && _notrun "xfs_fsr not found"
diff --git a/tests/xfs/223 b/tests/xfs/223
index 849667d4e..3099f47e5 100755
--- a/tests/xfs/223
+++ b/tests/xfs/223
@@ -20,7 +20,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/224 b/tests/xfs/224
index 6f6dcd04d..23b901a3e 100755
--- a/tests/xfs/224
+++ b/tests/xfs/224
@@ -20,7 +20,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/225 b/tests/xfs/225
index 8722d5065..8a8eb574e 100755
--- a/tests/xfs/225
+++ b/tests/xfs/225
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/226 b/tests/xfs/226
index a5f46a14b..7f7119914 100755
--- a/tests/xfs/226
+++ b/tests/xfs/226
@@ -19,7 +19,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/227 b/tests/xfs/227
index cd927dc4b..3f01b175e 100755
--- a/tests/xfs/227
+++ b/tests/xfs/227
@@ -17,8 +17,6 @@ _begin_fstest auto fsr
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 [ "$XFS_FSR_PROG" = "" ] && _notrun "xfs_fsr not found"
diff --git a/tests/xfs/228 b/tests/xfs/228
index 504f9288a..a868be180 100755
--- a/tests/xfs/228
+++ b/tests/xfs/228
@@ -23,7 +23,6 @@ _begin_fstest auto quick clone punch prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/229 b/tests/xfs/229
index a58fd16bb..9dae0f649 100755
--- a/tests/xfs/229
+++ b/tests/xfs/229
@@ -23,8 +23,6 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 _require_fs_space $TEST_DIR 3200000
 
diff --git a/tests/xfs/230 b/tests/xfs/230
index fd1209bea..28cf75500 100755
--- a/tests/xfs/230
+++ b/tests/xfs/230
@@ -23,7 +23,6 @@ _begin_fstest auto quick clone punch prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/231 b/tests/xfs/231
index 31f267eec..c01682fa8 100755
--- a/tests/xfs/231
+++ b/tests/xfs/231
@@ -27,8 +27,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/232 b/tests/xfs/232
index 0cb26fa1c..c7eba95a4 100755
--- a/tests/xfs/232
+++ b/tests/xfs/232
@@ -28,8 +28,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_scratch_delalloc
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/233 b/tests/xfs/233
index 2b2b86662..1f691e20f 100755
--- a/tests/xfs/233
+++ b/tests/xfs/233
@@ -12,8 +12,6 @@ _begin_fstest auto quick rmap
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_no_large_scratch_dev
 
diff --git a/tests/xfs/234 b/tests/xfs/234
index 6fdea42d2..4d6e30c0a 100755
--- a/tests/xfs/234
+++ b/tests/xfs/234
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/metadump
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$XFS_MDRESTORE_PROG" "xfs_mdrestore"
 _require_loop
 _require_xfs_scratch_rmapbt
diff --git a/tests/xfs/235 b/tests/xfs/235
index 59292bec1..5b201d930 100755
--- a/tests/xfs/235
+++ b/tests/xfs/235
@@ -14,8 +14,6 @@ _begin_fstest fuzzers rmap
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 test -n ${FORCE_FUZZ} || _require_scratch_xfs_crc
 
diff --git a/tests/xfs/236 b/tests/xfs/236
index a66ea2d55..a374a300d 100755
--- a/tests/xfs/236
+++ b/tests/xfs/236
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "fpunch"
 
diff --git a/tests/xfs/237 b/tests/xfs/237
index db235e05b..5f264ff44 100755
--- a/tests/xfs/237
+++ b/tests/xfs/237
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/xfs/238 b/tests/xfs/238
index 64abb4de1..4b71d4010 100755
--- a/tests/xfs/238
+++ b/tests/xfs/238
@@ -12,10 +12,8 @@ _begin_fstest auto quick metadata ioctl
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 
 echo "Silence is golden"
diff --git a/tests/xfs/239 b/tests/xfs/239
index f04460bc5..277bd4548 100755
--- a/tests/xfs/239
+++ b/tests/xfs/239
@@ -20,8 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/240 b/tests/xfs/240
index a65c270d2..4f9311e8e 100755
--- a/tests/xfs/240
+++ b/tests/xfs/240
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmerror
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
diff --git a/tests/xfs/241 b/tests/xfs/241
index d9879788a..153249397 100755
--- a/tests/xfs/241
+++ b/tests/xfs/241
@@ -20,8 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/242 b/tests/xfs/242
index cf88fa47b..4d3505de6 100755
--- a/tests/xfs/242
+++ b/tests/xfs/242
@@ -13,8 +13,6 @@ _begin_fstest auto quick prealloc zero
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/243 b/tests/xfs/243
index 2e537f3f5..ea83a7b44 100755
--- a/tests/xfs/243
+++ b/tests/xfs/243
@@ -23,8 +23,6 @@ _begin_fstest auto quick clone punch prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_debug
 _require_scratch_reflink
 _require_scratch_delalloc
diff --git a/tests/xfs/244 b/tests/xfs/244
index 28f1328ad..8a6337bd1 100755
--- a/tests/xfs/244
+++ b/tests/xfs/244
@@ -21,8 +21,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_quota
 _require_scratch
 _require_projid32bit
diff --git a/tests/xfs/245 b/tests/xfs/245
index 595a5938b..ac2358440 100755
--- a/tests/xfs/245
+++ b/tests/xfs/245
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_debug
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/246 b/tests/xfs/246
index 53e1b8b03..ce97fad5d 100755
--- a/tests/xfs/246
+++ b/tests/xfs/246
@@ -12,8 +12,6 @@ _begin_fstest auto quick clone
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_debug
 _require_xfs_io_command "bmap" "-c"
 _require_scratch
diff --git a/tests/xfs/247 b/tests/xfs/247
index 593ac47b6..2ca75df1d 100755
--- a/tests/xfs/247
+++ b/tests/xfs/247
@@ -14,8 +14,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 
 echo "Format and mount"
diff --git a/tests/xfs/248 b/tests/xfs/248
index 9b95af1d7..ed0f170c1 100755
--- a/tests/xfs/248
+++ b/tests/xfs/248
@@ -20,7 +20,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/249 b/tests/xfs/249
index 4febb79c0..0f92bc3e5 100755
--- a/tests/xfs/249
+++ b/tests/xfs/249
@@ -20,7 +20,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/250 b/tests/xfs/250
index 8af32711b..f8846be6e 100755
--- a/tests/xfs/250
+++ b/tests/xfs/250
@@ -21,8 +21,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 _require_loop
 _require_xfs_io_command "falloc"
@@ -35,7 +33,6 @@ _filter_io()
 	sed -e '/.* ops; /d'
 }
 
-# real QA test starts here
 
 echo "*** create loop mount point"
 rmdir $LOOP_MNT 2>/dev/null
diff --git a/tests/xfs/251 b/tests/xfs/251
index 7e21b5024..b2d062bb9 100755
--- a/tests/xfs/251
+++ b/tests/xfs/251
@@ -22,7 +22,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/252 b/tests/xfs/252
index f167fd5a4..efcf3a342 100755
--- a/tests/xfs/252
+++ b/tests/xfs/252
@@ -13,9 +13,6 @@ _begin_fstest auto quick prealloc punch fiemap
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
-_supported_fs xfs 
-
 _require_test
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
diff --git a/tests/xfs/253 b/tests/xfs/253
index 18c58eb8d..3c9271715 100755
--- a/tests/xfs/253
+++ b/tests/xfs/253
@@ -38,12 +38,10 @@ _require_test
 _require_scratch
 _xfs_setup_verify_metadump
 
-# real QA test starts here
 
 OUTPUT_DIR="${SCRATCH_MNT}/test_${seq}"
 ORPHANAGE="lost+found"
 
-_supported_fs xfs
 
 function create_file() {
 	[ $# -eq 1 ] ||		return 1
diff --git a/tests/xfs/254 b/tests/xfs/254
index f31b6651a..7239ad0e7 100755
--- a/tests/xfs/254
+++ b/tests/xfs/254
@@ -22,7 +22,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/255 b/tests/xfs/255
index c2eade3e5..25f09cbc2 100755
--- a/tests/xfs/255
+++ b/tests/xfs/255
@@ -22,7 +22,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/256 b/tests/xfs/256
index 5162e450a..b1c777b6f 100755
--- a/tests/xfs/256
+++ b/tests/xfs/256
@@ -22,7 +22,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/257 b/tests/xfs/257
index ae1dc98db..536792a50 100755
--- a/tests/xfs/257
+++ b/tests/xfs/257
@@ -23,7 +23,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/258 b/tests/xfs/258
index 7ce7bd2ee..c262ca267 100755
--- a/tests/xfs/258
+++ b/tests/xfs/258
@@ -23,7 +23,6 @@ _begin_fstest auto quick clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_scratch_reflink
 _require_scratch_delalloc
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/259 b/tests/xfs/259
index 88e2f3eed..0c8d6eb56 100755
--- a/tests/xfs/259
+++ b/tests/xfs/259
@@ -18,8 +18,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_test
 _require_loop
 _require_math
diff --git a/tests/xfs/260 b/tests/xfs/260
index a780365f9..bfc98d4ec 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -26,7 +26,6 @@ _cleanup()
 
 echo 'Silence is golden'
 
-_supported_fs xfs
 _require_test
 
 localfile=$TEST_DIR/$seq.$$
diff --git a/tests/xfs/261 b/tests/xfs/261
index eb8a72cd5..a5b536951 100755
--- a/tests/xfs/261
+++ b/tests/xfs/261
@@ -30,10 +30,8 @@ _cleanup()
 
 echo "Silence is golden."
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_quota
 _require_scratch
diff --git a/tests/xfs/262 b/tests/xfs/262
index a4ff6a471..ec33f3b21 100755
--- a/tests/xfs/262
+++ b/tests/xfs/262
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$LDD_PROG" ldd
 _require_scrub
 _require_scratch
diff --git a/tests/xfs/263 b/tests/xfs/263
index 54e9355aa..aedbc4795 100755
--- a/tests/xfs/263
+++ b/tests/xfs/263
@@ -13,10 +13,8 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_quota
diff --git a/tests/xfs/264 b/tests/xfs/264
index 191f57d58..109fecd1c 100755
--- a/tests/xfs/264
+++ b/tests/xfs/264
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_dm_target error
 _require_fs_sysfs error/fail_at_unmount
diff --git a/tests/xfs/265 b/tests/xfs/265
index c0edb6d28..21de4c054 100755
--- a/tests/xfs/265
+++ b/tests/xfs/265
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/xfs/266 b/tests/xfs/266
index eeca8822f..8c5cc4683 100755
--- a/tests/xfs/266
+++ b/tests/xfs/266
@@ -48,8 +48,6 @@ filter_cumulative_quota_updates() {
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 $XFSDUMP_PROG -h 2>&1 | grep -q -e -D
diff --git a/tests/xfs/267 b/tests/xfs/267
index 89b968be1..ca1b0fa20 100755
--- a/tests/xfs/267
+++ b/tests/xfs/267
@@ -42,8 +42,6 @@ End-of-File
 . ./common/dump
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $TAPE_DEV
 _require_attrs trusted
diff --git a/tests/xfs/268 b/tests/xfs/268
index 8c991fba5..0ddb40a50 100755
--- a/tests/xfs/268
+++ b/tests/xfs/268
@@ -45,8 +45,6 @@ End-of-File
 . ./common/dump
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_tape $TAPE_DEV
 _require_attrs trusted user
diff --git a/tests/xfs/269 b/tests/xfs/269
index c14773735..63b42b9c9 100755
--- a/tests/xfs/269
+++ b/tests/xfs/269
@@ -21,7 +21,6 @@ _cleanup()
 . ./common/attr
 . ./common/populate
 
-# real QA test starts here
 _require_scratch
 _require_populate_commands
 _require_test_program "attr-list-by-handle-cursor-test"
diff --git a/tests/xfs/270 b/tests/xfs/270
index 16e508035..3744df5a9 100755
--- a/tests/xfs/270
+++ b/tests/xfs/270
@@ -15,8 +15,6 @@ _begin_fstest auto quick mount
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_kernel_commit 74ad4693b647 \
 	"xfs: fix log recovery when unknown rocompat bits are set"
 # skip fs check because superblock contains unknown ro-compat features
diff --git a/tests/xfs/271 b/tests/xfs/271
index d67ac4d6c..420f4e747 100755
--- a/tests/xfs/271
+++ b/tests/xfs/271
@@ -19,8 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "fsmap"
 
diff --git a/tests/xfs/272 b/tests/xfs/272
index c68fa9d61..b65e2fae5 100755
--- a/tests/xfs/272
+++ b/tests/xfs/272
@@ -19,8 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "fsmap"
 _require_test_program "punch-alternating"
diff --git a/tests/xfs/273 b/tests/xfs/273
index a22e9d472..d7fb80c40 100755
--- a/tests/xfs/273
+++ b/tests/xfs/273
@@ -20,8 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_populate_commands
 _require_xfs_io_command "fsmap"
diff --git a/tests/xfs/274 b/tests/xfs/274
index cd483d77b..d06e7fc13 100755
--- a/tests/xfs/274
+++ b/tests/xfs/274
@@ -20,8 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "fsmap"
diff --git a/tests/xfs/275 b/tests/xfs/275
index d22e21e96..ae0ba5321 100755
--- a/tests/xfs/275
+++ b/tests/xfs/275
@@ -19,8 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_logdev
 _require_scratch
 _require_xfs_io_command "fsmap"
diff --git a/tests/xfs/276 b/tests/xfs/276
index 8cc486752..f21f7a86e 100755
--- a/tests/xfs/276
+++ b/tests/xfs/276
@@ -19,8 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "fsmap"
diff --git a/tests/xfs/277 b/tests/xfs/277
index 03208ef23..5cb44c33e 100755
--- a/tests/xfs/277
+++ b/tests/xfs/277
@@ -19,8 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "fsmap"
 if [ "$USE_EXTERNAL" = "yes" ] && [ -n "$SCRATCH_LOGDEV" ]; then
diff --git a/tests/xfs/278 b/tests/xfs/278
index 4a7e33099..9a949042d 100755
--- a/tests/xfs/278
+++ b/tests/xfs/278
@@ -16,8 +16,6 @@ status=0	# failure is the default!
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 _scratch_mkfs >$seqres.full 2>&1
diff --git a/tests/xfs/279 b/tests/xfs/279
index 9f366d1e7..b3d14ddcc 100755
--- a/tests/xfs/279
+++ b/tests/xfs/279
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/scsi_debug
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scsi_debug
 size=$(_small_fs_size_mb 128)
diff --git a/tests/xfs/280 b/tests/xfs/280
index 35598b2f3..703825de5 100755
--- a/tests/xfs/280
+++ b/tests/xfs/280
@@ -15,8 +15,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_xfs_io_command "bmap"
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/281 b/tests/xfs/281
index 6b148a946..43f6333b3 100755
--- a/tests/xfs/281
+++ b/tests/xfs/281
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_legacy_v2_format
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
diff --git a/tests/xfs/282 b/tests/xfs/282
index 50303b084..4a9c53db5 100755
--- a/tests/xfs/282
+++ b/tests/xfs/282
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_legacy_v2_format
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
diff --git a/tests/xfs/283 b/tests/xfs/283
index 59ea5f3bc..8124807f4 100755
--- a/tests/xfs/283
+++ b/tests/xfs/283
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/dump
 
-# real QA test starts here
-_supported_fs xfs
 _require_legacy_v2_format
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
diff --git a/tests/xfs/284 b/tests/xfs/284
index 443c37575..91c17690c 100755
--- a/tests/xfs/284
+++ b/tests/xfs/284
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$XFS_MDRESTORE_PROG" "xfs_mdrestore"
 _require_xfs_copy
 _require_test
diff --git a/tests/xfs/285 b/tests/xfs/285
index 0056baeb1..909db488b 100755
--- a/tests/xfs/285
+++ b/tests/xfs/285
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/286 b/tests/xfs/286
index 0f61a924d..7743d0371 100755
--- a/tests/xfs/286
+++ b/tests/xfs/286
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/287 b/tests/xfs/287
index 31bbf0d77..3d6800a95 100755
--- a/tests/xfs/287
+++ b/tests/xfs/287
@@ -29,8 +29,6 @@ _print_projid()
 		-c "print core.projid_hi"
 }
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_quota
 _require_scratch
 _require_projid32bit
diff --git a/tests/xfs/288 b/tests/xfs/288
index 60fb9360f..28ff37eb8 100755
--- a/tests/xfs/288
+++ b/tests/xfs/288
@@ -15,7 +15,6 @@ _begin_fstest auto quick repair fuzzers attr
 . ./common/attr
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _require_attrs
 
diff --git a/tests/xfs/289 b/tests/xfs/289
index c722deffa..cf0f2883c 100755
--- a/tests/xfs/289
+++ b/tests/xfs/289
@@ -24,10 +24,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_loop
 
diff --git a/tests/xfs/290 b/tests/xfs/290
index e41a478dc..d28393d03 100755
--- a/tests/xfs/290
+++ b/tests/xfs/290
@@ -18,10 +18,8 @@ _begin_fstest auto rw prealloc quick ioctl zero
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_test
 _require_xfs_io_command "zero"
diff --git a/tests/xfs/291 b/tests/xfs/291
index 2bd94d7b9..831c50d7b 100755
--- a/tests/xfs/291
+++ b/tests/xfs/291
@@ -21,11 +21,9 @@ _cleanup()
 . ./common/filter
 . ./common/metadump
 
-_supported_fs xfs
 _require_command "$XFS_MDRESTORE_PROG" "xfs_mdrestore"
 _xfs_setup_verify_metadump
 
-# real QA test starts here
 _require_scratch
 logblks=$(_scratch_find_xfs_min_logblocks -n size=16k -d size=133m)
 _scratch_mkfs_xfs -n size=16k -l size=${logblks}b -d size=133m >> $seqres.full 2>&1
diff --git a/tests/xfs/292 b/tests/xfs/292
index cf5015710..cdb608799 100755
--- a/tests/xfs/292
+++ b/tests/xfs/292
@@ -13,10 +13,8 @@ _begin_fstest auto mkfs quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 
 fsfile=$TEST_DIR/fsfile.$seq
diff --git a/tests/xfs/293 b/tests/xfs/293
index 7a17eb81c..3e887f1c4 100755
--- a/tests/xfs/293
+++ b/tests/xfs/293
@@ -12,10 +12,8 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_command "$MAN_PROG" man
 
diff --git a/tests/xfs/294 b/tests/xfs/294
index d381e2c85..dd2166a7b 100755
--- a/tests/xfs/294
+++ b/tests/xfs/294
@@ -19,10 +19,8 @@ _begin_fstest auto dir metadata prealloc punch
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _require_test_program "punch-alternating"
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/295 b/tests/xfs/295
index aad3c8998..5ffda1247 100755
--- a/tests/xfs/295
+++ b/tests/xfs/295
@@ -13,10 +13,8 @@ _begin_fstest auto logprint quick
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _require_attrs
 
diff --git a/tests/xfs/296 b/tests/xfs/296
index efd303e21..befbf9dfb 100755
--- a/tests/xfs/296
+++ b/tests/xfs/296
@@ -21,10 +21,8 @@ _cleanup()
 . ./common/filter
 . ./common/dump
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _require_command "$SETCAP_PROG" setcap
 _require_command "$GETCAP_PROG" getcap
diff --git a/tests/xfs/297 b/tests/xfs/297
index 1d1018761..2c5b03c5c 100755
--- a/tests/xfs/297
+++ b/tests/xfs/297
@@ -25,8 +25,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_freeze
diff --git a/tests/xfs/298 b/tests/xfs/298
index b0153ebf9..220835275 100755
--- a/tests/xfs/298
+++ b/tests/xfs/298
@@ -14,11 +14,9 @@ _begin_fstest auto attr symlink quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate. This is a XFS specific bug. xfs_db also limits
 # this test to xfs
-_supported_fs xfs
 
 _require_scratch
 
diff --git a/tests/xfs/299 b/tests/xfs/299
index 1df1988ac..710eb89c2 100755
--- a/tests/xfs/299
+++ b/tests/xfs/299
@@ -23,8 +23,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 cp /dev/null $seqres.full
 chmod a+rwx $seqres.full	# arbitrary users will write here
diff --git a/tests/xfs/300 b/tests/xfs/300
index e21ea2e32..c0b713f0d 100755
--- a/tests/xfs/300
+++ b/tests/xfs/300
@@ -15,9 +15,7 @@ _begin_fstest auto fsr
 _require_scratch
 _require_xfs_nocrc
 
-# real QA test starts here
 
-_supported_fs xfs
 
 getenforce | grep -q "Enforcing\|Permissive" || _notrun "SELinux not enabled"
 [ "$XFS_FSR_PROG" = "" ] && _notrun "xfs_fsr not found"
diff --git a/tests/xfs/301 b/tests/xfs/301
index 71ec14203..986baf29b 100755
--- a/tests/xfs/301
+++ b/tests/xfs/301
@@ -22,10 +22,8 @@ _cleanup()
 . ./common/dump
 . ./common/attr
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/302 b/tests/xfs/302
index 2e16890c7..525a72ff8 100755
--- a/tests/xfs/302
+++ b/tests/xfs/302
@@ -21,10 +21,8 @@ _cleanup()
 . ./common/filter
 . ./common/dump
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/xfs/303 b/tests/xfs/303
index 6aafae85b..95be4b023 100755
--- a/tests/xfs/303
+++ b/tests/xfs/303
@@ -13,8 +13,6 @@ _begin_fstest auto quick quota
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 echo "Silence is golden"
 
diff --git a/tests/xfs/304 b/tests/xfs/304
index 0ee6dad63..565d99f23 100755
--- a/tests/xfs/304
+++ b/tests/xfs/304
@@ -15,7 +15,6 @@ _begin_fstest auto quick quota
 . ./common/quota
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_quota
diff --git a/tests/xfs/305 b/tests/xfs/305
index e76dfdec1..0ad3ef7fb 100755
--- a/tests/xfs/305
+++ b/tests/xfs/305
@@ -15,7 +15,6 @@ _begin_fstest auto quota
 . ./common/quota
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_quota
diff --git a/tests/xfs/306 b/tests/xfs/306
index 152971cfc..e21a56220 100755
--- a/tests/xfs/306
+++ b/tests/xfs/306
@@ -18,7 +18,6 @@ _begin_fstest auto quick punch
 # Import common functions.
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch_nocheck	# check complains about single AG fs
 _require_xfs_io_command "fpunch"
diff --git a/tests/xfs/307 b/tests/xfs/307
index f3c970fad..25d15a9c0 100755
--- a/tests/xfs/307
+++ b/tests/xfs/307
@@ -15,8 +15,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 
 echo "Format"
diff --git a/tests/xfs/308 b/tests/xfs/308
index 6da6622e1..813c4d8d4 100755
--- a/tests/xfs/308
+++ b/tests/xfs/308
@@ -15,8 +15,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 
 echo "Format"
diff --git a/tests/xfs/309 b/tests/xfs/309
index 3e9095094..63ca0a67b 100755
--- a/tests/xfs/309
+++ b/tests/xfs/309
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/xfs/310 b/tests/xfs/310
index edd7d0d78..eb310d8cc 100755
--- a/tests/xfs/310
+++ b/tests/xfs/310
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmhugedisk
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_scratch_nocheck
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/311 b/tests/xfs/311
index d5e3afbfd..8b806fc29 100755
--- a/tests/xfs/311
+++ b/tests/xfs/311
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/dmdelay
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch
 _require_dm_target delay
diff --git a/tests/xfs/312 b/tests/xfs/312
index cb232bdf8..6e47d442b 100755
--- a/tests/xfs/312
+++ b/tests/xfs/312
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/xfs/313 b/tests/xfs/313
index 21e36982c..d0c77db8b 100755
--- a/tests/xfs/313
+++ b/tests/xfs/313
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_xfs_io_command "fpunch"
diff --git a/tests/xfs/314 b/tests/xfs/314
index 9ac311d0c..07596e00b 100755
--- a/tests/xfs/314
+++ b/tests/xfs/314
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_xfs_scratch_rmapbt
diff --git a/tests/xfs/315 b/tests/xfs/315
index 9f6b39c8c..f6c346e18 100755
--- a/tests/xfs/315
+++ b/tests/xfs/315
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_error_injection
diff --git a/tests/xfs/316 b/tests/xfs/316
index 7f7bdd641..63711ed47 100755
--- a/tests/xfs/316
+++ b/tests/xfs/316
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_error_injection
diff --git a/tests/xfs/317 b/tests/xfs/317
index 1ca2672d1..192107f59 100755
--- a/tests/xfs/317
+++ b/tests/xfs/317
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_scratch_rmapbt
 _require_error_injection
diff --git a/tests/xfs/318 b/tests/xfs/318
index 5798f9a38..590d268e6 100755
--- a/tests/xfs/318
+++ b/tests/xfs/318
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_error_injection
 _require_xfs_io_error_injection "rmap_finish_one"
diff --git a/tests/xfs/319 b/tests/xfs/319
index d64651fbf..45b958d8f 100755
--- a/tests/xfs/319
+++ b/tests/xfs/319
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_xfs_io_error_injection "bmap_finish_one"
diff --git a/tests/xfs/320 b/tests/xfs/320
index d22d76d97..f7e4949a3 100755
--- a/tests/xfs/320
+++ b/tests/xfs/320
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_xfs_io_error_injection "bmap_finish_one"
diff --git a/tests/xfs/321 b/tests/xfs/321
index 06a343478..a09e4a8ce 100755
--- a/tests/xfs/321
+++ b/tests/xfs/321
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_xfs_io_error_injection "refcount_finish_one"
diff --git a/tests/xfs/322 b/tests/xfs/322
index a2c3720ed..4cb36a515 100755
--- a/tests/xfs/322
+++ b/tests/xfs/322
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_xfs_scratch_rmapbt
diff --git a/tests/xfs/323 b/tests/xfs/323
index 66737da0b..0579d4a72 100755
--- a/tests/xfs/323
+++ b/tests/xfs/323
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_xfs_io_error_injection "free_extent"
diff --git a/tests/xfs/324 b/tests/xfs/324
index 57cab86a6..485b16215 100755
--- a/tests/xfs/324
+++ b/tests/xfs/324
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_error_injection
diff --git a/tests/xfs/325 b/tests/xfs/325
index 43fb09a6b..2387b8d88 100755
--- a/tests/xfs/325
+++ b/tests/xfs/325
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_error_injection
diff --git a/tests/xfs/326 b/tests/xfs/326
index ac620fc43..5d7afe9bf 100755
--- a/tests/xfs/326
+++ b/tests/xfs/326
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/327 b/tests/xfs/327
index 25855f776..44728c117 100755
--- a/tests/xfs/327
+++ b/tests/xfs/327
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
 
diff --git a/tests/xfs/328 b/tests/xfs/328
index 30e364eb8..085918265 100755
--- a/tests/xfs/328
+++ b/tests/xfs/328
@@ -14,8 +14,6 @@ _begin_fstest auto quick clone fsr prealloc
 . ./common/attr
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_test_program "punch-alternating"
diff --git a/tests/xfs/329 b/tests/xfs/329
index 12b7c6084..ed39ebc9b 100755
--- a/tests/xfs/329
+++ b/tests/xfs/329
@@ -15,8 +15,6 @@ _begin_fstest auto quick clone fsr
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_command "$XFS_FSR_PROG" "xfs_fsr"
diff --git a/tests/xfs/330 b/tests/xfs/330
index c6e74e67e..d239a6408 100755
--- a/tests/xfs/330
+++ b/tests/xfs/330
@@ -15,8 +15,6 @@ _begin_fstest auto quick clone fsr quota prealloc
 . ./common/reflink
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "falloc" # used in FSR
diff --git a/tests/xfs/331 b/tests/xfs/331
index 2332533fb..7c9a1e7e2 100755
--- a/tests/xfs/331
+++ b/tests/xfs/331
@@ -13,8 +13,6 @@ _begin_fstest auto quick rmap clone prealloc
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_scratch_rmapbt
 _require_scratch_reflink
diff --git a/tests/xfs/332 b/tests/xfs/332
index a2d37ee90..93c94bcdc 100755
--- a/tests/xfs/332
+++ b/tests/xfs/332
@@ -13,8 +13,6 @@ _begin_fstest auto quick rmap clone collapse punch insert zero prealloc
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_command "$XFS_DB_PROG" "xfs_db"
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/333 b/tests/xfs/333
index 728c51840..f68f2f013 100755
--- a/tests/xfs/333
+++ b/tests/xfs/333
@@ -12,8 +12,6 @@ _begin_fstest auto quick rmap realtime
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _disable_dmesg_check
 
diff --git a/tests/xfs/334 b/tests/xfs/334
index cf7b104a6..e15e039b4 100755
--- a/tests/xfs/334
+++ b/tests/xfs/334
@@ -12,8 +12,6 @@ _begin_fstest auto quick rmap realtime
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 
diff --git a/tests/xfs/335 b/tests/xfs/335
index 79d071164..bbf00aa8f 100755
--- a/tests/xfs/335
+++ b/tests/xfs/335
@@ -12,8 +12,6 @@ _begin_fstest auto rmap realtime prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_test_program "punch-alternating"
diff --git a/tests/xfs/336 b/tests/xfs/336
index 3c30f1a40..3f85429ea 100755
--- a/tests/xfs/336
+++ b/tests/xfs/336
@@ -19,8 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$XFS_MDRESTORE_PROG" "xfs_mdrestore"
 _require_realtime
 _require_xfs_scratch_rmapbt
diff --git a/tests/xfs/337 b/tests/xfs/337
index f74baae9b..ca232c1c5 100755
--- a/tests/xfs/337
+++ b/tests/xfs/337
@@ -12,8 +12,6 @@ _begin_fstest fuzzers rmap realtime prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_test_program "punch-alternating"
diff --git a/tests/xfs/338 b/tests/xfs/338
index 9f36150c7..1bdec2bfa 100755
--- a/tests/xfs/338
+++ b/tests/xfs/338
@@ -12,8 +12,6 @@ _begin_fstest auto quick rmap realtime
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 
diff --git a/tests/xfs/339 b/tests/xfs/339
index 3e0b4d97a..90faac784 100755
--- a/tests/xfs/339
+++ b/tests/xfs/339
@@ -12,8 +12,6 @@ _begin_fstest auto quick rmap realtime
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 
diff --git a/tests/xfs/340 b/tests/xfs/340
index 2c0014513..58c4176a6 100755
--- a/tests/xfs/340
+++ b/tests/xfs/340
@@ -12,8 +12,6 @@ _begin_fstest auto quick rmap realtime
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 
diff --git a/tests/xfs/341 b/tests/xfs/341
index 1f734c901..424deb3eb 100755
--- a/tests/xfs/341
+++ b/tests/xfs/341
@@ -12,8 +12,6 @@ _begin_fstest auto quick rmap realtime prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_test_program "punch-alternating"
diff --git a/tests/xfs/342 b/tests/xfs/342
index 538c8987e..9360ddbe7 100755
--- a/tests/xfs/342
+++ b/tests/xfs/342
@@ -12,8 +12,6 @@ _begin_fstest auto quick rmap realtime prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_test_program "punch-alternating"
diff --git a/tests/xfs/343 b/tests/xfs/343
index bffcc7d9a..a5834cab1 100755
--- a/tests/xfs/343
+++ b/tests/xfs/343
@@ -12,8 +12,6 @@ _begin_fstest auto quick rmap collapse punch insert zero realtime prealloc
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/344 b/tests/xfs/344
index adb6627e4..501cae678 100755
--- a/tests/xfs/344
+++ b/tests/xfs/344
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone fiemap unshare
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/345 b/tests/xfs/345
index 36625e834..d0e4469e0 100755
--- a/tests/xfs/345
+++ b/tests/xfs/345
@@ -16,8 +16,6 @@ _begin_fstest auto quick clone fiemap unshare
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/346 b/tests/xfs/346
index 9ce58ab8b..875643bc9 100755
--- a/tests/xfs/346
+++ b/tests/xfs/346
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone fiemap unshare
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/347 b/tests/xfs/347
index 1867c08cc..f9c296a86 100755
--- a/tests/xfs/347
+++ b/tests/xfs/347
@@ -17,8 +17,6 @@ _begin_fstest auto quick clone fiemap unshare
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fiemap"
diff --git a/tests/xfs/348 b/tests/xfs/348
index d1645d946..3502605c4 100755
--- a/tests/xfs/348
+++ b/tests/xfs/348
@@ -16,8 +16,6 @@ _begin_fstest auto quick fuzzers repair
 . ./common/filter
 . ./common/repair
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 # This test will corrupt fs intentionally, so there will be WARNINGs
diff --git a/tests/xfs/349 b/tests/xfs/349
index 76745097a..3937b4fdb 100755
--- a/tests/xfs/349
+++ b/tests/xfs/349
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_scrub
diff --git a/tests/xfs/350 b/tests/xfs/350
index aeb995784..4e618f41c 100755
--- a/tests/xfs/350
+++ b/tests/xfs/350
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/351 b/tests/xfs/351
index 74765aea5..d03cc3315 100755
--- a/tests/xfs/351
+++ b/tests/xfs/351
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/352 b/tests/xfs/352
index 49bd85b2f..8f56a2b8f 100755
--- a/tests/xfs/352
+++ b/tests/xfs/352
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/353 b/tests/xfs/353
index b58dc9cb6..017e3ce28 100755
--- a/tests/xfs/353
+++ b/tests/xfs/353
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/354 b/tests/xfs/354
index 8abf527ea..625c4e955 100755
--- a/tests/xfs/354
+++ b/tests/xfs/354
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/355 b/tests/xfs/355
index 2d552a591..f7377bd89 100755
--- a/tests/xfs/355
+++ b/tests/xfs/355
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/356 b/tests/xfs/356
index 9d5ff2518..3529425eb 100755
--- a/tests/xfs/356
+++ b/tests/xfs/356
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/357 b/tests/xfs/357
index 25af8624d..d21b9d320 100755
--- a/tests/xfs/357
+++ b/tests/xfs/357
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/358 b/tests/xfs/358
index 92180e519..11b29c5ce 100755
--- a/tests/xfs/358
+++ b/tests/xfs/358
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/359 b/tests/xfs/359
index 0498aaccf..8d0da3d1f 100755
--- a/tests/xfs/359
+++ b/tests/xfs/359
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/360 b/tests/xfs/360
index c34f45540..7f5348a18 100755
--- a/tests/xfs/360
+++ b/tests/xfs/360
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/361 b/tests/xfs/361
index 22b1af4ea..46f84888c 100755
--- a/tests/xfs/361
+++ b/tests/xfs/361
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/362 b/tests/xfs/362
index 51727edc0..0b54fc580 100755
--- a/tests/xfs/362
+++ b/tests/xfs/362
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/363 b/tests/xfs/363
index 8a62c1c82..9a5e893c2 100755
--- a/tests/xfs/363
+++ b/tests/xfs/363
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/364 b/tests/xfs/364
index 984ecdafe..002b47650 100755
--- a/tests/xfs/364
+++ b/tests/xfs/364
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/365 b/tests/xfs/365
index e4325c35d..7a7bb51a6 100755
--- a/tests/xfs/365
+++ b/tests/xfs/365
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/366 b/tests/xfs/366
index 8a52d21a0..e902d1d36 100755
--- a/tests/xfs/366
+++ b/tests/xfs/366
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _require_xfs_finobt
 
diff --git a/tests/xfs/367 b/tests/xfs/367
index d9d07faab..5a357bc6a 100755
--- a/tests/xfs/367
+++ b/tests/xfs/367
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _require_xfs_finobt
 
diff --git a/tests/xfs/368 b/tests/xfs/368
index 83499827c..3de32a0c3 100755
--- a/tests/xfs/368
+++ b/tests/xfs/368
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
 
diff --git a/tests/xfs/369 b/tests/xfs/369
index 3236b50e0..398ff9e94 100755
--- a/tests/xfs/369
+++ b/tests/xfs/369
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
 
diff --git a/tests/xfs/370 b/tests/xfs/370
index 891d5e257..ff19505b4 100755
--- a/tests/xfs/370
+++ b/tests/xfs/370
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
 
diff --git a/tests/xfs/371 b/tests/xfs/371
index f7a336b17..37850c084 100755
--- a/tests/xfs/371
+++ b/tests/xfs/371
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
 
diff --git a/tests/xfs/372 b/tests/xfs/372
index 225032252..01ac0e2b6 100755
--- a/tests/xfs/372
+++ b/tests/xfs/372
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_scratch_xfs_fuzz_fields
 
diff --git a/tests/xfs/373 b/tests/xfs/373
index e0c20044e..6759d78fc 100755
--- a/tests/xfs/373
+++ b/tests/xfs/373
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_scratch_xfs_fuzz_fields
 
diff --git a/tests/xfs/374 b/tests/xfs/374
index e3af7e4b8..807a8cd01 100755
--- a/tests/xfs/374
+++ b/tests/xfs/374
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/375 b/tests/xfs/375
index cb0efefe1..6518ac3c2 100755
--- a/tests/xfs/375
+++ b/tests/xfs/375
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/376 b/tests/xfs/376
index 2470e1d9f..dfca8f0be 100755
--- a/tests/xfs/376
+++ b/tests/xfs/376
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/377 b/tests/xfs/377
index eabb03fbf..6be8c45ba 100755
--- a/tests/xfs/377
+++ b/tests/xfs/377
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/378 b/tests/xfs/378
index c1fb40e60..94c0dcdbc 100755
--- a/tests/xfs/378
+++ b/tests/xfs/378
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/379 b/tests/xfs/379
index 1b5bfa41c..b7e89fce9 100755
--- a/tests/xfs/379
+++ b/tests/xfs/379
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/380 b/tests/xfs/380
index aba8441c5..84715b09f 100755
--- a/tests/xfs/380
+++ b/tests/xfs/380
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/381 b/tests/xfs/381
index ea0c44db4..aa5fb9149 100755
--- a/tests/xfs/381
+++ b/tests/xfs/381
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/382 b/tests/xfs/382
index 6cbc2bcf8..ee7a18208 100755
--- a/tests/xfs/382
+++ b/tests/xfs/382
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/383 b/tests/xfs/383
index a7875998d..be6191008 100755
--- a/tests/xfs/383
+++ b/tests/xfs/383
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/384 b/tests/xfs/384
index 409dbbf4c..490701e43 100755
--- a/tests/xfs/384
+++ b/tests/xfs/384
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/385 b/tests/xfs/385
index 2133d296c..63a7649e7 100755
--- a/tests/xfs/385
+++ b/tests/xfs/385
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/386 b/tests/xfs/386
index edeaa9a05..f8f5798cd 100755
--- a/tests/xfs/386
+++ b/tests/xfs/386
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/387 b/tests/xfs/387
index cd46f6fc1..805e27034 100755
--- a/tests/xfs/387
+++ b/tests/xfs/387
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/388 b/tests/xfs/388
index 42e780c8d..504f786fb 100755
--- a/tests/xfs/388
+++ b/tests/xfs/388
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/389 b/tests/xfs/389
index 258c5ef0d..f40bb6dae 100755
--- a/tests/xfs/389
+++ b/tests/xfs/389
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/390 b/tests/xfs/390
index c3fecd448..c272fd894 100755
--- a/tests/xfs/390
+++ b/tests/xfs/390
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/391 b/tests/xfs/391
index f5b904678..400ec31b8 100755
--- a/tests/xfs/391
+++ b/tests/xfs/391
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/392 b/tests/xfs/392
index 9044da0ce..8eb7b962d 100755
--- a/tests/xfs/392
+++ b/tests/xfs/392
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/393 b/tests/xfs/393
index 700691e11..e18572b5a 100755
--- a/tests/xfs/393
+++ b/tests/xfs/393
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/394 b/tests/xfs/394
index c9eabcd83..692d45f54 100755
--- a/tests/xfs/394
+++ b/tests/xfs/394
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/395 b/tests/xfs/395
index dcbfb51e9..5dac51cfe 100755
--- a/tests/xfs/395
+++ b/tests/xfs/395
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/396 b/tests/xfs/396
index 3209967d8..9b2a9a068 100755
--- a/tests/xfs/396
+++ b/tests/xfs/396
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/397 b/tests/xfs/397
index ebfd7f63b..878929e27 100755
--- a/tests/xfs/397
+++ b/tests/xfs/397
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/398 b/tests/xfs/398
index 08573f360..d9826725f 100755
--- a/tests/xfs/398
+++ b/tests/xfs/398
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/399 b/tests/xfs/399
index 0a5a0bd5e..3a2ea05ab 100755
--- a/tests/xfs/399
+++ b/tests/xfs/399
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/400 b/tests/xfs/400
index f85c04cc4..7191cff0b 100755
--- a/tests/xfs/400
+++ b/tests/xfs/400
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/401 b/tests/xfs/401
index 4c19665ef..0e95a7dfe 100755
--- a/tests/xfs/401
+++ b/tests/xfs/401
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/402 b/tests/xfs/402
index f42b64651..0c2174e2e 100755
--- a/tests/xfs/402
+++ b/tests/xfs/402
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/403 b/tests/xfs/403
index 8e7ab07b1..b9276c8d9 100755
--- a/tests/xfs/403
+++ b/tests/xfs/403
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/404 b/tests/xfs/404
index c0f5c917f..2901b015c 100755
--- a/tests/xfs/404
+++ b/tests/xfs/404
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/405 b/tests/xfs/405
index e33eb8f1b..76f5afb70 100755
--- a/tests/xfs/405
+++ b/tests/xfs/405
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/406 b/tests/xfs/406
index 78db18077..444dbd726 100755
--- a/tests/xfs/406
+++ b/tests/xfs/406
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
diff --git a/tests/xfs/407 b/tests/xfs/407
index 5a43775b5..ee67a40f6 100755
--- a/tests/xfs/407
+++ b/tests/xfs/407
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
diff --git a/tests/xfs/408 b/tests/xfs/408
index 8049d6bea..55b061ed4 100755
--- a/tests/xfs/408
+++ b/tests/xfs/408
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
diff --git a/tests/xfs/409 b/tests/xfs/409
index adac95fea..12d7c5cd9 100755
--- a/tests/xfs/409
+++ b/tests/xfs/409
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
diff --git a/tests/xfs/410 b/tests/xfs/410
index 388ed7d19..4155e03b5 100755
--- a/tests/xfs/410
+++ b/tests/xfs/410
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_scratch_xfs_fuzz_fields
 
diff --git a/tests/xfs/411 b/tests/xfs/411
index a9fc25ce7..93af836be 100755
--- a/tests/xfs/411
+++ b/tests/xfs/411
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_scratch_xfs_fuzz_fields
 
diff --git a/tests/xfs/412 b/tests/xfs/412
index 8b89dd6a8..2119282f9 100755
--- a/tests/xfs/412
+++ b/tests/xfs/412
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/413 b/tests/xfs/413
index c4b525c20..5a36f29c2 100755
--- a/tests/xfs/413
+++ b/tests/xfs/413
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/414 b/tests/xfs/414
index ee5db9c89..c92c6eb0f 100755
--- a/tests/xfs/414
+++ b/tests/xfs/414
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/415 b/tests/xfs/415
index ab7576295..2d5816d0e 100755
--- a/tests/xfs/415
+++ b/tests/xfs/415
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/416 b/tests/xfs/416
index 3e2130683..2ee0e7514 100755
--- a/tests/xfs/416
+++ b/tests/xfs/416
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/417 b/tests/xfs/417
index 3d09ec7e7..30501ea35 100755
--- a/tests/xfs/417
+++ b/tests/xfs/417
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/418 b/tests/xfs/418
index c4ba385c6..dd7b70a46 100755
--- a/tests/xfs/418
+++ b/tests/xfs/418
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/419 b/tests/xfs/419
index bba422653..b9cd21faf 100755
--- a/tests/xfs/419
+++ b/tests/xfs/419
@@ -25,8 +25,6 @@ _begin_fstest auto quick realtime mkfs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch
 
diff --git a/tests/xfs/420 b/tests/xfs/420
index d38772c9d..038682ef9 100755
--- a/tests/xfs/420
+++ b/tests/xfs/420
@@ -36,8 +36,6 @@ _begin_fstest auto quick clone punch seek
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/421 b/tests/xfs/421
index 027ae47c2..ab565e1f6 100755
--- a/tests/xfs/421
+++ b/tests/xfs/421
@@ -36,8 +36,6 @@ _begin_fstest auto quick clone punch seek
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "cowextsize"
diff --git a/tests/xfs/422 b/tests/xfs/422
index 339f12976..1043d4191 100755
--- a/tests/xfs/422
+++ b/tests/xfs/422
@@ -21,8 +21,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/423 b/tests/xfs/423
index a94118cc7..1fbf500d8 100755
--- a/tests/xfs/423
+++ b/tests/xfs/423
@@ -19,8 +19,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_test_program "punch-alternating"
 _require_xfs_io_command "scrub"
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/424 b/tests/xfs/424
index c8d522fd7..71d48bec1 100755
--- a/tests/xfs/424
+++ b/tests/xfs/424
@@ -29,7 +29,6 @@ filter_dbval()
 . ./common/filter
 
 # Modify as appropriate
-_supported_fs xfs
 
 # Since we have an open-coded mkfs call, disable the external devices and
 # don't let the post-check fsck actually run since it'll trip over us not
@@ -40,7 +39,6 @@ export SCRATCH_RTDEV=
 
 echo "Silence is golden."
 
-# real QA test starts here
 
 # for different sector sizes, ensure no CRC errors are falsely reported.
 
diff --git a/tests/xfs/425 b/tests/xfs/425
index 5275e594b..9ca10c666 100755
--- a/tests/xfs/425
+++ b/tests/xfs/425
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _require_quota
 
diff --git a/tests/xfs/426 b/tests/xfs/426
index 06f0f44b6..2cda865a0 100755
--- a/tests/xfs/426
+++ b/tests/xfs/426
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _require_quota
 
diff --git a/tests/xfs/427 b/tests/xfs/427
index 327cddd87..539cb4f15 100755
--- a/tests/xfs/427
+++ b/tests/xfs/427
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _require_quota
 
diff --git a/tests/xfs/428 b/tests/xfs/428
index 80b05b845..31694e180 100755
--- a/tests/xfs/428
+++ b/tests/xfs/428
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _require_quota
 
diff --git a/tests/xfs/429 b/tests/xfs/429
index 5fa3b2ce2..b0b5fa577 100755
--- a/tests/xfs/429
+++ b/tests/xfs/429
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _require_quota
 
diff --git a/tests/xfs/430 b/tests/xfs/430
index 6f5c772df..6331f82ea 100755
--- a/tests/xfs/430
+++ b/tests/xfs/430
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _require_quota
 
diff --git a/tests/xfs/431 b/tests/xfs/431
index 68c57525e..9764d2437 100755
--- a/tests/xfs/431
+++ b/tests/xfs/431
@@ -17,10 +17,8 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_io_command "chattr" "t"
 _require_xfs_io_command "fsync"
 _require_xfs_io_command "pwrite"
diff --git a/tests/xfs/432 b/tests/xfs/432
index 4eae92e75..0e531e963 100755
--- a/tests/xfs/432
+++ b/tests/xfs/432
@@ -28,8 +28,6 @@ _cleanup()
 . ./common/filter
 . ./common/metadump
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$XFS_MDRESTORE_PROG" "xfs_mdrestore"
 _require_scratch
 _xfs_setup_verify_metadump
diff --git a/tests/xfs/433 b/tests/xfs/433
index 54686e38c..ca8ef377d 100755
--- a/tests/xfs/433
+++ b/tests/xfs/433
@@ -24,10 +24,8 @@ _begin_fstest auto quick attr
 . ./common/attr
 . ./common/inject
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_xfs_io_error_injection buf_lru_ref
 _require_scratch
 _require_attrs
diff --git a/tests/xfs/434 b/tests/xfs/434
index ca80e1275..c51228843 100755
--- a/tests/xfs/434
+++ b/tests/xfs/434
@@ -28,8 +28,6 @@ _begin_fstest auto quick clone fsr
 . ./common/quota
 . ./common/module
 
-# real QA test starts here
-_supported_fs xfs
 _require_quota
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/xfs/435 b/tests/xfs/435
index b52e9287d..0bb5675e1 100755
--- a/tests/xfs/435
+++ b/tests/xfs/435
@@ -22,8 +22,6 @@ _begin_fstest auto quick clone
 . ./common/quota
 . ./common/module
 
-# real QA test starts here
-_supported_fs xfs
 _require_quota
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/xfs/436 b/tests/xfs/436
index 02bcd6690..1f7eb329e 100755
--- a/tests/xfs/436
+++ b/tests/xfs/436
@@ -25,8 +25,6 @@ _begin_fstest auto quick clone fsr
 . ./common/inject
 . ./common/module
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command falloc # fsr requires support for preallocation
diff --git a/tests/xfs/438 b/tests/xfs/438
index 0425c5b1f..0239778c5 100755
--- a/tests/xfs/438
+++ b/tests/xfs/438
@@ -88,7 +88,6 @@ make_xfs_scratch_flakey_table()
 . ./common/dmflakey
 . ./common/quota
 
-_supported_fs xfs
 
 # due to the injection of write IO error, the fs will be inconsistent
 _require_scratch_nocheck
diff --git a/tests/xfs/439 b/tests/xfs/439
index 3497e67cc..5736b7a78 100755
--- a/tests/xfs/439
+++ b/tests/xfs/439
@@ -17,8 +17,6 @@ _begin_fstest auto quick fuzzers log
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 
 # We corrupt XFS on purpose, and check if assert failures would crash the
diff --git a/tests/xfs/440 b/tests/xfs/440
index 368ee8a05..fc7319449 100755
--- a/tests/xfs/440
+++ b/tests/xfs/440
@@ -17,7 +17,6 @@ _begin_fstest auto quick clone quota
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_quota
 _require_scratch_delalloc
diff --git a/tests/xfs/441 b/tests/xfs/441
index 82654bf33..ca3c576ad 100755
--- a/tests/xfs/441
+++ b/tests/xfs/441
@@ -16,7 +16,6 @@ _begin_fstest auto quick clone quota
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_quota
 _require_scratch_reflink
diff --git a/tests/xfs/442 b/tests/xfs/442
index b04b1c834..77d08fda5 100755
--- a/tests/xfs/442
+++ b/tests/xfs/442
@@ -26,7 +26,6 @@ _cleanup()
 . ./common/reflink
 
 # Modify as appropriate.
-_supported_fs xfs
 
 _require_scratch_reflink
 _require_quota
diff --git a/tests/xfs/443 b/tests/xfs/443
index 069d976cb..8db51a834 100755
--- a/tests/xfs/443
+++ b/tests/xfs/443
@@ -21,10 +21,8 @@ _begin_fstest auto quick ioctl fsr punch fiemap prealloc
 . ./common/filter
 . ./common/punch
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch
 _require_test_program "punch-alternating"
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/444 b/tests/xfs/444
index db7418c55..85ae94cbc 100755
--- a/tests/xfs/444
+++ b/tests/xfs/444
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup; rm -f $tmp.*"
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_check_dmesg
 _require_scratch
diff --git a/tests/xfs/445 b/tests/xfs/445
index ca956efc7..c31b134b8 100755
--- a/tests/xfs/445
+++ b/tests/xfs/445
@@ -24,7 +24,6 @@ _begin_fstest auto quick filestreams prealloc
 . ./common/filter
 . ./common/filestreams
 
-# real QA test starts here
 drop_caches()
 {
 	while [ true ]; do
@@ -34,7 +33,6 @@ drop_caches()
 }
 
 # Modify as appropriate.
-_supported_fs generic
 _require_scratch_size $((2*1024*1024)) # kb
 _require_xfs_io_command "falloc"
 
diff --git a/tests/xfs/446 b/tests/xfs/446
index 2481bbaf1..099daeed6 100755
--- a/tests/xfs/446
+++ b/tests/xfs/446
@@ -11,8 +11,6 @@ _begin_fstest auto quick
 
 # get standard environment
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$CHECKBASHISMS_PROG" checkbashisms
 
 test -z "$WORKAREA" && _notrun "Can't find xfsprogs source"
diff --git a/tests/xfs/447 b/tests/xfs/447
index 795c43b90..cb7502333 100755
--- a/tests/xfs/447
+++ b/tests/xfs/447
@@ -20,9 +20,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs xfs
 
 _require_scratch
 _require_xfs_sysfs debug/mount_delay
diff --git a/tests/xfs/448 b/tests/xfs/448
index 815f56cb4..88efe2d18 100755
--- a/tests/xfs/448
+++ b/tests/xfs/448
@@ -24,8 +24,6 @@ _begin_fstest auto quick fuzzers
 . ./common/filter
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 _require_xfs_io_command "scrub"
 # Corrupt XFS on purpose, and skip if assert failures would crash system.
diff --git a/tests/xfs/449 b/tests/xfs/449
index 5374bf2f8..3d528e03a 100755
--- a/tests/xfs/449
+++ b/tests/xfs/449
@@ -12,8 +12,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch_nocheck
 
diff --git a/tests/xfs/450 b/tests/xfs/450
index a2ba49dcc..96a1c519a 100755
--- a/tests/xfs/450
+++ b/tests/xfs/450
@@ -15,8 +15,6 @@ _begin_fstest auto quick rmap prealloc
 
 # remove previous \$seqres.full before test
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_io_command "falloc"
 _require_test_program "punch-alternating"
 _require_xfs_scratch_rmapbt
diff --git a/tests/xfs/451 b/tests/xfs/451
index 8ca4e7d1c..80b627dde 100755
--- a/tests/xfs/451
+++ b/tests/xfs/451
@@ -15,10 +15,8 @@ _begin_fstest auto quick metadata repair
 
 echo "Silence is golden"
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 
 _scratch_mkfs >> /dev/null 2>&1
diff --git a/tests/xfs/452 b/tests/xfs/452
index 6c04cd497..5b5c094f2 100755
--- a/tests/xfs/452
+++ b/tests/xfs/452
@@ -14,7 +14,6 @@ _begin_fstest auto db
 . ./common/filter
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 
 _scratch_mkfs_xfs >> $seqres.full 2>&1
diff --git a/tests/xfs/453 b/tests/xfs/453
index 629744538..d586f79dd 100755
--- a/tests/xfs/453
+++ b/tests/xfs/453
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/454 b/tests/xfs/454
index 2540cd01b..828b2d93a 100755
--- a/tests/xfs/454
+++ b/tests/xfs/454
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/455 b/tests/xfs/455
index 9f06c71fa..c5d05b26c 100755
--- a/tests/xfs/455
+++ b/tests/xfs/455
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/456 b/tests/xfs/456
index dca03e108..3b2291570 100755
--- a/tests/xfs/456
+++ b/tests/xfs/456
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/457 b/tests/xfs/457
index 64cd6b4b8..41b51fb60 100755
--- a/tests/xfs/457
+++ b/tests/xfs/457
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/458 b/tests/xfs/458
index 8d87ec569..fff31ce9b 100755
--- a/tests/xfs/458
+++ b/tests/xfs/458
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/459 b/tests/xfs/459
index 5989bc1e6..b55899aed 100755
--- a/tests/xfs/459
+++ b/tests/xfs/459
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/460 b/tests/xfs/460
index 711747701..d67ae555f 100755
--- a/tests/xfs/460
+++ b/tests/xfs/460
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/461 b/tests/xfs/461
index 7c1327b05..7609ce9b0 100755
--- a/tests/xfs/461
+++ b/tests/xfs/461
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 _require_xfs_finobt
diff --git a/tests/xfs/462 b/tests/xfs/462
index 1ee4d27e9..0831f8e96 100755
--- a/tests/xfs/462
+++ b/tests/xfs/462
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/463 b/tests/xfs/463
index 7dd2d37de..cbfd9c3c6 100755
--- a/tests/xfs/463
+++ b/tests/xfs/463
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/464 b/tests/xfs/464
index 719901e66..71ce35572 100755
--- a/tests/xfs/464
+++ b/tests/xfs/464
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/465 b/tests/xfs/465
index 713993008..30c472459 100755
--- a/tests/xfs/465
+++ b/tests/xfs/465
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/466 b/tests/xfs/466
index c1a1628a8..4a470c908 100755
--- a/tests/xfs/466
+++ b/tests/xfs/466
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/467 b/tests/xfs/467
index 42b820d12..d64a7bb8c 100755
--- a/tests/xfs/467
+++ b/tests/xfs/467
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/468 b/tests/xfs/468
index 34612c883..fa501e402 100755
--- a/tests/xfs/468
+++ b/tests/xfs/468
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/469 b/tests/xfs/469
index 630b33296..20fdb78dc 100755
--- a/tests/xfs/469
+++ b/tests/xfs/469
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/470 b/tests/xfs/470
index acc43ba7e..52be985b3 100755
--- a/tests/xfs/470
+++ b/tests/xfs/470
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/471 b/tests/xfs/471
index 7883a00af..6b72b80a8 100755
--- a/tests/xfs/471
+++ b/tests/xfs/471
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/472 b/tests/xfs/472
index a4ab9d750..0ec3335ed 100755
--- a/tests/xfs/472
+++ b/tests/xfs/472
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/473 b/tests/xfs/473
index cbeed3456..12924aee2 100755
--- a/tests/xfs/473
+++ b/tests/xfs/473
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/474 b/tests/xfs/474
index 746e35311..d3c073524 100755
--- a/tests/xfs/474
+++ b/tests/xfs/474
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/475 b/tests/xfs/475
index 20053afe4..06317ee2a 100755
--- a/tests/xfs/475
+++ b/tests/xfs/475
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/476 b/tests/xfs/476
index f8f79e4f4..dd2fbf4da 100755
--- a/tests/xfs/476
+++ b/tests/xfs/476
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/477 b/tests/xfs/477
index 0c2e2b36d..fccd4f56a 100755
--- a/tests/xfs/477
+++ b/tests/xfs/477
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/478 b/tests/xfs/478
index 44e42e3e5..5909bd496 100755
--- a/tests/xfs/478
+++ b/tests/xfs/478
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/479 b/tests/xfs/479
index 9101d6515..e59726ef1 100755
--- a/tests/xfs/479
+++ b/tests/xfs/479
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/480 b/tests/xfs/480
index 4f3ae6dc3..e5a1fa96a 100755
--- a/tests/xfs/480
+++ b/tests/xfs/480
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/481 b/tests/xfs/481
index 48c7580cc..bc36beeec 100755
--- a/tests/xfs/481
+++ b/tests/xfs/481
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
diff --git a/tests/xfs/482 b/tests/xfs/482
index 0192b94cc..66e44efd1 100755
--- a/tests/xfs/482
+++ b/tests/xfs/482
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
diff --git a/tests/xfs/483 b/tests/xfs/483
index 56670ba17..5225a18a7 100755
--- a/tests/xfs/483
+++ b/tests/xfs/483
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/484 b/tests/xfs/484
index 27522bbd5..ef768df8c 100755
--- a/tests/xfs/484
+++ b/tests/xfs/484
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/485 b/tests/xfs/485
index efffbb85b..f3dbc4f66 100755
--- a/tests/xfs/485
+++ b/tests/xfs/485
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/486 b/tests/xfs/486
index 6d7f40316..8ee65c0cb 100755
--- a/tests/xfs/486
+++ b/tests/xfs/486
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/487 b/tests/xfs/487
index a68859395..8bd646ed9 100755
--- a/tests/xfs/487
+++ b/tests/xfs/487
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 _require_quota
diff --git a/tests/xfs/488 b/tests/xfs/488
index 0d54ab8c7..c58d21e22 100755
--- a/tests/xfs/488
+++ b/tests/xfs/488
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 _require_quota
diff --git a/tests/xfs/489 b/tests/xfs/489
index 012416f98..b9df871a2 100755
--- a/tests/xfs/489
+++ b/tests/xfs/489
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 _require_quota
diff --git a/tests/xfs/490 b/tests/xfs/490
index 8c3b06842..a3b074758 100755
--- a/tests/xfs/490
+++ b/tests/xfs/490
@@ -16,10 +16,8 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch_nocheck
 _require_xfs_mkfs_finobt
 
diff --git a/tests/xfs/491 b/tests/xfs/491
index 7402b09a8..05ef2c875 100755
--- a/tests/xfs/491
+++ b/tests/xfs/491
@@ -12,10 +12,8 @@ _begin_fstest auto quick fuzzers
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 
 echo "Format and mount"
diff --git a/tests/xfs/492 b/tests/xfs/492
index 514ac1e46..a3a4a3e07 100755
--- a/tests/xfs/492
+++ b/tests/xfs/492
@@ -12,10 +12,8 @@ _begin_fstest auto quick fuzzers
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch
 
 echo "Format and mount"
diff --git a/tests/xfs/493 b/tests/xfs/493
index 58091ad7d..e728e7b4a 100755
--- a/tests/xfs/493
+++ b/tests/xfs/493
@@ -13,10 +13,8 @@ _begin_fstest auto quick fuzzers
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch_nocheck
 
 echo "Format and mount"
diff --git a/tests/xfs/494 b/tests/xfs/494
index 2ff857589..510ffb107 100755
--- a/tests/xfs/494
+++ b/tests/xfs/494
@@ -12,8 +12,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_io_command "crc32cselftest"
 
 rm -f "$seqres.full"
diff --git a/tests/xfs/495 b/tests/xfs/495
index 8da61f234..b42e7e5b3 100755
--- a/tests/xfs/495
+++ b/tests/xfs/495
@@ -19,8 +19,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 _require_populate_commands
 _require_xfs_db_command "fuzz"
diff --git a/tests/xfs/496 b/tests/xfs/496
index a2624d2e9..22282ba0e 100755
--- a/tests/xfs/496
+++ b/tests/xfs/496
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/497 b/tests/xfs/497
index 9a985d8ce..f9f36c6b0 100755
--- a/tests/xfs/497
+++ b/tests/xfs/497
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/498 b/tests/xfs/498
index 20bd326a0..f46715194 100755
--- a/tests/xfs/498
+++ b/tests/xfs/498
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/499 b/tests/xfs/499
index 383e57192..ae6bbee3a 100755
--- a/tests/xfs/499
+++ b/tests/xfs/499
@@ -15,8 +15,6 @@ _register_cleanup "_cleanup" BUS
 
 . ./common/tracing
 
-# real QA test starts here
-_supported_fs xfs
 _require_ftrace
 _require_command "$CC_PROG" "cc"
 
diff --git a/tests/xfs/500 b/tests/xfs/500
index 7c336e86e..3832f03d8 100755
--- a/tests/xfs/500
+++ b/tests/xfs/500
@@ -12,8 +12,6 @@ testfile=$TEST_DIR/$seq.txt
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 
 # Try regular extent size hint
diff --git a/tests/xfs/501 b/tests/xfs/501
index a9acf0af2..1da4cbf92 100755
--- a/tests/xfs/501
+++ b/tests/xfs/501
@@ -28,8 +28,6 @@ _cleanup()
 # Import common functions.
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_io_error_injection "iunlink_fallback"
 _require_xfs_sysfs debug/log_recovery_delay
 _require_scratch
diff --git a/tests/xfs/502 b/tests/xfs/502
index fb9a82c15..52b8e95a2 100755
--- a/tests/xfs/502
+++ b/tests/xfs/502
@@ -19,8 +19,6 @@ testfile=$TEST_DIR/$seq.txt
 . ./common/inject
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_io_error_injection "iunlink_fallback"
 _require_scratch
 _require_test_program "t_open_tmpfiles"
diff --git a/tests/xfs/503 b/tests/xfs/503
index 01cff7b08..0b62e0aa6 100755
--- a/tests/xfs/503
+++ b/tests/xfs/503
@@ -27,8 +27,6 @@ _cleanup()
 
 testdir=$TEST_DIR/test-$seq
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_command "$XFS_MDRESTORE_PROG" "xfs_mdrestore"
 _require_loop
diff --git a/tests/xfs/504 b/tests/xfs/504
index 291ee4e41..6000923bf 100755
--- a/tests/xfs/504
+++ b/tests/xfs/504
@@ -15,7 +15,6 @@ _begin_fstest auto quick mkfs label
 # Import common functions.
 . ./common/filter
 
-_supported_fs xfs
 _require_scratch_nocheck
 _require_xfs_io_command 'label'
 
diff --git a/tests/xfs/505 b/tests/xfs/505
index 0601b1a85..81f53ffac 100755
--- a/tests/xfs/505
+++ b/tests/xfs/505
@@ -11,8 +11,6 @@ _begin_fstest auto quick spaceman
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$XFS_SPACEMAN_PROG" "xfs_spaceman"
 _require_command "$MAN_PROG" man
 
diff --git a/tests/xfs/506 b/tests/xfs/506
index 1c75fefa7..5d56155a5 100755
--- a/tests/xfs/506
+++ b/tests/xfs/506
@@ -13,8 +13,6 @@ _begin_fstest auto quick health
 . ./common/fuzzy
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 _require_scrub
 _require_xfs_spaceman_command "health"
diff --git a/tests/xfs/507 b/tests/xfs/507
index 8757152e5..75c183c07 100755
--- a/tests/xfs/507
+++ b/tests/xfs/507
@@ -31,8 +31,6 @@ _cleanup()
 . ./common/reflink
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_loop
diff --git a/tests/xfs/508 b/tests/xfs/508
index 47c04f89d..ee1a0371d 100755
--- a/tests/xfs/508
+++ b/tests/xfs/508
@@ -15,8 +15,6 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_quota
 
diff --git a/tests/xfs/509 b/tests/xfs/509
index d04dfbbfb..53c6bd9c0 100755
--- a/tests/xfs/509
+++ b/tests/xfs/509
@@ -138,7 +138,6 @@ _require_xfs_io_command inumbers
 
 # Real QA test starts here
 
-_supported_fs xfs
 
 DIRCOUNT=8
 INOCOUNT=$((2048 / DIRCOUNT))
diff --git a/tests/xfs/510 b/tests/xfs/510
index 5784077c5..ca0f2c39b 100755
--- a/tests/xfs/510
+++ b/tests/xfs/510
@@ -19,9 +19,7 @@ _begin_fstest auto ioctl quick
 
 _require_test_program "bulkstat_null_ocount"
 
-# real QA test starts here
 
-_supported_fs xfs
 
 echo "Silence is golden."
 $here/src/bulkstat_null_ocount $TEST_DIR
diff --git a/tests/xfs/511 b/tests/xfs/511
index d2550404b..b55c34b92 100755
--- a/tests/xfs/511
+++ b/tests/xfs/511
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_quota
 
diff --git a/tests/xfs/512 b/tests/xfs/512
index 4595770e5..120a6d6ba 100755
--- a/tests/xfs/512
+++ b/tests/xfs/512
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_test
 _require_runas
diff --git a/tests/xfs/513 b/tests/xfs/513
index 3a85ed429..5585a9c8e 100755
--- a/tests/xfs/513
+++ b/tests/xfs/513
@@ -29,8 +29,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_kernel_commit 237d7887ae72 \
 	"xfs: show the proper user quota options"
 
diff --git a/tests/xfs/514 b/tests/xfs/514
index 94f98398f..d3641c3e1 100755
--- a/tests/xfs/514
+++ b/tests/xfs/514
@@ -18,8 +18,6 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$XFS_DB_PROG" "xfs_db"
 _require_command "$MAN_PROG" man
 _require_test
diff --git a/tests/xfs/515 b/tests/xfs/515
index adb2bd6f1..7d6e99405 100755
--- a/tests/xfs/515
+++ b/tests/xfs/515
@@ -18,8 +18,6 @@ _cleanup()
 
 # Import common functions.
 
-# real QA test starts here
-_supported_fs xfs
 _require_command "$XFS_QUOTA_PROG" "xfs_quota"
 _require_command "$MAN_PROG" man
 _require_test
diff --git a/tests/xfs/516 b/tests/xfs/516
index 1bf6f858d..e52779cf3 100755
--- a/tests/xfs/516
+++ b/tests/xfs/516
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_nocheck
 
 # Assume that if we can run scrub on the test dev we can run it on the scratch
diff --git a/tests/xfs/517 b/tests/xfs/517
index 68438e544..4d3d24be7 100755
--- a/tests/xfs/517
+++ b/tests/xfs/517
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/fuzzy
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "fsmap"
 _require_xfs_stress_scrub
diff --git a/tests/xfs/518 b/tests/xfs/518
index 332ff16a4..ee5558e73 100755
--- a/tests/xfs/518
+++ b/tests/xfs/518
@@ -14,8 +14,6 @@ _begin_fstest auto quick quota
 . ./common/filter
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_quota
 
diff --git a/tests/xfs/519 b/tests/xfs/519
index 49c62b56f..ac815f123 100755
--- a/tests/xfs/519
+++ b/tests/xfs/519
@@ -15,8 +15,6 @@ _begin_fstest auto quick clone
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/xfs/520 b/tests/xfs/520
index dd6d845e7..3895db3a2 100755
--- a/tests/xfs/520
+++ b/tests/xfs/520
@@ -25,9 +25,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
-_supported_fs xfs
 _disable_dmesg_check
 _require_check_dmesg
 _require_scratch_nocheck
diff --git a/tests/xfs/521 b/tests/xfs/521
index 60f28740c..13982c440 100755
--- a/tests/xfs/521
+++ b/tests/xfs/521
@@ -28,8 +28,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 # Note that we don't _require_realtime because we synthesize a rt volume
 # below.
 _require_scratch_nocheck
diff --git a/tests/xfs/522 b/tests/xfs/522
index 05251b0e2..4c5022487 100755
--- a/tests/xfs/522
+++ b/tests/xfs/522
@@ -20,10 +20,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_scratch_nocheck
 _require_xfs_mkfs_cfgfile
diff --git a/tests/xfs/523 b/tests/xfs/523
index bd9b75532..f069b15d3 100755
--- a/tests/xfs/523
+++ b/tests/xfs/523
@@ -20,10 +20,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_scratch_nocheck
 _require_xfs_mkfs_cfgfile
diff --git a/tests/xfs/524 b/tests/xfs/524
index fe4d134b7..ef47a8461 100755
--- a/tests/xfs/524
+++ b/tests/xfs/524
@@ -19,10 +19,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_scratch_nocheck
 _require_xfs_mkfs_cfgfile
diff --git a/tests/xfs/525 b/tests/xfs/525
index a17c9f19b..8418267b6 100755
--- a/tests/xfs/525
+++ b/tests/xfs/525
@@ -19,10 +19,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_scratch_nocheck
 _require_xfs_mkfs_cfgfile
diff --git a/tests/xfs/526 b/tests/xfs/526
index c5c5f9b1a..94557e94e 100755
--- a/tests/xfs/526
+++ b/tests/xfs/526
@@ -19,10 +19,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_scratch_nocheck
 _require_xfs_mkfs_cfgfile
diff --git a/tests/xfs/527 b/tests/xfs/527
index 8abc866ff..2ef428c25 100755
--- a/tests/xfs/527
+++ b/tests/xfs/527
@@ -20,8 +20,6 @@ _begin_fstest auto quick quota
 # Import common functions.
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_debug
 _require_quota
 _require_scratch
diff --git a/tests/xfs/528 b/tests/xfs/528
index 2bd8c289f..6ca9a2370 100755
--- a/tests/xfs/528
+++ b/tests/xfs/528
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_loop
 _require_command "$FILEFRAG_PROG" filefrag
 _require_xfs_io_command "fpunch"
diff --git a/tests/xfs/529 b/tests/xfs/529
index cd176877f..14bdd2eeb 100755
--- a/tests/xfs/529
+++ b/tests/xfs/529
@@ -17,9 +17,7 @@ _begin_fstest auto quick quota prealloc
 . ./common/inject
 . ./common/populate
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_xfs_quota
 _require_xfs_debug
diff --git a/tests/xfs/530 b/tests/xfs/530
index 56f5e7ebd..8a182bd6a 100755
--- a/tests/xfs/530
+++ b/tests/xfs/530
@@ -24,9 +24,7 @@ _cleanup()
 . ./common/inject
 . ./common/populate
 
-# real QA test starts here
 
-_supported_fs xfs
 # Note that we don't _require_realtime because we synthesize a rt volume
 # below.
 _require_test
diff --git a/tests/xfs/531 b/tests/xfs/531
index 48cb37cd3..5b77c22c1 100755
--- a/tests/xfs/531
+++ b/tests/xfs/531
@@ -13,9 +13,7 @@ _begin_fstest auto quick punch zero insert collapse
 . ./common/filter
 . ./common/inject
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_xfs_debug
 _require_xfs_io_command "fpunch"
diff --git a/tests/xfs/532 b/tests/xfs/532
index 74a7ac30d..c196799e8 100755
--- a/tests/xfs/532
+++ b/tests/xfs/532
@@ -15,9 +15,7 @@ _begin_fstest auto quick attr
 . ./common/inject
 . ./common/populate
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_attrs
 _require_xfs_debug
diff --git a/tests/xfs/533 b/tests/xfs/533
index 31858cc99..8189b9431 100755
--- a/tests/xfs/533
+++ b/tests/xfs/533
@@ -14,8 +14,6 @@
 . ./common/preamble
 _begin_fstest auto quick db
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_git_commit xfsprogs f4afdcb0ad11 \
 	"xfs_db: clean up the salvage read callsites in set_cur()"
 #skip fs check because invalid superblock 1
diff --git a/tests/xfs/534 b/tests/xfs/534
index f17c45b8c..2bbf474df 100755
--- a/tests/xfs/534
+++ b/tests/xfs/534
@@ -13,9 +13,7 @@ _begin_fstest auto quick prealloc
 . ./common/filter
 . ./common/inject
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_xfs_debug
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/535 b/tests/xfs/535
index f76c17257..9b1c4150a 100755
--- a/tests/xfs/535
+++ b/tests/xfs/535
@@ -14,9 +14,7 @@ _begin_fstest auto quick clone unshare
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_scratch_reflink
 _require_xfs_debug
diff --git a/tests/xfs/536 b/tests/xfs/536
index 64fa4fbf8..ff693425e 100755
--- a/tests/xfs/536
+++ b/tests/xfs/536
@@ -14,9 +14,7 @@ _begin_fstest auto quick clone
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_scratch_reflink
 _require_xfs_debug
diff --git a/tests/xfs/537 b/tests/xfs/537
index 6364db9b5..0967ac99d 100755
--- a/tests/xfs/537
+++ b/tests/xfs/537
@@ -13,9 +13,7 @@ _begin_fstest auto quick collapse swapext
 . ./common/filter
 . ./common/inject
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_xfs_debug
 _require_xfs_scratch_rmapbt
diff --git a/tests/xfs/538 b/tests/xfs/538
index 0b5772a1c..57113d341 100755
--- a/tests/xfs/538
+++ b/tests/xfs/538
@@ -14,9 +14,7 @@ _begin_fstest auto stress
 . ./common/inject
 . ./common/populate
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_xfs_debug
 _require_test_program "punch-alternating"
diff --git a/tests/xfs/539 b/tests/xfs/539
index 778dce852..b9bb7cc12 100755
--- a/tests/xfs/539
+++ b/tests/xfs/539
@@ -16,7 +16,6 @@ _begin_fstest auto quick mount
 
 # Import common functions.
 
-_supported_fs xfs
 _fixed_by_kernel_commit 92cf7d36384b \
 	"xfs: Skip repetitive warnings about mount options"
 
diff --git a/tests/xfs/540 b/tests/xfs/540
index 55484dd33..3acb20951 100755
--- a/tests/xfs/540
+++ b/tests/xfs/540
@@ -23,8 +23,6 @@ _begin_fstest auto repair fuzzers
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 
 echo "Format and mount"
diff --git a/tests/xfs/541 b/tests/xfs/541
index ae2fd819d..f18b801cf 100755
--- a/tests/xfs/541
+++ b/tests/xfs/541
@@ -21,10 +21,8 @@ _begin_fstest auto quick realtime growfs
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_realtime
 _require_scratch
 
diff --git a/tests/xfs/542 b/tests/xfs/542
index 1540541ec..09200c005 100755
--- a/tests/xfs/542
+++ b/tests/xfs/542
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/reflink
 . ./common/dmflakey
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_kernel_commit 5ca5916b6bc9 \
 	"xfs: punch out data fork delalloc blocks on COW writeback failure"
 
diff --git a/tests/xfs/543 b/tests/xfs/543
index 913276c8e..f22fa84cf 100755
--- a/tests/xfs/543
+++ b/tests/xfs/543
@@ -21,10 +21,8 @@ _cleanup()
 # Import common functions.
 # . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test
 _require_xfs_mkfs_cfgfile
 
diff --git a/tests/xfs/544 b/tests/xfs/544
index c7251fc31..bd694453d 100755
--- a/tests/xfs/544
+++ b/tests/xfs/544
@@ -24,9 +24,7 @@ _cleanup()
 . ./common/filter
 . ./common/dump
 
-# real QA test starts here
 
-_supported_fs xfs
 
 # Setup
 rm -rf $TEST_DIR/src.$seq
diff --git a/tests/xfs/545 b/tests/xfs/545
index 57a650aca..21f622260 100755
--- a/tests/xfs/545
+++ b/tests/xfs/545
@@ -13,7 +13,6 @@ _begin_fstest auto quick dump prealloc
 # Import common functions.
 . ./common/dump
 
-_supported_fs xfs
 _require_xfs_io_command "falloc"
 _require_scratch
 
diff --git a/tests/xfs/546 b/tests/xfs/546
index 8c903a1b5..316ffc50b 100755
--- a/tests/xfs/546
+++ b/tests/xfs/546
@@ -25,10 +25,8 @@
 . ./common/preamble
 _begin_fstest auto quick shutdown
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_io_command syncfs
 _require_scratch_nocheck
 _require_scratch_shutdown
diff --git a/tests/xfs/547 b/tests/xfs/547
index 60121eb9f..eada4aadc 100755
--- a/tests/xfs/547
+++ b/tests/xfs/547
@@ -16,8 +16,6 @@ _begin_fstest auto quick metadata
 . ./common/inject
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_nrext64
 _require_attrs
diff --git a/tests/xfs/548 b/tests/xfs/548
index 560c90fdd..f0b58563e 100755
--- a/tests/xfs/548
+++ b/tests/xfs/548
@@ -16,8 +16,6 @@ _begin_fstest auto quick metadata
 . ./common/inject
 . ./common/populate
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_nrext64
 _require_attrs
diff --git a/tests/xfs/549 b/tests/xfs/549
index 925ca993f..a73832462 100755
--- a/tests/xfs/549
+++ b/tests/xfs/549
@@ -14,8 +14,6 @@
 . ./common/preamble
 _begin_fstest auto quick mkfs
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_git_commit xfsprogs 50dba8189b1f \
 	"mkfs: terminate getsubopt arrays properly"
 _require_test
diff --git a/tests/xfs/550 b/tests/xfs/550
index 87ae41105..cecc2ea29 100755
--- a/tests/xfs/550
+++ b/tests/xfs/550
@@ -13,7 +13,6 @@ _begin_fstest auto quick dax
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_check_dmesg
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/xfs/551 b/tests/xfs/551
index f4af72ed2..72f71e25b 100755
--- a/tests/xfs/551
+++ b/tests/xfs/551
@@ -13,7 +13,6 @@ _begin_fstest auto quick clone dax
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_check_dmesg
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/xfs/552 b/tests/xfs/552
index cb97b2ff6..facee8cd6 100755
--- a/tests/xfs/552
+++ b/tests/xfs/552
@@ -14,7 +14,6 @@ _begin_fstest auto quick clone dax
 . ./common/filter
 . ./common/reflink
 
-# real QA test starts here
 _require_check_dmesg
 _require_scratch_reflink
 _require_xfs_scratch_rmapbt
diff --git a/tests/xfs/553 b/tests/xfs/553
index e98c04ed7..f4294e9c1 100755
--- a/tests/xfs/553
+++ b/tests/xfs/553
@@ -14,8 +14,6 @@ _begin_fstest auto quick clone
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_kernel_commit d62113303d691 \
 	"xfs: Fix false ENOSPC when performing direct write on a delalloc extent in cow fork"
 _require_scratch_reflink
diff --git a/tests/xfs/554 b/tests/xfs/554
index 16fc052cc..450da84de 100755
--- a/tests/xfs/554
+++ b/tests/xfs/554
@@ -14,7 +14,6 @@ _begin_fstest auto quick dump prealloc
 # Import common functions.
 . ./common/dump
 
-_supported_fs xfs
 _fixed_by_git_commit xfsdump \
 	"XXXXXXXXXXXX xfsrestore: fix rootdir due to xfsdump bulkstat misuse"
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/555 b/tests/xfs/555
index a40245011..17d32ab16 100755
--- a/tests/xfs/555
+++ b/tests/xfs/555
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_kernel_commit 392c6de98af1 \
 	"xfs: sanitize sb_inopblock in xfs_mount_validate_sb"
 _require_scratch
diff --git a/tests/xfs/556 b/tests/xfs/556
index 2f8cad1a2..5a2e7fd6d 100755
--- a/tests/xfs/556
+++ b/tests/xfs/556
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmerror
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_scratch_xfs_crc
 _require_scrub
diff --git a/tests/xfs/557 b/tests/xfs/557
index 01205377b..706b0bba4 100755
--- a/tests/xfs/557
+++ b/tests/xfs/557
@@ -13,7 +13,6 @@
 . ./common/preamble
 _begin_fstest auto quick prealloc
 
-_supported_fs xfs
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "bulkstat_single"
 _require_scratch
diff --git a/tests/xfs/558 b/tests/xfs/558
index 270f458cb..ec2fbcb68 100755
--- a/tests/xfs/558
+++ b/tests/xfs/558
@@ -96,7 +96,6 @@ _begin_fstest auto quick clone
 . ./common/inject
 . ./common/tracing
 
-# real QA test starts here
 _cleanup()
 {
 	test -n "$sentryfile" && rm -f $sentryfile
@@ -107,7 +106,6 @@ _cleanup()
 }
 
 # Modify as appropriate.
-_supported_fs xfs
 _fixed_by_kernel_commit 5c665e5b5af6 "xfs: remove xfs_map_cow"
 _require_ftrace
 _require_xfs_io_error_injection "wb_delay_ms"
diff --git a/tests/xfs/559 b/tests/xfs/559
index 64fc16ebf..fb29d208a 100755
--- a/tests/xfs/559
+++ b/tests/xfs/559
@@ -14,7 +14,6 @@ _begin_fstest auto quick rw
 . ./common/inject
 . ./common/tracing
 
-# real QA test starts here
 _cleanup()
 {
 	test -n "$sentryfile" && rm -f $sentryfile
@@ -25,7 +24,6 @@ _cleanup()
 }
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_ftrace
 _require_xfs_io_command "falloc"
 _require_xfs_io_error_injection "write_delay_ms"
diff --git a/tests/xfs/560 b/tests/xfs/560
index 28b45d5f5..d2cf21329 100755
--- a/tests/xfs/560
+++ b/tests/xfs/560
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/fuzzy
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "fsmap"
 _require_xfs_stress_scrub
diff --git a/tests/xfs/561 b/tests/xfs/561
index c1d68c6fe..bbfcefcb1 100755
--- a/tests/xfs/561
+++ b/tests/xfs/561
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/fuzzy
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/562 b/tests/xfs/562
index a5c6e8887..354992a61 100755
--- a/tests/xfs/562
+++ b/tests/xfs/562
@@ -24,8 +24,6 @@ _cleanup()
 . ./common/fuzzy
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/563 b/tests/xfs/563
index 409a42be8..3cd00651e 100755
--- a/tests/xfs/563
+++ b/tests/xfs/563
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/xfs
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/564 b/tests/xfs/564
index 11b3fecb4..ae45952fe 100755
--- a/tests/xfs/564
+++ b/tests/xfs/564
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/xfs
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/565 b/tests/xfs/565
index 826bc5354..40f1139ae 100755
--- a/tests/xfs/565
+++ b/tests/xfs/565
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/566 b/tests/xfs/566
index 4003ff31e..19c73ff9e 100755
--- a/tests/xfs/566
+++ b/tests/xfs/566
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/567 b/tests/xfs/567
index b19eca238..89e504e54 100755
--- a/tests/xfs/567
+++ b/tests/xfs/567
@@ -15,7 +15,6 @@ _begin_fstest auto dump
 # Import common functions.
 . ./common/dump
 
-_supported_fs xfs
 _fixed_by_git_commit xfsdump \
 	"XXXXXXXXXXXX xfsrestore: fix rootdir due to xfsdump bulkstat misuse"
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/568 b/tests/xfs/568
index 017e17a5b..f358b817e 100755
--- a/tests/xfs/568
+++ b/tests/xfs/568
@@ -43,8 +43,6 @@ _list_dir()
 	LC_COLLATE=POSIX sort
 }
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_git_commit xfsdump \
 	"XXXXXXXXXXXX xfsrestore: fix rootdir due to xfsdump bulkstat misuse"
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/569 b/tests/xfs/569
index b6d579805..7f2ad206a 100755
--- a/tests/xfs/569
+++ b/tests/xfs/569
@@ -10,10 +10,8 @@
 . ./common/preamble
 _begin_fstest mkfs
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch_nocheck
 
 ls /usr/share/xfsprogs/mkfs/*.conf &>/dev/null || \
diff --git a/tests/xfs/570 b/tests/xfs/570
index 9f3ba873a..4e64a03a0 100755
--- a/tests/xfs/570
+++ b/tests/xfs/570
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/571 b/tests/xfs/571
index 9d22de8f4..016387b43 100755
--- a/tests/xfs/571
+++ b/tests/xfs/571
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/572 b/tests/xfs/572
index b0e352af4..dfee98250 100755
--- a/tests/xfs/572
+++ b/tests/xfs/572
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/573 b/tests/xfs/573
index a2b6bef3c..5ff1bdbdc 100755
--- a/tests/xfs/573
+++ b/tests/xfs/573
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/574 b/tests/xfs/574
index 5a4bad001..6250f5142 100755
--- a/tests/xfs/574
+++ b/tests/xfs/574
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/575 b/tests/xfs/575
index 3d29620f2..6cf321ce4 100755
--- a/tests/xfs/575
+++ b/tests/xfs/575
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/576 b/tests/xfs/576
index e11476d45..d3d3e783e 100755
--- a/tests/xfs/576
+++ b/tests/xfs/576
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/577 b/tests/xfs/577
index d1abe6faf..35ca1468c 100755
--- a/tests/xfs/577
+++ b/tests/xfs/577
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/578 b/tests/xfs/578
index 8160b7ef5..2101eb55c 100755
--- a/tests/xfs/578
+++ b/tests/xfs/578
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/579 b/tests/xfs/579
index a00ae02aa..e552e4992 100755
--- a/tests/xfs/579
+++ b/tests/xfs/579
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/580 b/tests/xfs/580
index f49cba642..dac036f4a 100755
--- a/tests/xfs/580
+++ b/tests/xfs/580
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch
 _require_xfs_stress_scrub
diff --git a/tests/xfs/581 b/tests/xfs/581
index 1d08bc7df..73b51f994 100755
--- a/tests/xfs/581
+++ b/tests/xfs/581
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch
 _require_xfs_stress_scrub
diff --git a/tests/xfs/582 b/tests/xfs/582
index 7a8c330be..f390b77f3 100755
--- a/tests/xfs/582
+++ b/tests/xfs/582
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch
 _require_xfs_stress_scrub
diff --git a/tests/xfs/583 b/tests/xfs/583
index a6121a83b..dcc60f126 100755
--- a/tests/xfs/583
+++ b/tests/xfs/583
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/584 b/tests/xfs/584
index c80ba5755..3f62261c0 100755
--- a/tests/xfs/584
+++ b/tests/xfs/584
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/585 b/tests/xfs/585
index ea47dada7..987c799f5 100755
--- a/tests/xfs/585
+++ b/tests/xfs/585
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/586 b/tests/xfs/586
index e802ee718..d78dea518 100755
--- a/tests/xfs/586
+++ b/tests/xfs/586
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/587 b/tests/xfs/587
index 71e1ce69a..a9d469047 100755
--- a/tests/xfs/587
+++ b/tests/xfs/587
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/588 b/tests/xfs/588
index f56c50ace..bd0788d3f 100755
--- a/tests/xfs/588
+++ b/tests/xfs/588
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/589 b/tests/xfs/589
index d9cd81e02..806c445fc 100755
--- a/tests/xfs/589
+++ b/tests/xfs/589
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_attrs
 _require_xfs_stress_scrub
diff --git a/tests/xfs/590 b/tests/xfs/590
index 4e39109ab..59a42f11b 100755
--- a/tests/xfs/590
+++ b/tests/xfs/590
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/591 b/tests/xfs/591
index 00d5114e0..9f080ebbe 100755
--- a/tests/xfs/591
+++ b/tests/xfs/591
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/592 b/tests/xfs/592
index 02ac456b5..653ad2569 100755
--- a/tests/xfs/592
+++ b/tests/xfs/592
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_attrs
 _require_xfs_stress_scrub
diff --git a/tests/xfs/593 b/tests/xfs/593
index cf2ac506c..118b7e759 100755
--- a/tests/xfs/593
+++ b/tests/xfs/593
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/594 b/tests/xfs/594
index 323b191b5..c86234e1f 100755
--- a/tests/xfs/594
+++ b/tests/xfs/594
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/595 b/tests/xfs/595
index fc2a89ed8..75797b6cc 100755
--- a/tests/xfs/595
+++ b/tests/xfs/595
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/596 b/tests/xfs/596
index 98659e8c7..21cce047c 100755
--- a/tests/xfs/596
+++ b/tests/xfs/596
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_scratch
 _require_realtime
diff --git a/tests/xfs/597 b/tests/xfs/597
index 353637291..d3bf91a99 100755
--- a/tests/xfs/597
+++ b/tests/xfs/597
@@ -18,7 +18,6 @@ _fixed_by_kernel_commit a9248538facc \
 _fixed_by_kernel_commit 9dceccc5822f \
 	"xfs: use the directory name hash function for dir scrubbing"
 
-_supported_fs xfs
 _require_scratch
 _require_xfs_mkfs_ciname
 
diff --git a/tests/xfs/598 b/tests/xfs/598
index 760cd8617..54f50cd60 100755
--- a/tests/xfs/598
+++ b/tests/xfs/598
@@ -24,7 +24,6 @@ _fixed_by_kernel_commit a9248538facc \
 _fixed_by_kernel_commit 9dceccc5822f \
         "xfs: use the directory name hash function for dir scrubbing"
 
-_supported_fs xfs
 _require_test
 _require_scratch
 _require_xfs_mkfs_ciname
diff --git a/tests/xfs/599 b/tests/xfs/599
index 57a797f0f..725dbf620 100755
--- a/tests/xfs/599
+++ b/tests/xfs/599
@@ -17,7 +17,6 @@ _begin_fstest auto dir
 _fixed_by_git_commit xfsprogs b7b81f336ac \
 	"xfs_repair: fix incorrect dabtree hashval comparison"
 
-_supported_fs xfs
 _require_xfs_db_command "hashcoll"
 _require_xfs_db_command "path"
 _require_scratch
diff --git a/tests/xfs/600 b/tests/xfs/600
index e6997c53d..189194fb0 100755
--- a/tests/xfs/600
+++ b/tests/xfs/600
@@ -24,7 +24,6 @@ _fixed_by_git_commit kernel cfa2df68b7ce \
 	"xfs: fix an agbno overflow in __xfs_getfsmap_datadev"
 
 # Modify as appropriate.
-_supported_fs generic
 _require_xfs_io_command fsmap
 _require_xfs_scratch_rmapbt
 
diff --git a/tests/xfs/601 b/tests/xfs/601
index e1e94ca8f..bc8fa719b 100755
--- a/tests/xfs/601
+++ b/tests/xfs/601
@@ -24,8 +24,6 @@ _cleanup()
 
 testdir=$TEST_DIR/test-$seq
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_xfs_copy
 _require_scratch_nocheck
diff --git a/tests/xfs/602 b/tests/xfs/602
index 3bc2484e6..de750ff3b 100755
--- a/tests/xfs/602
+++ b/tests/xfs/602
@@ -14,9 +14,7 @@ _begin_fstest auto quick unlink
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_xfs_db_command iunlink
 _require_scratch_nocheck	# we'll run repair ourselves
 
diff --git a/tests/xfs/603 b/tests/xfs/603
index 444ebf40b..04122b55c 100755
--- a/tests/xfs/603
+++ b/tests/xfs/603
@@ -14,9 +14,7 @@ _begin_fstest auto online_repair
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_xfs_db_command iunlink
 # The iunlink bucket repair code wasn't added to the AGI repair code
 # until after the directory repair code was merged
diff --git a/tests/xfs/604 b/tests/xfs/604
index fdc444c22..0e9393b98 100755
--- a/tests/xfs/604
+++ b/tests/xfs/604
@@ -11,7 +11,6 @@ _begin_fstest auto prealloc punch
 
 . ./common/filter
 
-_supported_fs xfs
 _require_scratch
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
diff --git a/tests/xfs/605 b/tests/xfs/605
index 78458c766..b31fe6b0a 100755
--- a/tests/xfs/605
+++ b/tests/xfs/605
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/inject
 . ./common/metadump
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_test
 _require_loop
diff --git a/tests/xfs/606 b/tests/xfs/606
index d52a93d2a..02de601d6 100755
--- a/tests/xfs/606
+++ b/tests/xfs/606
@@ -22,8 +22,6 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_kernel_commit 84712492e6da \
 	"xfs: short circuit xfs_growfs_data_private() if delta is zero"
 _require_test
diff --git a/tests/xfs/607 b/tests/xfs/607
index e1120eaca..530fea9ed 100755
--- a/tests/xfs/607
+++ b/tests/xfs/607
@@ -27,12 +27,10 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
 _fixed_by_kernel_commit d62113303d69 \
 	"xfs: Fix false ENOSPC when performing direct write on a delalloc extent in cow fork"
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_test_program "punch-alternating"
 _require_test_reflink
 _require_xfs_io_error_injection "bmap_alloc_minlen_extent"
diff --git a/tests/xfs/612 b/tests/xfs/612
index 0f6df7deb..4bead5700 100755
--- a/tests/xfs/612
+++ b/tests/xfs/612
@@ -12,8 +12,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_inobtcount
 _require_command "$XFS_ADMIN_PROG" "xfs_admin"
 _require_xfs_repair_upgrade inobtcount
diff --git a/tests/xfs/613 b/tests/xfs/613
index 8bff21711..1947afec7 100755
--- a/tests/xfs/613
+++ b/tests/xfs/613
@@ -29,8 +29,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _fixed_by_kernel_commit 237d7887ae72 \
 	"xfs: show the proper user quota options"
 
diff --git a/tests/xfs/614 b/tests/xfs/614
index 046c202c3..0f8952e50 100755
--- a/tests/xfs/614
+++ b/tests/xfs/614
@@ -20,8 +20,6 @@ _cleanup()
 	rm -r -f $tmp.* $loop_file
 }
 
-# real QA test starts here
-_supported_fs xfs
 
 _require_test
 _require_loop
diff --git a/tests/xfs/615 b/tests/xfs/615
index 783af4ec0..6abc6e012 100755
--- a/tests/xfs/615
+++ b/tests/xfs/615
@@ -13,9 +13,7 @@ _begin_fstest auto quick collapse fiexchange
 . ./common/filter
 . ./common/inject
 
-# real QA test starts here
 
-_supported_fs xfs
 _require_scratch
 _require_xfs_debug
 _require_xfs_scratch_rmapbt
diff --git a/tests/xfs/616 b/tests/xfs/616
index 151b755ca..1a7d5606a 100755
--- a/tests/xfs/616
+++ b/tests/xfs/616
@@ -13,10 +13,8 @@ _begin_fstest auto fiexchange
 
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_xfs_io_command "falloc"
 _require_xfs_io_command exchangerange
 _require_scratch
diff --git a/tests/xfs/617 b/tests/xfs/617
index 21959673e..2f5bf5233 100755
--- a/tests/xfs/617
+++ b/tests/xfs/617
@@ -13,10 +13,8 @@ _begin_fstest auto fiexchange
 
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
 _require_xfs_io_command "falloc"
 _require_xfs_io_command exchangerange
 _require_realtime
diff --git a/tests/xfs/618 b/tests/xfs/618
index f68b0eacd..b011057e3 100755
--- a/tests/xfs/618
+++ b/tests/xfs/618
@@ -15,13 +15,11 @@ _begin_fstest auto quick parent
 . ./common/filter
 
 # Modify as appropriate
-_supported_fs xfs
 _require_scratch
 _require_xfs_sysfs debug/larp
 _require_xfs_parent
 _require_xfs_io_command "parent"
 
-# real QA test starts here
 
 # Create a directory tree using a protofile and
 # make sure all inodes created have parent pointers
diff --git a/tests/xfs/619 b/tests/xfs/619
index efaa94d1a..7e542f705 100755
--- a/tests/xfs/619
+++ b/tests/xfs/619
@@ -13,13 +13,11 @@ _begin_fstest auto quick parent
 . ./common/parent
 
 # Modify as appropriate
-_supported_fs xfs
 _require_scratch
 _require_xfs_sysfs debug/larp
 _require_xfs_parent
 _require_xfs_io_command "parent"
 
-# real QA test starts here
 
 # Create a directory tree using a protofile and
 # make sure all inodes created have parent pointers
diff --git a/tests/xfs/620 b/tests/xfs/620
index 35fb8625b..42a30630f 100755
--- a/tests/xfs/620
+++ b/tests/xfs/620
@@ -15,14 +15,12 @@ _begin_fstest auto quick parent
 . ./common/parent
 
 # Modify as appropriate
-_supported_fs xfs
 _require_scratch
 _require_xfs_sysfs debug/larp
 _require_xfs_io_error_injection "larp"
 _require_xfs_parent
 _require_xfs_io_command "parent"
 
-# real QA test starts here
 
 # Create a directory tree using a protofile and
 # make sure all inodes created have parent pointers
diff --git a/tests/xfs/621 b/tests/xfs/621
index b425d0a6b..24fbbc4e9 100755
--- a/tests/xfs/621
+++ b/tests/xfs/621
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/622 b/tests/xfs/622
index dfb162609..59503cfa9 100755
--- a/tests/xfs/622
+++ b/tests/xfs/622
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/623 b/tests/xfs/623
index 59952f6a8..aff3f9036 100755
--- a/tests/xfs/623
+++ b/tests/xfs/623
@@ -16,10 +16,8 @@ _begin_fstest auto online_repair
 . ./common/fuzzy
 . ./common/populate
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_db_command "link"
 _require_xfs_db_command "unlink"
 _require_scratch
diff --git a/tests/xfs/624 b/tests/xfs/624
index 707e886db..e63cfcc6e 100755
--- a/tests/xfs/624
+++ b/tests/xfs/624
@@ -16,10 +16,8 @@ _begin_fstest auto online_repair
 . ./common/fuzzy
 . ./common/populate
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_db_command "link"
 _require_xfs_db_command "unlink"
 _require_scratch
diff --git a/tests/xfs/625 b/tests/xfs/625
index 05225ca57..23013f195 100755
--- a/tests/xfs/625
+++ b/tests/xfs/625
@@ -16,10 +16,8 @@ _begin_fstest auto online_repair
 . ./common/fuzzy
 . ./common/populate
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_db_command "link"
 _require_xfs_db_command "unlink"
 _require_scratch
diff --git a/tests/xfs/626 b/tests/xfs/626
index e1c28be66..c424819ce 100755
--- a/tests/xfs/626
+++ b/tests/xfs/626
@@ -16,10 +16,8 @@ _begin_fstest auto online_repair
 . ./common/fuzzy
 . ./common/populate
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_db_command "link"
 _require_xfs_db_command "unlink"
 _require_scratch
diff --git a/tests/xfs/627 b/tests/xfs/627
index ff76e5855..411a76033 100755
--- a/tests/xfs/627
+++ b/tests/xfs/627
@@ -16,10 +16,8 @@ _begin_fstest auto online_repair
 . ./common/fuzzy
 . ./common/populate
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_db_command "link"
 _require_xfs_db_command "unlink"
 _require_scratch
diff --git a/tests/xfs/628 b/tests/xfs/628
index 145651f4a..8dc268988 100755
--- a/tests/xfs/628
+++ b/tests/xfs/628
@@ -17,8 +17,6 @@ _begin_fstest scrub dangerous_fsstress_scrub
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/708 b/tests/xfs/708
index 76da63382..40c4d92d2 100755
--- a/tests/xfs/708
+++ b/tests/xfs/708
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/709 b/tests/xfs/709
index 247d10835..3a29ca12f 100755
--- a/tests/xfs/709
+++ b/tests/xfs/709
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/710 b/tests/xfs/710
index 45a2a2a3e..dc599c0b6 100755
--- a/tests/xfs/710
+++ b/tests/xfs/710
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/711 b/tests/xfs/711
index 0b1adb76d..685ada10b 100755
--- a/tests/xfs/711
+++ b/tests/xfs/711
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/712 b/tests/xfs/712
index 222b2b209..15a94a525 100755
--- a/tests/xfs/712
+++ b/tests/xfs/712
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/713 b/tests/xfs/713
index 05b2a1a94..551653917 100755
--- a/tests/xfs/713
+++ b/tests/xfs/713
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/714 b/tests/xfs/714
index cd8482167..aa209ce5b 100755
--- a/tests/xfs/714
+++ b/tests/xfs/714
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/715 b/tests/xfs/715
index 09fa0ebdb..e6821c025 100755
--- a/tests/xfs/715
+++ b/tests/xfs/715
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/716 b/tests/xfs/716
index ef0af4534..cd4fffef2 100755
--- a/tests/xfs/716
+++ b/tests/xfs/716
@@ -20,8 +20,6 @@ _cleanup()
 . ./common/inject
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_io_error_injection "force_repair"
 _require_xfs_io_command "falloc"
diff --git a/tests/xfs/717 b/tests/xfs/717
index ba00a710b..6368d704b 100755
--- a/tests/xfs/717
+++ b/tests/xfs/717
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/718 b/tests/xfs/718
index cc0efa7ac..7b0fe2c46 100755
--- a/tests/xfs/718
+++ b/tests/xfs/718
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_attrs
 _require_xfs_stress_online_repair
diff --git a/tests/xfs/719 b/tests/xfs/719
index 9e28958ef..818054020 100755
--- a/tests/xfs/719
+++ b/tests/xfs/719
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/720 b/tests/xfs/720
index 2b6406da6..f928cc43d 100755
--- a/tests/xfs/720
+++ b/tests/xfs/720
@@ -17,10 +17,8 @@ _begin_fstest online_repair
 . ./common/inject
 . ./common/quota
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_xfs_io_command "falloc"
 _require_quota
 _require_user
diff --git a/tests/xfs/721 b/tests/xfs/721
index e6ccc8ba5..c25cd269d 100755
--- a/tests/xfs/721
+++ b/tests/xfs/721
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/722 b/tests/xfs/722
index f53d03b43..b96163e32 100755
--- a/tests/xfs/722
+++ b/tests/xfs/722
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/723 b/tests/xfs/723
index b6af6ef12..21b608aaa 100755
--- a/tests/xfs/723
+++ b/tests/xfs/723
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/724 b/tests/xfs/724
index 2061b51f1..a832063be 100755
--- a/tests/xfs/724
+++ b/tests/xfs/724
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/725 b/tests/xfs/725
index 7317d048b..2972aeb71 100755
--- a/tests/xfs/725
+++ b/tests/xfs/725
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/726 b/tests/xfs/726
index e823f9960..f4bedcca5 100755
--- a/tests/xfs/726
+++ b/tests/xfs/726
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/727 b/tests/xfs/727
index 6c5ac7db5..2e8827754 100755
--- a/tests/xfs/727
+++ b/tests/xfs/727
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/728 b/tests/xfs/728
index 17ce97171..b4cf95f57 100755
--- a/tests/xfs/728
+++ b/tests/xfs/728
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/729 b/tests/xfs/729
index 235cb175d..45d65892e 100755
--- a/tests/xfs/729
+++ b/tests/xfs/729
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
diff --git a/tests/xfs/730 b/tests/xfs/730
index c6817e914..cd58d446d 100755
--- a/tests/xfs/730
+++ b/tests/xfs/730
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/731 b/tests/xfs/731
index 595ab04d4..8cc38f584 100755
--- a/tests/xfs/731
+++ b/tests/xfs/731
@@ -26,8 +26,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/732 b/tests/xfs/732
index a39a1f850..5a6c816a1 100755
--- a/tests/xfs/732
+++ b/tests/xfs/732
@@ -26,8 +26,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_realtime
 _require_xfs_stress_scrub
diff --git a/tests/xfs/733 b/tests/xfs/733
index d9f9b1c2d..71f16c257 100755
--- a/tests/xfs/733
+++ b/tests/xfs/733
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/734 b/tests/xfs/734
index 9ffe0df36..1ae020ea2 100755
--- a/tests/xfs/734
+++ b/tests/xfs/734
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/735 b/tests/xfs/735
index 96a171ff7..04bbcc5cb 100755
--- a/tests/xfs/735
+++ b/tests/xfs/735
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/736 b/tests/xfs/736
index 4a6c4687b..2314d12a0 100755
--- a/tests/xfs/736
+++ b/tests/xfs/736
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/737 b/tests/xfs/737
index 6fc0bba4e..d85d25125 100755
--- a/tests/xfs/737
+++ b/tests/xfs/737
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/738 b/tests/xfs/738
index e2f8a9c39..32f12a70b 100755
--- a/tests/xfs/738
+++ b/tests/xfs/738
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/739 b/tests/xfs/739
index fb7fe2e64..a4f553d81 100755
--- a/tests/xfs/739
+++ b/tests/xfs/739
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/740 b/tests/xfs/740
index a59fa37ec..971bf31e3 100755
--- a/tests/xfs/740
+++ b/tests/xfs/740
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/741 b/tests/xfs/741
index 957bed791..4e24fb4e2 100755
--- a/tests/xfs/741
+++ b/tests/xfs/741
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/742 b/tests/xfs/742
index d91174844..eabe766d7 100755
--- a/tests/xfs/742
+++ b/tests/xfs/742
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/743 b/tests/xfs/743
index 69e865a43..b5cec7d71 100755
--- a/tests/xfs/743
+++ b/tests/xfs/743
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/744 b/tests/xfs/744
index ea490b524..e2d097c2f 100755
--- a/tests/xfs/744
+++ b/tests/xfs/744
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/745 b/tests/xfs/745
index 7621d4574..d139aeefd 100755
--- a/tests/xfs/745
+++ b/tests/xfs/745
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/746 b/tests/xfs/746
index 401233162..696d02453 100755
--- a/tests/xfs/746
+++ b/tests/xfs/746
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/747 b/tests/xfs/747
index e3a8af772..03d0f5a42 100755
--- a/tests/xfs/747
+++ b/tests/xfs/747
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/748 b/tests/xfs/748
index c69e7a482..66b59fe44 100755
--- a/tests/xfs/748
+++ b/tests/xfs/748
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/749 b/tests/xfs/749
index a1a6530f1..ea9c34a50 100755
--- a/tests/xfs/749
+++ b/tests/xfs/749
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/750 b/tests/xfs/750
index f9b655343..0f451ecda 100755
--- a/tests/xfs/750
+++ b/tests/xfs/750
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/751 b/tests/xfs/751
index a9634bfc1..dfd9e09b0 100755
--- a/tests/xfs/751
+++ b/tests/xfs/751
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/752 b/tests/xfs/752
index 9fb3f4380..88c064e73 100755
--- a/tests/xfs/752
+++ b/tests/xfs/752
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/753 b/tests/xfs/753
index 151a964d1..b0984e99a 100755
--- a/tests/xfs/753
+++ b/tests/xfs/753
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/754 b/tests/xfs/754
index ad9078c47..9a3787112 100755
--- a/tests/xfs/754
+++ b/tests/xfs/754
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/755 b/tests/xfs/755
index b83118b82..06b9cafe6 100755
--- a/tests/xfs/755
+++ b/tests/xfs/755
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 _require_xfs_finobt
diff --git a/tests/xfs/756 b/tests/xfs/756
index 351c7ed4b..02dfc222c 100755
--- a/tests/xfs/756
+++ b/tests/xfs/756
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/757 b/tests/xfs/757
index 06b360fd3..46391e1e9 100755
--- a/tests/xfs/757
+++ b/tests/xfs/757
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/758 b/tests/xfs/758
index d2b6e46cc..2a32c2f28 100755
--- a/tests/xfs/758
+++ b/tests/xfs/758
@@ -19,8 +19,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/759 b/tests/xfs/759
index 8ed3f0b6a..117dc6b1c 100755
--- a/tests/xfs/759
+++ b/tests/xfs/759
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/760 b/tests/xfs/760
index 47a5dd3d7..f5032b95e 100755
--- a/tests/xfs/760
+++ b/tests/xfs/760
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/761 b/tests/xfs/761
index 87d302daa..19a2a273c 100755
--- a/tests/xfs/761
+++ b/tests/xfs/761
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/762 b/tests/xfs/762
index 0ce1773b0..98c48e89d 100755
--- a/tests/xfs/762
+++ b/tests/xfs/762
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/763 b/tests/xfs/763
index 98145351b..430c01ba5 100755
--- a/tests/xfs/763
+++ b/tests/xfs/763
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/764 b/tests/xfs/764
index 3addb9c8b..83378ae2f 100755
--- a/tests/xfs/764
+++ b/tests/xfs/764
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/765 b/tests/xfs/765
index 1a260c3a3..28c96737c 100755
--- a/tests/xfs/765
+++ b/tests/xfs/765
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/766 b/tests/xfs/766
index b0ff2ad43..c241d992b 100755
--- a/tests/xfs/766
+++ b/tests/xfs/766
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/767 b/tests/xfs/767
index 8ca7e7d4b..8fd5dded9 100755
--- a/tests/xfs/767
+++ b/tests/xfs/767
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/768 b/tests/xfs/768
index a8faad7ec..f77e0942b 100755
--- a/tests/xfs/768
+++ b/tests/xfs/768
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/769 b/tests/xfs/769
index e3b439bcb..f09424e9e 100755
--- a/tests/xfs/769
+++ b/tests/xfs/769
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/770 b/tests/xfs/770
index da12e0a23..96a64142f 100755
--- a/tests/xfs/770
+++ b/tests/xfs/770
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/771 b/tests/xfs/771
index c1e8b38f6..568c6fd79 100755
--- a/tests/xfs/771
+++ b/tests/xfs/771
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/772 b/tests/xfs/772
index 50577febd..a55887714 100755
--- a/tests/xfs/772
+++ b/tests/xfs/772
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/773 b/tests/xfs/773
index 8d37e0f47..e4e91d65f 100755
--- a/tests/xfs/773
+++ b/tests/xfs/773
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/774 b/tests/xfs/774
index ad5d4d714..ca01eb2f4 100755
--- a/tests/xfs/774
+++ b/tests/xfs/774
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/775 b/tests/xfs/775
index ec98d6884..89f20ad6d 100755
--- a/tests/xfs/775
+++ b/tests/xfs/775
@@ -19,8 +19,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/reflink
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_reflink
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
diff --git a/tests/xfs/776 b/tests/xfs/776
index a7b7adda7..cfa5874ff 100755
--- a/tests/xfs/776
+++ b/tests/xfs/776
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/777 b/tests/xfs/777
index 496a28d53..de30fa32f 100755
--- a/tests/xfs/777
+++ b/tests/xfs/777
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/778 b/tests/xfs/778
index 72f7d0dc8..893187d73 100755
--- a/tests/xfs/778
+++ b/tests/xfs/778
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/779 b/tests/xfs/779
index 05f271863..7c338b1c2 100755
--- a/tests/xfs/779
+++ b/tests/xfs/779
@@ -19,8 +19,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 _require_quota
diff --git a/tests/xfs/780 b/tests/xfs/780
index 9dd8f4527..06194d325 100755
--- a/tests/xfs/780
+++ b/tests/xfs/780
@@ -19,8 +19,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 _require_quota
diff --git a/tests/xfs/781 b/tests/xfs/781
index 604c9bdd8..7113a1434 100755
--- a/tests/xfs/781
+++ b/tests/xfs/781
@@ -19,8 +19,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/fuzzy
 . ./common/quota
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 _require_quota
diff --git a/tests/xfs/782 b/tests/xfs/782
index c113ea5ab..ba89d2198 100755
--- a/tests/xfs/782
+++ b/tests/xfs/782
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/783 b/tests/xfs/783
index bbc621baf..32f4ddfc9 100755
--- a/tests/xfs/783
+++ b/tests/xfs/783
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/784 b/tests/xfs/784
index 595f0fa80..b7067efc6 100755
--- a/tests/xfs/784
+++ b/tests/xfs/784
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/785 b/tests/xfs/785
index 577ef7720..a51f62e84 100755
--- a/tests/xfs/785
+++ b/tests/xfs/785
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/786 b/tests/xfs/786
index 73b161d9f..0a8bde8cc 100755
--- a/tests/xfs/786
+++ b/tests/xfs/786
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 
 echo "Format and populate"
diff --git a/tests/xfs/787 b/tests/xfs/787
index 7477c5053..090c3f8b9 100755
--- a/tests/xfs/787
+++ b/tests/xfs/787
@@ -18,8 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/788 b/tests/xfs/788
index c2c54cda2..46438eaba 100755
--- a/tests/xfs/788
+++ b/tests/xfs/788
@@ -17,8 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch_xfs_fuzz_fields
 _disable_dmesg_check
 
diff --git a/tests/xfs/789 b/tests/xfs/789
index e3a332d7c..ce88506f8 100755
--- a/tests/xfs/789
+++ b/tests/xfs/789
@@ -19,8 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_io_command swapext
 _require_test
 
diff --git a/tests/xfs/790 b/tests/xfs/790
index 88b79611e..53e8906bb 100755
--- a/tests/xfs/790
+++ b/tests/xfs/790
@@ -22,8 +22,6 @@ _cleanup()
 . ./common/reflink
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_io_command exchangerange
 _require_test_program "punch-alternating"
 _require_xfs_io_command startupdate
diff --git a/tests/xfs/791 b/tests/xfs/791
index 62d89f71b..bca580420 100755
--- a/tests/xfs/791
+++ b/tests/xfs/791
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_io_command exchangerange
 _require_xfs_scratch_atomicswap
 _require_xfs_io_error_injection "bmap_finish_one"
diff --git a/tests/xfs/792 b/tests/xfs/792
index 1da36fb97..cdfa63692 100755
--- a/tests/xfs/792
+++ b/tests/xfs/792
@@ -23,8 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/inject
 
-# real QA test starts here
-_supported_fs xfs
 _require_xfs_io_command exchangerange
 _require_xfs_io_command startupdate '-e'
 _require_xfs_scratch_atomicswap
diff --git a/tests/xfs/793 b/tests/xfs/793
index 961c33e39..d942d9807 100755
--- a/tests/xfs/793
+++ b/tests/xfs/793
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_realtime
 _require_scratch
 _require_xfs_stress_online_repair
diff --git a/tests/xfs/794 b/tests/xfs/794
index eeb1ceb80..cdccf9699 100755
--- a/tests/xfs/794
+++ b/tests/xfs/794
@@ -24,8 +24,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/xfs
 . ./common/attr
 
-# real QA test starts here
-_supported_fs xfs
 _require_attrs
 _require_scratch
 _require_xfs_stress_online_repair
diff --git a/tests/xfs/795 b/tests/xfs/795
index a4e65921a..5a67f02ec 100755
--- a/tests/xfs/795
+++ b/tests/xfs/795
@@ -17,10 +17,8 @@ _begin_fstest online_repair
 . ./common/inject
 . ./common/quota
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_quota
 _require_user
 _require_scratch
diff --git a/tests/xfs/796 b/tests/xfs/796
index 907e9b59e..e6a88cc6b 100755
--- a/tests/xfs/796
+++ b/tests/xfs/796
@@ -22,8 +22,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/797 b/tests/xfs/797
index 08117808c..642930f2f 100755
--- a/tests/xfs/797
+++ b/tests/xfs/797
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/798 b/tests/xfs/798
index 03e94e8ef..4ce792825 100755
--- a/tests/xfs/798
+++ b/tests/xfs/798
@@ -14,10 +14,8 @@ _begin_fstest auto quick online_repair
 . ./common/fuzzy
 . ./common/filter
 
-# real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _require_scratch_nocheck
 _require_scrub
 _require_xfs_db_command "fuzz"
diff --git a/tests/xfs/799 b/tests/xfs/799
index 4391686eb..0a43eb011 100755
--- a/tests/xfs/799
+++ b/tests/xfs/799
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_online_repair
 
diff --git a/tests/xfs/800 b/tests/xfs/800
index a23e47338..f12ef69e0 100755
--- a/tests/xfs/800
+++ b/tests/xfs/800
@@ -23,8 +23,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/inject
 . ./common/xfs
 
-# real QA test starts here
-_supported_fs xfs
 _require_scratch
 _require_xfs_stress_scrub
 
-- 
2.43.0


