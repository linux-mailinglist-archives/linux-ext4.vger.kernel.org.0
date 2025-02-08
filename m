Return-Path: <linux-ext4+bounces-6391-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B38A2D443
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Feb 2025 07:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1083A6293
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Feb 2025 06:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446901714B3;
	Sat,  8 Feb 2025 06:31:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DE19DF98
	for <linux-ext4@vger.kernel.org>; Sat,  8 Feb 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738996315; cv=none; b=Dq+0hnwc/Zmk/483j5A7j7T2Sb+lFPHRrbyItPgKy+LtXRM38isvjEWE82XMW5Jr5De0Jg9eLOzIKFglfLKKswPkU/rP5svfAzC+SaUwSL8QheuklGRQo66qu34lAOQYkbh+E9VdHNqr7A9oNu7kSOnFigyqOm/e/EVqIZor/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738996315; c=relaxed/simple;
	bh=4g28l58h6NPK2yMylGRqt0gnByHsGWPx/CXxpsnZMVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KxgpXzb9XnUDiLuObYD69cqjlRP9S8yTZtCk3XNDYYV/nZxhKwnPu0imBKYvp4IPEIqT64lqlNcR2l6/2lpFozFrUZ+js1bmAvXkCWmBw21UqBiQYnrrdA6RmfKctoM/Y7gqEI2DZ/vBDkaVGXptW8TedRIjYMx972RPyH2//wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YqgwB3984z4f3jMp
	for <linux-ext4@vger.kernel.org>; Sat,  8 Feb 2025 14:31:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A2D531A0E29
	for <linux-ext4@vger.kernel.org>; Sat,  8 Feb 2025 14:31:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGBN+qZnQ2X1DA--.63634S4;
	Sat, 08 Feb 2025 14:31:43 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz
Subject: [PATCH v2 0/2] ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
Date: Sat,  8 Feb 2025 14:31:39 +0800
Message-Id: <20250208063141.1539283-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGBN+qZnQ2X1DA--.63634S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5H7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

Diff v2 vs v1:
(1) Wrap the arguments in parentheses for PATCH[1];
(2) Call xattr_check_inode() in ext4_iget_extra_inode() for PATCH[2];

Ye Bin (2):
  ext4: introduce ITAIL helper
  ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

 fs/ext4/inode.c |  5 +++++
 fs/ext4/xattr.c | 32 ++++----------------------------
 fs/ext4/xattr.h | 10 ++++++++++
 3 files changed, 19 insertions(+), 28 deletions(-)

-- 
2.34.1


