Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1A34B9BF8
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Feb 2022 10:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbiBQJZy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Feb 2022 04:25:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbiBQJZy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Feb 2022 04:25:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 193A62819AD
        for <linux-ext4@vger.kernel.org>; Thu, 17 Feb 2022 01:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645089924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwcTCsKwutXoErWuWFZ+IUKzvQZnQs1kq0Rk37/P/Os=;
        b=cgdOP6vCVAvt+BrT72JYGHvGvmQvKcD0Rjfv/fGJi8dr6gGjPQcexdxEbgn5k8zQDl7DSr
        P9FA2PvDHCKWzX21lq8lQH2xtigFtXFS4hW6o02ZspmjkoLwrt+lUbLYaJleRPyyhYa8lK
        J3P1+oBBwcmU6IC0eqWAs3uxTAzhGA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-o_-OHeNeO3C8_WSH4IofyQ-1; Thu, 17 Feb 2022 04:25:20 -0500
X-MC-Unique: o_-OHeNeO3C8_WSH4IofyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B5118397A7;
        Thu, 17 Feb 2022 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7A1D7B6CA;
        Thu, 17 Feb 2022 09:25:18 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 3/3] e2fsprogs: use mallinfo2 instead of mallinfo if available
Date:   Thu, 17 Feb 2022 10:25:00 +0100
Message-Id: <20220217092500.40525-3-lczerner@redhat.com>
In-Reply-To: <20220217092500.40525-1-lczerner@redhat.com>
References: <20220217092500.40525-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

mallinfo has been deprecated with GNU C library version 2.33 in favor of
mallinfo2 which works exactly the same as mallinfo but with larger field
widths. Use mallinfo2 if available.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 configure               |  2 +-
 configure.ac            |  1 +
 e2fsck/iscan.c          | 11 ++++++++++-
 e2fsck/util.c           | 11 ++++++++++-
 lib/config.h.in         |  3 +++
 resize/resource_track.c | 13 ++++++++++---
 6 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index effd929d..530bc77c 100755
--- a/configure
+++ b/configure
@@ -11254,7 +11254,7 @@ fi
 if test -n "$DLOPEN_LIB" ; then
    ac_cv_func_dlopen=yes
 fi
-for ac_func in  	__secure_getenv 	add_key 	backtrace 	chflags 	dlopen 	fadvise64 	fallocate 	fallocate64 	fchown 	fcntl 	fdatasync 	fstat64 	fsync 	ftruncate64 	futimes 	getcwd 	getdtablesize 	getentropy 	gethostname 	getmntinfo 	getpwuid_r 	getrandom 	getrlimit 	getrusage 	jrand48 	keyctl 	llistxattr 	llseek 	lseek64 	mallinfo 	mbstowcs 	memalign 	mempcpy 	mmap 	msync 	nanosleep 	open64 	pathconf 	posix_fadvise 	posix_fadvise64 	posix_memalign 	prctl 	pread 	pwrite 	pread64 	pwrite64 	secure_getenv 	setmntent 	setresgid 	setresuid 	snprintf 	srandom 	stpcpy 	strcasecmp 	strdup 	strnlen 	strptime 	strtoull 	sync_file_range 	sysconf 	usleep 	utime 	utimes 	valloc
+for ac_func in  	__secure_getenv 	add_key 	backtrace 	chflags 	dlopen 	fadvise64 	fallocate 	fallocate64 	fchown 	fcntl 	fdatasync 	fstat64 	fsync 	ftruncate64 	futimes 	getcwd 	getdtablesize 	getentropy 	gethostname 	getmntinfo 	getpwuid_r 	getrandom 	getrlimit 	getrusage 	jrand48 	keyctl 	llistxattr 	llseek 	lseek64 	mallinfo 	mallinfo2 	mbstowcs 	memalign 	mempcpy 	mmap 	msync 	nanosleep 	open64 	pathconf 	posix_fadvise 	posix_fadvise64 	posix_memalign 	prctl 	pread 	pwrite 	pread64 	pwrite64 	secure_getenv 	setmntent 	setresgid 	setresuid 	snprintf 	srandom 	stpcpy 	strcasecmp 	strdup 	strnlen 	strptime 	strtoull 	sync_file_range 	sysconf 	usleep 	utime 	utimes 	valloc
 do :
   as_ac_var=`$as_echo "ac_cv_func_$ac_func" | $as_tr_sh`
 ac_fn_c_check_func "$LINENO" "$ac_func" "$as_ac_var"
diff --git a/configure.ac b/configure.ac
index dff3d1ca..8acc4e1c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1214,6 +1214,7 @@ AC_CHECK_FUNCS(m4_flatten([
 	llseek
 	lseek64
 	mallinfo
+	mallinfo2
 	mbstowcs
 	memalign
 	mempcpy
diff --git a/e2fsck/iscan.c b/e2fsck/iscan.c
index 607e4752..33c6a4cd 100644
--- a/e2fsck/iscan.c
+++ b/e2fsck/iscan.c
@@ -109,7 +109,16 @@ void print_resource_track(const char *desc,
 		printf("%s: ", desc);
 
 #define kbytes(x)	(((unsigned long long)(x) + 1023) / 1024)
-#ifdef HAVE_MALLINFO
+#ifdef HAVE_MALLINFO2
+	if (1) {
+		struct mallinfo2 malloc_info = mallinfo2();
+
+		printf("Memory used: %lluk/%lluk (%lluk/%lluk), ",
+		       kbytes(malloc_info.arena), kbytes(malloc_info.hblkhd),
+		       kbytes(malloc_info.uordblks),
+		       kbytes(malloc_info.fordblks));
+	} else
+#elif defined HAVE_MALLINFO
 	/* don't use mallinfo() if over 2GB used, since it returns "int" */
 	if ((char *)sbrk(0) - (char *)track->brk_start < 2LL << 30) {
 		struct mallinfo	malloc_info = mallinfo();
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 3fe3c988..42740d9e 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -430,7 +430,16 @@ void print_resource_track(e2fsck_t ctx, const char *desc,
 		log_out(ctx, "%s: ", desc);
 
 #define kbytes(x)	(((unsigned long long)(x) + 1023) / 1024)
-#ifdef HAVE_MALLINFO
+#ifdef HAVE_MALLINFO2
+	if (1) {
+		struct mallinfo2 malloc_info = mallinfo2();
+
+		log_out(ctx, _("Memory used: %lluk/%lluk (%lluk/%lluk), "),
+			kbytes(malloc_info.arena), kbytes(malloc_info.hblkhd),
+			kbytes(malloc_info.uordblks),
+			kbytes(malloc_info.fordblks));
+	} else
+#elif defined HAVE_MALLINFO
 	/* don't use mallinfo() if over 2GB used, since it returns "int" */
 	if ((char *)sbrk(0) - (char *)track->brk_start < 2LL << 30) {
 		struct mallinfo	malloc_info = mallinfo();
diff --git a/lib/config.h.in b/lib/config.h.in
index 9c9de65d..b5856bb5 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -208,6 +208,9 @@
 /* Define to 1 if you have the `mallinfo' function. */
 #undef HAVE_MALLINFO
 
+/* Define to 1 if you have the `mallinfo2' function. */
+#undef HAVE_MALLINFO2
+
 /* Define to 1 if you have the <malloc.h> header file. */
 #undef HAVE_MALLOC_H
 
diff --git a/resize/resource_track.c b/resize/resource_track.c
index f0efe114..f4667060 100644
--- a/resize/resource_track.c
+++ b/resize/resource_track.c
@@ -63,8 +63,10 @@ void print_resource_track(ext2_resize_t rfs, struct resource_track *track,
 #ifdef HAVE_GETRUSAGE
 	struct rusage r;
 #endif
-#ifdef HAVE_MALLINFO
-	struct mallinfo	malloc_info;
+#ifdef HAVE_MALLINFO2
+	struct mallinfo2 malloc_info;
+#elif defined HAVE_MALLINFO
+	struct mallinfo malloc_info;
 #endif
 	struct timeval time_end;
 
@@ -76,8 +78,13 @@ void print_resource_track(ext2_resize_t rfs, struct resource_track *track,
 	if (track->desc)
 		printf("%s: ", track->desc);
 
-#ifdef HAVE_MALLINFO
 #define kbytes(x)	(((unsigned long)(x) + 1023) / 1024)
+#ifdef HAVE_MALLINFO2
+	malloc_info = mallinfo2();
+	printf("Memory used: %luk/%luk (%luk/%luk), ",
+		kbytes(malloc_info.arena), kbytes(malloc_info.hblkhd),
+		kbytes(malloc_info.uordblks), kbytes(malloc_info.fordblks));
+#elif defined HAVE_MALLINFO
 
 	malloc_info = mallinfo();
 	printf("Memory used: %luk/%luk (%luk/%luk), ",
-- 
2.34.1

