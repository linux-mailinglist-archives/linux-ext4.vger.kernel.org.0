Return-Path: <linux-ext4+bounces-12102-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A357FC9838B
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 17:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635573A2FD4
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3504333441;
	Mon,  1 Dec 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hz0h2H3Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95B37E110
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606245; cv=none; b=OAeP4vDFLhnuHrtARpjqMgIFFYNIzrqXa4WZcwlknCRZZ1x9kvlOJMuDTyL1JjXm0NRSuphvTGXe4m+pqq3aQt4tyLdIj8V7YAsgvwbV/AFuvf5o7nxw/mQSW8sbKVf6boAbhzEtFsS0980I7uDaBDOQqjHVmz8kVOiqEKj+1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606245; c=relaxed/simple;
	bh=7wArZFGbytLfyt2xIClzfm9paN+oZzGIFQqy23uG35o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEV8y5j6RJpIxoLUhL6p6BeH1/Wizu4ZtZQHQwbq3G5z4NjvQNFGWRx4FSY7n9OjUpdLRDh59/6h1X2LyP0U3S1oef8hFLjMXl5YnE7U5Xni0uu74ARe0G7ICvbF2PJ2tUTb5xfv6GSSFvBVh1V+0L2nFcTdMpQFvhFLYMU4bAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hz0h2H3Y; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B1GNs1g008161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 11:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764606235; bh=Sl/ZBi/YCSVwZbxYHzSo06Tu+Qo1rJ1g3oQKLkDomdk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=hz0h2H3YIwyxYpp1vv2HnbUpx2L3Gp+nS7dtI338o5lWvYC72SZiQEwXKWRoPZrOZ
	 npZMNL14wUhAG6n2TQILI0zV36TSm7+1OVkrRPgx5a6PptHElcJ2bdTu/IOSgt11vp
	 UQxYE8SoGu6mfHAcKGzCj+rUgH7g9Nd7aRtCltX4Arvt5I/+wz0OQLPM4k2HBtiU5C
	 sJF6gg5msmJoFV25Vnb8nEk1b/7IsfRZAXoe4lrjs+xGdtGBpvDxKGTBAeETRkR3qa
	 TMnCyT1PivcmcDWoOM0FpkxQ56/FIs0CWkAQV63PN8Shz2+s0lAOlJfpNoMj439i6h
	 IqpGRR+xB7Igw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id EF19C2E00DA; Mon, 01 Dec 2025 11:23:53 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ext4: Mark inodes without acls in __ext4_iget()
Date: Mon,  1 Dec 2025 11:23:44 -0500
Message-ID: <176455640538.1349182.13701271074420659485.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125101340.24276-2-jack@suse.cz>
References: <20251125101340.24276-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 25 Nov 2025 11:13:41 +0100, Jan Kara wrote:
> Mark inodes without acls with cache_no_acl() in __ext4_iget() so that
> path lookup can run in RCU mode from the start. This is interesting in
> particular for the case where the file owner does the lookup because in
> that case end up constantly hitting the slow path otherwise. We drop out
> from the fast path (because ACL state is unknown) but never end up calling
> check_acl() to cache ACL state.
> 
> [...]

Applied, thanks!

[1/1] ext4: Mark inodes without acls in __ext4_iget()
      commit: 91ef18b567dae84c0cea9b996d933c856e366f52

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

