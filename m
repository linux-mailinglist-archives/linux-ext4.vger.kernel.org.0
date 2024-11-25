Return-Path: <linux-ext4+bounces-5393-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9599D8394
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2024 11:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4430E28442A
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2024 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB73A194147;
	Mon, 25 Nov 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="nqGJcLfQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3740192D7E;
	Mon, 25 Nov 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531235; cv=none; b=i4W0ljPdcK3h+2flWjqH4Z2WDPJ4s53h/xdMm5bF3NZ+YegialndgN3nMC3FBEsd9OVcHO47Dcj+JSlRmltMwm1OPfo+cnZgGZw8WeOwuEZDqAIulGsq3TR3d/BrH2AalbnBxB8zY06AD76LerRNhhRiGBUu9hx8f7D6fkkG72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531235; c=relaxed/simple;
	bh=1o2+SCKbPMlZSfhshov97BHiZ6npLENrivJUl/obBl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qoj4a5zs1bFXQZyexigvl1LUhMGqELN1rtey/zVovcns7tsMbMzKnQMX4MHaQfhYwCeTjyTiE9Srmn0hCeO65o2tk2MLA0ERta3t4ivK8Vi08S/He9pqQFtsbgp2s9FLIS+LO6AZNTEFIQibf/Wk+lk4l9lxXCs6lHuiaQqjpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=nqGJcLfQ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531224;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0u/9xnJFmCzCIsRXywH2TwoCekIvWc3+cszQ3gofsI=;
	b=nqGJcLfQpuCPVU4svGCFemBiN+Nqp+1R16Nvd1Z8RvKusipz8MFxJLNdU2uhjFvntoOYSb
	Xj1L3BtASdJeevaSB18S7Dl4G9iVy2NeKuB5bVvlEQ/00Zw4mWcB4rc9Y8T8msyZ1lYG1X
	9EFJuwkmLAYq+yC2ipfy3AxGyZxlF/Jc9QDPrMphpZ2z7VT/m3D7jllOSk539ISoY/tFbc
	kSn7Zr8qrh9mhI/pb9WE7RVtWlm2DpAmQRLqFEX0I9t3ojiACy+XuvtER8YjGVp+0wWSGE
	NlMPqw/DtS7g8Ao5UdD3jNlwW46B8Yn6PoWxwEILbI/QoEnLV0D9q/lx/AKSKA==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	cocci@inria.fr
Subject: [PATCH 03/11] ext4: reorder capability check last
Date: Mon, 25 Nov 2024 11:39:55 +0100
Message-ID: <20241125104011.36552-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 fs/ext4/balloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8042ad873808..c48fd36b2d74 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -649,8 +649,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
 	/* Hm, nope.  Are (enough) root reserved clusters available? */
 	if (uid_eq(sbi->s_resuid, current_fsuid()) ||
 	    (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) && in_group_p(sbi->s_resgid)) ||
-	    capable(CAP_SYS_RESOURCE) ||
-	    (flags & EXT4_MB_USE_ROOT_BLOCKS)) {
+	    (flags & EXT4_MB_USE_ROOT_BLOCKS) ||
+	    capable(CAP_SYS_RESOURCE)) {
 
 		if (free_clusters >= (nclusters + dirty_clusters +
 				      resv_clusters))
-- 
2.45.2


