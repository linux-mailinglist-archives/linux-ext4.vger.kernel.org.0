Return-Path: <linux-ext4+bounces-7532-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB5FAA0694
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 11:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE01188733B
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B229E075;
	Tue, 29 Apr 2025 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQv6tmsF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078A70800;
	Tue, 29 Apr 2025 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917409; cv=none; b=JH2pCay0k7GnR+F9HQmArskbd9pbC1PayL/SAodP5/5CtxNqFUFfoIah3q1tmCZn/YdgR9OiX92AeuBOu457vgTpuqjQ48kpkCulCiLU2HdqJXdTeWdmXM2TahW1ZxNQJL/8kNnLkwcuOGoHuZ4Ug8gGnL1Dj0pGzistIXY8O4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917409; c=relaxed/simple;
	bh=YfwOl/Apt0Ww0l0wBUxiUguq34+bBlhf53vHcub4MYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK8oGzAlxT3H9Gr1yZ9Q3KD7zR8/66YJkyVS6uARwOwpTwxJK42SHwss5TTzUHogcfHmFej4zdqu57q28qx6MAT0JuhRBbDDj4VlgrOKTy647bjucXS+1TGH/4u2pepX+1KUiABmC6yOM6FnYSwpNxicHjz/Ba6ABeSxgPkivcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQv6tmsF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736c062b1f5so4829948b3a.0;
        Tue, 29 Apr 2025 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745917407; x=1746522207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms755xbKCpd+/sKco8M1N+WIlI7nHIfhLDNPYdncmRI=;
        b=DQv6tmsFNe5F1dcTwLucAK63mlstmO+gCrDcyZe+2k7Kd3NAD0dCCW0nlZw5IwtxUl
         ceVsErjp4O0BRcvTTdZ/7W8rLUuOfVCEJ6drAsqjzvi6eZVWRaFlcSAqQnwSBG5ukzAx
         n6ltagkoSUeRC+Ai8vGHlZgoTcGhpl8Jb56IGp/IQ2vlBJeQV4+sgY/Udhe2R8uwBmJl
         H0y2ZNuKmwycOQQWSccG72O+QoBCv3rrfrW0N2oLT3WfL7jNpSorTu2IZOuotdF+76Ub
         FmOL4wyS8bVBiEtp3rgr8AvdCdDjPfyVmGPHXr9+7wK1W9bpKOXpsueuPAMYl9b2TNoy
         5iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917407; x=1746522207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms755xbKCpd+/sKco8M1N+WIlI7nHIfhLDNPYdncmRI=;
        b=ATy5eBro4L6FvaIWiupgD90lCGb2V74/+DUG2gsbE9QJAYHARPmVoQ6fSc2eQJ05Af
         eNMPUyII9GtrvjU7RMLswaAgCeiP/cH3GjVW4408258orAqPYbGkiIOWfBM+EfIRAOvv
         2aOS/I7DTSFIrx3amrwo5eztOW5foFWJ3bVgJg9tlH3b8aT6F5VJUMHV2aqkTF3GLRN+
         IKTe9cOw2hiwdt2ALO3pc1+QN37fIodhMlmwx36K1DIS+OPcycrebc6ikzK9qn3ychhJ
         f7O5ReIqs1twGmr5KFnR4lqWP59Gwh4DOrZStAvSwU3u3/EALFlklKR0QjyzWqVceBI7
         zMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS4LW6nU2TQv+QPGYAecXx/AHbkSy8GTBZsMwryCPEUFb0a31ZPbSOnaYC/1+pNmnjDnH83W4M@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19YOey6cIdtF0vW9XyPWe0oMmRCefxRRul8f9JSSii+DEUP4K
	kbDxkUvBKYsEmSdZlcmIckvz0ex2AxYkyduDOhTRnl2mcor6dhgloBlHYg==
X-Gm-Gg: ASbGnctao720C75jUVKgXCExbJzjhkYv3Ona7Qq18ImPdf2Ns6RXBVFQkWw4847ycgs
	MxQsBFP5aQWcXQRy8w3CsPsCVJ7PF1DZldpIbp1dnq9D8jdEsSPbb1oBd7ZzHUm62JbVbYRZ1lt
	l4qt8Eg8a0v3gHeVkpKtDwFhQIsS6u6CuutR9WAAEvNI1Zn74ENbBqa8n5T5ot7qFF+lYdOKIA4
	7gp56BO8Oy3raFcNigiUf29Rvfnicqvx+LtqD3adkITcP4slgexI8X5vQLUkQ9tvFwVCVvtQDS+
	PgB8Xyqbq8gghdwdt7K8zzVC+UNSmt6UtayMN1DFsQdl+brEEFHmgRfXYkoQ5bvnFnFUK1QAcMe
	Pzh8MEZnzBxQLYkyTeQ==
X-Google-Smtp-Source: AGHT+IFNhGWCCwA/n8JbnkxCS7usv0RPKofyAnayoBVShQQYckuI75xFzCWshG0du4d7/MIDIvpzaw==
X-Received: by 2002:a05:6a20:7f87:b0:1f5:8072:d7f3 with SMTP id adf61e73a8af0-2093e724297mr3927963637.30.1745917406656;
        Tue, 29 Apr 2025 02:03:26 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25acaba0sm9341237b3a.169.2025.04.29.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:03:26 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	hch@infradead.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v2 1/1] xfs: Fail remount with noattr2 on a v5 with v4 enabled
Date: Tue, 29 Apr 2025 14:32:08 +0530
Message-ID: <94a5d92139aef3a42929325bc61584437957190e.1745916682.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1745916682.git.nirjhar.roy.lists@gmail.com>
References: <cover.1745916682.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bug: When we compile the kernel with CONFIG_XFS_SUPPORT_V4=y,
remount with "-o remount,noattr2" on a v5 XFS does not
fail explicitly.

Reproduction:
mkfs.xfs -f /dev/loop0
mount /dev/loop0 /mnt/scratch
mount -o remount,noattr2 /dev/loop0 /mnt/scratch

However, with CONFIG_XFS_SUPPORT_V4=n, the remount
correctly fails explicitly. This is because the way the
following 2 functions are defined:

static inline bool xfs_has_attr2 (struct xfs_mount *mp)
{
	return !IS_ENABLED(CONFIG_XFS_SUPPORT_V4) ||
		(mp->m_features & XFS_FEAT_ATTR2);
}
static inline bool xfs_has_noattr2 (const struct xfs_mount *mp)
{
	return mp->m_features & XFS_FEAT_NOATTR2;
}

xfs_has_attr2() returns true when CONFIG_XFS_SUPPORT_V4=n
and hence, the the following if condition in
xfs_fs_validate_params() succeeds and returns -EINVAL:

/*
 * We have not read the superblock at this point, so only the attr2
 * mount option can set the attr2 feature by this stage.
 */

if (xfs_has_attr2(mp) && xfs_has_noattr2(mp)) {
	xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
	return -EINVAL;
}

With CONFIG_XFS_SUPPORT_V4=y, xfs_has_attr2() always return
false and hence no error is returned.

Fix: Check if the existing mount has crc enabled(i.e, of
type v5 and has attr2 enabled) and the
remount has noattr2, if yes, return -EINVAL.

I have tested xfs/{189,539} in fstests with v4
and v5 XFS with both CONFIG_XFS_SUPPORT_V4=y/n and
they both behave as expected.

This patch also fixes remount from noattr2 -> attr2 (on a v4 xfs).

Related discussion in [1]

[1] https://lore.kernel.org/all/Z65o6nWxT00MaUrW@dread.disaster.area/

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 fs/xfs/xfs_super.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..1fd45567ae00 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2114,6 +2114,22 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* attr2 -> noattr2 */
+	if (xfs_has_noattr2(new_mp)) {
+		if (xfs_has_crc(mp)) {
+			xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
+			return -EINVAL;
+		}
+		else {
+			mp->m_features &= ~XFS_FEAT_ATTR2;
+			mp->m_features |= XFS_FEAT_NOATTR2;
+		}
+	} else if (xfs_has_attr2(new_mp)) {
+		/* noattr2 -> attr2 */
+		mp->m_features &= ~XFS_FEAT_NOATTR2;
+		mp->m_features |= XFS_FEAT_ATTR2;
+	}
+
 	/* inode32 -> inode64 */
 	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
 		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
@@ -2126,6 +2142,15 @@ xfs_fs_reconfigure(
 		mp->m_maxagi = xfs_set_inode_alloc(mp, mp->m_sb.sb_agcount);
 	}
 
+	/* Now that mp has been modified according to the remount options, we do a
+	 * final option validation with xfs_finish_flags() just like it is done
+	 * during mount. We cannot use xfs_finish_flags() on new_mp as it contains
+	 * only the user given options.
+	 */
+	error = xfs_finish_flags(mp);
+	if (error)
+		return error;
+
 	/* ro -> rw */
 	if (xfs_is_readonly(mp) && !(flags & SB_RDONLY)) {
 		error = xfs_remount_rw(mp);
-- 
2.43.5


