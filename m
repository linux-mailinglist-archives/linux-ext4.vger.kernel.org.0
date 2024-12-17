Return-Path: <linux-ext4+bounces-5678-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 137E99F4182
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 05:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C660D1889D39
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 04:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E3A146590;
	Tue, 17 Dec 2024 04:05:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C151411EB;
	Tue, 17 Dec 2024 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734408353; cv=none; b=eJOMiTc4lt4wJIOORWh6Yr9lPH6G/no9q1uyGFfRYUs5Ug0qPFLaIeIjCoEdQh4atcu9tXydqHpAbuBSpgmtCFigzz/xTuMXFxotoY8xKP0v965m+hYrXRibJv58HzYUNpmdD4wTEk8exxEwJR+KHYIRFR77oOsrzDfhmIgJkLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734408353; c=relaxed/simple;
	bh=QFo1x7gHDC8cT6BkmFc8xKrT4+1fX6TaiVANO3bhp9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZtsPmUHnqkkVPaP1R7ZxAEv3g8uXNLKSLtffyonjz5xDYnI9kOz0jpfWMDEQjX3KypCnxAd1RO3RYM+sItl6B3HUeGsqTIrg2GnVGaJuRocYshIDDI6bFCfiP/KXUDs+Y652mxh31kBJ4v3XxvMCNx6jfDuNKPPNhkv5XOMQEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YC3BH384Fz4f3lWD;
	Tue, 17 Dec 2024 12:05:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E59731A058E;
	Tue, 17 Dec 2024 12:05:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgB3VsOb+GBnwxC_Eg--.2804S2;
	Tue, 17 Dec 2024 12:05:47 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: dennis.lamerice@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 0/3] Minor cleanups to ext4 and jbd2
Date: Tue, 17 Dec 2024 20:03:53 +0800
Message-Id: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3VsOb+GBnwxC_Eg--.2804S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4fJF45Xr4UCr4DKry5XFb_yoWxCFX_AF
	WxtF98CrW3XF18GF129w18tF15ZrZ7Wrn0v3Z3tw48Ar1aqFs8Zw1DCrs3ur1UWr95ur15
	t3WUXrykJFn7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
	Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
	8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2js
	IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kK
	e7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
	Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j4ksgUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Patch 1 remove unused ext4 journal callback
patch 2 remove transaction->t_private_list which is only used by ext4
journal callback
Patch 3 remove unneeded forward declaration of
ext4_destroy_lazyinit_thread().

More details can be found in respective patches. Thanks.

Kemeng Shi (3):
  ext4: remove unused ext4 journal callback
  jbd2: remove unused transaction->t_private_list
  ext4: remove unneeded forward declaration

 Documentation/filesystems/journalling.rst |  2 -
 fs/ext4/ext4_jbd2.h                       | 84 -----------------------
 fs/ext4/super.c                           | 15 ----
 fs/jbd2/transaction.c                     |  1 -
 include/linux/jbd2.h                      |  6 --
 5 files changed, 108 deletions(-)

-- 
2.30.0


