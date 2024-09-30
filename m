Return-Path: <linux-ext4+bounces-4375-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDEA9898B5
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 02:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822611C20FD9
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 00:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3111CA9;
	Mon, 30 Sep 2024 00:50:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D1C13B
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657439; cv=none; b=gSNXaqUXCH6cQElDsugxQW0zUxoqVKZibFop766po1/3GKhiaq6EIGkhz5DdlNY6s0WAg36SC4ajs2ATir5/uE3K50qFKdVek9tBsNAM0LogpTD2KqtZO+nHgZJefM3jxg+aKr+0POjEqxoHZp7Ts28co7c9YnlOXf+8C5vpjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657439; c=relaxed/simple;
	bh=8jM80l4pgPfUCaxpJPgyW1Q/5vQWWQL+zgOrlZi7TKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i/1rkitbhy9UNRtRVE2QAorrdoygrCVOWh38E+pkhFABu2ngz/PyYPAo0PYtYJCdz543iF5ivTscmknWEbt0yNCsWxpIzQupBHRmXNa6kvJ7an8/UEPElOwZuCiAy/TzDpIV3b6OoD7CwedUPDdjPLpBaQNwnlxkew83A4YIDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XH2Y92v2qz4f3jk7
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 08:50:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CA8E31A092F
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 08:50:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnW9flmLxfsCg--.51013S4;
	Mon, 30 Sep 2024 08:50:32 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH v2 0/6] some cleanup and refactor for jbd2 journal recover
Date: Mon, 30 Sep 2024 08:59:36 +0800
Message-Id: <20240930005942.626942-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMnW9flmLxfsCg--.51013S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZF45tw18JF1DWw13CF17ZFb_yoWxCrb_Za
	92gFW8Zw4UXF1jqa4qkr4UJFW7Jr4UAr18GF4kKF4UX3s3Jw15WF1kGr4DZr1rZa4Fkrs8
	Cr15Ar18JasYvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

Diff v2 vs v1:
1. Modify the indentation problem and remove unnecessary braces in PATCH[4];
2. Add PATCH[6] to remove the 'success' parameter from the jbd2_do_replay();

Ye Bin (6):
  jbd2: remove redundant judgments for check v1 checksum
  jbd2: unified release of buffer_head in do_one_pass()
  jbd2: refactor JBD2_COMMIT_BLOCK process in do_one_pass()
  jbd2: factor out jbd2_do_replay()
  jbd2: remove useless 'block_error' variable
  jbd2: remove the 'success' parameter from the jbd2_do_replay()
    function

 fs/jbd2/recovery.c | 311 +++++++++++++++++++++------------------------
 1 file changed, 148 insertions(+), 163 deletions(-)

-- 
2.31.1


