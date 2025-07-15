Return-Path: <linux-ext4+bounces-9000-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363AB04E8F
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 05:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140833B11EC
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 03:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0D2D0C74;
	Tue, 15 Jul 2025 03:17:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CA80B;
	Tue, 15 Jul 2025 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752549424; cv=none; b=PTXwUQPGyUG3NA1Dq/bTD/AmlGv41IxfZLOq2i4Ct4oKC0poG6J3sQIyRlomaBN0JGK+BbUooghuTO/PTqKeQ0T/z8GnlOJuu4pm/G9lsaGie4Iis7BS2QfrGXJ0l9GJDbKZKfQf0Oma91/oB2foX4pH5XtgutF/P4tU4i0uGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752549424; c=relaxed/simple;
	bh=DobzWGBFs0STjXLqElYZFbvuGKos5OfHW4xHHXaTJhQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QRPdCmP8LN/m+fqyNdjz7oWt317WxW89X/Jics3Z0kuF1dl8pnDqoIYtnLCvNOu/sW/IbKdsvv6oSau/TBD9WtUfhl5sz9NY0yUNtErfHhLUnHt7E0weKi+2DRyODfg22W7OsaGSe6T8iJXZAso8mJJEC65y1G+1cAQlPNpmK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202507151116450026;
        Tue, 15 Jul 2025 11:16:45 +0800
Received: from localhost.localdomain.com (10.94.4.253) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 15 Jul 2025 11:16:45 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 0/1] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask
Date: Tue, 15 Jul 2025 11:15:30 +0800
Message-ID: <20250715031531.1693-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20257151116451951eae42aaa82327da64e2f2e669652
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Add FALLOC_FL_ALLOCATE_RANGE to the set of supported fallocate mode flags.
This change improves code clarity and maintains by explicitly showing 
this flag in the supported flags mask.

chuguangqing (1):
  ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask

 fs/ext4/extents.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.5


