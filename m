Return-Path: <linux-ext4+bounces-11808-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0AFC51411
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 10:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1127B3BCAEA
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226112FDC49;
	Wed, 12 Nov 2025 08:54:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A262FD7B9
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937674; cv=none; b=p6vuJcGLTWKwp6sXo+MiFWZ+S6lNHuv3nKF4F8QxTrBBtdPxedqNTC/EtsE1V4QnXrmQ1NOlzT8sb/J7byb3Jw3yeoktMyONMkr0htITCfhcmQHBhvgqUSBY41vsGEgBf9imbxuRcWH5nugbeX1z9FA5Pi3QHossQFlfLlGfLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937674; c=relaxed/simple;
	bh=J1WbNE3Ov1sft69/JRMLAT/GDJzG4FHTW9jaI8aqO68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u4G+am38FvRfxX0q+2aR3amsVuBbb5vSfrfu756Xbym1X0cX8wW883W/7BdXwgog2jWWvU1KGLJZWcGkI+xSn5Gcbi012KBDExEGFTCGr/Jr81WHVtRHIKU4z5Vp9tpX6qWOXvZAiLeiKBSmk4TnRAqxwBDO9zorlBPs6xspbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5xyx5cHwzYQvCR
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 16:54:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E8B8E1A07BB
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 16:54:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgAHZXtASxRpyWXjAQ--.5900S4;
	Wed, 12 Nov 2025 16:54:28 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: yi.zhang@huawei.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH v4 0/3] ext4: minor cleanup
Date: Wed, 12 Nov 2025 16:45:35 +0800
Message-Id: <20251112084538.1658232-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHZXtASxRpyWXjAQ--.5900S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1UGw1rZF17KFy7tF13Jwb_yoW3tFc_Ca
	yxCFWrJr4kJFnagay7Krn8tFyUJF40yr13JF95KF47ZrnxArW5Gr1kZrsrur95WF4UJ345
	JFnrtrykZ393XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjsIEF7I21c0EjII2zVCS5cI20VAGYxC7
	MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082
	I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1z6wJUUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

v3->v4: remove "ext4: remove useless code in ext4_map_create_blocks"
since we should keep this logic which needed for latter work from Yi[1].

v2->v3: remove "ext4: order mode should not take effect for DIO" since
there is no measurable performance benefit

v1->v2: update comments for EXT4_GET_BLOCKS_SPLIT_NOMERGE

1. https://lore.kernel.org/linux-ext4/20251031062905.4135909-1-yi.zhang@huaweicloud.com/

Yang Erkun (3):
  ext4: rename EXT4_GET_BLOCKS_PRE_IO
  ext4: cleanup for ext4_map_blocks
  ext4: correct the comments place for EXT4_EXT_MAY_ZEROOUT

 fs/ext4/ext4.h              | 21 +++++++++++++++------
 fs/ext4/extents.c           | 24 ++++++++++++------------
 fs/ext4/inode.c             | 18 ++++++++++--------
 include/trace/events/ext4.h |  2 +-
 4 files changed, 38 insertions(+), 27 deletions(-)

-- 
2.39.2


