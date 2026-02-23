Return-Path: <linux-ext4+bounces-13907-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAyaD1DknGn4LwQAu9opvQ
	(envelope-from <linux-ext4+bounces-13907-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 00:35:44 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D250817F9ED
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 00:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E7703020859
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 23:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D4437F8C6;
	Mon, 23 Feb 2026 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9pHdSgS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373B369980;
	Mon, 23 Feb 2026 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889637; cv=none; b=PqvqKbYSfjd5NHdgdB9E2R1JIbMd0BtlyvwppD6bUU5UwPKdwRoRWNRx+BD1p9MPQv+pds/zFkiNSYiSnQA1cejX/SuM8GlTEiR6BpuHVF6eydhblPL5181P4bHxyDS7TwaEckBm48itur57ZtM83dqzPgq/H/V3LVgvon6u+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889637; c=relaxed/simple;
	bh=5vaV9ijs3gEC10GWb6LYCjBwVDlN1vhzVtB73Z55dUA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUqp0oJQ0R21CkuKiAhU+8alyP7wuhlWL5wS4spuYZ3yOVkCLP0fFHRu7AN4ZJrey7w4EdwnMRecsHyhmeWB+ztjJi6tdLN6L9P5wWPBKRwNQfodwBOvPcH9eFXvsHDy14ncdj8rJC2rrkMTWfYSRQxWweGTk3QGkGEREgvAPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9pHdSgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3E5C19421;
	Mon, 23 Feb 2026 23:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889637;
	bh=5vaV9ijs3gEC10GWb6LYCjBwVDlN1vhzVtB73Z55dUA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=D9pHdSgSI58Gr1AYNEBqVeQHzSsOsnh32Vi5qRFShIbeFvg6adN9HKbgLz3h88QOb
	 4pdE46a1yR5DDCYfgEjsemW2WkfGss6vvljcdptUtqg4eu0Jd2dHg86oM9IsaSe+qg
	 AYeiqzH3M7R0v8pLb49zzPO0Io84LvUqG7NvWkwmcumuz3N06y0lg9VYfLjSSc4MLc
	 ZVENdli7jGWBepJznMA+3uYnWIGml/BM+vF75C8b8ew3OTF1OcBh6zWyP7xlmT12Uk
	 BIl3l3RqneP6iYMAAdJgJN1DO/0wOJsow8g5CUIBECzlX4d+tjS6bZWhQPMnExVD37
	 ibsBTfd/dnHQA==
Date: Mon, 23 Feb 2026 15:33:57 -0800
Subject: [PATCH 5/5] libfuse: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741107.3941876.9023199559620484316.stgit@frogsfrogsfrogs>
In-Reply-To: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
References: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13907-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-ext4@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D250817F9ED
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Remove the guard that we used to avoid bisection problems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_lowlevel.c |    2 --
 1 file changed, 2 deletions(-)


diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index b2bf2e5345cc71..714c26385c044f 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3181,8 +3181,6 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
 		if (inargflags & FUSE_IOMAP)
 			se->conn.capable_ext |= FUSE_CAP_IOMAP;
-		/* Don't let anyone touch iomap until the end of the patchset. */
-		se->conn.capable_ext &= ~FUSE_CAP_IOMAP;
 	} else {
 		se->conn.max_readahead = 0;
 	}


