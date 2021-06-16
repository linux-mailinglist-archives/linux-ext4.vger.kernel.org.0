Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7CA3A984D
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 12:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhFPK7x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 06:59:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35808 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhFPK7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 06:59:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D64271FD6F;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzNcke28CCdvhGi1On7m4Wh58678UhE+mdrTdbKpFgs=;
        b=1dokGFEk73BE3pKVh1mS+cnPGLnw10NzRhgIN8vNnTZEB+j65FembphlfOeb6dReJLTZrH
        taZq9Yek0whIOgatlqF7zgQ9MO8BjMcOZ7tsYC8rwhAskoIxVBpMQN83SgvsZ1jm/W8xBS
        PPMOCC1j8ks0TTE+Hb2pxFBr7O3xLOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzNcke28CCdvhGi1On7m4Wh58678UhE+mdrTdbKpFgs=;
        b=tNYLMhCw4uWU+NtmVn5x0CvakLDhJGAqchYlpyiGEurpTKkFBHm8VTt4FFbaSrWaVqQGdo
        t0ZrfVO7V/+MnfAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B6748A3BAB;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 75BCD1F2CC1; Wed, 16 Jun 2021 12:57:45 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 8/9] mke2fs: Add orphan_file feature into mke2fs.conf
Date:   Wed, 16 Jun 2021 12:57:34 +0200
Message-Id: <20210616105735.5424-9-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616105735.5424-1-jack@suse.cz>
References: <20210616105735.5424-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Enable orphan_file feature by default in larger filesystems. Since the
feature is COMPAT, older kernels will just ignore it and happily work
with the filesystem as well.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/mke2fs.conf.in | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/misc/mke2fs.conf.in b/misc/mke2fs.conf.in
index 01e35cf83150..d97d8d643d1d 100644
--- a/misc/mke2fs.conf.in
+++ b/misc/mke2fs.conf.in
@@ -11,15 +11,17 @@
 		features = has_journal
 	}
 	ext4 = {
-		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize
+		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize,orphan_file
 		inode_size = 256
 	}
 	small = {
+		default_features = ^orphan_file
 		blocksize = 1024
 		inode_size = 128
 		inode_ratio = 4096
 	}
 	floppy = {
+		default_features = ^orphan_file
 		blocksize = 1024
 		inode_size = 128
 		inode_ratio = 8192
-- 
2.26.2

