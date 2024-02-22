Return-Path: <linux-ext4+bounces-1369-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD1A85FD3C
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0831B1C2553F
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5697C15099C;
	Thu, 22 Feb 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XEWO5WzO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215B154C15
	for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617313; cv=none; b=R2tN4UEZybl3x5HyLa0Wm8QIZ5y6JSWqFL8w0/H8qcBHU0weZXloPGOXe5ePjZJzhKggYHmuansMEwXA3pRh++YkrsCg4DzJ48liptLgCK1P4zKP2o0oFNGMCgJRX1H0aE+JeZyR79nVYfzTLJ8AK8h7U6AD63k1uSm2LiQbW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617313; c=relaxed/simple;
	bh=hspY6RH3t+LGEJg8cjSeq222SIA1BCVbAIFaMEKIwYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvTFy7atEmu7OtskcKzfjyG6JQo8cz6EwuHM9A/VRer7NGlVfqMfDHz9nTn6J5yjRzaPPcfMuQxQxRyvYY5zMl+l+xlNX8NJFs7LTeqMRn4EjdgHKhz8lSkdrvgwZjtna4JaraetyvwtWqkUEx+pSpG6sxsRsoYCnHSSi1uEERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XEWO5WzO; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MFsgsx030846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708617284; bh=RsU6dWPMTxtwXU+swsq0FRs5IS4Rl+7HRm70Qkf2hj8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=XEWO5WzOrJD4P3WTr+0iAwiP5oa3eULhymabj6h6MebNMwLHpWAdSYWKyawEiEvQq
	 2CNsAd78kuRrjvJ4abVjvg8IbRVuw2hhinnIteptVGNlQJw9AKeUcW0mtaek7MjwvU
	 /MAMmcab75V8BAX68+ac1soaADmqrwCs3bsQcHC4h85GohUgLqUULt0BirYZUt+vq2
	 tTVx2twSEln2ncgCn1iThhSoE7dVzopvlE9Di3HrXw13Nk/8wtyQFDrvfs0m1ohvhg
	 FXR7bfwBR1pFHv3N/3YEbD+/mWYkK4r+AVLYm1tZRdj7JrofGCEZ6notT+lia7ebBi
	 ufDYzjIl0RWgg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 42DCE15C14B5; Thu, 22 Feb 2024 10:54:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: add a hint for block bitmap corrupt state in mb_groups
Date: Thu, 22 Feb 2024 10:54:36 -0500
Message-ID: <170861726752.823885.5003769926749986066.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119061154.1525781-1-yi.zhang@huaweicloud.com>
References: <20240119061154.1525781-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 19 Jan 2024 14:11:54 +0800, Zhang Yi wrote:
> If one group is marked as block bitmap corrupted, its free blocks cannot
> be used and its free count is also deducted from the global
> sbi->s_freeclusters_counter. User might be confused about the absent
> free space because we can't query the information about corrupted block
> groups except unreliable error messages in syslog. So add a hint to show
> block bitmap corrupted groups in mb_groups.
> 
> [...]

Applied, thanks!

[1/1] ext4: add a hint for block bitmap corrupt state in mb_groups
      commit: 68ee261fb15457ecb17e3683cb4e6a4792ca5b71

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

