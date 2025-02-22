Return-Path: <linux-ext4+bounces-6528-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD283A4066B
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2025 09:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24B8176956
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2025 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E018D206F12;
	Sat, 22 Feb 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l12j+Hs3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087472066F6;
	Sat, 22 Feb 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213640; cv=none; b=RWR+JBHvu6M7xOUCLAQj4ORdv/8G402jJwpw+SLR5ycAMpJyEe1oVBPqIzzYs+bI81Qcqf2lWMWq0V87GA6D+ZHNLZwvQ4jHh6HpQ5Sq4AI+/9J0hbLJb4KidpoX2eOyKP540HhjxlnTaRpQxFpRzrkXiVkeio0fKPS8NdwWqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213640; c=relaxed/simple;
	bh=Eh8bl2pVWJNueaAhYMrHBVA1XHH3qqIC7uOPxUWsDis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQPKG0ndbrKZCr3r+3b+6nTRsklaKcEcx80Q+uGWhsV0WThhjiCLLgyImZigfEuCqsvyMO7A+ur37c9+elI6LZstVd4TeEgbHAL8dbQCARfHvxFMrcKKnqmX0T5mSDkMpjAMhwbYbmKdontSWzaytqwrAbXIKBHGrxg1lRUxDK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l12j+Hs3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M55HBp004067;
	Sat, 22 Feb 2025 08:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4XtThhzNQNN+G+vao
	qrLy7mKY3x0takmgshiY4U7Gjs=; b=l12j+Hs3J0mfLaLht/nr+X27y70O1Iixb
	Ar6XNA8VCcmkaqcltjamb95psCssr0Xym5vtzhb+gyO1l+nIgrXR8jZEfEtlsHFF
	xjBROEFAiYiZL0YpgYgo3j8CkOZ18vOvUg+UTBegXU3GNwoetA/856FAXEF+ilMg
	min63QCw4mvjmoryu6FAimdc052LdPygdZleKGyxs87CwQ1FoL4Nu7OxhKNo1dx8
	0mj+CAjfr9ufTgzlWw2QLSFxitsYvg9JcHSqXy5Uip90eVE1o9Ysz+P4H3tzewmc
	4CIoHcvbmBBt8FXLTnzZDeaGgNExnzpVNe7SRz5hof917uAFCD4pw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y846rjr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 08:40:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51M8eX44010977;
	Sat, 22 Feb 2025 08:40:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y846rjr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 08:40:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51M898kE005817;
	Sat, 22 Feb 2025 08:40:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xvfr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 08:40:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51M8eU5p33620542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 08:40:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 616B920043;
	Sat, 22 Feb 2025 08:40:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F5A320040;
	Sat, 22 Feb 2025 08:40:28 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.30.104])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Feb 2025 08:40:28 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Mahesh Kumar <maheshkumar657g@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
Date: Sat, 22 Feb 2025 14:10:22 +0530
Message-ID: <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740212945.git.ojaswin@linux.ibm.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4g_7nRuMGfgq9AHqx8E3qko_HhDdWltC
X-Proofpoint-GUID: agpCCAzhxM4sjRy0AiVPv1JZI6fCjp3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502220066

Presently we always BUG_ON if trying to start a transaction on a journal
marked with JBD2_UNMOUNT, since this should never happen. However while
running stress tests it was observed that in case of some error handling
paths, it is possible for update_super_work to start a transaction after
the journal is destroyed eg:

(umount)
ext4_kill_sb
  kill_block_super
    generic_shutdown_super
      sync_filesystem /* commits all txns */
      evict_inodes
        /* might start a new txn */
      ext4_put_super
	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
        jbd2_journal_destroy
          journal_kill_thread
            journal->j_flags |= JBD2_UNMOUNT;
          jbd2_journal_commit_transaction
            jbd2_journal_get_descriptor_buffer
              jbd2_journal_bmap
                ext4_journal_bmap
                  ext4_map_blocks
                    ...
                    ext4_inode_error
                      ext4_handle_error
                        schedule_work(&sbi->s_sb_upd_work)

                                               /* work queue kicks in */
                                               update_super_work
                                                 jbd2_journal_start
                                                   start_this_handle
                                                     BUG_ON(journal->j_flags &
                                                            JBD2_UNMOUNT)

Hence, make sure we only defer the update of ext4 sb if the sb is still
active.  Otherwise, just fallback to an un-journaled commit.

The important thing to note here is that we must only defer sb update if
we have not yet flushed the s_sb_update_work queue in umount path else
this race can be hit (point 1 below). Since we don't have a direct way
to check for that we use SB_ACTIVE instead. The SB_ACTIVE check is a bit
subtle so adding some notes below for future reference:

1. Ideally we would want to have a something like (flags & JBD2_UNMOUNT
== 0) however this is not correct since we could end up scheduling work
after it has been flushed:

 ext4_put_super
  flush_work(&sbi->s_sb_upd_work)

                           **kjournald2**
                           jbd2_journal_commit_transaction
                           ...
                           ext4_inode_error
                             /* JBD2_UNMOUNT not set */
                             schedule_work(s_sb_upd_work)

   jbd2_journal_destroy
    journal->j_flags |= JBD2_UNMOUNT;

                                      **workqueue**
                                      update_super_work
                                       jbd2_journal_start
                                        start_this_handle
                                          BUG_ON(JBD2_UNMOUNT)

Something like the above doesn't happen with SB_ACTIVE check because we
are sure that the workqueue would be flushed at a later point if we are
in the umount path.

2. We don't need a similar check in ext4_grp_locked_error since it is
only called from mballoc and AFAICT it would be always valid to schedule
work here.

Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
Suggested-by: Ritesh Harjani <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a963ffda692a..b7341e9acf62 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		 * constraints, it may not be safe to do it right here so we
 		 * defer superblock flushing to a workqueue.
 		 */
-		if (continue_fs && journal)
+		if (continue_fs && journal && (sb->s_flags & SB_ACTIVE))
 			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 		else
 			ext4_commit_super(sb);
-- 
2.48.1


