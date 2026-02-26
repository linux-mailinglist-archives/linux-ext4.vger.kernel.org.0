Return-Path: <linux-ext4+bounces-14171-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBfNAYOpoGnilQQAu9opvQ
	(envelope-from <linux-ext4+bounces-14171-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 21:13:55 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7C1AEF05
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 21:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F8F53006224
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 20:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626EB42B736;
	Thu, 26 Feb 2026 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R05nU0yB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D8B44B676
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136824; cv=none; b=AdK7Co28PLDwj2RZv4ItMGkNSbpO7pgTkdHH+c7ce1Dh7PI+hPkCz9AC3e7teK/Z89aJvjvr1X8/uZJaeTEzP5ugWO8vDP6ZjnvZnH73vo4EViyP0bmRdWnNP1bgfqmA7DTZwuoD/5zBO1r4rfoYSwprPCeCfRXDKKHgI7W1xx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136824; c=relaxed/simple;
	bh=Zi2jR8Be2KiiufGPnIMuQh7FYRBbB/Sh+npLt+M1mgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ORUmkYO07Deh4INP7pydydXcMDqgm8unYTvRWoJMeloZhdBsZZVexpYrb0OajzFYkesHXT5k3uKoAKW1VJxFg6wyvxA1WCRzILvXhgOQF3xOTriw+W3IyTugk7lXrceYnrD2S7VEueVS65QK6VSKoZkRFkSRoCrBp3NzhLZ2gJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R05nU0yB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3870778358aso11093801fa.1
        for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772136819; x=1772741619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TS4zdw51yb5j6bKlplzS+LtFOtrGMiI87QKDt5kdVas=;
        b=R05nU0yBoGR2PnSPMNzId0zTGRJCGJRgKyWJmBy1q2kw+oTQfqJZJ59clfx3Pe+c82
         Bx+EreZPJ7BNOdJMZHEhNhSdf8OlISyX89pdYnJ7+ScDnfSvrHMeFZYfdmuRkEMz6Q+I
         KRuO1AOLPqULLgtq6OP6hrFMT9EyvNJXbcZK4MlHthQSUttnnR4bRePbBq7dC5YUY+XM
         mFtl6KK3Yaay1m8QBkPR2xerOM9mGZyzFKTlfh9SH9g373dRTCyufg9/evVSPBBTBlfo
         ulpOUd+4AQCO543yagB/vEY8IkIhfHWLwtA3+yPJy1bF7/2uk9likZ3IsuLVK3Kto5HD
         v2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772136819; x=1772741619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS4zdw51yb5j6bKlplzS+LtFOtrGMiI87QKDt5kdVas=;
        b=TLbZhbTe6YfcN+I0R7y5Goqhs0S5RdFWEeyRVUDhGbU02mgRhC9Sk8w4VxlYEkUQRQ
         dpBPO+bsPcftqtlKqFZEEgtQxyxwzhlAwa4/bIYFJ3fEbPOIFn7rF03dY/R1RNz4x8Zo
         nfp/RPWA+UKJTy5lorR49M3wDoD7fo6zKfc9JgnUFyqCIhPkCc+Q7WEs+njV3r4i6vKk
         zHuawI2IAcwfNoKVdP1VTfHUlxBmNiEC56Zrf/pCAR511Yjhc7fEcalIAq61MHchtkhP
         +GrHhJ4ReqUlgCM8INRdzVmImEc+Xkp+t/ZAujtwAp+/HRktmeHBNnyTFTRKvHGhgs7X
         p88A==
X-Gm-Message-State: AOJu0YycQfD+CzWPuxosJnnZ9jThy9p+6ne4RsFVFdFWBjv8zQsTlbYo
	AOXWjMiL5hdszGEidQOitmLKL8s8wiNYuZOt6/rmNR+uS3i9hzAyjLinQh7+SN8DgKac3Q==
X-Gm-Gg: ATEYQzyE1xMWbPGlSuJFSBmgWDh9RLxjyfuW2BP2R8kl9p4v9XSUWRxQ7CMH/6zKaAM
	Mv/x4gm0IgTAzVazbyA8FYdlWieBkljyXqKQIxKIobrBm56IFAqAPv6NpQ2lmkQ1quL6eO2fQFp
	hw9NWzTtZIobC7N7uL+OsXSlNSf5qJlAPFBEUiwybGhGge+qVDV+us6HfPj3fiu2cmag2oJlOvn
	tnG8V8qW1conWZSPKnBpkNW9jpjbC6kvndzFMFMUOMNnNbm4OVAJ/nR1//fN9d8VCiPMEbIhODL
	cW3Tn/DPcETvfu9SL2lyCe3sRpfz2rEFj9408FOFbixl+evQVBaWx43K0z8cd5OfDExIMtGiUXS
	/nOOJYczBP3AhqXwmtwkxw7AGW2Pr203TA0dP+pspGRhRGIXrUySlMPwulmkWcKmHhdfo/bOAwI
	UasZWSXjQRSzs06+XqLtdYz7+FNt2f2Nd0A0A=
X-Received: by 2002:a2e:9a83:0:b0:383:18fb:fdf0 with SMTP id 38308e7fff4ca-389ff34fbe2mr1208361fa.22.1772136818918;
        Thu, 26 Feb 2026 12:13:38 -0800 (PST)
Received: from darkstar.. ([91.231.233.187])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f30226bdsm9443291fa.46.2026.02.26.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 12:13:38 -0800 (PST)
From: Alexander Zarochentsev <zamenator@gmail.com>
X-Google-Original-From: Alexander Zarochentsev <alexander.zarochentsev@hpe.com>
To: linux-ext4@vger.kernel.org
Cc: Andreas Dilger <adilger@dilger.ca>,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Alexander Zarochentsev <alexander.zarochentsev@hpe.com>
Subject: [PATCH] e2fsck: large dir rehash fix
Date: Thu, 26 Feb 2026 20:13:34 +0000
Message-Id: <20260226201334.3260754-1-alexander.zarochentsev@hpe.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14171-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,gmail.com,mit.edu,hpe.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zamenator@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,whamcloud.com:url,hpe.com:mid,hpe.com:email]
X-Rspamd-Queue-Id: 18D7C1AEF05
X-Rspamd-Action: no action

Use EXT2_I_SIZE() macro instead of direct access to i_size in
fill_dir_block() and other functions. W/o the fix, e2fsck -D fails to
optimise 4GB+ directories reporting "EXT2 directory corrupted".

Fixing a defect of overwriting the node limit and count by the first dx
entry in calculate_tree().

In the large dir test, increase number of the internal blocks in the
test dir to test more node limits update paths.

Add a r/o e2fsck run after large dir optimisation.

Reduce number of subdirectories so e2fsck wouldn't complain about nlink
overflow also adjust foofile's nlink explicitly by debugfs "sif"
command.

Lustre-bug-id: https://jira.whamcloud.com/browse/LU-19741
HPE-bug-id: LUS-13152
Change-Id: Ic3d974bd7fe27a950afaa6992f75a00badc31600
Signed-off-by: Alexander Zarochentsev <alexander.zarochentsev@hpe.com>
---
 e2fsck/rehash.c          | 206 ++++++++++++++-------------------------
 tests/f_large_dir/expect |  20 ++--
 tests/f_large_dir/script |  23 +++--
 3 files changed, 102 insertions(+), 147 deletions(-)

diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index 4847d172e..c9a47ad67 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -128,14 +128,15 @@ static int fill_dir_block(ext2_filsys fs,
 	struct hash_entry 	*ent;
 	struct ext2_dir_entry 	*dirent;
 	char			*dir;
-	unsigned int		offset, dir_offset, rec_len, name_len;
+	unsigned int		dir_offset, rec_len, name_len;
+	ptrdiff_t		offset;
 	int			hash_alg, hash_flags, hash_in_entry;
 
 	if (blockcnt < 0)
 		return 0;
 
 	offset = blockcnt * fs->blocksize;
-	if (offset + fs->blocksize > fd->inode->i_size) {
+	if (offset + fs->blocksize > EXT2_I_SIZE(fd->inode)) {
 		fd->err = EXT2_ET_DIR_CORRUPTED;
 		return BLOCK_ABORT;
 	}
@@ -725,44 +726,60 @@ static struct ext2_dx_entry *set_int_node(ext2_filsys fs, char *buf)
 	return (struct ext2_dx_entry *) limits;
 }
 
-static int alloc_blocks(ext2_filsys fs,
-			struct ext2_dx_countlimit **limit,
-			struct ext2_dx_entry **prev_ent,
-			struct ext2_dx_entry **next_ent,
-			int *prev_offset, int *next_offset,
-			struct out_dir *outdir, int i,
-			int *prev_count, int *next_count)
+struct fill_index_ctx {
+	ext2_filsys fs;
+	struct out_dir *out;
+	unsigned block;
+	unsigned nblocks;
+	bool done;
+};
+
+static int fill_index(struct fill_index_ctx *ctx, int level,
+		      struct ext2_dx_entry *start)
 {
-	errcode_t	retval;
-	char		*block_start;
+	struct ext2_dx_countlimit *lim = (void *)start;
+	struct out_dir *out = ctx->out;
+	int ret = 0;
+	int i;
 
-	if (*limit)
-		(*limit)->limit = (*limit)->count =
-			ext2fs_cpu_to_le16((*limit)->limit);
-	*prev_ent = (struct ext2_dx_entry *) (outdir->buf + *prev_offset);
-	(*prev_ent)->block = ext2fs_cpu_to_le32(outdir->num);
+	for (i = 0; i < lim->limit && !ctx->done; i++) {
+		char *block_start;
+		struct ext2_dx_entry *next_start;
+		ptrdiff_t lim_offset, dx_offset;
+
+		if (i !=0 )
+			start->hash =
+			       ext2fs_cpu_to_le32(out->hashes[ctx->block]);
+		if (level == 0) {
+			(start++)->block = ext2fs_cpu_to_le32(ctx->block);
+			if (++(ctx->block) >= ctx->nblocks) {
+				ctx->done = true;
+			}
+			continue;
+		}
 
-	if (i != 1)
-		(*prev_ent)->hash =
-			ext2fs_cpu_to_le32(outdir->hashes[i]);
+		(start++)->block = ext2fs_cpu_to_le32(out->num);
 
-	retval = get_next_block(fs, outdir, &block_start);
-	if (retval)
-		return retval;
+		lim_offset = (char *)lim - out->buf;
+		dx_offset = (char *)start - out->buf;
 
-	/* outdir->buf might be reallocated */
-	*prev_ent = (struct ext2_dx_entry *) (outdir->buf + *prev_offset);
+		ret = get_next_block(ctx->fs, ctx->out, &block_start);
+		if (ret) {
+			ctx->done = true;
+			continue;
+		};
+
+		next_start = set_int_node(ctx->fs, block_start);
+		ret = fill_index(ctx, level - 1, next_start);
 
-	*next_ent = set_int_node(fs, block_start);
-	*limit = (struct ext2_dx_countlimit *)(*next_ent);
-	if (next_offset)
-		*next_offset = ((char *) *next_ent - outdir->buf);
+		lim = (void *)(out->buf + lim_offset);
+		start = (void *)(out->buf + dx_offset);
+	}
 
-	*next_count = (*limit)->limit;
-	(*prev_offset) += sizeof(struct ext2_dx_entry);
-	(*prev_count)--;
+	lim->count = ext2fs_cpu_to_le32(start - (struct ext2_dx_entry *)lim);
+	lim->limit = ext2fs_cpu_to_le32(lim->limit);
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -776,108 +793,35 @@ static errcode_t calculate_tree(ext2_filsys fs,
 				struct ext2_inode *inode)
 {
 	struct ext2_dx_root_info	*root_info;
-	struct ext2_dx_entry		*root, *int_ent, *dx_ent = 0;
-	struct ext2_dx_countlimit	*root_limit, *int_limit, *limit;
+	struct ext2_dx_countlimit	*root_limit;
 	errcode_t			retval;
-	int				i, c1, c2, c3, nblks;
-	int				limit_offset, int_offset, root_offset;
+	int	indirect_levels = 0;
+	struct fill_index_ctx ctx = {
+		.fs = fs,
+		.out = outdir,
+		.block = 1,
+		.nblocks = outdir->num,
+		.done = false
+	};
 
 	root_info = set_root_node(fs, outdir->buf, ino, parent, inode);
-	root_offset = limit_offset = ((char *) root_info - outdir->buf) +
-		root_info->info_length;
-	root_limit = (struct ext2_dx_countlimit *) (outdir->buf + limit_offset);
-	c1 = root_limit->limit;
-	nblks = outdir->num;
+	root_limit = (void *)((char *)root_info + root_info->info_length);
 
 	/* Write out the pointer blocks */
-	if (nblks - 1 <= c1) {
-		/* Just write out the root block, and we're done */
-		root = (struct ext2_dx_entry *) (outdir->buf + root_offset);
-		for (i=1; i < nblks; i++) {
-			root->block = ext2fs_cpu_to_le32(i);
-			if (i != 1)
-				root->hash =
-					ext2fs_cpu_to_le32(outdir->hashes[i]);
-			root++;
-			c1--;
-		}
-	} else if (nblks - 1 <= ext2fs_htree_intnode_maxrecs(fs, c1)) {
-		c2 = 0;
-		limit = NULL;
-		root_info->indirect_levels = 1;
-		for (i=1; i < nblks; i++) {
-			if (c2 == 0 && c1 == 0)
-				return ENOSPC;
-			if (c2 == 0) {
-				retval = alloc_blocks(fs, &limit, &root,
-						      &dx_ent, &root_offset,
-						      NULL, outdir, i, &c1,
-						      &c2);
-				if (retval)
-					return retval;
-			}
-			dx_ent->block = ext2fs_cpu_to_le32(i);
-			if (c2 != limit->limit)
-				dx_ent->hash =
-					ext2fs_cpu_to_le32(outdir->hashes[i]);
-			dx_ent++;
-			c2--;
-		}
-		limit->count = ext2fs_cpu_to_le16(limit->limit - c2);
-		limit->limit = ext2fs_cpu_to_le16(limit->limit);
-	} else {
-		c2 = 0;
-		c3 = 0;
-		limit = NULL;
-		int_limit = 0;
-		root_info->indirect_levels = 2;
-		for (i = 1; i < nblks; i++) {
-			if (c3 == 0 && c2 == 0 && c1 == 0)
-				return ENOSPC;
-			if (c3 == 0 && c2 == 0) {
-				retval = alloc_blocks(fs, &int_limit, &root,
-						      &int_ent, &root_offset,
-						      &int_offset, outdir, i,
-						      &c1, &c2);
-				if (retval)
-					return retval;
-			}
-			if (c3 == 0) {
-				int delta1 = (char *)int_limit - outdir->buf;
-				int delta2 = (char *)root - outdir->buf;
-
-				retval = alloc_blocks(fs, &limit, &int_ent,
-						      &dx_ent, &int_offset,
-						      NULL, outdir, i, &c2,
-						      &c3);
-				if (retval)
-					return retval;
-
-				/* outdir->buf might be reallocated */
-				int_limit = (struct ext2_dx_countlimit *)
-					(outdir->buf + delta1);
-				root = (struct ext2_dx_entry *)
-					(outdir->buf + delta2);
-			}
-			dx_ent->block = ext2fs_cpu_to_le32(i);
-			if (c3 != limit->limit)
-				dx_ent->hash =
-					ext2fs_cpu_to_le32(outdir->hashes[i]);
-			dx_ent++;
-			c3--;
-		}
-		int_limit->count = ext2fs_cpu_to_le16(limit->limit - c2);
-		int_limit->limit = ext2fs_cpu_to_le16(limit->limit);
-
-		limit->count = ext2fs_cpu_to_le16(limit->limit - c3);
-		limit->limit = ext2fs_cpu_to_le16(limit->limit);
-
-	}
-	root_limit = (struct ext2_dx_countlimit *) (outdir->buf + limit_offset);
-	root_limit->count = ext2fs_cpu_to_le16(root_limit->limit - c1);
-	root_limit->limit = ext2fs_cpu_to_le16(root_limit->limit);
+	if (ctx.nblocks - 1 <= root_limit->limit)
+		indirect_levels = 0;
+	else if (ctx.nblocks - 1 <=
+		 ext2fs_htree_intnode_maxrecs(fs, root_limit->limit))
+		indirect_levels = 1;
+	else
+		indirect_levels = 2;
+	root_info->indirect_levels = indirect_levels;
 
-	return 0;
+	retval = fill_index(&ctx, indirect_levels,
+			    (struct ext2_dx_entry*)root_limit);
+	if (!retval && ctx.block < ctx.nblocks - 1)
+		retval = ENOSPC;
+	return retval;
 }
 
 struct write_dir_struct {
@@ -1004,11 +948,11 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, ext2_ino_t ino,
 	   (inode.i_flags & EXT4_INLINE_DATA_FL))
 		return 0;
 
-	retval = ext2fs_get_mem(inode.i_size, &dir_buf);
+	retval = ext2fs_get_mem(EXT2_I_SIZE(&inode), &dir_buf);
 	if (retval)
 		goto errout;
 
-	fd.max_array = inode.i_size / 32;
+	fd.max_array = EXT2_I_SIZE(&inode) / 32;
 	retval = ext2fs_get_array(sizeof(struct hash_entry),
 				  fd.max_array, &fd.harray);
 	if (retval)
@@ -1020,7 +964,7 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, ext2_ino_t ino,
 	fd.inode = EXT2_INODE(&inode);
 	fd.dir = ino;
 	if (!ext2fs_has_feature_dir_index(fs->super) ||
-	    (inode.i_size / fs->blocksize) < 2)
+	    (EXT2_I_SIZE(&inode) / fs->blocksize) < 2)
 		fd.compress = 1;
 	fd.parent = 0;
 
diff --git a/tests/f_large_dir/expect b/tests/f_large_dir/expect
index 495ea85d3..b0ee9fbfb 100644
--- a/tests/f_large_dir/expect
+++ b/tests/f_large_dir/expect
@@ -1,5 +1,5 @@
 128-byte inodes cannot handle dates beyond 2038 and are deprecated
-Creating filesystem with 108341 1k blocks and 65072 inodes
+Creating filesystem with 141612 1k blocks and 96912 inodes
 Superblock backups stored on blocks: 
 	8193, 24577, 40961, 57345, 73729
 
@@ -15,20 +15,22 @@ Pass 4: Checking reference counts
 Pass 5: Checking group summary information
 
 test.img: ***** FILE SYSTEM WAS MODIFIED *****
-test.img: 17/65072 files (5.9% non-contiguous), 9732/108341 blocks
+test.img: 17/96912 files (5.9% non-contiguous), 13720/141612 blocks
 Exit status is 0
 Pass 1: Checking inodes, blocks, and sizes
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 3A: Optimizing directories
 Pass 4: Checking reference counts
-Directory exceeds max links, but no DIR_NLINK feature in superblock.
-Fix? yes
-
-Inode 12 ref count is 65012, should be 1.  Fix? yes
-
 Pass 5: Checking group summary information
 
 test.img: ***** FILE SYSTEM WAS MODIFIED *****
-test.img: 65023/65072 files (0.0% non-contiguous), 96666/108341 blocks
-Exit status is 1
+test.img: 64923/96912 files (0.0% non-contiguous), 111270/141612 blocks
+E2FSCK -D exit status is 0
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test.img: 64923/96912 files (0.0% non-contiguous), 111270/141612 blocks
+E2FSCK r/o exit status is 0
diff --git a/tests/f_large_dir/script b/tests/f_large_dir/script
index e3235836f..bca520828 100644
--- a/tests/f_large_dir/script
+++ b/tests/f_large_dir/script
@@ -7,19 +7,19 @@ DIRENT_SZ=8
 BLOCKSZ=1024
 INODESZ=128
 DIRENT_PER_LEAF=$((BLOCKSZ / (NAMELEN + DIRENT_SZ)))
-HEADER=32
 INDEX_SZ=8
-INDEX_L1=$(((BLOCKSZ - HEADER) / INDEX_SZ))
 INDEX_L2=$(((BLOCKSZ - DIRENT_SZ) / INDEX_SZ))
-DIRBLK=$((2 + INDEX_L1 * INDEX_L2))
+# more than two internal blocks at the top level
+DIRBLK=$((2 + 2 * INDEX_L2 * INDEX_L2))
 ENTRIES=$((DIRBLK * DIRENT_PER_LEAF))
-EXT4_LINK_MAX=65000
+EXT4_LINK_MAX=64900
 if [ $ENTRIES -lt $((EXT4_LINK_MAX + 10)) ]; then
 	ENTRIES=$((EXT4_LINK_MAX + 10))
 	DIRBLK=$((ENTRIES / DIRENT_PER_LEAF + 3))
 fi
-# directory leaf blocks plus inode count and 25% for the rest of the fs
-FSIZE=$(((DIRBLK + EXT4_LINK_MAX * ((BLOCKSZ + INODESZ) / BLOCKSZ)) * 5 / 4))
+# directory leaf blocks plus half for the internal nodes plus inode count
+# and 25% for the rest of the fs
+FSIZE=$(((DIRBLK + DIRBLK / 2 + EXT4_LINK_MAX * ((BLOCKSZ + INODESZ) / BLOCKSZ)) * 5 / 4))
 
 $MKE2FS -b 1024 -O large_dir,uninit_bg -N $((ENTRIES + 50)) \
 	-I $INODESZ -F $TMPFILE $FSIZE > $OUT.new 2>&1
@@ -50,6 +50,7 @@ if [ $RC -eq 0 ]; then
 {
 	START=$SECONDS
 	i=$(($DIRENT_PER_LEAF+1))
+	links=1
 	last=$i
 	echo "cd /foo"
 	while test $i -lt $ENTRIES ; do
@@ -64,9 +65,12 @@ if [ $RC -eq 0 ]; then
 		printf "mkdir d%0254u\n" $i
 	    else
 		printf "ln foofile f%0254u\n" $i
+		links=$((links+1))
 	    fi
 	    i=$((i + 1))
 	done
+	# adjust nlink count because ln didn't
+	echo "sif foofile links_count $links"
 } | $DEBUGFS -w $TMPFILE > /dev/null 2>> $OUT.new
 	RC=$?
 fi
@@ -74,7 +78,12 @@ fi
 if [ $RC -eq 0 ]; then
 	$E2FSCK -yfD $TMPFILE >> $OUT.new 2>&1
 	status=$?
-	echo Exit status is $status >> $OUT.new
+	echo E2FSCK -D exit status is $status >> $OUT.new
+
+	$E2FSCK -fn $TMPFILE >> $OUT.new 2>&1
+	status=$?
+	echo E2FSCK r/o exit status is $status >> $OUT.new
+
 	sed -f $cmd_dir/filter.sed -e "s;$TMPFILE;test.img;" $OUT.new > $OUT
 	rm -f $OUT.new
 
-- 
2.34.1


