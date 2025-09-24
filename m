Return-Path: <linux-ext4+bounces-10380-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E9DB9ACF4
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 18:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BAD3203BC
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BED530B527;
	Wed, 24 Sep 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="td4CG88d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC0116D4EF
	for <linux-ext4@vger.kernel.org>; Wed, 24 Sep 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729854; cv=none; b=E1gkKCeXAE6qxVBT5NXpPMOpy1G1wqNGEEtmw6G1bzG6WmtvIUx3QHm97SxxyaX+9FQoGOjurus2AKkPRmgKYAov4j1lqF6hrNghNxKzjZQcyFbV7dYRaJN9YLQFKmpcX6AvaFGR2MON6TNKBfsEH7wpXDaPwLrbjtDWOURr7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729854; c=relaxed/simple;
	bh=+0AEV87jptcFNO9kCkbRBriHUh9w402uKL3wHfpN1oE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hbjGQD3aEAdOVHAcMIfzBGg8YzP+Rz/0EHmbJGlaRzSCHbAbr1PeyNhZLlgGkVyaqjqIEjnmmfOqHVAxmaHetG19JrdGNfi+r8BiRwNQ+8DTaqSJwcSxiSYmP7EdiI4a7RvIMDquKlrcIUNYNB2xwVnS/AFvl9KGN0LMdLHQd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=td4CG88d; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cX1qs12Ndz9tYW
	for <linux-ext4@vger.kernel.org>; Wed, 24 Sep 2025 18:04:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758729849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+0AEV87jptcFNO9kCkbRBriHUh9w402uKL3wHfpN1oE=;
	b=td4CG88dcj/ViOcXfQtP7gLV+8tMZhmYD/SY2hDXdwgBCUz0e20xNEECy9quOFZXF5pvCS
	Su6XrjDxXkS3OQIntDlf2amsDJMSB5PEgbyUwe52BT9urnV4YO3NPO5J+xv2i0WdRwMh/j
	DPEn1IJ2vAdF0XZ6FAd6aoxGZ1dkyZtcgLGnBGjW03JnqqsPrbWh9L5Hymd/LhfxfXtJWi
	o8ngsxP1z/eoXA0GPqy6fJDs2kW4UIxv6R+lWQ7Kc2LSqnXyvh/6LV9SXxzOB46HcigW0F
	Oxj1E5PWJw28vuTApsTPMdtDSR0BHeT0Qyim5wKoZqB5BiIq8MfJ0oAnhCgA4Q==
Message-ID: <51a89ced-228d-4fd0-9613-3b4d027d9162@mailbox.org>
Date: Wed, 24 Sep 2025 18:04:08 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-ext4@vger.kernel.org
From: Zeno Endemann <zeno.endemann@mailbox.org>
Subject: ext4: Question about directory entry minor hash usage (documentation
 error?)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: x5snar6pm3jj9kory5ihb4pgyx8xajoy
X-MBO-RS-ID: 1c88f8be29ae51100bb

Hello,

The documentation of hash tree directories claims that interior nodes are
"indexed by a minor hash".

However from my current understanding of the code, it seems to me the node
splitting works somewhat like regular B-trees, and there is no re-sorting
with a minor hash going on. The minor hash doesn't influence at all the
on-disk data structure, and is only used for sorting in a kernel internal
rb-tree. Is this correct? If so, I could offer to write up a patch for the
documentation.

As a side question, I was wondering a bit why the kernel differentiates
between htree-indexed dirs and others when simply iterating over it (as in
e.g. ext4_readdir), and what the point of that rb-tree there is, i.e. why one
would want to iterate over the entries in hash tree order.


Thanks and cheers,
Zeno Endemann

