Return-Path: <linux-ext4+bounces-9020-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DBB06BD2
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 04:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01183AD254
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 02:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC624291A;
	Wed, 16 Jul 2025 02:47:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FC19D09C;
	Wed, 16 Jul 2025 02:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752634049; cv=none; b=bgypWRcXAr6TTm9U6V64Zjz8Kgc/HHXjh0qZOCp9pNH+sd0TikfjvKkWowvil2XKbrjStW3laNP4GMsozx4j6nt/9N0lunlxAmPe0XCU/gOu1k5q8oQwe2wqmBf2PCygrc9agraXD2v4jbamTVRipyt1WOlAg73YNiBwEU2YxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752634049; c=relaxed/simple;
	bh=/F3Dg/QQ0oSdFKFXvmAUOLMpeuoI13iFLo2TzoRzjNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sw7w5LLuBpL4ynvXc00tHC0TMxsQXFuFaC3aRjrKO5EX6u3i0lghjNgirRqIan0EI4+U3Ie3f9IAFOEn/wfa2zAa8gq+yJ7Is9N/FnXbxsLh4VUjqq0Mh3XyRfIbueH9clvo2drUVhfBmz8MNrMP6dct0rzl6y0ZednVhWSD29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202507161047122672;
        Wed, 16 Jul 2025 10:47:12 +0800
Received: from localhost.localdomain.com (10.94.16.122) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 16 Jul 2025 10:47:12 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 1/1] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask
Date: Wed, 16 Jul 2025 10:44:18 +0800
Message-ID: <20250716024709.3278-1-chuguangqing@inspur.com>
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
tUid: 20257161047126f345f78e21ad49cc9b68d42d5793783
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The patch for XFS is here: https://lore.kernel.org/linux-xfs/aGIxIx6XZM-qu0iY@infradead.org/T/#t

Applied to for-next, thanks!

[1/1] xfs: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask
      commit: 9e9b46672b1daac814b384286c21fb8332a87392


