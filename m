Return-Path: <linux-ext4+bounces-10880-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD26BDC327
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 04:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88E0B4E2864
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 02:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078F30C349;
	Wed, 15 Oct 2025 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="W4SAvpiO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1172F533E
	for <linux-ext4@vger.kernel.org>; Wed, 15 Oct 2025 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496299; cv=none; b=H5cjJDul23qFDMLNiz4QylaCH/LgDLzGV1LOo2wHdHfZdSvI2aZIKF4scODKegdqDQNj75RMh6pLbeNu7Pi3TxJiOxnQ31YJmunWIBF03yKoxZzRghON8TaNJAvweyld62AjwD+BkhpA0spUINP0SJyvd/BbxaGiULkbG8K7hxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496299; c=relaxed/simple;
	bh=hotXs0HfjrLYtwfElOiQiZVTCjwBl+li5cVHPaaH6iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cE1BW1UewoLlvCFzjfM04QtB6mId3wX8EtqdymVhbivQ2dNzqKw8acN0va5WXrPeNRYzZO0vq2zgR/fsSNA8z3QSupr4cxcdKUS7C8LKC5NYc6ZH0A24r4UsoAkWKUvxpkFtG99HovPQscIXVF837Bps5Fp3wf1lPWNSIBs0n30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=W4SAvpiO; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59F2iJje021701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 22:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760496262; bh=HSZUZqUidfGPeZv6bNytBwx9TuCfBssnC7oW+Iqnm/k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=W4SAvpiO3rWMSukCq5t+6JBOFWUkSQUcx/UHkFy480gQScQeMz+D9+Isl4shXme5F
	 aEJkzB9bkPkHavzpBncCrrQMjTJZIqDT0oZn2CYuOqe9G77hxHOZMXqvsAYFTMK5jG
	 bMYLUzgya1w2lXRn5/UEGNygJcuJPUcMnlpjXRKqW6W0aWx78QQpjqhe3JEQFKiX61
	 BLzcoAvpyfUQER0Enzljth6MnKwSjYkZycbXDjbHkTXBUEoGrdPtMs1yfEITSFC1yG
	 Zm/+KBwlvt6UhlcKI0fse8igrt07AZTmtzDNhXuN3fO921denLQZKdYIjpb021/E/P
	 VdIut9iUmr4ow==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 41EA82E00DB; Tue, 14 Oct 2025 22:44:19 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com, Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 0/2] ext4: fix an data corruption issue in nojournal mode
Date: Tue, 14 Oct 2025 22:44:14 -0400
Message-ID: <176049624800.779602.13091975049465790858.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916093337.3161016-1-yi.zhang@huaweicloud.com>
References: <20250916093337.3161016-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 16 Sep 2025 17:33:35 +0800, Zhang Yi wrote:
> This series fixes an data corruption issue reported by Gao Xiang in
> nojournal mode. The problem is happened after a metadata block is freed,
> it can be immediately reallocated as a data block. However, the metadata
> on this block may still be in the process of being written back, which
> means the new data in this block could potentially be overwritten by the
> stale metadata and trigger a data corruption issue. Please see below
> discussion with Jan for more details:
> 
> [...]

Applied, thanks!

[1/2] jbd2: ensure that all ongoing I/O complete before freeing blocks
      commit: 3c652c3a71de1d30d72dc82c3bead8deb48eb749
[2/2] ext4: wait for ongoing I/O to complete before freeing blocks
      commit: 328a782cb138029182e521c08f50eb1587db955d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

