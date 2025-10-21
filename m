Return-Path: <linux-ext4+bounces-11005-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8D9BF6040
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 13:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FC524FCDA5
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6665E32BF54;
	Tue, 21 Oct 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlzW8Sao"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD78321422
	for <linux-ext4@vger.kernel.org>; Tue, 21 Oct 2025 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045985; cv=none; b=Pk0g7sAqWPjsIN2DAlQf1G7t6JULPBxoYKyMh91YAeq+xeF63Ja2TII09n4guEXQYNCfiPCdUuVPU8QplAHRkCpnrH1Piwz0CB83tkB0xoEKHeS/rFMyL+aVHKKOnSOfpCEu0EjJU/9EHxBmXNEW1SD2Uc0e5HVpIQwRUMpiGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045985; c=relaxed/simple;
	bh=4o6GabJCs8lMZMdxN0bZMTFHmu3hyrO8WHGu9QddGZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWcigeBol2jyQgOxz22KprriGiSZBhFmuOAA5yZ7g77UNxNNH15SPP/Ed3+f2xcwsMucgyAwFAuP3oK/8m/ood9JyIYdMwBqsD3MHp6a9ePKMHJgKpX89nm/v8xRn18UECYKj1F9sClBrJBtitPUdHgZvXPFfUCQyD+LM5s9mLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlzW8Sao; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761045982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IAp9PJIXRx90mxRigYbDEFeaSrCTmH7Jl9dfYi3Qn60=;
	b=PlzW8SaorrYfgcFwVsPiT/SZxrXtnpEeKx1jokGrPg9+QwZYNylj7dA4VOTnBcwRaSUb8M
	HXTQn3NTmWRnO/mg3szaqkzef/NMtRwk0gu811EuGsSOh+AG6CY4ADpzZToeBil8v1mIf8
	CtJ4D6fMeKf0lA3xwl7XIk2QbLcxR50=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-9qAaqctCOsCM9bHGN8WSXg-1; Tue,
 21 Oct 2025 07:26:17 -0400
X-MC-Unique: 9qAaqctCOsCM9bHGN8WSXg-1
X-Mimecast-MFC-AGG-ID: 9qAaqctCOsCM9bHGN8WSXg_1761045976
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C04FA18002F7;
	Tue, 21 Oct 2025 11:26:15 +0000 (UTC)
Received: from bfoster (unknown [10.22.65.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2365A19560A2;
	Tue, 21 Oct 2025 11:26:14 +0000 (UTC)
Date: Tue, 21 Oct 2025 07:30:32 -0400
From: Brian Foster <bfoster@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: John Garry <john.g.garry@oracle.com>, Zorro Lang <zlang@redhat.com>,
	fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aPdu2DtLSNrI7gfp@bfoster>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
 <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOPCAzx0diQy7lFN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <66470caf-ec35-4f7d-adac-4a1c22a40a3e@oracle.com>
 <aPdgR5gdA3l3oTLQ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPdgR5gdA3l3oTLQ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Oct 21, 2025 at 03:58:23PM +0530, Ojaswin Mujoo wrote:
> On Mon, Oct 20, 2025 at 11:33:40AM +0100, John Garry wrote:
> > On 06/10/2025 14:20, Ojaswin Mujoo wrote:
> > > Hi Zorro, thanks for checking this. So correct me if im wrong but I
> > > understand that you have run this test on an atomic writes enabled
> > > kernel where the stack also supports atomic writes.
> > > 
> > > Looking at the bad data log:
> > > 
> > > 	+READ BAD DATA: offset = 0x1c000, size = 0x1803, fname = /mnt/xfstests/test/junk
> > > 	+OFFSET      GOOD    BAD     RANGE
> > > 	+0x1c000     0x0000  0xcdcd  0x0
> > > 	+operation# (mod 256) for the bad data may be 205
> > > 
> > > We see that 0x0000 was expected but we got 0xcdcd. Now the operation
> > > that caused this is indicated to be 205, but looking at that operation:
> > > 
> > > +205(205 mod 256): ZERO     0x6dbe6 thru 0x6e6aa	(0xac5 bytes)
> > > 
> > > This doesn't even overlap the range that is bad. (0x1c000 to 0x1c00f).
> > > Infact, it does seem like an unlikely coincidence that the actual data
> > > in the bad range is 0xcdcd which is something xfs_io -c "pwrite" writes
> > > to default (fsx writes random data in even offsets and operation num in
> > > odd).
> > > 
> > > I am able to replicate this but only on XFS but not on ext4 (atleast not
> > > in 20 runs).  I'm trying to better understand if this is a test issue or
> > > not. Will keep you update.
> > 
> > 
> > Hi Ojaswin,
> > 
> > Sorry for the very slow response.
> > 
> > Are you still checking this issue?
> > 
> > To replicate, should I just take latest xfs kernel and run this series on
> > top of latest xfstests? Is it 100% reproducible?
> > 
> > Thanks,
> > John
> 
> Hi John,
> 
> Yes Im looking into it but I'm now starting to run into some reflink/cow
> based concepts that are taking time to understand. Let me share what I
> have till now:
> 
> So the test.sh that I'm using can be found here [1] which just uses an
> fsx replay file (which replays all operations) present in the same repo
> [2]. If you see the replay file, there are a bunch of random operations
> followed by the last 2 commented out operations:
> 
> # copy_range 0xd000 0x1000 0x1d800 0x44000   <--- # operations <start> <len> <dest of copy> <filesize (can be ignored)>
> # mapread 0x1e000 0x1000 0x1e400 *
> 
> The copy_range here is the one which causes (or exposes) the corruption
> at 0x1e800 (the end of copy range destination gets corrupted).
> 
> To have more control, I commented these 2 operations and am doing it by
> hand in the test.sh file, with xfs_io. I'm also using a non atomic write
> device so we only have S/W fallback.
> 
> Now some observations:
> 
> 1. The copy_range operations is actually copying from a hole to a hole,
> so we should be reading all 0s. But What I see is the following happening:
> 
>   vfs_copy_file_range
>    do_splice_direct
>     do_splice_direct_actor
>      do_splice_read
>        # Adds the folio at src offset to the pipe. I confirmed this is all 0x0.
>      splice_direct_to_actor
>       direct_splice_actor
>        do_splice_from
>         iter_file_splice_write
>          xfs_file_write_iter
>           xfs_file_buffered_write
>            iomap_file_buferred_write
>             iomap_iter
>              xfs_buferred_write_iomap_begin
>                # Here we correctly see that there is noting at the
>                # destination in data fork, but somehow we find a mapped
>                # extent in cow fork which is returned to iomap.
>              iomap_write_iter
>               __iomap_write_begin
>                 # Here we notice folio is not uptodate and call
>                 # iomap_read_folio_range() to read from the cow_fork
>                 # mapping we found earlier. This results in folio having
>                 # incorrect data at 0x1e800 offset.
> 
>  So it seems like the fsx operations might be corrupting the cow fork state
>  somehow leading to stale data exposure. 
> 
> 2. If we disable atomic writes we dont hit the issue.
> 
> 3. If I do a -c pread of the destination range before doing the
> copy_range operation then I don't see the corruption any more.
> 
> I'm now trying to figure out why the mapping returned is not IOMAP_HOLE
> as it should be. I don't know the COW path in xfs so there are some gaps
> in my understanding. Let me know if you need any other information since
> I'm reliably able to replicate on 6.17.0-rc4.
> 

I haven't followed your issue closely, but just on this hole vs. COW
thing, XFS has a bit of a quirk where speculative COW fork preallocation
can expand out over holes in the data fork. If iomap lookup for buffered
write sees COW fork blocks present, it reports those blocks as the
primary mapping even if the data fork happens to be a hole (since
there's no point in allocating blocks to the data fork when we can just
remap).

Again I've no idea if this relates to your issue or what you're
referring to as a hole (i.e. data fork only?), but just pointing it out.
The latest iomap/xfs patches I posted a few days ago kind of dance
around this a bit, but I was somewhat hoping that maybe the cleanups
there would trigger some thoughts on better iomap reporting in that
regard.

Brian

> [1]
> https://github.com/OjaswinM/fsx-aw-issue/tree/master
> 
> [2] https://github.com/OjaswinM/fsx-aw-issue/blob/master/repro.fsxops
> 
> regards,
> ojaswin
> 


