Return-Path: <linux-ext4+bounces-3690-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DF294D74F
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 21:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8251F1C2216F
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 19:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851315D5A1;
	Fri,  9 Aug 2024 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y187kFt5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3828101E6;
	Fri,  9 Aug 2024 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231842; cv=none; b=iskEcMJQKMxvr2QBSoFxSxGaN9/jNeZlTblqnBAo7g3rl7PnPfE3Y7i07SWNqwxDzX6NgKBgGH3Maqo449kg8qRheeea7vDEJZ2WI5IwzI3ag7yGjo2/jkXZM6TkG9BISpcHTuy8pGriHFhwY4WA8MSjWdcXnNY1+OM93fwrlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231842; c=relaxed/simple;
	bh=WZ8SwuMUov7X6Llv77snzRlzn91CJOudvQ9L5glaeR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jcns9+rGfkLoELTAullw4s8AMP3xYVjkJE+nnKftl/iAH89m5qOrQ1DbV2ezu/kpKMOsd+BosPfGVTQZVLc3ts5uwzWICzfWk+pIl9VSXQ2m6y8nDEBsPjVqk7DG+PS3tN0vqNitpGjYiZZCZo0kWhRdnt82sw7Xc/Ibb0LCv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y187kFt5; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db145c8010so1587423b6e.3;
        Fri, 09 Aug 2024 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723231840; x=1723836640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CgSxb2UgjDh9Kwmgwd9YAvPsr2Q0YrQopOK6MSBZhM0=;
        b=Y187kFt5Ku8kLP1rsUXnexQWuFaiPEKkK9IB9LnNE8/MmJ7lUMkD/1xQi8vtGJ8vO1
         /Z3sFA1fFwRgqTo08uSWX685B+RF3zxbTRRmTxQ56ix4B/xCOForVFiprrvQRI849wkB
         5x0qe6g7+QowsYs3ySf99dgFLTHZuAFPlX0oK5pK5grYurnzwwHms4Vk/IMocxkAeCH9
         5UD7Doat6Syol+2YNK6t3SI2C3sJJFsxtG3qqAh+rwsUH9w3wQUijxS99FApZDvNQby6
         9NTNpMj5Xq+bmCdT0wdCxwjAHrbo1fus+4OdwvtBk3j3ptzsbCyyLIxIF9uJ1XMaquWq
         yPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723231840; x=1723836640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgSxb2UgjDh9Kwmgwd9YAvPsr2Q0YrQopOK6MSBZhM0=;
        b=nu9hK0ZksqSeGsDDm1XjR81AV4Qz7KyLR35CndX8XPu7/XRqGPM0fkCJ/KgENkhKwt
         jm2vWFMXpDeOeehLz+dDoEVLOSS0Bcp+JjOUutmLgJ5LcNtnCOmPA4PXo7Ikeoyut3VL
         tIQy+etIM2m4gG4bh8vLSYJV11p+AbAL/WuX34fEnWgIs3G5xOxBOj3FpZfCvsOVssas
         qO+nGOjioaxd/JfWjUwecTqIiAKzMOZaf87sXljG+YYnSkZj5ugEH7jY8XdzVYgm7gh0
         3l1vVLNCAkcvUiRtq27i7FSLW7LELuVPlRK1E0W7ijA0UVZJ5EzcTRXDfaqZPvO9kFW3
         s2Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUgLqDplaXmK2Bh9lhTq885xe0LfZVxEwgu6X2YYMk6Gqz7/XeT2ot37dzWOMHzGbF6iWWvO0YXSYmSPRQevz8KtDb48JVxciRs3kW5Zs41UiuD7+Ja+koDm5VIW6NPtTPZXfOlmAcefg==
X-Gm-Message-State: AOJu0YyKfzSXcKQmkS7x7MKeCKrNtPMZA6ZMGjprywKGWndADODst9+D
	waQewaVoTophBuEHXbGvyN2egaE3kt/iNPPwP37iPNP4t2CGMttd
X-Google-Smtp-Source: AGHT+IFYgqdX4zdAmfBAD7JRVp63QtVdWxgn3ydxkyygDZP9qF+Od0WlL7lfEFKkvBzI+p7IDi+1Ag==
X-Received: by 2002:a05:6870:b69f:b0:260:f827:243c with SMTP id 586e51a60fabf-26c62c83d34mr3117004fac.12.1723231839667;
        Fri, 09 Aug 2024 12:30:39 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e451-b7c6-baa2-2646-98fa-e895.emome-ip6.hinet.net. [2001:b400:e451:b7c6:baa2:2646:98fa:e895])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a815a0sm111550b3a.146.2024.08.09.12.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:30:39 -0700 (PDT)
From: Jing-Ping Jan <zoo868e@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Jing-Ping Jan <zoo868e@gmail.com>
Subject: [PATCH] jbd2: correct member name in document
Date: Sat, 10 Aug 2024 03:30:31 +0800
Message-Id: <20240809193031.72060-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two warnings that seems related when building the htmldocs.
It seems the warnings are cause by a discrepancy between the struct
members in the documentation and those in the source code.

Signed-off-by: Jing-Ping Jan <zoo868e@gmail.com>
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
2.25.1


