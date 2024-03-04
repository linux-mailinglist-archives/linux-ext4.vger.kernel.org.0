Return-Path: <linux-ext4+bounces-1494-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54CA86FAFF
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 08:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D2B210A7
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4B017566;
	Mon,  4 Mar 2024 07:39:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4C14ABC;
	Mon,  4 Mar 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537953; cv=none; b=Afh6uZoqVMGh992A2wZLzw3mf5U1OkAwM/nTP0+1IkWLdTGSLpmF7rq77CRSAYT2z86LNaLLuzJghvK0mWRQ5xd8TXYfmYQwGiw+yPGHh7ghAHlloaigWSmfCcuuWiMdnJwp1jG0KKDJRICEuPCKRKy+h/iH1rbAh1B2648vPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537953; c=relaxed/simple;
	bh=QeEW/mhWgeO0FWL+qh7PGW3mJVcstKH+c64VwZdxhkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tqaTPSdVZOgjNptqEBn77Zs/M/2NrQsc4ufdLHuUBaMwYcGqbOz768yKTwaH+6qJWvppp8XP0lqoiJcfjB9sBMEMPPtbC3F9WfvkogGZsQdsZ7cxrBqY45kXnF6uMA9BOrtp1gQoNWd3NNnihSYU4PvujkyWt4L6wDB/2QW+8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tp9Yb3wLSz4f3m7g;
	Mon,  4 Mar 2024 15:38:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 036BA1A0283;
	Mon,  4 Mar 2024 15:39:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDXKGuXeuVlWUH1Fw--.2277S2;
	Mon, 04 Mar 2024 15:39:05 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org,
	linux@roeck-us.net,
	brauner@kernel.org
Subject: [PATCH v4 0/3] Fix crashes and warnings in ext4 unit test
Date: Tue,  5 Mar 2024 00:35:40 +0800
Message-Id: <20240304163543.6700-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXKGuXeuVlWUH1Fw--.2277S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyUJryxCryruFWkXw1fJFb_yoWDGrc_GF
	WkA3s5Jr4xta1jkFy7tr1FqrykKay2vry8ZFW7JFy7G34xZw13ta4kGr1vy3Z5Ww45Ar9x
	XwnYkr1fZwnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
	3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jIGQDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v3->v4:
-fix that sbi->s_dirtyclusters_counter is used before
initialization.

v2->v3:
-fix warning that sb->s_umount is still held when unit test finishs
-fix warning that sbi->s_freeclusters_counter is used before
initialization.

v1->v2:
-properly handle error from sget()

Previously, the new mballoc unit tests are only tested by running
"./tools/testing/kunit/kunit.py run ..." in which case only rare configs
are enabled.
This series fixes issues when more debug configs are enabled. Fixes are
tested with and without kunit_tool [1].

[1] https://docs.kernel.org/dev-tools/kunit/run_manual.html

Kemeng Shi (3):
  ext4: alloc test super block from sget
  ext4: hold group lock in ext4 kunit test
  ext4: initialize sbi->s_freeclusters_counter and
    sbi->s_dirtyclusters_counter before use in kunit test

 fs/ext4/mballoc-test.c | 85 +++++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 17 deletions(-)

-- 
2.30.0


