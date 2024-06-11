Return-Path: <linux-ext4+bounces-2851-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB24B903EB3
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jun 2024 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D161F234B3
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jun 2024 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717A17D898;
	Tue, 11 Jun 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UeAZo699"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE1317CA17
	for <linux-ext4@vger.kernel.org>; Tue, 11 Jun 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116043; cv=none; b=qlhQQ9OdroFB45A1rXUVZHN6wB55lWNjxqzJMdVk/4Phq15hvD3nTLR5gXs8KEIewd54Vrv9ObOr4NMMC4W1CLP3+hyw+EHT3YYKPCCA2tJjIDyrvq6mLprHyYkrghWCNSrImmpqhm/15ZgrhMiyfnLdPWIxMJ1YW2g1ZERLNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116043; c=relaxed/simple;
	bh=xQyi8x7XM6VeovpVDfhOGm0eR1PhSRVEsz1IpofzP0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dh67vpQ+pYgcKU13ch9aJk+1+LrSCr0vn06WMKkVuROi7IThv+jrGiGkwcApYYOQit0uEsEcYarhZE4fA2JAkvZUtV8uCxtNezbmDXS2dJcpaSBOCOEi/Ki09SU1BVL+JQjDwncYAvsVnNt58yKAZ75KDlP+I3MGvdDNbeQwm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UeAZo699; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: luis.henriques@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718116039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=If8+HtHtn91wWn82XIuz1y8GVldm8f6n22eLx1qHatI=;
	b=UeAZo699GIqXenoAEMN01idW+vVoNeOCBpy3q0ogFUis0LdaOeYI4cBLBK/+G4w0j9J9Z8
	GkOgqvvzZztKbZIcMGQFwHGxZrqbhd6mKKNyLHtEKrXD+/vZx5WvR4qMfPoVzLd33hJTxR
	fCkuzWEuGm8fFZsjBo6H1RCAf+Mh+hA=
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: linux-ext4@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 1/2] e2fsck: don't skip checks if the orphan file is present in the filesystem
Date: Tue, 11 Jun 2024 15:27:03 +0100
Message-ID: <20240611142704.14307-2-luis.henriques@linux.dev>
In-Reply-To: <20240611142704.14307-1-luis.henriques@linux.dev>
References: <20240611142704.14307-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the filesystem supports the orphan file feature and that file is present
then don't skip the filesystem checks as that file may need to be cleaned
up.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 e2fsck/unix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index de20b216dde0..7768f0ed7c4e 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -371,6 +371,10 @@ static void check_if_skip(e2fsck_t ctx)
 	if (ctx->options & E2F_OPT_JOURNAL_ONLY)
 		goto skip;
 
+	if (ext2fs_has_feature_orphan_file(fs->super) &&
+	    ext2fs_has_feature_orphan_present(fs->super))
+		return;
+
 	lastcheck = ext2fs_get_tstamp(sb, s_lastcheck);
 	if (lastcheck > ctx->now)
 		lastcheck -= ctx->time_fudge;

