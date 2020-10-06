Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF49284D78
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 16:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgJFOSz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Oct 2020 10:18:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:26797 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgJFOSz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 6 Oct 2020 10:18:55 -0400
IronPort-SDR: zILase6RRnQHzSWDJNj+OoY3SjJhCLjKe8SukEHrwcQL3HIEr0dGCArQ0cZpZ85rvrQEPtVECz
 2vZRdQO3+IcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="164648127"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="gz'50?scan'50,208,50";a="164648127"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 07:15:02 -0700
IronPort-SDR: OCTQwd6kXd5GWXVBXiaUVf1ywDBBQRDdimWjjkpxdopyP7s3kQtJQ4lKzPg2gqJ/APAqc/W+4f
 S0zRLqsyPM4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="gz'50?scan'50,208,50";a="315661432"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Oct 2020 07:14:57 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPnk0-0001Db-SL; Tue, 06 Oct 2020 14:14:56 +0000
Date:   Tue, 6 Oct 2020 22:14:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@hikvision.com>,
        changfengnan <fengnanchang@foxmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] jbd2: avoid transaction reuse after reformatting
Message-ID: <202010062254.4DpTOK62-lkp@intel.com>
References: <20201006103154.7130-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20201006103154.7130-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ext4/dev]
[also build test WARNING on linus/master v5.9-rc8 next-20201002]
[cannot apply to tytso-fscrypt/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jan-Kara/jbd2-avoid-transaction-reuse-after-reformatting/20201006-183337
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: s390-randconfig-s032-20201005 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-201-g24bdaac6-dirty
        # https://github.com/0day-ci/linux/commit/ca606dc0beaec78e8b2b6ec2f112b2192534d9e2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jan-Kara/jbd2-avoid-transaction-reuse-after-reformatting/20201006-183337
        git checkout ca606dc0beaec78e8b2b6ec2f112b2192534d9e2
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

	echo
	echo "sparse warnings: (new ones prefixed by >>)"
	echo
>> fs/jbd2/recovery.c:713:41: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be64 [usertype] commit_time @@     got unsigned long long [usertype] @@
>> fs/jbd2/recovery.c:713:41: sparse:     expected restricted __be64 [usertype] commit_time
>> fs/jbd2/recovery.c:713:41: sparse:     got unsigned long long [usertype]
>> fs/jbd2/recovery.c:730:45: sparse: sparse: restricted __be64 degrades to integer
   fs/jbd2/recovery.c:730:60: sparse: sparse: restricted __be64 degrades to integer

vim +713 fs/jbd2/recovery.c

   415	
   416	static int do_one_pass(journal_t *journal,
   417				struct recovery_info *info, enum passtype pass)
   418	{
   419		unsigned int		first_commit_ID, next_commit_ID;
   420		unsigned long		next_log_block;
   421		int			err, success = 0;
   422		journal_superblock_t *	sb;
   423		journal_header_t *	tmp;
   424		struct buffer_head *	bh;
   425		unsigned int		sequence;
   426		int			blocktype;
   427		int			tag_bytes = journal_tag_bytes(journal);
   428		__u32			crc32_sum = ~0; /* Transactional Checksums */
   429		int			descr_csum_size = 0;
   430		int			block_error = 0;
   431		bool			need_check_commit_time = false;
   432		__be64			last_trans_commit_time = 0;
   433	
   434		/*
   435		 * First thing is to establish what we expect to find in the log
   436		 * (in terms of transaction IDs), and where (in terms of log
   437		 * block offsets): query the superblock.
   438		 */
   439	
   440		sb = journal->j_superblock;
   441		next_commit_ID = be32_to_cpu(sb->s_sequence);
   442		next_log_block = be32_to_cpu(sb->s_start);
   443	
   444		first_commit_ID = next_commit_ID;
   445		if (pass == PASS_SCAN)
   446			info->start_transaction = first_commit_ID;
   447	
   448		jbd_debug(1, "Starting recovery pass %d\n", pass);
   449	
   450		/*
   451		 * Now we walk through the log, transaction by transaction,
   452		 * making sure that each transaction has a commit block in the
   453		 * expected place.  Each complete transaction gets replayed back
   454		 * into the main filesystem.
   455		 */
   456	
   457		while (1) {
   458			int			flags;
   459			char *			tagp;
   460			journal_block_tag_t *	tag;
   461			struct buffer_head *	obh;
   462			struct buffer_head *	nbh;
   463	
   464			cond_resched();
   465	
   466			/* If we already know where to stop the log traversal,
   467			 * check right now that we haven't gone past the end of
   468			 * the log. */
   469	
   470			if (pass != PASS_SCAN)
   471				if (tid_geq(next_commit_ID, info->end_transaction))
   472					break;
   473	
   474			jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
   475				  next_commit_ID, next_log_block, journal->j_last);
   476	
   477			/* Skip over each chunk of the transaction looking
   478			 * either the next descriptor block or the final commit
   479			 * record. */
   480	
   481			jbd_debug(3, "JBD2: checking block %ld\n", next_log_block);
   482			err = jread(&bh, journal, next_log_block);
   483			if (err)
   484				goto failed;
   485	
   486			next_log_block++;
   487			wrap(journal, next_log_block);
   488	
   489			/* What kind of buffer is it?
   490			 *
   491			 * If it is a descriptor block, check that it has the
   492			 * expected sequence number.  Otherwise, we're all done
   493			 * here. */
   494	
   495			tmp = (journal_header_t *)bh->b_data;
   496	
   497			if (tmp->h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER)) {
   498				brelse(bh);
   499				break;
   500			}
   501	
   502			blocktype = be32_to_cpu(tmp->h_blocktype);
   503			sequence = be32_to_cpu(tmp->h_sequence);
   504			jbd_debug(3, "Found magic %d, sequence %d\n",
   505				  blocktype, sequence);
   506	
   507			if (sequence != next_commit_ID) {
   508				brelse(bh);
   509				break;
   510			}
   511	
   512			/* OK, we have a valid descriptor block which matches
   513			 * all of the sequence number checks.  What are we going
   514			 * to do with it?  That depends on the pass... */
   515	
   516			switch(blocktype) {
   517			case JBD2_DESCRIPTOR_BLOCK:
   518				/* Verify checksum first */
   519				if (jbd2_journal_has_csum_v2or3(journal))
   520					descr_csum_size =
   521						sizeof(struct jbd2_journal_block_tail);
   522				if (descr_csum_size > 0 &&
   523				    !jbd2_descriptor_block_csum_verify(journal,
   524								       bh->b_data)) {
   525					/*
   526					 * PASS_SCAN can see stale blocks due to lazy
   527	 				 * journal init. Don't error out on those yet.
   528					 */
   529					if (pass != PASS_SCAN) {
   530						pr_err("JBD2: Invalid checksum "
   531						       "recovering block %lu in log\n",
   532						       next_log_block);
   533						err = -EFSBADCRC;
   534						brelse(bh);
   535						goto failed;
   536					}
   537					need_check_commit_time = true;
   538					jbd_debug(1,
   539						"invalid descriptor block found in %lu\n",
   540						next_log_block);
   541				}
   542	
   543				/* If it is a valid descriptor block, replay it
   544				 * in pass REPLAY; if journal_checksums enabled, then
   545				 * calculate checksums in PASS_SCAN, otherwise,
   546				 * just skip over the blocks it describes. */
   547				if (pass != PASS_REPLAY) {
   548					if (pass == PASS_SCAN &&
   549					    jbd2_has_feature_checksum(journal) &&
   550					    !need_check_commit_time &&
   551					    !info->end_transaction) {
   552						if (calc_chksums(journal, bh,
   553								&next_log_block,
   554								&crc32_sum)) {
   555							put_bh(bh);
   556							break;
   557						}
   558						put_bh(bh);
   559						continue;
   560					}
   561					next_log_block += count_tags(journal, bh);
   562					wrap(journal, next_log_block);
   563					put_bh(bh);
   564					continue;
   565				}
   566	
   567				/* A descriptor block: we can now write all of
   568				 * the data blocks.  Yay, useful work is finally
   569				 * getting done here! */
   570	
   571				tagp = &bh->b_data[sizeof(journal_header_t)];
   572				while ((tagp - bh->b_data + tag_bytes)
   573				       <= journal->j_blocksize - descr_csum_size) {
   574					unsigned long io_block;
   575	
   576					tag = (journal_block_tag_t *) tagp;
   577					flags = be16_to_cpu(tag->t_flags);
   578	
   579					io_block = next_log_block++;
   580					wrap(journal, next_log_block);
   581					err = jread(&obh, journal, io_block);
   582					if (err) {
   583						/* Recover what we can, but
   584						 * report failure at the end. */
   585						success = err;
   586						printk(KERN_ERR
   587							"JBD2: IO error %d recovering "
   588							"block %ld in log\n",
   589							err, io_block);
   590					} else {
   591						unsigned long long blocknr;
   592	
   593						J_ASSERT(obh != NULL);
   594						blocknr = read_tag_block(journal,
   595									 tag);
   596	
   597						/* If the block has been
   598						 * revoked, then we're all done
   599						 * here. */
   600						if (jbd2_journal_test_revoke
   601						    (journal, blocknr,
   602						     next_commit_ID)) {
   603							brelse(obh);
   604							++info->nr_revoke_hits;
   605							goto skip_write;
   606						}
   607	
   608						/* Look for block corruption */
   609						if (!jbd2_block_tag_csum_verify(
   610							journal, tag, obh->b_data,
   611							be32_to_cpu(tmp->h_sequence))) {
   612							brelse(obh);
   613							success = -EFSBADCRC;
   614							printk(KERN_ERR "JBD2: Invalid "
   615							       "checksum recovering "
   616							       "data block %llu in "
   617							       "log\n", blocknr);
   618							block_error = 1;
   619							goto skip_write;
   620						}
   621	
   622						/* Find a buffer for the new
   623						 * data being restored */
   624						nbh = __getblk(journal->j_fs_dev,
   625								blocknr,
   626								journal->j_blocksize);
   627						if (nbh == NULL) {
   628							printk(KERN_ERR
   629							       "JBD2: Out of memory "
   630							       "during recovery.\n");
   631							err = -ENOMEM;
   632							brelse(bh);
   633							brelse(obh);
   634							goto failed;
   635						}
   636	
   637						lock_buffer(nbh);
   638						memcpy(nbh->b_data, obh->b_data,
   639								journal->j_blocksize);
   640						if (flags & JBD2_FLAG_ESCAPE) {
   641							*((__be32 *)nbh->b_data) =
   642							cpu_to_be32(JBD2_MAGIC_NUMBER);
   643						}
   644	
   645						BUFFER_TRACE(nbh, "marking dirty");
   646						set_buffer_uptodate(nbh);
   647						mark_buffer_dirty(nbh);
   648						BUFFER_TRACE(nbh, "marking uptodate");
   649						++info->nr_replays;
   650						/* ll_rw_block(WRITE, 1, &nbh); */
   651						unlock_buffer(nbh);
   652						brelse(obh);
   653						brelse(nbh);
   654					}
   655	
   656				skip_write:
   657					tagp += tag_bytes;
   658					if (!(flags & JBD2_FLAG_SAME_UUID))
   659						tagp += 16;
   660	
   661					if (flags & JBD2_FLAG_LAST_TAG)
   662						break;
   663				}
   664	
   665				brelse(bh);
   666				continue;
   667	
   668			case JBD2_COMMIT_BLOCK:
   669				/*     How to differentiate between interrupted commit
   670				 *               and journal corruption ?
   671				 *
   672				 * {nth transaction}
   673				 *        Checksum Verification Failed
   674				 *			 |
   675				 *		 ____________________
   676				 *		|		     |
   677				 * 	async_commit             sync_commit
   678				 *     		|                    |
   679				 *		| GO TO NEXT    "Journal Corruption"
   680				 *		| TRANSACTION
   681				 *		|
   682				 * {(n+1)th transanction}
   683				 *		|
   684				 * 	 _______|______________
   685				 * 	|	 	      |
   686				 * Commit block found	Commit block not found
   687				 *      |		      |
   688				 * "Journal Corruption"       |
   689				 *		 _____________|_________
   690				 *     		|	           	|
   691				 *	nth trans corrupt	OR   nth trans
   692				 *	and (n+1)th interrupted     interrupted
   693				 *	before commit block
   694				 *      could reach the disk.
   695				 *	(Cannot find the difference in above
   696				 *	 mentioned conditions. Hence assume
   697				 *	 "Interrupted Commit".)
   698				 */
   699	
   700				/*
   701				 * Found an expected commit block: if checksums
   702				 * are present, verify them in PASS_SCAN; else not
   703				 * much to do other than move on to the next sequence
   704				 * number.
   705				 */
   706				if (pass == PASS_SCAN &&
   707				    jbd2_has_feature_checksum(journal)) {
   708					struct commit_header *cbh =
   709						(struct commit_header *)bh->b_data;
   710					unsigned found_chksum =
   711						be32_to_cpu(cbh->h_chksum[0]);
   712					__be64 commit_time =
 > 713						be64_to_cpu(cbh->h_commit_sec);
   714	
   715					if (info->end_transaction) {
   716						journal->j_failed_commit =
   717							info->end_transaction;
   718						brelse(bh);
   719						break;
   720					}
   721	
   722					/*
   723					 * If need_check_commit_time is set, it means
   724					 * csum verify failed before, if commit_time is
   725					 * increasing, it's same journal, otherwise it
   726					 * is stale journal block, just end this
   727					 * recovery.
   728					 */
   729					if (need_check_commit_time) {
 > 730						if (commit_time >= last_trans_commit_time) {
   731							pr_err("JBD2: Invalid checksum found in transaction %u\n",
   732							       next_commit_ID);
   733							err = -EFSBADCRC;
   734							brelse(bh);
   735							goto failed;
   736						}
   737						/*
   738						 * It likely does not belong to same
   739						 * journal, just end this recovery with
   740						 * success.
   741						 */
   742						jbd_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
   743							  next_commit_ID);
   744						err = 0;
   745						brelse(bh);
   746						goto done;
   747					}
   748	
   749					/* Neither checksum match nor unused? */
   750					if (!((crc32_sum == found_chksum &&
   751					       cbh->h_chksum_type ==
   752							JBD2_CRC32_CHKSUM &&
   753					       cbh->h_chksum_size ==
   754							JBD2_CRC32_CHKSUM_SIZE) ||
   755					      (cbh->h_chksum_type == 0 &&
   756					       cbh->h_chksum_size == 0 &&
   757					       found_chksum == 0)))
   758						goto chksum_error;
   759	
   760					crc32_sum = ~0;
   761					last_trans_commit_time = commit_time;
   762				}
   763				if (pass == PASS_SCAN &&
   764				    !jbd2_commit_block_csum_verify(journal,
   765								   bh->b_data)) {
   766				chksum_error:
   767					info->end_transaction = next_commit_ID;
   768	
   769					if (!jbd2_has_feature_async_commit(journal)) {
   770						journal->j_failed_commit =
   771							next_commit_ID;
   772						brelse(bh);
   773						break;
   774					}
   775				}
   776				brelse(bh);
   777				next_commit_ID++;
   778				continue;
   779	
   780			case JBD2_REVOKE_BLOCK:
   781				/*
   782				 * Check revoke block crc in pass_scan, if csum verify
   783				 * failed, check commit block time later.
   784				 */
   785				if (pass == PASS_SCAN &&
   786				    !jbd2_descriptor_block_csum_verify(journal,
   787								       bh->b_data)) {
   788					jbd_debug(1, "JBD2: invalid revoke block found in %lu\n",
   789						  next_log_block);
   790					need_check_commit_time = true;
   791				}
   792				/* If we aren't in the REVOKE pass, then we can
   793				 * just skip over this block. */
   794				if (pass != PASS_REVOKE) {
   795					brelse(bh);
   796					continue;
   797				}
   798	
   799				err = scan_revoke_records(journal, bh,
   800							  next_commit_ID, info);
   801				brelse(bh);
   802				if (err)
   803					goto failed;
   804				continue;
   805	
   806			default:
   807				jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
   808					  blocktype);
   809				brelse(bh);
   810				goto done;
   811			}
   812		}
   813	
   814	 done:
   815		/*
   816		 * We broke out of the log scan loop: either we came to the
   817		 * known end of the log or we found an unexpected block in the
   818		 * log.  If the latter happened, then we know that the "current"
   819		 * transaction marks the end of the valid log.
   820		 */
   821	
   822		if (pass == PASS_SCAN) {
   823			if (!info->end_transaction)
   824				info->end_transaction = next_commit_ID;
   825		} else {
   826			/* It's really bad news if different passes end up at
   827			 * different places (but possible due to IO errors). */
   828			if (info->end_transaction != next_commit_ID) {
   829				printk(KERN_ERR "JBD2: recovery pass %d ended at "
   830					"transaction %u, expected %u\n",
   831					pass, next_commit_ID, info->end_transaction);
   832				if (!success)
   833					success = -EIO;
   834			}
   835		}
   836		if (block_error && success == 0)
   837			success = -EIO;
   838		return success;
   839	
   840	 failed:
   841		return err;
   842	}
   843	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--sdtB3X0nJg68CQEu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
1G0Cn1tlQfF/iKBQtRPNAQA=

--sdtB3X0nJg68CQEu--
