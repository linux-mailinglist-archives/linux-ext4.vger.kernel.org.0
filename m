Return-Path: <linux-ext4+bounces-10987-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC463BF371E
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 22:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DF118C41BE
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 20:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070182E0B5B;
	Mon, 20 Oct 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy/XtnkG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950C2DC322
	for <linux-ext4@vger.kernel.org>; Mon, 20 Oct 2025 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992012; cv=none; b=h7xLH4L1WAw0sLxJdtAaoKTcftZRlcrZXw9cMAoITKdzIlAm5gD1zC556mSK+kuzBAP+IN7HnPmrlCOGY7QJgn+iqai15GAYHvTVhIJs8jxXpHAvOc0ZuJauPep2eGh4Gw3FVNXGE/SNboqB7R7OyOB+HtEN7wFv+l12plDVcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992012; c=relaxed/simple;
	bh=yWnrsB9G032JQ4+8slSgvfG9zMCvJz2yPObczK/VTMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvL6MHkFNSC/71ALSLFHXMjEicjWXnV52mLghAJoWYTWb+lcHy83uGaqaRNZWqHcOh+dzpAfZyKV9WKL37raIgnSt5LA+QuL0GgS7kDyfcL50354PZ/L6LRH9pb5s3jKG7KVsSzVRG9lCAZmVex7NxzhhBEA9H+W9+97wmg4TX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy/XtnkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E4DC113D0;
	Mon, 20 Oct 2025 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760992012;
	bh=yWnrsB9G032JQ4+8slSgvfG9zMCvJz2yPObczK/VTMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qy/XtnkGi1uKT+mRytcq+hyymTkk7rlFgFox/UeNKQPdViSVbkqNyy8yE04/nimJ3
	 9LG4Ms5jRU9MahNvgWeCLyjob1r5dsVlinBvtmXhmmvaah/4AnO/cfsBRk+QxgV1NG
	 PzScweH7uDPZYzls7FM5PaXHotP4mP4bpkVRvf34N0BLMSFjgC8qalBO6dVRYE47Ke
	 Hy0NN1f4sIvUDBefDyBWVrp0gxCIG0Y/YCs5n+6EYQO7liJI5jql8ssuMjr/sRPfwM
	 kx7SemQawOvSqxw6SKN7bkvW8krhbddzmEJ7ohkGEUyrKjXBEfJWIR897hbl04im2I
	 eNlCriTB0maxQ==
Date: Mon, 20 Oct 2025 13:26:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 18/16] fuse2fs: make norecovery behavior consistent with the
 kernel
Message-ID: <20251020202651.GN6170@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

Amazingly, norecovery/noload on the kernel ext4 driver allows a
read-write mount even for journalled filesystems.  The one case where
mounting fails is if there's a journal and it's dirty AND you didn't
specify norecovery.  Make the fuse2fs option behave the same as the
kernel.

Also, ext2fs_run_ext3_journal doesn't explicitly check EXT2_FILE_RW
state, which means fuse2fs must do that.

Found via ext4/271.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 931e60f61e85b6..9922747728a438 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4818,6 +4818,11 @@ int main(int argc, char *argv[])
  _("Mounting read-only without recovering journal."));
 			fctx.ro = 1;
 			global_fs->flags &= ~EXT2_FLAG_RW;
+		} else if (!(global_fs->flags & EXT2_FLAG_RW)) {
+			err_printf(&fctx, "%s\n",
+ _("Cannot replay journal on read-only device."));
+			ret = 32;
+			goto out;
 		} else {
 			log_printf(&fctx, "%s\n", _("Recovering journal."));
 			err = ext2fs_run_ext3_journal(&global_fs);

