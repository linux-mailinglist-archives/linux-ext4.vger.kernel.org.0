Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07296727728
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jun 2023 08:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjFHGQv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 02:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjFHGQu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 02:16:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F44270B;
        Wed,  7 Jun 2023 23:16:46 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3585v8SY024204;
        Thu, 8 Jun 2023 06:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=CuYYvdDyVxPvMIkgQPT/BtmdTGmAfxC7QUiM5MbG4F0=;
 b=elP3Y6mu3/c4J2COXyayoDwnk+c8LbRZ+qTPCuEA0C6BwaMrWQR5rlBfTv2/I4k7YVJm
 krBAHI3p5h9ek6ZLOZLUSNWp9OMpDG+53ItgItYY4Rx1ElwuRYEE6cuO5i8OoMyDWMUi
 fXeIP2KuchnXVm6/3QN7mGI25KtKYKqDiB+sYPVHDJdAchzXzkZ8N60L4eNPlw3HTJ22
 igYDl7H2Y+HmDdnZldol82HhGz6K4m6wKPZq+kidw0ojaQVBBub+KXeQstF48NXaQ33U
 0oNfqBjLk0pmapynH7/e/IAQDERCHfCO1fvUNuiirIz9dle/XCnjlq+4TWwFfY4tM8kC AQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r399p8a8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 06:16:33 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3585CDhQ008779;
        Thu, 8 Jun 2023 06:16:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r2a7693u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 06:16:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3586GSGo15401572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jun 2023 06:16:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB6CB2004E;
        Thu,  8 Jun 2023 06:16:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6753820043;
        Thu,  8 Jun 2023 06:16:27 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Jun 2023 06:16:27 +0000 (GMT)
Date:   Thu, 8 Jun 2023 11:46:24 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/19] ext4: call ext4_mb_mark_group_bb in
 ext4_mb_clear_bb
Message-ID: <ZIFyOKoJWMiV2xwJ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
 <20230603150327.3596033-17-shikemeng@huaweicloud.com>
 <ZH7+xclxW3hKb7GA@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <bb19c6f8-d31f-f686-17f9-3fd2bb1db3dd@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb19c6f8-d31f-f686-17f9-3fd2bb1db3dd@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TSsqSjhN8gefHwRnTavDcAbG01_ne6QP
X-Proofpoint-GUID: TSsqSjhN8gefHwRnTavDcAbG01_ne6QP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 06, 2023 at 10:16:38PM +0800, Kemeng Shi wrote:
> 
> 
> on 6/6/2023 5:39 PM, Ojaswin Mujoo wrote:
> > On Sat, Jun 03, 2023 at 11:03:24PM +0800, Kemeng Shi wrote:
> >> call ext4_mb_mark_group_bb in ext4_mb_clear_bb to remove repeat code
> >> to update block bitmap and group descriptor on disk.
> >>
> >> Note: ext4_mb_clear_bb will update buddy and bitmap in two critical sections
> >> instead of update in the same critical section.
> >>
> >> Original lock behavior introduced in 7a2fcbf7f857 ("ext4: don't use
> >> blocks freed but not yet committed in buddy cache init") to avoid
> >> race betwwen ext4_mb_free_blocks and ext4_mb_init_cache:
> >> ext4_mb_load_buddy_gfp
> >> ext4_lock_group
> >> mb_clear_bits(bitmap_bh, ...)
> >> mb_free_blocks/ext4_mb_free_metadata
> >> ext4_unlock_group
> >> ext4_mb_unload_buddy
> >>
> >> New lock behavior in this patch:
> >> ext4_mb_load_buddy_gfp
> >> ext4_lock_group
> >> mb_clear_bits(bitmap_bh, ...)
> >> ext4_unlock_group
> >>
> >> /* no ext4_mb_init_cache for the same group will be called as
> >> ext4_mb_load_buddy_gfp will ensure buddy page is update-to-date */
> >>
> >> ext4_lock_group
> >> mb_free_blocks/ext4_mb_free_metadata
> >> ext4_unlock_group
> >> ext4_mb_unload_buddy
> >>
> >> As buddy page for group is always update-to-date between
> >> ext4_mb_load_buddy_gfp and ext4_mb_unload_buddy. Then no
> >> ext4_mb_init_cache will be called for the same group concurrentlly when
> >> we update bitmap and buddy page betwwen buddy load and unload.
> >>
> >> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> > 
> > Hi Kemeng,
> > 
> > Sorry for the late reply I was trying to understand the codepath
> > properly. So I have a question here:
> > 
> > With the changes you've made in the patch, the flow would look something
> > like:
> > 
> > ext4_mb_clear_bb():
> >   ext4_mb_mark_group_bb():
> >     ext4_group_lock()
> >       - Mark bitmap free
> >       - Modify gdp
> >     ext4_group_unlock()
> >     ext4_handle_dirty_metadata()
> > 			- I understand this will add the bitmap and gdp buffers to journal's 
> >         dirty metadata list
> >   ...
> >   ext4_group_lock()
> >     ext4_mb_free_metadata()
> > 			- Add ext4_free_data entries to sbi->s_freed_data_list. (On commit 
> >         ext4_journal_commit_callback() will then free the buddy for these)
> >   ext4_group_unlock()
> > 
> > My question is what happens if journal commits between
> > ext4_handle_dirty_metadata() and ext4_mb_free_metadata() call (Possible?). Then we might
> > never end up freeing the metadata in the buddy bitmap because the commit callback wont
> > be able to find the ext4_free_data entries in sbi->s_freed_data_list.
> > 
> > Regards,
> > ojaswin
> > 
> Hi Ojaswin, thanks for the reply. To my knowledge, commit should be normally done after handle
> is stopped as following:
> ext4_journal_start_sb
> 	start_this_handle
> 		read_lock(&journal->j_state_lock);
> 		atomic_inc(&transaction->t_updates);
> 		read_unlock(&journal->j_state_lock);
> 
> ext4_journal_stop
> 	jbd2_journal_stop
> 		stop_this_handle
> 			if (atomic_dec_and_test(&transaction->t_updates))
> 				wake_up(&journal->j_wait_updates);
> 
> jbd2_journal_commit_transaction
> 	jbd2_journal_wait_updates
> 		while (1)
> 			if (!atomic_read(&transaction->t_updates))
> 				/* break loop */
> 	...
> 
> 	if (journal->j_commit_callback)
> 		journal->j_commit_callback(journal, commit_transaction);
> 
> So no commit of transaction should not happen between ext4_handle_dirty_metadata and
> ext4_mb_free_metadata.

Hi Kemeng, 

Okay makes sense. Thanks for the explanation :) 

Regards,
ojaswin

> 
> >> ---
> >>  fs/ext4/mballoc.c | 90 ++++++++++++-----------------------------------
> >>  1 file changed, 23 insertions(+), 67 deletions(-)
> >>
> >> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> >> index 46b37f5c9223..e4f1b34448e3 100644
> >> --- a/fs/ext4/mballoc.c
> >> +++ b/fs/ext4/mballoc.c
> >> @@ -6135,19 +6135,21 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
> >>  			       ext4_fsblk_t block, unsigned long count,
> >>  			       int flags)
> >>  {
> >> -	struct buffer_head *bitmap_bh = NULL;
> >> +	struct ext4_mark_context mc = {
> >> +		.handle = handle,
> >> +		.sb = inode->i_sb,
> >> +		.state = 0,
> >> +	};
> >>  	struct super_block *sb = inode->i_sb;
> >> -	struct ext4_group_desc *gdp;
> >>  	struct ext4_group_info *grp;
> >>  	unsigned int overflow;
> >>  	ext4_grpblk_t bit;
> >> -	struct buffer_head *gd_bh;
> >>  	ext4_group_t block_group;
> >>  	struct ext4_sb_info *sbi;
> >>  	struct ext4_buddy e4b;
> >>  	unsigned int count_clusters;
> >>  	int err = 0;
> >> -	int ret;
> >> +	int mark_flags = 0;
> >>  
> >>  	sbi = EXT4_SB(sb);
> >>  
> >> @@ -6179,18 +6181,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
> >>  		/* The range changed so it's no longer validated */
> >>  		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
> >>  	}
> >> -	count_clusters = EXT4_NUM_B2C(sbi, count);
> >> -	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
> >> -	if (IS_ERR(bitmap_bh)) {
> >> -		err = PTR_ERR(bitmap_bh);
> >> -		bitmap_bh = NULL;
> >> -		goto error_return;
> >> -	}
> >> -	gdp = ext4_get_group_desc(sb, block_group, &gd_bh);
> >> -	if (!gdp) {
> >> -		err = -EIO;
> >> -		goto error_return;
> >> -	}
> >>  
> >>  	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
> >>  	    !ext4_inode_block_valid(inode, block, count)) {
> >> @@ -6200,28 +6190,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
> >>  		goto error_return;
> >>  	}
> >>  
> >> -	BUFFER_TRACE(bitmap_bh, "getting write access");
> >> -	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
> >> -					    EXT4_JTR_NONE);
> >> -	if (err)
> >> -		goto error_return;
> >> -
> >> -	/*
> >> -	 * We are about to modify some metadata.  Call the journal APIs
> >> -	 * to unshare ->b_data if a currently-committing transaction is
> >> -	 * using it
> >> -	 */
> >> -	BUFFER_TRACE(gd_bh, "get_write_access");
> >> -	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
> >> -	if (err)
> >> -		goto error_return;
> >> -#ifdef AGGRESSIVE_CHECK
> >> -	{
> >> -		int i;
> >> -		for (i = 0; i < count_clusters; i++)
> >> -			BUG_ON(!mb_test_bit(bit + i, bitmap_bh->b_data));
> >> -	}
> >> -#endif
> >> +	count_clusters = EXT4_NUM_B2C(sbi, count);
> >>  	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
> >>  
> >>  	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
> >> @@ -6230,6 +6199,22 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
> >>  	if (err)
> >>  		goto error_return;
> >>  
> >> +#ifdef AGGRESSIVE_CHECK
> >> +	mark_flags |= EXT4_MB_BITMAP_MARKED_CHECK;
> >> +#endif
> >> +	err = ext4_mb_mark_group_bb(&mc, block_group, bit, count_clusters,
> >> +				    mark_flags);
> >> +
> >> +
> >> +	if (err && mc.changed == 0) {
> >> +		ext4_mb_unload_buddy(&e4b);
> >> +		goto error_return;
> >> +	}
> >> +
> >> +#ifdef AGGRESSIVE_CHECK
> >> +	BUG_ON(mc.changed != count_clusters);
> >> +#endif
> >> +
> >>  	/*
> >>  	 * We need to make sure we don't reuse the freed block until after the
> >>  	 * transaction is committed. We make an exception if the inode is to be
> >> @@ -6252,13 +6237,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
> >>  		new_entry->efd_tid = handle->h_transaction->t_tid;
> >>  
> >>  		ext4_lock_group(sb, block_group);
> >> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
> >>  		ext4_mb_free_metadata(handle, &e4b, new_entry);
> >>  	} else {
> >> -		/* need to update group_info->bb_free and bitmap
> >> -		 * with group lock held. generate_buddy look at
> >> -		 * them with group lock_held
> >> -		 */
> >>  		if (test_opt(sb, DISCARD)) {
> >>  			err = ext4_issue_discard(sb, block_group, bit,
> >>  						 count_clusters, NULL);
> >> @@ -6271,23 +6251,11 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
> >>  			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
> >>  
> >>  		ext4_lock_group(sb, block_group);
> >> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
> >>  		mb_free_blocks(inode, &e4b, bit, count_clusters);
> >>  	}
> >>  
> >> -	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
> >> -	ext4_free_group_clusters_set(sb, gdp, ret);
> >> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> >> -	ext4_group_desc_csum_set(sb, block_group, gdp);
> >>  	ext4_unlock_group(sb, block_group);
> >>  
> >> -	if (sbi->s_log_groups_per_flex) {
> >> -		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
> >> -		atomic64_add(count_clusters,
> >> -			     &sbi_array_rcu_deref(sbi, s_flex_groups,
> >> -						  flex_group)->free_clusters);
> >> -	}
> >> -
> >>  	/*
> >>  	 * on a bigalloc file system, defer the s_freeclusters_counter
> >>  	 * update to the caller (ext4_remove_space and friends) so they
> >> @@ -6302,26 +6270,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
> >>  
> >>  	ext4_mb_unload_buddy(&e4b);
> >>  
> >> -	/* We dirtied the bitmap block */
> >> -	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
> >> -	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
> >> -
> >> -	/* And the group descriptor block */
> >> -	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
> >> -	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
> >> -	if (!err)
> >> -		err = ret;
> >> -
> >>  	if (overflow && !err) {
> >>  		block += count;
> >>  		count = overflow;
> >> -		put_bh(bitmap_bh);
> >>  		/* The range changed so it's no longer validated */
> >>  		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
> >>  		goto do_more;
> >>  	}
> >>  error_return:
> >> -	brelse(bitmap_bh);
> >>  	ext4_std_error(sb, err);
> >>  	return;
> >>  }
> >> -- 
> >> 2.30.0
> >>
> > 
> 
> -- 
> Best wishes
> Kemeng Shi
> 
