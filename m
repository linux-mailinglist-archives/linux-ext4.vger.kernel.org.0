Return-Path: <linux-ext4+bounces-5068-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA39C4F78
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 08:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D416282ADA
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE9320A5FE;
	Tue, 12 Nov 2024 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CqficmTH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54044849C
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396869; cv=none; b=nWeYmhc4EXgWo7oAyMm1t2vua5KqAF9Zx3Vn1EfuP3dFQ9tBXcHWLDueSxor6cxvJAQE+SWKlhCTAHgWhOywyPK8UBVB1vKp3DUaZgJLI0e0Pt1xDpYRfC2sa60y5wQ7I1yohW+miXvrkAnCBZmrQ7pf03pyz8cr13pW5Pg8Ir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396869; c=relaxed/simple;
	bh=S9AWkh9lGMhvCzL2BzrZte8v4YH0TGUUAI683H2TIAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zp57x/xiYzeGgnTC+b70scxDCHr+dIHHrFzsCJtydVcMVXGLypIlCvq5ieQMjjr2or0UCgSBqG2oKzpMgOipqlQSDjpZtsIChFdoNVA+gGjwVvJ1tr/QN0+wwWQy07dZ7oHgk4jMNP9jXaYM2ViET0NcagY4sZUAyiOxXqP8EcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CqficmTH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso2762770a12.3
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 23:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731396865; x=1732001665; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeJvnOkpNipvaH1FIbSRW01azEBiVaLjEayar5yqJZ0=;
        b=CqficmTHKGs/MaYDU2QMwrYH+YS9FYeC/8DBMHalbXRNszRF/QhzOJLyuRLbGiAK4T
         ZcV9XSyemU0NLOaK/GVzi5k/2OlTUK9NTGWGo2QnUaybPuUjBzLqrcciMdG3fpsrQSe/
         1YTNMBGLsMjEH2mjnl7TgDihDCWYe3LNIKYEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731396865; x=1732001665;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeJvnOkpNipvaH1FIbSRW01azEBiVaLjEayar5yqJZ0=;
        b=LffBG8j3MlbE9xRqSMSIqlU6vZLa6unOpPamvdlZk8wsBMrJb9HI/WJec0togFJ45z
         DgN0zef483FBAtW/Ur2ez//je9ul90gnS7Bu78YIfyrvFzqa4CfpURAA1xrs1p5FA6V4
         YHJp2QRnNK+voZm6lnJEaWxEhsXROYMa/CgUT0n0qiu9lQmngQOSX6ZNvHGlCp+fu/Tr
         rY5sSIPrGcHdS909hBXE8JQ2KUMZpSg+DOVFv7+ixuRf0kSp7P0u0tFSA5gARU+GPt6R
         dZOZ0BHNSc5y2tbqukgWcG2yI+2dDoyVeiXcLSP5gYrBgPJu0n9/7QWcBXNMQEnbAhQO
         TkaQ==
X-Gm-Message-State: AOJu0Yy7JKdbCDCcfxoaA0VThx7HUfOA1eSsAcilxxHR27bHhN7WuGzL
	MG0EbhsaKhQmUjkf/ZyM2nkgVbrgGYieHAv4h0C3O+KnesLMuhBnwftsWdI5dw==
X-Google-Smtp-Source: AGHT+IGzWCGIJVN1Bajk3aY5Ezm0oGO0lMUy5hZgd6Or9HJzTzqB441BAapCmsVuWlClMnfbPI4K8g==
X-Received: by 2002:a05:6a20:2593:b0:1db:dc9d:47e9 with SMTP id adf61e73a8af0-1dc22b5924amr21557904637.32.1731396865405;
        Mon, 11 Nov 2024 23:34:25 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:9e09:d4e8:509d:405b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5a1d1sm86778005ad.210.2024.11.11.23.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 23:34:25 -0800 (PST)
Date: Tue, 12 Nov 2024 16:34:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ext4: possible circular locking dependency at ext4_xattr_inode_create
Message-ID: <20241112073421.GD1458936@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've a following syzkaller report (no reproducer); the report is
against 5.15, but the same call-chain seems possible in current
upstream as well.  So I suspect that maybe ext4_xattr_inode_create()
should take nested inode_lock (I_MUTEX_XATTR) instead.  Does the
patch below make any sense?

======================================================
WARNING: possible circular locking dependency detected
5.15.168-syzkaller-23766-g3f37c55c6291 #0 Not tainted
------------------------------------------------------
syz-executor297/1452 is trying to acquire lock:
ffff888120b5e750 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock
ffff888120b5e750 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_create
ffff888120b5e750 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_lookup_create
ffff888120b5e750 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_set_entry+0x2aeb/0x3200

but task is already holding lock:
ffff888120b58c68 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_setattr+0x12b5/0x1950

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ei->i_data_sem/3){++++}-{3:3}:
       down_write+0x38/0x60
       ext4_update_i_disksize
       ext4_xattr_inode_write
       ext4_xattr_inode_lookup_create
       ext4_xattr_set_entry+0x2839/0x3200
       ext4_xattr_ibody_set+0x113/0x320
       ext4_xattr_set_handle+0xa31/0x1440
       ext4_xattr_set+0x266/0x3d0
       __vfs_setxattr+0x15e/0x1c0
       __vfs_setxattr_noperm+0x128/0x5e0
       vfs_setxattr+0x1c6/0x410
       setxattr+0x1d6/0x270
       path_setxattr+0x1cc/0x2b0
       __do_sys_lsetxattr
       __se_sys_lsetxattr
       __x64_sys_lsetxattr+0xb4/0xd0
       do_syscall_x64
       do_syscall_64+0x69/0xc0
       entry_SYSCALL_64_after_hwframe+0x66/0xd0

-> #0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       check_prev_add
       check_prevs_add
       validate_chain
       __lock_acquire+0x2c95/0x7850
       lock_acquire+0x1d2/0x4e0
       down_write+0x38/0x60
       inode_lock
       ext4_xattr_inode_create
       ext4_xattr_inode_lookup_create
       ext4_xattr_set_entry+0x2aeb/0x3200
       ext4_xattr_block_set+0xdc1/0x2de0
       ext4_xattr_move_to_block
       ext4_xattr_make_inode_space
       ext4_expand_extra_isize_ea+0xe58/0x19c0
       __ext4_expand_extra_isize+0x2fd/0x400
       ext4_try_to_expand_extra_isize
       __ext4_mark_inode_dirty+0x58b/0x840
       ext4_setattr+0x1341/0x1950
       notify_change+0xafb/0xd80
       do_truncate+0x218/0x2f0
       handle_truncate
       do_open
       path_openat+0x27d3/0x2e10
       do_filp_open+0x23a/0x360
       do_sys_openat2+0x188/0x720
       do_sys_open+0x1d1/0x220
       do_syscall_x64
       do_syscall_64+0x69/0xc0
       entry_SYSCALL_64_after_hwframe+0x66/0xd0

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/3);
                               lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->i_data_sem/3);
  lock(&ea_inode->i_rwsem#8/1);

 *** DEADLOCK ***

5 locks held by syz-executor297/1452:
 #0: ffff88811231c460 (sb_writers#5){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80
 #1: ffff888120b58de0 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock
 #1: ffff888120b58de0 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: do_truncate+0x204/0x2f0
 #2: ffff888120b58f80 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock
 #2: ffff888120b58f80 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_setattr+0xd49/0x1950
 #3: ffff888120b58c68 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_setattr+0x12b5/0x1950
 #4: ffff888120b58ab8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr
 #4: ffff888120b58ab8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize
 #4: ffff888120b58ab8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x4f7/0x840

stack backtrace:
Call Trace:
 <TASK>
 __dump_stack
 dump_stack_lvl+0x1e3/0x2d0
 check_noncircular+0x2f3/0x3a0
 check_prev_add
 check_prevs_add
 validate_chain
 __lock_acquire+0x2c95/0x7850
 lock_acquire+0x1d2/0x4e0
 down_write+0x38/0x60
 inode_lock
 ext4_xattr_inode_create
 ext4_xattr_inode_lookup_create
 ext4_xattr_set_entry+0x2aeb/0x3200
 ext4_xattr_block_set+0xdc1/0x2de0
 ext4_xattr_move_to_block
 ext4_xattr_make_inode_space
 ext4_expand_extra_isize_ea+0xe58/0x19c0
 __ext4_expand_extra_isize+0x2fd/0x400
 ext4_try_to_expand_extra_isize
 __ext4_mark_inode_dirty+0x58b/0x840
 ext4_setattr+0x1341/0x1950
 notify_change+0xafb/0xd80
 do_truncate+0x218/0x2f0
 handle_truncate
 do_open
 path_openat+0x27d3/0x2e10
 do_filp_open+0x23a/0x360
 do_sys_openat2+0x188/0x720
 do_sys_open+0x1d1/0x220
 do_syscall_x64
 do_syscall_64+0x69/0xc0
 entry_SYSCALL_64_after_hwframe+0x66/0xd0

---

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7647e9f6e190..db3c68fbbadf 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1511,7 +1511,7 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
 		 */
 		dquot_free_inode(ea_inode);
 		dquot_drop(ea_inode);
-		inode_lock(ea_inode);
+		inode_lock_nested(inode, I_MUTEX_XATTR);
 		ea_inode->i_flags |= S_NOQUOTA;
 		inode_unlock(ea_inode);
 	}

