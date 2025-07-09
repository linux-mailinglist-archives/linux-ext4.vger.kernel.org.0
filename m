Return-Path: <linux-ext4+bounces-8905-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9FBAFEF3A
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 18:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0610D189EEF6
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EB1221FC0;
	Wed,  9 Jul 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErIX8iPf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E022126A
	for <linux-ext4@vger.kernel.org>; Wed,  9 Jul 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079914; cv=none; b=QhUMaim2hhZEB5qiRYQYDFP/J++/kYx9CjnadNw9myZYs4V9xNY/54p3tCi5Bch60FYVoBW4TekQXo4iU/fMxLSfGgZkMgigbm9GRrinmesZyPOUcs4tj0fiMOh+Em4XxzCoejpTS4WI6b7G2hpoiQY4HaodeLHEYzRtJAE0WO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079914; c=relaxed/simple;
	bh=e7l99A14nbjyz9j5qEDX3CAkhXKclAN64tWMh80wG8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rak+u7v3glUXIAwF8SDuiQTMmHwcTxV4TtesVdatDxeJwyH9i9Jsm4v38zxLmV8GEdPGuzZvOdZIR7R+BK7MF9BfIk6PucdqCo6zDsm+WB5dpfvxZcmZbQpFTmW9H1EGSkZbKI1Jj6myZe3hFKxWjvJ+1bZB8PSnjWfkfuGWb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErIX8iPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77796C4CEEF;
	Wed,  9 Jul 2025 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752079913;
	bh=e7l99A14nbjyz9j5qEDX3CAkhXKclAN64tWMh80wG8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErIX8iPf5J2TM5eoI2dKpby9lZiRcyjsDwbh8SgB6iW/Rw6hfgY3sX/HnATA0Sc92
	 FaMXEXxPlZpH0gDdndRflaDNkxWqWzgQM0tUDd5rvhmBlsFcLDOl1Ws1WWFkGQ5oNC
	 zFqAjEg00k0z/+0jdWPDnOvM86/uJT6aWgJ7GmeXPMwgoT+H/f+5SsSqtuwem9Sjim
	 1BuS802nkt9kL8e+/Dw90i5BccVmdUfZfi6vmPVmoUph+4gcCkcAchp6kAT32eneSk
	 9CbFYcVowhqm/mIHqSfVjeZytq+EtIaKp5PxBDNzL5cC3IteRtg7iUZu3UjdseV3p3
	 BAIOh65tuCEUQ==
Date: Wed, 9 Jul 2025 09:51:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 11/8] fuse2fs: fix race condition in op_destroy
Message-ID: <20250709165152.GE2672022@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

On a regular fuse server (i.e. one not running in fuseblk mode), libfuse
synthesizes and dispatches a FUSE_DESTROY command as soon as the event
dispatch loop terminates after the kernel disconnects /dev/fuse.
Unfortunately, this is done without coordinating with any other threads
that may have already received a real FUSE command from the kernel.

In other words, FUSE_DESTROY can run in parallel with other
fuse_operations.  Therefore, we must guard the body of this function
with the BKL just like any other fuse operation or risk races within
libext2fs.  If we're lucky, we trash the ext2_filsys state and
generic/488 will crash.

[23512.452451] [U] fuse: reading device: Software caused connection abort
[23512.453886] [U] fuse: reading device: Software caused connection abort

If we're not lucky, it corrupts the ondisk filesystem resulting in a
e2fsck complaining as well.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ff8d4668cee217..f0250bd1cec2ec 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -728,7 +728,10 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC);
 		return;
 	}
+
+	pthread_mutex_lock(&ff->bfl);
 	fs = ff->fs;
+
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
 	if (fs->flags & EXT2_FLAG_RW) {
 		fs->super->s_state |= EXT2_VALID_FS;
@@ -763,6 +766,8 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		uuid_unparse(fs->super->s_uuid, uuid);
 		log_printf(ff, "%s %s.\n", _("unmounting filesystem"), uuid);
 	}
+
+	pthread_mutex_unlock(&ff->bfl);
 }
 
 static void *op_init(struct fuse_conn_info *conn

