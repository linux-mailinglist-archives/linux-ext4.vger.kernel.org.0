Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D786E3B3B
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Apr 2023 20:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjDPScI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 14:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDPScI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 14:32:08 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3666B1FE3
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 11:32:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517baf1bc87so1664649a12.0
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681669926; x=1684261926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGh0bl/iiJSxy7fHnW3+jIlzjVgyckmk8BLBlFYvTkY=;
        b=pS5+8rLiWyKIMN+luqPLxN8jBBhaf4UeVDWqYONloKt+a7mcY9ZET6EK/7+kaK7yxW
         T1P/04l9RqzqQeYBZJCc7f1Iw/s02D9vSCiIope5Os6kKuTo3MpAEJ2579CKGfErb/wV
         StNN/GRY0VcgJRPjAPyOh+qo//ZctzHWARYK6IOJbDfMf5mPgiAxWjbjknaOLTpCjDYm
         yuO1AgP5qx2KqxK3n4/CoYIzsXsaG+CISCTz4vvbllfiGuLN/DtrfNtTl8GFXGdVUboV
         KaEe0t3REszhN6HcjaSOgtcwZSPNHHIfgEAQF9sO21QLw0qy9e9Mtqo2Qdy1gtA/8XyW
         8Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669926; x=1684261926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGh0bl/iiJSxy7fHnW3+jIlzjVgyckmk8BLBlFYvTkY=;
        b=U9HTLZwsPftw0lPB5/3o9JltlJiefn8yv9uvWDe7k7VKITd8dCAz4IYHudw2zXr6GX
         2kc3C/4R4Dr+6PBLTUKHMz9ZeD8jp+052SAQWluV6ToCnMqpbAiAaqDcvi/+j1fyXK5K
         fk+/gSpxmujyktROZ1eKeY53evkkvRGwd1fEkU6CNRnSu9yiRx7+z9Pr42DH9rVv1Oge
         8nUVyO6/nXhb0dzt5mVUx8iBHapdF0U1tTtwr7ssKEEMCllehWlm4kYx1p6gDqyBO/Cg
         jbnfgJo7GAC376n0G48cNMju/lbtHoxb5hc+MvIVUAIAD9qf3Bvh1UQwOUQ1dt3oJnxD
         UvbA==
X-Gm-Message-State: AAQBX9co2ZW/SVrAwy5hiG4PJKS0VjvdFd1Xgrfe4Y5IfI+r7fjw45yN
        8ig+ouy00Lt0pNedIfb1ZeY=
X-Google-Smtp-Source: AKy350aMLXGHRwyRzzEIG06FxGAJ1KFDosv3rpQydcEeHtpzmhHf7DrxVTjoTNgccpFEhDrsgeqHtg==
X-Received: by 2002:a05:6a00:148d:b0:63b:64a6:571 with SMTP id v13-20020a056a00148d00b0063b64a60571mr14612532pfu.29.1681669926460;
        Sun, 16 Apr 2023 11:32:06 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b00639fc7124c2sm6397480pfm.148.2023.04.16.11.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 11:32:06 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 0/4] ext4: misc left over folio changes
Date:   Mon, 17 Apr 2023 00:01:49 +0530
Message-Id: <cover.1681669004.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Matthew,

Could you please review this series. I found this during code review and
I think these can/should go in as well along with other folio changes queued up
for 6.4 (after some testing).

Also had a query w.r.t your change [1]. I couldn't understand this change diff
from [1]. Given if we are making the conversion to folio, then shouldn't we do
len = size - folio_pos(pos), instead of len = size & ~PAGE_MASK
Could you please tell if the current change in [1] is kept deliberately?
At other places you did make len as size - folio_pos(pos) which removes the
PAGE_SIZE assumption.

-static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
+static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 {
-	int len;
+	size_t len;

	<...>

	size = i_size_read(mpd->inode);
-	if (page->index == size >> PAGE_SHIFT &&
+	len = folio_size(folio);
+	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(mpd->inode))
 		len = size & ~PAGE_MASK;
-	else
-		len = PAGE_SIZE;
-	err = ext4_bio_write_page(&mpd->io_submit, page, len);
+	err = ext4_bio_write_page(&mpd->io_submit, &folio->page, len);
 	if (!err)
 		mpd->wbc->nr_to_write--;

[1]: https://lore.kernel.org/linux-ext4/20230324180129.1220691-7-willy@infradead.org/


Note: I haven't yet tested this series completely. I mainly first wanted to get
some initial inputs from Matthew on this one before I do any serious fstests
testing of the changes. If the changes are in the right direction, I shall
do some testing before sending next revision.


Ritesh Harjani (IBM) (4):
  ext4: kill unused function ext4_journalled_write_inline_data
  ext4: Change remaining tracepoints to use folio
  ext4: Make mpage_journal_page_buffers use folio
  ext4: Make ext4_write_inline_data_end() use folio

 fs/ext4/ext4.h              | 10 ++-----
 fs/ext4/inline.c            | 27 +-----------------
 fs/ext4/inode.c             | 57 +++++++++++++++++++------------------
 include/trace/events/ext4.h | 26 ++++++++---------
 4 files changed, 46 insertions(+), 74 deletions(-)

--
2.39.2

