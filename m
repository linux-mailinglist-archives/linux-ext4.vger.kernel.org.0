Return-Path: <linux-ext4+bounces-151-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17807F8909
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 09:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4AA1C20BC9
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 08:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80C9475;
	Sat, 25 Nov 2023 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768E110E4;
	Sat, 25 Nov 2023 00:12:55 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Scl2l5QWPz4f3m7R;
	Sat, 25 Nov 2023 16:12:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2066C1A02C2;
	Sat, 25 Nov 2023 16:12:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgCnSkmCrGFlWcLEBw--.36822S2;
	Sat, 25 Nov 2023 16:12:51 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Some random cleanups to mballoc
Date: Sun, 26 Nov 2023 00:11:35 +0800
Message-Id: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnSkmCrGFlWcLEBw--.36822S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1rtryUAF4xWF4DWryUZFb_yoWkKrc_Ga
	4xWF95tr43JFyfC3W8Kw45tFW8tF4xuF1YyFZ3ta15ZFy3ZrW8C3WDCrWfur45urZ5Aa4a
	krnrJry8tF4IvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
	3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsBMNUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains some random cleanups to mballoc. No function change
is intended except patch 8 may fix a potential memleak if non-used
preallocation spaces of inode could be greater than UNIT_MAX.
More details can be found in respective patches. Thanks!

Kemeng Shi (8):
  ext4: remove unused return value of __mb_check_buddy
  ext4: remove unused parameter group in ext4_mb_choose_next_group_*()
  ext4: remove unneeded return value of ext4_mb_release_context
  ext4: remove unused ext4_allocation_context::ac_groups_considered
  ext4: remove unused return value of ext4_mb_release
  ext4: remove unused return value of ext4_mb_release_inode_pa
  ext4: remove unused return value of ext4_mb_release_group_pa
  ext4: remove unnecessary parameter "needed" in
    ext4_discard_preallocations

 fs/ext4/ext4.h        |  4 ++--
 fs/ext4/extents.c     | 10 +++++-----
 fs/ext4/file.c        |  2 +-
 fs/ext4/indirect.c    |  2 +-
 fs/ext4/inode.c       |  6 +++---
 fs/ext4/ioctl.c       |  2 +-
 fs/ext4/mballoc.c     | 46 ++++++++++++++++---------------------------
 fs/ext4/mballoc.h     |  1 -
 fs/ext4/move_extent.c |  4 ++--
 fs/ext4/super.c       |  2 +-
 10 files changed, 33 insertions(+), 46 deletions(-)

-- 
2.30.0


