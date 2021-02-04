Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD703100CB
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Feb 2021 00:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBDXg4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Feb 2021 18:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhBDXgz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Feb 2021 18:36:55 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6CDC061786
        for <linux-ext4@vger.kernel.org>; Thu,  4 Feb 2021 15:36:15 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g15so3219314pgu.9
        for <linux-ext4@vger.kernel.org>; Thu, 04 Feb 2021 15:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/cCceaH1n7LgzmHcAPZwFCH3eC5URKt6b5rYiHgVWo=;
        b=vC75VFqSLPj0tDeCCSzSUCCUXc2mpoZs8NX38ab+ot3ZkoMqfZfr0+2E6bTpuEUUcL
         kShH9SW2bDvwjZoLz+Eqy9FS0dddEzTc3UFo0NxbfjHlYQuxsHd/JWC4QrsgbO8+7o7Z
         jhB7fb/ZqaYJenLwbEkYAhDhyxhtM0VgXRHSznjBGguE7paLhXVOGfOFLzLy8Skq/912
         70OHDu4d9Noq1QBoGEg0mAw960LtrnRrJZqrCycboRhayH/uE8UQel1F+T/tfpm04xU6
         EXqTa/5N9VsrSEbRwV69XNEtH69pCSCzORYs+TJ9FfTGri49SOLofr8Au34dVtjTMOzs
         aKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/cCceaH1n7LgzmHcAPZwFCH3eC5URKt6b5rYiHgVWo=;
        b=Zx+GeJyksPqal0tkHRU5stDv06hCdG2QqYwxkHoqFThIXAOEE8diBvLQ8terNLtmk5
         wa/T1CAkjmstZ/02jBSbrUfYKkmMP+iXYc+u/33EeSJExEyrF0EsW9jti+wVzDmNY7be
         znoTjgIzy2I0sKPLhKWf+s+V4d40DbiatobirZGMQiOXecT1yUeERYSnTm2oDQPjwcmj
         Zy+YHIrVJ5h1ZG21Ae2mtie0nf1asGrQdqNbe3geuZjAuNsz+ezAW8+QmQ+mFMc0EIuJ
         xNcJHcdsMVnQvRL8r2Y9RWN0IJPIus3t2hos8PhvBeX0mJlXhEp4nRmIqZXwfKcbAFV+
         DRoA==
X-Gm-Message-State: AOAM531n/YwqsQWz22doMqOeT7YvmS/Ko7Kj1WSm8rvvwzFtbrjtq4Tj
        QuNTk0RV+9ji+zpf0hpUCi1QNzbiTwo=
X-Google-Smtp-Source: ABdhPJwsK0d9GpsvE8J3ulowrUq2+wOZchMC73geopESyhpKrC6y04YfOgzyrzgYGONfvBh6clGlUA==
X-Received: by 2002:a63:e310:: with SMTP id f16mr1466908pgh.160.1612481774565;
        Thu, 04 Feb 2021 15:36:14 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:5142:d9c7:4222:def5])
        by smtp.googlemail.com with ESMTPSA id mv14sm10236149pjb.0.2021.02.04.15.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 15:36:13 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/3] e2fsck: don't print errcode if the errcode is 0
Date:   Thu,  4 Feb 2021 15:36:00 -0800
Message-Id: <20210204233601.2369470-2-harshads@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210204233601.2369470-1-harshads@google.com>
References: <20210204233601.2369470-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

We print the error message corresponding to errcode while converting
errcode to errno. Don't do that if errcode is 0.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index b1ca485c..922c252d 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -383,7 +383,9 @@ out_err:
 
 static int __errcode_to_errno(errcode_t err, const char *func, int line)
 {
-	fprintf(stderr, "Error \"%s\" encountered in %s at line %d\n",
+	if (err == 0)
+		return 0;
+	fprintf(stderr, "Error \"%s\" encountered in function %s at line %d\n",
 		error_message(err), func, line);
 	if (err <= 256)
 		return -err;
-- 
2.30.0.365.g02bc693789-goog

