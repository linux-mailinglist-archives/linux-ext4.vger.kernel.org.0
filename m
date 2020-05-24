Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB0E1E03CA
	for <lists+linux-ext4@lfdr.de>; Mon, 25 May 2020 00:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgEXWxV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 24 May 2020 18:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387863AbgEXWxU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 24 May 2020 18:53:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24CC061A0E
        for <linux-ext4@vger.kernel.org>; Sun, 24 May 2020 15:53:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d10so7910648pgn.4
        for <linux-ext4@vger.kernel.org>; Sun, 24 May 2020 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5/CL6aE3lmoBkiGBNUyn08WPxVC9RpbRIRWnD6gEim0=;
        b=d4I2rw7JyAW6c5tLLKj1CoCnyw7IOmQ1KKrOwsDYwRs97Mmv63Gk/06vSP6J6nYyHK
         xCpSMKh05Caa4OKGqNQvqQ2auPfEnVWLK06yudWFzFLncqjzrd6x8lm6kSWitlY3K4UE
         k+BZuxSCpKnqaa0DEFDTGovBPJa5ootz6bEwUqQgtDTS7tTwNcgW33fKKyNMmqMQ0Ta+
         Uc/AhTd6oOjopjG7DsUrJX3tXVVWAtRsMrIKnzW3iAWTfQAVHg5ae0DX9n9B02hfnUmF
         s61DsVtvjeuylg2DkMc47wGqPahEd3xedSVBUHK8K3k43Rh6IgSJCTy9wdhwXlVvI5BB
         dnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5/CL6aE3lmoBkiGBNUyn08WPxVC9RpbRIRWnD6gEim0=;
        b=k0Rh6sXn1/oiEeX8OGxS2ihrkJoYU35Qu1E3MOCo6OHIRqJ2GqhBiBdgSnbu2VV3eu
         RQfhIMLD/qWIzZRB9VS7NgFWHKqPEhmttHUUB2L8p7pP6z9gR5+1CU8sy2zsj+phx+jp
         uUWWcdxS0mvC4oXnXDD4neALoubUc4yZp8SxAZibDWw0XNdf/wvgFoxCP2tV11ZlxYSU
         AcFWck5QPyVYkS3VIkw7CwlBn+94t15K5D/icIijNrxB6Up23/TN9Tn34SwmoFm4wEeH
         Q61Hhkc3Ws/+RtN31G5fB2huu8CNMql5s2kZiWC0U2IblHNMFVQeE4HQCVT12gDBEC/w
         iBZg==
X-Gm-Message-State: AOAM530vjbdjPlVY0clGFqK9YL87J4Boq4UViahDKAAToMInx6q0PmM3
        njfN3StVN8i5vxRF7wQeuMJQmHjwAArRgA==
X-Google-Smtp-Source: ABdhPJwrw0jm5eq4OdEjBfgOQdC7cuwT1GdTriTUSRgWkXw8y5uo23p69JfqObr0AqTJHoxbHUfOIQ==
X-Received: by 2002:a05:6a00:d2:: with SMTP id e18mr15029510pfj.252.1590360798612;
        Sun, 24 May 2020 15:53:18 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:343d:8ab7:4cee:d96f? ([2605:e000:100e:8c61:343d:8ab7:4cee:d96f])
        by smtp.gmail.com with ESMTPSA id w65sm1540434pfb.160.2020.05.24.15.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 15:53:17 -0700 (PDT)
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ext4: don't block for O_DIRECT if IOCB_NOWAIT is set
Message-ID: <76152096-2bbb-7682-8fce-4cb498bcd909@kernel.dk>
Date:   Sun, 24 May 2020 16:53:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Running with some debug patches to detect illegal blocking triggered the
extend/unaligned condition in ext4. If ext4 needs to extend the file (and
hence go to buffered IO), or if the app is doing unaligned IO, then ext4
asks the iomap code to wait for IO completion. If the caller asked for
no-wait semantics by setting IOCB_NOWAIT, then ext4 should return -EAGAIN
instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0d624250a62b..3ac95f4cada6 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -495,6 +495,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret <= 0)
 		return ret;
 
+	/* if we're going to block and IOCB_NOWAIT is set, return -EAGAIN */
+	if ((iocb->ki_flags & IOCB_NOWAIT) && (unaligned_io || extend)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
 	offset = iocb->ki_pos;
 	count = ret;
 

-- 
Jens Axboe

