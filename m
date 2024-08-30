Return-Path: <linux-ext4+bounces-3975-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF1A9656FB
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 07:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09FE284B33
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 05:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF24150989;
	Fri, 30 Aug 2024 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnoSVZ/Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC7136351;
	Fri, 30 Aug 2024 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996270; cv=none; b=ATsmAXjnQz1pXk0NthpXP2SozETgfU/BIXQMtlXqnLHPMiPs/hAhy9NOeEYxrdZmZkeObrKmgqjzgupGigfL2aPN0MjzFneSRfAkhONYQZ13ONSainRJfXplnwhSeHvnWfmxk/0nmEIoyXEa5YPP3ESzTTrd2AfSfg91qFBVmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996270; c=relaxed/simple;
	bh=nuQv1OLBf2ugiCywOpIdcyS0cvAkW50Sitj+r8HjmIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AdHM0ofxZ4enSI1PWOLr5UPFcr+4C5zpRiwUCTZiVfr1pUQmWV9JvvWKtUX/C9nlipiuvvJZOL7dleV9b2WlkFMc723RD/RD8zNh1T+KWf6rtIs6fHIRKuZFjW2Wx7TgHpwEyIBTVfN3fsO0En1fTAM3WEr+gK4nnX3THIZiMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnoSVZ/Q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-202089e57d8so10353015ad.0;
        Thu, 29 Aug 2024 22:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724996269; x=1725601069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdVUpClNZhLv7aynuPjXbG3fkC0bU3f1/3YjjjbDagc=;
        b=MnoSVZ/QcU9yxA2PisMyHVOSAbhFrD8nYi7aoubT0VnXtKviBqPWUEzIA13H1L5JsI
         CjLSlXfqOJy63tDVOvTZ6o5XkKFavFjDBU59+OkXwzrd+Fr9XCpgfNFnK1jwVLMY0rw5
         6lMc/ao9n42YlodCw3GHiqQ5YlxsrZ8NXpFGMYpxLhoBOLXkQcyfAjUKlrVSriaDd9WP
         HYHR7rcMqWV3WD30FjVl/Y72hV8KB+4dr+w6EJvScF8Iqk6Qwf9tt0tSwf8nUNRn0LA6
         94ZBqQadLwdRFY/S6qOSKnj8lGoC7owPKs4PfQ74T5xc9L85Kwmn1UTsMt72lR3QPkWn
         NJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724996269; x=1725601069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdVUpClNZhLv7aynuPjXbG3fkC0bU3f1/3YjjjbDagc=;
        b=cL7dBRyXUM9q98sFz0cAJUrXhBpN1GiIHg16XsVkcZCsrf8KAHFkdwR1mnwSrB0DFm
         l9jHTAZ5B/c4+5xhi65ULPZ8Kf5bUlIrxFlxvPKc60yeIc4a/zQk5tIH1WB63qEUxv4r
         SCXcSH6wmQYlm2h/EudvjqcCQ2mV3opmcZHkLUKzF7y6cN/OKDyrvEmvq1gcBzW/oJl9
         /RkoqE67tx8y/lXBGrxNcnTsA90nja/FvoKELkGNtN9MAy9nIXMee90QbZ27xVMc2ftu
         DxCzTOCxtxZCeRC1aWB4Il8FQJFDm0zAe50BN7X2siMQQvPXZCcnEj7GiEOEUNGBIuKS
         eCaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbCkkksPBrIYcbAFDwBAK7fl70XzkIqBfKAEtPrnsmjMspvxfqnC5aIiS9qvIq63xCoIbl1V54wziFOa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9L10BjdVgRI66noTu0DifIBKoaq71ql8nKxYpNEsXYoLjFm5O
	AnSnuApwGXMPMqxMKJnGcSnreNGkRp6KjZUXCoET3aJghVpJzrAb
X-Google-Smtp-Source: AGHT+IFpWsVes4diSrUdlF9BJ1BIG9NfIS8lOK21oPRW1rgU8knTSpNvsLNnAnM6puQn3y280G76Tw==
X-Received: by 2002:a17:902:e5cf:b0:202:2f0:3b83 with SMTP id d9443c01a7336-2050e9804e1mr71789405ad.13.1724996268556;
        Thu, 29 Aug 2024 22:37:48 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534801sm19784075ad.154.2024.08.29.22.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 22:37:48 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com,
	ebiggers@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/4] ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers
Date: Fri, 30 Aug 2024 13:37:36 +0800
Message-Id: <20240830053739.3588573-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830053739.3588573-1-zhangshida@kylinos.cn>
References: <20240830053739.3588573-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

For new uptodate buffers we also need to call write_end_fn() to persist the
uptodate content, similarly as folio_zero_new_buffers() does it.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..a0a55cb8db53 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1389,9 +1389,9 @@ static void ext4_journalled_zero_new_buffers(handle_t *handle,
 					size = min(to, block_end) - start;
 
 					folio_zero_range(folio, start, size);
-					write_end_fn(handle, inode, bh);
 				}
 				clear_buffer_new(bh);
+				write_end_fn(handle, inode, bh);
 			}
 		}
 		block_start = block_end;
-- 
2.33.0


