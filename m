Return-Path: <linux-ext4+bounces-5761-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05B69F7319
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 04:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D10516B74B
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 03:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5F2153598;
	Thu, 19 Dec 2024 03:02:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E270824;
	Thu, 19 Dec 2024 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577350; cv=none; b=MAl2dG13cm4jlrlSnMDV1tXxP+d6yehmGIUJFjcjpEFiMNyo+kUdsV6oh3cdLavOvJC217/yy/XkpgBEhAo4c/N1nTVJs0JBLx206Af8Cus8Lt3lqSF8O5qxDUETt3Q0pDec0y37uxmp64RUdGOmMIi+HpnN0e+hrt7jZwSFaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577350; c=relaxed/simple;
	bh=53NhDC/InCH5IcKQ/Ok/HfaO/AYTJ3K7q4oYD1rWt7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tnQ8f9EMD6fWUm/o1B+j0VmY2JfxKdk98TlgD7ROxDf1IGzrylwHapzrxA1bmwVugSN58R1stuqKOISKZ3eVFflEAxCz8Vzmkm9Mg6vy6k9LgoFMLtRCcLF451R5M6D6zLQ6vpWvLvm63l+uzGq4dokPOSeb+SjyUCaJz3w17Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YDFhB0QF8z4f3lWG;
	Thu, 19 Dec 2024 11:02:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9DDE91A018C;
	Thu, 19 Dec 2024 11:02:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDHpMG9jGNnctd0Ew--.54838S2;
	Thu, 19 Dec 2024 11:02:22 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Fix and cleanups to ext4 namei.c
Date: Thu, 19 Dec 2024 19:00:21 +0800
Message-Id: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHpMG9jGNnctd0Ew--.54838S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4DAF1fCF1xWw4kuFy7Awb_yoWxtFc_Wa
	yxJa4DJr42qay8Wa45Kr1ftFyDGw4xGryYyF10qr43ZrnIyF1rA3WDCrWfur15WrWDCF17
	Xr17Jw18Ar47WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
	3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains a fix and some random cleanups to namei.c and
this series survives "kvm-xfstest smoke".
More details can be found in respective patches. Thanks.

Kemeng Shi (6):
  ext4: add missing brelse for bh2 in ext4_dx_add_entry
  ext4: remove unneeded bits mask in dx_get_block()
  ext4: remove unneeded forward declaration in namei.c
  ext4: remove unneeded check in get_dx_countlimit
  ext4: remove unused input "inode" in ext4_find_dest_de
  ext4: calculate rec_len of ".." with correct name length 2

 fs/ext4/ext4.h   |  3 +--
 fs/ext4/inline.c |  2 +-
 fs/ext4/namei.c  | 63 +++++++++++++-----------------------------------
 3 files changed, 19 insertions(+), 49 deletions(-)

-- 
2.30.0


