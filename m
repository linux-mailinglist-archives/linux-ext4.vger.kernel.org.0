Return-Path: <linux-ext4+bounces-9018-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E92B06BA8
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 04:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9554B1AA2115
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 02:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C37264A90;
	Wed, 16 Jul 2025 02:28:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308E2E36EF;
	Wed, 16 Jul 2025 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632919; cv=none; b=ctj9YXk3DJ4Ssjl1ylJagEeXrl2Ooc1jm5t1HZRF3oEYKzPU5cnanRsR5BaRq/8IkggxyiXcIQ+Ziv3pwW+BN00NUG12cF3zwKpgltH12jzTnnd6CwbzuvWVzrnT2JpsSEekalVd0F5VeDg2lIMdwjAcmC+c3SS2K9GMNvvAm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632919; c=relaxed/simple;
	bh=N94MnelSWIW5KrTN26FeYZRRE15xGNOMXTUzcvBbdL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2IQLQDaHxUHEHYkDTh1so7zoDhw1JrsKjSfYS6oqg3CTgUXi3+1rxvdwZiaGlkBI03ACgPLhM/49MqggAjehQ7PX2Oc8dMEf3wUa1bd4i9HE0VCqU6eWXNuYQ21t+tA65HJ7yBI9yN1i9DGx5+nDjkoG61RCIxR7digYJ9kd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202507161028286375;
        Wed, 16 Jul 2025 10:28:28 +0800
Received: from localhost.localdomain.com (10.94.16.122) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 16 Jul 2025 10:28:27 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH v2 0/1] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask
Date: Wed, 16 Jul 2025 10:28:21 +0800
Message-ID: <20250716022822.2434-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250715123454.GD74698@mit.edu>
References: <20250715123454.GD74698@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20257161028287df23f6db77d3ad58643993247594124
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The original patch had a spelling mistake. I re-sent a new version (V2) earlier, but perhaps you missed it. 
I encountered a compilation error today.
[auto build test ERROR on next-20250714] [cannot apply to tytso-ext4/dev v6.16-rc6 v6.16-rc5 v6.16-rc4 linus/master v6.16-rc6]
Here's the updated patch marked as V2 for clarity.

chuguangqing (1):
  ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask

 fs/ext4/extents.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.5


