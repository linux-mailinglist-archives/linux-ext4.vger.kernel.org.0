Return-Path: <linux-ext4+bounces-706-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04D6824C78
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 02:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DF21C21B25
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 01:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E51FB4;
	Fri,  5 Jan 2024 01:23:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D94410;
	Fri,  5 Jan 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T5m0y0dW5z4f3l8W;
	Fri,  5 Jan 2024 09:22:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DA62B1A017D;
	Fri,  5 Jan 2024 09:22:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXZUXyWZdl68i0Fg--.35140S2;
	Fri, 05 Jan 2024 09:22:59 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] Some random cleanups to mballoc
Date: Fri,  5 Jan 2024 17:20:53 +0800
Message-Id: <20240105092102.496631-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXZUXyWZdl68i0Fg--.35140S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4xWrWrAr4xAF1DKr4rKrg_yoW8Xr4rpr
	sxCr43Ww18Z345CFsrWw4qqw1fGw1xCFWUX3WSgwn7XF9xZF1fGFsrtF4F9FyrXrW0gFnx
	Zr42vr15Gr1xua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E
	3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains some random cleanups to mballoc. No function change
is intended except patch 8 may fix a potential memleak if non-used
preallocation spaces of inode could be greater than UNIT_MAX.
More details can be found in respective patches. Thanks!

v1->v2:
-Collect RVB from Jan.
-Remove 'needed' in trace_ext4_discard_preallocations.

v2->v3:
-Collect RVB from Jan and Ojaswin.
-Fix commit message in patch 2.

Kemeng Shi (9):
  ext4: remove unused return value of __mb_check_buddy
  ext4: remove unused parameter ngroup in ext4_mb_choose_next_group_*()
  ext4: remove unneeded return value of ext4_mb_release_context
  ext4: remove unused ext4_allocation_context::ac_groups_considered
  ext4: remove unused return value of ext4_mb_release
  ext4: remove unused return value of ext4_mb_release_inode_pa
  ext4: remove unused return value of ext4_mb_release_group_pa
  ext4: remove unnecessary parameter "needed" in
    ext4_discard_preallocations
  ext4: remove 'needed' in trace_ext4_discard_preallocations

 fs/ext4/ext4.h              |  4 +--
 fs/ext4/extents.c           | 10 ++++----
 fs/ext4/file.c              |  2 +-
 fs/ext4/indirect.c          |  2 +-
 fs/ext4/inode.c             |  6 ++---
 fs/ext4/ioctl.c             |  2 +-
 fs/ext4/mballoc.c           | 49 ++++++++++++++-----------------------
 fs/ext4/mballoc.h           |  1 -
 fs/ext4/move_extent.c       |  4 +--
 fs/ext4/super.c             |  2 +-
 include/trace/events/ext4.h | 11 +++------
 11 files changed, 38 insertions(+), 55 deletions(-)

-- 
2.30.0


