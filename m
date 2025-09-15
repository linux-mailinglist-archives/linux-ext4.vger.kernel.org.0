Return-Path: <linux-ext4+bounces-10074-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6B0B587BB
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5944C2FA9
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE532D8399;
	Mon, 15 Sep 2025 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlcSndQM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BE2D7DE2
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976207; cv=none; b=E2b+nNLMRYHleoxVPh+D4z/PORE3IFSPw2XARCGXmPfJO0YWsqOXotPsJJdw7otiqg93/0qQbcTIuYMmF6usAx1EA1GvutYfgANzV5bH4WLdWrsUcLWO+3bijdOLozj0Tk4lEYcLyAlvWqr97QWjw3z2JDP2nwL/owhNlUfq75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976207; c=relaxed/simple;
	bh=5eto0JEWsQDJpveINmunwVCEdDsPyQCCXwsNyHKEDlA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwqEij2FW8CTTZEDLA2ebGOn0uztU/Tsx62fzc43LvKucrzPrSwOwmkmm4hs+OqmBvNptOHt4/0YLZBGdwbnBbSxkk9AKbEZAn7V7mpO+9ZkfK0MC5De0ikTnqJFYJDdW8p0uFdIceO85zfpLotNKesBeQhTMr7aeNHxDkCPUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlcSndQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845C9C4CEF1;
	Mon, 15 Sep 2025 22:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976207;
	bh=5eto0JEWsQDJpveINmunwVCEdDsPyQCCXwsNyHKEDlA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qlcSndQMQDRlc84yDoWKrwTGHkart8hloKyMffdrc+CEzqqTMnvxhaJXdCkRbgiVS
	 sPrEItOBIqDMuWbW3mdrZeNk5uQ43CzLyXdIDz8kw0wTKARB/ZUcBGl5vfBWvn+gnq
	 6VZueD+hut/iyZ/2M0LOu6+K7WX9f6lx9SonaHlgmQp3IHURmeUr58lfd22CLVQmKs
	 87ekmrFV4bNXhC8oJdNKqpsIC7KKD2pORq05ByxlDkBA3RmLWIJ9ZVpQdqdV4g/hzg
	 p0nxtBPfWHXTD/yhEyODKOyAN0rC5ADZHv1kZaet303DR8h1hAkeS7QJ4xYnLIMOW6
	 RxJySimU9qocg==
Date: Mon, 15 Sep 2025 15:43:27 -0700
Subject: [PATCH 10/11] fuse2fs: constrain worker thread count
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797570193.246189.18292292585216876168.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
References: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

fuse2fs isn't all that scalable -- there's a big kernel lock around all
the libext2fs code.  Constrain the fuse worker thread count to reduce
unnecessary lock contention.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 ++++++++
 1 file changed, 8 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 1f2700b5f95270..e54a2d7f9ae523 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5102,6 +5102,14 @@ int main(int argc, char *argv[])
  "-oallow_other,default_permissions,suid,dev");
 	}
 
+	/*
+	 * Since there's a Big Kernel Lock around all the libext2fs code, we
+	 * only need to start four threads -- one to decode a request, another
+	 * to do the filesystem work, a third to transmit the reply, and a
+	 * fourth to handle fuse notifications.
+	 */
+	fuse_opt_insert_arg(&args, 1, "-omax_threads=4");
+
 	if (fctx.debug) {
 		int	i;
 


