Return-Path: <linux-ext4+bounces-9006-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC38B05065
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 06:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AC54A7D29
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 04:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4AF2D29D9;
	Tue, 15 Jul 2025 04:39:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CFA1F418B;
	Tue, 15 Jul 2025 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752554378; cv=none; b=QZStP5lDBgDRT0xDCBUnhLmR9sE6ABzgEOC1+GqTKJB856G6UVKEsAPbmQiSPYlM39fbkPVi+O1kDRuh/+bCl0J7UOROZjk1M1uPOXAb6qTmp9JTaKAnrILAuK0t3h/h9lVjFT6QDQLtG545Acbv7wg/uS8sXXhFQj/3cnCfLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752554378; c=relaxed/simple;
	bh=DobzWGBFs0STjXLqElYZFbvuGKos5OfHW4xHHXaTJhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuDBMTleaw+2SLJKdg+sSA8CRKUd8hDlD7tZ025Zq46n3FMFdVgt91bGVHvl68YaDAWnFd0YjU8/ao+kJl/uPnBZDMH0z3VBh66Vkv+dF8lPyDtV+KG3WzWKT5S8XnV0sascr7TwczhkdNOn84ZXdA0aIAdouy553qTl/gD0lKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202507151239246108;
        Tue, 15 Jul 2025 12:39:24 +0800
Received: from localhost.localdomain.com (10.94.4.253) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 15 Jul 2025 12:39:23 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 0/1] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask
Date: Tue, 15 Jul 2025 12:37:25 +0800
Message-ID: <20250715043808.5808-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250715031531.1693-1-chuguangqing@inspur.com>
References: <20250715031531.1693-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025715123924e3ca70ad28ab49c99074a6eec41f0c9b
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


