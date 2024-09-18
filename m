Return-Path: <linux-ext4+bounces-4204-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8065697BB99
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 13:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421382887FC
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE6B188A11;
	Wed, 18 Sep 2024 11:26:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E149291E
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658804; cv=none; b=KMK0qDE0ZYAfv4iz5b7gOSv0NuW8HQMyrm3KbPuWzbPRYnowV2HPUaXpEK3ZMqydRxzkKm1vE8XSvtQ+QwnNNUF+2JTgD0X59KYnJY5mfHN3qn0Za275h5n98FgfQejYkky/DJnizHzKvzYtPcdiNRprQqnCn2WvLRrC4NsFViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658804; c=relaxed/simple;
	bh=+lkiOUEBQUIJSJMgo9mINIWc4dnq/xclS2sG4Ejuc+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b3U1oyBO2JL7fuu6fUHCUXjg0wOYqPx6xvqtvs0Az9NyXh70W8hwjhoym7kvtSsoQtpQzrQ2w4lR6NJahj5BTGBcwM77WU/iCBM3UWgsH897An0X+u60gb8FaLXKA0ZQd49qWgGJzxLxusug/UktrD0UR6zGN9idwSxVqs8ZKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X7xDY4J3Bz4f3lDF
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 335561A0C11
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnsuOpmuiKqBg--.12650S4;
	Wed, 18 Sep 2024 19:26:38 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 0/5] some cleanup and refactor for jbd2 journal recover
Date: Wed, 18 Sep 2024 19:35:59 +0800
Message-Id: <20240918113604.660640-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMnsuOpmuiKqBg--.12650S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxG
	rwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
	Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	zuWJUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Ye Bin (5):
  jbd2: remove redundant judgments for check v1 checksum
  jbd2: unified release of buffer_head in do_one_pass()
  jbd2: refactor JBD2_COMMIT_BLOCK process in do_one_pass()
  jbd2: factor out jbd2_do_replay()
  jbd2: remove useless 'block_error' variable

 fs/jbd2/recovery.c | 310 +++++++++++++++++++++------------------------
 1 file changed, 146 insertions(+), 164 deletions(-)

-- 
2.31.1


