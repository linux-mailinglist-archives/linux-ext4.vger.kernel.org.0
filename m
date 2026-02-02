Return-Path: <linux-ext4+bounces-13472-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAkfJTr3gGmxDQMAu9opvQ
	(envelope-from <linux-ext4+bounces-13472-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 20:12:58 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03430D0687
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 865D03045645
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Feb 2026 19:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87242F12C3;
	Mon,  2 Feb 2026 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+fvS69g"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB52D6407;
	Mon,  2 Feb 2026 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059505; cv=none; b=PWRPqwacxVdodiIRY1+UpNCogPNVk+pAlSpGazcLJnR/LCFxMQtJfo87NHyLtYsXtoTVM0fvWs+duiX6D26UHqx+LGbwVKQZcjPRb+tr9QD7jRx299yeiBI3mZAqWQoATcyxr3p0F1GJeid/usadmvndtCFflhRrR8Eiix4XqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059505; c=relaxed/simple;
	bh=GRjO8V+n0VKOwYpY/JYYWEdhzQFZKDhiy1K5bFYT4OU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdjJkiFcnKQOneprwHD7tkDo2EsrcUGaZQjH1t3hSNLteN8PJIvR9SrFhBSBM0xavWogefxzLi2rpSRxO2OV4H67k4alTYb5zKw1dvRRJJzREFZ4u9C8uaqzKcafLv8R7KwFZ0Cipxbk05NC8fNq3Ex2ZWQJr7eG3F/hTsWjVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+fvS69g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24B8C19422;
	Mon,  2 Feb 2026 19:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770059505;
	bh=GRjO8V+n0VKOwYpY/JYYWEdhzQFZKDhiy1K5bFYT4OU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g+fvS69g8wCjwMXZdK/ZwG3l+OZMMf00OdqnChNE8ef9cl3Ly3ljZ2DnFEHMk7b8L
	 Ym5oImCKNLabUpWXfToxswurDJ5xnE1ieECBEyWiclAeQ56hZ4qhGyi5BfyffyZ1lR
	 G869B2ZnSjXy+7YulGI988bjlduNK/vBALr63zEHP0RWDRQ00OwkcwsZlEEX8YVcFi
	 Q2NIoS3lvVWXulIQOCsvUD65f1NBdz5i9gcZ3cWxXSYNLeR9BHlfBFY18NQeXdh7Ft
	 wg5Ry+17pp24T26pDMUiOynP9G82gF5yO90OWBc0kBaxFuMhu1r3WCavOKDpBusCXu
	 lXuyhvkezOACA==
Date: Mon, 02 Feb 2026 11:11:44 -0800
Subject: [PATCH 3/3] generic/749: don't write a ton of _mread output to
 seqres.full
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org
Message-ID: <177005945334.2432878.12923613447146396794.stgit@frogsfrogsfrogs>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13472-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03430D0687
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Something went wrong with this test when testing with fuse4fs, but I
couldn't tell what because this test writes so much data to seqres.full
that it completely filled the log partition.  Most of that output was
from checks that actually succeeded, so let's reduce the amount of
logging from _mread (which passes -v) by writing to a tempfile and only
dumping the output to the .full file if something breaks.

Cc: <fstests@vger.kernel.org> # v2024.06.27
Fixes: e4a6b119e52295 ("fstests: add mmap page boundary tests")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/749 |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


diff --git a/tests/generic/749 b/tests/generic/749
index 7af019ddd7f98f..01e3eac0ff73be 100755
--- a/tests/generic/749
+++ b/tests/generic/749
@@ -163,17 +163,20 @@ do_mmap_tests()
 	new_filelen=$(_get_filesize $test_file)
 	map_len=$(_round_up_to_page_boundary $new_filelen)
 	csum_orig="$(_md5_checksum $test_file)"
-	_mread $test_file 0 $map_len >> $seqres.full  2>$tmp.err
+	_mread $test_file 0 $map_len > $tmp.out 2>$tmp.err
 	if grep -q 'Bus error' $tmp.err; then
 		failed=1
+		cat $tmp.out >> $seqres.full
 		cat $tmp.err
 		echo "Not expecting SIGBUS when reading up to page boundary"
 	fi
 
 	# This should just work
-	_mread $test_file 0 $map_len >> $seqres.full  2>$tmp.err
+	_mread $test_file 0 $map_len > $tmp.out 2>$tmp.err
 	if [[ $? -ne 0 ]]; then
 		let failed=$failed+1
+		cat $tmp.out >> $seqres.full
+		cat $tmp.err
 		echo "mmap() read up to page boundary should work"
 	fi
 
@@ -205,9 +208,11 @@ do_mmap_tests()
 	fi
 
 	# Now let's go beyond the allowed mmap() page boundary
-	_mread $test_file 0 $((map_len + 10)) $((map_len + 10)) >> $seqres.full  2>$tmp.err
+	_mread $test_file 0 $((map_len + 10)) $((map_len + 10)) > $tmp.out 2>$tmp.err
 	if ! grep -q 'Bus error' $tmp.err; then
 		let failed=$failed+1
+		cat $tmp.out >> $seqres.full
+		cat $tmp.err
 		echo "Expected SIGBUS when mmap() reading beyond page boundary"
 	fi
 


