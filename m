Return-Path: <linux-ext4+bounces-13471-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMk3BA73gGmxDQMAu9opvQ
	(envelope-from <linux-ext4+bounces-13471-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 20:12:14 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66865D0677
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 20:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92B8E3026C1D
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Feb 2026 19:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C895F2F2910;
	Mon,  2 Feb 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr8ouqnf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF82E0926;
	Mon,  2 Feb 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059489; cv=none; b=T2ikKB8ZLyciJ4z2MJdg8X0lzQ3gtW1BH9NACwFZQT31bHQLb2EP+7nHPN+0kH9CsZli9SS++jCHVuo8kYd8dIDv4sh9qZWD5Msf4qYuIkSlL489pum47fpRP+lmRXPOwBjFCnCaHvBcefgz2mGYBaWHSGxRq54H9wXIvMDl7+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059489; c=relaxed/simple;
	bh=5F/Jampyew1Z72XbR9tm2SF44ID4dzX17OlHAYwTSdA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuyluw7LIPnh7paM1f6uGD+9Z+PMVjF623DBnDPr62bz1mZgOGRllLRRnbd/57bAbY+yC9FlNzRYJbALfpCfBeOClg4UIGu3uKbux/4ImR5QmRX6XetAuxmo6jYO3S89q+YGgAAB1Rs3iSLlDrnbB61c7PH9rxSy1xLWASa5gCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr8ouqnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFBDC116C6;
	Mon,  2 Feb 2026 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770059489;
	bh=5F/Jampyew1Z72XbR9tm2SF44ID4dzX17OlHAYwTSdA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Lr8ouqnfyFZUNiD+GcCwj6LBYL5izTEs3wYrvL2n8YwcGYX3DFbRCi3+t9/WUMuzJ
	 PJtu2PvNnO8y/YD1u+Ho0q/bLA6FQIDeR3F84Si1/d0T9494VI+U5dIFDovneThW4e
	 cH+cbYhO/tPKD7eGWtat1ATsTquclq3i+YJIW5iiaXEWSFr2fGWqQBpZdVDG03Esq9
	 nEn5wuihR5FL3c2GCkS1gTtX2CstuOlKzj74O5eki2R3FEkigDy3ZMoDhojmYXICgD
	 t2Rknd/Sf7Fc2Wrbe7f1PSsRU2812lo3E3cJxbQR1BPuvEUqVSY8jat/2vgdMWK52y
	 ZxpdaXF80ViHw==
Date: Mon, 02 Feb 2026 11:11:28 -0800
Subject: [PATCH 2/3] xfs/620: force xattr leaf format for this test
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Message-ID: <177005945316.2432878.12756542407523044780.stgit@frogsfrogsfrogs>
In-Reply-To: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
References: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13471-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66865D0677
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Now that the kernel's parent pointer update code skips the attr intent
mechanism when the attr fork is in local/shortform format, we need to
bloat the attr fork to force the slow path for error injection testing.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/xfs/620 |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


diff --git a/tests/xfs/620 b/tests/xfs/620
index 42a30630f50ac0..47e042b937eb9c 100755
--- a/tests/xfs/620
+++ b/tests/xfs/620
@@ -55,8 +55,11 @@ file5="file5"
 
 echo ""
 
-# Create files
-touch $SCRATCH_MNT/$testfolder1/$file4
+# Create a file with a 53k xattr to force the attr structure out of short
+# format.  Parent pointer operations on a shortform attr structure can skip the
+# attr intent mechanism and therefore do not trigger the larp knob.
+truncate -s 53535 $SCRATCH_MNT/$testfolder1/$file4
+$ATTR_PROG -s x $SCRATCH_MNT/$testfolder1/$file4 < $SCRATCH_MNT/$testfolder1/$file4 &>/dev/null
 _xfs_verify_parent "$testfolder1" "$file4" "$testfolder1/$file4"
 
 # Inject error


