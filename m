Return-Path: <linux-ext4+bounces-11574-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC867C3D9F2
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9160B18893A8
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B430DED7;
	Thu,  6 Nov 2025 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImayrKI2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD02C3252
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468505; cv=none; b=LIA1xF7uC0KV6GQ19lymScpaA2T/bC4cfKS9JLsKVewrvs0+EraMOPUZGlurTfaqmFCJFKiZHGJNl2hoQoaR95m8fehOgSLAFOBtUsmPPQjkjC1ruejLmCWsPuVBwsAqMnT/EXm/g/nCaZoTyEMYLpqUcTnM/jL2n4KSct58dqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468505; c=relaxed/simple;
	bh=tvujOlGqkNoIZkRmjUwJh5MN8c4sWzOkgcd8bdPdixA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hn7AvDQhTBOivAQ5AYtzCUD2nGmOZHGqDgnr7wFPpjrQceZPvSqUPEiY4T+POi2gEySQf/gRA/5NjYeLpuE/i2ETlbo+peQZMUvNPBwWdU9r/zz1eNRsLuZPIzP2XjNsFY+hd6zfX+NQqBAesBieGlMLKoII7cSU6OaoDcgQuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImayrKI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B7DC116C6;
	Thu,  6 Nov 2025 22:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468504;
	bh=tvujOlGqkNoIZkRmjUwJh5MN8c4sWzOkgcd8bdPdixA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ImayrKI2CHxVPyzEJSr6WKYMeE50/RH6Ac4sOSgcYtUQAZzE6JrHz0OOzpiHLtvBF
	 tDK17UvDm4xrWfCRve1+hSvRQaZaCnBdm727GAA4fepxokTdH7AoS+4EQaZL5rM4kI
	 EwWXalzpWEE34Yq/Mkb8qrAPXoiF9VZPHb3iz4cLRpiVv/yicHddtgmIi0gdR+gWE/
	 Jlb2t/4Aj5YFASpDmSbZvsqTtUn9w7TXPh3ErTYlAzjOXe4+rg3RPUKPlc4OOejaHP
	 ZU3jiscD6EIIRuvsPLxay3+QVlRofu37bukXiP+JKzzMjYyCnNv2nG6xGYQM0c7ekn
	 2ivNHD/SbHooQ==
Date: Thu, 06 Nov 2025 14:35:03 -0800
Subject: [PATCH 15/19] fuse2fs: constrain worker thread count
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793900.2862242.841536140540610467.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
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
index c1bd76ba449370..d890855df9c0f3 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5259,6 +5259,14 @@ int main(int argc, char *argv[])
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
 


