Return-Path: <linux-ext4+bounces-10901-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E44DBE44D7
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073D71A63E8D
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D462313287;
	Thu, 16 Oct 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlMTW3VV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422020DD48
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629329; cv=none; b=GgOtuKcaUdLVRRAXnmVe6hxA7BtWUI+/9vwkbNMQigsTjfva+5XSTQz3y+YBYuv0FQ5uS8w+VVeSs0MEtmDea72FKlATqbL/Jda0nGIBPeATzJP1BG+SaI9xliZUfORrB8puxw/ogypiXGHPJMmpXdXF5+Mse6aXSUJw18fcXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629329; c=relaxed/simple;
	bh=0CcE05G1rlAyw+b5VR7fwhpXdzh5iob9wijO1IAzURs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZIhq2bRVMVLunvA9bm6gfKG1+W+Qa1T1dwtJ635keBq+f9ZwD20dBCodVxTOUM2HYbD8ZPojNaxc8WPqcSrkwIG5Y5n4radJb7DBqRmMmAZdJAqFqXpfjapWb74eostcWXc4Pwgk5Y6HWaEWRZicXY7HR1Jek++GrN9fbRMXjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlMTW3VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095F9C4CEFB;
	Thu, 16 Oct 2025 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629329;
	bh=0CcE05G1rlAyw+b5VR7fwhpXdzh5iob9wijO1IAzURs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UlMTW3VVz1Ya78PX8EZgNs971y1gL470XJAcc7dG6XhusWdMpWhUyCrQNZfzY1/Vb
	 rmXffGL6UDHpR/1W+8kUPabadZasrWYjrb6tN+KCoHTRCzdjxJN1u6iWSFPkHVIzDw
	 pjlqEoR38wytFXeaXvv+z/Nvhx6eg2CmIOGLwmR+DD0f71m+0YSW7NfmB15IHSl2j+
	 D2M6a5OrrP1FHawZgwlY3CrcL5ZaqHwDmun9FYDHkyIHvym5CAdmYuYJmlQb1YUyWh
	 dtQee7j2PrA3Qh6s3kwPPo67EAB4lwIP+uvvIHhF485JEg61ZDh5w4YH+rQsJO0D9Z
	 ydVnnJmjDeOOg==
Date: Thu, 16 Oct 2025 08:42:08 -0700
Subject: [PATCH 09/16] fuse2fs: fix memory corruption when parsing mount
 options
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915628.3343688.6702643409617373122.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

struct fuse_opt has this interesting behavior -- if you set the offset
field to a non-negative value, then it will treat that value as a byte
offset into the data parameter that is passed to fuse_opt_parse.

Unfortnately, process_opt computes a pointer from ((char *)data +
offset), casts that to an int pointer(!), and dereferences the int
pointer to set the value.  Therefore, we cannot have uint8_t fields in
struct fuse2fs because that will lead to subtle memory corruption.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: c7f2688540d95e ("fuse2fs: compact all the boolean flags in struct fuse2fs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 0a862ea086cbde..868b889912857d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -217,17 +217,19 @@ struct fuse2fs {
 	pthread_mutex_t bfl;
 	char *device;
 	char *shortdev;
-	uint8_t ro;
-	uint8_t debug;
-	uint8_t no_default_opts;
-	uint8_t panic_on_error;
-	uint8_t minixdf;
-	uint8_t fakeroot;
-	uint8_t alloc_all_blocks;
-	uint8_t norecovery;
-	uint8_t kernel;
-	uint8_t directio;
-	uint8_t acl;
+
+	/* options set by fuse_opt_parse must be of type int */
+	int ro;
+	int debug;
+	int no_default_opts;
+	int panic_on_error;
+	int minixdf;
+	int fakeroot;
+	int alloc_all_blocks;
+	int norecovery;
+	int kernel;
+	int directio;
+	int acl;
 
 	int logfd;
 	int blocklog;


