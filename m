Return-Path: <linux-ext4+bounces-13604-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIimBQxdhmlfMQQAu9opvQ
	(envelope-from <linux-ext4+bounces-13604-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 22:28:44 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA031036DA
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 22:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 016A5306814F
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 21:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6F0311966;
	Fri,  6 Feb 2026 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf0CKj74"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94B168BD;
	Fri,  6 Feb 2026 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770413227; cv=none; b=HY0cgfU8MLtKGOu/2BxQiiZ0b61+6d/0uQLIWS3iiRHCRo0SUIkMhFtmVI9n8mvpZ8S2WnGPcNPLu5LaBsheQO9JfSzUlAeYKjDWsj+A/rmwJB4WEhAmkb8sc6K9PazfVZaBzCvAPzLAV/u/dor6YbruZdkbMdkhVvyEmUJ8N9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770413227; c=relaxed/simple;
	bh=OiXVY1vI80wzSxaGlo+lQpLE1RdgdtyDMpPUx9FkJVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WWgAIhmFD+5dZv8bGU4zRvf9ejfBCw+CBMI5wKftPWKcVK/ZkuyUb/7eOFk87GfGS/7fRP+S7uLOTwBBq37bqoyFkc3qL54qWbmDW2bSU4neJlOKrqjgqwNRutFd9q8nehbSEa8c2JDnlzbgeh3/qiU3I7/ZUAek8MriNWfEIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf0CKj74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38600C116C6;
	Fri,  6 Feb 2026 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770413227;
	bh=OiXVY1vI80wzSxaGlo+lQpLE1RdgdtyDMpPUx9FkJVk=;
	h=From:To:Cc:Subject:Date:From;
	b=Nf0CKj74pfsoJHwPLVWnNVdihiG8LQWiNZz0vSPmEkWtlzOx7IlgcHikgEdzOBEPq
	 he/zBElOCyoFNwvK6eYNWCj2IMadprCCx0NWQ3VpTiJ+FIR37stEiuN0Ibk0bc/g0J
	 5xF1h1DVep9Fb/lVRM7K5GrFkCJNGyACzDLHGpC6jd0NMuqg5AYgubU1183F3hJtaG
	 LR8GXMqIaDSKvHpB79xvJNORC1Fom3SJclmlMVAnu+q+52/8wMfJIzW6XyX77Srdej
	 Dm9wk1vAjrwe+EAxVdq97BZpXkBhMtRgZkEM/n/KH1W4WvUp4q6xhM9LhHKQj0n5Ro
	 fxjJCjnpJGq2w==
From: Kees Cook <kees@kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?=E6=9D=8E=E9=BE=99=E5=85=B4?= <coregee2000@gmail.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ext4: Reject on-disk mount options with missing NUL-terminator
Date: Fri,  6 Feb 2026 13:27:03 -0800
Message-Id: <20260206212654.work.035-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4850; i=kees@kernel.org; h=from:subject:message-id; bh=OiXVY1vI80wzSxaGlo+lQpLE1RdgdtyDMpPUx9FkJVk=; b=owGbwMvMwCVmps19z/KJym7G02pJDJltMcs3tfI+cCzorHHbEZC1uZKB813cHluzuu2ZWYsF1 Vew6bzpKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmEhDCiPDIoFJf6cuY+oOLj8k q718xXa+t1JvrGzyEi6WHDn3b8PsTYwMVxmtZJsWs5gtWJV+9ttWJrtkHRYh+63n7m+Tq7hbx6L KCwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,dilger.ca,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13604-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dilger.ca:email]
X-Rspamd-Queue-Id: 6AA031036DA
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

Reject the mount with an error instead. While there is an existing similar
check in the ioctl path (which validates userspace input before writing
TO disk), this check validates data read FROM disk before parsing.

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
  for the case of an unterminated s_mount_opts. (But strscpy_pad() will
  fail due to the over-read of s_mount_opts by strnlen().)

3db63d2c2d1d ("ext4: check if mount_opts is NUL-terminated in ext4_ioctl_set_tune_sb()")
  As a continuation of trying to solve the 64/65 mismatch, this started
  enforcing a 63 character limit (i.e. 64 bytes total) to incoming values
  from userspace to the ioctl API. (But did not check s_mount_opts coming
  from disk.)

ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")
  Notices the loud failures of strscpy_pad() introduced by 8ecb790ea8c3,
  and attempted to silence them by making the destination 64 and rejecting
  too-long strings from the on-disk copy of s_mount_opts, but didn't
  actually solve it at all, since the problem was always the over-read
  of the source seen by strnlen(). (Note that the report quoted in this
  commit exactly matches the report today.)

The other option is to go back in time and mark both s_mount_opts and
mount_opts as __nonstring and switch to using memcpy_and_pad() to copy
them around between userspace and kernel and disk instead of making them
C strings.

What do the ext4 regression tests expect for s_mount_opts? Is there a
test for a non-terminated s_mount_opts in an image?

Reported-by: 李龙兴 <coregee2000@gmail.com>
Closes: https://lore.kernel.org/lkml/CAHPqNmzBb2LruMA6jymoHXQRsoiAKMFZ1wVEz8JcYKg4U6TBbw@mail.gmail.com/
Fixes: ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <linux-ext4@vger.kernel.org>
---
 fs/ext4/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d0..9ad6005615d8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2485,6 +2485,13 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
+	if (strnlen(sbi->s_es->s_mount_opts, sizeof(sbi->s_es->s_mount_opts)) ==
+	    sizeof(sbi->s_es->s_mount_opts)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Mount options in superblock are not NUL-terminated");
+		return -EINVAL;
+	}
+
 	if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)
 		return -E2BIG;
 
-- 
2.34.1


