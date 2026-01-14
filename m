Return-Path: <linux-ext4+bounces-12844-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E50D20D34
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 19:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50F20301C56B
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0E0335064;
	Wed, 14 Jan 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UzE73aXh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZU81KB62";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UzE73aXh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZU81KB62"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA73358D5
	for <linux-ext4@vger.kernel.org>; Wed, 14 Jan 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415331; cv=none; b=Aq/5GOXiioJFOOzLCOwH9xc5U/vY6R7xhrLCKg7NaVZcnL3WmtpDW82FPW/a+6LmlsX68b2Fx+ldOjnWU3ywz9breFUodShwOccH6FJ2qbN/woEgKX7HJ6GZf3w3qjygoXkauu6X+7Tt9RppjH/ta8ozeth89rtzAVrWJHydMZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415331; c=relaxed/simple;
	bh=5cmiT9yALClNSSPcdHAkmIyCQ3dr1NhNOV0IdDf30OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wauvj8HLfiMFJjZUxHu2uIXj0EW+mNiqKuwYP6/sgbOkID3HT/ZHR5XgkxAsgONoedhkGZVM6TLmIb9Z9m1R1jY6qrjtaZi10z7N7+vsnMAlc6gicckQ+XIJrlPlO9Nj5zaNRQHdfCVH7SjnGHH3TnGiMn7o7ImOQS1oKoRydkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UzE73aXh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZU81KB62; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UzE73aXh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZU81KB62; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21D385D168;
	Wed, 14 Jan 2026 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768415328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a90tB5nvx8lj7TgvhaU3r0Fj9AtHI0Z764/0juQE6ck=;
	b=UzE73aXhe+4z3081Ir5eOrSMxtHnmoloPuFp6G35HQ9GnomjUbcF/iyagp0Zq+jdSTLcND
	zvfykFPdCaFEIyV31lzEMB/EXGf6CAUxnXtWw+l9t+5Smj/5DjNwbq4wbilWrzNV8eBzCa
	0wRIIavanEh18nNdHIvbU/Nab8KNPq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768415328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a90tB5nvx8lj7TgvhaU3r0Fj9AtHI0Z764/0juQE6ck=;
	b=ZU81KB62snBsXxGK308PJKSlKe8Tas0hehyFkeY4MkYmofoqzAaARqgo7RL80pG3Anf76S
	awmoHw29lNql21Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768415328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a90tB5nvx8lj7TgvhaU3r0Fj9AtHI0Z764/0juQE6ck=;
	b=UzE73aXhe+4z3081Ir5eOrSMxtHnmoloPuFp6G35HQ9GnomjUbcF/iyagp0Zq+jdSTLcND
	zvfykFPdCaFEIyV31lzEMB/EXGf6CAUxnXtWw+l9t+5Smj/5DjNwbq4wbilWrzNV8eBzCa
	0wRIIavanEh18nNdHIvbU/Nab8KNPq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768415328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a90tB5nvx8lj7TgvhaU3r0Fj9AtHI0Z764/0juQE6ck=;
	b=ZU81KB62snBsXxGK308PJKSlKe8Tas0hehyFkeY4MkYmofoqzAaARqgo7RL80pG3Anf76S
	awmoHw29lNql21Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15BFD3EA66;
	Wed, 14 Jan 2026 18:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ifRBBWDgZ2k/QAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 Jan 2026 18:28:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CA970A0C44; Wed, 14 Jan 2026 19:28:43 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Baokun Li <libaokun1@huawei.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH 2/2] ext4: use optimized mballoc scanning regardless of inode format
Date: Wed, 14 Jan 2026 19:28:19 +0100
Message-ID: <20260114182836.14120-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114182333.7287-1-jack@suse.cz>
References: <20260114182333.7287-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=jack@suse.cz; h=from:subject; bh=5cmiT9yALClNSSPcdHAkmIyCQ3dr1NhNOV0IdDf30OA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpZ+BVHePmJ7X9hLck1K7q75M0ZMEBj5tzYpkns ckw4aVRDEmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaWfgVQAKCRCcnaoHP2RA 2elTB/9Bgylw23VYv00GrpafKv1vilh779pQZvbXAy0JeCXDBXnecWgzHEQZtEB5z17FHdnDytP jHeKiBH+/yKcAnZNlBi0Q189NVUKhCt0GHrsKtbIP/6ZG91UWX7iyIz8A+tF7eRDI95fL5s5aS9 xW4Orx1lecnZeuFYtumiwlD5VnQBf4Z6PTcXuTDuaEzr1jWqnxLULLFgBn+ecCRyG1rt6Cherlt 7TemsSxDi1+DbQbpM2CBUKnicvvzTkwo4CP3qvVypKNCRm/Kj+V5AFf2njIEcuFcOvRJ3ci5vEd 4Di4ZSPxWBwGjxhwg/9zWCvrEQx0bX8/LHOqq7w/bOekDfhX
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

Currently we don't used mballoc optimized scanning (using max free
extent order and avg free extent order group lists) for inodes with
indirect block based format. This is confusing for users and I don't see
a good reason for that. Even with indirect block based inode format we
can spend big amount of time searching for free blocks for large
filesystems with fragmented free space. To add to the confusion before
commit 077d0c2c78df ("ext4: make mb_optimize_scan performance mount
option work with extents") optimized scanning was applied *only* to
indirect block based inodes so that commit appears as a performance
regression to some users. Just use optimized scanning whenever it is
enabled by mount options.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a88fbaa4f5f4..bca62cc2be1c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1148,8 +1148,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 		return 0;
 	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
 		return 0;
-	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
-		return 0;
 	return 1;
 }
 
-- 
2.51.0


