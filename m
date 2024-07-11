Return-Path: <linux-ext4+bounces-3182-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5120C92DE7B
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 04:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D9EB22073
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 02:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2435A0F4;
	Thu, 11 Jul 2024 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ETIszyY/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6C1C686
	for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665361; cv=none; b=KfI1R3l64zpIkd5HArA/+WU00twlnmQOmkLaRU49DeeJ9xctnrp9HapToXEZoKbxVisGajwI7Ob7j58xNCQj+Z3g7uUqE8XepSB3EERiNJKoBYtQbTX4KZyKZV72TSl4mgQMeQtfqKcBcdIyn+4I6AWzW/tbT4Zkt+S12bs6tS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665361; c=relaxed/simple;
	bh=1dHhu94C0jLKjmfCKwMet6G1U9zke2O5eJGIO8iX9bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyjWjzKeL5jWnapPoxxy7L2323G755RZDKY/H75TbNtgRAJmyrTtNlIF4SV3Yw+fkEM7ZW2hG9g/POpn/JVjlrSN98i5+C2JyOliZ5z00PWGbFbO8yVRB7UeY4tVZiadKDI6ZsUi7+vtVqH+aWpuzlWnXb/z8dQW9uvndx2Mw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ETIszyY/; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2Zfmq025370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665344; bh=8vKzLzNuAVoA//3qb4BWd8KRFow1wUUznoZUJyN2WD0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ETIszyY/uH3UYNKCJOxtAHp4ZX643TebaPYCgP3oaSM9Upz+yxzUkDgPYJHoTHzLN
	 ToDWeECiSOrypRTppqKOnH7YlvK4pgS1wsg+CvITS4M+HGmnXhJMiob5Cwy8AKACoL
	 fuFAq8UMWQ1p20KJ/zUHSiT9BiuNqkRL9quueBjS3XvWe/0T6rrSixY+5pMeZ/7eqV
	 ZfiIx7bdjQ45ctcjuOLsG3+7stOkMzpJ4nJmn4pP1ZLX8KPxB0G+38gczQfQwOrOun
	 6AI0QI2gTcA/vvPil3h7pvwRfHCUtIWBWm1Qn1uYwsgc9BGZ6UxiOEd4j2hdUGCgRp
	 Snk6ZeSDGfQTQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CE0A315C18CF; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ben Hutchings <ben@decadent.org.uk>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: don't track ranges in fast_commit if inode has inlined data
Date: Wed, 10 Jul 2024 22:35:31 -0400
Message-ID: <172066485815.400039.14789389889049658262.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618144312.17786-1-luis.henriques@linux.dev>
References: <20240618144312.17786-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 18 Jun 2024 15:43:12 +0100, Luis Henriques (SUSE) wrote:
> When fast-commit needs to track ranges, it has to handle inodes that have
> inlined data in a different way because ext4_fc_write_inode_data(), in the
> actual commit path, will attempt to map the required blocks for the range.
> However, inodes that have inlined data will have it's data stored in
> inode->i_block and, eventually, in the extended attribute space.
> 
> Unfortunately, because fast commit doesn't currently support extended
> attributes, the solution is to mark this commit as ineligible.
> 
> [...]

Applied, thanks!

[1/1] ext4: don't track ranges in fast_commit if inode has inlined data
      commit: 7882b0187bbeb647967a7b5998ce4ad26ef68a9a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

