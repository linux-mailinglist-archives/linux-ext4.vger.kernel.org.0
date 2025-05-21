Return-Path: <linux-ext4+bounces-8067-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A83ABF859
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7ED50188B
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52FB22257E;
	Wed, 21 May 2025 14:51:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D031EB18A
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839087; cv=none; b=cZZ64mQM7lBKCCexxwTHLTqyQ5w38eebxaUWrsMLOLJ2Djx3UPlrWpR6cmh0bAdyieZ8JKS7+VwAEU4m/qnf2UJaQ6B2Rj02ZCcS6nfOVYRn39uMvV2XX/M49MSinAtfdDaL6kmVZy2oBZHgYxgBvMulgtDiKH4OCj22u2v57Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839087; c=relaxed/simple;
	bh=jsANpF/o+MeONomysi2zAwcr5dafPdNS1ZS7RXl5brw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsVB1mIoOTgt63k0WNM0K4JsR434V7+AQ/8uga4m3AoeThWrc9u0Q2/obhw1zM5S0gZaLLelT79YMt8g0mC9Z4FQz+ugVhbVpOlWkdG8vVn8C10Z6dhLNavMeSiuRUMAovEVHqBz09uLvJNuEoakbGQHjoJ/Fc/k+i3pVj2kfqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54LEpDg9001384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:51:14 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id AA29D2E00DE; Wed, 21 May 2025 10:51:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] debugfs: byteswap dirsearch dirent buf on big endian systems
Date: Wed, 21 May 2025 10:51:00 -0400
Message-ID: <174783906007.866336.14071698242251268337.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250123135211.575895-1-bfoster@redhat.com>
References: <20250123135211.575895-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 Jan 2025 08:52:11 -0500, Brian Foster wrote:
> fstests test ext4/048 fails on big endian systems due to broken
> debugfs dirsearch functionality. On an s390x system and 4k block
> size, the dirsearch command seems to hang indefinitely. On the same
> system with a 1k block size, the command fails to locate an existing
> entry and causes the test to fail due to unexpected results.
> 
> The cause of the dirsearch failure is lack of byte swapping of the
> on-disk (little endian) dirent buffer before attempting to iterate
> entries in the given block. This leads to garbage record and name
> length values, for example. To resolve this problem, byte swap the
> directory buffer on big endian systems.
> 
> [...]

Applied, thanks!

[1/1] debugfs: byteswap dirsearch dirent buf on big endian systems
      commit: 4be42019388d76c933e3b2ea80284aaf5b8eaecb

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

