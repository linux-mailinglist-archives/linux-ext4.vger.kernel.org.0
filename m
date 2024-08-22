Return-Path: <linux-ext4+bounces-3841-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F9495AAFE
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B4C1C223C1
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77101F947;
	Thu, 22 Aug 2024 02:40:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AD10A1C;
	Thu, 22 Aug 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294438; cv=none; b=rlRfIf80mLvMwxKGmuBzk2p0iEqeNw6DqxAav5y+Dd954af7Jj3M9zwFl0G1lgyheN9GSZtFMXMeDV2+P09Drj7Bnwe+OgKZpNCA63+R6VxRDWABwm00Cp8NmTkNCGdRlCuuhv5Al5SecjrfTSYfDpzGL05k2HrBrDXkBGoz00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294438; c=relaxed/simple;
	bh=PD7qAguko5ryOSzVxSF4usiYnpSFl8et9TkOsabeJUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MhDPE15GOaMavUv2r40kYSp4ib1ueyG6cuFOMugPfq8Wk8rR6VSNgsKBwJZXUZUsfEISVeQpsZ0AcMs9EQV5fVURhjL7WeTa8HJHtZB3du+NA4DlL4/KfNbZZiu0daJ00kaz+qfByCAdgk5AhLB8Glos+SjF7hkbpodUk64tVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r52Z1hz4f3jt6;
	Thu, 22 Aug 2024 10:40:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 113981A06D7;
	Thu, 22 Aug 2024 10:40:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S4;
	Thu, 22 Aug 2024 10:40:28 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 00/25] ext4: some bugfixes and cleanups for ext4 extents path
Date: Thu, 22 Aug 2024 10:35:20 +0800
Message-Id: <20240822023545.1994557-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S4
X-Coremail-Antispam: 1UD129KBjvJXoWxArWkWF43Gw15Jw4xGFWUCFg_yoW7Gr15pF
	4fCw1UCw1kJw1kCrZrJa15ZF1Fyw4fW34fArW3Kr1kAF98JryF9FyxKa4YkFW5JFWxAa4a
	vFWIvr1xC3Z8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQACBWbEU35FnwABsS

From: Baokun Li <libaokun1@huawei.com>

Hi all!

This patch series is a hardening of ext4 extents path related code.

This is the second version of this patch series. Thank you, Jan Kara and
Ojaswin Mujoo, for the feedback in the previous version. The new version
has no functional changes compared to the previous one, so I've kept the
previous Reviewed-by, please let me know if you have any objections.

The following is a brief overview of the patches, see the patches for
more details.

Patch 1-2: Refactor ext4_ext_rm_idx() as suggested by Jan, and add
appropriate error handling branches to ext4_ext_rm_idx() and
ext4_ext_correct_indexes() to avoid inconsistent extents tree.
 PS: This comes from the previous work of my colleague zhanchengbin
 (see link), who is no longer in charge of these and I have taken over.
 Link: https://lore.kernel.org/r/20230213080514.535568-3-zhanchengbin1@huawei.com/

Patch 3-7: Quick fixes for use-after-free and double-free problems caused
by mixing path(pointer to an extent path) and ppath(pointer to an extent
path pointer).

Patch 8-9: Fix an issue that caused p_bh to be released twice if it wasn't
set to NULL after path->p_bh was released. And add a helper function after
the quick fix to prevent this from happening again.

Patch 10: Fix an issue where the error returned by ext4_find_extent in
ext4_insert_range() was not propagated correctly.

Patch 11-22: Now the use of path and ppath is so confusing that we can
trigger use-after-free or double-free by accessing a stale pointer, or
we can get a memory leak by forgetting to update ppath. And it's very
difficult to read the code. So to make the code more readable, get rid
of ppath and pass path between functions uniformly to avoid these risks.

Patch 23-24: Reduces the consumption of unnecessary memory operations by
avoiding repetitive allocation and release extents path.

Patch 25：Clean up ext4_ext_create_new_leaf() to reduce some unnecessary
indentation and line breaks.

"kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.
Randomly injecting faults(EIO, ENOMEM, Realloc Path) in ext4_find_extent()
while executing xfstests also did not observe new Oops.

Comments and questions are, as always, welcome.
Please let me know what you think.

Thanks,
Baokun

Changes since v1:
 * Collect RVB from Honza and Ojaswin.(Thanks for your review!)
 * Patch 5: A quick fix has been added for a null pointer or memory leak
   that could be caused by ppath remaining NULL when path is reallocated.
 * Patch 6: Added a quick fix for the UAF that could be caused by a path
   not being updated when the ppath is reallocated.(Spotted by Ojaswin)
 * Patch 8: Correct the trace stack in commit message.(Spotted by Ojaswin)
 * Patch 10: Quick fixes split from Patch 15 to be easily pulled into
   stable.(Suggested by Honza)
 * Patch 23: A refactoring split from Patch 16 for easy review.(Suggested
   by Ojaswin)
 * Patch 24: Modify the patch subject.
 * Patch 25: Added cleanup patch to remove unnecessary indentation and
   line breaks in ext4_ext_create_new_leaf().(Suggested by Honza)
 * Adjust the sequence of patches.

v1: https://lore.kernel.org/r/20240710040654.1714672-1-libaokun@huaweicloud.com

Baokun Li (25):
  ext4: refactor ext4_ext_rm_idx() to index 'path'
  ext4: prevent partial update of the extents path
  ext4: fix slab-use-after-free in ext4_split_extent_at()
  ext4: avoid use-after-free in ext4_ext_show_leaf()
  ext4: update orig_path in ext4_find_extent()
  ext4: aovid use-after-free in ext4_ext_insert_extent()
  ext4: drop ppath from ext4_ext_replay_update_ex() to avoid double-free
  ext4: fix double brelse() the buffer of the extents path
  ext4: add new ext4_ext_path_brelse() helper
  ext4: propagate errors from ext4_find_extent() in ext4_insert_range()
  ext4: get rid of ppath in ext4_find_extent()
  ext4: get rid of ppath in get_ext_path()
  ext4: get rid of ppath in ext4_ext_create_new_leaf()
  ext4: get rid of ppath in ext4_ext_insert_extent()
  ext4: get rid of ppath in ext4_split_extent_at()
  ext4: get rid of ppath in ext4_force_split_extent_at()
  ext4: get rid of ppath in ext4_split_extent()
  ext4: get rid of ppath in ext4_split_convert_extents()
  ext4: get rid of ppath in ext4_convert_unwritten_extents_endio()
  ext4: get rid of ppath in ext4_ext_convert_to_initialized()
  ext4: get rid of ppath in ext4_ext_handle_unwritten_extents()
  ext4: get rid of ppath in convert_initialized_extent()
  ext4: refactor ext4_swap_extents() to reuse extents path
  ext4: make some fast commit functions reuse extents path
  ext4: save unnecessary indentation in ext4_ext_create_new_leaf()

 fs/ext4/ext4.h        |   9 +-
 fs/ext4/extents.c     | 781 +++++++++++++++++++++++-------------------
 fs/ext4/fast_commit.c |  17 +-
 fs/ext4/migrate.c     |   5 +-
 fs/ext4/move_extent.c |  36 +-
 5 files changed, 456 insertions(+), 392 deletions(-)

-- 
2.39.2


