Return-Path: <linux-ext4+bounces-1475-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD186EFC3
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Mar 2024 10:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C0284B5E
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Mar 2024 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2350614291;
	Sat,  2 Mar 2024 09:21:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1197134A1;
	Sat,  2 Mar 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709371283; cv=none; b=EWMCeCdkUWyLPZYZRZyE82GH5QsvFwD8Douq9+9FD46Grwxy5R8TIMIg6HVxXAOBytoD6JoD2HHxgkmmicAygIvh6SBJKzPd/qODUVSrVHXK51e62VsT/5NqYG6yu+dL/eIODkB6qU4TqNvqdzN6o327CRC+79TNXyb0xwGZmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709371283; c=relaxed/simple;
	bh=qdezucad5cPvzaEjmiAU3jX0Q8SyunCIEy72jkWfi5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PTeAxagwl1gSW02SMjEgTvh7BPeL7/noelLj+Dar1bT1OOEmBqwsCqMqJnAIo2JiUITutE4AM2JBv5kntPsT6HOXB8OegsDdemlsxozO3xcpdcPRZ2R85h/R5gEZu4ENTB89G/bJC6vLI312DyDUxNnFdpy5H94fLN2tOyuRvkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmzwJ4J3sz4f3lg8;
	Sat,  2 Mar 2024 17:21:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 072411A0C43;
	Sat,  2 Mar 2024 17:21:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgA3imyE7+Jld1cqFw--.52350S2;
	Sat, 02 Mar 2024 17:21:10 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org,
	linux@roeck-us.net,
	brauner@kernel.org
Subject: [PATCH v3 0/3] Fix crashes and warning in ext4 unit test
Date: Sun,  3 Mar 2024 02:17:52 +0800
Message-Id: <20240302181755.9192-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3imyE7+Jld1cqFw--.52350S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1DZF47ZFWfXry5Kr4fGrg_yoWfGrb_GF
	W8Z3s5JrWxJ3WjyFWxtryFqry8Kay2yry8ZF47JFW3GrWxZw17Aa4kGr1vy3Z8Ww45Ar9I
	q3Wvkr1fZwnFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
	Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
	8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2js
	IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUIf-PUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

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
  ext4: initialize sbi->s_freeclusters_counter before use in kunit test

 fs/ext4/mballoc-test.c | 77 ++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 17 deletions(-)

-- 
2.30.0


