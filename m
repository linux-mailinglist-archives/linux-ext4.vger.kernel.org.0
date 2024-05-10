Return-Path: <linux-ext4+bounces-2452-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB8C8C278B
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2024 17:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC4F1C2232F
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2024 15:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B4F17165F;
	Fri, 10 May 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdjjvtrz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449A17109F
	for <linux-ext4@vger.kernel.org>; Fri, 10 May 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354581; cv=none; b=gq6oC/kMRM/bfysejX1PfKRDr7WpIrxjqFnd6qb37c3mT1yAQrk8JshAw9Vo6zODL8lgoqJAJCx7PriKWB2eQ+PkDW5iodL0gfsef9SL7d4yQ5KomJnMCkRZKwcyfFS+bug6hCwye/ApJg3sWPUR6ahWRKar+kz9oY6d5QFzMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354581; c=relaxed/simple;
	bh=xDmeGB3ZsvbdC9b0Eap8RfCmxjnpKodqPjIW7iJ+0cA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=au0NQjtsa8+Ebj9IWw48Gh/TUhbo3W5bN5rKlr3VmuOIkbwfsW/S+FEDEj5fSszraUOLnxRiHV5ggSUMjTkVwMvHRLSHnTtvq8jOFHWxcLw/ExkXg7Yluzc1qGqcVPKPi3EhYiUeXgMudu8pQ0jLIlHvfZnkNPcds2nCgMFOURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wdjjvtrz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a2c05006aso149018766b.0
        for <linux-ext4@vger.kernel.org>; Fri, 10 May 2024 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715354577; x=1715959377; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BP4hiObhnrJXL+AshuqLMzgV0aIGD7OqswBGKEywkcQ=;
        b=wdjjvtrzfxJbVJe2qYnLGpcFGHz2/giNsfEJFuWLweXJnUQbvKqZ4QQI19WYVAAybq
         NBdfPRAoOakva1F1pSWjYhEK5YuytDZUzE5CxE4HzDwM9PizaFGkrLSwaWvw+6RybydK
         91UScMG8dLLsNcWJ12QCvOAyjiNas7ScLh1qaqyS4dF+BMiaHUECUEZBOVXJwgfzvWDJ
         lEJCd8GUR/2hVCfaGYjU3yCAX4/hb0PeaeB1/tZx+OmMntjoIYiYEK396G+UQmZ/BNcn
         NtV+5dauAyWI54DjTnvJ8kiD0EKKLEp0xZwJtsWgEw/B9am0kauGhBSH2l5bAUKHHCmB
         cb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715354577; x=1715959377;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BP4hiObhnrJXL+AshuqLMzgV0aIGD7OqswBGKEywkcQ=;
        b=m28oSqS17qB4Kt9vf4WWzRquU/PGwrqRlMsVOT9Vy7fFatJwMKIm+RQqcSZP5kbShg
         +I9DDeFHfAkNxrIk/nIzVLwCXJPzDwKN0tKpyhGc/p89V2eb7diTCEHACvvduSw6tbX3
         LYaUedWNvQQX9ba5S6bgZQ13zET5Ss61qcsjoUJkb9rkzNNLZ+42c6KddhBUpMG30s4H
         MAegKJRniA4CiZg5LlwmJ7r82KAE+o0bbg1LjfVeiLZK4Vpb/ULIc+RgPt+kVFMLnL2L
         77HiO29FHZnMnlnABcly4gCNzeUC5MFl/AdtkWUQo5qcRbr5XDrWWK1UlNm4iHcny2+l
         Ey9A==
X-Forwarded-Encrypted: i=1; AJvYcCWVTgw5wF+FHFGaqP6dZ96KC1SbzGbtmeFhfrY8opMqumO4RAnS5dvCnCTIhiNBauju1SnHl4A00x3wqNbgNc4PQAVEzoCrGHjXsg==
X-Gm-Message-State: AOJu0YwYmwKbLC20kLHqO8CC56BK1QXOVVKWrgAVJp2xDeDVDjj/FvfY
	6ZWdsvsZqWMHqi//h+mGAhV66F8UeelrdU34IniFa8kFzs16yMZiLkJ1MvanIk0=
X-Google-Smtp-Source: AGHT+IECyncmlyBZlx8POXK4gXnXiaTjEWCp1Q9Ts1yOT/JsMxgrlDRoEy7sB5jOG9XSuixGma2Gug==
X-Received: by 2002:a50:9ea5:0:b0:572:a731:dd18 with SMTP id 4fb4d7f45d1cf-5734d5c2570mr2746612a12.18.1715354576789;
        Fri, 10 May 2024 08:22:56 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb52asm1925091a12.74.2024.05.10.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:22:56 -0700 (PDT)
Date: Fri, 10 May 2024 18:22:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: fix error pointer dereference in
 ext4_mb_load_buddy_gfp()
Message-ID: <eaafa1d9-a61c-4af4-9f97-d3ad72c60200@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code calls folio_put() on an error pointer which will lead to a
crash.  Check for both error pointers and NULL pointers before calling
folio_put().

Fixes: 5eea586b47f0 ("ext4: convert bd_buddy_page to bd_buddy_folio")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 648989c125f2..9dda9cd68ab2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1717,7 +1717,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	return 0;
 
 err:
-	if (folio)
+	if (!IS_ERR_OR_NULL(folio))
 		folio_put(folio);
 	if (e4b->bd_bitmap_folio)
 		folio_put(e4b->bd_bitmap_folio);
-- 
2.43.0


