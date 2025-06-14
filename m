Return-Path: <linux-ext4+bounces-8421-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BABAD9E8A
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Jun 2025 19:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE88017529D
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Jun 2025 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460C2D9EFF;
	Sat, 14 Jun 2025 17:36:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042AA1C54AF
	for <linux-ext4@vger.kernel.org>; Sat, 14 Jun 2025 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749922566; cv=none; b=B4vil1OhQK8JS5rMn49KdXxVKhdRAA49jPk7ijPC8xU+htSJ+vmcyfak+dloIhyi0gXlc8mUmCUpeGzKXP9NhpjJWaZT5hHiAPw6oFJEdsrj/ZTxGPKm+tlisvoSUX8QNysCbvQA0wqz8pA+P+Cp27sxJD+YyXbbctBtqSDCa6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749922566; c=relaxed/simple;
	bh=UVHfFETKJ3BLujFS5sLt8qmDlAZkcEI2ozPyK5RPyfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1bEiX9odNHCjH1yAG9iV8RdS97WzNhjfNSeGOBZIcy8nq2+Zm04thuepOa9cz902uvgXUfJ7knB1S7I0gv5UeBIuqx/U4iGODyzsOKiD2Gq/gdPKteTcMUgx5DVpXOGt/X6skQIlV/DKkKzxxbZGM493LX+uBpaCpoRedvwc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55EHZbwg017660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 13:35:38 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4CD892E00DD; Sat, 14 Jun 2025 13:35:37 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        debianbugs@woodall.me.uk
Subject: Re: [PATCHSET] fuse2fs: more bug fixes
Date: Sat, 14 Jun 2025 13:35:30 -0400
Message-ID: <174992242296.2651855.3712862846723397956.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
References: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 11 Jun 2025 09:43:39 -0700, Darrick J. Wong wrote:
> This series fixes more bugs in fuse2fs.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> Comments and questions are, as always, welcome.
> 
> [...]

Applied, thanks!

[4/3] libext2fs: fix bounding error in the extent fallocate code
      commit: 149805bf64e81de61cc027bc43e9b480c4392800

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

