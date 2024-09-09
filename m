Return-Path: <linux-ext4+bounces-4087-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A39971E14
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2024 17:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAD91C2213C
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2024 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF42E634;
	Mon,  9 Sep 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="qOp3zA+2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E0200B5
	for <linux-ext4@vger.kernel.org>; Mon,  9 Sep 2024 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895928; cv=none; b=EcWGGQwq+u5BMaR9BKIFp6aj9voeUW2h/S5zwzr1xM84bS1+k9V5FE2A86wBMoAESso6edRkCPT5QBmxWloJMje9Rgy4FIkKm+PUfny0kDRbheAkAxJ4+gQTZgQvIStyIBKv0859P1GdiX5gHTZGCULR/OyWUFMSrYH0rJEa5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895928; c=relaxed/simple;
	bh=H/OuznDcPURetxXExfKkXOH6iC0YacL3g4+OVk67avM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mKZVDsHDC208U48h1WccYiJqfX94lTl8uFwrdNzQv+McvHzffe2ViIojEJrq3I/RjD00nFY5vy/jozdl+E/Lpj2fyuJsDiR3F/qMgr2gBnFbEMpOQQtgG32pkmL3XpnpHrcwoyAhTVWghQHscnlhly8oNStTIgAbD3y2WaynkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=qOp3zA+2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 489FVjnr002375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 11:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725895906; bh=MbU8vviFwnb+J+xNzSgQJCNndanStEfP4JAVpY/o0kU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=qOp3zA+28z8m/HQTDQXz64UZ8oLAKJiCmsdkPvhun8xmKHQiodmnZDs/3RWooPshZ
	 4Kvb6Wz2rIRX8qtJd4wdLDLnoaIqo+VAC2oLjsWf3sa6ASN8CLwamYAxhmSSkFJLGe
	 WZ6u11e/GU2NXYf1drXJrg1mSR7XqdDjF9SYdxssjQKtfDWmJp184oGVB7NqNoLo8N
	 Xa71WBNT8vZC9u0abtmOPy2DisXa3z8zplnH9qXJdx7XATYSSAMaQ95ZgHHYjxFTaL
	 8pFrmox1+J9nwIkjoybkR5C8YCWHrUuIeWIQO1lz8VSCklSvlIVZvjO2QXaxmvfBoF
	 Q3dhg57qIwRww==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E35FD15C19A9; Mon, 09 Sep 2024 11:31:44 -0400 (EDT)
Date: Mon, 9 Sep 2024 11:31:44 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: cve@kernel.org, linux-ext4@vger.kernel.org
Subject: CVE-2024-43898 is invalid?
Message-ID: <20240909153144.GA1510718@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I believe CVE-2024-43898 regarding "ext4: sanity check for NULL
pointer after ext4_force_shutdown" (commit id: 83f4414b8f84) may have
been issued in error.

ext4_force_shutdown() is called from FS_IOC_SHUTDOWN, which requires
root privileges.

Cheers,

						- Ted

