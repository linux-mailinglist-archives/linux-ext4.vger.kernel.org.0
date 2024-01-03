Return-Path: <linux-ext4+bounces-641-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7663822729
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 03:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F87A284A9B
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 02:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80E04A21;
	Wed,  3 Jan 2024 02:51:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3417984;
	Wed,  3 Jan 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4Z3M276Lz4f3mW9;
	Wed,  3 Jan 2024 10:50:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0AF2F1A01CA;
	Wed,  3 Jan 2024 10:50:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3U0SNy5RlDGn8FQ--.36935S2;
	Wed, 03 Jan 2024 10:50:55 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] More unit test for mballoc
Date: Wed,  3 Jan 2024 18:48:55 +0800
Message-Id: <20240103104900.464789-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3U0SNy5RlDGn8FQ--.36935S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF47Wr4rKF1fZF1kGw4DJwb_yoW7Cr43pa
	9Fkrn8Kr1UGrnFvan3C3sruw1ftw10ya1UXryrtry2gF93W3sFyF1qgryYk34vgF1kZw1q
	vF18uFW7ua9FqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E
	3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0miiDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series covers more function to mark on-disk bitmap. Besides, some
code which is relevant to buddy cache is also tested.
Before more work is done, I want to be sure I'm not on a wrong
direction!

v1->v2:
-Fix unused variable warning which is reported at
https://lore.kernel.org/lkml/202311260042.kMxL6DnL-lkp@intel.com/T/

Kunit test result is as following:
# ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig --raw_output
[18:39:42] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
[18:39:45] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make ARCH=um O=.kunit --jobs=88
[18:39:57] Starting KUnit Kernel (1/1)...
KTAP version 1
1..2
    KTAP version 1
    # Subtest: ext4_mballoc_test
    # module: ext4
    1..6
        KTAP version 1
        # Subtest: test_new_blocks_simple
        ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
    # test_new_blocks_simple: pass:3 fail:0 skip:0 total:3
    ok 1 test_new_blocks_simple
        KTAP version 1
        # Subtest: test_free_blocks_simple
        ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
    # test_free_blocks_simple: pass:3 fail:0 skip:0 total:3
    ok 2 test_free_blocks_simple
        KTAP version 1
        # Subtest: test_mb_generate_buddy
        ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
    # test_mb_generate_buddy: pass:3 fail:0 skip:0 total:3
    ok 3 test_mb_generate_buddy
        KTAP version 1
        # Subtest: test_mb_mark_used
        ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
 # SKIP blocksize exceeds pagesize
    # test_mb_mark_used: pass:2 fail:0 skip:1 total:3
    ok 4 test_mb_mark_used
        KTAP version 1
        # Subtest: test_mb_free_blocks
        ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
 # SKIP blocksize exceeds pagesize
    # test_mb_free_blocks: pass:2 fail:0 skip:1 total:3
    ok 5 test_mb_free_blocks
        KTAP version 1
        # Subtest: test_mark_diskspace_used
        ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
    # test_mark_diskspace_used: pass:3 fail:0 skip:0 total:3
    ok 6 test_mark_diskspace_used
# ext4_mballoc_test: pass:6 fail:0 skip:0 total:6
# Totals: pass:16 fail:0 skip:2 total:18
ok 1 ext4_mballoc_test
    KTAP version 1
    # Subtest: ext4_inode_test
    # module: ext4_inode_test
    1..1
        KTAP version 1
        # Subtest: inode_test_xtimestamp_decoding
        ok 1 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
        ok 2 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
        ok 3 1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits
        ok 4 2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits
        ok 5 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on
        ok 6 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on
        ok 7 2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on
        ok 8 2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on
        ok 9 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on
        ok 10 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on
        ok 11 2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on
        ok 12 2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on
        ok 13 2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns
        ok 14 2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns
        ok 15 2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on
        ok 16 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on
    # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
    ok 1 inode_test_xtimestamp_decoding
# Totals: pass:16 fail:0 skip:0 total:16
ok 2 ext4_inode_test
[18:39:57] Elapsed time: 14.400s total, 2.940s configuring, 11.343s building, 0.074s running

Kemeng Shi (5):
  ext4: Add unit test for test_free_blocks_simple
  ext4: Add unit test of ext4_mb_generate_buddy
  ext4: Add unit test for mb_mark_used
  ext4: Add unit test for mb_free_blocks
  ext4: Add unit test for ext4_mb_mark_diskspace_used

 fs/ext4/mballoc-test.c | 502 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 502 insertions(+)

-- 
2.30.0


