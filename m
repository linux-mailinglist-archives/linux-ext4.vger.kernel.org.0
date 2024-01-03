Return-Path: <linux-ext4+bounces-631-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C5C8226FA
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 03:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF8C1C21D24
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 02:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB35C4A13;
	Wed,  3 Jan 2024 02:30:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC9186B;
	Wed,  3 Jan 2024 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T4YbT063Hz4f3l7R;
	Wed,  3 Jan 2024 10:30:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 457B71A088B;
	Wed,  3 Jan 2024 10:30:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDX2A62xpRlYWmAFQ--.14269S2;
	Wed, 03 Jan 2024 10:30:16 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] Some random cleanups to mballoc
Date: Wed,  3 Jan 2024 18:28:12 +0800
Message-Id: <20240103102821.448134-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2A62xpRlYWmAFQ--.14269S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4xWrWrAr4xAF1DKr4rKrg_yoW8GF4Upr
	sxCr43Ww18Z345uFsrWw4vqw1fGw1xCFWUX3WSgwn7XFy3ZF1fGFsrtF4F9FyrXFW0qFnx
	Za12yr15Gr1xua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Kemeng Shi (9):
  ext4: remove unused return value of __mb_check_buddy
  ext4: remove unused parameter group in ext4_mb_choose_next_group_*()
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


