Return-Path: <linux-ext4+bounces-8404-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9674AAD7FF7
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 03:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDCF1E1E3D
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B161C6FF9;
	Fri, 13 Jun 2025 01:06:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209AA1AA786
	for <linux-ext4@vger.kernel.org>; Fri, 13 Jun 2025 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776785; cv=none; b=IQAwRjeNPw22gP++lokkRh77BjTnQPRMxiUnS16R89XVW6yBbSAilC7rckQPScu9ZtN9QGZ7K+HGaTHouEt4kFpX2X/qx4n63rXvXU2XVlhQRg5aJnyrH/20wJQSzhBfz3qjoEHNiALfI8Ns8VcTsHHKN7Gss8SQ0IqYD7Kik20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776785; c=relaxed/simple;
	bh=DdFC6ZXC0lCkkoU/JQ0yTMhEX03ltjRPhEpdi7ImDso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNxGtBCIJg6aAmqqWHhh96gO51DC63ghFJDE2GVuL9g68i8M+ArNO4zTlHY/0zjFemVj4/6wEl6bVgseBK7CQP+FAzZf7CCvGxN4N+WjTGnx+Vq+aQ/ZyG6A8naq4OzZg+pkYuoWCBa2p2CUDgpg4BqVzDYZcIWgV00GFaERwP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([191.96.150.107])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55D168Gr027211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 21:06:11 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id C54C8346B48; Thu, 12 Jun 2025 21:06:05 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        debianbugs@woodall.me.uk
Subject: Re: [PATCHSET] fuse2fs: more bug fixes
Date: Thu, 12 Jun 2025 22:36:02 -0230
Message-ID: <174977674052.1531931.15024877953419438142.b4-ty@mit.edu>
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

[1/3] libext2fs: fix spurious warnings from fallocate
      commit: 459efa346874a11b4911809e75d6eee157792ca5
[2/3] fuse2fs: fix error bailout in op_create
      commit: 9f6d1bf3bbf16cef4a08b67894c827059dd401a8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

