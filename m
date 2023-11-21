Return-Path: <linux-ext4+bounces-50-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5E97F2336
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 02:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3161C216AF
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114D4847C;
	Tue, 21 Nov 2023 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB408ED
	for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 17:40:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZ6X33R9Tz4f3k5s
	for <linux-ext4@vger.kernel.org>; Tue, 21 Nov 2023 09:40:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 289881A0774
	for <linux-ext4@vger.kernel.org>; Tue, 21 Nov 2023 09:40:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA6MClxlGMf4BQ--.64879S4;
	Tue, 21 Nov 2023 09:40:37 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH 0/6] ext4: make ext4_map_blocks() recognize delayed only extent
Date: Tue, 21 Nov 2023 17:34:23 +0800
Message-Id: <20231121093429.1827390-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3iA6MClxlGMf4BQ--.64879S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF43AFW8ury8Wry7CF4kWFg_yoW8XrW8pr
	9xCFyfKw1kX342gFZ3Xw47Jr1Fgws7CF4UGry7Gw18uFyrAFy8GF4DKF10vFyrKrWxtr47
	ua1jkryUG3W7C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
	RwZDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Hello, guys.

I'm working on switching ext4 buffer IO from buffer_head to iomap
and enable large folio on regular file recently, this patch set is one
of a preparation of this work. It first correct the hole length returned
by ext4_map_blocks() when user query mapping type and blocks range, and
then make this function and ext4_set_iomap() are able to distinguish
delayed allocated only mapping from hole, finally cleanup the
ext4_iomap_begin_report() by the way. This preparation patch set changes
the ext4 map -> iomap converting logic in ext4_set_iomap(), so that the
later buffer IO conversion can use it. This patch set is already passed
'kvm-xfstests -g auto' tests.

Thanks,
Yi.

Zhang Yi (6):
  ext4: introduce ext4_es_skip_hole_extent() to skip hole extents
  ext4: make ext4_es_lookup_extent() return the next extent if not found
  ext4: correct the hole length returned by ext4_map_blocks()
  ext4: add a hole extent entry in cache after punch
  ext4: make ext4_map_blocks() distinguish delayed only mapping
  ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC mapping type

 fs/ext4/ext4.h              |  7 ++++-
 fs/ext4/extents.c           |  5 ++--
 fs/ext4/extents_status.c    | 53 ++++++++++++++++++++++++--------
 fs/ext4/extents_status.h    |  2 ++
 fs/ext4/inode.c             | 60 ++++++++++++++++++-------------------
 include/trace/events/ext4.h | 28 +++++++++++++++++
 6 files changed, 107 insertions(+), 48 deletions(-)

-- 
2.39.2


