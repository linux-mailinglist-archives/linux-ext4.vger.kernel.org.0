Return-Path: <linux-ext4+bounces-552-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E681D3AE
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 12:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC211F226F7
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61DBD26C;
	Sat, 23 Dec 2023 11:04:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26ECA6C
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sy1X32PHPz4f3jpq
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 19:04:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C1DF81A0497
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 19:04:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDX5UW6voZlWeceEg--.27538S4;
	Sat, 23 Dec 2023 19:04:34 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH v2 0/6] ext4: make ext4_map_blocks() recognize delalloc only extent
Date: Sat, 23 Dec 2023 19:02:17 +0800
Message-Id: <20231223110223.3650717-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDX5UW6voZlWeceEg--.27538S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryUur18Kw1kCw4rtr4fZrb_yoW8Zw1UpF
	Z3Cw43Gw1kW347Wan3uw4fJr1Fga18CF4UGr47Jr1kWrW8Ary8Grs7K3W09FyfArWxAr12
	qF1Utr1DCa48C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUouWlDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

v1->v2:
 - Fix a long standing race issue between determine hole and inserting
   new delalloc extent analyzed by Jan Kara.
 - Change method of adjusting hole length, instead of skip holes in
   ext4_map_blocks(), now we find delalloc and correct length and type
   in ext4_ext_determine_hole().

v1: https://lore.kernel.org/linux-ext4/20231121093429.1827390-1-yi.zhang@huaweicloud.com/

Hello, all!

I'm working on switching ext4 buffer IO from buffer_head to iomap
and enable large folio on regular file recently [1] (I've been fixing a
lot of issues and should be able to send out v2 soon), this patch set
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

[1] https://lore.kernel.org/linux-ext4/20231123125121.4064694-1-yi.zhang@huaweicloud.com/

Zhang Yi (6):
  ext4: refactor ext4_da_map_blocks()
  ext4: convert to exclusive lock while inserting delalloc extents
  ext4: correct the hole length returned by ext4_map_blocks()
  ext4: add a hole extent entry in cache after punch
  ext4: make ext4_map_blocks() distinguish delalloc only extent
  ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC map type

 fs/ext4/ext4.h    |   4 +-
 fs/ext4/extents.c | 110 +++++++++++++++++++++++++++-------------------
 fs/ext4/inode.c   |  84 ++++++++++++-----------------------
 3 files changed, 96 insertions(+), 102 deletions(-)

-- 
2.39.2


