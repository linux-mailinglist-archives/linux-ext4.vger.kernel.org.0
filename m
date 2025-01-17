Return-Path: <linux-ext4+bounces-6143-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C3A14B1F
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 09:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9773188BCAB
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 08:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC141F8ADA;
	Fri, 17 Jan 2025 08:28:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622481F6686;
	Fri, 17 Jan 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102530; cv=none; b=ULz8ZH/LrG/05q/rdgGsjbDTpHx02fPR9BC3f9YDxwvwM25HcyP7N1TWtpdgHmeanRKPpU9t81lG7n/CPkpPD0023sesjR/hY9ndr18ZIMJNmUbicxOknvwAhN2HuBEAhVmyF+ZNPDTUsR9xHGa5EKiP3yl8Jo30IdQeWO+Rwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102530; c=relaxed/simple;
	bh=/n50zAxi2wksg8KxXG2Vi3QsoV0uozj50fhRWmDWwOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GpcgAVK9PoMqNHeHJooEdOdwMDDjDlUp78KaoezjDawsgZsCuHkD4xDp7XJ80rHbPfKOU6mA4y/s5pq3qt/yp54A8gqUcWYICBQZlsZYkhuNYZIC6IznpR4PnCexSTSxLI29KnzqzaG/yWKGpFiEiTJkxzG2tVD62fbhBH3vT+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZCYL5wfHz4f3lCm;
	Fri, 17 Jan 2025 16:28:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 864C41A0DE1;
	Fri, 17 Jan 2025 16:28:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl+5FIpnZbnIBA--.46013S4;
	Fri, 17 Jan 2025 16:28:43 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 0/7] ext4: correct behaviors under errors=remount-ro mode
Date: Fri, 17 Jan 2025 16:23:08 +0800
Message-Id: <20250117082315.2869996-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl+5FIpnZbnIBA--.46013S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF15Cryxur48Gw48Wr18Grg_yoW8Cr43pw
	s3GrnxXr10vry3ua13G3y8X3W3Jr4xCa1UXr1ftr18Wry5Aryrur42kr1F9FyUWrW8Xr15
	XF17Jr15Wr13CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUmjgxUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQALBWeKD3IBjwAAsR

From: Baokun Li <libaokun1@huawei.com>

After commit d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem
errors") in v6.12-rc1, the 'errors=remount-ro' mode no longer sets
SB_RDONLY on errors, which results in us seeing the filesystem is still
in rw state after errors.

What's worse is that after commit
  95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag")
was merged in v6.6-rc1, the EXT4_FLAGS_SHUTDOWN bit is set in
ext4_handle_error(). This causes the file system to not be read-only
when an error is triggered in "errors=remount-ro" mode, because
EXT4_FLAGS_SHUTDOWN prevents both writing and reading.

This patch set fixes the above behavior change. See the link[1] for the
previous discussion:

Link: https://lore.kernel.org/all/22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com [1]

Comments and questions are, as always, welcome.

Thanks,
Baokun

Baokun Li (7):
  ext4: convert EXT4_FLAGS_* defines to enum
  ext4: add EXT4_FLAGS_EMERGENCY_RO bit
  ext4: add ext4_is_emergency() helper function
  ext4: add ext4_sb_rdonly() helper function
  ext4: correct behavior under errors=remount-ro mode
  ext4: show 'emergency_ro' when EXT4_FLAGS_EMERGENCY_RO is set
  ext4: show 'shutdown' hint when ext4 is forced to shutdown

 fs/ext4/ext4.h      | 28 ++++++++++++++++++++---
 fs/ext4/ext4_jbd2.c |  6 +++--
 fs/ext4/file.c      | 26 ++++++++++++++-------
 fs/ext4/fsync.c     | 12 ++++------
 fs/ext4/ialloc.c    |  5 +++--
 fs/ext4/inline.c    |  2 +-
 fs/ext4/inode.c     | 47 +++++++++++++++++++++-----------------
 fs/ext4/ioctl.c     |  2 +-
 fs/ext4/mballoc.c   |  4 ++--
 fs/ext4/mmp.c       |  2 +-
 fs/ext4/namei.c     | 20 ++++++++++-------
 fs/ext4/page-io.c   |  2 +-
 fs/ext4/super.c     | 55 ++++++++++++++++++++++-----------------------
 13 files changed, 126 insertions(+), 85 deletions(-)

-- 
2.39.2


