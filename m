Return-Path: <linux-ext4+bounces-9271-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC967B1BEC2
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Aug 2025 04:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08091182403
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Aug 2025 02:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC7219DF4F;
	Wed,  6 Aug 2025 02:29:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678FE2AD32;
	Wed,  6 Aug 2025 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754447351; cv=none; b=cLVzd7Gqow167t01iFLdPXKAuI2W+NcpmlQbhzcK9tYSHH8pQlXQsL5zSf5XooR+WwlCu2ibY+XlLLeCU7wO41cZE4QdjdOJkMfbRdzB00gLs0dB3tpLQa/FFJgbQDRhW96i0BCRIe1BsPNjRIoEvB6b2qzn6Vn/Rz3oxQ6Op9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754447351; c=relaxed/simple;
	bh=aKXLaJaRhpLtF1Rz6Dx01pvmuhhnoyrFTA7T/7VBvEk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jkhV1Q2r37zvrFOI9EzXab1qZnfTaF5kgyP9VFnJx9zHIzGMBRGtmLTnWgk0dkxxdybb5lL8vi42ktMw1zRmFoneWc1t5yd9HQnkcDePsqT4hQWXfyOfIt0Nie3vdwbeWxHqCPhLyCOXAKzj+wuEygwA0tuaA+Heb1GIM0AbAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201608.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202508061028508093;
        Wed, 06 Aug 2025 10:28:50 +0800
Received: from localhost.localdomain.com (10.94.12.223) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 6 Aug 2025 10:28:51 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 0/1] fs: ext4: use GFP_KERNEL to GFP_NOFS to avoid deadlock
Date: Wed, 6 Aug 2025 10:28:48 +0800
Message-ID: <20250806022849.1415-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20258061028507a44ff7a9a47c65360a5c75886af1926
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

I noticed that in the ext4 file system code, some memory allocations use GFP_NOFS, while others still use GFP_KERNEL. The GFP_NOFS flag is used to prevent file system operations (such as writing back dirty pages) from being triggered during memory allocation, thereby avoiding circular waits when holding certain file system locks. I found functions where the parent function has already used the GFP_NOFS flag for memory allocation, but the child function still uses GFP_KERNEL for memory allocation. This will render the GFP_NOFS used by the parent function ineffective. For the identified functions, their memory allocations should be modified to use the same GFP_NOFS flag as the parent function.

chuguangqing (1):
  fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock

 fs/ext4/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.5


