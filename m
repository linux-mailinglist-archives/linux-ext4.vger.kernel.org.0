Return-Path: <linux-ext4+bounces-12104-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49EC98394
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 17:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B1753430C7
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDB33346BA;
	Mon,  1 Dec 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dszEWsBb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5133344D
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606249; cv=none; b=AiczAUWv74zRgps24oVPbrEAg8svf63baotE/s6OAPN8WibF1b+YHUIP+Jmb/07ARneddNgU4khPD/UO99EXXLtBDxPodB1ndujiOKjBbfXzVYk6jy8spUgOhun0LB/TJUyxACAPdG8EJznQpHf+nyEUMyW/fqGN4So+Mlp3nI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606249; c=relaxed/simple;
	bh=IaOgbXRI96Z/A5nbOuLFAk2vXr/HqzrWr8OsC7fL8Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu0aDqSrDyd4K/D9GgtyFo4foYR4xSQCLC6qvMVLQSl1nV2xraxe4j36vWDdV7NorC4dwQ5j+8O1k6yVBVaXirD9N/2Xx63XUXRPdWQVcunbWdaNbFSHM+uV4gJJ6VW6Ir+qo4JAvJXwx39ytwREt4TQXrOgGFBbXu3EhQFyMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dszEWsBb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B1GNsvG008154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 11:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764606236; bh=v9PYJ/AS1zHpSeYFSJpKi363UDMw/vXMzT2m9GD4IJI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=dszEWsBbMO6z4FyLXaCEuYPnshilj+71kY6jtJV328U0G9/BnhU6/0ySpdsi/4UYi
	 dvHus7zdsgh3ELv2pf9fI6gO8tSw+3YQnfxszzeIKrI4V/kRHQ1SpW3Ox/Fs0XfyBe
	 gOC7UwvoL5CVBCkeEvdx2WaHrmMFuOgHs49l0LHTVz+MEI4fJw8DLxSwDilWknRZJf
	 cnggOfg3x7YIwySSl7R1CC28vaknVG2nJxCNIG+OFLPU82H8nCdUlDVXhZGwUuxhzP
	 EBn/Ycdrcjonxgg01UIFno2lg9fxmQvz8timH3rMvmksIbZt4XAw79Gd+LDLiPr+Ad
	 u2fGP/Ktk8bFg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id ECCEF2E00D9; Mon, 01 Dec 2025 11:23:53 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        Daniel Tang <danielzgtg.opensource@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] Documentation: ext4: Document casefold and encrypt flags
Date: Mon,  1 Dec 2025 11:23:43 -0500
Message-ID: <176455640536.1349182.13508992419516252883.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <4506189.9SDvczpPoe@daniel-desktop3>
References: <4506189.9SDvczpPoe@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Nov 2025 09:32:13 -0500, Daniel Tang wrote:
> Based on ext4(5) and fs/ext4/ext4.h.
> 
> For INCOMPAT_ENCRYPT, it's possible to create a new filesystem with that
> flag without creating any encrypted inodes. ext4(5) says it adds
> "support" but doesn't say whether anything's actually present like
> COMPAT_RESIZE_INODE does.
> 
> [...]

Applied, thanks!

[1/1] Documentation: ext4: Document casefold and encrypt flags
      commit: 39fc6d4d3527d790f090dcb10bdb82fd1a1d925a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

