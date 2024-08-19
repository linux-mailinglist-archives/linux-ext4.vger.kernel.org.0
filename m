Return-Path: <linux-ext4+bounces-3782-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D78195707E
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 18:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C3D1C22D73
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F0186294;
	Mon, 19 Aug 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU8Wq2PB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C781177982;
	Mon, 19 Aug 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085383; cv=none; b=FPmegN3e4eK5uYlhzO8jqBh2omMNH7mfQVhJP/4S7ge+ahmirnXD/weYqp2voj/Kf5DTK4lvPYXEXVADv7LAWjR7cz+WCIBTFF8ix7oDqbupKPObX4f4QF+h0Tu1PJ46TqyC6mlRYIdBB38xdMUS8sg+WIs8lPkoPzEuLUA7Rvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085383; c=relaxed/simple;
	bh=oAbT2/V//sASh2FB6mLAQ8KsBx4tO2mGToNZf4q0kVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbbokNFFgN+Y02ikXmt28CMONVfkE5UG+Hn2Se0R3rXnXF7SxhxZR4pnbAZKgaODs/C7OO12eve4/4clHlvyReWY7eVQdAK/lVjAevT6BnXCr1eMyQQytOfw3qP3Inq//9kOjmdbUvlvp8HsdJrb7fehVlwSfeJnGsveYwFDhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU8Wq2PB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-713f3b4c9f7so952075b3a.2;
        Mon, 19 Aug 2024 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724085381; x=1724690181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5fZaX5oWZGeD9RQxsXePn4lL7p20ba09HGY/1Px244=;
        b=kU8Wq2PB28DZzDBuoKe4kB5c/OGdzSWXzytajLLw7Iax1sUlEna4n/9VGSwRi58IRt
         v6Rnc+IHaSKRg3d/EMRWGTkZlls5JirsYEhfrAxkONDObUBxOwQmvqjwnHmi3HGhgog9
         /IMSYDRjqSmKNC05aft3lzu5r6k5IhfVmobrVoIgGA4nO1DIe9w83jRcHzgAjswrytMm
         o3M+04qt1JoPryCCKHWmoPv1TUS+j19k3jC8TKXpu+fPyB3pwAJ6zIyoPVChs0pkCoU3
         upoCH6n5Tux1PUSRRVtd+abPgRjKk/KoMXih87pTQJpLqtf2tPwL9I8hvWxgpQToGr1y
         Dr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724085381; x=1724690181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5fZaX5oWZGeD9RQxsXePn4lL7p20ba09HGY/1Px244=;
        b=T3GRBeZFU7xeC0SaJcoBC3dbURyWaRMj+o/3SAb2Vgah47E7mhhAmpun9aKQnVsP5D
         bTW0ZDiWaSZ1ynWeYkyWxG3Bo4yc0uLhuqUbOyasInkXAIGqBxmLBZz+Xqs9g+fBMdE/
         LsxQ8xus+Bteds7a89PEzbCKEfWLhRhrzrOY/YkvbwE28oVnFjgnCQ6YhZuRS8PF52zo
         G8E6N5gZVTwB9nmGbGE6XoLXcNVUS3iWdBQJkuj0KFXhn2aJ4ExhrkZZZVj1dOWz8DjB
         /7hz18JhLNifMD3weVv4pQO2nlO/3jAjlqYd+/ndledfKxvh4i+Htn4s9dv77u8QM5o0
         3woQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp5i2gCrQDcpFYdbOBwWrUed+26yn7RcfJhUVe273M06zAp4VpF99TZwndo59BHGf3EXbk2mGaJ2WkzmCJUipx98E11WAUImZ+XvS4KfS64rYUaBK1JodTfDFOCWeJo9S/OWsJgAhwlA==
X-Gm-Message-State: AOJu0YyE5aSzHUvgWcIiPlVVZ7fQpcbIVwFmKWQLY1Hh44j55K0Jyiet
	MXBJdaO9yn44OjanLQfYdw7nn1EZwerRg9UQe3/SVKNE08s+B3Iy
X-Google-Smtp-Source: AGHT+IHXMzdy5JC5AIH8g12qAViEn1EOAzudKsOxTgFug0BxHwp4du4zV5efVM1rl3xCQ/tWwkzBLQ==
X-Received: by 2002:a05:6a00:2d26:b0:710:7fd2:cb2 with SMTP id d2e1a72fcca58-713c4dffd3amr14162442b3a.6.1724085381134;
        Mon, 19 Aug 2024 09:36:21 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:14f0:322b:1aea:d241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6e46sm6993765b3a.17.2024.08.19.09.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:36:20 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: skhan@linuxfoundation.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] doc: jbd2: Fix documentation warnings for jbd2.h
Date: Mon, 19 Aug 2024 22:06:16 +0530
Message-ID: <20240819163616.21076-1-vamsikrishna.brahmajosyula@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix documentation warnings for struct journal_s in jbd2.h

Fix the following warnings:
./include/linux/jbd2.h:1303: warning: Function parameter or struct member 'j_transaction_overhead_buffers' not described in 'journal_s'
./include/linux/jbd2.h:1303: warning: Excess struct member 'j_transaction_overhead' description in 'journal_s'

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
 include/linux/jbd2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5157d92b6f23..17662eae408f 100644
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
-- 
2.46.0


