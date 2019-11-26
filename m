Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC059109AA9
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2019 10:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKZJEJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Nov 2019 04:04:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35823 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfKZJEJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Nov 2019 04:04:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so177133pgk.2
        for <linux-ext4@vger.kernel.org>; Tue, 26 Nov 2019 01:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q0NyiXArr22g/79WISVgXRe8UCxDj8zYXXjWPELgzlM=;
        b=dj6PtWr5gbBoP+UCR8Qy7owESK8KHu6yuPC4wpC0wwEpqrMJAcHenwgnYL/fE2XYo9
         rdcBZns6Nnz2B/ibH+h9FB8YkWfl0+3flMVDsldQdI5ZcoZen46/89tzJZdKa6jLIK4N
         UUmPq3Tk2Hg8kBL3aiVR1h5wrgNEmc/DVg3NtGWCgvtF0rQ8u3ClVElWpeaBVLJ9SEg+
         KpTZuYsHXj53+nM5lYEu46DmTqtedNY6EdyndNolo/2UUEeAvVOJzUzM+JOFpYHP8R6A
         W9nOmZVRVD/wa+46FwF7g6uTaa9PCpKPhdmOU7crCkv7KLWhy4EwR+Cc4gC23w24JgNT
         ukMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q0NyiXArr22g/79WISVgXRe8UCxDj8zYXXjWPELgzlM=;
        b=AfG7v4STFcVrHiDYS3yQG6yfNLq9fewGH1F1qia7uuLsPLY7AeSG426WAwgYIGnXZs
         pJQ+bpvEn8MZnwzDvhDgvqaLzR0zux14xKN2FNCbCMU1eFkV5/T9o59ZZU8LpHmrL29n
         KWjmj6CCBAB59wDmdxxVPPf0cxEBto2l0ymI9TSt1F9L5pT7tllsmhuZ2C7ad0RzaCSK
         Rf3Bst6fZ1nubDH71UExh2kbs9wCdv5t0qe5ipLKkDeZFrUnRBeaSw6QsqtpCvcz2ydA
         V/i8b7Rt/QayYv6sti0yNHeIdEYb9Mh5QR7ZMMZNSgobHBF8Gwwr7uo18cIqnvWq78a3
         B5Hw==
X-Gm-Message-State: APjAAAU43c6uLzBtsH46nd/CLfxP/e4+FM+KENGE54WqzKhrKoB3Hc0C
        G3fhz3aGr45X6dT7mRZ9OEr2eppXEm/m96eZ
X-Google-Smtp-Source: APXvYqx+yagte3FMT1P1zO4Wgv4i17ZqyoKAVQWQ7oQfLmMI1dqm1yOFuk5OiVvYwYbNCtNmd2ORPg==
X-Received: by 2002:a63:1a22:: with SMTP id a34mr35781584pga.403.1574759048457;
        Tue, 26 Nov 2019 01:04:08 -0800 (PST)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id b17sm11969851pfr.17.2019.11.26.01.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 01:04:07 -0800 (PST)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca, lixi@ddn.com, wshilong@ddn.com
Subject: [PATCH 1/2] e2fsck: fix to return ENOMEM in alloc_size_dir()
Date:   Tue, 26 Nov 2019 18:03:58 +0900
Message-Id: <1574759039-7429-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Two memory allocation return check is missed.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/rehash.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index a5fc1be1..5250652e 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -272,7 +272,11 @@ static errcode_t alloc_size_dir(ext2_filsys fs, struct out_dir *outdir,
 		outdir->hashes = new_mem;
 	} else {
 		outdir->buf = malloc(blocks * fs->blocksize);
+		if (!outdir->buf)
+			return ENOMEM;
 		outdir->hashes = malloc(blocks * sizeof(ext2_dirhash_t));
+		if (!outdir->hashes)
+			return ENOMEM;
 		outdir->num = 0;
 	}
 	outdir->max = blocks;
-- 
2.21.0

