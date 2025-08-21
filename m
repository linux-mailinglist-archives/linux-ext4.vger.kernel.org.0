Return-Path: <linux-ext4+bounces-9505-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24068B30633
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92CF1D21759
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586AA3705BF;
	Thu, 21 Aug 2025 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FdjFDnSf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3862370580
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807625; cv=none; b=jwTJaDxo8ySyM/wLxUERN+TK5edu6xNYxtzyPZBOcXdXg16gXqIearDEkyxKhnVjPCCVDEq1bbkpuMA0wkYkJo1E7PszL2zcxscgFZB0pu18mB82+OxHCWme7KW7kJA+evwCZhwCml6UU0J+oKO1a/jVbViMkqj/tITm81COmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807625; c=relaxed/simple;
	bh=D93quPOEYKV3ecF80PgDZ/SBCUn+YEd3pA6H3kfuds8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxmg7q77Ce9JfroQjwGysDQyndvkIAxc9pz8UIfIFFa19tCVwLQT1IfrIhl6xdZzPHboTolB65bvYTA9WG7GRZ4zJj9mTYD+aalyzJJWmvHjkt2nBwyuY32MR516gJACDg7UBN5CUm/ZAlLrexeuczugC2TjnNYUDnph9B8schY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FdjFDnSf; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603a269cso11770287b3.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807622; x=1756412422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAA7yBTxTE6ptsf2bLIbVrVMiD/7hA8aK0cz9PGFZKo=;
        b=FdjFDnSfQSraijqQk4sRFY1Q/f7Na957iwTOMAMkV1vDWbUvnYX2c9jm+Yecn59Xq8
         e9Q4yUlnAJCLAhN5PJYMxOnLHYJSjOzF6j2uUDUE6kQ8mcd3s8H4BNXU2hZ4WitqIVuj
         qixhh10usq3B5ANJPaoMcOzpggFR8xj2FL6aSdI01WzbzpNowVYIAOBUW1AyVDoN5jQq
         nDkwe7pbw7Za7iaoc9ZYC7eFA8PhSSeBu7zM2bPx6XcIUPaN43cnMIPUDi9C7lA1tNQj
         aK0FRgEzqRhXrZDu+xMw1XYe/+LwFIHw38nuBKNmlvSOLLFhviwZKra/h3h6JGnrwkYt
         tHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807622; x=1756412422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAA7yBTxTE6ptsf2bLIbVrVMiD/7hA8aK0cz9PGFZKo=;
        b=GTZsBrBka2zCJ2HxBchArpIq60pYXY3ykCL9i/7tQ6dgLJKWee/Dyaw7s9xLOoSU9b
         Ozlf3zy5/hkcf0Owpce2j7TFa1GBfskj72Z2n8cS4nccABsuypd0pNSPxyJN3WVsSP/N
         OUgMQkMNbdELZGjRjUoCfrW+K9x1zBDazUzglPVaiomZXHIbw4QqJDg3aJ3pI5zBmWMY
         9NeGfqCXHp+6yVqiZbHPIx722KAQjHEw/itUxcvqgVhf+Dtx3NqCRjt2WyVXNSt5YRUk
         XD34sGUhKUlD0Ie6vMkaslm8+tOuJWJ7vDM7fYMHlbcKDDYlQVRMhhqSv1f2ZbJI0jTR
         s7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd5IBp8U0QS+o6boJ+Ah19pjmNYBGMAT/8nOnFW6zcUulRPs5KQz8IQYRnBCFVC5EFz5m9rZI2eI/2@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0RSZPrnKJT4bBvqAONQ8/JBv7Q3BqVvbkQaEM6Kw+qlfKo14
	DZ/wCDmcMYYESN6Y/VpJ5xy8G2KlRbafy18C0WzdhqLo/n7CE+C559XgWZtZjLcdWHQ=
X-Gm-Gg: ASbGncuEbkaIL+v3WZmfyLJk/74wany5KefTw9fuEkQfsw9mArqxFMzVV1LqVaQu79t
	YE08RPVvoJkqQ8LUo3+/tofZyWOGnQ5PErlJps3AaFERanQVCAoEqXKaiYSto5Jzs9VWK3XJNYh
	O51HSALtv1hSprHpI+SzaIQTlK/9qAJCdqW3J7JJxIhqYmfn1jnxht+madxlgToNO1SoCpd42Xf
	gF4Frn2uHdIqCrD3yTUiUYJfPdNWEmxcDKFnuviKVtj5E4RBaPrdKoU6R/2Ta+DMclWxjUab7xy
	3Sr7ZJqUBP628Np1r16m5hg4nQxGwv6mj0HznOk8XDCfl36R+8c7BPNNIE9DH42eFHnt1kQo0AE
	M+L5+ISBUU6D1dgb23LT6BVFKDiSql9kigQZcMsNFmIvZTCB0j8r4Sofo73U0fRTFATzsZHRfze
	qXWAKq
X-Google-Smtp-Source: AGHT+IGv4NhJf1cT6NIbqZa/4R9/wEW3Dk34Z/qOn5/BwvXw6MJR1AIUtLA2xvcvi2nVywQSjYDnPA==
X-Received: by 2002:a05:690c:4b89:b0:719:5664:87fd with SMTP id 00721157ae682-71fdc40e0aamr6490137b3.37.1755807621709;
        Thu, 21 Aug 2025 13:20:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6de96c79sm46567797b3.11.2025.08.21.13.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 04/50] fs: hold an i_obj_count reference for the i_wb_list
Date: Thu, 21 Aug 2025 16:18:15 -0400
Message-ID: <39379ac2620e98987f185dcf3a20f7b273d7ca33.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're holding the inode on one of the writeback lists we need to have
a reference on that inode. Grab a reference when we add i_wb_list to
something, drop it when it's removed.

This is potentially dangerous, because we remove the inode from the
i_wb_list potentially under IRQ via folio_end_writeback(). This will be
mitigated by making sure all writeback is completed on the final iput,
before the final iobj_put, preventing a potential free under IRQ.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 001773e6e95c..c2437e3d320a 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1332,6 +1332,7 @@ void sb_mark_inode_writeback(struct inode *inode)
 	if (list_empty(&inode->i_wb_list)) {
 		spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
 		if (list_empty(&inode->i_wb_list)) {
+			iobj_get(inode);
 			list_add_tail(&inode->i_wb_list, &sb->s_inodes_wb);
 			trace_sb_mark_inode_writeback(inode);
 		}
@@ -1346,15 +1347,26 @@ void sb_clear_inode_writeback(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	unsigned long flags;
+	bool drop = false;
 
 	if (!list_empty(&inode->i_wb_list)) {
 		spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
 		if (!list_empty(&inode->i_wb_list)) {
+			drop = true;
 			list_del_init(&inode->i_wb_list);
 			trace_sb_clear_inode_writeback(inode);
 		}
 		spin_unlock_irqrestore(&sb->s_inode_wblist_lock, flags);
 	}
+
+	/*
+	 * This can be called in IRQ context when we're clearing writeback on
+	 * the folio. This should not be the last iobj_put() on the inode, we
+	 * run all of the writeback before we free the inode in order to avoid
+	 * this possibility.
+	 */
+	if (drop)
+		iobj_put(inode);
 }
 
 /*
@@ -2683,6 +2695,8 @@ static void wait_sb_inodes(struct super_block *sb)
 		 * to preserve consistency between i_wb_list and the mapping
 		 * writeback tag. Writeback completion is responsible to remove
 		 * the inode from either list once the writeback tag is cleared.
+		 * At that point the i_obj_count reference will be dropped for
+		 * the i_wb_list reference.
 		 */
 		list_move_tail(&inode->i_wb_list, &sb->s_inodes_wb);
 
-- 
2.49.0


