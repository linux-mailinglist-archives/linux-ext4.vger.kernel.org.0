Return-Path: <linux-ext4+bounces-274-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BF080210B
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Dec 2023 06:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C9F280F7C
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Dec 2023 05:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECB10EB;
	Sun,  3 Dec 2023 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MdDOk6HV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47482F9
	for <linux-ext4@vger.kernel.org>; Sat,  2 Dec 2023 21:15:06 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B35EsEm017454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 3 Dec 2023 00:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701580498; bh=tBVJpI+aQK5EDPRLNT/vo0HOOLjHeEtNgTuIKZIm78A=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MdDOk6HVOLfJDpRQoe+ofzYfMlB+cKx1ixmj1DjWReQm7iHhxG8kM9xP12nWFtEyZ
	 PXJmCnjqLj5dt0nL4rEUfyeLv/hVXcy5fD3EjjQ3bALE7KobeCNKCfPeUd0H1sg98n
	 JGqd7RFvLd5pZ/1FOLWF4tX+UG0vnAJl54gDGR5RhjZrBYhRvQpdkZYZjz8Pim1mEX
	 rFVuhDIzMLqr/zGqoE9auXCc8+ZwFtJf52ve5HKL45Fc1hKwDZo6aailc0wJqcBIKm
	 zuhbqroHthO9YzLMHMflzrA8wHE+TcHpwSvO0BXZq8gG4qhA3VOPp05RlGjy+0zLt4
	 hHpDBiomdV55A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 51C8015C0290; Sun,  3 Dec 2023 00:14:54 -0500 (EST)
Date: Sun, 3 Dec 2023 00:14:54 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: Re: [RESEND PATCH] debugfs/htree.c: In do_dx_hash() read hash_seed,
 hash_version directly from superblock
Message-ID: <20231203051454.GE509422@mit.edu>
References: <20230824065634.2662858-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7XPFOp8NvGT9igiR"
Content-Disposition: inline
In-Reply-To: <20230824065634.2662858-1-srivathsa.d.dara@oracle.com>


--7XPFOp8NvGT9igiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2023 at 06:56:34AM +0000, Srivathsa Dara wrote:
> diff --git a/debugfs/htree.c b/debugfs/htree.c
> index 7fae7f11..2d881c74 100644
> --- a/debugfs/htree.c
> +++ b/debugfs/htree.c
> @@ -316,7 +316,12 @@ void do_dx_hash(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
>  	int		hash_flags = 0;
>  	const struct ext2fs_nls_table *encoding = NULL;
>  
> -	hash_seed[0] = hash_seed[1] = hash_seed[2] = hash_seed[3] = 0;
> +	hash_seed[0] = current_fs->super->s_hash_seed[0];
> +	hash_seed[1] = current_fs->super->s_hash_seed[1];
> +	hash_seed[2] = current_fs->super->s_hash_seed[2];
> +	hash_seed[3] = current_fs->super->s_hash_seed[3];
> +
> +	hash_version = current_fs->super->s_def_hash_version;
>  
>  	reset_getopt();
>  	while ((c = getopt(argc, argv, "h:s:ce:")) != EOF) {

The problem with this patch is that if a file system is not opened,
then current_fs is NULL.  As a result:

% gdb -q debugfs
Reading symbols from debugfs...
(gdb) run
Starting program: /build/e2fsprogs/debugfs/debugfs 
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
debugfs 1.47.0 (5-Feb-2023)
debugfs:  dx_hash test1

Program received signal SIGSEGV, Segmentation fault.
0x000055555556f73d in do_dx_hash (argc=2, argv=0x5555555d38d0, sci_idx=1, infop=0x0)
    at /usr/projects/e2fsprogs/e2fsprogs/debugfs/htree.c:343
343             hash_seed[0] = current_fs->super->s_hash_seed[0];


To address this, I've fixed up your patch slightly.  (See below for
the fix up, as well as the final patch.)

Also, in the future, please make sure that the first line of the
commit is a summary of the patch, no longer than 75 characters, and
that the text is wrapped to no more than 75 characters.  (I personally
use 72 characters, but 75 is what suggested in the Linux Kernel's
submitting patches documentation[1] in the "The Canonical Patch
Format" section.)

[1] https://docs.kernel.org/process/submitting-patches.html

					- Ted



--7XPFOp8NvGT9igiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fixup

diff --git a/debugfs/htree.c b/debugfs/htree.c
index ad493e8fb..a3e95ddb0 100644
--- a/debugfs/htree.c
+++ b/debugfs/htree.c
@@ -336,16 +336,18 @@ void do_dx_hash(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 	errcode_t	err;
 	int		c;
 	int		hash_version = 0;
-	__u32		hash_seed[4];
+	__u32		hash_seed[4] = { 0, };
 	int		hash_flags = 0;
 	const struct ext2fs_nls_table *encoding = NULL;
 
-	hash_seed[0] = current_fs->super->s_hash_seed[0];
-	hash_seed[1] = current_fs->super->s_hash_seed[1];
-	hash_seed[2] = current_fs->super->s_hash_seed[2];
-	hash_seed[3] = current_fs->super->s_hash_seed[3];
+	if (current_fs) {
+		hash_seed[0] = current_fs->super->s_hash_seed[0];
+		hash_seed[1] = current_fs->super->s_hash_seed[1];
+		hash_seed[2] = current_fs->super->s_hash_seed[2];
+		hash_seed[3] = current_fs->super->s_hash_seed[3];
 
-	hash_version = current_fs->super->s_def_hash_version;
+		hash_version = current_fs->super->s_def_hash_version;
+	}
 
 	reset_getopt();
 	while ((c = getopt(argc, argv, "h:s:ce:")) != EOF) {

--7XPFOp8NvGT9igiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=final-patch

commit 29d83fef9e6eab139516afe433c03d975e85c25b
Author: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Date:   Thu Aug 24 06:56:34 2023 +0000

    debugfs: Use the hash_version from superblock if a file system is opened
    
    The debugfs program's dx_hash command computes the hash for the given
    filename, taking the hash_seed and hash_version (i.e hash algorithm)
    as arguments.  So the user has to refer to the superblock to get these
    values used by the filesystem.  So if debugfs has an opened file
    system, use those values from the current file system.
    
    [ Fixed patch to avoid crashing when a file system is not opened. --TYT ]
    
    Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
    Link: https://lore.kernel.org/r/20230824065634.2662858-1-srivathsa.d.dara@oracle.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/debugfs/htree.c b/debugfs/htree.c
index a9f9211ba..a3e95ddb0 100644
--- a/debugfs/htree.c
+++ b/debugfs/htree.c
@@ -336,11 +336,18 @@ void do_dx_hash(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 	errcode_t	err;
 	int		c;
 	int		hash_version = 0;
-	__u32		hash_seed[4];
+	__u32		hash_seed[4] = { 0, };
 	int		hash_flags = 0;
 	const struct ext2fs_nls_table *encoding = NULL;
 
-	hash_seed[0] = hash_seed[1] = hash_seed[2] = hash_seed[3] = 0;
+	if (current_fs) {
+		hash_seed[0] = current_fs->super->s_hash_seed[0];
+		hash_seed[1] = current_fs->super->s_hash_seed[1];
+		hash_seed[2] = current_fs->super->s_hash_seed[2];
+		hash_seed[3] = current_fs->super->s_hash_seed[3];
+
+		hash_version = current_fs->super->s_def_hash_version;
+	}
 
 	reset_getopt();
 	while ((c = getopt(argc, argv, "h:s:ce:")) != EOF) {

--7XPFOp8NvGT9igiR--

