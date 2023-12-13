Return-Path: <linux-ext4+bounces-422-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68285810961
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 06:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B491C20AF6
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 05:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EBFC8CB;
	Wed, 13 Dec 2023 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eSm+mNYY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59EECD;
	Tue, 12 Dec 2023 21:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702444629; x=1733980629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H/EH6tQoOujC8sN9THaYTQOj3Fa4ltukpYjXl3eXRIQ=;
  b=eSm+mNYYEP97DVsEDuPT9rL5SBEODiDy3rD1qKaHb2wYejU6rwiZ+BKI
   td0U4uqlA43sicaDKILskgtnYGQN3vibR92d8hu9pbejrKAKRhKBZpqK9
   P3HPAUoElx87PT/QxgUg+xtl1kYKTGga9PngpeQF61MH+LQnutxUbJhhT
   U=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="373447902"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:17:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id 2ABD4806BB;
	Wed, 13 Dec 2023 05:17:05 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:23380]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.95:2525] with esmtp (Farcaster)
 id 650e561f-6b55-43b2-8323-f20778c0f1b5; Wed, 13 Dec 2023 05:17:05 +0000 (UTC)
X-Farcaster-Flow-ID: 650e561f-6b55-43b2-8323-f20778c0f1b5
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 05:17:04 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.43.143.133) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 05:17:02 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <tytso@mit.edu>
CC: <adilger.kernel@dilger.ca>, <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sjitindarsingh@smail.com>, "Suraj Jitindar
 Singh" <surajjs@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH] fs/ext4: Allow for the last group to be marked as trimmed
Date: Wed, 13 Dec 2023 16:16:35 +1100
Message-ID: <20231213051635.37731-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)

The ext4 filesystem tracks the trim status of blocks at the group level.
When an entire group has been trimmed then it is marked as such and subsequent
trim invocations with the same minimum trim size will not be attempted on that
group unless it is marked as able to be trimmed again such as when a block is
freed.

Currently the last group can't be marked as trimmed due to incorrect logic
in ext4_last_grp_cluster(). ext4_last_grp_cluster() is supposed to return the
zero based index of the last cluster in a group. This is then used by
ext4_try_to_trim_range() to determine if the trim operation spans the entire
group and as such if the trim status of the group should be recorded.

ext4_last_grp_cluster() takes a 0 based group index, thus the valid values
for grp are 0..(ext4_get_groups_count - 1). Any group index less than
(ext4_get_groups_count - 1) is not the last group and must have
EXT4_CLUSTERS_PER_GROUP(sb) clusters. For the last group we need to calculate
the number of clusters based on the number of blocks in the group. Finally
subtract 1 from the number of clusters as zero based indexing is expected.
Rearrange the function slightly to make it clear what we are calculating
and returning.

Reproducer:
// Create file system where the last group has fewer blocks than blocks per group
$ mkfs.ext4 -b 4096 -g 8192 /dev/nvme0n1 8191
$ mount /dev/nvme0n1 /mnt

Before Patch:
$ fstrim -v /mnt
/mnt: 25.9 MiB (27156480 bytes) trimmed
// Group not marked as trimmed so second invocation still discards blocks
$ fstrim -v /mnt
/mnt: 25.9 MiB (27156480 bytes) trimmed

After Patch:
fstrim -v /mnt
/mnt: 25.9 MiB (27156480 bytes) trimmed
// Group marked as trimmed so second invocation DOESN'T discard any blocks
fstrim -v /mnt
/mnt: 0 B (0 bytes) trimmed

Fixes: 45e4ab320c9b ("ext4: move setting of trimmed bit into ext4_try_to_trim_range()")
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 fs/ext4/mballoc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 454d5612641ee..c15d8b6f887dd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6731,11 +6731,16 @@ __acquires(bitlock)
 static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
 					   ext4_group_t grp)
 {
-	if (grp < ext4_get_groups_count(sb))
-		return EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-	return (ext4_blocks_count(EXT4_SB(sb)->s_es) -
-		ext4_group_first_block_no(sb, grp) - 1) >>
-					EXT4_CLUSTER_BITS(sb);
+	unsigned long nr_clusters_in_group;
+
+	if (grp < (ext4_get_groups_count(sb) - 1))
+		nr_clusters_in_group = EXT4_CLUSTERS_PER_GROUP(sb);
+	else
+		nr_clusters_in_group = (ext4_blocks_count(EXT4_SB(sb)->s_es) -
+					ext4_group_first_block_no(sb, grp))
+				       >> EXT4_CLUSTER_BITS(sb);
+
+	return nr_clusters_in_group - 1;
 }
 
 static bool ext4_trim_interrupted(void)
-- 
2.34.1


