Return-Path: <linux-ext4+bounces-6161-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC0AA1787B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 08:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAF97A4589
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 07:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F11BE223;
	Tue, 21 Jan 2025 07:16:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272271B81B8;
	Tue, 21 Jan 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443803; cv=none; b=s2etQsVY/qBbUvTfZMHF0BFDxE8qhGnudtjs7dMFGwKvFe9UOV0xA9MSf7q8U2uYA6iuemqVHvPY8eJ7fXDe7PekQIpvpKgIktLokDKQM8zAX+hEJvp40lvgXN4FvR/nAQ7KaktlfsE8hpVOtvaeqtzgba5GE7t0bT75di9nEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443803; c=relaxed/simple;
	bh=FtrVKFZyNVHyXc8Ymufsw66wGj8NaMiC5Fr6Cjols38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibnIKmyb3tcQEf/pHKpOueGVER1ihOwSABARJJKOWwU7SK2hf3bezCaKwzUvjJ0bQYpAUDs/XMmiJTW9HUx78CQsPCWudpNyAOWVc7N2qyWzJ5zjDV1xfSk1OsfabiruHat/bl5UqSxPjdpteG1QtQ8m2+vCfZ2Nr3jNl2U2hYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YcdmK3XjLz4f3jMn;
	Tue, 21 Jan 2025 15:16:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 14E651A17D8;
	Tue, 21 Jan 2025 15:16:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2DNSY9n3Gg+Bg--.34135S10;
	Tue, 21 Jan 2025 15:16:37 +0800 (CST)
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
Subject: [PATCH v2 6/8] ext4: update the descriptions of data_err=abort and data_err=ignore
Date: Tue, 21 Jan 2025 15:10:48 +0800
Message-Id: <20250121071050.3991249-7-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250121071050.3991249-1-libaokun@huaweicloud.com>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2DNSY9n3Gg+Bg--.34135S10
X-Coremail-Antispam: 1UD129KBjvJXoW7WFykArWfGF1xXr17CrWruFg_yoW8GFyDpr
	sxK3s2qrykuF13CF48Aa1SqFWfKF1xXF43GFs29as7Wan8JrnYqw17t3WYqFyakrWfKay5
	ZrW2gw1fuFnFya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7
	CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUbT7KDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAPBWeOA-NKygADsR

From: Baokun Li <libaokun1@huawei.com>

We now print error messages in ext4_end_bio() when page writeback
encounters an error. If data_err=abort is set, the journal will also
be aborted in a kworker. This means that we now check all Buffer I/O
in all modes and decide whether to abort the journal based on the
data_err option. Therefore, we remove the ordered mode restriction
in the descriptions of data_err=abort and data_err=ignore.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 Documentation/admin-guide/ext4.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
index 2418b0c2d3df..b857eb6ca1b6 100644
--- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -238,11 +238,10 @@ When mounting an ext4 filesystem, the following option are accepted:
         configured using tune2fs)
 
   data_err=ignore(*)
-        Just print an error message if an error occurs in a file data buffer in
-        ordered mode.
+        Just print an error message if an error occurs in a file data buffer.
+
   data_err=abort
-        Abort the journal if an error occurs in a file data buffer in ordered
-        mode.
+        Abort the journal if an error occurs in a file data buffer.
 
   grpid | bsdgroups
         New objects have the group ID of their parent.
-- 
2.39.2


