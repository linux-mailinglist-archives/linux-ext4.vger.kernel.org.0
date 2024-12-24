Return-Path: <linux-ext4+bounces-5851-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36BD9FBD51
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B93B1881ADD
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7381D7E50;
	Tue, 24 Dec 2024 12:29:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359FE1B6D0E;
	Tue, 24 Dec 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735043358; cv=none; b=CGcG9W/60eII9O1kxmCgC9/k7oUH46LCsP6KIZtWbo/I6i3x3iPJBX91IcQPFQg+eloCRkNct8p94JzZ1u/JZBYcglG7b5HW+LiZK8OMhUv0u/LOun3OOViTRZxgcIcZzzs7gOFWHrSS7tfYRLgwiuxcxApn4/zf0WrCI3ld9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735043358; c=relaxed/simple;
	bh=D2GK52ML0/NXax7GS2stPbPoOxy8a08asthgATnWgxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jll9lngFGwWZLXPT1WLdH7c0x4M8+lOt5Y+K82cHceB+UOdktZu/zgxmwfUhQe1uHoHVuNfkF1dcObxnvxTlZgF81pBBktIuIPsV0rwkXYqRDZo4wKFQ5J2odtuE1fLmvpjFhi7ZL8313aTelkiJQMV3CDKhjGccZLnifnKV4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YHZ206vlzz4f3jt5;
	Tue, 24 Dec 2024 20:28:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8FD2E1A0196;
	Tue, 24 Dec 2024 20:29:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDXs8AWqWpnruNnFQ--.3177S2;
	Tue, 24 Dec 2024 20:29:11 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Minor cleanups to jbd2
Date: Wed, 25 Dec 2024 04:27:01 +0800
Message-Id: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDXs8AWqWpnruNnFQ--.3177S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWfWF1DGryUKr1UJr47Jwb_yoWxtFg_Za
	yqkF98Ary7WFy3C3WIkw1FgF97Kw4xur1jq3Z5tw4jyrnrXan3Ww1DArZ5Xr97Xa1qkrW5
	Krn8Gry8Jr1fJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
	Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
	8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2js
	IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains some random minor cleanups to jbd2. No funtional
change is intended. More details can be found in respective patches.
Thanks.

Kemeng Shi (6):
  jbd2: remove unused h_jdata flag of handle
  jbd2: remove unused return value of jbd2_journal_cancel_revoke
  jbd2: remove unused return value of do_readahead
  jbd2: remove stale comment of update_t_max_wait
  jbd2: correct stale function name in comment
  jbd2: Correct stale comment of release_buffer_page

 fs/jbd2/commit.c      |  4 ++--
 fs/jbd2/recovery.c    | 11 +++--------
 fs/jbd2/revoke.c      | 13 +++++--------
 fs/jbd2/transaction.c |  3 +--
 include/linux/jbd2.h  |  4 +---
 5 files changed, 12 insertions(+), 23 deletions(-)

-- 
2.30.0


