Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A712BBB3
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 23:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfL0WwS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 17:52:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:20875 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfL0WwS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Dec 2019 17:52:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 14:52:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,364,1571727600"; 
   d="scan'208";a="243351232"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 14:52:16 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ikySu-000ElT-3D; Sat, 28 Dec 2019 06:52:16 +0800
Date:   Sat, 28 Dec 2019 06:51:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH v4 19/20] ext4: add fast commit replay path
Message-ID: <201912280641.QyyfUJRx%lkp@intel.com>
References: <20191224081324.95807-19-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224081324.95807-19-harshadshirwadkar@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Harshad,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/perf/core]
[cannot apply to ext4/dev linus/master v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Harshad-Shirwadkar/ext4-update-docs-for-fast-commit-feature/20191225-200339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ceb9e77324fa661b1001a0ae66f061b5fcb4e4e6
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   fs/ext4/ext4_jbd2.c:612:5: sparse: sparse: symbol '__ext4_fc_track_range' was not declared. Should it be static?
   fs/ext4/ext4_jbd2.c:826:6: sparse: sparse: symbol 'submit_fc_bh' was not declared. Should it be static?
>> fs/ext4/ext4_jbd2.c:1398:13: sparse: sparse: cast to restricted __le16
>> fs/ext4/ext4_jbd2.c:1403:18: sparse: sparse: incorrect type in assignment (different base types)
>> fs/ext4/ext4_jbd2.c:1403:18: sparse:    expected unsigned int [usertype] old_csum
>> fs/ext4/ext4_jbd2.c:1403:18: sparse:    got restricted __le32 [usertype] fc_csum
   fs/ext4/ext4_jbd2.c:1406:25: sparse: sparse: incorrect type in assignment (different base types)
>> fs/ext4/ext4_jbd2.c:1406:25: sparse:    expected restricted __le32 [usertype] fc_csum
>> fs/ext4/ext4_jbd2.c:1406:25: sparse:    got unsigned int [usertype] old_csum
   fs/ext4/ext4_jbd2.c:1608:5: sparse: sparse: symbol 'ext4_fc_perform_hard_commit' was not declared. Should it be static?
   fs/ext4/ext4_jbd2.c:501:12: sparse: sparse: context imbalance in '__ext4_dentry_update' - unexpected unlock
   fs/ext4/ext4_jbd2.c:924:20: sparse: sparse: context imbalance in 'wait_all_inode_data' - unexpected unlock

vim +1398 fs/ext4/ext4_jbd2.c

  1364	
  1365	static int ext4_journal_fc_replay_scan(journal_t *journal,
  1366					       struct buffer_head *bh, int off)
  1367	{
  1368		struct super_block *sb = journal->j_private;
  1369		struct ext4_sb_info *sbi = EXT4_SB(sb);
  1370		struct ext4_fc_replay_state *state;
  1371		struct ext4_fc_commit_hdr *fc_hdr;
  1372		__u32 csum, old_csum;
  1373		__u8 *start, *end;
  1374	
  1375		state = &sbi->s_fc_replay_state;
  1376		fc_hdr = (struct ext4_fc_commit_hdr *)
  1377			  ((__u8 *)bh->b_data + sizeof(journal_header_t));
  1378	
  1379		start = (u8 *)fc_hdr;
  1380		end = (__u8 *)bh->b_data + journal->j_blocksize;
  1381	
  1382		/* Check if we already concluded that this fast commit is not useful */
  1383		if (state->fc_replay_expected_off && state->fc_replay_error)
  1384			goto out_err;
  1385	
  1386		if (le32_to_cpu(fc_hdr->fc_magic) != EXT4_FC_MAGIC) {
  1387			state->fc_replay_error = -ENOENT;
  1388			goto out_err;
  1389		}
  1390	
  1391		if (off != state->fc_replay_expected_off) {
  1392			state->fc_replay_error = -EFSCORRUPTED;
  1393			goto out_err;
  1394		}
  1395	
  1396		state->fc_replay_expected_off++;
  1397	
> 1398		if (le16_to_cpu(fc_hdr->fc_features)) {
  1399			state->fc_replay_error = -EOPNOTSUPP;
  1400			goto out_err;
  1401		}
  1402	
> 1403		old_csum = fc_hdr->fc_csum;
  1404		fc_hdr->fc_csum = 0;
  1405		csum = ext4_chksum(sbi, 0, start, end - start);
> 1406		fc_hdr->fc_csum = old_csum;
  1407	
  1408		if (csum != le32_to_cpu(fc_hdr->fc_csum)) {
  1409			state->fc_replay_error = -EFSBADCRC;
  1410			goto out_err;
  1411		}
  1412	
  1413		trace_ext4_journal_fc_replay_scan(sb, state->fc_replay_error, off);
  1414		return 0;
  1415	
  1416	out_err:
  1417		trace_ext4_journal_fc_replay_scan(sb, state->fc_replay_error, off);
  1418		return state->fc_replay_error;
  1419	}
  1420	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
