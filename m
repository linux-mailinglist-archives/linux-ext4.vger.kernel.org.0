Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA44BF80
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2019 19:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfFSRWX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jun 2019 13:22:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39317 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfFSRWX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Jun 2019 13:22:23 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so308204iod.6
        for <linux-ext4@vger.kernel.org>; Wed, 19 Jun 2019 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E3jskMxg6mXOnAk1TRm40OOCGhyEHDf4Luejh67p06E=;
        b=XJUjnADzObWPEkqAra7JZG2MqVf6jOIl2xtoUl1SDnE0wuok4jfWhzqw1sqdOy1MdG
         ukIsu9ZRYZ7Odf66ee9EScvXI8+ziKIaEoU1vAYC/d16vXG5k7/dNvwAB5MjWlb1v9J5
         LJYYWKu+nb0iK/BWTUe5n9zeCPnxh/3JNBMQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3jskMxg6mXOnAk1TRm40OOCGhyEHDf4Luejh67p06E=;
        b=buSLazojhPWC/Wy70kAa/fHEADym3ZUG5lGEzhsUMR8n7Bj/hD1gjXQgzydCUpPuTR
         qBA33KSini0A2/+CeAiNVdKyeWxCJpMACdniHOyZY5q5W4Iyp5yCKI71/YYSs3BUb4DO
         gPcNcvS0zrE4F086/WTDM5++sW3i8ScNtJVcs35wquGKVNh9CqovEhZqrZaT9N4mAYHk
         1V+xYU9cZgqXJtHHGTM1ajH5IZBVohIlZBiZsxsE7GjkCXMndtU71rzj9FolvWPsHBAk
         TtbLyYrW5zArHLfYlfa/GtXHUQrldPU2v8DrAeFPXNo3ZpxvIC2uGEFdo+Wif7EsRLak
         KaVg==
X-Gm-Message-State: APjAAAV9t4iUVDMnNfSf2G3z4AEdhYFg1ch2DcRWlj0B48sfY5dl5Bzx
        A3sEu5zJOXlvZdmlsv1fqHSvDA==
X-Google-Smtp-Source: APXvYqzUJ4kHlMB8oH2as8CG6GkE5UrM7Ov3FQ1gEUbkCnWiEbXHPUBrf42GwGzGyQpr2zjdPsDhvg==
X-Received: by 2002:a02:cd82:: with SMTP id l2mr11507623jap.96.1560964942675;
        Wed, 19 Jun 2019 10:22:22 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id y17sm17889989ioa.40.2019.06.19.10.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 10:22:22 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
Subject: [PATCH 1/3] mm: add filemap_fdatawait_range_keep_errors()
Date:   Wed, 19 Jun 2019 11:21:54 -0600
Message-Id: <20190619172156.105508-2-zwisler@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190619172156.105508-1-zwisler@google.com>
References: <20190619172156.105508-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the spirit of filemap_fdatawait_range() and
filemap_fdatawait_keep_errors(), introduce
filemap_fdatawait_range_keep_errors() which both takes a range upon
which to wait and does not clear errors from the address space.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d3..79fec8a8413f4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2712,6 +2712,8 @@ extern int filemap_flush(struct address_space *);
 extern int filemap_fdatawait_keep_errors(struct address_space *mapping);
 extern int filemap_fdatawait_range(struct address_space *, loff_t lstart,
 				   loff_t lend);
+extern int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
+		loff_t start_byte, loff_t end_byte);
 
 static inline int filemap_fdatawait(struct address_space *mapping)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index df2006ba0cfa5..e87252ca0835a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -553,6 +553,28 @@ int filemap_fdatawait_range(struct address_space *mapping, loff_t start_byte,
 }
 EXPORT_SYMBOL(filemap_fdatawait_range);
 
+/**
+ * filemap_fdatawait_range_keep_errors - wait for writeback to complete
+ * @mapping:		address space structure to wait for
+ * @start_byte:		offset in bytes where the range starts
+ * @end_byte:		offset in bytes where the range ends (inclusive)
+ *
+ * Walk the list of under-writeback pages of the given address space in the
+ * given range and wait for all of them.  Unlike filemap_fdatawait_range(),
+ * this function does not clear error status of the address space.
+ *
+ * Use this function if callers don't handle errors themselves.  Expected
+ * call sites are system-wide / filesystem-wide data flushers: e.g. sync(2),
+ * fsfreeze(8)
+ */
+int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
+		loff_t start_byte, loff_t end_byte)
+{
+	__filemap_fdatawait_range(mapping, start_byte, end_byte);
+	return filemap_check_and_keep_errors(mapping);
+}
+EXPORT_SYMBOL(filemap_fdatawait_range_keep_errors);
+
 /**
  * file_fdatawait_range - wait for writeback to complete
  * @file:		file pointing to address space structure to wait for
-- 
2.22.0.410.gd8fdbe21b5-goog

