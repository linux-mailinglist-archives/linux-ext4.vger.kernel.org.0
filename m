Return-Path: <linux-ext4+bounces-1751-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B888C3FA
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 14:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A700306EE2
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADC412AACF;
	Tue, 26 Mar 2024 13:42:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A31272CC;
	Tue, 26 Mar 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460542; cv=none; b=WHvoROfMWDgB2Rh/x468bGX5diSrtFi6lycV5QovmUTOGcA3ZKhRqxG3/HJno1MyEQPX9ed0jGkYbz1PWFN19cUaMvlBzxtRVmrxRt1q48Fjcc2xrQBlsRI98o25pHlQ/1pSLIfJO8tgdbxUETvqCz5mcLYCHdj75+QAcVwxRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460542; c=relaxed/simple;
	bh=XbDKDdKej/nZOXXuUNdEiNnJba4EVrE9Embr8/JaT3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iwPH89jAQEQgtJQBISdGn1L8uzjlQzDw9Wshgv6GVpkNTw/f/OhohbySCpy02Ao1xTmyroPtu2BTdi/iiaJqxB5hYXNwMUNDZ5hN9mer01guiLHjhNmYI7mf6TvjHmDFp2nOxVE6tcZpXbIeBgqckcq3Afsr6EU99fOe6DLpDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V3rZS1XDbz4f3m6v;
	Tue, 26 Mar 2024 21:42:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 50C591A0179;
	Tue, 26 Mar 2024 21:42:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCHowy00AJmmQiSIA--.63567S2;
	Tue, 26 Mar 2024 21:42:12 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH 0/5] Minor improvements and cleanups to ext4 mballoc
Date: Wed, 27 Mar 2024 05:38:18 +0800
Message-Id: <20240326213823.528302-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHowy00AJmmQiSIA--.63567S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4kAr1kJFyrAw1DJFW7XFb_yoW3ZFX_Ca
	4kZFykJrZxXFy7KFyIkrn8t3s5WF4Iyr1UXF95twsIvFW7XFs3u3WDCrWrZr18Wr1YyFyU
	AF17Xry8CF4IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
	Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
	8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2js
	IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7NVkUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains some minor improvements and cleanups to ext4
mballoc. No failure is found in "kvm-xfstests smoke" test and unit
test. More details can be found in respective patches. Thanks!

Kemeng Shi (5):
  ext4: keep "prefetch_grp" and "nr" consistent
  ext4: add test_mb_mark_used_cost to estimate cost of mb_mark_used
  ext4: call ext4_mb_mark_free_simple in mb_mark_used to clear bits
  ext4: use correct criteria name instead stale integer number in
    comment
  ext4: expand next_linear_group to remove repeat check for linear scan.

 fs/ext4/ext4.h         | 15 +++++--
 fs/ext4/mballoc-test.c | 56 ++++++++++++++++++++++++++
 fs/ext4/mballoc.c      | 89 +++++++++++++++++-------------------------
 fs/ext4/mballoc.h      |  4 +-
 4 files changed, 105 insertions(+), 59 deletions(-)

-- 
2.30.0


