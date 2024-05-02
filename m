Return-Path: <linux-ext4+bounces-2264-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06748B9CE7
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2024 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913361F248BA
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2024 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DFF153BD1;
	Thu,  2 May 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="M7sU3oSX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E76153800
	for <linux-ext4@vger.kernel.org>; Thu,  2 May 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661661; cv=none; b=LOiWkzCJBco7IN6TeTmh/+KIIGUCRPFGOm2v3ncwPNl8ECCZh/mxFKMxLXiQZjwgSerWl0NL+/XDJ7ssD8FDfFL43EJuC177lzdRKzz35EJMOg8ozs1j48ZU7H4l4GAwxHNDcdYgCd+fR8WG5ri0AkCRJfxLBjPJOOc4RUSFEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661661; c=relaxed/simple;
	bh=OaW31qptMjA9bhBKnFUvOwMMG3sEYZNZJ0eZydOX4dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRNiEw92o8dYu9eoINDI5jeOgPfMlocrM/r3VfEsZjb3iS6CRGGaBSky4UTnKW5GMsi3N+XlrKNipqrILi148YtoezVOk/+XaNTiKCIxN3L1kqzXd9No+2A4YInyIV979whrWe/5p+Jyhlwg/HOjjDmf287+kaOr8QCQvpbvHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=M7sU3oSX; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 442Es7cM001670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 10:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714661651; bh=bpdiTxn4cY7rUmkakPzNGP9RmxQ9dkHRORP+u9bct2g=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=M7sU3oSXh2ROzvhJlb177GgRr+7hHhB9dJuDgoIdpQHy12jaKF6uPjD0TXJKyo8zB
	 U4UXka81xfvhJbL/yg7Z+fzMqyxinHU6E101c1KPGo92U6eeSlYRlbfshgj3pNo2mS
	 F+JAzYkxmNDBnj0dTOE0AOAoRbh5OaiMw6qVYiSGZmmOnRzWzmRCjH95xBSCRGaEJY
	 dm2dFQhzEDk38y9OVH6ZCE3HPXEALSOUvrjiRcXj/fYMmILc98lWA2Yf3u9zzzFGGK
	 9mq/FVq7Wm5tMMejd73+gSyF7Qujc4tXTW4+KpzFtuyeVg8Em7e3THM6l4rXPeIXF3
	 nhTyHiOWBUqOQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6093715C02BB; Thu,  2 May 2024 10:54:07 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] ext4: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
Date: Thu,  2 May 2024 10:54:04 -0400
Message-ID: <171466162130.2959204.6437256169207302775.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e5797bb597219a49043e53e4e90aa494b97dc328.1709215665.git.ritesh.list@gmail.com>
References: <e5797bb597219a49043e53e4e90aa494b97dc328.1709215665.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 29 Feb 2024 19:54:12 +0530, Ritesh Harjani (IBM) wrote:
> Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
> systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
> wiring up a dummy direct_IO method to indicate support for direct I/O.
> 
> 

Applied, thanks!

[1/2] ext4: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
      commit: a0c7cce824a54dbb83bb722df19f1ddcfa5f8d25

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

