Return-Path: <linux-ext4+bounces-8189-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B03AC2701
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 18:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B7544E21
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CA296FAB;
	Fri, 23 May 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYGLrF1G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA492951CE
	for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015968; cv=none; b=jMUl0SfESubYxkWP3CXQ1h+bmDOGh345fbyPp6q0k/1x845crC39kxKj0VYZg9JzMo5crnXSGG0zmjzDDeyT1vGNuteMtusfTsZN1WzXvqpOIL8L1K/LeV65mWrRXZD75xwOoVOeOVBhLRdaBx7GnZ6seECZJ7IixjdRes6kUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015968; c=relaxed/simple;
	bh=hkQms7jC8qsyM7whptL2cnK6dHNOzoYfonOqvVTk3Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jLgugQid1M0D/XsOA040E1ZUbecld+dhcYMlfDA7sKGRttgeYQIKxcGl0fj/34skt9XHCEf2MlDx7W99mtLIxbf/HcNLbZQYw/MFmAoK9ZxAvTOVktuSSTWUtAUvx48urYD1Df8fspS7zPbbTUeMMu8dAVRXrsjrkDL7fLdsuiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xYGLrF1G; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso116935845e9.2
        for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748015965; x=1748620765; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrPH5WuAZuxNsU+xkS/5s3P/VI9R9sD7jSQbzlLD0Rg=;
        b=xYGLrF1GzVTCCAXDNW4ad3mHf0zGSx+R2SEqOMFiaokidJuJkz1UAF+Dg2HYYA/NjC
         zWTfSneIJCBlkeC0RPeR68LCnd3MHTFXJ8EGkJzr0cRuPOQWKmwVD697mF4Oo8oK1p+u
         H0C8c67BtH+QbAOo+9Bko53iJhLm14S67Cis0IxDiNs15FbLuDp5W45gLOjyBhMABPHS
         ompRrxn2x00iQU3GjZODUs5q29e1aFW6WjnMy3QWCiQ2/dTn4Dixvq3hmNBpAuvygSf1
         1+5gsEj2YAJ6dvC2LFDFFYkp0lL5EAdZoOvP6VqyiG9NtFZNnZQuZei9mJKezsDhjiRZ
         9THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748015965; x=1748620765;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrPH5WuAZuxNsU+xkS/5s3P/VI9R9sD7jSQbzlLD0Rg=;
        b=hKmd4awPRsN/u318mtEC1XxLPUifbQbRIeVImCOWSAmAlSm3plQMaNZXdrK9A7kSYT
         nnnVUopt3TWZVHng/1OuNU1gKQwxwT6BwFnm1RhCdl2ZeJEKR7Nz9/kmXoP21dttTYcE
         hOxrkAWxecyrMaibo0Jvg45+3y+gabxiRdfWd68Djep7TQUopdSOw7HFtrzKRbd//nIn
         foynWpPPZtAz2hoaWFFAgp27sc2SppugjAC6/Swm3fz3OLk1ywvIzJHZjWVd9k1jYZGj
         7SRjkZut2/WMWpabmLd7IQVaUb6jiANKyzmwaXGqo0FrdKb2Ep60A3h6KGmCl0z27LSN
         PRZg==
X-Gm-Message-State: AOJu0Yza1reIzvHeRU4a3cBjQHLvxOQM4KQdPMxIncLi7F9bUaRAWtog
	PLpBoYv8Rei7+Eck098qcToCiUJLU35DvqES6rgllDgHWhckILZBQ+HHF/lIzbI5nI0OzjSDNEN
	DnsLg
X-Gm-Gg: ASbGnctUKYg53JtRJaJByZM7l8WqoQQcS7DE6Spe6lWjhDDOiWkkY9htIm7vu96OiXh
	tcj4xE9RmwixEdVnPa8yPipppoCDdpvO/pmKK6nEboUHl9dFkG3cnEqFexFzT7GEk+wFFmk2FLS
	zePtrX6lG0Bl9tXM9ObElzR1EnsOES7ll/cPqzZ6mpsvn854rwTu8jFolQ1vm40I8jELmtbyOdk
	dViZtIlrSueqDIZHbLv3xAz7I0gyEM7UAFtR/iQbcW3KtEAXldNtXyP0mll80EQxhE9IQ2Zgtiq
	BXRW78L9EDfdbcLM/SabgLGODBBhzYI/cI3/8JISG6pno/ViVg5WFG9b
X-Google-Smtp-Source: AGHT+IEKA6aw+eJQiaSnquiTjT8FIrjTfUgtyu7uLuSAhjGtcf9X+lK1A1bCvxmZAJsVjuluWKBJCA==
X-Received: by 2002:a05:600c:3d12:b0:43d:47b7:b32d with SMTP id 5b1f17b1804b1-44b6e66e02bmr30465655e9.25.1748015964654;
        Fri, 23 May 2025 08:59:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca8894csm27030258f8f.76.2025.05.23.08.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:59:24 -0700 (PDT)
Date: Fri, 23 May 2025 18:59:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org
Subject: [bug report] ext4: hold s_fc_lock while during fast commit
Message-ID: <aDCbWc9dEzAaQX1J@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Harshad Shirwadkar,

Commit 6593714d67ba ("ext4: hold s_fc_lock while during fast commit")
from May 8, 2025 (linux-next), leads to the following Smatch static
checker warning:

	fs/ext4/fast_commit.c:1159 ext4_fc_perform_commit()
	warn: double unlock '&sbi->s_fc_lock' (orig line 1109)

fs/ext4/fast_commit.c
    1039 static int ext4_fc_perform_commit(journal_t *journal)
    1040 {
    1041         struct super_block *sb = journal->j_private;
    1042         struct ext4_sb_info *sbi = EXT4_SB(sb);
    1043         struct ext4_inode_info *iter;
    1044         struct ext4_fc_head head;
    1045         struct inode *inode;
    1046         struct blk_plug plug;
    1047         int ret = 0;
    1048         u32 crc = 0;
    1049 
    1050         /*
    1051          * Step 1: Mark all inodes on s_fc_q[MAIN] with
    1052          * EXT4_STATE_FC_FLUSHING_DATA. This prevents these inodes from being
    1053          * freed until the data flush is over.
    1054          */
    1055         mutex_lock(&sbi->s_fc_lock);
    1056         list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
    1057                 ext4_set_inode_state(&iter->vfs_inode,
    1058                                      EXT4_STATE_FC_FLUSHING_DATA);
    1059         }
    1060         mutex_unlock(&sbi->s_fc_lock);
    1061 
    1062         /* Step 2: Flush data for all the eligible inodes. */
    1063         ret = ext4_fc_flush_data(journal);
    1064 
    1065         /*
    1066          * Step 3: Clear EXT4_STATE_FC_FLUSHING_DATA flag, before returning
    1067          * any error from step 2. This ensures that waiters waiting on
    1068          * EXT4_STATE_FC_FLUSHING_DATA can resume.
    1069          */
    1070         mutex_lock(&sbi->s_fc_lock);
    1071         list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
    1072                 ext4_clear_inode_state(&iter->vfs_inode,
    1073                                        EXT4_STATE_FC_FLUSHING_DATA);
    1074 #if (BITS_PER_LONG < 64)
    1075                 wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_FLUSHING_DATA);
    1076 #else
    1077                 wake_up_bit(&iter->i_flags, EXT4_STATE_FC_FLUSHING_DATA);
    1078 #endif
    1079         }
    1080 
    1081         /*
    1082          * Make sure clearing of EXT4_STATE_FC_FLUSHING_DATA is visible before
    1083          * the waiter checks the bit. Pairs with implicit barrier in
    1084          * prepare_to_wait() in ext4_fc_del().
    1085          */
    1086         smp_mb();
    1087         mutex_unlock(&sbi->s_fc_lock);
    1088 
    1089         /*
    1090          * If we encountered error in Step 2, return it now after clearing
    1091          * EXT4_STATE_FC_FLUSHING_DATA bit.
    1092          */
    1093         if (ret)
    1094                 return ret;
    1095 
    1096 
    1097         /* Step 4: Mark all inodes as being committed. */
    1098         jbd2_journal_lock_updates(journal);
    1099         /*
    1100          * The journal is now locked. No more handles can start and all the
    1101          * previous handles are now drained. We now mark the inodes on the
    1102          * commit queue as being committed.
    1103          */
    1104         mutex_lock(&sbi->s_fc_lock);
    1105         list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
    1106                 ext4_set_inode_state(&iter->vfs_inode,
    1107                                      EXT4_STATE_FC_COMMITTING);
    1108         }
    1109         mutex_unlock(&sbi->s_fc_lock);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    1110         jbd2_journal_unlock_updates(journal);
    1111 
    1112         /*
    1113          * Step 5: If file system device is different from journal device,
    1114          * issue a cache flush before we start writing fast commit blocks.
    1115          */
    1116         if (journal->j_fs_dev != journal->j_dev)
    1117                 blkdev_issue_flush(journal->j_fs_dev);
    1118 
    1119         blk_start_plug(&plug);
    1120         /* Step 6: Write fast commit blocks to disk. */
    1121         if (sbi->s_fc_bytes == 0) {
    1122                 /*
    1123                  * Step 6.1: Add a head tag only if this is the first fast
    1124                  * commit in this TID.
    1125                  */
    1126                 head.fc_features = cpu_to_le32(EXT4_FC_SUPPORTED_FEATURES);
    1127                 head.fc_tid = cpu_to_le32(
    1128                         sbi->s_journal->j_running_transaction->t_tid);
    1129                 if (!ext4_fc_add_tlv(sb, EXT4_FC_TAG_HEAD, sizeof(head),
    1130                         (u8 *)&head, &crc)) {
    1131                         ret = -ENOSPC;
    1132                         goto out;
                                 ^^^^^^^^^
We dropped the lock already.

    1133                 }
    1134         }
    1135 
    1136         /* Step 6.2: Now write all the dentry updates. */
    1137         mutex_lock(&sbi->s_fc_lock);
    1138         ret = ext4_fc_commit_dentry_updates(journal, &crc);
    1139         if (ret)
    1140                 goto out;
    1141 
    1142         /* Step 6.3: Now write all the changed inodes to disk. */
    1143         list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
    1144                 inode = &iter->vfs_inode;
    1145                 if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
    1146                         continue;
    1147 
    1148                 ret = ext4_fc_write_inode_data(inode, &crc);
    1149                 if (ret)
    1150                         goto out;
    1151                 ret = ext4_fc_write_inode(inode, &crc);
    1152                 if (ret)
    1153                         goto out;
    1154         }
    1155         /* Step 6.4: Finally write tail tag to conclude this fast commit. */
    1156         ret = ext4_fc_write_tail(sb, crc);
    1157 
    1158 out:
--> 1159         mutex_unlock(&sbi->s_fc_lock);

Double unlock.

    1160         blk_finish_plug(&plug);
    1161         return ret;
    1162 }

regards,
dan carpenter

