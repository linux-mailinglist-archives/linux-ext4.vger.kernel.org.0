Return-Path: <linux-ext4+bounces-6149-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281CBA14B27
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 09:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04923A6919
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 08:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DFF1F91DF;
	Fri, 17 Jan 2025 08:28:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67A1F8AC1;
	Fri, 17 Jan 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102532; cv=none; b=mKMP5hflcugLZR/kx1JYSI7Z9toj/CvWf3FhYN7K5lmP4ZrY/4cLy/2dty/CVVxz41iKgUP7hCUSY79dbpPeyRqoyc0ZvB+x/0V91V2VMKrYu9ElbnpYxsza0oEgfqZzZOAUwL1ScDcT0jp11ggW3TIL6zO3YEr/1a11x2C+i7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102532; c=relaxed/simple;
	bh=Ek3Sl+5WMSS74V1QklldqLln5s6Se8qKoZ3+CnrEkzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nNAhKikPX+t0n1s9HeDGbWVBYFuKPSNU9oainbAnSSyeLHnW+/pxAvDoO2QqdDcfj0VT2gNBcmEcLxdohTLTFNtX+tSUUsd3m6LbD+ye5euSLq9Jgkp71TGew95W4bqILATAFFOeg0Wi+B8Qyjw6HoXfkxp579YT646kPGTby80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZCYX3L5rz4f3jqx;
	Fri, 17 Jan 2025 16:28:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B65041A13C7;
	Fri, 17 Jan 2025 16:28:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl+5FIpnZbnIBA--.46013S11;
	Fri, 17 Jan 2025 16:28:47 +0800 (CST)
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
Subject: [PATCH 7/7] ext4: show 'shutdown' hint when ext4 is forced to shutdown
Date: Fri, 17 Jan 2025 16:23:15 +0800
Message-Id: <20250117082315.2869996-8-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250117082315.2869996-1-libaokun@huaweicloud.com>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl+5FIpnZbnIBA--.46013S11
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1fZF48GFWDuFWUKr1DGFg_yoWDurX_Z3
	yfGan3XanxCws2y3W8CFW5XrZIkFs2vw15Xr93tryrXw15X3y8JF1DJrW8Ar1fWaySgr98
	AFsavF1DXFyxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbyxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCY1x
	0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
	yTuYvjfUYl19UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgALBWeKD3kBggAGsS

From: Baokun Li <libaokun1@huawei.com>

Now, if dmesg is cleared, we have no way of knowing if the file system has
been shutdown. Moreover, ext4 allows directory reads even after the file
system has been shutdown, so when reading a file returns -EIO, we cannot
determine whether this is a hardware issue or if the file system has been
shutdown.

Therefore, when ext4 file system is shutdown, we're adding a 'shutdown'
hint to commands like mount so users can easily check the file system's
status.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2377ebf0aff1..b15c36df934c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3032,6 +3032,9 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	if (ext4_emergency_ro(sb))
 		SEQ_OPTS_PUTS("emergency_ro");
 
+	if (ext4_forced_shutdown(sb))
+		SEQ_OPTS_PUTS("shutdown");
+
 	ext4_show_quota_options(seq, sb);
 	return 0;
 }
-- 
2.39.2


