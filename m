Return-Path: <linux-ext4+bounces-6944-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70060A6C774
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 04:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB223BCC60
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 03:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68CA13A265;
	Sat, 22 Mar 2025 03:36:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D413E47B
	for <linux-ext4@vger.kernel.org>; Sat, 22 Mar 2025 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614608; cv=none; b=ps7gzcEICJXY1s40Z2eD4eMQ+mHTQUkWJcWVYCF63Vw96byqiarHGHr7DjwHi9VQf6vzhmSsZenxeg/eote4aIxldu2B2zC6JLSfIW9pxY6CVa4RrvKMymBDYkGF+nNTheIbzxMOOm88gLEWjw8ORLA/XWCdttL3MBGJ6+xT5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614608; c=relaxed/simple;
	bh=JqsvHkEtR1js2oxw1GhdUI0c2XgtruxlopFr7w7MbvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atiAmNdavJh6jlk/o3L7OvR+ks1RKgAePPzV9KSZRId7dAGUziC19M/6jbH8szlxuPHRYuvfMT5tZQ8F4daHZILvrwZCoS9pA03Kc9jH0q7yvynjdsd2iTy3H6cnXDC/qYqv0WqDeMbMg3VLjtBRMsIH09CzGEJOH9W+GhAyFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aMDI007707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:23 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BC54E2E010D; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>, Andreas Dilger <adilger@dilger.ca>,
        Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: hash: simplify kzalloc(n * 1, ...) to kzalloc(n, ...)
Date: Fri, 21 Mar 2025 23:36:16 -0400
Message-ID: <174261457016.1344301.3520847990943957158.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250316-ext4-hash-kcalloc-v2-1-2a99e93ec6e0@ethancedwards.com>
References: <20250316-ext4-hash-kcalloc-v2-1-2a99e93ec6e0@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 16 Mar 2025 01:33:59 -0400, Ethan Carter Edwards wrote:
> sizeof(char) evaluates to 1. Remove the churn.
> 
> 

Applied, thanks!

[1/1] ext4: hash: simplify kzalloc(n * 1, ...) to kzalloc(n, ...)
      commit: 1e93d6f221e7cfe5e069583a2b664e79eb361ba6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

