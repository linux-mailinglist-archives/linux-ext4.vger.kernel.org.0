Return-Path: <linux-ext4+bounces-3180-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F0B92DE78
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 04:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DBA28414B
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 02:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA82208A1;
	Thu, 11 Jul 2024 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NU4aV/bT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF5815E8C
	for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665360; cv=none; b=NwwdZXz8EKW1xsom1FlMQbDRjaQlQllpLomatJGb764+j+JqqvyxUlW0ztS2pJakh/WOxtFBQUgQzxyLitzoNRvuPCMTtsZjLZqDV6yDEXMWDyrk5StOQQiituopLi285Q8mbMe0FtaBeIELjx8AvOFixq6Pk0ewlbniK9jzoS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665360; c=relaxed/simple;
	bh=zi+E5I+G6GZSiFh7YNemUXCiMlfPc0opBO7tG+NtCDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3xbXU9rbpkCQxQBuq2L6zgntK+v4K9cx2OT6ikp/jmGi6/Kxn3nOLCJC5xTm3sT+8SB3bIbgw+e0AIagQwGu9DKbGCdIIK2jiYvu+1ez40kYBOp5bX3sQu4UUEDgNlimAPzNH4QUMXcReM+8JsWI4iCQN/4F7Wu9gqpsjhodcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NU4aV/bT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2ZfD0025369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665343; bh=H5LjYlxK8pLcRFuX1WDYrEwmsyjOAfcf5KEdy43E0LA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=NU4aV/bTov6sAOPC7SAh68y4I+parOICkN7hXfCAXEmSmNBdruErDOEogzhbkWuBf
	 aDHNL/NHwPxraIqThHGmK8+X+coRB+MJbKG+N0zkdJrDr8652CvRiCXUGTOGEFG+bB
	 2BCRvuR0e+ryDjVcYYabS7sgX+Gc9pG2dN3STP+JeVe81b26swyG0a/Gx8HN3x6lO4
	 rR70morplVj8/fxXBOfZwn3Gnn14XCHZc9ZHcJNtjIPBREjVKRy6DCKxluAIzXNcNu
	 OagxTTQwrOYXnZM0LhNFGtzaHSNdQHBPoQoVar/eAnjbuVy6mTZc66VZGztacNAKCS
	 vMLrDoucWQoCw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C688915C0250; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] ext4: Avoid writing unitialized memory to disk in EA inodes
Date: Wed, 10 Jul 2024 22:35:27 -0400
Message-ID: <172066485816.400039.12241862277216436676.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613150234.25176-1-jack@suse.cz>
References: <20240613150234.25176-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 13 Jun 2024 17:02:34 +0200, Jan Kara wrote:
> If the extended attribute size is not a multiple of block size, the last
> block in the EA inode will have uninitialized tail which will get
> written to disk. We will never expose the data to userspace but still
> this is not a good practice so just zero out the tail of the block as it
> isn't going to cause a noticeable performance overhead.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: Avoid writing unitialized memory to disk in EA inodes
      commit: 65121eff3e4c8c90f8126debf3c369228691c591

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

