Return-Path: <linux-ext4+bounces-3795-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2A9587DC
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 111A8B21C5F
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9001917FB;
	Tue, 20 Aug 2024 13:25:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0E190696;
	Tue, 20 Aug 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160351; cv=none; b=eXur+JVXk8Ow2VKTPi73mC37GzscS6ye4RIhwqNUvcCRBXjqRVDXyoWSLR6aQSp7IOnAeqo3RftsvMinW3GrLj/62n/21fCZN7jtD3FclMqVDv5rL7kcVufQaxn7HJonPqJEidWAzAXHwMnJqbqPltSEGrzYaAJXL4exkhtCD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160351; c=relaxed/simple;
	bh=sIu7oYoaJQjyuB6gLjixvVv8WdBnCljuXi+R9E219sY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p7P5wPaYRZWnXEHnFzQzvVHxzhMyjbd3BLao2+CQTzOzk32eAyP11tR967LFo5FeVqVn1BtJ20KFqyhq93AlytezAKigbfPRheoKxTddjqWNt8DctLOz/7ZdpAbItHnxS1HSy+xNrfwG1ClIXrdxJQF8QuOTQTqh1LeT1FO0zbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wp9FV65ksz4f3jv6;
	Tue, 20 Aug 2024 21:25:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 751081A0359;
	Tue, 20 Aug 2024 21:25:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgDH_bxWmcRmD7_dCA--.4366S2;
	Tue, 20 Aug 2024 21:25:44 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: harshadshirwadkar@gmail.com,
	darrick.wong@oracle.com,
	akpm@osdl.org,
	shaggy@austin.ibm.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Fixes and cleanups to ext4 ialloc
Date: Tue, 20 Aug 2024 21:22:27 +0800
Message-Id: <20240820132234.2759926-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDH_bxWmcRmD7_dCA--.4366S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrykGrW3WF4ftw4UuFW5Awb_yoWDZwc_Ja
	4kZFyDJr4UZas7CayDKry5JFyDCrW8Cr1UtF4vqw4UZr1fJws8ua1kCr42vr1xWry3Z3Zx
	Cry7Jr1xAFn29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v1->v2:
-Append parentheses to function names in changelog.
-Add "Fixes" tag to bugfix patch
-Minor improve in patch "ext4: avoid potential buffer_head leak in
__ext4_new_inode"

This series contains some random fixes and cleanups to ext4 ialloc. More
details can be found in respective patches. Thanks!

Kemeng Shi (7):
  ext4: avoid buffer_head leak in ext4_mark_inode_used()
  ext4: avoid potential buffer_head leak in __ext4_new_inode()
  ext4: avoid negative min_clusters in find_group_orlov()
  ext4: remove dead check in __ext4_new_inode()
  ext4: move checksum length calculation of inode bitmap into
    ext4_inode_bitmap_csum_[verify/set]() functions
  ext4: remove unneeded NULL check of buffer_head in
    ext4_mark_inode_used()
  ext4: check buffer_verified in advance to avoid unneeded
    ext4_get_group_info()

 fs/ext4/bitmap.c |  8 ++++++--
 fs/ext4/ext4.h   |  4 ++--
 fs/ext4/ialloc.c | 35 ++++++++++++++++-------------------
 fs/ext4/resize.c |  3 +--
 4 files changed, 25 insertions(+), 25 deletions(-)

-- 
2.30.0


