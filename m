Return-Path: <linux-ext4+bounces-3701-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF2D950486
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 14:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889871F23CA4
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 12:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE2319939E;
	Tue, 13 Aug 2024 12:10:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC12262B;
	Tue, 13 Aug 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551016; cv=none; b=J48LYyJOvWP9Fl23dU3riZgzuChmf8OSfj1X6Imli0P4qauufWMUUksxrFk8dkbXfH1HUZAavQJ1P1pbOdqB31HHxmC2CgKajvTHHeV6kknNCULBkrl9pfVAZsh4kI5x87KYJjpdIPb9q3UtTdYVM/3XMLE0QkUe846U2ZYwenQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551016; c=relaxed/simple;
	bh=A4DHdwWylvwUI/bLZv3liXYffGxkOg9V0fqn3Hc1KK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u2A2/n6au2BdOdAv8oHjvy5bFbI+hFaTzE1hadVc0dKxFSX6fFocwqNcPMVNjDu5Pnc6b+40i17+4d09Uf1AnsqPjue5nSXLg4JzgZfelUIcTic9LEG5As2ni3LKQSdEZYbqcu7/s25VsXqS6GXdFW/QmA8Fo9LTUavgU2AH39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjqvS6dpCz4f3jHh;
	Tue, 13 Aug 2024 20:09:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9EF211A0E97;
	Tue, 13 Aug 2024 20:10:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDnl7YhTbtmPh4XBg--.33191S2;
	Tue, 13 Aug 2024 20:10:10 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Fixes and cleanups to ext4 ialloc
Date: Tue, 13 Aug 2024 20:07:05 +0800
Message-Id: <20240813120712.2592310-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnl7YhTbtmPh4XBg--.33191S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry5CryxXr48CFyUCrW5Awb_yoWfJFc_Ja
	4kuF95trWrXas7uayDKry5JrWkCFW8Cr1jqF40qw45Z3WfJws8ua1kCr4Svr17WrW3ZFnx
	AFy7JryfA3Z2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbOAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains some random fixes and cleanups to ext4 ialloc. More
details can be found in respective patches. Thanks!

Kemeng Shi (7):
  ext4: avoid buffer_head leak in ext4_mark_inode_used
  ext4: avoid potential buffer_head leak in __ext4_new_inode
  ext4: avoid negative min_clusters in find_group_orlov
  ext4: remove dead check in __ext4_new_inode
  ext4: move checksum length calculation of inode bitmap into
    ext4_inode_bitmap_csum_[verify/set] functions
  ext4: remove unneeded NULL check of buffer_head in
    ext4_mark_inode_used
  ext4: check buffer_verified in advance to avoid unneeded
    ext4_get_group_info

 fs/ext4/bitmap.c |  8 ++++++--
 fs/ext4/ext4.h   |  4 ++--
 fs/ext4/ialloc.c | 38 +++++++++++++++++++-------------------
 fs/ext4/resize.c |  3 +--
 4 files changed, 28 insertions(+), 25 deletions(-)

-- 
2.30.0


