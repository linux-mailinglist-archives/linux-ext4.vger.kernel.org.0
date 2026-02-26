Return-Path: <linux-ext4+bounces-14063-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK05BYJdoGm3igQAu9opvQ
	(envelope-from <linux-ext4+bounces-14063-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:49:38 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8841A7E53
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 154F330F3B4A
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ACC3D9033;
	Thu, 26 Feb 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSldUeAx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF83279DC3;
	Thu, 26 Feb 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116924; cv=none; b=Qurr/sLGqS4tF2ZrKGX3JmhS7B/28AvyZfnBhG5E/dEVuACrHMa1MIpXp4bmjYamM0Nhgrs0D6QeQCdK6j/412isWpDoaTUD1rSBgBpXsjCtGbjkxzt2PKMyTNi+9efwrAZtaIwv7HemZzbQ98iVutkiBiZAqU7YLMytVRhHlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116924; c=relaxed/simple;
	bh=H/nqtmCCJ+Q0fwzcG5GEomLy14KL0XNtpnUB0zMIE3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8vHXdIAxm/8DPqJKw4BgU9t+LlFg5/cc6VwKzDiyimL9DwNctKlz1vl+e+aplbyGUMlxgN8LtXVaTBL1pV4hL9FSEQ751RcqqEOrz5arrXJF/D1ve0+NlP5X+6r/FOQaXxSRYUZLvE7UqGmKA4BFBLG0zsGlAa//q24YiizCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSldUeAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B15C116C6;
	Thu, 26 Feb 2026 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116924;
	bh=H/nqtmCCJ+Q0fwzcG5GEomLy14KL0XNtpnUB0zMIE3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSldUeAxqqxJxNo9Zz9nWNl38O1OaROEZ3/66HxvusaOZIGsTNPfWLPPAPStJYXu+
	 KxZgXK7ti+BuKqNwosDhsYHI7glE24Z+1MT8U/dJ4O2dU++FaoOwcc9KIPmapTlxtu
	 nzZcFmOs/BMqhUUXg6ROdwbgZvZFJKnWMWq78tiGiNoHSnIw+Ha8n5AZoaWkVDeWtw
	 2Ocpz9/bv/kalC98zNpLi2UFAIVRp8TT1koq+22gUWC6+gErtc9md3TH8phaKT8cQg
	 I51P5/1mH+tEVM6uk0nKfn4W85Vtk0kDMFpPyadO+mg5Hv7Isujs5yB58hOby2WQos
	 coEm1puPBBqhw==
From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 2/9] fstests: add _mkfs_scratch_clone() helper
Date: Thu, 26 Feb 2026 22:41:43 +0800
Message-ID: <254fdd3e212f6618ea33207ef24db2b316d2d8fc.1772095513.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772095513.git.asj@kernel.org>
References: <cover.1772095513.git.asj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14063-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asj@kernel.org,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE8841A7E53
X-Rspamd-Action: no action

Introduce _mkfs_scratch_clone() to mkfs the scratch device and clone it to
the next device in SCRATCH_DEV_POOL.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/common/rc b/common/rc
index 9db8b3e88996..2253438ef0f6 100644
--- a/common/rc
+++ b/common/rc
@@ -1503,6 +1503,38 @@ _scratch_resvblks()
 	esac
 }
 
+_scratch_mkfs_sized_clone()
+{
+	local devs=($SCRATCH_DEV_POOL)
+	local scratch_data="$1"
+	local size=$(_small_fs_size_mb 128) # Smallest possible
+
+	size=$((size * 1024 * 1024))
+
+	# make sure there are two devices
+	if [ "${#devs[@]}" -ne 2 ]; then
+		_notrun "Test requires exactly 2 devices"
+	fi
+
+	case "$FSTYP" in
+	"btrfs")
+		_scratch_mkfs_sized $size
+		_scratch_mount
+		$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/sv1
+		_scratch_unmount
+		;;
+	"xfs"|"ext4")
+		_scratch_mkfs_sized $size
+		;;
+	*)
+		_notrun "fstests clone op unsupported for FS $FSTYP"
+		;;
+	esac
+
+	# clone SCRATCH_DEV devs[0] to devs[1].
+	dd if=$SCRATCH_DEV of=${devs[1]} bs=$size status=none count=1 || \
+							_fail "Clone failed"
+}
 
 # Repair scratch filesystem.  Returns 0 if the FS is good to go (either no
 # errors found or errors were fixed) and nonzero otherwise; also spits out
-- 
2.43.0


