Return-Path: <linux-ext4+bounces-9021-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B7B06BDF
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 05:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484587A750E
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BC9277C95;
	Wed, 16 Jul 2025 03:04:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E3522F;
	Wed, 16 Jul 2025 03:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635080; cv=none; b=Y81fAveAmNCUTdUEK4h1Jv39S0H0mVNVqgxWnzj9MqbKb5ZZqFBPKtaoGahv3jJE4nnw33WsotVdvbSn1W9jD0Guv27LhgwkQ1lF6Z5DHGsjzqPRxnYMKgMLanBZ0xEty38Sf2JL9jCAIXGCLbMvD9JNoLRPrCyaTSrLsxhdnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635080; c=relaxed/simple;
	bh=LicT5uMNHYj1ctswD2li1Oithk1FARPRNqpkCCe9New=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvcsETC9R06S8cuQwKxWfpNmjMmh5Vq+GP12SblhOQznFSQyw72odpA6Zu5NoTNq63Key8f79eWNe8cnv+BebWd5B9NXO2pYvTQThTChhwYOAC0IQuyi4zE4koqp4Jb817+b4AOz0JhCSkP644C2vm581XgL504t4xoMl19BauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202507161104318591;
        Wed, 16 Jul 2025 11:04:31 +0800
Received: from localhost.localdomain.com (10.94.16.122) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 16 Jul 2025 11:04:30 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	Zhang Yi <yi.zhang@huawei.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH v3 0/1] Re: Re: [PATCH 1/1] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask
Date: Wed, 16 Jul 2025 11:04:19 +0800
Message-ID: <20250716030420.4528-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <f42f9a79-75cf-491e-bf46-5ea036cf6656@huawei.com>
References: <f42f9a79-75cf-491e-bf46-5ea036cf6656@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025716110431a453d0ef0ad267a7348acff09a1b4606
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

> Why did you remove the FALLOC_FL_WRITE_ZEROES support?

It's missing FALLOC_FL_WRITE_ZEROES. tks for a lot.

chuguangqing (1):
  ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask

 fs/ext4/extents.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.5


