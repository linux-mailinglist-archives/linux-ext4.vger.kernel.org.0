Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26C51BC599
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgD1Qpx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:45:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37860 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728290AbgD1Qpx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 12:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0vMC3HuJzPIw1Ztt6E6uDdv1TccYRho20hVFuaD/RNM=;
        b=KDQljXnOC3K+qlw12RhGL5RWACdSUmXLSnXB8tIrEHzAOsS1GZtV0/kJ+A3iDpPaHqPgKc
        mo40plaZC2jOx8n6XTPJQCKIu4Am815qjnyAzICo5/TUcWfOxYd3M2Ju3zrCwE06Iryzzc
        Ne3qijqpKrHO8VM2jR8VNtK+GCiB/ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-VZRJNup3MrKlj5TAJFSUSQ-1; Tue, 28 Apr 2020 12:45:49 -0400
X-MC-Unique: VZRJNup3MrKlj5TAJFSUSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFC6C835B42;
        Tue, 28 Apr 2020 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C271D1010403;
        Tue, 28 Apr 2020 16:45:47 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 03/17] ext4: move option validation to a separate function
Date:   Tue, 28 Apr 2020 18:45:22 +0200
Message-Id: <20200428164536.462-4-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Move option validation out of parse_options() into a separate function
ext4_validate_options().

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fed2e4cafb38..5f8d21568c8d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -88,6 +88,7 @@ static void ext4_unregister_li_request(struct super_blo=
ck *sb);
 static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 					    unsigned int journal_inum);
+static int ext4_validate_options(struct super_block *sb);
=20
 /*
  * Lock ordering
@@ -2253,10 +2254,9 @@ static int parse_options(char *options, struct sup=
er_block *sb,
 			 unsigned int *journal_ioprio,
 			 int is_remount)
 {
-	struct ext4_sb_info __maybe_unused *sbi =3D EXT4_SB(sb);
-	char *p, __maybe_unused *usr_qf_name, __maybe_unused *grp_qf_name;
 	substring_t args[MAX_OPT_ARGS];
 	int token;
+	char *p;
=20
 	if (!options)
 		return 1;
@@ -2274,7 +2274,14 @@ static int parse_options(char *options, struct sup=
er_block *sb,
 				     journal_ioprio, is_remount) < 0)
 			return 0;
 	}
+	return ext4_validate_options(sb);
+}
+
+static int ext4_validate_options(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 #ifdef CONFIG_QUOTA
+	char *usr_qf_name, *grp_qf_name;
 	/*
 	 * We do the test below only for project quotas. 'usrquota' and
 	 * 'grpquota' mount options are allowed even without quota feature
--=20
2.21.1

