Return-Path: <linux-ext4+bounces-4684-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96529A95AA
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 03:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A3C1F21C19
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 01:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A5D136345;
	Tue, 22 Oct 2024 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="P2lTV3Hr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2985C47
	for <linux-ext4@vger.kernel.org>; Tue, 22 Oct 2024 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561685; cv=none; b=mepi8iTH5UTOGOmtB6C2NOt0bMxlfGU2MmJOKwca18kWB3WV3BxVNlDbGMCbtw66H/7AurQKIc3io91IYHE6Nq1MPgOvO8C4U5hT8Hhm4SUfldSsELP50JQbi1aa5IWouJDG+DSVkohGz1xCA4T06L+V0aFv6PTvx+RY7DY6LKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561685; c=relaxed/simple;
	bh=HrLFNJXtSHB0n+GPoO3sxyglx2EYVkIV8xZB7FUQVL0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HcimLlyl5Zqf4wZkr/x/+D5v/lQWOojydmXguizY9dljUeLenynkJr0C5+Sew+wzJXSS15WCB9W1WMbp3lY5+ZXMsbL/UtVmAvgLLfPlL1+fhCgaC7/ysPKKj+BlDqAW5jQ1WE8Bnu+OEuGBk+ZYp/+px17mi+MOAwVwWlRbnyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=P2lTV3Hr; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49M1lgjY024273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 21:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729561664; bh=OnXsjt0K+JUjAm/vOpRYkRCPD1Un2eei+2NpSJBVGzg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=P2lTV3HrPvLYD2KT5KKZfE9lGezfir99az8b8Yyh34v4kyPTBaLHsEkDYpsQ7ZAyE
	 +7hZzIAOOVEp20P3NEzRK54NaLcBkdWuXU87dW9qc2rz76waIigL0z1H9v62KIJzCY
	 bNtqJLrMBpoGuBymb/WoJpBztFpcbmPPaT9iWTEnI1nmG/+yrUCtkFwNEkQZ444xvR
	 xHh2lqPfOwVz7meB7xJxDYO60svz8Y2ObDidC8nItCiXzlkcD2BIYhVqClNzrSZ8Im
	 X9SVQA2rDjbPkeHzxO0g3iyzmCigbo5Il9vUXEqx3W2OL/HHBpph+ox7nPQ/jz8vaB
	 pKeB/XaZB0wjg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 90C4315C02DB; Mon, 21 Oct 2024 21:47:42 -0400 (EDT)
Date: Mon, 21 Oct 2024 21:47:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Is fsmap supposed to use open or closed intervals?
Message-ID: <20241022014742.GA3570993@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was debugging ext4's failure with the new test generic/365, which
was testing the regressions fixed by commits 68415b349f3f ("xfs: Fix
the owner setting issue for rmap query in xfs fsmap") and ca6448aed4f1
("xfs: Fix missing interval for missing_owner in xfs fsmap").  It
appears that ext4 has a similar bug, but then when I started looking
at how XFS handles fsmap, it's a bit unclear whether the intervals
queried are supposed to be open, closed, or half-open.

Looking at how 6.11-rc4's xfs handles fsmap, these two results seem to
be a bit contradictory:

root@kvm-xfstests:~# xfs_io -i -c "fsmap -d 104 127" /vdd
        0: 254:48 [104..126]: free space 23

OK, so it looks like fsmap returns the half-open interval [104 127).

But then I tried this:

root@kvm-xfstests:~# xfs_io -i -c "fsmap -d 104 128" /vdd
        0: 254:48 [104..127]: free space 24
        1: 254:48 [128..191]: inodes 64

and the fact that this query returns the region between [128, 191] is
surprising.

Is this a bug?  Is it OK if we expand the interval and return more
blocks than what the application program queried?

Thanks,

						- Ted

