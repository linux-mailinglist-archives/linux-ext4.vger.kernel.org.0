Return-Path: <linux-ext4+bounces-11737-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7681DC48915
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 19:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FF7534A617
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D08A32AADE;
	Mon, 10 Nov 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXQN/I4e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCFA32AAB4;
	Mon, 10 Nov 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799178; cv=none; b=WpIafJhFr0ZxmdkILRdm5zo0vji8Ex/T3qFzG5pP72rLvEEWaMuSDMp+B1TU9aCXbirE8yoQJ5jjGf6B9C0v3t4daZa+jYP08BQXVilAjvH3qhMsGWPnQ9q4kz8ByXWEglFGNNSRPRQUryXUBu7aHEtf9IhrMGy94fRYa1N4mWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799178; c=relaxed/simple;
	bh=1kcYxCBwYcJF+pMVaWlRjgkvp4166ABy/fVpipYE+No=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nm8U6mZRJQq2mNW2u/HrEefM1QKKrpoiUmprYCx5pQnE332fdzInZDPa1qt9xtGnxMpmh1WPyCEbLoyvW6RN1WgmiFpXpDwFAWnVRgs/5aE2yRqe8hccHk3pA90Is7ioCeXQwy4RzhtM6oIqC9S/kGqkZ+Ge4aD3rnjrBKiWctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXQN/I4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07FBC113D0;
	Mon, 10 Nov 2025 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799177;
	bh=1kcYxCBwYcJF+pMVaWlRjgkvp4166ABy/fVpipYE+No=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hXQN/I4e6Xb2OPSV8/FRfCt9IR6E/y78uL+YjgUojuqLsjY/IKwZf8GTwbs83Yk73
	 mhPpeVeBfRcbANGanmz30fbbRW8hGZGpzYAs4PDfTdf900bnOXYFYicXXukf+1IC1x
	 PyIHpnQKNmejqOFMOVRSVl5WW83bNbv3P0HNJ5sApkDpcajp34k3+7dZc6L4Hu3yNK
	 9xVn9FUCDr7sxuwiXpeiHdve+qu4jcrC44NKRFD91LZBgd0stOiRdB3g3FjDrfmtMt
	 5zJzdfJ6HAV27vSrNQGQn+2c7Z5JY/f7YSy4FVuB8A1CRZqZ80/xX+YUJ+JrP3ZwzX
	 VjwOoR4D9Rggg==
Date: Mon, 10 Nov 2025 10:26:17 -0800
Subject: [PATCH 1/7] common: leave any breadcrumbs when _link_out_file_named
 can't find the output file
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176279909022.605950.903689908646225008.stgit@frogsfrogsfrogs>
In-Reply-To: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

_link_out_file_named is an obnoxiously complicated helper involving a
perl script embedded inside a bash subshell that does ... a lookup of
some sort involving comparing the comma-separated list in its second
argument against a comma-separated list in a config file that then maps
to an output file suffix.  I don't know what it really does.  The .cfg
file format is undocumented except for the perl script.

This is really irritating every time I have to touch any of these tests
with flexible golden outputs, and I frequently screw up the mapping.
The helper is not very helpful when you do this, because it doesn't even
try to tell you *which* suffix it found, let alone how it got there.

Fix this up so that the .full file gets some diagnostics, even if the
stdout text is "no qualified output".

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc |    1 +
 1 file changed, 1 insertion(+)


diff --git a/common/rc b/common/rc
index a10ac17746a3ca..cb91c00d24fb19 100644
--- a/common/rc
+++ b/common/rc
@@ -3825,6 +3825,7 @@ _link_out_file_named()
 		' <$seqfull.cfg)
 	rm -f $1 || _fail "_link_out_file_named: failed to remove existing output file"
 	ln -fs $(basename $1).$suffix $1 || _fail "$(basename $1).$suffix: could not setup output file"
+	test -r $1 || _fail "$(basename $1).$suffix: output file for feature set \"$2\" not found"
 }
 
 _link_out_file()


