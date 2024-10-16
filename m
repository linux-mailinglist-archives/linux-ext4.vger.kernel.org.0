Return-Path: <linux-ext4+bounces-4592-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C3D9A0779
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 12:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827D52858CF
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEBB20696F;
	Wed, 16 Oct 2024 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y+IumJs0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zr7OAkrW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y+IumJs0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zr7OAkrW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDE5187850;
	Wed, 16 Oct 2024 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074786; cv=none; b=afG0C/kfkUrlEFSYMy8TmMNgD9de4JcYmRBJhZE9UUlLqKmOs1/w451aKQuqC88ZRVzxGDXFaKOF0HeBE5d3x7CxKGydco1Z2cxKs/uBxl3M2IZd+tuI/L6ENMpIIvcW57q756w6TUqfCUx7N2dPHa+I4fXJ7+srxIapywCiCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074786; c=relaxed/simple;
	bh=PE/S58MqtL//qvO6WBTAuvUDTgXidBZ23Nlj8T8/bCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ibo9uPMvrcy6B/Ho+vJSmD9u6T5hIdvpWBH11Nu+zL1ru8T72Ur3oZlx+Zy7duunE+fAM4izNyuDaIDoAcZ6wrKBDVdGRtTLRgXmHXe9kXLxN0zMp68XQARCIJpgRKAviWAWAyBNtDW32M0oiTv+PXd5DEj6YHHLrtftnhrrlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y+IumJs0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zr7OAkrW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y+IumJs0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zr7OAkrW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6605F21E99;
	Wed, 16 Oct 2024 10:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729074782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5P+aJ05WP01r+79yNikHqdrPvAunAaPOA1JFf4+Ab8=;
	b=y+IumJs0b7n1R1a6WK5kyJN3N1Bw5sKggcLB5okJTE4Uc+e8K7MOtHLVSlNN4N0qAr9Z50
	YKRvGeR35dHjCB6OwRZDIWZ5R599bflf6AFvKoNCYbKnuatnyZF5LHkz6Wwvz94yCpWgM/
	6LpnjsUqSRs4Mh3Fhgh8iypBNs7pCK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729074782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5P+aJ05WP01r+79yNikHqdrPvAunAaPOA1JFf4+Ab8=;
	b=zr7OAkrW99TwwRRSaFVkgGm+iChNrQFc/ees4uYpfRpvSYQC63nZTjZGdT9lRg3gQtBh9a
	Gp0AI5GFRArzcCDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729074782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5P+aJ05WP01r+79yNikHqdrPvAunAaPOA1JFf4+Ab8=;
	b=y+IumJs0b7n1R1a6WK5kyJN3N1Bw5sKggcLB5okJTE4Uc+e8K7MOtHLVSlNN4N0qAr9Z50
	YKRvGeR35dHjCB6OwRZDIWZ5R599bflf6AFvKoNCYbKnuatnyZF5LHkz6Wwvz94yCpWgM/
	6LpnjsUqSRs4Mh3Fhgh8iypBNs7pCK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729074782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5P+aJ05WP01r+79yNikHqdrPvAunAaPOA1JFf4+Ab8=;
	b=zr7OAkrW99TwwRRSaFVkgGm+iChNrQFc/ees4uYpfRpvSYQC63nZTjZGdT9lRg3gQtBh9a
	Gp0AI5GFRArzcCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55B5D13433;
	Wed, 16 Oct 2024 10:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KGWIFF6WD2eQTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Oct 2024 10:33:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E7ED8A083E; Wed, 16 Oct 2024 12:33:01 +0200 (CEST)
Date: Wed, 16 Oct 2024 12:33:01 +0200
From: Jan Kara <jack@suse.cz>
To: Baolin Liu <liubaolin12138@163.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
	zhangshida@kylinos.cn, longzhi@sangfor.com.cn,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] ext4: fix a assertion failure due to ungranted bh
 dirting
Message-ID: <20241016103301.rl6qngi2fb6yxjin@quack3>
References: <20241010025855.2632516-1-liubaolin12138@163.com>
 <20241010092923.r53povuflevzhxrw@quack3>
 <5dc22111.4718.19279c3f3b7.Coremail.liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xfanqf3vw6zqfkzt"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dc22111.4718.19279c3f3b7.Coremail.liubaolin12138@163.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-0.99)[-0.989];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	FREEMAIL_TO(0.00)[163.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Score: -3.79
X-Spam-Flag: NO


--xfanqf3vw6zqfkzt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

On Fri 11-10-24 12:08:58, Baolin Liu wrote:
> Greetings，
> 
> This problem is reproduced by our customer using their own testing tool
> “run_bug”. When I consulted with a client, the testing tool “run_bug”
> used a variety of background programs to benchmark (including memory
> pressure, cpu pressure, file cycle manipulation, fsstress Stress testing
> tool, postmark program，and so on).
> 
> The recurrence probability is relatively low.

OK, thanks for asking!

> In response to your query, in ext4_block_write_begin, the new state will
> be clear before get block, and the bh that failed get_block will not be
> set to new. However, when the page size is greater than the block size, a
> page will contain multiple bh. 

True. I wanted to argue that the buffer_new bit should be either cleared in
ext4_block_write_begin() (in case of error) or in
ext4_journalled_write_end() (in case of success) but actually
ext4_journalled_write_end() misses the clearing. So I think the better
solution is like the attached patch. I'll submit it once testing finishes
but it would be great if you could test that it fixes your problems as
well. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--xfanqf3vw6zqfkzt
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext4-Make-sure-BH_New-bit-is-cleared-in-write_end-ha.patch"

From e93cba22bf3b576e6ac481d034b677188134bd7d Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 16 Oct 2024 12:24:03 +0200
Subject: [PATCH] ext4: Make sure BH_New bit is cleared in ->write_end handler

Currently we clear BH_New bit in case of error and also in the standard
ext4_write_end() handler (in block_commit_write()). However
ext4_journalled_write_end() misses this clearing and thus we are leaving
stale BH_New bits behind. Generally ext4_block_write_begin() clears
these bits before any harm can be done but in case blocksize < pagesize
and we hit some error when processing a page with these stale bits,
we'll try to zero buffers with these stale BH_New bits and jbd2 will
complain (as buffers were not prepared for writing in this transaction).
Fix the problem by clearing BH_New bits in ext4_journalled_write_end()
and WARN if ext4_block_write_begin() sees stale BH_New bits.

Reported-by: Baolin Liu <liubaolin12138@163.com>
Reported-by: Zhi Long <longzhi@sangfor.com.cn>
Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..aa56af4a92ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1049,7 +1049,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 			}
 			continue;
 		}
-		if (buffer_new(bh))
+		if (WARN_ON_ONCE(buffer_new(bh)))
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			WARN_ON(bh->b_size != blocksize);
@@ -1265,6 +1265,7 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
 	ret = ext4_dirty_journalled_data(handle, bh);
 	clear_buffer_meta(bh);
 	clear_buffer_prio(bh);
+	clear_buffer_new(bh);
 	return ret;
 }
 
-- 
2.35.3


--xfanqf3vw6zqfkzt--

