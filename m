Return-Path: <linux-ext4+bounces-3176-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4F592DE70
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 04:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A81AB22001
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 02:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FE12E7C;
	Thu, 11 Jul 2024 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EP3QsZaj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B42F46
	for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665355; cv=none; b=b/bIZ9f3BJzsoQNjDur+Yms8oaak/5eM+xHjRJBZG2iulEuDW/D9Ppck1F/WnnIQOZGfrUG96KDsmjV2WQWpQKCOzWJmsJlWP2lzigUuKgASwnHDvMKm3wSZJkKV1aQCCsRVtVmIRBmwZr6Qal28Rfnl8sEqBjXjRtRj9CKVvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665355; c=relaxed/simple;
	bh=gGMvOD3ReLy6EirhCvuS4kswxiUyi48TXhm/4fk2UKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvbqpJTilihu8gIr08uYYXcCNiLvFrurPIGWzu/Mo1JqKdGESZdGNM35lVytsq5/7jw/vU/qpJy+1QyEcN/P8i0G0IDFL2cXHw5E5OU/5LsmT6LiBwAnJypW9S4/O0KXe7I0kObzx+OG3UokT7jBuranQXOOg/VRzKudLvGqCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=EP3QsZaj; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2ZfvO025371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665343; bh=PMlBRc40M6ath2f+MKit3uOxN7nDPEB47vzVSU2u9Fw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=EP3QsZaj3ErMRetkoJUQDrNwTEyR4X/RtqXicMj5WLwHjTpiafYw5wjZFSzoWN01G
	 XxnqRj5AuIM57RgWKMgK1jMwGOvdAXjUM5ZqOnm+GzFfK013S6Umhx8aq9YkO0prHT
	 TTkHulFLeOs10V2M66G6LNsYyXJgYodlP8mTmxP5DuYRZiReFDuX54mh6RCRH3bY40
	 USZDen4eaBgSF8EBysLX89ljFymKt/EiTe5a2EdW2YpQLgKvt3IUmB+4EnVwytIHww
	 JeBR/gQyfojY9TqYZ9rt+J8Z7BgQsigrSmZOplwdE1FTPJPN64kW82B2tJcMjY8F8t
	 2+NR+49O77rKQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C804915C18BD; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] jbd2: Increase maximum transaction size
Date: Wed, 10 Jul 2024 22:35:28 -0400
Message-ID: <172066485818.400039.6335659106550128846.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701132800.7158-1-jack@suse.cz>
References: <20240701132800.7158-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 01 Jul 2024 15:28:00 +0200, Jan Kara wrote:
> Originally, we were quite conservative in limiting maximum transaction
> size to a quarter of the journal because we were not accounting
> transaction descriptor and revoke blocks. These days we do properly
> account them and reserve space for them from the total transaction
> credits. Thus there's no need to be so conservative and we can increase
> the maximum transaction size to one third of the journal (even half
> should work fine in principle but the performance will likely suffer in
> that case). This also fixes failures to grow filesystems with tiny
> journals.
> 
> [...]

Applied, thanks!

[1/1] jbd2: Increase maximum transaction size
      commit: a794c9ad026f0a28044347f31929fcdb0270eadc

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

