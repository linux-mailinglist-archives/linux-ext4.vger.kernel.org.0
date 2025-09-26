Return-Path: <linux-ext4+bounces-10438-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C5BA53E5
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5106E1C009B3
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D41C28BAB1;
	Fri, 26 Sep 2025 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pQBbs9YR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CC8286894
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923282; cv=none; b=ARwqmH88r62g2kanShGOB7B8D4LVBJNRdm5aJ9/SjH82Xqu+vF+l07oztqpVSTEcWvT3+JZiqnLBpjdsPGVeDV8hnF/6884cq5ApyVUR1KOGsJp1nvGP7cQI/HsFQyYcBWviJdwveF8wKy/xD8s6nA7WTXHvkbIqFp1DIAr2lSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923282; c=relaxed/simple;
	bh=5oG4t0nfrm9fFwvjD36mzMEZQbeSsVBao177LpOvaKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Er4OGjA7RIIWig1NekChcrF1oQT7HetMC8iqxWq4hCk/YNdM03kmfFYK3LyjhgcUa5Y5GZtEm+28aautH9n9g2p8uWlyYt/d688fZDOqItQDye1XKAxjZtI/jmZ7pvpZEh9mv1N4lvarDSEP5fftjRyLSNuPBcy4Y3o4djUbzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pQBbs9YR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLlsu2014694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923275; bh=OdcokRjutK0YxbkiBd/GdaZqoODTCBY5QGX9e+e4tqc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=pQBbs9YRIxk7gfJy/ygcvKbRvxCt3pYxoGwCMCXJBUK8PInRl+BmW0X+RXTYjkqNn
	 SQPoUR6Y0IpUfqPI+Ao22myS4emfUS7tBtPgQETSmnujuEWvTPYFnFcwaLiZOOVcn+
	 PM5WsT3xiHDZDHkiKK/AH/VV9j1eLJr7Nu1v2lQc4Vw3lKUisiq6+YnEWph4sH8YV0
	 Z82oIZsvhs3cMs3Lsk0n03OxzwZdsF4hazY24g2iJRsQ82zbuNzpNHXIUxjncsI2DA
	 X71Pr1o9RtooRoa7ovZVNrQj2XhTue/czuzj/X+Sjl1Yf9lGcKzigHf/g/8hMO2OxW
	 Hc4W9NqyOlHzw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D86692E00DC; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix checks for orphan inodes
Date: Fri, 26 Sep 2025 17:47:37 -0400
Message-ID: <175892300647.128029.6799624233457058163.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925123038.20264-2-jack@suse.cz>
References: <20250925123038.20264-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Sep 2025 14:30:39 +0200, Jan Kara wrote:
> When orphan file feature is enabled, inode can be tracked as orphan
> either in the standard orphan list or in the orphan file. The first can
> be tested by checking ei->i_orphan list head, the second is recorded by
> EXT4_STATE_ORPHAN_FILE inode state flag. There are several places where
> we want to check whether inode is tracked as orphan and only some of
> them properly check for both possibilities. Luckily the consequences are
> mostly minor, the worst that can happen is that we track an inode as
> orphan although we don't need to and e2fsck then complains (resulting in
> occasional ext4/307 xfstest failures). Fix the problem by introducing a
> helper for checking whether an inode is tracked as orphan and use it in
> appropriate places.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix checks for orphan inodes
      commit: acf943e9768ec9d9be80982ca0ebc4bfd6b7631e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

