Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054CB2B80F5
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgKRPmO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbgKRPmG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:42:06 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C7AC0613D6
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:06 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 190so1410372pfz.16
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=U8cT2QAxIu96iJauReA/Bomb7qYfmerVWdtdZDUXkJc=;
        b=ieWkSbTJT2eRJ0ussxH4h+s7Q9RzySxvlo/HcKSWQ41JRkrxV8Fzi7GK+3y/fT5Ii0
         C3A82WjR/130nzSX501okoxhDg4pOVPz7pJlXKrrgsVR+WWpD0BDlMDQSYyJrEVizVuC
         xlElv+Gd+v95iuJJbOCadJd4R0D6KrtKx277mMYCq2T2Vm0ARt+F/IOKura+nAdmQjiG
         +NW/HIuj0mfGGtO4KkfkEVZNuvpk5+IDBYijri7HjbKbj7icdj8pXcWa499/d9GBgCeq
         eN+Zgk3isFkZrgLgD+uHza9mHVHRA876+jl96QQUW6x9yH23kuNdnzeBHpr+b7FC0AZi
         G5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U8cT2QAxIu96iJauReA/Bomb7qYfmerVWdtdZDUXkJc=;
        b=oPKDRUFwKbWMdCs6q9pKCgGbP5Anrg+Da1NTcSvtG9aJc8aZr8W91cHq+y7yZsIC/7
         pct3TCOm3m7mJNRtlYSUKCy64lveGfx+qBSAz/C4Z493WaHAqLMO8lEmkoMXC0621hQy
         WqU1zKi3jsa+QLAXUkPY7d32qqAlJR3SHCSC/9KtYzMLckIEFF6ccp0Q/4kGiFz/yMlt
         3YzhFiZNtgRsly5IfqPO/ZYo5w1AV22WRtpc48ZHRHaMHzDHK9+qF8HTUdmKW89aj+zu
         S52NtK1q3LL1how7LxNfSXI5Ne1aWAsAb/UAa7MoSIIAkCIc77mKHjviaYQHp0jgDEna
         yRTA==
X-Gm-Message-State: AOAM5325HFflxzGgIpjVfwmSRge6rtwOrH+z5bM8w4iLczT7WMzM6Ain
        L0jt97ZQaq+Fkl9qui1KinPxJN8eP8MR2iYZO042aiiliRa00NPF6e7Aee4H09lycXkuGQatyRe
        vyX81dmnH0+nDXLG+T55LqN1iwA18Ty3sEL8fbd+ATncmTlBJMvXze5JVGJUBjMuh5KO7ZmuWy1
        RfAlArwrI=
X-Google-Smtp-Source: ABdhPJxJCO87gq/s83j2s7BtGFQSCdze9wgLoP2bZ9yP6jW2UUdL4zCoH0SrX/m7gPblcQxn2ofjIAsth3kneWI1ZSQ=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:902:8c8a:b029:d6:d1e7:e78e with
 SMTP id t10-20020a1709028c8ab02900d6d1e7e78emr4744264plo.39.1605714126081;
 Wed, 18 Nov 2020 07:42:06 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:39 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-54-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 53/61] e2fsck: fix f_multithread_ok test
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Andreas Dilger <adilger@whamcloud.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Andreas Dilger <adilger@whamcloud.com>

Don't use $OUT for both the input amd output of a pipeline,
as the output file is truncated befor the input is read.

Fix the handling in the failure case to generate the
*.failed file, and print the actual $test_name instead
of "test_name".

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 tests/f_multithread_ok/script | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/f_multithread_ok/script b/tests/f_multithread_ok/script
index 4010881b..c62c93ce 100644
--- a/tests/f_multithread_ok/script
+++ b/tests/f_multithread_ok/script
@@ -5,15 +5,15 @@ SKIP_CLEANUP="true"
 
 . $cmd_dir/run_e2fsck
 
-cat $OUT1 | grep -v Thread > $OUT1
-rm -f $test_name.ok $test_name.failed
-cmp -s $OUT1 $EXP1
+grep -v Thread $OUT1 > $OUT1.tmp
+cmp -s $OUT1.tmp $EXP1
 status1=$?
 if [ "$status1" -eq 0 ]; then
 	echo "$test_name: $test_description: ok"
 	touch $test_name.ok
 else
-	echo "test_name: $test_description: failed"
+	echo "$test_name: $test_description: failed"
+	cmp $OUT1.tmp $EXP1 > $test_name.failed
 fi
 
 unset IMAGE FSCK_OPT SECOND_FSCK_OPT OUT1 OUT2 EXP1 EXP2 
-- 
2.29.2.299.gdc1121823c-goog

