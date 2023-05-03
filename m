Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6514A6F5C1C
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjECQfo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 12:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECQfn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 12:35:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53E4EEB;
        Wed,  3 May 2023 09:35:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aafa41116fso26753495ad.1;
        Wed, 03 May 2023 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683131739; x=1685723739;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqiIgSYBmUSzWim3hBWXe1W12WpOZgYh+xzvDgKOOAw=;
        b=W1tFB2+rwjx6tMmAekvWbZVVqMRhxalnyPEGwn8gATJRxnzhDaJkYFanHkr6x9s/gW
         IJaaDT6apSrA226M46h60X1/OAegcJZG6atBaSi9vcw+xX6o/ir3B8Aha1x2vMB32weB
         aIn2qpE1LgxqrEmo2zkKQ1hT5YorpJ7KU+Tw+mtokqT3egS9nXMD5AIM1DVrGz4lAOuf
         Z3meXnzemn8g9ECxx6sAAdwdAsk9obtG/2x+m3+gfJDygN8bKIG01mP+QLuOr7D9Y3vb
         pqYKYZvpi1Czxcyacx2BjHqVUlXy1AufVJ97+2FUItZ2z7CDINJ+l15yNGTkCQ6Tz/Bw
         G/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131739; x=1685723739;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqiIgSYBmUSzWim3hBWXe1W12WpOZgYh+xzvDgKOOAw=;
        b=k9dBpfocMiCXSGaLK82O1QCZMHh0aGdX0PQupvKB2/3ajOaIR7MioF5HJnwSuaU3fV
         7SPkiGZ5bGSJ7SZ+mfHmj4unTd4RaljxfNetCbHq1c2K1y0ko+OJYGZa68RrjfmS3IZv
         moFQ9gmUrAF1CYWJe4Mk8OzabRI5jiA4zfpzqp5GR026EBot9exmM3uJ3OTa/LV/Bg1q
         fOkWBCO0J8kP46hsEeOzD5R30iItBtqlbXp95LxDLARs/+34O6q/1LN7yhI+0kKUUjgW
         vlgL4/C1H2xcw9akOEOSOx+5PQZzXpJaKrMaGrqdHa3x13jY1Ho2zXAaKPJ26/cv0XnZ
         ibog==
X-Gm-Message-State: AC+VfDygG7EVNeWkZybT1EF5lFeWgp99iktaw4qbiANVpAKWZsVAWiku
        pU0zc16HwkcuxzDJnfCPmMs7YNp3X8Ld9ls10EY=
X-Google-Smtp-Source: ACHHUZ5LNIap3AEAr5bDyr6KOWhiALFsbKfZ+U2oDCmmm8nXCng7uC6vudOkgDxlAVqFxzYZ1sk0cQ==
X-Received: by 2002:a17:902:b18f:b0:19e:dc0e:1269 with SMTP id s15-20020a170902b18f00b0019edc0e1269mr651757plr.7.1683131739541;
        Wed, 03 May 2023 09:35:39 -0700 (PDT)
Received: from MSI-FindNS.localdomain ([95.174.71.27])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902d2c400b001a5260a6e6csm8111509plc.206.2023.05.03.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 09:35:39 -0700 (PDT)
From:   Yue Zhao <findns94@gmail.com>
To:     stable@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH 0/1][For stable 5.4] mm: migrate: buffer_migrate_page_norefs() fallback migrate not uptodate pages
Date:   Thu,  4 May 2023 00:34:25 +0800
Message-Id: <20230503163426.5538-1-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Recently we found a bug related with ext4 buffer head is fixed by
commit 0b73284c564d("ext4: ext4_read_bh_lock() should submit IO if the
buffer isn't uptodate")[1].

This bug is fixed on some kernel long term versions, such as 5.10 and 5.15.
However, on 5.4 stable version, we can still easily reproduce this bug by
adding some delay after buffer_migrate_lock_buffers() in __buffer_migrate_page()
and do fsstress on the ext4 filesystem. We can get some errors in dmesg like:

  EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #73193:
  comm fsstress: reading directory lblock 0
  EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #75334:
  comm fsstress: reading directory lblock 0

About how to fix this bug in 5.4 version, currently I have three ideas.
But I don't know which one is better or is there any other feasible way to
fix this bug elegantly based on the 5.4 stable branch?

The first idea comes from this thread[2]. In __buffer_migrate_page(),
we can let it fallback to migrate_page that are not uptodate like 
fallback_migrate_page(), those pages that has buffers may probably do
read operation soon. From [3], we can see this solution is not good enough
because there are other places that lock the buffer without doing IO.
I think this solution can be a candidate option to fix if we do not want to
change a lot. Also based on my test results, the ext4 filesystem remains
stable after one week stress test with this patch applied.

The second idea is backport a series of commits from upstream, such as

  2d069c0889ef ("ext4: use common helpers in all places reading metadata buffers")
  0b73284c564d ("ext4: ext4_read_bh_lock() should submit IO if the buffer isn't uptodate")
  79f597842069 ("fs/buffer: remove ll_rw_block() helper")

This will lead to many lines of code change and should be carefully conducted,
but it looks like the most reasonable solution so far.

The third idea is replace trylock_buffer in ll_rw_block() with lock_buffer and
change ll_rw_block() in __breadahead_gfp() to trylock_buffer. However, 
this will change the semantic of ll_rw_block(), and will not be suitable for
some readahead circumstances. Besides, the ll_rw_block() has many occurences
among many filesystems other than ext4, I think it is better to limit the
fix in the ext4 filesystem without affecting other filesystems.

Here I send the patch based on the first idea, hope someone can give more ideas
about how to fix this bug in kernel 5.4 version, thanks.

[1] https://lore.kernel.org/linux-mm/20220825080146.2021641-1-chengzhihao1@huawei.com/
[2] https://lore.kernel.org/all/20220831074629.3755110-1-yi.zhang@huawei.com/T/
[3] https://lore.kernel.org/linux-mm/20220825105704.e46hz6dp6opawsjk@quack3/

Yue Zhao (1):
  mm: migrate: buffer_migrate_page_norefs() fallback migrate not
    uptodate pages

 mm/migrate.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
2.17.1

