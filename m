Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5690154FF5
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 02:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBGBR5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 20:17:57 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.138]:60364 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBGBR4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 20:17:56 -0500
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id zs9SiRcpt17ZDzs9UiUgmF; Thu, 06 Feb 2020 18:09:49 -0700
X-Authority-Analysis: v=2.3 cv=ZsqT1OzG c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=ySfo2T4IAAAA:8 a=lB0dNpNiAAAA:8
 a=KjjfyWZL2dlP1ZKsOugA:9 a=ZUkhVnNHqyo2at-WnAgH:22 a=c-ZiYqmG3AbHTdtsH08C:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH 3/9] e2fsck: avoid mallinfo() if over 2GB allocated
Date:   Thu,  6 Feb 2020 18:09:40 -0700
Message-Id: <1581037786-62789-3-git-send-email-adilger@whamcloud.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
X-CMAE-Envelope: MS4wfOHde0K32nLEvijb8mfmFT8kM7/76GliIsZ0QklZEDTiCBP3plZrFh+ygqz9JZ9dzd7TT4iPv6zdz9tutrPzHTllYuuCwyqbgvzUBfXKi5NSDi/wtFVh
 cyl3TSNRlCCpPjAkWAaQD5+62iWHbSyQDz8gwOAFnPenbIKXKdh9iXUbnttlRQ5A+JhCw/pjzywvgS/w+lb8rUFRMPu5l8J4yXgmc9w+65qxRxqkNhoNRyM8
 dBH54cfy15ZcTQJgFAnJtA==
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Don't use mallinfo() for determining the amount of memory used if it
is over 2GB.  Otherwise, the signed ints used by this interface can
can overflow and return garbage values.  This makes the actual amount
of memory used by e2fsck misleading and hard to determine.

Instead, use brk() to get the total amount of memory allocated, and print
this if the more detailed mallinfo() information is not suitable for use.

There does not appear to be a mallinfo64() variant of this function.
There does appear to be an abomination named malloc_info() that writes
XML-formatted malloc stats to a FILE stream that would need to be read
and parsed in order to get these stats, but that doesn't seem worthwhile.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Reviewed-by: Shilong Wang <wshilong@ddn.com>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197
---
 e2fsck/scantest.c |  4 ++--
 e2fsck/util.c     | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/e2fsck/scantest.c b/e2fsck/scantest.c
index 6131141..ed3595f 100644
--- a/e2fsck/scantest.c
+++ b/e2fsck/scantest.c
@@ -76,8 +76,8 @@ static void print_resource_track(struct resource_track *track)
 	gettimeofday(&time_end, 0);
 	getrusage(RUSAGE_SELF, &r);
 
-	printf(_("Memory used: %d, elapsed time: %6.3f/%6.3f/%6.3f\n"),
-	       (int) (((char *) sbrk(0)) - ((char *) track->brk_start)),
+	printf(_("Memory used: %lu, elapsed time: %6.3f/%6.3f/%6.3f\n"),
+	       (unsigned long)((char *)sbrk(0) - (char *)track->brk_start),
 	       timeval_subtract(&time_end, &track->time_start),
 	       timeval_subtract(&r.ru_utime, &track->user_start),
 	       timeval_subtract(&r.ru_stime, &track->system_start));
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 300993d..e3d92b3 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -421,9 +421,6 @@ void print_resource_track(e2fsck_t ctx, const char *desc,
 #ifdef HAVE_GETRUSAGE
 	struct rusage r;
 #endif
-#ifdef HAVE_MALLINFO
-	struct mallinfo	malloc_info;
-#endif
 	struct timeval time_end;
 
 	if ((desc && !(ctx->options & E2F_OPT_TIME2)) ||
@@ -436,18 +433,21 @@ void print_resource_track(e2fsck_t ctx, const char *desc,
 	if (desc)
 		log_out(ctx, "%s: ", desc);
 
+#define kbytes(x)	(((unsigned long long)(x) + 1023) / 1024)
 #ifdef HAVE_MALLINFO
-#define kbytes(x)	(((unsigned long)(x) + 1023) / 1024)
-
-	malloc_info = mallinfo();
-	log_out(ctx, _("Memory used: %luk/%luk (%luk/%luk), "),
-		kbytes(malloc_info.arena), kbytes(malloc_info.hblkhd),
-		kbytes(malloc_info.uordblks), kbytes(malloc_info.fordblks));
-#else
-	log_out(ctx, _("Memory used: %lu, "),
-		(unsigned long) (((char *) sbrk(0)) -
-				 ((char *) track->brk_start)));
+	/* don't use mallinfo() if over 2GB used, since it returns "int" */
+	if ((char *)sbrk(0) - (char *)track->brk_start < 2ULL << 30) {
+		struct mallinfo	malloc_info = mallinfo();
+
+		log_out(ctx, _("Memory used: %lluk/%lluk (%lluk/%lluk), "),
+			kbytes(malloc_info.arena), kbytes(malloc_info.hblkhd),
+			kbytes(malloc_info.uordblks),
+			kbytes(malloc_info.fordblks));
+	} else
 #endif
+	log_out(ctx, _("Memory used: %lluk, "),
+		kbytes(((char *)sbrk(0)) - ((char *)track->brk_start)));
+
 #ifdef HAVE_GETRUSAGE
 	getrusage(RUSAGE_SELF, &r);
 
-- 
1.8.0

