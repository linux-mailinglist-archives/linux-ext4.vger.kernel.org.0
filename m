Return-Path: <linux-ext4+bounces-13607-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE0zEgJjhmlyMgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13607-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 22:54:10 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A101039A5
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 22:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D930F3008D2C
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 21:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B003128C6;
	Fri,  6 Feb 2026 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="davn8wgC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7326D4CD;
	Fri,  6 Feb 2026 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770414841; cv=none; b=p553oeRG0trBWCod9VdRaTppFZNWIz+Y03+s0pRVNbaVAuJhd597KYPDxags7+XbQp0Y8dgf2d3HyUtQQtTg54tBncjuNTzRfvrH0YORWYlKlJIs/RrJ2ya+9lHogN+5X80J2UL7rxDGhTiPGfm5Lm89UsH07j++WcvK1zF1LJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770414841; c=relaxed/simple;
	bh=h2F02Qz4bAEK41GQKS7KGtmFOs0X2EOM1L/wN7L8rls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNaw6r0pVdoZ+0rhL6dK4kBpUgZNW0t/lcX0Dhe7krGeWg/nkdh0XXn5IXdr61iLZO9uIHcnu+bA3Q8LZAMt8P6rkhykjqrIZzBSC2bgqf4wNbypSjFoZVbdmflqjvzGkVkUyMkIxbQIFgxZvbxk9jISNPYLCNqOfWekWrXWps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=davn8wgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEF0C19423;
	Fri,  6 Feb 2026 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770414841;
	bh=h2F02Qz4bAEK41GQKS7KGtmFOs0X2EOM1L/wN7L8rls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=davn8wgCDzNUVMs4MTkm8SYleHqDVxhRreSQK1lpmqlpPY5KeHbQWgcpQF63Ncypl
	 z/IM5mCmJLLy+WdnE31yLUqs9A1Lih5/1PqiCD8e2MFl+KwQqQ+4/IwVsC0nUjOOA8
	 vO2bdMutV1tzRIPfouqbVeU4BIoTgfw1hwn8nxcoS/pl8mKtEYz4+Y63jfgm22n29V
	 DsJeM7/wUtpn/j/DGFAyiE4wptLsPJ0+0caCjuDISv8troO8dMl3NWfyO2A+NR7SoF
	 fZdrzmmMnW/QOytuDRPpGx65+pM0s7scdJt/YjeaM+Vhta2+Tr9FaUpUwECcJa6v4M
	 wifstl1BN9xGQ==
Date: Fri, 6 Feb 2026 13:54:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: zlang@redhat.com
Cc: linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v1.1 1/3] xfs/018: remove inline xattr recovery tests
Message-ID: <20260206215400.GC7703@frogsfrogsfrogs>
References: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
 <177005945298.2432878.17951687824065765554.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177005945298.2432878.17951687824065765554.stgit@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13607-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60A101039A5
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

In Linux 7.0 we've changed the extended attribute update code to try to
take a shortcut for performance reasons.  Before walking through the
attr intent state machine (slow), the update will check to see if the
attr structure is in short format and will stay in that format after the
change.  If so, then the incore inode can be updated and logged, and
the update is complete (fast) in a single transaction.

(Obviously, for complex attr structures or large changes we still walk
through the intent machinery.)

However, xfs/018 tests the behavior of the "larp" error injector, which
only triggers from inside the attr intent state machine.  Therefore, the
short format tests don't actually trip the injector.  It makes no sense
to add a new larp injection callsite for the shortcut because either the
single transaction gets written to disk or it doesn't.

The golden output no longer matches because the attr update doesn't
return EIO and shut down the filesystem due to the larp injection.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v1.1: improve commit message, add rvb
---
 tests/xfs/018     |   24 ------------------------
 tests/xfs/018.out |   45 ---------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/tests/xfs/018 b/tests/xfs/018
index 8b6a3e1c508045..9b69c9cb14b33d 100755
--- a/tests/xfs/018
+++ b/tests/xfs/018
@@ -127,16 +127,6 @@ mkdir $testdir
 
 require_larp
 
-# empty, inline
-create_test_file empty_file1 0
-test_attr_replay empty_file1 "attr_name" $attr64 "s" "larp"
-test_attr_replay empty_file1 "attr_name" $attr64 "r" "larp"
-
-# empty, inline with an unaligned value
-create_test_file empty_fileX 0
-test_attr_replay empty_fileX "attr_nameX" $attr17 "s" "larp"
-test_attr_replay empty_fileX "attr_nameX" $attr17 "r" "larp"
-
 # empty, internal
 create_test_file empty_file2 0
 test_attr_replay empty_file2 "attr_name" $attr1k "s" "larp"
@@ -152,16 +142,6 @@ create_test_file empty_fileY 0
 test_attr_replay empty_fileY "attr_name" $attr32l "s" "larp"
 test_attr_replay empty_fileY "attr_name" $attr32l "r" "larp"
 
-# inline, inline
-create_test_file inline_file1 1 $attr16
-test_attr_replay inline_file1 "attr_name2" $attr64 "s" "larp"
-test_attr_replay inline_file1 "attr_name2" $attr64 "r" "larp"
-
-# inline, internal
-create_test_file inline_file2 1 $attr16
-test_attr_replay inline_file2 "attr_name2" $attr1k "s" "larp"
-test_attr_replay inline_file2 "attr_name2" $attr1k "r" "larp"
-
 # inline, remote
 create_test_file inline_file3 1 $attr16
 test_attr_replay inline_file3 "attr_name2" $attr64k "s" "larp"
@@ -195,10 +175,6 @@ create_test_file remote_file2 1 $attr64k
 test_attr_replay remote_file2 "attr_name2" $attr64k "s" "larp"
 test_attr_replay remote_file2 "attr_name2" $attr64k "r" "larp"
 
-# replace shortform with different value
-create_test_file sf_file 2 $attr64
-test_attr_replay sf_file "attr_name2" $attr16 "s" "larp"
-
 # replace leaf with different value
 create_test_file leaf_file 3 $attr1k
 test_attr_replay leaf_file "attr_name2" $attr256 "s" "larp"
diff --git a/tests/xfs/018.out b/tests/xfs/018.out
index ad8fd5266f06d0..be1d6422af65a5 100644
--- a/tests/xfs/018.out
+++ b/tests/xfs/018.out
@@ -1,26 +1,6 @@
 QA output created by 018
 *** mkfs
 *** mount FS
-attr_set: Input/output error
-Could not set "attr_name" for SCRATCH_MNT/testdir/empty_file1
-touch: cannot touch 'SCRATCH_MNT/testdir/empty_file1': Input/output error
-attr_name: e889d82dd111d6315d7b1edce2b1b30f  -
-
-attr_remove: Input/output error
-Could not remove "attr_name" for SCRATCH_MNT/testdir/empty_file1
-touch: cannot touch 'SCRATCH_MNT/testdir/empty_file1': Input/output error
-attr_name: d41d8cd98f00b204e9800998ecf8427e  -
-
-attr_set: Input/output error
-Could not set "attr_nameX" for SCRATCH_MNT/testdir/empty_fileX
-touch: cannot touch 'SCRATCH_MNT/testdir/empty_fileX': Input/output error
-attr_nameX: cb72c43fb97dd3cb4ac6ad2d9bd365e1  -
-
-attr_remove: Input/output error
-Could not remove "attr_nameX" for SCRATCH_MNT/testdir/empty_fileX
-touch: cannot touch 'SCRATCH_MNT/testdir/empty_fileX': Input/output error
-attr_nameX: d41d8cd98f00b204e9800998ecf8427e  -
-
 attr_set: Input/output error
 Could not set "attr_name" for SCRATCH_MNT/testdir/empty_file2
 touch: cannot touch 'SCRATCH_MNT/testdir/empty_file2': Input/output error
@@ -51,26 +31,6 @@ Could not remove "attr_name" for SCRATCH_MNT/testdir/empty_fileY
 touch: cannot touch 'SCRATCH_MNT/testdir/empty_fileY': Input/output error
 attr_name: d41d8cd98f00b204e9800998ecf8427e  -
 
-attr_set: Input/output error
-Could not set "attr_name2" for SCRATCH_MNT/testdir/inline_file1
-touch: cannot touch 'SCRATCH_MNT/testdir/inline_file1': Input/output error
-attr_name2: e889d82dd111d6315d7b1edce2b1b30f  -
-
-attr_remove: Input/output error
-Could not remove "attr_name2" for SCRATCH_MNT/testdir/inline_file1
-touch: cannot touch 'SCRATCH_MNT/testdir/inline_file1': Input/output error
-attr_name2: d41d8cd98f00b204e9800998ecf8427e  -
-
-attr_set: Input/output error
-Could not set "attr_name2" for SCRATCH_MNT/testdir/inline_file2
-touch: cannot touch 'SCRATCH_MNT/testdir/inline_file2': Input/output error
-attr_name2: 4198214ee02e6ad7ac39559cd3e70070  -
-
-attr_remove: Input/output error
-Could not remove "attr_name2" for SCRATCH_MNT/testdir/inline_file2
-touch: cannot touch 'SCRATCH_MNT/testdir/inline_file2': Input/output error
-attr_name2: d41d8cd98f00b204e9800998ecf8427e  -
-
 attr_set: Input/output error
 Could not set "attr_name2" for SCRATCH_MNT/testdir/inline_file3
 touch: cannot touch 'SCRATCH_MNT/testdir/inline_file3': Input/output error
@@ -131,11 +91,6 @@ Could not remove "attr_name2" for SCRATCH_MNT/testdir/remote_file2
 touch: cannot touch 'SCRATCH_MNT/testdir/remote_file2': Input/output error
 attr_name2: d41d8cd98f00b204e9800998ecf8427e  -
 
-attr_set: Input/output error
-Could not set "attr_name2" for SCRATCH_MNT/testdir/sf_file
-touch: cannot touch 'SCRATCH_MNT/testdir/sf_file': Input/output error
-attr_name2: e43df9b5a46b755ea8f1b4dd08265544  -
-
 attr_set: Input/output error
 Could not set "attr_name2" for SCRATCH_MNT/testdir/leaf_file
 touch: cannot touch 'SCRATCH_MNT/testdir/leaf_file': Input/output error

