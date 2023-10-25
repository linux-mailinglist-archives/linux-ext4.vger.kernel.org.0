Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484497D6F16
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Oct 2023 16:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjJYOj4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Oct 2023 10:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344792AbjJYOEA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Oct 2023 10:04:00 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665B185
        for <linux-ext4@vger.kernel.org>; Wed, 25 Oct 2023 07:03:56 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a6643ba679so40445839f.1
        for <linux-ext4@vger.kernel.org>; Wed, 25 Oct 2023 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698242636; x=1698847436; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmmBJe4qx/Z0FecJmP2HKoWoGSGv5MNLqFmWTEvkhKI=;
        b=a/8qgnaEyPA2+d8L9scDYh0UYOxTJMS3BK0vc5+KINadxbd8jQdWq6+LEwx98nOVly
         QYPXB7WikXnW7AijKNEUhH3X3mNTwxws0+hr9itZeAWfE7zkEv+j0sQaEQyDGjTfPI5m
         Z63kUysNIdyjWSZS7XeBfu+j3muxPa0v1WQoll8aqn8y9vFZVyrvshAYBcKoxkC03yT9
         Jsl+Syxfw0fyhDGofGoSgoVI/H2VyOu0CF4ILccExRaYfztxPUiyBg3E20syJ87UiipT
         ubsIRvA5ZZO5cfEixyMI9Idhv53GILJcjwqxvJauCzg0yB9iWlMK+e/gRdweVnuXGgAv
         jqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242636; x=1698847436;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xmmBJe4qx/Z0FecJmP2HKoWoGSGv5MNLqFmWTEvkhKI=;
        b=KXkqeIK9iJQtWmFQT7lQvUyNdWG0D6LtpABzGiMuiAdAgAA6YXe1N/RGwpNdzdCXXx
         nJvuIU4vJELCCIkbuZpWNFYwp1pqif0fAX1aEoOPByPfpjpUV7aRGd23DzwBJisIbaiw
         D5h9wEAjNTJUDmrBkZsWVzsphqSFgHF0oFnZxb3g4SYRUdjFEkY9OiLi1hALtMllJZ2o
         6zeDBxjdaFO11mvcM/yfVMfuTRn0TZ9QMIk9kvmH/yBN6M6USEOFbFnSShQv0S20+fVc
         XIGK8/HaE9tmMAjCAC/z6QUdCNH0983JQlrJol4g6Mu48Bv7BUK3fvLj1Lty3h2d7Q1y
         PTwA==
X-Gm-Message-State: AOJu0YxYEYnUJRaiGIN/7SlzjDgC3jRbwKZaelmCWnrUuZ9xBHkpSi0b
        bOcAY4TP1Wzb7yfOAn/D6rw2yij5s0zrIPLSV79QYQ==
X-Google-Smtp-Source: AGHT+IFYmFywKXAzWWhg4qfxKE9/pCPls+VDtDPHa5McGJtGQk0XUmWH7jSIpHWbdFzkwKTT1x9JWg==
X-Received: by 2002:a05:6e02:ec1:b0:357:a986:18ee with SMTP id i1-20020a056e020ec100b00357a98618eemr12760905ilk.1.1698242635601;
        Wed, 25 Oct 2023 07:03:55 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y13-20020a92090d000000b0034fccc27c11sm3735496ilg.76.2023.10.25.07.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 07:03:55 -0700 (PDT)
Message-ID: <48d0ea0b-af74-4a2e-9961-0286466050a9@kernel.dk>
Date:   Wed, 25 Oct 2023 08:03:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     io-uring <io-uring@vger.kernel.org>
Cc:     Andres Freund <andres@anarazel.de>,
        Dave Chinner <david@fromorbit.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring/rw: disable IOCB_DIO_CALLER_COMP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If an application does O_DIRECT writes with io_uring and the file system
supports IOCB_DIO_CALLER_COMP, then completions of the dio write side is
done from the task_work that will post the completion event for said
write as well.

Whenever a dio write is done against a file, the inode i_dio_count is
elevated. This enables other callers to use inode_dio_wait() to wait for
previous writes to complete. If we defer the full dio completion to
task_work, we are dependent on that task_work being run before the
inode i_dio_count can be decremented.

If the same task that issues io_uring dio writes with
IOCB_DIO_CALLER_COMP performs a synchronous system call that calls
inode_dio_wait(), then we can deadlock as we're blocked sleeping on
the event to become true, but not processing the completions that will
result in the inode i_dio_count being decremented.

Until we can guarantee that this is the case, then disable the deferred
caller completions.

Fixes: 099ada2c8726 ("io_uring/rw: add write support for IOCB_DIO_CALLER_COMP")
Reported-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/io_uring/rw.c b/io_uring/rw.c
index c8c822fa7980..807d83ab756e 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -913,15 +913,6 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		kiocb_start_write(kiocb);
 	kiocb->ki_flags |= IOCB_WRITE;
 
-	/*
-	 * For non-polled IO, set IOCB_DIO_CALLER_COMP, stating that our handler
-	 * groks deferring the completion to task context. This isn't
-	 * necessary and useful for polled IO as that can always complete
-	 * directly.
-	 */
-	if (!(kiocb->ki_flags & IOCB_HIPRI))
-		kiocb->ki_flags |= IOCB_DIO_CALLER_COMP;
-
 	if (likely(req->file->f_op->write_iter))
 		ret2 = call_write_iter(req->file, kiocb, &s->iter);
 	else if (req->file->f_op->write)

-- 
Jens Axboe

