Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032EB200797
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 13:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgFSLQs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Jun 2020 07:16:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40886 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731108AbgFSLQo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 19 Jun 2020 07:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592565402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dzlh3Beb8TVN+8fiXAM+LK2Mo9t7r/0nCU7g2eWiMdc=;
        b=flHLQVFttZa8d41ExF1r/vQAmbJkZy8LuBNhAMV2VtGv01cSFpdx9/+/lsgsDwHKHyQMjz
        ZFMb2jMj/nxeU15xipX2AWWoN0AGu/7rZ1C4IPF4rI2SI1yoE+fcNt74fLB81dn0fhEwzh
        NTVOOMh7QmEbhmhbu905PKN3csEGYL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-9aL1Li9KNzm1nrdXyGk4uQ-1; Fri, 19 Jun 2020 07:16:41 -0400
X-MC-Unique: 9aL1Li9KNzm1nrdXyGk4uQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DBF9464
        for <linux-ext4@vger.kernel.org>; Fri, 19 Jun 2020 11:16:40 +0000 (UTC)
Received: from work (unknown [10.40.192.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28FF971662;
        Fri, 19 Jun 2020 11:16:35 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:16:31 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/1] ext4: fix potential negative array index in
 do_split()
Message-ID: <20200619111631.ugx7sdpci32ohgir@work>
References: <d08d63e9-8f74-b571-07c7-828b9629ce6a@redhat.com>
 <f53e246b-647c-64bb-16ec-135383c70ad7@redhat.com>
 <20200619064122.vj346xptid5viogv@work>
 <20200619070854.z3dslhh7yebainhd@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619070854.z3dslhh7yebainhd@work>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 19, 2020 at 09:08:54AM +0200, Lukas Czerner wrote:
> On Fri, Jun 19, 2020 at 08:41:22AM +0200, Lukas Czerner wrote:
> > On Wed, Jun 17, 2020 at 02:19:04PM -0500, Eric Sandeen wrote:
> > > If for any reason a directory passed to do_split() does not have enough
> > > active entries to exceed half the size of the block, we can end up
> > > iterating over all "count" entries without finding a split point.
> > > 
> > > In this case, count == move, and split will be zero, and we will
> > > attempt a negative index into map[].
> > > 
> > > Guard against this by detecting this case, and falling back to
> > > split-to-half-of-count instead; in this case we will still have
> > > plenty of space (> half blocksize) in each split block.
> > > 
> > > Fixes: ef2b02d3e617 ("ext34: ensure do_split leaves enough free space in both blocks")
> > > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > > ---
> > > 
> > > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > > index a8aca4772aaa..8b60881f07ee 100644
> > > --- a/fs/ext4/namei.c
> > > +++ b/fs/ext4/namei.c
> > > @@ -1858,7 +1858,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
> > >  			     blocksize, hinfo, map);
> > >  	map -= count;
> > >  	dx_sort_map(map, count);
> > > -	/* Split the existing block in the middle, size-wise */
> > > +	/* Ensure that neither split block is over half full */
> > >  	size = 0;
> > >  	move = 0;
> > >  	for (i = count-1; i >= 0; i--) {
> > > @@ -1868,8 +1868,18 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
> > >  		size += map[i].size;
> > >  		move++;
> > >  	}
> > > -	/* map index at which we will split */
> > > -	split = count - move;
> > > +	/*
> > > +	 * map index at which we will split
> > > +	 *
> > > +	 * If the sum of active entries didn't exceed half the block size, just
> > > +	 * split it in half by count; each resulting block will have at least
> > > +	 * half the space free.
> > > +	 */
> > > +	if (i > 0)
> > > +		split = count - move;
> > > +	else
> > > +		split = count/2;
> > 
> > Won't we have exactly the same problem as we did before your commit
> > ef2b02d3e617cb0400eedf2668f86215e1b0e6af ? Since we do not know how much
> > space we actually moved we might have not made enough space for the new
> > entry ?
> > 
> > Also since we have the move == count when the problem appears then it's
> > clear that we never hit the condition
> > 
> > 1865 →       →       /* is more than half of this entry in 2nd half of the block? */
> > 1866 →       →       if (size + map[i].size/2 > blocksize/2)
> > 1867 →       →       →       break;
> > 
> > in the loop. This is surprising but it means the the entries must have
> > gaps between them that are small enough that we can't fit the entry
> > right in ? Should not we try to compact it before splitting, or is it
> > the case that this should have been done somewhere else ?
> 
> The other possibility is that map[i].size is not right and indeed there
> seems to be a bug in dx_make_map()
> 
> map_tail->size = le16_to_cpu(de->rec_len);
> 
> should be
> 
> map_tail->size = ext4_rec_len_from_disk(de->rec_len, blocksize));
> 
> right ? Otherwise with large enough records the size will be smaller
> than it really is.
> 
> A quick look at fs/ext4/namei.c reveals couple of places there rec_len
> is used without the conversion and we should check whether it needs
> fixing.
> 
> -Lukas

And indeed the following patch seems to have fixed the issue we were
seeing. Eric I think that this might be a proper fix. But we still need
to check the other uses of rec_len to make sure it's ok as well.

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 94ec882..5509fdc 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1068,7 +1068,7 @@ static int dx_make_map(struct ext4_dir_entry_2 *de, unsigned blocksize,
                        map_tail--;
                        map_tail->hash = h.hash;
                        map_tail->offs = ((char *) de - base)>>2;
-                       map_tail->size = le16_to_cpu(de->rec_len);
+                       map_tail->size = ext4_rec_len_from_disk(le16_to_cpu(de->rec_len), blocksize);
                        count++;
                        cond_resched();
                }


> 
> 
> 
> > 
> > If we really want ot be fair and we want to split it right in the middle
> > of the entries size-wise then we need to keep track of of sum of the
> > entries and decide based on that, not blocksize/2. But maybe the problem
> > could be solved by compacting the entries together because the condition
> > seems to rely on that.
> > 
> > -Lukas
> > 
> > > +
> > >  	hash2 = map[split].hash;
> > >  	continued = hash2 == map[split - 1].hash;
> > >  	dxtrace(printk(KERN_INFO "Split block %lu at %x, %i/%i\n",
> > > 
> > > 
> > 
> 

