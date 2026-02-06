Return-Path: <linux-ext4+bounces-13606-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBe/AzNhhmkdMgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13606-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 22:46:27 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB7103836
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 22:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70B3C3010B59
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 21:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EA5309EEB;
	Fri,  6 Feb 2026 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miTX8q/b"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403835975;
	Fri,  6 Feb 2026 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770414380; cv=none; b=AjIK1od5uqkcsicsBOnkkGaJundAHf0vBVh0hlgoWS/Kgm+pnmIst0wl8bp4p7MAQ2KGoraIfYfB0V3Z496twaVqwYl/GbM1FPQybluEnX1/LaBRhcIBIvuBFBhOLlGilGY7elEI6bam3Jy3v8564CNRNf82W2IHukqh7CMbapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770414380; c=relaxed/simple;
	bh=33n7JfvoxNjoA9AcZk3us7gGXm6K7pn0EwypmZJlHiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=n+IUyfzU5jt+Ix8puLImtyjyP9+X+8JT4O+H7DZ8qya6e2+6+ZNjRvw5WCOV+rjkb66zO95oOOCMgF2U+OHG469MwbYJttPqiLEJkvR83Cu2G88jUlJSKiR66nkuI9fLjS+GGVJ0fBew0kfkG+QerUShORSmRXnBfOw+yNVxyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miTX8q/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F03C16AAE;
	Fri,  6 Feb 2026 21:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770414380;
	bh=33n7JfvoxNjoA9AcZk3us7gGXm6K7pn0EwypmZJlHiI=;
	h=From:To:Cc:Subject:Date:From;
	b=miTX8q/bvOs594rk2qZlTUwETYZ6KP73QhNYozPll/gUzxwYtL9nm0aKuotaz9gl5
	 uhmculosjUTVetczxTRZ0JzsxeUjt1iJ8R4TtLz3A5LeDZZotg+4QnB6ZrBNzKZftH
	 eW1AdpZlH+4IMDQ4CecvIAvBzOJroa1gvhMp2BsLHWchf60POduXlja4/Hx1XfUIa8
	 LGp5ZRve/a5AzAui0CFM+4GXTfQmw7AWZRZUBxIBYkJifPQo7Ux6ecMi3bvVaSrd/V
	 BoIOwZcaGjKvF7iTR4dwN36/rFGvclurhy/4RHmd2/8G/M0nH/x2gQaMWtYV/atqMw
	 qMJhFdbaV96rQ==
From: Kees Cook <kees@kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?=E6=9D=8E=E9=BE=99=E5=85=B4?= <coregee2000@gmail.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH ALTERNATIVE] ext4: Treat s_mount_opts and mount_opts as __nonstring
Date: Fri,  6 Feb 2026 13:46:18 -0800
Message-Id: <20260206214613.work.184-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7802; i=kees@kernel.org; h=from:subject:message-id; bh=33n7JfvoxNjoA9AcZk3us7gGXm6K7pn0EwypmZJlHiI=; b=owGbwMvMwCVmps19z/KJym7G02pJDJltiZoFx+LebbPOVwsqflPmeOB96fzbwbPrQtLkWCJ9P 0b+T7rWUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJFzQgz/XUNKtRfoN4fHJM5I ff9yirCL49W2xPSFumIHD2moOG3/x/A/+KRfXifnitlF/lGmfw9N1VhyOd7MZUv57hu/u87s/XS cDQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,dilger.ca,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13606-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,dilger.ca:email]
X-Rspamd-Queue-Id: 91AB7103836
X-Rspamd-Action: no action

When mounting an ext4 filesystem, the on-disk superblock's s_mount_opts
field (which stores default mount options set via tune2fs) is read and
parsed. Unlike userspace-provided mount options which are validated by
the VFS layer before reaching the filesystem, the on-disk s_mount_opts
is read directly from the disk buffer without NUL-termination validation.

The two option paths use the same parser but arrive differently:

  Userspace mount options:
    VFS -> ext4_parse_param()

  On-disk default options:
    parse_apply_sb_mount_options() -> parse_options() -> ext4_parse_param()

When s_mount_opts lacks NUL-termination, strscpy_pad()'s internal
fortified strnlen() detects reading beyond the 64-byte field, triggering
an Oops:

  strnlen: detected buffer overflow: 65 byte read of buffer size 64
  WARNING: CPU: 0 PID: 179 at lib/string_helpers.c:1035 __fortify_report+0x5a/0x100
  ...
  Call Trace:
   strnlen+0x71/0xa0 lib/string.c:155
   sized_strscpy+0x48/0x2a0 lib/string.c:298
   parse_apply_sb_mount_options+0x94/0x4a0 fs/ext4/super.c:2486
   __ext4_fill_super+0x31d6/0x51b0 fs/ext4/super.c:5306
   ext4_fill_super+0x3972/0xaf70 fs/ext4/super.c:5736
   get_tree_bdev_flags+0x38c/0x620 fs/super.c:1698
   vfs_get_tree+0x8e/0x340 fs/super.c:1758
   fc_mount fs/namespace.c:1199
   do_new_mount fs/namespace.c:3718
   path_mount+0x7b9/0x23a0 fs/namespace.c:4028
   ...

The painful history here is:

8b67f04ab9de ("ext4: Add mount options in superblock")
  s_mount_opts is created and treated as __nonstring: kstrndup is used to
  make sure all 64 potential characters are available for use (i.e. up
  to 65 bytes may be allocated).

04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
  Created ext4_tune_sb_params::mount_opts as 64 bytes in size but
  incorrectly treated it and s_mount_opts as a C strings (it used
  strscpy_pad() to copy between them).

8ecb790ea8c3 ("ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()")
  As a prerequisite to the ioctl treating s_mount_opts as a C string, this
  attempted to switch to using strscpy_pad() with a 65 byte destination
  for the case of an unterminated s_mount_opts. (But strscpy_pad will
  fail due to the over-read of s_mount_opts by strnlen().)

3db63d2c2d1d ("ext4: check if mount_opts is NUL-terminated in ext4_ioctl_set_tune_sb()")
  As a continuation of trying to solve the 64/65 mismatch, this started
  enforcing a 63 character limit (i.e. 64 bytes total) to incoming values
  from userspace to the ioctl API. (But did not check s_mount_opts coming
  from disk.)

ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")
  Notices the loud failures of strscpy_pad introduced by 8ecb790ea8c3,
  and attempted to silence them by making the destination 64 and rejecting
  too-long strings from the on-disk copy of s_mount_opts, but didn't
  actually solve it at all, since the problem was always the over-read
  of the source seen by strnlen(). (Note that the report quoted in this
  commit exactly match the report today.)

Effectively revert 8ecb790ea8c3, 3db63d2c2d1d, and ee5a977b4e77, and fix
04a91570ac67 to treat s_mount_opts and ext4_tune_sb_params::mount_opts
as __nonstring.

Reported-by: 李龙兴 <coregee2000@gmail.com>
Closes: https://lore.kernel.org/lkml/CAHPqNmzBb2LruMA6jymoHXQRsoiAKMFZ1wVEz8JcYKg4U6TBbw@mail.gmail.com/
Fixes: ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Here's the alternative, though I have not heavily tested this. I'm hoping
the ext4 regression tests have images with 64 character s_mount_opts...

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <linux-ext4@vger.kernel.org>
---
 fs/ext4/ext4.h            |  2 +-
 include/uapi/linux/ext4.h |  2 +-
 fs/ext4/ioctl.c           | 12 ++++++------
 fs/ext4/super.c           |  5 ++---
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 56112f201cac..588d51a41c38 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1448,7 +1448,7 @@ struct ext4_super_block {
 	__le64	s_last_error_block;	/* block involved of last error */
 	__u8	s_last_error_func[32] __nonstring;	/* function where the error happened */
 #define EXT4_S_ERR_END offsetof(struct ext4_super_block, s_mount_opts)
-	__u8	s_mount_opts[64];
+	__u8	s_mount_opts[64] __nonstring;
 	__le32	s_usr_quota_inum;	/* inode for tracking user quota */
 	__le32	s_grp_quota_inum;	/* inode for tracking group quota */
 	__le32	s_overhead_clusters;	/* overhead blocks/clusters in fs */
diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
index 9c683991c32f..551373a775be 100644
--- a/include/uapi/linux/ext4.h
+++ b/include/uapi/linux/ext4.h
@@ -138,7 +138,7 @@ struct ext4_tune_sb_params {
 	__u32 clear_feature_compat_mask;
 	__u32 clear_feature_incompat_mask;
 	__u32 clear_feature_ro_compat_mask;
-	__u8  mount_opts[64];
+	__u8  mount_opts[64] __kernel_nonstring;
 	__u8  pad[68];
 };
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7ce0fc40aec2..9fd4118c9805 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1292,7 +1292,9 @@ static int ext4_ioctl_get_tune_sb(struct ext4_sb_info *sbi,
 	ret.raid_stripe_width = le32_to_cpu(es->s_raid_stripe_width);
 	ret.encoding = le16_to_cpu(es->s_encoding);
 	ret.encoding_flags = le16_to_cpu(es->s_encoding_flags);
-	strscpy_pad(ret.mount_opts, es->s_mount_opts);
+	memcpy_and_pad(ret.mount_opts, sizeof(ret.mount_opts),
+		       es->s_mount_opts,
+		       strnlen(es->s_mount_opts, sizeof(es->s_mount_opts)), 0);
 	ret.feature_compat = le32_to_cpu(es->s_feature_compat);
 	ret.feature_incompat = le32_to_cpu(es->s_feature_incompat);
 	ret.feature_ro_compat = le32_to_cpu(es->s_feature_ro_compat);
@@ -1353,7 +1355,9 @@ static void ext4_sb_setparams(struct ext4_sb_info *sbi,
 		es->s_encoding = cpu_to_le16(params->encoding);
 	if (params->set_flags & EXT4_TUNE_FL_ENCODING_FLAGS)
 		es->s_encoding_flags = cpu_to_le16(params->encoding_flags);
-	strscpy_pad(es->s_mount_opts, params->mount_opts);
+	memcpy_and_pad(es->s_mount_opts, sizeof(es->s_mount_opts),
+		       params->mount_opts,
+		       strnlen(params->mount_opts, sizeof(params->mount_opts)), 0);
 	if (params->set_flags & EXT4_TUNE_FL_EDIT_FEATURES) {
 		es->s_feature_compat |=
 			cpu_to_le32(params->set_feature_compat_mask);
@@ -1394,10 +1398,6 @@ static int ext4_ioctl_set_tune_sb(struct file *filp,
 	if (copy_from_user(&params, in, sizeof(params)))
 		return -EFAULT;
 
-	if (strnlen(params.mount_opts, sizeof(params.mount_opts)) ==
-	    sizeof(params.mount_opts))
-		return -E2BIG;
-
 	if ((params.set_flags & ~TUNE_OPS_SUPPORTED) != 0)
 		return -EOPNOTSUPP;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d0..fe3a8e7c6f03 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2477,7 +2477,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char s_mount_opts[64];
+	char s_mount_opts[sizeof(sbi->s_es->s_mount_opts) + 1];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2485,8 +2485,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)
-		return -E2BIG;
+	memtostr(s_mount_opts, sbi->s_es->s_mount_opts);
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-- 
2.34.1


