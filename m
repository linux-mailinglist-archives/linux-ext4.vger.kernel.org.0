Return-Path: <linux-ext4+bounces-6156-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEFBA1786F
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 08:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8817A1742
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 07:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ADC1B0F14;
	Tue, 21 Jan 2025 07:16:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4716A395;
	Tue, 21 Jan 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443799; cv=none; b=ToAg35ON+qjy5pB9g3ldK1kp7Quj0v5tKGcb/Lii/3zcRF8IE3YRvaADuPk/t8Xqytjg5ROAJwm9xebng0CUqzBx3+TaIWojaqjfhx7A+7CCK6VO3dmOi8e6DsqGRBz8PLZZsjkfaLfK7Y/vQIvJHp3J3nn50AUvX8Sjx5T+Tus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443799; c=relaxed/simple;
	bh=mqN1GAoOJAzSX9J5i94RKL0VRbHgzzsfU5CDOfV76VE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IGFuMEGe2BXPgqX1/ODqKVz9+BZnsg6+b8lr/zGWX+9Z+Tz1ex1wLFFImnSdzasdmHA95gL9PME4eaQFiibGMahhQxQD80NsP6l8Qyh19jUXXq7NooJnq7Ipw85JHYXoJFHl/KcNSkVaF2VxKARZvf9G5yfI6egQAElEEeZ7BZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YcdmL26H3z4f3jqw;
	Tue, 21 Jan 2025 15:16:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AEFF11A07BD;
	Tue, 21 Jan 2025 15:16:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2DNSY9n3Gg+Bg--.34135S4;
	Tue, 21 Jan 2025 15:16:31 +0800 (CST)
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
Subject: [PATCH v2 0/8] ext4: fix issues caused by data write-back failures
Date: Tue, 21 Jan 2025 15:10:42 +0800
Message-Id: <20250121071050.3991249-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2DNSY9n3Gg+Bg--.34135S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW3GrW8JryxAw1fZFW7twb_yoW5Jr4Dpr
	ZIkryayry8ZFyxua1fAa1xXryYk3WrAFW7tF17X3WkAw4DAr1SyrW7tFWrCa4jy393Ka4Y
	qr4DA34fuF47AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjfUO73vUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgALBWeKD3kBggAIsc

From: Baokun Li <libaokun1@huawei.com>

Changes since v1:
 * Patch 5: Make data_err=abort work for all Buffer IO, not just add
            support in dioread_nolock mode.
 * Add patch 3,4,6.
 * Collect RVB from Jan Kara and Zhang Yi.(Thanks for your review!)

v1: https://lore.kernel.org/r/20241220060757.1781418-1-libaokun@huaweicloud.com

Recently some of our customers remounted ext4 from
"dioread_nolock,data_err=abort" to "dioread_lock,data_err=abort" and the
ext4 filesystem became read-only.

Then I found that "data_err=abort" is not working in dioread_nolock mode,
when data writeback fails, the error is always recorded in inode mapping,
but no one will check it, not even when converting unwritten to written,
which could expose stale data. When remounted with dioread_lock, the error
recorded in the inode mapping was checked and the journal aborted, and the
file system became read-only later.

Patch 1: Clean up duplicate code and ensure that an warning is printed
         when data may be lost;
Patch 2: Fix an issue that could expose stale data when data writeback
         fails;
Patch 3: Reject data_err=abort in nojournal mode to ensure
         sbi->s_journal != NULL when DATA_ERR_ABORT set.
Patch 4: Add the ext4_check_nojournal_options() helper to
         reduce code duplication.
Patch 5: Make data_err=abort work for all Buffer IO, not just order mode.
Patch 6: Update the description of data_err=abort|ignore in the DOC.
Patch 7: Remove useless i_unwritten and related code.
Patch 8: Pack holes in ext4_inode_info to save memory.

Comments and questions are, as always, welcome.

Thanks,
Baokun

Baokun Li (8):
  ext4: replace opencoded ext4_end_io_end() in ext4_put_io_end()
  ext4: do not convert the unwritten extents if data writeback fails
  ext4: reject the 'data_err=abort' option in nojournal mode
  ext4: extract ext4_check_nojournal_options() from __ext4_fill_super()
  ext4: abort journal on data writeback failure if in data_err=abort mode
  ext4: update the descriptions of data_err=abort and data_err=ignore
  ext4: remove unused member 'i_unwritten' from 'ext4_inode_info'
  ext4: pack holes in ext4_inode_info

 Documentation/admin-guide/ext4.rst |  7 ++-
 fs/ext4/ext4.h                     | 34 ++++----------
 fs/ext4/inode.c                    |  2 +-
 fs/ext4/page-io.c                  | 75 ++++++++++++++++++++----------
 fs/ext4/super.c                    | 61 +++++++++++++-----------
 5 files changed, 98 insertions(+), 81 deletions(-)

-- 
2.39.2


