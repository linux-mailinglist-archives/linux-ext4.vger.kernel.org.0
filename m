Return-Path: <linux-ext4+bounces-3359-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D844C939921
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 07:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF591F227F2
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 05:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0113C69C;
	Tue, 23 Jul 2024 05:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R5tGNRC6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42FC18D;
	Tue, 23 Jul 2024 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721711814; cv=none; b=NOqQiQth/uPHnd+I+9zheI658YO4q3cIWdOUW0fIbnxWZdykBTIRLAtPvtKkZKVG69Mxum3auUC2gpW5/qJqJBtBN9iPf17z+YRP40Kah5QtLltWgamLZ6BhPpXBE558bH3+MUIqpdfcuSvfxfGymhHa2gUtlZeacEumhjuKoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721711814; c=relaxed/simple;
	bh=LfSlzySw7PPpZSZPx7lOT07CzVtQPh+7Z4tvW/dro1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YytERoIQKm9TmLD4mXy0UotbaMDlczM4/I67B1GFjxMN6ZmvG4oBOLfeC9SnofWIkE+nv17RiiXYR9aO6uS2ypqSaoCB8DDyjuaKXxRBIrIZrWJSulkDWcqF2A+T/IFAQ0eWcPD3GryY0pg4QlmwP2BGzyOfW1Oc5dFfbIOEpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R5tGNRC6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WMLr6d7aDO1D5C67sGe2tO20/t42i9KxkVB2oXY9K0A=; b=R5tGNRC64qfZm1zB2JbOx8Phfe
	Tg8S77j4EV+3jf6z1p+zcKsFtZIh4uUjcOT1dwNF7SJ8lB260hFgWHvAX5Xbzp4cTaxcBQhBOr49e
	ZNwKNkiEGtB9kugRLG49dyeaoCEY/pVmMqXeVK8gVj+nuR77kafdUWRpqbUk9T1PuhgDG1tDcRimI
	9SkAnzi8lUhfdhPgtrga6Vg0juExWxBUYTzFwxJcZK1oOmgY7qrMMqnGqa0TY0X7av6aibd/ACWwm
	nGJeHQJez49LpSkvDMGw6+ds4kK/23/8hJdq217hYgUtFuwkfcGWvhgHphvNpTYFsQC5XEqZb9yxG
	cjwQ0MbQ==;
Received: from [50.53.4.147] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW7tJ-0000000BMnW-3w2I;
	Tue, 23 Jul 2024 05:16:50 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: [PATCH] jbd2: fix kernel-doc for j_transaction_overhead_buffers
Date: Mon, 22 Jul 2024 22:16:47 -0700
Message-ID: <20240723051647.3053491-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct struct member name in the kernel-doc notation
to prevent a kernel-doc build warning.

include/linux/jbd2.h:1303: warning: Function parameter or struct member 'j_transaction_overhead_buffers' not described in 'journal_s'
include/linux/jbd2.h:1303: warning: Excess struct member 'j_transaction_overhead' description in 'journal_s'

Fixes: e3a00a23781c ("jbd2: precompute number of transaction descriptor blocks")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20240710182252.4c281445@canb.auug.org.au/
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org

 include/linux/jbd2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/linux/jbd2.h b/include/linux/jbd2.h
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1086,7 +1086,7 @@ struct journal_s
 	int			j_revoke_records_per_block;
 
 	/**
-	 * @j_transaction_overhead:
+	 * @j_transaction_overhead_buffers:
 	 *
 	 * Number of blocks each transaction needs for its own bookkeeping
 	 */

