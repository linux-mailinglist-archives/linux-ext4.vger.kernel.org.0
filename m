Return-Path: <linux-ext4+bounces-10056-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C53B5879C
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4279A4C2F40
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349042D46AF;
	Mon, 15 Sep 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU1bkgVd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36322C236D
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975926; cv=none; b=MH92pN0hh+u72hCPVHGANdgRqIQYRudGQvawV1G1gGlI2wCagnuCoJB+qOf8qfFsyY0IFDsLp9nPocSa2ukDCiwPEd2GNYNT87AjAfE1e0NaLFk47EDIFj/j7BQcU37K0UY6FRB8ITWErZ450opQXuKPFmM6gCdG2QpbPykTHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975926; c=relaxed/simple;
	bh=BSjIPdhqaaq4nGxK03Dd8Lrv+DFcvsPfzuGJNFm/vOQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuPF9o0xct54ZioWEgzVPPefDSCWVbbBqq3Sot60htqPcO5WA4STtePMVcLMEzwClcE0iTJdi7HhAaPmTo/phpScaVAPPDBJZwJKeCCTCb0YnNX9m/J50sZ/UC9xC+V6vSeJdLJlH3pHtLuK5M50ZyduD05SExRL/cUufBoEeWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU1bkgVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4317EC4CEF1;
	Mon, 15 Sep 2025 22:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757975926;
	bh=BSjIPdhqaaq4nGxK03Dd8Lrv+DFcvsPfzuGJNFm/vOQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lU1bkgVd924mreMF1bt7jFvI9/WLv5jR8OuKSCTS+adZ3jbEg8irgNP5Tsmi8YD4r
	 P8XSwYHBD52Pvykeswc1w0NLQ+ennechX4j5/ZWKCXhS9B9ocsdZWV6Uu86klAq8a6
	 3cYHjRqs2uS5x+tmH8eahxC0KT0xZygw9oEyKu21/aqFdeY5X8eHlHkAfE4Qc5bXxM
	 L6ZOp41FxvRSzKxqX2qkLZ8kNjxOgdkKCw12A5kxvOsDcNu52GUODWRgOOnvtuqNyu
	 9sd2RGTz7IsDOikYsc3EE0vNwHZ3alNKmX+2p/qZz8kkCcFdBNemW9cQkmYL79T0ca
	 MZFRIm+U8jOLQ==
Date: Mon, 15 Sep 2025 15:38:45 -0700
Subject: [PATCH 04/12] fuse2fs: quiet down EXT2_ET_RO_FILSYS errors
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175797569690.245695.16625825695688597417.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
References: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If an fs update fails because the ext2_filsys is opened in readonly
mode, just return EROFS and don't log that.  This prevents unnecessary
spew for norecovery mounts.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 +++
 1 file changed, 3 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cb5620c7e2ee33..4d92e1e818b1c4 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4983,6 +4983,9 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	case EXT2_ET_UNIMPLEMENTED:
 		ret = -EOPNOTSUPP;
 		break;
+	case EXT2_ET_RO_FILSYS:
+		ret = -EROFS;
+		break;
 	case EXT2_ET_MAGIC_EXT2FS_FILSYS:
 	case EXT2_ET_MAGIC_BADBLOCKS_LIST:
 	case EXT2_ET_MAGIC_BADBLOCKS_ITERATE:


