Return-Path: <linux-ext4+bounces-3548-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D8A942691
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 08:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB31D1C23E2F
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 06:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307EE16C84A;
	Wed, 31 Jul 2024 06:25:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0169D2B;
	Wed, 31 Jul 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407131; cv=none; b=mxB/NdtkO1OU9Ag1EgSUCsHZb/HvjyLV4pP29YICW0FB0poS/R7TDYA1d3yX8YngZADA1w0QbIHd9u+g217TjG+aGUFu/eMp18UaEs7Tn66aOoy7s375BCZvu9xRaWxMkcc/mhdp1J07YWZyL2BriTzuM5WdxuF8ezcIBgk4sFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407131; c=relaxed/simple;
	bh=eIth9tuI4h26Vp0wpykunSpEzcTH3IrOMQsckm/ke8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oXXRP8gTQXJjjKtszApu3sPXX1SgHPDm8DKfz4tJrSKht67niwaN0jEuQ0sCouRMqzZYSQX8Qfgk0FopUSOUDNLE21KFZZir8RBzJdoA+tKHib7YE0su17B8EdFzB/zXlz4QbhT/jdltkglqKjG8GD5G/1YQkUugGCN9h1r2BcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYhsm40CQz4f3jk3;
	Wed, 31 Jul 2024 14:25:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 36ED91A15F6;
	Wed, 31 Jul 2024 14:25:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3jE7T2KlmaFNcAQ--.8748S2;
	Wed, 31 Jul 2024 14:25:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Fix and cleanups to jbd2
Date: Wed, 31 Jul 2024 14:22:39 +0800
Message-Id: <20240731062247.2380440-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3jE7T2KlmaFNcAQ--.8748S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrykZw4fZr4fZw47tw13Arb_yoWDJFc_ZF
	WvgFZrXwsxXF13Xa43CF13WrZ5Ww4rXr18KFn3tw4qkrn7J3Z5uw4UGF4UZrnxZayvk3yY
	gr4Yq348tw1kAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

v1->v2:
-Move escape handle to futher improve
jbd2_journal_write_metadata_buffer.

This series contains a fix and some random cleanups to jbd2. More
details can be found in respective patches. Thanks!

Kemeng Shi (8):
  jbd2: correctly compare tids with tid_geq function in
    jbd2_fc_begin_commit
  jbd2: remove dead check in journal_alloc_journal_head
  jbd2: remove unused return value of jbd2_fc_release_bufs
  jbd2: remove unneeded kmap for jh_in->b_frozen_data in
    jbd2_journal_write_metadata_buffer
  jbd2: remove unneeded done_copy_out variable in
    jbd2_journal_write_metadata_buffer
  ext4: move escape handle to futher improve
    jbd2_journal_write_metadata_buffer
  jbd2: correct comment jbd2_mark_journal_empty
  jbd2: remove unneeded check of ret in jbd2_fc_get_buf

 fs/jbd2/journal.c    | 87 +++++++++++++++++++-------------------------
 include/linux/jbd2.h |  2 +-
 2 files changed, 39 insertions(+), 50 deletions(-)

-- 
2.30.0


