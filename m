Return-Path: <linux-ext4+bounces-8064-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42088ABF858
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4732950182F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3722256D;
	Wed, 21 May 2025 14:51:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4E1D63DF
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839087; cv=none; b=r0tmM959OVizqutpaGXqLgpR3yzRlpsXVqv2jEYS3oSq8mhdeRisKBco3qH2GylfbPhnK9UoVIBlKYzCLIpkO6Wl+YjHT1h4nFhhXKaYAnYFDxj+GVu90q1bTgVYqFY3YMF16H6NCrq+8PTB0c8MEcpal0ITCJGd48pxDFRjRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839087; c=relaxed/simple;
	bh=F3pOxOWdkqv1GuiY4E3o0yBfVb9LcHobehbUc8MZ+sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUxDLGRM7Wcd/EwKJX4x1CzzKQoLAtvV+Z5HUU25NZf1P+h6brESo+p7fj3A1ooJHX7I1eJFiqua/chJAxnXyq/aGYU1JW4xQBy3MF949ctW9ZXbi3dotkISK+28mg9EhaCPpqInNocHWzy5UQnIHNiLboP7AAUw8THe9wpgnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54LEpD2Y001383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:51:14 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id ACBB02E00E0; Wed, 21 May 2025 10:51:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET 1/5] fuse2fs: better logging
Date: Wed, 21 May 2025 10:51:01 -0400
Message-ID: <174783906008.866336.17894484897217205439.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
References: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 24 Apr 2025 14:38:29 -0700, Darrick J. Wong wrote:
> This series improves logging in fuse2fs by prefixing all messages with
> the name of the driver and the device; and ensures that messages are
> flusehd immediately.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> [...]

Applied, thanks!

[1/5] fuse2fs: enable runtime debugging
      commit: c4d34d7a4963c60a2e1e7ab276c6439b6f71ca05
[2/5] fuse2fs: stop aliasing stderr with ff->err_fp
      commit: 5cdebf3eebc22cb850e7ba0344379a4918ef4a1a
[3/5] fuse2fs: use error logging macro for mount errors
      commit: 348d84817d8f37ba61b4c3c6c044ae9d075cbbbf
[4/5] fuse2fs: make other logging consistent
      commit: cbbf78113ae1bbddfe5a97d436b7aba70a30b3d4
[5/5] fuse2fs: redirect all messages when FUSE2FS_LOGFILE is set
      commit: 7e651c358bfb52c51bf14b6b660b43100214b387

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

