Return-Path: <linux-ext4+bounces-12426-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B09CCAACC
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA549308DAF5
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138712DA76F;
	Thu, 18 Dec 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GxI2bRmH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22129ACC5;
	Thu, 18 Dec 2025 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043051; cv=none; b=u9Y3bscwRpKZvdWCU2BUONXuytcesdt4o9Tdxwqqh7AO4JVwAlzgEz8azkiXYICU3pDOQMl9dM0/VAf7S+k8gnvN0Fd1Ksc3qFAPAwMItgpJA5j7cNDviqS1FZqOqih3juPaIZYLLfvMDfIllHbiy0FJvflZyJNblUnSDEJ12m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043051; c=relaxed/simple;
	bh=NxRRwYA9tnelvKUaEIe0oGn1IlKHn44lmM5FhD42L1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdmk63YwBNWo3EZ6STRzZb4U7qayNV4TF/o+K/q2q1TwvIvcSziewWaNYcl+lud+pUn+xftmUiX8s9yPyIXKlSPNxyc1rfhiw8nr8lCOOX6QAfVSeYigsAoyxS9IT40SYajTjPtA3iRag8fzYBWwZ6MCuIoGMo/JQ4DQL4siR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GxI2bRmH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xbKkU/qe06OxKUaMLJVY84YlKy/2aN3ZBBvCjkpiiWU=; b=GxI2bRmHA3alqRUaAWeuga/qZu
	k19KHv8OL78kv87KWqvx9oswJ3z8w8OJmISn/y/AoPw2wiKqEjgka+5Cbc9/IVvvvS0zCDLuJ97gY
	Cfz4V6zMS69kIaxtlhfN2KFACUvzKKVrrMwNgsNYUTGZNL4G2m18e5jyr0FECkzYU6/uoxBGGvVuF
	9Qf1JPl/Nf4C7ucCjFuEQjEgMlAo8v/ntEcfsbY6M2oVGo+YZv7k/fa+hcBquAM0Jz7P1Eq67JpTs
	dSg9VWI6gL9BWSDBvhPl1n7JggXroJF1iSa7pvtjpL8GV1ZJgbCAVdYDeur2iFLt8J82uk3DtSdpq
	3Q3gk4+Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8TJ-00000007xaL-1wSC;
	Thu, 18 Dec 2025 07:30:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 06/13] xfs/157: don't override SCRATCH_{,LOG,RT}DEV
Date: Thu, 18 Dec 2025 08:30:04 +0100
Message-ID: <20251218073023.1547648-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218073023.1547648-1-hch@lst.de>
References: <20251218073023.1547648-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This tests wants to test various difference device configurations,
and does so by overriding SCRATCH_{,LOG,RT}DEV.  This has two downside:

 1) the actual SCRATCH_{,LOG,RT}DEV configuration is still injected by
    default, thus making the test dependent on that configuration
 2) the MKFS_OPTIONS might not actually be compatible with the
    configuration created

Fix this by open coding the mkfs, db, admin and repair calls and always
run them on the specific configuration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/xfs/157 | 104 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/tests/xfs/157 b/tests/xfs/157
index e102a5a10abe..31f05db25724 100755
--- a/tests/xfs/157
+++ b/tests/xfs/157
@@ -50,53 +50,105 @@ fake_rtfile=$TEST_DIR/$seq.scratch.rt
 rm -f $fake_rtfile
 truncate -s $fs_size $fake_rtfile
 
-# Save the original variables
-orig_ddev=$SCRATCH_DEV
-orig_external=$USE_EXTERNAL
-orig_logdev=$SCRATCH_LOGDEV
-orig_rtdev=$SCRATCH_RTDEV
-
 scenario() {
 	echo "$@" | tee -a $seqres.full
 
-	SCRATCH_DEV=$orig_ddev
-	USE_EXTERNAL=$orig_external
-	SCRATCH_LOGDEV=$orig_logdev
-	SCRATCH_RTDEV=$orig_rtdev
+	dev=$SCRATCH_DEV
+	logdev=
+	rtdev=
+}
+
+_fake_mkfs()
+{
+	OPTIONS="$*"
+	if [ -n "$logdev" ]; then
+		OPTIONS="$OPTIONS -l logdev=$logdev"
+	fi
+	if [ -n "$rtdev" ]; then
+		OPTIONS="$OPTIONS -r rtdev=$rtdev"
+	fi
+	$MKFS_XFS_PROG -f $OPTIONS $dev || _fail "mkfs failed"
+}
+
+_fake_xfs_db_options()
+{
+	OPTIONS=""
+	if [ ! -z "$logdev" ]; then
+		OPTIONS="-l $logdev"
+	fi
+	if [ ! -z "$rtdev" ]; then
+		if [ $XFS_DB_PROG --help 2>&1 | grep -q -- '-R rtdev']; then
+			OPTIONS="$OPTIONS -R $rtdev"
+		fi
+	fi
+	echo $OPTIONS $* $dev
+}
+
+_fake_xfs_db()
+{
+	$XFS_DB_PROG "$@" $(_fake_xfs_db_options)
+}
+
+_fake_xfs_admin()
+{
+	local options=("$dev")
+	local rt_opts=()
+	if [ -n "$logdev" ]; then
+		options+=("$logdev")
+	fi
+	if [ -n "$rtdev" ]; then
+		$XFS_ADMIN_PROG --help 2>&1 | grep -q 'rtdev' || \
+			_notrun 'xfs_admin does not support rt devices'
+		rt_opts+=(-r "$rtdev")
+	fi
+
+	# xfs_admin in xfsprogs 5.11 has a bug where an external log device
+	# forces xfs_db to be invoked, potentially with zero command arguments.
+	# When this happens, xfs_db will wait for input on stdin, which causes
+	# fstests to hang.  Since xfs_admin is not an interactive tool, we
+	# can redirect stdin from /dev/null to prevent this issue.
+	$XFS_ADMIN_PROG "${rt_opts[@]}" "$@" "${options[@]}" < /dev/null
+}
+
+
+_fake_xfs_repair()
+{
+	OPTIONS=""
+	if [ -n "$logdev" ]; then
+		OPTIONS="-l $logdev"
+	fi
+	if [ -n "$rtdev" ]; then
+		OPTIONS="$OPTIONS -r $rtdev"
+	fi
+	$XFS_REPAIR_PROG $OPTIONS $* $dev
 }
 
 check_label() {
-	_scratch_mkfs_sized "$fs_size" "" -L oldlabel >> $seqres.full 2>&1
-	_scratch_xfs_db -c label
-	_scratch_xfs_admin -L newlabel "$@" >> $seqres.full
-	_scratch_xfs_db -c label
-	_scratch_xfs_repair -n &>> $seqres.full || echo "Check failed?"
+	_fake_mkfs -L oldlabel >> $seqres.full 2>&1
+	_fake_xfs_db -c label
+	_fake_xfs_admin -L newlabel "$@" >> $seqres.full
+	_fake_xfs_db -c label
+	_fake_xfs_repair -n &>> $seqres.full || echo "Check failed?"
 }
 
 scenario "S1: Check that label setting with file image"
-SCRATCH_DEV=$fake_datafile
+dev=$fake_datafile
 check_label -f
 
 scenario "S2: Check that setting with logdev works"
-USE_EXTERNAL=yes
-SCRATCH_LOGDEV=$fake_logfile
+logdev=$fake_logfile
 check_label
 
 scenario "S3: Check that setting with rtdev works"
-USE_EXTERNAL=yes
-SCRATCH_RTDEV=$fake_rtfile
+rtdev=$fake_rtfile
 check_label
 
 scenario "S4: Check that setting with rtdev + logdev works"
-USE_EXTERNAL=yes
-SCRATCH_LOGDEV=$fake_logfile
-SCRATCH_RTDEV=$fake_rtfile
+logdev=$fake_logfile
+rtdev=$fake_rtfile
 check_label
 
 scenario "S5: Check that setting with nortdev + nologdev works"
-USE_EXTERNAL=
-SCRATCH_LOGDEV=
-SCRATCH_RTDEV=
 check_label
 
 scenario "S6: Check that setting with bdev incorrectly flagged as file works"
-- 
2.47.3


