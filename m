Return-Path: <linux-ext4+bounces-2422-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F618C1199
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 17:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570261F21C9B
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED713C668;
	Thu,  9 May 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="edfKK++S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D33A8CB
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266887; cv=none; b=aD1euo3EcC23oVaHIaqyIco0vkUdT9xp7xxgcVWhq0IlEWXjpIfIrXTqR0R3dJ+VmRKVEIWV+d68+EJgXi3zm/moPJnPg2n7Fk0dh1CtiyV5iRAB/q1HUTbbugFh1lFw+rge552VoaMSIMXVmy93yloTeYSP16VWAtclACTHo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266887; c=relaxed/simple;
	bh=eLTb1CIfSokSC7BfmTBXqHoGvjiLXoTNq8xzJdtuQ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbk8lSBNOdEVq2rfyoQWxeAWpd3jn83MzhfPJKTjSLx1e9us1OetscgsXDs97Wylc9OZg8Ud85J2OLiiuGFkO/a5mcJfQcPxAtLnqtm/CWnAniDgebPZGWY9VK7pQRPetMw0NdWPDwQbiJfUa5w3ISmFqs3n092u4Gf8Z0+qv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=edfKK++S; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 449F1F2P032038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 11:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715266877; bh=JopNOntVXHLOtbL4JdQmIcnapJT+abtLocnM9Kqxz6g=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=edfKK++SSJtZnXyAjEEvPv9bnGTxnp1Q7WcngFZIyQCs337gnUVTMQpRSSyMRCZFo
	 im7VIewSIpHvf9v9p5k+neC6RoJwD86q8KTRwdB2AmRPPI4du0lx+w+G8f/QsTyARP
	 SN3gKZvwkyDhr8klqzpEx1NFWlMMXGSTEu2CX/duddoWS9x58jALIRz8Xwx15D5r9f
	 5FYdUu3ut5mpRZpHK/lDyj04X3f8oHuhoKMjA6YsU3Z3EaC3o9gGWlNgKPx3mcYEYL
	 /HVIRqrF2KVofj7lJv3/OQNnUdNkmVXubI31iCw55AQ9S9P7xJyzzJKBbBxX+Yfj9Y
	 IKXw9JNTmjPjQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 81B4415C026D; Thu, 09 May 2024 11:01:15 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 0/3] e2fsck: expand checking of EA inode
Date: Thu,  9 May 2024 11:01:12 -0400
Message-ID: <171526685562.3688698.12347840597640365752.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506173704.24995-1-jack@suse.cz>
References: <20240506173704.24995-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 06 May 2024 19:41:16 +0200, Jan Kara wrote:
> customer has reported that his filesystem was reporting errors from
> ext4_iget() about inode with EA_INODE_FL but e2fsck was considering the
> filesystem as clean. Indeed the EA inode checking in e2fsck is weak and
> lets through several cases of corruption related to EA inodes. This series
> adds more strict checking of EA inodes and adds e2fsck tests for them.
> 
> Honza
> 
> [...]

Applied, thanks!

[1/3] e2fsck: add more checks for ea inode consistency
      commit: 849a9e6e133a903db7b005854ec58b35dc947150
[2/3] e2fsck: add tests for EA inodes
      commit: eb01b6e22a44a26668c9f8645ca1889d67a643c1
[3/3] e2fsck: fix golden output of several tests
      commit: 7b2e837bf0eacb5c12396e994b4c7979f576019a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

