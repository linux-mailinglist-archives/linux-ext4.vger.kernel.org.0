Return-Path: <linux-ext4+bounces-6945-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CC4A6C778
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 04:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4901896668
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 03:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3031482F2;
	Sat, 22 Mar 2025 03:37:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FACA12D758
	for <linux-ext4@vger.kernel.org>; Sat, 22 Mar 2025 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614619; cv=none; b=ASWDkZ5tLC693z4E/Nvxcb4BdlZBT429bYBoS4AReHpQml93/X6WBLoGwqTsVE/HJ2I5v/M2oxmta1LgOzc9VlBTjNplE88bBpCSEdnzAnDdDbnTw42pTdSMTs7HbPZIRkGWGYV2X0fNmXVjajFRJA0fiHdPvDP/nyc8CgL8KZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614619; c=relaxed/simple;
	bh=9WdwlONds9AwiYBhY7fdJ9jErqwt6qjAMS1lVKzFY44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OX2kDQiK7rVAzq5JptwHq2pOgQQVQC/7boagJ4kHAo23+PgWAe92fUMr5aEQ1vC6k8BXBFkmTiflVo/aoeFLRMvHGvR4SUMs2Dv3CNWG9z8NsYxONE9pwSGP56wNewCPYfnixvZZkEVu+QYXK6iSpsvfWUGDZY4lljKHkTGg2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aMJu007704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:23 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C15532E010F; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] jbd2: add a missing data flush during file and fs synchronization
Date: Fri, 21 Mar 2025 23:36:18 -0400
Message-ID: <174261457016.1344301.7380792216760002334.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241206111327.4171337-1-yi.zhang@huaweicloud.com>
References: <20241206111327.4171337-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 06 Dec 2024 19:13:27 +0800, Zhang Yi wrote:
> When the filesystem performs file or filesystem synchronization (e.g.,
> ext4_sync_file()), it queries the journal to determine whether to flush
> the file device through jbd2_trans_will_send_data_barrier(). If the
> target transaction has not started committing, it assumes that the
> journal will submit the flush command, allowing the filesystem to bypass
> a redundant flush command. However, this assumption is not always valid.
> If the journal is not located on the filesystem device, the journal
> commit thread will not submit the flush command unless the variable
> ->t_need_data_flush is set to 1. Consequently, the flush may be missed,
> and data may be lost following a power failure or system crash, even if
> the synchronization appears to succeed.
> 
> [...]

Applied, thanks!

[1/1] jbd2: add a missing data flush during file and fs synchronization
      commit: aac45075f6d79a63ac8dff93b3e1d7053a6ba628

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

