Return-Path: <linux-ext4+bounces-5799-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CCA9F8C70
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 07:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CD916B95B
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 06:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6126C1A7AE3;
	Fri, 20 Dec 2024 06:11:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44B1422A8;
	Fri, 20 Dec 2024 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675112; cv=none; b=JPCojnyJF/ypKScJ7vA6zYfx/IHj6td1HtEulU6vpIe9jAHpx7uARKYDoWSvHcC3A3m+Gye0+wim1iHx1lykythMvAm5kX4kyrBui4Vf3EGLLkU61iFLjFmBxrHGO8+i5QgFGekNFelFhR6utQ9bAcW6XgdsX2YeBzes+wgHy/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675112; c=relaxed/simple;
	bh=vkhw6QBxiDe2BmoSiv5a+0H/sK625Dxn6keuLaFaiqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AruwUHjsOvbbKvrQUcKscJvsbnLSs7h0iwgIS6uTu28oPivIpRnjMdxW6NOi+vKsvw/ghLHY9NSJ2vwRjGpvAmRqHDjVhKrrrfcFEI/AAsVH/ji+pAaH6LGsDxxJFtP4fgPo1fo+JZmwi6p0SmtmI+CI+6pss5QH8YEPUTIeZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YDxrD1Xy3z4f3kw5;
	Fri, 20 Dec 2024 14:11:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CC8FE1A07B6;
	Fri, 20 Dec 2024 14:11:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoKeCmVn6SRyFA--.26943S4;
	Fri, 20 Dec 2024 14:11:44 +0800 (CST)
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
Subject: [PATCH 0/5] ext4: fix issues caused by data write-back failures
Date: Fri, 20 Dec 2024 14:07:52 +0800
Message-Id: <20241220060757.1781418-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3XoKeCmVn6SRyFA--.26943S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWUWF43tFyUGw4ktF48Crg_yoW8Xw1xpr
	9xCry3trW8ZFyS9an3Aa17Jr90kr18CFWUtF42vrn7Ar4UAr1SvrW7tFWrAa4Ut3ySg345
	Xr4kJ34rCF17JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWdkCnU2wAAAsN

From: Baokun Li <libaokun1@huawei.com>

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
Patch 3: Make “data_err=abort” works in dioread_nolock mode.
Patch 4: Remove useless i_unwritten and related code.
Patch 5: Pack holes in ext4_inode_info to save memory.

Baokun Li (5):
  ext4: replace opencoded ext4_end_io_end() in ext4_put_io_end()
  ext4: do not convert the unwritten extents if data writeback fails
  ext4: abort journal on data writeback failure if in data_err=abort mode
  ext4: remove unused member 'i_unwritten' from 'ext4_inode_info'
  ext4: pack holes in ext4_inode_info

 fs/ext4/ext4.h    | 32 ++++++++------------------------
 fs/ext4/inode.c   |  2 +-
 fs/ext4/page-io.c | 38 +++++++++++++++++++++++++-------------
 fs/ext4/super.c   |  9 +--------
 4 files changed, 35 insertions(+), 46 deletions(-)

-- 
2.46.1


