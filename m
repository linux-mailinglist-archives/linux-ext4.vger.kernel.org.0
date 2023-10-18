Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3FF7CE4E6
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 19:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjJRRlq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Oct 2023 13:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjJRRlo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Oct 2023 13:41:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A02120;
        Wed, 18 Oct 2023 10:41:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BBFC433D9;
        Wed, 18 Oct 2023 17:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697650899;
        bh=oV0lFdI7Yn7QJ5JE87c+C5HW+Uto4gEIDr/OnGVhofo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GcpsqU3PkpNElzrRNZAh3XTjk9L9FU1ZFKJ0Nuy36O4dTnIGzGvLmzqNHSEPu56yj
         fwpfkupeILBixno66h7UwaC+ESWCL5Mn9+PHSEDIe/d39R2QJtMWQdIk9dtKO+8mBv
         fs9yJoR0RLy47E5axLbnbDIwRRY/K92Ahi/zp/JiYqTrHQqZBsRgMsLEMiI58WmFY7
         CPOULDJXAtNvZY2Y4tUNSA5fdezHHf+X+L8uPAgCasaFp2dpwPzXlw41p5JMyEMgSF
         V8IDjIp+cpdNbLf2y+84w2Z35QTu7OAnQl+JskaMxc+mKp7GxaRqPDtAUViX1j0jwi
         1qYxkdVgrYioQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 18 Oct 2023 13:41:10 -0400
Subject: [PATCH RFC 3/9] timekeeping: add new debugfs file to count
 multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-3-4a7a97b1f482@kernel.org>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oV0lFdI7Yn7QJ5JE87c+C5HW+Uto4gEIDr/OnGVhofo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjIZJAEh2EvSWsTRIXNUoSp+/gPrdnrW38DM
 8NdE4JkFmWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyAAKCRAADmhBGVaC
 FYbiD/0ZFfWVcuSGUPgSgemJY2MzGuMffXnd/jkl+/NHQ1nlRsWS01DWyVwdWucUQasEC1H0rdI
 5uXOT2GcTX/68+GO+2tqvb1JlhSnujcLZm1Lg456xiDlllxlwIhZ9tZrlYVCOrYuP8jEqXYvjZU
 V+pX3XjE/kpytbDpv4jBNXvd33alsrO1+bznAl0pM2sOm/dVXZQSQ8NYrpztvxjJk5qNLqUPS7Z
 U77qUZBIXUm2mQR8NpLwL471ld2/NmDB4pWDRjvCl9+E9LUaKW68g5iDdMrP1FYZEgo5nuBug26
 G9gk1+WG8MzsHsYFl6ELLbS2zBVqoMtrdqt568EogG7jT0bV9ZMQdIYySUOXW4QYfw8xmG5gMep
 x76CG8p1DUeFingRztj1TLljnTJOBjvvu6/y4uHysrrk48R5ZJgW10j9GNfzFxlmWLjzROb5uq1
 DrLstWJYcyyzYThiFx6ceWhtadCHD8oOozKVH0QwA2Iz6TUjCXq4wmT/TUthsNQ64iTwZKIscuS
 i8Te9fkr7v+sjrBd7L3KROqoW+H82LEsMIQaJGP7fXOLTpmGndcbF9RRWYs3TY48ha1YUBvq1tG
 mr5XAlH/ldtbzv9DCdGsn+zCmXwMuFoPEEiGSzhQzKBi1Xi62s7eCGftf2cmFcAvZBqTr8ByLyl
 avNZl9vDKp3Z4KQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add two percpu counters for tracking multigrain timestamps -- one for
coarse-grained timestamps and one for fine-grained ones. Add a new
debugfs file for summing them and outputting the result.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/time/timekeeping.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7c20c98b1ea8..c843838cb643 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -24,6 +24,8 @@
 #include <linux/compiler.h>
 #include <linux/audit.h>
 #include <linux/random.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
 
 #include "tick-internal.h"
 #include "ntp_internal.h"
@@ -59,6 +61,9 @@ static struct {
 
 static struct timekeeper shadow_timekeeper;
 
+struct percpu_counter mg_fine_ts;
+struct percpu_counter mg_coarse_ts;
+
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
 
@@ -2326,6 +2331,7 @@ void ktime_get_mg_fine_ts64(struct timespec64 *ts)
 
 	ts->tv_nsec = 0;
 	timespec64_add_ns(ts, nsecs);
+	percpu_counter_inc(&mg_fine_ts);
 }
 
 /**
@@ -2361,6 +2367,7 @@ void ktime_get_mg_coarse_ts64(struct timespec64 *ts)
 		ts->tv_nsec = 0;
 		timespec64_add_ns(ts, nsec);
 	}
+	percpu_counter_inc(&mg_coarse_ts);
 }
 
 /*
@@ -2581,3 +2588,33 @@ void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 }
 EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
+
+static int fgts_show(struct seq_file *s, void *p)
+{
+	u64 fine = percpu_counter_sum(&mg_fine_ts);
+	u64 coarse = percpu_counter_sum(&mg_coarse_ts);
+
+	seq_printf(s, "%llu %llu\n", fine, coarse);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(fgts);
+
+static int __init tk_debugfs_init(void)
+{
+	int ret = percpu_counter_init(&mg_fine_ts, 0, GFP_KERNEL);
+
+	if (ret)
+		return ret;
+
+	ret = percpu_counter_init(&mg_coarse_ts, 0, GFP_KERNEL);
+	if (ret) {
+		percpu_counter_destroy(&mg_fine_ts);
+		return ret;
+	}
+
+	debugfs_create_file("multigrain_timestamps", S_IFREG | S_IRUGO,
+				NULL, NULL, &fgts_fops);
+	return 0;
+}
+late_initcall(tk_debugfs_init);

-- 
2.41.0

