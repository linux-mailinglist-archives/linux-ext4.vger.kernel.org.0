Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6DA285A28
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Oct 2020 10:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJGILM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Oct 2020 04:11:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:36606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgJGILL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 7 Oct 2020 04:11:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AC5BB018;
        Wed,  7 Oct 2020 08:11:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C14991E1305; Wed,  7 Oct 2020 10:11:08 +0200 (CEST)
Date:   Wed, 7 Oct 2020 10:11:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@hikvision.com>,
        changfengnan <fengnanchang@foxmail.com>
Subject: Re: [PATCH v3] jbd2: avoid transaction reuse after reformatting
Message-ID: <20201007081108.GB6984@quack2.suse.cz>
References: <20201006103154.7130-1-jack@suse.cz>
 <202010062030.yz2whk5O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010062030.yz2whk5O-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-10-20 21:06:06, kernel test robot wrote:
> Hi Jan,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on ext4/dev]
> [also build test WARNING on linus/master v5.9-rc8 next-20201002]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

Thanks for report! I'll send v4 with sparse warning fixed up (it isn't a
functional problem but it is good to have it fixed).

								Honza

> 
> url:    https://github.com/0day-ci/linux/commits/Jan-Kara/jbd2-avoid-transaction-reuse-after-reformatting/20201006-183337
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> config: i386-randconfig-s001-20201005 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-201-g24bdaac6-dirty
>         # https://github.com/0day-ci/linux/commit/ca606dc0beaec78e8b2b6ec2f112b2192534d9e2
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Jan-Kara/jbd2-avoid-transaction-reuse-after-reformatting/20201006-183337
>         git checkout ca606dc0beaec78e8b2b6ec2f112b2192534d9e2
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 	echo
> 	echo "sparse warnings: (new ones prefixed by >>)"
> 	echo
> >> fs/jbd2/recovery.c:713:41: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be64 [usertype] commit_time @@     got unsigned long long @@
>    fs/jbd2/recovery.c:713:41: sparse:     expected restricted __be64 [usertype] commit_time
> >> fs/jbd2/recovery.c:713:41: sparse:     got unsigned long long
>    fs/jbd2/recovery.c:730:45: sparse: sparse: restricted __be64 degrades to integer
>    fs/jbd2/recovery.c:730:60: sparse: sparse: restricted __be64 degrades to integer
> 
> vim +713 fs/jbd2/recovery.c
> 
>    415	
>    416	static int do_one_pass(journal_t *journal,
>    417				struct recovery_info *info, enum passtype pass)
>    418	{
>    419		unsigned int		first_commit_ID, next_commit_ID;
>    420		unsigned long		next_log_block;
>    421		int			err, success = 0;
>    422		journal_superblock_t *	sb;
>    423		journal_header_t *	tmp;
>    424		struct buffer_head *	bh;
>    425		unsigned int		sequence;
>    426		int			blocktype;
>    427		int			tag_bytes = journal_tag_bytes(journal);
>    428		__u32			crc32_sum = ~0; /* Transactional Checksums */
>    429		int			descr_csum_size = 0;
>    430		int			block_error = 0;
>    431		bool			need_check_commit_time = false;
>    432		__be64			last_trans_commit_time = 0;
>    433	
>    434		/*
>    435		 * First thing is to establish what we expect to find in the log
>    436		 * (in terms of transaction IDs), and where (in terms of log
>    437		 * block offsets): query the superblock.
>    438		 */
>    439	
>    440		sb = journal->j_superblock;
>    441		next_commit_ID = be32_to_cpu(sb->s_sequence);
>    442		next_log_block = be32_to_cpu(sb->s_start);
>    443	
>    444		first_commit_ID = next_commit_ID;
>    445		if (pass == PASS_SCAN)
>    446			info->start_transaction = first_commit_ID;
>    447	
>    448		jbd_debug(1, "Starting recovery pass %d\n", pass);
>    449	
>    450		/*
>    451		 * Now we walk through the log, transaction by transaction,
>    452		 * making sure that each transaction has a commit block in the
>    453		 * expected place.  Each complete transaction gets replayed back
>    454		 * into the main filesystem.
>    455		 */
>    456	
>    457		while (1) {
>    458			int			flags;
>    459			char *			tagp;
>    460			journal_block_tag_t *	tag;
>    461			struct buffer_head *	obh;
>    462			struct buffer_head *	nbh;
>    463	
>    464			cond_resched();
>    465	
>    466			/* If we already know where to stop the log traversal,
>    467			 * check right now that we haven't gone past the end of
>    468			 * the log. */
>    469	
>    470			if (pass != PASS_SCAN)
>    471				if (tid_geq(next_commit_ID, info->end_transaction))
>    472					break;
>    473	
>    474			jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
>    475				  next_commit_ID, next_log_block, journal->j_last);
>    476	
>    477			/* Skip over each chunk of the transaction looking
>    478			 * either the next descriptor block or the final commit
>    479			 * record. */
>    480	
>    481			jbd_debug(3, "JBD2: checking block %ld\n", next_log_block);
>    482			err = jread(&bh, journal, next_log_block);
>    483			if (err)
>    484				goto failed;
>    485	
>    486			next_log_block++;
>    487			wrap(journal, next_log_block);
>    488	
>    489			/* What kind of buffer is it?
>    490			 *
>    491			 * If it is a descriptor block, check that it has the
>    492			 * expected sequence number.  Otherwise, we're all done
>    493			 * here. */
>    494	
>    495			tmp = (journal_header_t *)bh->b_data;
>    496	
>    497			if (tmp->h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER)) {
>    498				brelse(bh);
>    499				break;
>    500			}
>    501	
>    502			blocktype = be32_to_cpu(tmp->h_blocktype);
>    503			sequence = be32_to_cpu(tmp->h_sequence);
>    504			jbd_debug(3, "Found magic %d, sequence %d\n",
>    505				  blocktype, sequence);
>    506	
>    507			if (sequence != next_commit_ID) {
>    508				brelse(bh);
>    509				break;
>    510			}
>    511	
>    512			/* OK, we have a valid descriptor block which matches
>    513			 * all of the sequence number checks.  What are we going
>    514			 * to do with it?  That depends on the pass... */
>    515	
>    516			switch(blocktype) {
>    517			case JBD2_DESCRIPTOR_BLOCK:
>    518				/* Verify checksum first */
>    519				if (jbd2_journal_has_csum_v2or3(journal))
>    520					descr_csum_size =
>    521						sizeof(struct jbd2_journal_block_tail);
>    522				if (descr_csum_size > 0 &&
>    523				    !jbd2_descriptor_block_csum_verify(journal,
>    524								       bh->b_data)) {
>    525					/*
>    526					 * PASS_SCAN can see stale blocks due to lazy
>    527	 				 * journal init. Don't error out on those yet.
>    528					 */
>    529					if (pass != PASS_SCAN) {
>    530						pr_err("JBD2: Invalid checksum "
>    531						       "recovering block %lu in log\n",
>    532						       next_log_block);
>    533						err = -EFSBADCRC;
>    534						brelse(bh);
>    535						goto failed;
>    536					}
>    537					need_check_commit_time = true;
>    538					jbd_debug(1,
>    539						"invalid descriptor block found in %lu\n",
>    540						next_log_block);
>    541				}
>    542	
>    543				/* If it is a valid descriptor block, replay it
>    544				 * in pass REPLAY; if journal_checksums enabled, then
>    545				 * calculate checksums in PASS_SCAN, otherwise,
>    546				 * just skip over the blocks it describes. */
>    547				if (pass != PASS_REPLAY) {
>    548					if (pass == PASS_SCAN &&
>    549					    jbd2_has_feature_checksum(journal) &&
>    550					    !need_check_commit_time &&
>    551					    !info->end_transaction) {
>    552						if (calc_chksums(journal, bh,
>    553								&next_log_block,
>    554								&crc32_sum)) {
>    555							put_bh(bh);
>    556							break;
>    557						}
>    558						put_bh(bh);
>    559						continue;
>    560					}
>    561					next_log_block += count_tags(journal, bh);
>    562					wrap(journal, next_log_block);
>    563					put_bh(bh);
>    564					continue;
>    565				}
>    566	
>    567				/* A descriptor block: we can now write all of
>    568				 * the data blocks.  Yay, useful work is finally
>    569				 * getting done here! */
>    570	
>    571				tagp = &bh->b_data[sizeof(journal_header_t)];
>    572				while ((tagp - bh->b_data + tag_bytes)
>    573				       <= journal->j_blocksize - descr_csum_size) {
>    574					unsigned long io_block;
>    575	
>    576					tag = (journal_block_tag_t *) tagp;
>    577					flags = be16_to_cpu(tag->t_flags);
>    578	
>    579					io_block = next_log_block++;
>    580					wrap(journal, next_log_block);
>    581					err = jread(&obh, journal, io_block);
>    582					if (err) {
>    583						/* Recover what we can, but
>    584						 * report failure at the end. */
>    585						success = err;
>    586						printk(KERN_ERR
>    587							"JBD2: IO error %d recovering "
>    588							"block %ld in log\n",
>    589							err, io_block);
>    590					} else {
>    591						unsigned long long blocknr;
>    592	
>    593						J_ASSERT(obh != NULL);
>    594						blocknr = read_tag_block(journal,
>    595									 tag);
>    596	
>    597						/* If the block has been
>    598						 * revoked, then we're all done
>    599						 * here. */
>    600						if (jbd2_journal_test_revoke
>    601						    (journal, blocknr,
>    602						     next_commit_ID)) {
>    603							brelse(obh);
>    604							++info->nr_revoke_hits;
>    605							goto skip_write;
>    606						}
>    607	
>    608						/* Look for block corruption */
>    609						if (!jbd2_block_tag_csum_verify(
>    610							journal, tag, obh->b_data,
>    611							be32_to_cpu(tmp->h_sequence))) {
>    612							brelse(obh);
>    613							success = -EFSBADCRC;
>    614							printk(KERN_ERR "JBD2: Invalid "
>    615							       "checksum recovering "
>    616							       "data block %llu in "
>    617							       "log\n", blocknr);
>    618							block_error = 1;
>    619							goto skip_write;
>    620						}
>    621	
>    622						/* Find a buffer for the new
>    623						 * data being restored */
>    624						nbh = __getblk(journal->j_fs_dev,
>    625								blocknr,
>    626								journal->j_blocksize);
>    627						if (nbh == NULL) {
>    628							printk(KERN_ERR
>    629							       "JBD2: Out of memory "
>    630							       "during recovery.\n");
>    631							err = -ENOMEM;
>    632							brelse(bh);
>    633							brelse(obh);
>    634							goto failed;
>    635						}
>    636	
>    637						lock_buffer(nbh);
>    638						memcpy(nbh->b_data, obh->b_data,
>    639								journal->j_blocksize);
>    640						if (flags & JBD2_FLAG_ESCAPE) {
>    641							*((__be32 *)nbh->b_data) =
>    642							cpu_to_be32(JBD2_MAGIC_NUMBER);
>    643						}
>    644	
>    645						BUFFER_TRACE(nbh, "marking dirty");
>    646						set_buffer_uptodate(nbh);
>    647						mark_buffer_dirty(nbh);
>    648						BUFFER_TRACE(nbh, "marking uptodate");
>    649						++info->nr_replays;
>    650						/* ll_rw_block(WRITE, 1, &nbh); */
>    651						unlock_buffer(nbh);
>    652						brelse(obh);
>    653						brelse(nbh);
>    654					}
>    655	
>    656				skip_write:
>    657					tagp += tag_bytes;
>    658					if (!(flags & JBD2_FLAG_SAME_UUID))
>    659						tagp += 16;
>    660	
>    661					if (flags & JBD2_FLAG_LAST_TAG)
>    662						break;
>    663				}
>    664	
>    665				brelse(bh);
>    666				continue;
>    667	
>    668			case JBD2_COMMIT_BLOCK:
>    669				/*     How to differentiate between interrupted commit
>    670				 *               and journal corruption ?
>    671				 *
>    672				 * {nth transaction}
>    673				 *        Checksum Verification Failed
>    674				 *			 |
>    675				 *		 ____________________
>    676				 *		|		     |
>    677				 * 	async_commit             sync_commit
>    678				 *     		|                    |
>    679				 *		| GO TO NEXT    "Journal Corruption"
>    680				 *		| TRANSACTION
>    681				 *		|
>    682				 * {(n+1)th transanction}
>    683				 *		|
>    684				 * 	 _______|______________
>    685				 * 	|	 	      |
>    686				 * Commit block found	Commit block not found
>    687				 *      |		      |
>    688				 * "Journal Corruption"       |
>    689				 *		 _____________|_________
>    690				 *     		|	           	|
>    691				 *	nth trans corrupt	OR   nth trans
>    692				 *	and (n+1)th interrupted     interrupted
>    693				 *	before commit block
>    694				 *      could reach the disk.
>    695				 *	(Cannot find the difference in above
>    696				 *	 mentioned conditions. Hence assume
>    697				 *	 "Interrupted Commit".)
>    698				 */
>    699	
>    700				/*
>    701				 * Found an expected commit block: if checksums
>    702				 * are present, verify them in PASS_SCAN; else not
>    703				 * much to do other than move on to the next sequence
>    704				 * number.
>    705				 */
>    706				if (pass == PASS_SCAN &&
>    707				    jbd2_has_feature_checksum(journal)) {
>    708					struct commit_header *cbh =
>    709						(struct commit_header *)bh->b_data;
>    710					unsigned found_chksum =
>    711						be32_to_cpu(cbh->h_chksum[0]);
>    712					__be64 commit_time =
>  > 713						be64_to_cpu(cbh->h_commit_sec);
>    714	
>    715					if (info->end_transaction) {
>    716						journal->j_failed_commit =
>    717							info->end_transaction;
>    718						brelse(bh);
>    719						break;
>    720					}
>    721	
>    722					/*
>    723					 * If need_check_commit_time is set, it means
>    724					 * csum verify failed before, if commit_time is
>    725					 * increasing, it's same journal, otherwise it
>    726					 * is stale journal block, just end this
>    727					 * recovery.
>    728					 */
>    729					if (need_check_commit_time) {
>    730						if (commit_time >= last_trans_commit_time) {
>    731							pr_err("JBD2: Invalid checksum found in transaction %u\n",
>    732							       next_commit_ID);
>    733							err = -EFSBADCRC;
>    734							brelse(bh);
>    735							goto failed;
>    736						}
>    737						/*
>    738						 * It likely does not belong to same
>    739						 * journal, just end this recovery with
>    740						 * success.
>    741						 */
>    742						jbd_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
>    743							  next_commit_ID);
>    744						err = 0;
>    745						brelse(bh);
>    746						goto done;
>    747					}
>    748	
>    749					/* Neither checksum match nor unused? */
>    750					if (!((crc32_sum == found_chksum &&
>    751					       cbh->h_chksum_type ==
>    752							JBD2_CRC32_CHKSUM &&
>    753					       cbh->h_chksum_size ==
>    754							JBD2_CRC32_CHKSUM_SIZE) ||
>    755					      (cbh->h_chksum_type == 0 &&
>    756					       cbh->h_chksum_size == 0 &&
>    757					       found_chksum == 0)))
>    758						goto chksum_error;
>    759	
>    760					crc32_sum = ~0;
>    761					last_trans_commit_time = commit_time;
>    762				}
>    763				if (pass == PASS_SCAN &&
>    764				    !jbd2_commit_block_csum_verify(journal,
>    765								   bh->b_data)) {
>    766				chksum_error:
>    767					info->end_transaction = next_commit_ID;
>    768	
>    769					if (!jbd2_has_feature_async_commit(journal)) {
>    770						journal->j_failed_commit =
>    771							next_commit_ID;
>    772						brelse(bh);
>    773						break;
>    774					}
>    775				}
>    776				brelse(bh);
>    777				next_commit_ID++;
>    778				continue;
>    779	
>    780			case JBD2_REVOKE_BLOCK:
>    781				/*
>    782				 * Check revoke block crc in pass_scan, if csum verify
>    783				 * failed, check commit block time later.
>    784				 */
>    785				if (pass == PASS_SCAN &&
>    786				    !jbd2_descriptor_block_csum_verify(journal,
>    787								       bh->b_data)) {
>    788					jbd_debug(1, "JBD2: invalid revoke block found in %lu\n",
>    789						  next_log_block);
>    790					need_check_commit_time = true;
>    791				}
>    792				/* If we aren't in the REVOKE pass, then we can
>    793				 * just skip over this block. */
>    794				if (pass != PASS_REVOKE) {
>    795					brelse(bh);
>    796					continue;
>    797				}
>    798	
>    799				err = scan_revoke_records(journal, bh,
>    800							  next_commit_ID, info);
>    801				brelse(bh);
>    802				if (err)
>    803					goto failed;
>    804				continue;
>    805	
>    806			default:
>    807				jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
>    808					  blocktype);
>    809				brelse(bh);
>    810				goto done;
>    811			}
>    812		}
>    813	
>    814	 done:
>    815		/*
>    816		 * We broke out of the log scan loop: either we came to the
>    817		 * known end of the log or we found an unexpected block in the
>    818		 * log.  If the latter happened, then we know that the "current"
>    819		 * transaction marks the end of the valid log.
>    820		 */
>    821	
>    822		if (pass == PASS_SCAN) {
>    823			if (!info->end_transaction)
>    824				info->end_transaction = next_commit_ID;
>    825		} else {
>    826			/* It's really bad news if different passes end up at
>    827			 * different places (but possible due to IO errors). */
>    828			if (info->end_transaction != next_commit_ID) {
>    829				printk(KERN_ERR "JBD2: recovery pass %d ended at "
>    830					"transaction %u, expected %u\n",
>    831					pass, next_commit_ID, info->end_transaction);
>    832				if (!success)
>    833					success = -EIO;
>    834			}
>    835		}
>    836		if (block_error && success == 0)
>    837			success = -EIO;
>    838		return success;
>    839	
>    840	 failed:
>    841		return err;
>    842	}
>    843	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
