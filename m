Return-Path: <linux-ext4+bounces-2639-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEBF8CD5FC
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 16:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423BD1C20627
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C0914A4DC;
	Thu, 23 May 2024 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMwVcycT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D712B16E
	for <linux-ext4@vger.kernel.org>; Thu, 23 May 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475225; cv=none; b=D+jQW37WSU2Ffs41Kee1JWGPuOG1OdxTfP//0vhOQZCJGEnSVdY+wZfCA7PqdXRC3R2NeagZfP1d1obAwY+w6O5HCGNRpqh1YKlYC1FUxZ2ijnrH3gnagPODKih2dmhMdsYHKuZ5ejbT5vn546GjT5UctpAtNAt0KbrLLwBWbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475225; c=relaxed/simple;
	bh=/EhI5SV+eLkKHn6JuRJDB8qmUsH9QFiZWAcZwM5kl8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dVswJF7jz4zGacMs9YkGPPIb99JKnC0LZKAkZJUDDr6uSFxSI3FMwtwt7ntQDkcZG3EcK6Ggii302wNRqeS5bgClK9l3lGwhjPHfQNo6VWDueYZz7/Idq8DxTau4Pb7jJzm9O6sPvtfgRQQysGZOsclrlNKMS6zTUGw7KsXpKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMwVcycT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso54640325e9.1
        for <linux-ext4@vger.kernel.org>; Thu, 23 May 2024 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716475221; x=1717080021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntcN9UG8LCLRsIiP82LMaVuIkwbqeFlgR40LbwJ887I=;
        b=WMwVcycTiO5gFd7CumrvH06AVEtavFIA6hqw9eS+lId0NMiPVwBhfEsbEEE/8w+bpR
         SHcUc0GwB1PETgPE1/OWhJz6mNxrP+GBm7ymUqr1hCPW1QxH3kMV1BnaL26m8JG+v8Aa
         wcYWzav+2ufkZ2TfSgYxW68Kfc1vOYOrdP+YBozxWbJs+7ciktyAnwf9oVjy+JLeEdo1
         egMK6JhlCPNbWO6yllGhnA3kdzPznGvoWjDViQh/Y9V+TPwaQ6WFgp1DG3vhyCChUyDI
         yU9cgzc4gbJCAZ9F8KDO1XmAo60JUkZlvI/fzjY5YRqBGagQU27USzm7uJTuxViVJ2pB
         7NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475221; x=1717080021;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntcN9UG8LCLRsIiP82LMaVuIkwbqeFlgR40LbwJ887I=;
        b=FP79TQm4iAjn4RUDZkGocj20OpbzmI44jcsujQ4t9DSayMoxCq3WT3StiMXCWzDZe8
         jUzY3NkkOjgM0GVBe4vSYZhd0jzlbGwXa8AzULq76ew7bBvEz7yMMQynK9X7J3lgaJfw
         BfIy4L2SBmYIbNNEYow2Hn+wSWUFKQkZ9idOlMhVPQDc8rffBzlZp59u8ebM3xQKZT2u
         qTSCIIaWetbb0bjnS5QaE13Dhj1P0c8sKxdBimPbO//BlWLm5OfJyrdTwFd5+lk1war1
         rVrok63o9zE/RWAKaEnSyELXwY/z5cpAOlkTFZac3h2nrul8oakSTUKbTOuoLu+JginQ
         4zDg==
X-Forwarded-Encrypted: i=1; AJvYcCVxv7u87w3FCvW4PK1ZG9U03Mu5XtYfr8GDP9Sy0//volhHTKkjKE8pQpxu4/uI62TQppQ4B/QgpGJ630NzjEsc0lgsh4oJ9wp+GA==
X-Gm-Message-State: AOJu0Yy00qaBoDwZ+riXmfhyOT9qnASr8vlk25jXEwcRoR5SvErUb6a2
	sWTYCCvF01U9uEfwSdJasVvbexlYIbAMieRHOshP92tdhzYfqphePsNkNdfMiEc=
X-Google-Smtp-Source: AGHT+IElJxY9dqC1eLWDsF5oZGyvKHUVkCA4vyOJY3Vj6h3bD/viIGXHTHOqCpe+gJLvs8lAkOFo3w==
X-Received: by 2002:a7b:cb44:0:b0:41a:1d3a:3fc1 with SMTP id 5b1f17b1804b1-420fd2d8443mr40254095e9.3.1716475221044;
        Thu, 23 May 2024 07:40:21 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fb2205sm27214235e9.42.2024.05.23.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:40:19 -0700 (PDT)
Date: Thu, 23 May 2024 17:40:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, tytso@mit.edu,
	saukad@google.com, harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 09/10] ext4: temporarily elevate commit thread priority
Message-ID: <00111762-dd9a-4274-8893-770d1f92d1ff@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520055153.136091-10-harshadshirwadkar@gmail.com>

Hi Harshad,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Harshad-Shirwadkar/ext4-convert-i_fc_lock-to-spinlock/20240520-135501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20240520055153.136091-10-harshadshirwadkar%40gmail.com
patch subject: [PATCH 09/10] ext4: temporarily elevate commit thread priority
config: i386-randconfig-141-20240520 (https://download.01.org/0day-ci/archive/20240521/202405210026.5LpHV4Sn-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405210026.5LpHV4Sn-lkp@intel.com/

smatch warnings:
fs/ext4/fast_commit.c:1280 ext4_fc_commit() error: uninitialized symbol 'old_ioprio'.

vim +/old_ioprio +1280 fs/ext4/fast_commit.c

aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1200  int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1201  {
c30365b90ab26f Yu Zhe             2022-04-01  1202  	struct super_block *sb = journal->j_private;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1203  	struct ext4_sb_info *sbi = EXT4_SB(sb);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1204  	int nblks = 0, ret, bsize = journal->j_blocksize;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1205  	int subtid = atomic_read(&sbi->s_fc_subtid);
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1206  	int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1207  	ktime_t start_time, commit_time;
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1208  	int old_ioprio, journal_ioprio;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1209  
7f142440847480 Ritesh Harjani     2022-03-12  1210  	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
7f142440847480 Ritesh Harjani     2022-03-12  1211  		return jbd2_complete_transaction(journal, commit_tid);
7f142440847480 Ritesh Harjani     2022-03-12  1212  
5641ace54471cb Ritesh Harjani     2022-03-12  1213  	trace_ext4_fc_commit_start(sb, commit_tid);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1214  
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1215  	start_time = ktime_get();
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1216  
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1217  restart_fc:
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1218  	ret = jbd2_fc_begin_commit(journal, commit_tid);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1219  	if (ret == -EALREADY) {
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1220  		/* There was an ongoing commit, check if we need to restart */
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1221  		if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1222  			commit_tid > journal->j_commit_sequence)
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1223  			goto restart_fc;
d9bf099cb980d6 Ritesh Harjani     2022-03-12  1224  		ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0,
d9bf099cb980d6 Ritesh Harjani     2022-03-12  1225  				commit_tid);
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1226  		return 0;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1227  	} else if (ret) {
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1228  		/*
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1229  		 * Commit couldn't start. Just update stats and perform a
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1230  		 * full commit.
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1231  		 */
d9bf099cb980d6 Ritesh Harjani     2022-03-12  1232  		ext4_fc_update_stats(sb, EXT4_FC_STATUS_FAILED, 0, 0,
d9bf099cb980d6 Ritesh Harjani     2022-03-12  1233  				commit_tid);
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1234  		return jbd2_complete_transaction(journal, commit_tid);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1235  	}
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1236  
7bbbe241ec7ce0 Harshad Shirwadkar 2021-12-23  1237  	/*
7bbbe241ec7ce0 Harshad Shirwadkar 2021-12-23  1238  	 * After establishing journal barrier via jbd2_fc_begin_commit(), check
7bbbe241ec7ce0 Harshad Shirwadkar 2021-12-23  1239  	 * if we are fast commit ineligible.
7bbbe241ec7ce0 Harshad Shirwadkar 2021-12-23  1240  	 */
7bbbe241ec7ce0 Harshad Shirwadkar 2021-12-23  1241  	if (ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE)) {
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1242  		status = EXT4_FC_STATUS_INELIGIBLE;
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1243  		goto fallback;

old_ioprio not initialized.

7bbbe241ec7ce0 Harshad Shirwadkar 2021-12-23  1244  	}
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1245  
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1246  	/*
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1247  	 * Now that we know that this thread is going to do a fast commit,
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1248  	 * elevate the priority to match that of the journal thread.
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1249  	 */
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1250  	if (journal->j_task->io_context)
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1251  		journal_ioprio = sbi->s_journal->j_task->io_context->ioprio;
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1252  	else
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1253  		journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1254  	old_ioprio = get_current_ioprio();
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1255  	set_task_ioprio(current, journal_ioprio);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1256  	fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1257  	ret = ext4_fc_perform_commit(journal);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1258  	if (ret < 0) {
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1259  		status = EXT4_FC_STATUS_FAILED;
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1260  		goto fallback;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1261  	}
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1262  	nblks = (sbi->s_fc_bytes + bsize - 1) / bsize - fc_bufs_before;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1263  	ret = jbd2_fc_wait_bufs(journal, nblks);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1264  	if (ret < 0) {
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1265  		status = EXT4_FC_STATUS_FAILED;
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1266  		goto fallback;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1267  	}
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1268  	atomic_inc(&sbi->s_fc_subtid);
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1269  	ret = jbd2_fc_end_commit(journal);
c3b2c196d67585 Harshad Shirwadkar 2024-05-20  1270  	set_task_ioprio(current, old_ioprio);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1271  	/*
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1272  	 * weight the commit time higher than the average time so we
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1273  	 * don't react too strongly to vast changes in the commit time
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1274  	 */
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1275  	commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
d9bf099cb980d6 Ritesh Harjani     2022-03-12  1276  	ext4_fc_update_stats(sb, status, commit_time, nblks, commit_tid);
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1277  	return ret;
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1278  
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1279  fallback:
c3b2c196d67585 Harshad Shirwadkar 2024-05-20 @1280  	set_task_ioprio(current, old_ioprio);
                                                                                 ^^^^^^^^^^
Uninitialized

0915e464cb2746 Harshad Shirwadkar 2021-12-23  1281  	ret = jbd2_fc_end_commit_fallback(journal);
d9bf099cb980d6 Ritesh Harjani     2022-03-12  1282  	ext4_fc_update_stats(sb, status, 0, 0, commit_tid);
0915e464cb2746 Harshad Shirwadkar 2021-12-23  1283  	return ret;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  1284  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


