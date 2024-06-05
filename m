Return-Path: <linux-ext4+bounces-2783-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D088FD709
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 22:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7D31C211C7
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 20:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AD158218;
	Wed,  5 Jun 2024 20:05:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E9155356
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617950; cv=none; b=o0he7YXpgxcu/4mE5NQboMdanw8Pmks1/Banz2avxjpI7AVdKuUI504Bkevmjdtui+/Woo3aRT6+Q8c+srXdhvq90lctDXikrhwYRXo09CLZLU/yI/0hnVmKdSIvFQXue4Hr+qqLLY6CHVZnzzt+4NzhEn1ORLevfZFjUAZAHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617950; c=relaxed/simple;
	bh=NiTzQbVy+xJbbWsMbs38X93NHu+c1xKnhli4RK006qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJaGEOrK/AXhr1r1RwKhc3/jIgiIeuJnEPEfOvKbMVgnPWO7o4wqOFZLVybv1bFioe1SfVfXFyJFyG2UtT989Sx5Mi+/Q8TMgHoa/uzRm39Oq94CGy3zgLKW4It2VE8NFTtEEbTmLgJ31P4CjbXdK4P+H3ZVDnekc/l+6JL86X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTPS
	id ElXusWF8T2Ui5EwrjsOxiE; Wed, 05 Jun 2024 20:04:11 +0000
Received: from webber.adilger.int ([70.77.200.158])
	by cmsmtp with ESMTP
	id EwrisLxWOWhyfEwrisoZjH; Wed, 05 Jun 2024 20:04:11 +0000
X-Authority-Analysis: v=2.4 cv=MenPuI/f c=1 sm=1 tr=0 ts=6660c4bb
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=RPJ6JBhKAAAA:8
 a=koeibLOpxPZKHOG3OBkA:9 a=fa_un-3J20JGBB2Tu-mn:22
From: Andreas Dilger <adilger@dilger.ca>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] tests: write f_badjour_encrypted output to log
Date: Wed,  5 Jun 2024 14:03:52 -0600
Message-ID: <20240605200408.55221-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfETnZ1WHcIOUr0J8fh7OvOyEXfge6jdtudPjsYSSDtJQTsDOMMPwqxBp3q4M2WgnQFHjKbNU5YEN9S2Guxt3+ew8ZCGx/Hy4qPoqIWb7ZbBkSq/+Sc12
 HpmnBkDslvdfxk/KiUcYREpze3QlTY9b7tWbnPB04CqeudnSbY6j5TS9b8Olo1G7DDxy7c39+RDRbo4ypSMDNa1fQr62+2/YqwhV2+SglP00tDhRRRbpeC23
 9Xbhdlj8UKcADDkYZJJhEg==

Write the mke2fs and debugfs output from f_badjour_encrypted/script
into a log file instead of stdout/stderr, so that it doesn't mess
up the "make check" output, and is available if this test ever fails.

Fixes: b0cd09e5 ("e2fsck: don't allow journal to have encrypt flag")
Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 tests/f_badjour_encrypted/script | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/f_badjour_encrypted/script b/tests/f_badjour_encrypted/script
index e6778f1d..27b1026b 100644
--- a/tests/f_badjour_encrypted/script
+++ b/tests/f_badjour_encrypted/script
@@ -3,9 +3,9 @@ if ! test -x $DEBUGFS_EXE; then
 	return 0
 fi
 
-touch $TMPFILE
-$MKE2FS -t ext4 -b 1024 $TMPFILE 2M
-$DEBUGFS -w -R 'set_inode_field <8> flags 0x80800' $TMPFILE
+touch $TMPFILE >> $LOG 2>&1
+$MKE2FS -t ext4 -b 1024 $TMPFILE 2M >> $LOG 2>&1
+$DEBUGFS -w -R 'set_inode_field <8> flags 0x80800' $TMPFILE >> $LOG 2>&1
 
 SKIP_GUNZIP="true"
 . $cmd_dir/run_e2fsck
-- 
2.44.0


