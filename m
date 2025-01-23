Return-Path: <linux-ext4+bounces-6223-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA76A19FCF
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 09:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8281882993
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF320C023;
	Thu, 23 Jan 2025 08:23:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D120B80A;
	Thu, 23 Jan 2025 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620626; cv=none; b=KDLNtXlgp5Ev/EigIyfIGrQSyQiHq9DVVITcfVrzXVsodbeMDN31zDyr/mwnXFihKZ2KFiJVHJoOrVdzgnUDsPqzfm+Weqr7POfz1oBKRpmfHfNOpEOWMuy1+aXNcZ0U1xyQqk5tnXqRMWZcHI8JiTi699/mxZgXwal1lgF6p74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620626; c=relaxed/simple;
	bh=8fvludm1yrhSFiKPaieUSXD7xbZzS2V40R8xM26Fj9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U+ApACga/YQZfgik99GGe4XV3wPy6Z7QSj6GHBHvqgwko4jLLYBeQX+ema7lu6sKdgHv/bHxbwVhTE+UgEACwxRHcRsy3VPUxuir956VBLI11NeW0efoxdCpvLHF0Z8rt/xGP7TLP/Y158tnNQSFkKmokY2KmcKepmeQITfZlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ydv8s0H5Tz4f3jqy;
	Thu, 23 Jan 2025 16:23:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 808981A183D;
	Thu, 23 Jan 2025 16:23:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCH7GCL_JFnxur_Bg--.47357S2;
	Thu, 23 Jan 2025 16:23:40 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	ojaswin@linux.ibm.com,
	yi.zhang@huaweicloud.com
Cc: akpm@osdl.org,
	shaggy@austin.ibm.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Fix and cleanups to ext4 namei.c
Date: Fri, 24 Jan 2025 00:20:47 +0800
Message-Id: <20250123162050.2114499-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH7GCL_JFnxur_Bg--.47357S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYP7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JF
	v_Gryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AK
	xVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aV
	AFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	F7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14
	v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRZqXDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v1->v2:
-Collect RVB from Ojaswin and Yi
-Drop some unneeded patches
-Improve changelog in patch 1/3

This series contains a fix and some random cleanups to namei.c. More
detail can be found in respective patches. Thanks.

Kemeng Shi (3):
  ext4: add missing brelse() for bh2 in ext4_dx_add_entry()
  ext4: remove unneeded forward declaration in namei.c
  ext4: remove unused input "inode" in ext4_find_dest_de

 fs/ext4/ext4.h   |  3 +--
 fs/ext4/inline.c |  2 +-
 fs/ext4/namei.c  | 51 +++++++++++++-----------------------------------
 3 files changed, 16 insertions(+), 40 deletions(-)

-- 
2.30.0


