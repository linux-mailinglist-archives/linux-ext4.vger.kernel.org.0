Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A028A2FE17E
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 06:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbhAUFXt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 00:23:49 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57351 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726765AbhAUFXQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 00:23:16 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10L5MPIm000469
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 00:22:26 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 607E515C35F5; Thu, 21 Jan 2021 00:22:25 -0500 (EST)
Date:   Thu, 21 Jan 2021 00:22:25 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Fast commit changes for e2fsprogs
Message-ID: <YAkPkXDzua0va3v7@mit.edu>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 20, 2021 at 01:26:26PM -0800, Harshad Shirwadkar wrote:
> 
> - Fix compilation error by defining jbd2_journal_get_fc_num_blks (also
>   rename it to jbd_get_fc_num_blks) as a preprocessor macro instead of
>   inline function which gets compiled out when "-g" is passed

Unfortunately, this still doesn't quite fix things.  The problem with
this approach is the preprocessor macro uses be32_to_cpu(), which gets
turned into ext2fs_swab32().  And the libe2p shared library is not
allowed to depend on libext2fs.  Otherwise when we build with
configure --enable-elf-shlibs, the link of misc/chattr fails with:

<tytso@cwcc> {/build/e2fsprogs/misc}  
1078% make V=1
../util/subst -f ../util/subst.conf /usr/projects/e2fsprogs/e2fsprogs/lib/dirpaths.h.in ../lib/dirpaths.h
gcc   -Wl,-rpath-link,../lib -o chattr chattr.o ../lib/libe2p.so ../lib/libcom_err.so  \
	 
/bin/ld: ../lib/libe2p.so: undefined reference to `ext2fs_swab32'
collect2: error: ld returned 1 exit status
make: *** [Makefile:636: chattr] Error 1

We had already defined e2p_be32() and use it in other places in
lib/e2p/ljs.c.

So I fixed this by taking your Dec 10th version of the patch series,
and making the following change to patch 4/15:

diff --git a/lib/e2p/ljs.c b/lib/e2p/ljs.c
index 9f866c7e..59728198 100644
--- a/lib/e2p/ljs.c
+++ b/lib/e2p/ljs.c
@@ -36,6 +36,17 @@ static __u32 e2p_swab32(__u32 val)
 #define e2p_be32(x) e2p_swab32(x)
 #endif
 
+/*
+ * This function is copied from kernel-jbd.h's function
+ * jbd2_journal_get_num_fc_blks() to avoid inter-library dependencies.
+ */
+static inline int get_num_fc_blks(journal_superblock_t *jsb)
+{
+	int num_fc_blocks = e2p_be32(jsb->s_num_fc_blks);
+
+	return num_fc_blocks ? num_fc_blocks : JBD2_DEFAULT_FAST_COMMIT_BLOCKS;
+}
+
 static const char *journal_checksum_type_str(__u8 type)
 {
 	switch (type) {
@@ -58,7 +69,7 @@ void e2p_list_journal_super(FILE *f, char *journal_sb_buf,
 	int journal_blks = 0;
 
 	if (flags & E2P_LIST_JOURNAL_FLAG_FC)
-		num_fc_blks = jbd2_journal_get_num_fc_blks((journal_superblock_t *)journal_sb_buf);
+		num_fc_blks = get_num_fc_blks((journal_superblock_t *)journal_sb_buf);
 	journal_blks = ntohl(jsb->s_maxlen) - num_fc_blks;
 	fprintf(f, "%s", "Journal features:        ");
 	for (i=0, mask_ptr=&jsb->s_feature_compat; i <3; i++,mask_ptr++) {

