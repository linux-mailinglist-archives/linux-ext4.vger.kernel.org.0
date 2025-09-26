Return-Path: <linux-ext4+bounces-10448-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281FCBA541B
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC132560FDE
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF34C30F811;
	Fri, 26 Sep 2025 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JTJOdXPD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8162BE7CB
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923300; cv=none; b=aI8J7SPB362+dm/Nh512ZiHoIvVENwS5NvdvyjzADaiE6+7/mv3d52EhVqA2yGJ6IW4JvoAUPXhxYVEBCf3iDgmwV6M/i8FhBBXmYU2e/DsRqd/+xrzljE+NsmKSbQoNChkPcc9wWl6dkyp632BpAYmDtxy1eb8+tEt9VsiRWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923300; c=relaxed/simple;
	bh=xmMNky3BsGuaFTW+AbpBBTHabl0TxDKpEGXPtbE4q00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnZOOxS89fa9Ta8E8sBzVvZxEmvcskSyltGREE2oqbU5iLeqhOMtO3EILRePSLsP8JkSKKXb9LNSHZaGiE02VA9O1TxNOeqYNiGSYLjbIrUPqLoO7nxqwTJq+RIur1X96Gvl/t3kg+4ZbM68a7XlL4urzkFf6al3AeeYLbSybqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JTJOdXPD; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLlusc014762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923278; bh=xW23VKFboLPz4cdyrVtGNQ2xpjb6haOOE+FrCfcXvow=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=JTJOdXPD/YjbiCT6+y1NCFhB9whERsZUJB/gpL7/J2pcJYy9lPcelc4V6Q85lsJQM
	 Mz0XpLSOS3jyKH7I7x2AR+f9iIIJ7nc3gXN8ItMbOdJGG7cVG68NwNVS5vHKirOe06
	 5LOz+fjI0k6JE8RYcaVUSYtY5mbWaspAPzgw5KK2ChkKkNSptak8vVDlQWDH3OnpU1
	 /WTSV7RsiLQlsznOeG3G6k38BUt7OqXs9dtEmaj5e2jR5XlFvrKEkQpknLmxQKMzRg
	 Hd/Qr+xFxIiDv+65uCuuqDSdnxefuKYoHIbcz1hHCNYl9RL2XKBHxE16sj5ktUn/j+
	 wfXBZShZx/QYg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id EDDC82E00E4; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Julian Sun <sunjunchao@bytedance.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.com, yi.zhang@huawei.com
Subject: Re: [PATCH] jbd2: Increase IO priority of checkpoint.
Date: Fri, 26 Sep 2025 17:47:45 -0400
Message-ID: <175892300641.128029.17950430609494970727.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825125339.1368799-1-sunjunchao@bytedance.com>
References: <20250825125339.1368799-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 25 Aug 2025 20:53:39 +0800, Julian Sun wrote:
> In commit 6a3afb6ac6df ("jbd2: increase the journal IO's priority"),
> the priority of IOs initiated by jbd2 has been raised, exempting them
> from WBT throttling.
> Checkpoint is also a crucial operation of jbd2. While no serious issues
> have been observed so far, it should still be reasonable to exempt
> checkpoint from WBT throttling.
> 
> [...]

Applied, thanks!

[1/1] jbd2: Increase IO priority of checkpoint.
      commit: 0f3b05c12158ec7545fb336469ccce38c31c7f9f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

