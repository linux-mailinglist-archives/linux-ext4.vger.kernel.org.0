Return-Path: <linux-ext4+bounces-6211-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B53FA190E5
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6138B3AAD3C
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122C62135DE;
	Wed, 22 Jan 2025 11:47:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363621323C;
	Wed, 22 Jan 2025 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546451; cv=none; b=p3mEMSYBg5FhubwaGoLuCJoE7Y6hh1AzjpI87x8iCpO1fFdMd+l2h/9ZaZnrwRN/aGw1WhC4mYORc3i8JPTw3vK2rrtcZ0szNjmdBV/Zo8zDtUO+JEIas5dTHLSTush40auCyy8GJuF3KRgtu3YriaVKrDQAuQ1XUW9aAeZNLEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546451; c=relaxed/simple;
	bh=n+8ksibll6RKcRg5uSvdbsQ//ji0CwFwmK5uNUqU1SY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JYdPKgXH8uY0oKlZ9C6vFTvSVntXsFIhiBHfqmn347kV4BFP49XujbYF0GxOLu7RamzO3pVs32Fl3wr8SVBQQ68rHdyZ+GbQnf/Ax1o3ScYZWj5cKTgMOvfFc2zFVQfh5FPPWdjUKAcyhbVI7KyAJ+4cx3qNczjHz+Df864fHxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdMkJ5qpXz4f3jqC;
	Wed, 22 Jan 2025 19:47:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 441D11A08FE;
	Wed, 22 Jan 2025 19:47:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl_F2pBn0KiuBg--.48765S4;
	Wed, 22 Jan 2025 19:47:18 +0800 (CST)
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
Subject: [PATCH v2 0/7] ext4: correct behaviors under errors=remount-ro mode
Date: Wed, 22 Jan 2025 19:41:23 +0800
Message-Id: <20250122114130.229709-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl_F2pBn0KiuBg--.48765S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4xuFy3KF13ury7XFWfuFg_yoW5GF13pr
	s3GwnxXr109r97WanxG34j93W5Gwn3C3W7Xr1fKr18WFyUAr1ruF4IkF1FgFyUWrWxWa4D
	ZF17Ar15Wr47CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUO73vUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAQBWeQpvMO6QAAsR

From: Baokun Li <libaokun1@huawei.com>

Changes since v1:
 * Patch 1,2: Add comma after the last enum member.
 * Patch 3: Rename ext4_is_emergency() to ext4_emergency_state().
 * Patch 4: Instead of adding an ext4_sb_rdonly() helper, add additional
            ext4_emergency_state() checks.
 * Patch 5: Replace sb_rdonly() with ext4_emergency_ro() in
            ext4_handle_error() and keep the SB_RDONLY comments.
 * Collect RVB from Jan Kara and Zhang Yi.(Thanks for your review!)
 * Rebased on link[2] to avoid context conflicts with Patch 3.
  (ext4_forced_shutdown() -> ext4_emergency_state() in ext4_end_io_end()).

[v1]: https://lore.kernel.org/r/20250117082315.2869996-1-libaokun@huaweicloud.com
Link: https://lore.kernel.org/r/20250122110533.4116662-1-libaokun@huaweicloud.com [2]

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

Link: https://lore.kernel.org/r/22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com [1]

Comments and questions are, as always, welcome.

Thanks,
Baokun

Baokun Li (7):
  ext4: convert EXT4_FLAGS_* defines to enum
  ext4: add EXT4_FLAGS_EMERGENCY_RO bit
  ext4: add ext4_emergency_state() helper function
  ext4: add more ext4_emergency_state() checks around sb_rdonly()
  ext4: correct behavior under errors=remount-ro mode
  ext4: show 'emergency_ro' when EXT4_FLAGS_EMERGENCY_RO is set
  ext4: show 'shutdown' hint when ext4 is forced to shutdown

 fs/ext4/ext4.h      | 23 +++++++++++++--
 fs/ext4/ext4_jbd2.c |  6 ++--
 fs/ext4/file.c      | 27 +++++++++++------
 fs/ext4/fsync.c     | 12 +++-----
 fs/ext4/ialloc.c    |  5 ++--
 fs/ext4/inline.c    |  2 +-
 fs/ext4/inode.c     | 47 +++++++++++++++++-------------
 fs/ext4/ioctl.c     |  2 +-
 fs/ext4/mballoc.c   |  4 +--
 fs/ext4/mmp.c       |  2 +-
 fs/ext4/namei.c     | 20 +++++++------
 fs/ext4/page-io.c   |  2 +-
 fs/ext4/super.c     | 70 +++++++++++++++++++++++++--------------------
 13 files changed, 134 insertions(+), 88 deletions(-)

-- 
2.39.2


