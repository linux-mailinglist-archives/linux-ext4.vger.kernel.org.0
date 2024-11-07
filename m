Return-Path: <linux-ext4+bounces-4996-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD939C09D3
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 16:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FF01F22763
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D217DA9C;
	Thu,  7 Nov 2024 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fNtYKep2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D047F4A
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992545; cv=none; b=RXl84V1HEzN3dLiwFiDYtxi5y+18tvfetpowbuq1cYfg4wA1IgfvF7NFg3mUBvsykQq+kKJKrMQxjvcKr4KAobe1G/kg+qCBTlww7an8DJnuUCcb/e8kIlm5DQpSIL5ehvlB4eBnEoLMLwxd9zEebPAbBikpIFLjtmcxOS1qec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992545; c=relaxed/simple;
	bh=f53VMlD9u95v+55/gffunntgJ3OC/A8Q9e72woQmo3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDM2IuqPruwE9Lz/kUJ2OKepnC3fwFhivTlrnnz9IanH/VzWjBhe45nPlLogvlBR2ePGcthvtHdPKO+y9eDnorIUFULrbZwFEyHK7DqYABbKjoy8tUcPqYcVxI/qzppHkKeFjNqxyqTohDBVuKRgal0y2wyXiDLaYfyWE6U0lAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fNtYKep2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD8Q2003576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992391; bh=NpRVto2oJv1r9qgeFToO/9vEnPP/tQoaldlTKis7JNI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fNtYKep2oIzKI0QbVF5GbmbCv8UL4jeeHYSSFO1mOyOGVfkmjoq3uOtPkJsXaUCPK
	 yTGBQAZ3MEplk9TcRBzGxrnoaoWlR+8Uo9fMirOckuJd+TNOtIzYDl9M/Xro52Ty00
	 WoxGJxZRHkLCe4TxQApGDDWTTtPuQ9APjLwcP23PqY6T9AF5of1c4d4obrWKgrN6oh
	 VvthQb6lSQL+FISiQPO067/RIVByvDXQWCBqTh1ARDE6Nsg0wN23v09GbQU6+6yg2z
	 n6YY3pC13TTm44cx5UvAuzy7gXOPITP6iYNhOpMSJGhs95OmasyXJLwFjFBepK70G5
	 h45Odjo5gi8NQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4F03315C1C63; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH -next] ext4: don't pass full mapping flags to ext4_es_insert_extent()
Date: Thu,  7 Nov 2024 10:13:01 -0500
Message-ID: <173099237653.321265.15423417228670209283.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906061401.2980330-1-yi.zhang@huaweicloud.com>
References: <20240906061401.2980330-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 06 Sep 2024 14:14:01 +0800, Zhang Yi wrote:
> When converting a delalloc extent in ext4_es_insert_extent(), since we
> only want to pass the info of whether the quota has already been claimed
> if the allocation is a direct allocation from ext4_map_create_blocks(),
> there is no need to pass full mapping flags, so changes to just pass
> whether the EXT4_GET_BLOCKS_DELALLOC_RESERVE bit is set.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: don't pass full mapping flags to ext4_es_insert_extent()
      commit: a274f8059aa45b2af52e8b92424d53f6139a3c4e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

