Return-Path: <linux-ext4+bounces-1448-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5009186D9F4
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 04:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6072846A8
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 03:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A7042067;
	Fri,  1 Mar 2024 03:11:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB53FE55;
	Fri,  1 Mar 2024 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709262696; cv=none; b=nOTA1eqmUeZ6FnFZAV4VEutmiDieI3kZVkpzUI15jJz76h71CkocSZ3UJqIxj7Z0DY1ZExleOrosHoMGf3rL+I04LPSJc/PPk7EjpmsVmWPUZwtOuE2VmjYo+gpx2DVRCnkyOG6nMPB2poF2wzetHoUiB3Lx2lXAcbq69EZBU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709262696; c=relaxed/simple;
	bh=cs3vPNCzJkJq2gL2qtrcrkhMvdlQb2I5E8lcE+Zp6pw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NHztcF2EDvNgSeGld7fkMEHgRysHjKkmCUemfr+k3GQoi953+jq7ksZIVPIvoDfpVu9+GUiwel8kCSe9D5s81guN7dcKVKiy5iokKT8tRILd7vvRQBevKwBQJnBN2rQQQwOwORBs1vI5a65T7cw0nYcBY9+c1tMslm7aEy/RaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmCmB01pYz4f3m78;
	Fri,  1 Mar 2024 11:11:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5D7401A07FA;
	Fri,  1 Mar 2024 11:11:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgD3SGtfR+FlBJ6mFg--.42023S2;
	Fri, 01 Mar 2024 11:11:27 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org,
	linux@roeck-us.net,
	brauner@kernel.org
Subject: [PATCH 0/2] Fix crashes in ext4 unit test
Date: Fri,  1 Mar 2024 20:08:14 +0800
Message-Id: <20240301120816.22581-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3SGtfR+FlBJ6mFg--.42023S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGw1DAF1DJF13Jr45CryUKFg_yoW8JFWruo
	WftF1jqr4ktr4DJ3s29rs8AFZ8CwnrG3WxXr45u3WfJ3yYkrZFvay2qay3Ja98tw47tFyU
	ta43tFW3AFs7ua4rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYb7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8Xw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j
	6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j7NVkUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Previously, the new mballoc unit tests are only tested by running
"./tools/testing/kunit/kunit.py run ..." in which case only rare configs
are enabled.
This series fixes the reported issue and changes are tested with and
without kunit_tool [1].

Result with kunit_tool:
./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig --raw_output
[17:40:24] Configuring KUnit Kernel ...
[17:40:24] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make ARCH=um O=.kunit --jobs=88
[17:40:28] Starting KUnit Kernel (1/1)...
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
[17:40:28] Elapsed time: 3.990s total, 0.001s configuring, 3.823s building, 0.123s running


Result without kunit_tool (built-in):
Mar  1 18:24:36 localhost kernel: [    5.260386] KTAP version 1
Mar  1 18:24:36 localhost kernel: [    5.260558] 1..2
Mar  1 18:24:36 localhost kernel: [    5.261225]     KTAP version 1
Mar  1 18:24:36 localhost kernel: [    5.261387]     # Subtest: ext4_mballoc_test
Mar  1 18:24:36 localhost kernel: [    5.261581]     # module: ext4
Mar  1 18:24:36 localhost kernel: [    5.261583]     1..6
Mar  1 18:24:36 localhost kernel: [    5.261886]         KTAP version 1
Mar  1 18:24:36 localhost kernel: [    5.262050]         # Subtest: test_new_blocks_simple
Mar  1 18:24:36 localhost kernel: [    5.262409]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.263342]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.264334]         ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.264664]     # test_new_blocks_simple: pass:3 fail:0 skip:0 total:3
Mar  1 18:24:36 localhost kernel: [    5.264669]     ok 1 test_new_blocks_simple
Mar  1 18:24:36 localhost kernel: [    5.264893]         KTAP version 1
Mar  1 18:24:36 localhost kernel: [    5.265230]         # Subtest: test_free_blocks_simple
Mar  1 18:24:36 localhost kernel: [    5.265552]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.266451]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.267183]         ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.267508]     # test_free_blocks_simple: pass:3 fail:0 skip:0 total:3
Mar  1 18:24:36 localhost kernel: [    5.267510]     ok 2 test_free_blocks_simple
Mar  1 18:24:36 localhost kernel: [    5.267748]         KTAP version 1
Mar  1 18:24:36 localhost kernel: [    5.268087]         # Subtest: test_mb_generate_buddy
Mar  1 18:24:36 localhost kernel: [    5.268493]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.269542]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.270824]         ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.271287]     # test_mb_generate_buddy: pass:3 fail:0 skip:0 total:3
Mar  1 18:24:36 localhost kernel: [    5.271288]     ok 3 test_mb_generate_buddy
Mar  1 18:24:36 localhost kernel: [    5.271512]         KTAP version 1
Mar  1 18:24:36 localhost kernel: [    5.271873]         # Subtest: test_mb_mark_used
Mar  1 18:24:36 localhost kernel: [    5.272194]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.273105]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.273855]         ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64#012 # SKIP blocksize exceeds pagesize
Mar  1 18:24:36 localhost kernel: [    5.273857]     # test_mb_mark_used: pass:2 fail:0 skip:1 total:3
Mar  1 18:24:36 localhost kernel: [    5.274306]     ok 4 test_mb_mark_used
Mar  1 18:24:36 localhost kernel: [    5.274526]         KTAP version 1
Mar  1 18:24:36 localhost kernel: [    5.274863]         # Subtest: test_mb_free_blocks
Mar  1 18:24:36 localhost kernel: [    5.275146]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.275935]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.276706]         ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64#012 # SKIP blocksize exceeds pagesize
Mar  1 18:24:36 localhost kernel: [    5.276708]     # test_mb_free_blocks: pass:2 fail:0 skip:1 total:3
Mar  1 18:24:36 localhost kernel: [    5.277155]     ok 5 test_mb_free_blocks
Mar  1 18:24:36 localhost kernel: [    5.277370]         KTAP version 1
Mar  1 18:24:36 localhost kernel: [    5.277711]         # Subtest: test_mark_diskspace_used
Mar  1 18:24:36 localhost kernel: [    5.277936]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.278825]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.279712]         ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
Mar  1 18:24:36 localhost kernel: [    5.280039]     # test_mark_diskspace_used: pass:3 fail:0 skip:0 total:3
Mar  1 18:24:36 localhost kernel: [    5.280041]     ok 6 test_mark_diskspace_used
Mar  1 18:24:36 localhost kernel: [    5.280262] # ext4_mballoc_test: pass:6 fail:0 skip:0 total:6
Mar  1 18:24:36 localhost kernel: [    5.280438] # Totals: pass:16 fail:0 skip:2 total:18
Mar  1 18:24:36 localhost kernel: [    5.280661] ok 1 ext4_mballoc_test
Mar  1 18:24:36 localhost kernel: [    5.281017]     KTAP version 1
Mar  1 18:24:36 localhost kernel: [    5.281168]     # Subtest: ext4_inode_test
Mar  1 18:24:36 localhost kernel: [    5.281347]     # module: ext4_inode_test
Mar  1 18:24:36 localhost kernel: [    5.281349]     1..1
Mar  1 18:24:36 localhost kernel: [    5.281698]         KTAP version 1
Mar  1 18:24:36 localhost kernel: [    5.281863]         # Subtest: inode_test_xtimestamp_decoding
Mar  1 18:24:36 localhost kernel: [    5.282082]         ok 1 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
Mar  1 18:24:36 localhost kernel: [    5.282463]         ok 2 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
Mar  1 18:24:36 localhost kernel: [    5.282936]         ok 3 1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits
Mar  1 18:24:36 localhost kernel: [    5.283425]         ok 4 2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits
Mar  1 18:24:36 localhost kernel: [    5.283909]         ok 5 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on
Mar  1 18:24:36 localhost kernel: [    5.284398]         ok 6 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on
Mar  1 18:24:36 localhost kernel: [    5.284895]         ok 7 2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on
Mar  1 18:24:36 localhost kernel: [    5.285360]         ok 8 2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on
Mar  1 18:24:36 localhost kernel: [    5.285849]         ok 9 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on
Mar  1 18:24:36 localhost kernel: [    5.286307]         ok 10 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on
Mar  1 18:24:36 localhost kernel: [    5.287497]         ok 11 2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on
Mar  1 18:24:36 localhost kernel: [    5.288002]         ok 12 2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on
Mar  1 18:24:36 localhost kernel: [    5.288469]         ok 13 2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns
Mar  1 18:24:36 localhost kernel: [    5.288971]         ok 14 2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns
Mar  1 18:24:36 localhost kernel: [    5.289479]         ok 15 2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on
Mar  1 18:24:36 localhost kernel: [    5.290023]         ok 16 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on
Mar  1 18:24:36 localhost kernel: [    5.290326]     # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
Mar  1 18:24:36 localhost kernel: [    5.290651]     ok 1 inode_test_xtimestamp_decoding
Mar  1 18:24:36 localhost kernel: [    5.290930] # Totals: pass:16 fail:0 skip:0 total:16
Mar  1 18:24:36 localhost kernel: [    5.291123] ok 2 ext4_inode_test

[1] https://docs.kernel.org/dev-tools/kunit/run_manual.html

Kemeng Shi (2):
  ext4: alloc test super block from sget
  ext4: hold group lock in ext4 kunit test

 fs/ext4/mballoc-test.c | 55 ++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 15 deletions(-)

-- 
2.30.0


