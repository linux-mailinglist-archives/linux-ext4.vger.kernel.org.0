Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94EE7DE415
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Nov 2023 16:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjKAPpq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Nov 2023 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbjKAPpm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Nov 2023 11:45:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7379E4;
        Wed,  1 Nov 2023 08:45:38 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1Ff0TX009625;
        Wed, 1 Nov 2023 15:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qqTqld6TNMz6S169GlceMny/T6g2ZuFLzeGC9yFelHM=;
 b=ctoklITT5PsVuCOlLafnyxwrNRcOttr6rTt6vo6ypxP2tIhgksefEHYCW0lT3pfua6dQ
 GxgYDZJVg2l1MYsPDIXzJm20bPuaf6aPNXgkU/IfShMTS+A7f7OliG6ElA//XJi31mmH
 WAeG34vDK0GobuB5gJircphFfNqoxe6RMhb559vf9Q7vFpbbLzUtbiMT0bmH68ZpfgJp
 qN2nf19fm2OrIzRTEGUq+kPdOy4lgwapWpCZDYvHLHNVPix9EK4Fm9zZL/gEb+VkjFCU
 z+LBK/WVvMvMkYG54MLgyYhNcLDFpg/b6fVSjVIwR+mOdXcpBF7adyQtcWbDA+lCVJyw rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3s40gvjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 15:45:34 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A1FfXW6011213;
        Wed, 1 Nov 2023 15:45:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3s40gvj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 15:45:33 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1Eu5FE000725;
        Wed, 1 Nov 2023 15:45:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmt8t2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 15:45:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A1FjUBO44696138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 15:45:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E290E2004E;
        Wed,  1 Nov 2023 15:45:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B46820040;
        Wed,  1 Nov 2023 15:45:29 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.9.163])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Nov 2023 15:45:29 +0000 (GMT)
Date:   Wed, 1 Nov 2023 21:15:26 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ext4: truncate complete range in pagecache before
 calling ext4_zero_partial_blocks()
Message-ID: <ZUJydhIfHauMZ78p@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1695987265.git.ojaswin@linux.ibm.com>
 <f7aaea4a59bc1c69f87e178dae34c38d2bcfee12.1695987265.git.ojaswin@linux.ibm.com>
 <ZRb4BX8bhhyWEari@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20231019165546.norapdphdyx7g3ob@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019165546.norapdphdyx7g3ob@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q8L7lVziukwfGXGsm1TRgvN60JlzWqs8
X-Proofpoint-GUID: 1lHNHPu69KnIve4W8pUQpiybJICBymY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_14,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 19, 2023 at 06:55:46PM +0200, Jan Kara wrote:
> On Fri 29-09-23 21:45:29, Ojaswin Mujoo wrote:
> > On Fri, Sep 29, 2023 at 07:40:44PM +0530, Ojaswin Mujoo wrote:
> > > In ext4_zero_range() and ext4_punch_hole(), the range passed could be unaligned
> > > however we only zero out the pagecache range that is block aligned. These
> > > functions are relying on ext4_zero_partial_blocks() ->
> > > __ext4_block_zero_page_range() to take care of zeroing the unaligned edges in
> > > the pageacache. However, the right thing to do is to properly zero out the whole
> > > range in these functions before and not rely on a different function to do it
> > > for us. Hence, modify ext4_zero_range() and ext4_punch_hole() to zero the
> > > complete range.
> > > 
> > > This will also allow us to now exit early for unwritten buffer heads in
> > > __ext4_block_zero_page_range(), in upcoming patch.
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  fs/ext4/extents.c | 17 +++++++++++------
> > >  fs/ext4/inode.c   |  3 +--
> > >  2 files changed, 12 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index c79b4c25afc4..2dc681cab6a5 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > > @@ -4582,9 +4582,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
> > >  
> > >  	/* Zero range excluding the unaligned edges */
> > >  	if (max_blocks > 0) {
> > > -		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
> > > -			  EXT4_EX_NOCACHE);
> > > -
> > >  		/*
> > >  		 * Prevent page faults from reinstantiating pages we have
> > >  		 * released from page cache.
> > > @@ -4609,17 +4606,25 @@ static long ext4_zero_range(struct file *file, loff_t offset,
> > >  		 * disk in case of crash before zeroing trans is committed.
> > >  		 */
> > >  		if (ext4_should_journal_data(inode)) {
> > > -			ret = filemap_write_and_wait_range(mapping, start, end - 1);
> > > +			ret = filemap_write_and_wait_range(mapping, start,
> > > +							   end - 1);
> > 
> > I think this accidentally creeped in, will fix it in next rev.
> 
> Yeah, just pull it in patch 1.
> 
> > >  			if (ret) {
> > >  				filemap_invalidate_unlock(mapping);
> > >  				goto out_mutex;
> > >  			}
> > >  		}
> > > +	}
> > 
> > So the above if (max_blocks) {...} block runs when the range spans
> > multiple blocks but I think the filemap_write_and_wait_range() and
> > ext4_update_disksize_before_punch() should be called when we are actually
> > spanning multiple pages, since the disksize not updating issue and the 
> > truncate racing with checkpoint only happen when the complete page is
> > truncated. Is this understanding correct? 
> 
> Why do you think the issues apply only to multiple pages? I mean even if a
> single block is dirty in memory, it may be pushing i_disksize or carrying
> journalled data we need to commit.

Hey Jan, 

You are right, I think I was misunderstanding this code a bit, thinking
that these things would only be needed if the complete folio is absent.
Upon rechecking the paths like the writeback path I can now see that
even if the blocks till i_size are already allocated (eg, through
ext4_zero_range) then we won't actually be calling
mpage_map_and_submit_extent() which is where disksize updates.

> 
> > > +	/*
> > > +	 * Now truncate the pagecache and zero out non page aligned edges of the
> > > +	 * range (if any)
> > > +	 */
> > > +	truncate_pagecache_range(inode, offset, offset + len - 1);
> > >  
> > > -		/* Now release the pages and zero block aligned part of pages */
> > > -		truncate_pagecache_range(inode, start, end - 1);
> > > +	if (max_blocks > 0) {
> > >  		inode->i_mtime = inode->i_ctime = current_time(inode);
> > >  
> > > +		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
> > >  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
> > >  					     flags);
> > >  		filemap_invalidate_unlock(mapping);
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 6c490f05e2ba..de8ea8430d30 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -3974,9 +3974,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
> > >  		ret = ext4_update_disksize_before_punch(inode, offset, length);
> > 
> > In this function ext4_punch_hole() I see that we call
> > filemap_write_and_wait_range() and then take the inode_lock() later.
> > Doesn't this leave a window for the pages to get dirty again? 
> 
> There's definitely a race window but I think the call to
> filemap_write_and_wait_range() is a leftover from the past when hole
> punching could race in a nasty way. These days we have invalidate_lock so I
> *think* we can just remove that filemap_write_and_wait_range() call. At
> least I don't see a good reason for it now because the pages are going away
> anyway. But it needs testing :).

> 
> > For example, in ext4_zero_range(), we checkpoint using
> > filemap_write_and_wait_range() in case of data=journal under
> > inode_lock() but that's not the case here. Just wondering if this 
> > or any other code path might still race here? 
> 
> Well, that's a bit different story as the comment there explains. And yes,
> invalidate_lock protects us from possible races there.

Ahh okay, got it.

> 
> > >  		if (ret)
> > >  			goto out_dio;
> > > -		truncate_pagecache_range(inode, first_block_offset,
> > > -					 last_block_offset);
> > >  	}
> > > +	truncate_pagecache_range(inode, offset, offset + length - 1);
> 
> But I have realized that changes done in this patch actually don't help
> with changing ext4_zero_partial_blocks() because as soon as we drop
> invalidate_lock, a page fault can come in and modify contents of partial
> pages we need zeroed.
> 
> So thinking about this again with fresh mind, these block vs pagecache
> consistency issues aren't probably worth it and current code flow is good
> enough. Sorry for misleading you. We might just add a comment to
> __ext4_block_zero_page_range() to explain that buffer_unwritten() buffers
> can get there but they should be already zeroed-out and uptodate and we do
> need to process them because of page cache zeroing. What do you think?

Oh right, I was not thinking from the mmap path, sorry about that. In
that case I think your point makes sense, lets just let this be for now.
I'll send a v2 with the first patch of the series and also add a comment
as you suggested.

Thanks for the review and taking the time to answer my questions!

Regards,
ojaswin
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
