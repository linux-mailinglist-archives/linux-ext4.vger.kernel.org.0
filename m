Return-Path: <linux-ext4+bounces-719-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14521824D77
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 04:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193861C21BD2
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 03:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A4525B;
	Fri,  5 Jan 2024 03:33:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2714410
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T5pvD2YW3z4f3pJ7
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 11:33:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 18D041A08E1
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 11:33:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6hByeJdlyaRBFg--.23173S4;
	Fri, 05 Jan 2024 11:33:15 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 0/6] ext4: make ext4_map_blocks() recognize delalloc only extent
Date: Fri,  5 Jan 2024 11:30:12 +0800
Message-Id: <20240105033018.1665752-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6hByeJdlyaRBFg--.23173S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4xCrWfCw4kGFyxAr18Zrb_yoW8tw4kpF
	Z3Cr13Gws0gw17Wa9xZw47Gr1F9an7GF4UGry7Gr1kJrWUAry8WFs7K3WF9Fy3ArWxJF1a
	qF4Ut34kua4rC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbE_M3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

v2->v3:
 - Rename ext4_ext_determine_hole() to ext4_ext_determine_insert_hole()
   and keep setting of 'map' inside ext4_ext_map_blocks().
 - Don't set EXT4_MAP_DELAYED in ext4_ext_determine_insert_hole()
   because it's unreliable, and revise the comments.
v1->v2:
 - Fix a long standing race issue between determine hole and inserting
   new delalloc extent analyzed by Jan Kara.
 - Change method of adjusting hole length, instead of skip holes in
   ext4_map_blocks(), now we find delalloc and correct length and type
   in ext4_ext_determine_hole().

v2: https://lore.kernel.org/linux-ext4/20231223110223.3650717-1-yi.zhang@huaweicloud.com/
v1: https://lore.kernel.org/linux-ext4/20231121093429.1827390-1-yi.zhang@huaweicloud.com/

Hello, all!

I'm working on switching ext4 buffer IO from buffer_head to iomap
and enable large folio on regular file recently [1], this patch set
is one of a preparation of this work. It first fix a long standing race
issue between bmap querying and adding new delalloc extents, then
correct the hole length returned by ext4_map_blocks() when user querying
map type and blocks range, after that, make this function and
ext4_set_iomap() are able to distinguish delayed allocated only mapping
from hole, finally BTW cleanup the ext4_iomap_begin_report().

This preparation patch set changes the ext4 map -> iomap converting logic
in ext4_set_iomap(), so that the later buffer IO conversion can use this
helper to connect iomap frame. This patch set is already passed
'kvm-xfstests -g auto' tests.

Thanks,
Yi.

[1] https://lore.kernel.org/linux-ext4/20240102123918.799062-1-yi.zhang@huaweicloud.com/

Zhang Yi (6):
  ext4: refactor ext4_da_map_blocks()
  ext4: convert to exclusive lock while inserting delalloc extents
  ext4: correct the hole length returned by ext4_map_blocks()
  ext4: add a hole extent entry in cache after punch
  ext4: make ext4_map_blocks() distinguish delalloc only extent
  ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC map type

 fs/ext4/ext4.h    |   4 +-
 fs/ext4/extents.c | 114 +++++++++++++++++++++++++++++-----------------
 fs/ext4/inode.c   |  84 +++++++++++-----------------------
 3 files changed, 103 insertions(+), 99 deletions(-)

-- 
2.39.2


