Return-Path: <linux-ext4+bounces-3155-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2459E92C992
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1F41F23D2C
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2A0770E6;
	Wed, 10 Jul 2024 04:09:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC02BB04;
	Wed, 10 Jul 2024 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584558; cv=none; b=aEe9zz5O9N2Q+b0TOJl4vN3hGQbSLWS4K6UbjZfcW9nY7hNHTmuxr/u4w99y2zD8mAMzB6Pu64ZB4H64eAJDo4k8peUqPaRwKfHeyOutsUiQC/FVoLvBS52ooNVcC56kOD1cKuHCn1ch992Aw3RuwaNQhMoX1IyNJLMkvkcdvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584558; c=relaxed/simple;
	bh=qc4SezDM94JLx0RivPHLn3N6khqf8RIdNCtutKb+Ors=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KcrHeF2r49uSeQeesnPLp1JZhghTl3ZRM9dRvGh5cqb479S43PQSQe263sS+eaROQFnMbKMgGc7NH4Cr6Hxaxar5eyU4AH1bkHQW6rZUKJUTpYxNFX+6HVBWDiGrYzwlUy54NE7uRShC81HQK+weGmtrjynAGphNSsywvaG4luA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WJkr900Vzz4f3kp6;
	Wed, 10 Jul 2024 12:08:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9D0321A016E;
	Wed, 10 Jul 2024 12:09:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIZdCY5mkoy3Bg--.14986S4;
	Wed, 10 Jul 2024 12:09:03 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 00/20] ext4: some bugfixes and cleanups for ext4 extents path
Date: Wed, 10 Jul 2024 12:06:34 +0800
Message-Id: <20240710040654.1714672-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAIZdCY5mkoy3Bg--.14986S4
X-Coremail-Antispam: 1UD129KBjvJXoWxArWkZw1Utw1UXryfXFW7XFb_yoW5Cry5pF
	s3Cw1UA34vq3s7u39xJa15ZF15Gw4fG343Ary3Gr1kAF98JryFgFyxKa4YyFW5JFWxCF9I
	vFW0yr17Cas8Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUm2NtUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAPBV1jkIIt0wABsY

From: Baokun Li <libaokun1@huawei.com>

Hi all!

This patch series is a hardening of ext4 extents path related code.
The following is a brief overview of the patches, see the patches for
more details.

Patch 1-2: Refactor ext4_ext_rm_idx() as suggested by Jan, and add
appropriate error handling branches to ext4_ext_rm_idx() and
ext4_ext_correct_indexes() to avoid inconsistent extents tree.
 PS: This comes from the previous work of my colleague zhanchengbin
 (see link), who is no longer in charge of these and I have taken over.
 Link: https://lore.kernel.org/r/20230213080514.535568-3-zhanchengbin1@huawei.com/

Patch 3-4: Fix an issue that caused p_bh to be released twice if it wasn't
set to NULL after path->p_bh was released. And add a helper function after
the quick fix to prevent this from happening again.

Patch 5-7: Quick fixes for use-after-free and double-free problems caused
by mixing path(pointer to an extent path) and ppath(pointer to an extent
path pointer).

Patch 8-19: Now the use of path and ppath is so confusing that we can
trigger use-after-free or double-free by accessing a stale pointer, or
we can get a memory leak by forgetting to update ppath. And it's very
difficult to read the code. So to make the code more readable, get rid
of ppath and pass path between functions uniformly to avoid these risks.

Patch 20: Reduces the consumption of unnecessary memory operations by
avoiding repetitive allocation and release paths.

"kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.

Comments and questions are, as always, welcome.
Please let me know what you think.

Thanks,
Baokun

Baokun Li (20):
  ext4: refactor ext4_ext_rm_idx() to index 'path'
  ext4: prevent partial update of the extents path
  ext4: fix double brelse() the buffer of the extents path
  ext4: add new ext4_ext_path_brelse() helper
  ext4: fix slab-use-after-free in ext4_split_extent_at()
  ext4: avoid use-after-free in ext4_ext_show_leaf()
  ext4: drop ppath from ext4_ext_replay_update_ex() to avoid double-free
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
  ext4: avoid unnecessary extent path frees and allocations

 fs/ext4/ext4.h        |   9 +-
 fs/ext4/extents.c     | 746 +++++++++++++++++++++++-------------------
 fs/ext4/fast_commit.c |  17 +-
 fs/ext4/migrate.c     |   5 +-
 fs/ext4/move_extent.c |  36 +-
 5 files changed, 439 insertions(+), 374 deletions(-)

-- 
2.39.2


