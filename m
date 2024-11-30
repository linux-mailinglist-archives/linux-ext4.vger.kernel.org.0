Return-Path: <linux-ext4+bounces-5441-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE63C9DEDFD
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Nov 2024 02:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CEC163700
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Nov 2024 01:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5162E433D9;
	Sat, 30 Nov 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="C2dRaMaY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28AA2572
	for <linux-ext4@vger.kernel.org>; Sat, 30 Nov 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732930612; cv=none; b=owX+LmjriYwaoNzOH0WAIgv2OGpP6BYzolbC3mtOnjmfiLVJd/PSriqSFACete6cZrsSyB2JAMzObFnM5CmTeRYPQ+d9iQkb/JZG+QyJ6yCoYqYxB2yMvX/rQhCBIJY0SkE+X+P7TpL5C1rINfWqX7426PYg032lTZi3H2n1stI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732930612; c=relaxed/simple;
	bh=OLqIdcVSBQacXVId8P8rC2lvDHimtPR3p1oCF4FP4ZE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nOhB4C0yJ9VQVGPikxONdzdI13GmVOUtLwuS/DsBGLA6yujCH7xlJBCD4PeSyvhANvdm+OsWNV3fmJ5BMCm9HGHhvvxElrietsyfJEKUgef7nHB+/eodn+vimq1dtUGtYmapEGb4grmP4IsSD6Y2NX9YLsSHBNdt8iJk8bc2RQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=C2dRaMaY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-132.bstnma.fios.verizon.net [173.48.113.132])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AU1YT8C008808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 20:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1732930470; bh=duIPOAUqlrJ8h1s+wzlZ78T9YB7/umAZyxIE4me4UGM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=C2dRaMaYULmfvhdthQPpFAOGEaxrSRoxMqQwj3CCm8FJq4+kok+fLOUQ3gj71wnGj
	 zU3Cc/tiXr+WMDZ0uhSeW74Oczl4nFWxqj1+DwDR4YqvTpDgs536v8HL8XM1O8fXYY
	 Nom/XjdioLGRTb0v1IVwtR0eQzTJDPdouOz4ovM9LGBeC51BGhJ4fA8Af1uCGozlto
	 tk1uFJRiTAtV+f45AYWE+4vNGPt5IdDn9ior3BGz0PLKHHMmsxoS730s/7DyRCHqfO
	 IasEjS8OPDUe2Q6suyQvR9vwfZGjph3pkqT6OpBQr5CYXSX6IT6LYCWBet9kO2n9lg
	 s791AMfpZ0EWw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0B63815C035D; Fri, 29 Nov 2024 20:34:29 -0500 (EST)
Date: Fri, 29 Nov 2024 20:34:29 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Release candidate for e2fsprogs 1.47.2 is available
Message-ID: <20241130013429.GA812025@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

There is a release candidate for e2fsprogs 1.47.2 available at:

https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/testing/v1.47.2-rc1/e2fsprogs-1.47.2-rc1.tar.gz

It is also uploaded to Debian unstable, for folks who want to try that out.

A known issue is that f_clear_orphan_file is failing on s390x,
powerpc, and ppc64 which is why Debian packages haven't been built on
those architectures:

    https://buildd.debian.org/status/package.php?p=e2fsprogs

Please give it a try, and let me know if you run into any other
problems.

Many thanks!!

					- Ted

