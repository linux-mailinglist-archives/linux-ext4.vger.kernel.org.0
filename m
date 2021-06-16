Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DDF3A9849
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFPK7w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 06:59:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35792 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFPK7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 06:59:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9867D1FD49;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7pU2ek3/cmj0H8tjQ1+AqDwww25R7hx11P5k70j6k4=;
        b=B7TVgy9PYDxMRFOoe63qqSZb6ENUUueJ4wIArxNa3w/4oeGXudJaCBLphaUmESJc+vyLD6
        AOA/rVb9kVy3wRk7UsRaNJY1tTjyi2koAqggxF7qvLHmTO31y81rksDxOm95Ii6IihO1M3
        pyXF2AboOqxfTJhmuKNi22/AFKMGcio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7pU2ek3/cmj0H8tjQ1+AqDwww25R7hx11P5k70j6k4=;
        b=1wqHALJ9lGxd3iE2uJQM0jJtMzgAaFKX2+hDZASskFqd7tjyWodazoB3r9VJ9JRoVI501s
        EzOQZZFysh4JTABQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 863B9A3B81;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5CD531F2CB9; Wed, 16 Jun 2021 12:57:45 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/9] ext2fs: Drop HAS_SNAPSHOT feature
Date:   Wed, 16 Jun 2021 12:57:27 +0200
Message-Id: <20210616105735.5424-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616105735.5424-1-jack@suse.cz>
References: <20210616105735.5424-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It has never been implemented and is dead for quite some time and
unused AFAICT.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/ext2fs/ext2_fs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index e92a045205a9..6f1d5db4b482 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -825,7 +825,6 @@ struct ext2_super_block {
 #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM		0x0010
 #define EXT4_FEATURE_RO_COMPAT_DIR_NLINK	0x0020
 #define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE	0x0040
-#define EXT4_FEATURE_RO_COMPAT_HAS_SNAPSHOT	0x0080
 #define EXT4_FEATURE_RO_COMPAT_QUOTA		0x0100
 #define EXT4_FEATURE_RO_COMPAT_BIGALLOC		0x0200
 /*
@@ -926,7 +925,6 @@ EXT4_FEATURE_RO_COMPAT_FUNCS(huge_file,		4, HUGE_FILE)
 EXT4_FEATURE_RO_COMPAT_FUNCS(gdt_csum,		4, GDT_CSUM)
 EXT4_FEATURE_RO_COMPAT_FUNCS(dir_nlink,		4, DIR_NLINK)
 EXT4_FEATURE_RO_COMPAT_FUNCS(extra_isize,	4, EXTRA_ISIZE)
-EXT4_FEATURE_RO_COMPAT_FUNCS(has_snapshot,	4, HAS_SNAPSHOT)
 EXT4_FEATURE_RO_COMPAT_FUNCS(quota,		4, QUOTA)
 EXT4_FEATURE_RO_COMPAT_FUNCS(bigalloc,		4, BIGALLOC)
 EXT4_FEATURE_RO_COMPAT_FUNCS(metadata_csum,	4, METADATA_CSUM)
-- 
2.26.2

