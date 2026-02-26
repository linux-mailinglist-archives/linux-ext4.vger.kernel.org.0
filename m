Return-Path: <linux-ext4+bounces-14062-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIK3FWddoGm3igQAu9opvQ
	(envelope-from <linux-ext4+bounces-14062-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:49:11 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E70891A7E16
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7207030C9884
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C993D7D64;
	Thu, 26 Feb 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGl5jDk4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F73D3CE5;
	Thu, 26 Feb 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116923; cv=none; b=YLhfSfjFNWAdvatZMWfh6K4Uuxuk8eL7B7xNvdYJ83IixLM3wAGYCopVWak3eKFxAsLN2Dqqf5j+e/T0ZD3YoBAkd0pN83+8UuQq986yr/CrThMqXgubh4VKrKhF65qs7N+TU68phlPesK90xTl7o2kU2C/a1/u76n+Qp1cy+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116923; c=relaxed/simple;
	bh=baTYamRuAKpIdQOrHW78YSXw8bc/YChuG27OL7s8lFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euO8OydXX1K8OybQ2MLnYj4dons+jhPW5m4Il1dHDLhROCNnfMYCxmzm/W7Q/I/pZIyAjSPHXZm6rucYw0qXHuxSdCjrIK2mRa3t+6iiP60lUcyrqTsk8lKHwv/OoZ1hYYZI8ZON8OoXUqqxH8y2EYNjV160WKbOnOpvOmgWhBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGl5jDk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25960C19422;
	Thu, 26 Feb 2026 14:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116923;
	bh=baTYamRuAKpIdQOrHW78YSXw8bc/YChuG27OL7s8lFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGl5jDk4YOcQX0h+xL8oP1MOKUSbLcrCTKNPRHWeqAdR9DmhDvmiJ4PL4tVT86IOI
	 RUqBmQ/5RK/aTz9XUoLDXz3ils5ndtIFMter/RWQ81RVeeGW8b2vrf1LW09gcAqH+3
	 //U3128Z5cAVJmbTfnF4OJMgbte9WDnU/00Xtcu1xSYovdnznQGAYwU4DoOwSDbJYI
	 o5iLBHXX2g+c2oVvhw8piMG+RuDTHYrfvdVihsmEg0XebHazKaXkQjCH6XjkDX72BB
	 wRVpnfCPOuc69154UcRmhWqdV87/YeRz8HK0wkJeHGzeNUm+621nVQRS31+lSDXanp
	 oga3h90C/+QKQ==
From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 1/9] fstests: allow SCRATCH_DEV_POOL for non-Btrfs filesystems
Date: Thu, 26 Feb 2026 22:41:42 +0800
Message-ID: <9dd001e84a8f78be3be7c8b539f3d17e5eb8c981.1772095513.git.asj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14062-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E70891A7E16
X-Rspamd-Action: no action

Tests for cloned device verification should pass on Btrfs, XFS, and ext4.
We need 2 scratch devices, allow SCRATCH_DEV_POOL for other FSs.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/common/rc b/common/rc
index 92cb69820311..9db8b3e88996 100644
--- a/common/rc
+++ b/common/rc
@@ -3990,18 +3990,9 @@ _require_scratch_dev_pool()
 		ndevs=$1
 	fi
 
-	# btrfs test case needs ndevs or more scratch_dev_pool; other FS not sure
-	# so fail it
-	case $FSTYP in
-	btrfs)
-		if [ "`echo $SCRATCH_DEV_POOL|wc -w`" -lt $ndevs ]; then
-			_notrun "btrfs and this test needs $ndevs or more disks in SCRATCH_DEV_POOL"
-		fi
-	;;
-	*)
-		_notrun "dev_pool is not supported by fstype \"$FSTYP\""
-	;;
-	esac
+	if [ "`echo $SCRATCH_DEV_POOL|wc -w`" -lt $ndevs ]; then
+		_notrun "This test needs $ndevs or more disks in SCRATCH_DEV_POOL"
+	fi
 
 	for i in $SCRATCH_DEV_POOL; do
 		if [ "`_is_block_dev "$i"`" = "" ]; then
-- 
2.43.0


