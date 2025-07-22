Return-Path: <linux-ext4+bounces-9157-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91454B0E455
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 21:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BAF17BB1F
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BAB283C9F;
	Tue, 22 Jul 2025 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY+oEoV1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79F17E4
	for <linux-ext4@vger.kernel.org>; Tue, 22 Jul 2025 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213254; cv=none; b=OU8Eh3TxB5AnLMxskgD/qINRXwbM/3lRZ1qemwqV4jrtxErh8qGIfkuEhFR/Zv38IubcU6W2aVHGEN3XrMM6ysManZjhdgwiBwUHvyGMJ+HVn2Z1OIW7QawUtJCyStWx8h6aKWLQM4CFIJpnk1e4i5VVkYuMvLc6zDDeXK2aTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213254; c=relaxed/simple;
	bh=F9chcLNZ/4MRLEhK5q+9c/6+29QcCxhA/6UEFsOqbMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nge+R3hX/uYucyTkSbJl6M0ayy8ji/TxXKZ4qpwvm4+W972cGG8Cw065+E2g8AV75CIkFF1v1vI2OwUVqG12Q2Q20mTbH7fp6eQuPGuC3CQcWIOHTCVuUXfjcgkjqkfCEZBitR87Aqkn+SSC6gq2yji/LlUyjxechDVn2URw+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY+oEoV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C47C4CEEB;
	Tue, 22 Jul 2025 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753213253;
	bh=F9chcLNZ/4MRLEhK5q+9c/6+29QcCxhA/6UEFsOqbMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UY+oEoV1vCLKYsTPqBwotydO72TMfRwpQK4Mdcio6jf0XOy8m0zUUccpf9ybXM3B3
	 V6/u6/tWJK8FwTiUk/qb4ANDCfuCs87UiH2KFuVPR9mJ6bHtvj5hwTnlTDzqmq0f0h
	 ajUuaThbrcW30o4yIi0es5a7hBKswLJaoVjABSY5o6iAmgzEXmkNn7es9pcCMG3ABz
	 OB8UwJK8tjqTh2+wdGPVYezjFGJLATR8iAN1AA9DsV0c6QfbpAn5Jc1RDKt6UtvtIj
	 s1jw6F2AvOuXQYoee4WhQMAobLoTSb08r1TTSEwKuoBu2KK885UyuhGTLeHgX0grR7
	 e98FHwsnBN7xw==
Date: Tue, 22 Jul 2025 12:40:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, sam@gentoo.org
Subject: [PATCH 18/8] fuse2fs: fix logging redirection
Message-ID: <20250722194053.GO2672022@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

Someone pointed out that you can't just go around reassigning stdout and
stderr because section 7.23.1 paragraph 4 of a recent C2y draft says
that stdin, stdout, and stderr “are expressions of type "pointer to
FILE" that point to the FILE objects associated, respectively, with the
standard error, input, and output streams.”

The use of the word "expression" should have been the warning sign that
a symbol that can be mostly used as a pointer is not simply a pointer.

Seven pages later, footnote 318 of the C2y draft clarifies that stdin,
stdout, and stderr “need not be modifiable lvalues to which the value
returned by the fopen function could be assigned.”

"need not be" is the magic phrasing that means that glibc, musl, and
mingw (for example) have very different declarations of stdout:

glibc:
extern FILE *stdout;           /* Standard output stream.  */

musl:
extern FILE *const stdout;

mingw:
#define stdout	(&_iob[STDOUT_FILENO])

All three are following the specification, yet you can write C code that
fails to compile what otherwise looks like a normal assignment on two of
the libraries:

static FILE *const fark;	/* musl */

FILE crap[3];			/* mingw */
#define crows (&crap[0])

static FILE *stupid;		/* glibc */

int main(int argc, char *argv[])
{
	fark = NULL;
	crows = NULL;
	stupid = NULL;
}

/tmp/a.c: In function ‘main’:
/tmp/a.c:20:14: error: assignment of read-only variable ‘fark’
   20 |         fark = NULL;
      |              ^
/tmp/a.c:21:15: error: lvalue required as left operand of assignment
   21 |         crows = NULL;
      |               ^

What a useless specification!  You don't even get the same error!
Unfortunately, this leadership vacuum means that each implementation of
a so-called standard C library is perfectly within its right to do this.
IOWs, the authors decided that every C programmer must divert some of
the brainpower they could spend on their program's core algorithms to be
really smart about this quirk.

A whole committee of very smart programmers collectively decided this
was a good way to run things decades ago so that C library authors in
the 1980s wouldn't have to change their code, and subsequent gatherings
have reaffirmed this "practical" decision.  Their suggestion to reassign
stdout and stderr is to use freopen, but that walks the specified path,
which is racy if you want both streams to point to the same file.  You
could pass /dev/fd/XX to solve the race, but then you lose portability.

In other words, they "engineered" an incomplete solution with problems
to achieve a short term goal that nobody should care about 40 years
later.

Fix fuse2fs by rearranging the code to change STD{OUT,ERR}_FILENO to
point to the same open logfile via dup2 and then try to use freopen on
/dev/fd/XX to capture any stdout/err usage by the libraries that fuse2fs
depends on.

Note that we must do the whole thing over again in op_init because
libfuse will dup2 STD{OUT,ERR}_FILE to /dev/null as part of daemonizing
the server.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 5cdebf3eebc22c ("fuse2fs: stop aliasing stderr with ff->err_fp")
Link: https://github.com/tytso/e2fsprogs/issues/235
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  141 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 123 insertions(+), 18 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cee9e657c36767..242bbfd221eb3a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -229,6 +229,7 @@ struct fuse2fs {
 	uint8_t directio;
 	uint8_t acl;
 
+	int logfd;
 	int blocklog;
 	unsigned int blockmask;
 	unsigned long offset;
@@ -792,6 +793,111 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 	pthread_mutex_unlock(&ff->bfl);
 }
 
+/* Reopen @stream with @fileno */
+static int fuse2fs_freopen_stream(const char *path, int fileno, FILE *stream)
+{
+	char _fdpath[256];
+	const char *fdpath;
+	FILE *fp;
+	int ret;
+
+	ret = snprintf(_fdpath, sizeof(_fdpath), "/dev/fd/%d", fileno);
+	if (ret >= sizeof(_fdpath))
+		fdpath = path;
+	else
+		fdpath = _fdpath;
+
+	/*
+	 * C23 defines std{out,err} as an expression of type FILE* that need
+	 * not be an lvalue.  What this means is that we can't just assign to
+	 * stdout: we have to use freopen, which takes a path.
+	 *
+	 * There's no guarantee that the OS provides a /dev/fd/X alias for open
+	 * file descriptors, so if that fails, fall back to the original log
+	 * file path.  We'd rather not do a path-based reopen because that
+	 * exposes us to rename race attacks.
+	 */
+	fp = freopen(fdpath, "a", stream);
+	if (!fp && errno == ENOENT && fdpath == _fdpath)
+		fp = freopen(path, "a", stream);
+	if (!fp) {
+		perror(fdpath);
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Redirect stdout/stderr to a file, or return a mount-compatible error. */
+static int fuse2fs_capture_output(struct fuse2fs *ff, const char *path)
+{
+	int ret;
+	int fd;
+
+	/*
+	 * First, open the log file path with system calls so that we can
+	 * redirect the stdout/stderr file numbers (typically 1 and 2) to our
+	 * logfile descriptor.  We'd like to avoid allocating extra file
+	 * objects in the kernel if we can because pos will be the same between
+	 * stdout and stderr.
+	 */
+	if (ff->logfd < 0) {
+		fd = open(path, O_WRONLY | O_CREAT | O_APPEND, 0600);
+		if (fd < 0) {
+			perror(path);
+			return -1;
+		}
+
+		/*
+		 * Save the newly opened fd in case we have to do this again in
+		 * op_init.
+		 */
+		ff->logfd = fd;
+	}
+
+	ret = dup2(ff->logfd, STDOUT_FILENO);
+	if (ret < 0) {
+		perror(path);
+		return -1;
+	}
+
+	ret = dup2(ff->logfd, STDERR_FILENO);
+	if (ret < 0) {
+		perror(path);
+		return -1;
+	}
+
+	/*
+	 * Now that we've changed STD{OUT,ERR}_FILENO to be the log file, use
+	 * freopen to make sure that std{out,err} (the C library abstractions)
+	 * point to the STDXXX_FILENO because any of our library dependencies
+	 * might decide to printf to one of those streams and we want to
+	 * capture all output in the log.
+	 */
+	ret = fuse2fs_freopen_stream(path, STDOUT_FILENO, stdout);
+	if (ret)
+		return ret;
+	ret = fuse2fs_freopen_stream(path, STDERR_FILENO, stderr);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* Set up debug and error logging files */
+static int fuse2fs_setup_logging(struct fuse2fs *ff)
+{
+	char *logfile = getenv("FUSE2FS_LOGFILE");
+	if (logfile)
+		return fuse2fs_capture_output(ff, logfile);
+
+	/* in kernel mode, try to log errors to the kernel log */
+	if (ff->kernel)
+		fuse2fs_capture_output(ff, "/dev/ttyprintk");
+
+	return 0;
+}
+
 static void *op_init(struct fuse_conn_info *conn
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, struct fuse_config *cfg EXT2FS_ATTR((unused))
@@ -807,6 +913,17 @@ static void *op_init(struct fuse_conn_info *conn
 		translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC);
 		return NULL;
 	}
+
+	/*
+	 * Configure logging a second time, because libfuse might have
+	 * redirected std{out,err} as part of daemonization.  If this fails,
+	 * give up and move on.
+	 */
+	fuse2fs_setup_logging(ff);
+	if (ff->logfd >= 0)
+		close(ff->logfd);
+	ff->logfd = -1;
+
 	fs = ff->fs;
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
 #ifdef FUSE_CAP_IOCTL_DIR
@@ -4448,7 +4565,6 @@ int main(int argc, char *argv[])
 	struct fuse2fs fctx;
 	errcode_t err;
 	FILE *orig_stderr = stderr;
-	char *logfile;
 	char extra_args[BUFSIZ];
 	int ret;
 	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE |
@@ -4456,6 +4572,7 @@ int main(int argc, char *argv[])
 
 	memset(&fctx, 0, sizeof(fctx));
 	fctx.magic = FUSE2FS_MAGIC;
+	fctx.logfd = -1;
 
 	ret = fuse_opt_parse(&args, &fctx, fuse2fs_opts, fuse2fs_opt_proc);
 	if (ret)
@@ -4482,23 +4599,11 @@ int main(int argc, char *argv[])
 #endif
 	add_error_table(&et_ext2_error_table);
 
-	/* Set up error logging */
-	logfile = getenv("FUSE2FS_LOGFILE");
-	if (logfile) {
-		FILE *fp = fopen(logfile, "a");
-		if (!fp) {
-			perror(logfile);
-			goto out;
-		}
-		stderr = fp;
-		stdout = fp;
-	} else if (fctx.kernel) {
-		/* in kernel mode, try to log errors to the kernel log */
-		FILE *fp = fopen("/dev/ttyprintk", "a");
-		if (fp) {
-			stderr = fp;
-			stdout = fp;
-		}
+	ret = fuse2fs_setup_logging(&fctx);
+	if (ret) {
+		/* operational error */
+		ret = 2;
+		goto out;
 	}
 
 	/* Will we allow users to allocate every last block? */

