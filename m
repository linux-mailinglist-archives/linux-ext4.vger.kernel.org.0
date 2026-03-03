Return-Path: <linux-ext4+bounces-14570-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGCuONsip2mMegAAu9opvQ
	(envelope-from <linux-ext4+bounces-14570-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 19:05:15 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C8F1F4EE2
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 19:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B40D33015707
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA634921A6;
	Tue,  3 Mar 2026 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLIVyco9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D33282F00
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560923; cv=none; b=NoXBZZQELxOaOr/lqPNaFgaYQ+0AK3Z6qqEpOvDbP/MpCYmWyV1GKUEapqu2GMgFkx3dLNvBUrdGiuQ7IgTnm+PLLgNP/KX0JtPB/RyOqOVImb6G753vmKrnmOP+1W32w9yrdhrXFc87JxJPk+GeMv5vm7BHiiCtd4Ect4NgszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560923; c=relaxed/simple;
	bh=0APIcoHqTqXX3pb5qx9OvGuipFCciqLsFjrYlsSw7io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jo4l+fS3mDqIirr875KDxUGB5ym6AjOC9nQL8z68J5rU/on42cD0Cyf1OVZuS52OQJnWEZ67Y7dKMfbZJbAtrGXJ6huPYMUM14JQIenBz+MczoLqEEBD6WZBD6GweiWCQQMecRrvfwHDRCgmsEYvKI8h/E9F1MLHQXERyvyVeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLIVyco9; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1279eced0b9so3410488c88.0
        for <linux-ext4@vger.kernel.org>; Tue, 03 Mar 2026 10:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772560922; x=1773165722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Alfyl5T3KNbNxo24SrmGEISdwL5PeMwjzCbF2yGEsfA=;
        b=ZLIVyco90rHOO0/Y5VdmEYsTDvPLSNfjWfn3Zq3FvJJzHjkZ+iXLpLad3f+GhhDbUs
         jLC2IOJ28AbbKpOt4dImrsGvmah6ywv9sVO2f8PfVdQ8gq1OwPDZ2LOAWor6oHAQUeke
         a3vVXeZZY7e5aO08KJifUhqKUlcUVT3So5vtgzWce/H+HHA5ndQCvR3geePFlD1tPyof
         EO1w9lrCsmeynHfZfqJckLyCULq0eeB+ycGAUVe4P25eegItFCuRA67H8iXtR4c+PuXH
         RESLtzWL2kI5w63WTwuQQZxrjb/ITaZNVZdLDFjLG4SeSF3dmdPV4M/sfb2+JfVdOBIy
         lV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772560922; x=1773165722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Alfyl5T3KNbNxo24SrmGEISdwL5PeMwjzCbF2yGEsfA=;
        b=LfJuFGh3vwiC71dTOBB4DCtfHVzHt5HJ8W97K9n6JiCjEFQRCHCzmn+vfVRkQ3wQ7W
         UuJuDGxtALJKrqlxu860kJTDa4q9gQsSpBCZritqdE6ef2BuY6AAfslO0vBG4xcHSKbY
         +LP1QUOoRf98+jRHcDVW/dzHKw5QzIVkTo3t5osxyQJzsphcKudn2lhmKCexwPAjMOYb
         W72grjOGkCDgVJsDbTsqtxtjUNlmB8AsjHVcP9mva2Lb4psTy5GVbTjhv3eEhhgqBkOG
         GD0HDBCfOy9DVq1JD5wi9xDA3PbKTKFqsfm/tKtHP8B9UB+gygGo+tkh4NLUVsBV01fO
         WfLA==
X-Forwarded-Encrypted: i=1; AJvYcCW3CUhflXSxvZyHMPxpd0z3h70f6U3F/vG7UbDXn1jDcexFoIAAW06IB6+Wcvw6ONLvMmBvku9WVs48@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9MnqO4rRUGeyFHPi92trxCx5TVSJCFR1DWzB643wmjq27F8u
	XtNwwHAHvHuhKFkW+HONcTGDTZwuhJMd+f1TEciGRlqbhtvQT3ek4yGR
X-Gm-Gg: ATEYQzyd733Aq/0SajngW5nB78DLfV0w27eH2VUaCoKK+luJcIj+yI8p1oi5Yy0+aph
	BWrwmLazdrfjySNhSV/OVe+bqGfihrji74OhIvcnzXEKf1EFdsMGnVqALO2Kx/G38bpgOu6nA8Y
	ICZrtoqlzlrdMw/uXOZjm/ETxNH1Oqv8rIPiMZSFoEflPsHjTN/6De7uw+OmDihEmX8bdluHb82
	AMbl2ZOS4+w7jBgqtbuujO/ugLMv5t1u1tDiOqoI0ITjg2eirnULvudESUl8iyGew5vahPbroEI
	XI48pw95wNvPq9bHSMtZX6Exrv8omZ7A8UhV3DKDxzyIIrP22mpcdYKrG1P0jfCMZAQJbvjf4zY
	0AZ8D0m0c/gGId7BpFJ4dJpsEKEiYLbeZHRHbiGtAsy5j117BTAhLW6JnxTzbzcxKfz5Z1VyKU+
	N0WWektz7vb7R1rlQKJcinSeDomgE+Isv3d2zJXyqNkGPcfgZFnHy6zk6WoF+vqpM1+b+UzX6pO
	ZSPXb5TPZfII/K2Lah+FYMUb9snGso06noBK5rYpSct3lGaJS2MIQQp/Jjj/9r6Tl9DcKQNTiDT
X-Received: by 2002:a05:7022:6624:b0:11b:b3a1:714a with SMTP id a92af1059eb24-1278fb78dd9mr5443793c88.12.1772560921317;
        Tue, 03 Mar 2026 10:02:01 -0800 (PST)
Received: from arch.guest.box.net ([8.39.49.136])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfba0df2fsm9506612eec.7.2026.03.03.10.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:02:00 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH v4 0/2] jbd2: audit and convert legacy J_ASSERT usage
Date: Tue,  3 Mar 2026 10:01:55 -0800
Message-ID: <20260303180157.53061-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54C8F1F4EE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14570-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello Jan and the ext4 team,

This patch series follows up on the previous discussion regarding
converting hard J_ASSERT panics into graceful journal aborts.

In v1, we addressed a specific panic on unlock. Per Jan's suggestion,
I have audited fs/jbd2/transaction.c for other low-hanging fruit
where state machine invariants are enforced by J_ASSERT inside
functions that natively support error returns.

Changes in v4:
    Patch 2: Fixed a build test WARNING by initializing a variable
    `journal` earlier in  jbd2_journal_dirty_metadata().

Changes in v3:

    Patch 2: Added pr_err() statements inside the ambiguous WARN_ON_ONCE()
    blocks (where multiple conditions are checked via logical OR/AND) to
    explicitly dump the b_transaction, b_next_transaction, and
    j_committing_transaction pointers. This provides necessary context for
    debugging state machine corruptions from the dmesg stack trace.

Changes in v2:

    Patch 1: Unmodified from v1. Collected Reviewed-by tags.

    Patch 2: New patch resulting from the broader audit. Systematically
    replaces J_ASSERTs with WARN_ON_ONCE and graceful -EINVAL returns
    across 6 core transaction lifecycle functions. Careful attention was
    paid to ensuring spinlocks are safely dropped before triggering
    jbd2_journal_abort(), and no memory is leaked on the error paths.

Milos Nikic (2):
  jbd2: gracefully abort instead of panicking on unlocked buffer
  jbd2: gracefully abort on transaction state corruptions

 fs/jbd2/transaction.c | 119 ++++++++++++++++++++++++++++++++----------
 1 file changed, 92 insertions(+), 27 deletions(-)

-- 
2.53.0


