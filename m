Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F383D2882E6
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 08:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgJIGop (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 02:44:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:48770 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgJIGop (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Oct 2020 02:44:45 -0400
IronPort-SDR: j1EveUkQD1M9G5g/CRmyFSQrRsAY50gxbEfXpdEXqkDBUFPcXCjjlWQshkBs4yoNeEHRjHOEaB
 JRkRC+eQXylQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="162812322"
X-IronPort-AV: E=Sophos;i="5.77,354,1596524400"; 
   d="gz'50?scan'50,208,50";a="162812322"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 23:44:43 -0700
IronPort-SDR: ICMPyIgQiieTaV1MMdOFHbfB5CdpTAoEUfCjLWoz7FuFCUZeNmbFqn49XdGFpllWOtrssK4Chg
 h8rH83Gvb+Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,354,1596524400"; 
   d="gz'50?scan'50,208,50";a="344978564"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 08 Oct 2020 23:44:41 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQm8u-0000Gk-HA; Fri, 09 Oct 2020 06:44:40 +0000
Date:   Fri, 9 Oct 2020 14:43:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [ext4:dev 9/44] fs/ext4/fast_commit.c:1079:6: warning: variable
 'start_time' is used uninitialized whenever 'if' condition is true
Message-ID: <202010091437.T53myZsm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
head:   ab7b179af3f98772f2433ddc4ace6b7924a4e862
commit: 96df8fb629b26ce3b0b10c9b730965788786bb8c [9/44] ext4: main fast-commit commit path
config: x86_64-randconfig-a004-20201009 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 4cfc4025cc1433ca5ef1c526053fc9c4bfe64109)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?id=96df8fb629b26ce3b0b10c9b730965788786bb8c
        git remote add ext4 https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
        git fetch --no-tags ext4 dev
        git checkout 96df8fb629b26ce3b0b10c9b730965788786bb8c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/fast_commit.c:1079:6: warning: variable 'start_time' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ext4/fast_commit.c:1135:51: note: uninitialized use occurs here
           commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
                                                            ^~~~~~~~~~
   include/linux/ktime.h:47:39: note: expanded from macro 'ktime_sub'
   #define ktime_sub(lhs, rhs)     ((lhs) - (rhs))
                                             ^~~
   fs/ext4/fast_commit.c:1079:2: note: remove the 'if' if its condition is always false
           if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> fs/ext4/fast_commit.c:1079:6: warning: variable 'start_time' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ext4/fast_commit.c:1135:51: note: uninitialized use occurs here
           commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
                                                            ^~~~~~~~~~
   include/linux/ktime.h:47:39: note: expanded from macro 'ktime_sub'
   #define ktime_sub(lhs, rhs)     ((lhs) - (rhs))
                                             ^~~
   fs/ext4/fast_commit.c:1079:6: note: remove the '||' if its condition is always false
           if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ext4/fast_commit.c:1075:20: note: initialize the variable 'start_time' to silence this warning
           ktime_t start_time, commit_time;
                             ^
                              = 0
   2 warnings generated.

vim +1079 fs/ext4/fast_commit.c

  1061	
  1062	/*
  1063	 * The main commit entry point. Performs a fast commit for transaction
  1064	 * commit_tid if needed. If it's not possible to perform a fast commit
  1065	 * due to various reasons, we fall back to full commit. Returns 0
  1066	 * on success, error otherwise.
  1067	 */
  1068	int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
  1069	{
  1070		struct super_block *sb = (struct super_block *)(journal->j_private);
  1071		struct ext4_sb_info *sbi = EXT4_SB(sb);
  1072		int nblks = 0, ret, bsize = journal->j_blocksize;
  1073		int subtid = atomic_read(&sbi->s_fc_subtid);
  1074		int reason = EXT4_FC_REASON_OK, fc_bufs_before = 0;
  1075		ktime_t start_time, commit_time;
  1076	
  1077		trace_ext4_fc_commit_start(sb);
  1078	
> 1079		if (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
  1080			(ext4_fc_is_ineligible(sb))) {
  1081			reason = EXT4_FC_REASON_INELIGIBLE;
  1082			goto out;
  1083		}
  1084	
  1085		start_time = ktime_get();
  1086	restart_fc:
  1087		ret = jbd2_fc_start(journal, commit_tid);
  1088		if (ret == -EALREADY) {
  1089			/* There was an ongoing commit, check if we need to restart */
  1090			if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
  1091				commit_tid > journal->j_commit_sequence)
  1092				goto restart_fc;
  1093			reason = EXT4_FC_REASON_ALREADY_COMMITTED;
  1094			goto out;
  1095		} else if (ret) {
  1096			sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
  1097			reason = EXT4_FC_REASON_FC_START_FAILED;
  1098			goto out;
  1099		}
  1100	
  1101		fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
  1102		ret = ext4_fc_perform_commit(journal);
  1103		if (ret < 0) {
  1104			sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
  1105			reason = EXT4_FC_REASON_FC_FAILED;
  1106			goto out;
  1107		}
  1108		nblks = (sbi->s_fc_bytes + bsize - 1) / bsize - fc_bufs_before;
  1109		ret = jbd2_fc_wait_bufs(journal, nblks);
  1110		if (ret < 0) {
  1111			sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
  1112			reason = EXT4_FC_REASON_FC_FAILED;
  1113			goto out;
  1114		}
  1115		atomic_inc(&sbi->s_fc_subtid);
  1116		jbd2_fc_stop(journal);
  1117	out:
  1118		/* Has any ineligible update happened since we started? */
  1119		if (reason == EXT4_FC_REASON_OK && ext4_fc_is_ineligible(sb)) {
  1120			sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
  1121			reason = EXT4_FC_REASON_INELIGIBLE;
  1122		}
  1123	
  1124		spin_lock(&sbi->s_fc_lock);
  1125		if (reason != EXT4_FC_REASON_OK &&
  1126			reason != EXT4_FC_REASON_ALREADY_COMMITTED) {
  1127			sbi->s_fc_stats.fc_ineligible_commits++;
  1128		} else {
  1129			sbi->s_fc_stats.fc_num_commits++;
  1130			sbi->s_fc_stats.fc_numblks += nblks;
  1131		}
  1132		spin_unlock(&sbi->s_fc_lock);
  1133		nblks = (reason == EXT4_FC_REASON_OK) ? nblks : 0;
  1134		trace_ext4_fc_commit_stop(sb, nblks, reason);
> 1135		commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
  1136		/*
  1137		 * weight the commit time higher than the average time so we don't
  1138		 * react too strongly to vast changes in the commit time
  1139		 */
  1140		if (likely(sbi->s_fc_avg_commit_time))
  1141			sbi->s_fc_avg_commit_time = (commit_time +
  1142					sbi->s_fc_avg_commit_time * 3) / 4;
  1143		else
  1144			sbi->s_fc_avg_commit_time = commit_time;
  1145		jbd_debug(1,
  1146			"Fast commit ended with blks = %d, reason = %d, subtid - %d",
  1147			nblks, reason, subtid);
  1148		if (reason == EXT4_FC_REASON_FC_FAILED)
  1149			return jbd2_fc_stop_do_commit(journal, commit_tid);
  1150		if (reason == EXT4_FC_REASON_FC_START_FAILED ||
  1151			reason == EXT4_FC_REASON_INELIGIBLE)
  1152			return jbd2_complete_transaction(journal, commit_tid);
  1153		return 0;
  1154	}
  1155	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7AUc2qLy4jB3hD7Z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--7AUc2qLy4jB3hD7Z--
