Return-Path: <linux-ext4+bounces-7100-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D73A7F18D
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 01:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF21179380
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 23:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75919221F0A;
	Mon,  7 Apr 2025 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmIjrNnj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161214F123;
	Mon,  7 Apr 2025 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744070373; cv=none; b=lksyHH4dJB9ZRbLjMsG3gHhybTsb07lqd9lM6oGGjmLQykuTaHv5zU/m9hzBMh3p87mmnktJjrfahjbI9oVE5fwd129OjjggZu/il9isnf07CrJYJoLP4KJ8ayEcWAt9trMR8Lo+oEny4DadDZAKmVicfFDSXbMRcH6sezBA++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744070373; c=relaxed/simple;
	bh=CD02yh1zTokGCLhUQWbDuMQP6eKJrgSX3trbFD2t/1w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TJRHLdwdlv9uMQ55yahnDa+bL3nGdt8r+CHKLMyeYirHOjppIJF7ulsVEfjxN/SNHnwzei22qyFZBCuuc9iRpbccXZM1pE/QIIISFrfdQ7eufLqR/GlmA1cgsbmxXTXMamk8m/6+FKlcnniAWHpH74Q1D+aAFQWvxIackpkTd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmIjrNnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA49C4CEDD;
	Mon,  7 Apr 2025 23:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744070372;
	bh=CD02yh1zTokGCLhUQWbDuMQP6eKJrgSX3trbFD2t/1w=;
	h=Date:From:To:Cc:Subject:From;
	b=hmIjrNnj1GISudW6HoYe3IduyltjRDDHWNd6AxMh7TxDYuzsDeZHoL8E5ZOD/ALDn
	 xzc0NrAUP3g1kpE9s469GcevsssnAmqjz/l9JVpFrTQzb4KoJjHu0WhuSVlKDcnHmm
	 W2M+A0hpeX/lARnAg2fQez536dLWH7UtBDylei7k4Dsk24LZYVkzDctuMo5AsqVgpS
	 plsdO+dT9WJIGk8VleYA9arNLIPsL73fCyQB1feD1R84WFx3P+z4jpqmH4fj1zsl4Q
	 5v1zadEazfCYD2MgmB2r+HXd0/paGJLGUi7nGpajwNHbeE+OekW/ANNl7ggB79kkrU
	 193D8WzTRIjOQ==
Date: Mon, 7 Apr 2025 16:59:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests <fstests@vger.kernel.org>,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH] common/rc: fix dumping of corrupt ext* filesystems
Message-ID: <20250407235931.GB6274@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

The parameters to _ext4_metadump are device, dumpfile, and compress
options.  This callsite got the arguments in the wrong order, which
causes fstests to compress all of /dev/sdX as /dev/sdX.zst which is not
what we want.

Cc: <fstests@vger.kernel.org> # v2022.05.01
Fixes: 9fb30a9500c169 ("common: capture qcow2 dumps of corrupt ext* filesystems")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index b2155d37a90d68..a71c15986efd18 100644
--- a/common/rc
+++ b/common/rc
@@ -3552,7 +3552,7 @@ _check_generic_filesystem()
         case "$FSTYP" in
         ext*)
             local flatdev="$(basename "$device")"
-            _ext4_metadump "$seqres.$flatdev.check.qcow2" "$device" compress
+            _ext4_metadump "$device" "$seqres.$flatdev.check.qcow2" compress
             ;;
         esac
     fi

