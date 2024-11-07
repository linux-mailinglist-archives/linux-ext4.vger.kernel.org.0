Return-Path: <linux-ext4+bounces-4989-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D49C09C2
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD6A1C2116F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E62141DE;
	Thu,  7 Nov 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="BS5PWJr9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF6B213ECF
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992406; cv=none; b=CFq1aCGkW9jdk175Ze0Q2AuT4intkVkNITgi/MSGfNpiSXI0q9wwS4d7d4oMD9oJYJe4ZJBYt3zDLX9tWAe//6rM3fjrWN78nCqkCEK6+H1gMyv6+HZPFMfa55V928UnRKQkupmS69x8DxfVidSJyQiWJIyN8kpYJp23VZYZZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992406; c=relaxed/simple;
	bh=HfDmPm/9M+3h/VhPhefY1twvIttQ00bPWZapWLFh5+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGIGXjy0SkbPK7DEz27T9Wni+c8tayrkqlrbnYBPFEwN4+nKEvdFpRce8bRbokAf/hn0qU4QElrn5NvilFJJ+o2FleGopmb1GTnJzMae7XpaQAvW2rLxN63S67iZaWjRIr3Na4+zg/kldFNb7BCqzwun0jl7REiG8FNE5Dw2shY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=BS5PWJr9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD6ZZ003524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992388; bh=DPxSfCJuzC681msBh4mf8NBBIC6HGVkfFdrMsq4s57E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=BS5PWJr9Kh0yMWrWCf+KbJU9daqtw0Ws9X8X4jgaQEQBA5y29Vk8USWVQS7eVxw9g
	 dqlPOT1cRDo0/DGbCZi1H1JJ+uLnjpFIFA4whfANXfsldDo0+BcSdRnU0MTzNKPwxd
	 HD/jNdWCMkps4jWN7M2QRU65CICqHX0gI6J3pUksH8rDKS2qTEmGOiHmuMoK5d6h3x
	 bPKXFPPVMlfFo2MPXhvscnwTYZIrE7YGQK3g661Ns+cpB583AmbPF2lWQwNxzXDPqK
	 ZPlk2u/ghjZ+atZxeCyfGBZQ9CS4PL6oCReAG83eSYRQQctrbiE+1TJSxdS6CYoNVK
	 U2z3Kfh6MQBbA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3E46915C02FB; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>,
        Jan Kara <jack@suse.cz>, Zorro Lang <zlang@kernel.org>,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] ext4: return error on syncfs after shutdown
Date: Thu,  7 Nov 2024 10:12:53 -0500
Message-ID: <173099237651.321265.5540960574939202041.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904084657.1062243-1-amir73il@gmail.com>
References: <20240904084657.1062243-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 04 Sep 2024 10:46:57 +0200, Amir Goldstein wrote:
> This is the logic behavior and one that we would like to verify
> using a generic fstest similar to xfs/546.
> 
> 

Applied, thanks!

[1/1] ext4: return error on syncfs after shutdown
      commit: e80597b47c4a8ed28471cc59acce850f3a401e8c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

