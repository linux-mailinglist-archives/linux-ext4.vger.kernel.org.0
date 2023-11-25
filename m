Return-Path: <linux-ext4+bounces-143-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C81D7F88DE
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 08:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9517B2817D6
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 07:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575518F49;
	Sat, 25 Nov 2023 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80171701;
	Fri, 24 Nov 2023 23:42:57 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SckN93JYJz4f3l10;
	Sat, 25 Nov 2023 15:42:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CA5961A040A;
	Sat, 25 Nov 2023 15:42:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgCX7Ut8pWFlk8TCBw--.12413S2;
	Sat, 25 Nov 2023 15:42:53 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] More unit test for mballoc
Date: Sat, 25 Nov 2023 23:41:39 +0800
Message-Id: <20231125154144.3943442-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCX7Ut8pWFlk8TCBw--.12413S2
X-Coremail-Antispam: 1UD129KBjvdXoWrWryUKF4DAr4rGr43JrykAFb_yoWxGFg_GF
	1xAF9rJr48AF17GFySgr1kJFW8Kr4xAr18Xa48Xr1vgrWjvF4UAwn7Kw4rJw45GwsxA3y3
	Aw1DWr1rCr4aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
	3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0miiDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Sorry for the late update as I was busy on my own things.
This series covers more function to mark on-disk bitmap. Besides, some
code which is relevant to buddy cache is also tested.
Before more work is done, I want to be sure I'm not on a wrong
direction!

Kemeng Shi (5):
  ext4: Add unit test for test_free_blocks_simple
  ext4: Add unit test of ext4_mb_generate_buddy
  ext4: Add unit test for mb_mark_used
  ext4: Add unit test for mb_free_blocks
  ext4: Add unit test for ext4_mb_mark_diskspace_used

 fs/ext4/mballoc-test.c | 504 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 504 insertions(+)

-- 
2.30.0


